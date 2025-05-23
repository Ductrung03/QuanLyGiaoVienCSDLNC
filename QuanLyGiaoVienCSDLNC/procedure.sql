-- =============================================
-- STORED PROCEDURES TỐI ƯU CHO HỆ THỐNG QUẢN LÝ GIÁO VIÊN
-- Version: 2.0
-- Updated: 2024
-- =============================================

USE QLGiaoVienFinal;
GO

-- =============================================
-- SECTION 1: QUẢN LÝ GIÁO VIÊN
-- =============================================

-- 1.1. Thêm mới giáo viên với đầy đủ validation
CREATE OR ALTER PROCEDURE sp_GiaoVien_ThemMoi
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaGV CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate inputs
        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
            THROW 50001, N'Họ tên không được để trống', 1;
            
        IF @NgaySinh > GETDATE() OR @NgaySinh < DATEADD(YEAR, -70, GETDATE())
            THROW 50002, N'Ngày sinh không hợp lệ', 1;
            
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50003, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email)
            THROW 50004, N'Email đã tồn tại trong hệ thống', 1;
            
        IF @SDT < 100000000 OR @SDT > 999999999
            THROW 50005, N'Số điện thoại phải có 9 chữ số', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50006, N'Mã bộ môn không tồn tại', 1;
        
        -- Generate MaGV
        DECLARE @NextId INT;
        UPDATE SequenceGenerator 
        SET @NextId = LastSequence = LastSequence + 1
        WHERE TableName = 'GiaoVien';
        
        SET @MaGV = 'GV' + RIGHT('0000' + CAST(@NextId AS VARCHAR(4)), 4);
        
        -- Insert
        INSERT INTO GiaoVien (MaGV, HoTen, NgaySinh, GioiTinh, QueQuan, DiaChi, SDT, Email, MaBM)
        VALUES (@MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM);
        
        SET @ErrorMessage = N'Thêm giáo viên thành công. Mã GV: ' + @MaGV;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaGV = NULL;
        THROW;
    END CATCH
END;
GO

-- 1.2. Cập nhật thông tin giáo viên
CREATE OR ALTER PROCEDURE sp_GiaoVien_CapNhat
    @MaGV CHAR(15),
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaNguoiCapNhat NVARCHAR(50) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50010, N'Mã giáo viên không tồn tại', 1;
            
        -- Validate
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50011, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email AND MaGV != @MaGV)
            THROW 50012, N'Email đã được sử dụng bởi giáo viên khác', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50013, N'Mã bộ môn không tồn tại', 1;
        
        -- Store old data for audit
        DECLARE @OldData NVARCHAR(MAX);
        SELECT @OldData = (
            SELECT MaGV, HoTen, NgaySinh, GioiTinh, Email, MaBM
            FROM GiaoVien WHERE MaGV = @MaGV
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        
        -- Update
        UPDATE GiaoVien
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            QueQuan = @QueQuan,
            DiaChi = @DiaChi,
            SDT = @SDT,
            Email = @Email,
            MaBM = @MaBM
        WHERE MaGV = @MaGV;
        
        -- Log change if user provided
        IF @MaNguoiCapNhat IS NOT NULL
        BEGIN
            DECLARE @MaLichSu NVARCHAR(50);
            SELECT TOP 1 @MaLichSu = MaLichSu 
            FROM LichSuDangNhap 
            WHERE MaNguoiDung = @MaNguoiCapNhat 
                AND ThoiDiemDangXuat IS NULL
            ORDER BY ThoiDiemDangNhap DESC;
            
            IF @MaLichSu IS NOT NULL
                EXEC sp_NhatKy_GhiLog @MaLichSu, N'Cập nhật thông tin giáo viên', @OldData, NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật thông tin giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 1.3. Xóa giáo viên (soft delete)
CREATE OR ALTER PROCEDURE sp_GiaoVien_Xoa
    @MaGV CHAR(15),
    @ForceDelete BIT = 0,
    @MaNguoiXoa NVARCHAR(50) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50020, N'Mã giáo viên không tồn tại', 1;
        
        -- Check dependencies
        DECLARE @Dependencies NVARCHAR(MAX) = '';
        
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'Giảng dạy, ';
            
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'NCKH, ';
            
        IF EXISTS (SELECT 1 FROM Khoa WHERE MaChuNhiemKhoa = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm khoa, ';
            
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaChuNhiemBM = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm bộ môn, ';
        
        IF LEN(@Dependencies) > 0 AND @ForceDelete = 0
        BEGIN
            SET @Dependencies = LEFT(@Dependencies, LEN(@Dependencies) - 2); -- Loại bỏ dấu phẩy và khoảng trắng cuối
            DECLARE @ErrorMsg NVARCHAR(500) = N'Không thể xóa vì giáo viên đang có liên kết: ' + @Dependencies;
            THROW 50021, @ErrorMsg, 1;
        END
        
        IF @ForceDelete = 1
        BEGIN
            -- Remove all dependencies
            UPDATE Khoa SET MaChuNhiemKhoa = NULL WHERE MaChuNhiemKhoa = @MaGV;
            UPDATE BoMon SET MaChuNhiemBM = NULL WHERE MaChuNhiemBM = @MaGV;
            DELETE FROM ChiTietGiangDay WHERE MaGV = @MaGV;
            DELETE FROM ChiTietNCKH WHERE MaGV = @MaGV;
            DELETE FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV;
            DELETE FROM ThamGia WHERE MaGV = @MaGV;
            DELETE FROM ThamGiaHuongDan WHERE MaGV = @MaGV;
            DELETE FROM NguoiDung WHERE MaGV = @MaGV;
        END
        
        DELETE FROM GiaoVien WHERE MaGV = @MaGV;
        
        SET @ErrorMessage = N'Xóa giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 1.4. Tìm kiếm giáo viên nâng cao
CREATE OR ALTER PROCEDURE sp_GiaoVien_TimKiem
    @SearchText NVARCHAR(100) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @HocVi NVARCHAR(100) = NULL,
    @HocHam NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Count total records
    SELECT @TotalRecords = COUNT(DISTINCT GV.MaGV)
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
    WHERE (@SearchText IS NULL OR 
           GV.HoTen LIKE N'%' + @SearchText + '%' OR 
           GV.Email LIKE '%' + @SearchText + '%' OR
           GV.MaGV LIKE '%' + @SearchText + '%')
      AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
      AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
      AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
      AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam);
    
    -- Return paginated results
    WITH CTE AS (
        SELECT DISTINCT
            GV.MaGV,
            GV.HoTen,
            GV.NgaySinh,
            CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
            GV.Email,
            GV.SDT,
            GV.DiaChi,
            BM.TenBM,
            K.TenKhoa,
            STRING_AGG(HV.TenHocVi, ', ') WITHIN GROUP (ORDER BY HV.NgayNhan DESC) AS DanhSachHocVi,
            (SELECT TOP 1 TenHocHam FROM LichSuHocHam WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
            ROW_NUMBER() OVER (ORDER BY GV.HoTen) AS RowNum
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
        LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
        LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
        WHERE (@SearchText IS NULL OR 
               GV.HoTen LIKE N'%' + @SearchText + '%' OR 
               GV.Email LIKE '%' + @SearchText + '%' OR
               GV.MaGV LIKE '%' + @SearchText + '%')
          AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
          AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
          AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
          AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam)
        GROUP BY GV.MaGV, GV.HoTen, GV.NgaySinh, GV.GioiTinh, GV.Email, 
                 GV.SDT, GV.DiaChi, BM.TenBM, K.TenKhoa
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 2: QUẢN LÝ KHOA VÀ BỘ MÔN
-- =============================================

-- 2.1. Thêm mới khoa
CREATE OR ALTER PROCEDURE sp_Khoa_ThemMoi
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @MaKhoa CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa)
            THROW 50030, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
            THROW 50031, N'Mã chủ nhiệm khoa không tồn tại', 1;
        
        -- Generate MaKhoa
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM Khoa;
        SET @MaKhoa = 'KHOA' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, MaChuNhiemKhoa)
        VALUES (@MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemKhoa IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm khoa thành công. Mã khoa: ' + @MaKhoa;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaKhoa = NULL;
        THROW;
    END CATCH
END;
GO

-- 2.2. Cập nhật khoa
CREATE OR ALTER PROCEDURE sp_Khoa_CapNhat
    @MaKhoa CHAR(15),
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50040, N'Mã khoa không tồn tại', 1;
            
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa AND MaKhoa != @MaKhoa)
            THROW 50041, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL 
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
                THROW 50042, N'Mã chủ nhiệm khoa không tồn tại', 1;
                
            -- Check if teacher belongs to this faculty
            IF NOT EXISTS (
                SELECT 1 FROM GiaoVien GV
                INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
                WHERE GV.MaGV = @MaChuNhiemKhoa AND BM.MaKhoa = @MaKhoa
            )
                THROW 50043, N'Giáo viên không thuộc khoa này', 1;
        END
        
        -- Get old dean
        DECLARE @OldChuNhiem CHAR(15);
        SELECT @OldChuNhiem = MaChuNhiemKhoa FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        -- Update
        UPDATE Khoa
        SET TenKhoa = @TenKhoa,
            DiaChi = @DiaChi,
            MaChuNhiemKhoa = @MaChuNhiemKhoa
        WHERE MaKhoa = @MaKhoa;
        
        -- Update ChucVu
        IF @OldChuNhiem != @MaChuNhiemKhoa
        BEGIN
            IF @OldChuNhiem IS NOT NULL
                EXEC sp_ChucVu_KetThuc @OldChuNhiem, 'CV003', NULL;
                
            IF @MaChuNhiemKhoa IS NOT NULL
                EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 2.3. Xóa khoa
CREATE OR ALTER PROCEDURE sp_Khoa_Xoa
    @MaKhoa CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50050, N'Mã khoa không tồn tại', 1;
            
        -- Check dependencies
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaKhoa = @MaKhoa)
            THROW 50051, N'Không thể xóa khoa vì còn bộ môn trực thuộc', 1;
        
        DELETE FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        SET @ErrorMessage = N'Xóa khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 2.4. Thêm mới bộ môn
CREATE OR ALTER PROCEDURE sp_BoMon_ThemMoi
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @MaBM CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50060, N'Mã khoa không tồn tại', 1;
            
        IF EXISTS (SELECT 1 FROM BoMon WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa)
            THROW 50061, N'Tên bộ môn đã tồn tại trong khoa', 1;
            
        IF @MaChuNhiemBM IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemBM)
            THROW 50062, N'Mã chủ nhiệm bộ môn không tồn tại', 1;
        
        -- Generate MaBM
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM BoMon;
        SET @MaBM = 'BM' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO BoMon (MaBM, TenBM, DiaChi, MaKhoa, MaChuNhiemBM)
        VALUES (@MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemBM IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemBM, 'CV005', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm bộ môn thành công. Mã bộ môn: ' + @MaBM;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaBM = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 3: QUẢN LÝ GIẢNG DẠY
-- =============================================

-- 3.1. Thêm mới tài giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_ThemTai
    @TenHocPhan NVARCHAR(100),
    @SiSo INT,
    @He NVARCHAR(20),
    @Lop NVARCHAR(20),
    @SoTinChi INT,
    @GhiChu NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @MaDoiTuong CHAR(15),
    @MaThoiGian CHAR(15),
    @MaNgonNgu CHAR(15),
    @MaTaiGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SiSo <= 0 OR @SiSo > 500
            THROW 50070, N'Sĩ số không hợp lệ (1-500)', 1;
            
        IF @SoTinChi <= 0 OR @SoTinChi > 10
            THROW 50071, N'Số tín chỉ không hợp lệ (1-10)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay WHERE MaDoiTuong = @MaDoiTuong)
            THROW 50072, N'Mã đối tượng giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay WHERE MaThoiGian = @MaThoiGian)
            THROW 50073, N'Mã thời gian giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay WHERE MaNgonNgu = @MaNgonNgu)
            THROW 50074, N'Mã ngôn ngữ giảng dạy không tồn tại', 1;
        
        -- Generate MaTaiGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiGiangDay;
        SET @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiGiangDay (MaTaiGiangDay, TenHocPhan, SiSo, He, Lop, SoTinChi, 
                                GhiChu, NamHoc, MaDoiTuong, MaThoiGian, MaNgonNgu)
        VALUES (@MaTaiGiangDay, @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, 
                @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu);
        
        SET @ErrorMessage = N'Thêm tài giảng dạy thành công. Mã: ' + @MaTaiGiangDay;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiGiangDay = NULL;
        THROW;
    END CATCH
END;
GO

-- 3.2. Phân công giảng dạy với kiểm tra lịch trùng
CREATE OR ALTER PROCEDURE sp_GiangDay_PhanCong
    @MaGV CHAR(15),
    @MaTaiGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @MaNoiDungGiangDay CHAR(15),
    @CheckConflict BIT = 1,
    @MaChiTietGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50080, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50081, N'Mã tài giảng dạy không tồn tại', 1;
            
        IF @SoTiet <= 0 OR @SoTiet > 200
            THROW 50082, N'Số tiết không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV AND MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50083, N'Giáo viên đã được phân công cho học phần này', 1;
        
        -- Check schedule conflict
        IF @CheckConflict = 1
        BEGIN
            DECLARE @MaThoiGian CHAR(15), @NamHoc NVARCHAR(20);
            SELECT @MaThoiGian = MaThoiGian, @NamHoc = NamHoc 
            FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay;
            
            IF EXISTS (
                SELECT 1 FROM ChiTietGiangDay CTGD
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = @MaGV 
                    AND TGD.MaThoiGian = @MaThoiGian 
                    AND TGD.NamHoc = @NamHoc
                    AND TGD.MaTaiGiangDay != @MaTaiGiangDay
            )
                THROW 50084, N'Giáo viên có lịch trùng trong thời gian này', 1;
        END
        
        -- Calculate SoTietQuyDoi
        DECLARE @HeSoDoiTuong FLOAT = 1, @HeSoThoiGian FLOAT = 1, @HeSoNgonNgu FLOAT = 1;
        
        SELECT 
            @HeSoDoiTuong = DT.HeSoQuyChuan,
            @HeSoThoiGian = TG.HeSoQuyChuan,
            @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;
        
        DECLARE @SoTietQuyDoi FLOAT = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;
        
        -- Generate MaChiTietGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietGiangDay;
        SET @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, 
                                    MaGV, MaTaiGiangDay, MaNoiDungGiangDay)
        VALUES (@MaChiTietGiangDay, @SoTiet, @SoTietQuyDoi, @GhiChu, 
                @MaGV, @MaTaiGiangDay, @MaNoiDungGiangDay);
        
        SET @ErrorMessage = N'Phân công giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietGiangDay = NULL;
        THROW;
    END CATCH
END;
GO

-- 3.3. Kiểm tra lịch trùng giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_KiemTraLichTrung
    @MaGV CHAR(15),
    @MaThoiGian CHAR(15),
    @NamHoc NVARCHAR(20),
    @HasConflict BIT OUTPUT,
    @ConflictDetails NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @HasConflict = 0;
    SET @ConflictDetails = '';
    
    IF EXISTS (
        SELECT 1 FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc
    )
    BEGIN
        SET @HasConflict = 1;
        
        SELECT @ConflictDetails = STRING_AGG(
            TGD.TenHocPhan + ' - ' + TGD.Lop + ' (' + CAST(CTGD.SoTiet AS NVARCHAR(10)) + ' tiết)', 
            '; '
        )
        FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc;
    END
END;
GO

-- =============================================
-- SECTION 4: QUẢN LÝ NGHIÊN CỨU KHOA HỌC
-- =============================================

-- 4.1. Thêm mới tài NCKH
CREATE OR ALTER PROCEDURE sp_NCKH_ThemTai
    @TenCongTrinhKhoaHoc NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @SoTacGia INT,
    @MaLoaiNCKH CHAR(15),
    @MaTaiNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoTacGia <= 0 OR @SoTacGia > 20
            THROW 50090, N'Số tác giả không hợp lệ (1-20)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiNCKH WHERE MaLoaiNCKH = @MaLoaiNCKH)
            THROW 50091, N'Mã loại NCKH không tồn tại', 1;
        
        -- Generate MaTaiNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiNCKH;
        SET @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiNCKH (MaTaiNCKH, TenCongTrinhKhoaHoc, NamHoc, SoTacGia, MaLoaiNCKH)
        VALUES (@MaTaiNCKH, @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH);
        
        SET @ErrorMessage = N'Thêm tài NCKH thành công. Mã: ' + @MaTaiNCKH;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiNCKH = NULL;
        THROW;
    END CATCH
END;
GO

-- 4.2. Phân công NCKH với validation số tác giả
CREATE OR ALTER PROCEDURE sp_NCKH_PhanCong
    @MaGV CHAR(15),
    @MaTaiNCKH CHAR(15),
    @VaiTro NVARCHAR(100),
    @SoGio FLOAT,
    @MaChiTietNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50100, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH)
            THROW 50101, N'Mã tài NCKH không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 500
            THROW 50102, N'Số giờ không hợp lệ (1-500)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV AND MaTaiNCKH = @MaTaiNCKH)
            THROW 50103, N'Giáo viên đã được phân công cho công trình này', 1;
        
        -- Check number of authors
        DECLARE @SoTacGia INT, @SoTacGiaHienTai INT;
        SELECT @SoTacGia = SoTacGia FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        SELECT @SoTacGiaHienTai = COUNT(*) FROM ChiTietNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        
        IF @SoTacGiaHienTai >= @SoTacGia
            THROW 50104, N'Đã đủ số tác giả cho công trình này', 1;
        
        -- Check role
        IF @VaiTro = N'Chủ nhiệm' AND EXISTS (
            SELECT 1 FROM ChiTietNCKH 
            WHERE MaTaiNCKH = @MaTaiNCKH AND VaiTro = N'Chủ nhiệm'
        )
            THROW 50105, N'Đã có chủ nhiệm cho công trình này', 1;
        
        -- Generate MaChiTietNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietNCKH;
        SET @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietNCKH (MaChiTietNCKH, VaiTro, MaGV, MaTaiNCKH, SoGio)
        VALUES (@MaChiTietNCKH, @VaiTro, @MaGV, @MaTaiNCKH, @SoGio);
        
        SET @ErrorMessage = N'Phân công NCKH thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietNCKH = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 5: QUẢN LÝ KHẢO THÍ
-- =============================================

-- 5.1. Thêm mới tài khảo thí
CREATE OR ALTER PROCEDURE sp_KhaoThi_ThemTai
    @HocPhan NVARCHAR(100),
    @Lop NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @GhiChu NVARCHAR(200),
    @MaLoaiCongTacKhaoThi CHAR(15),
    @MaTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LoaiCongTacKhaoThi WHERE MaLoaiCongTacKhaoThi = @MaLoaiCongTacKhaoThi)
            THROW 50110, N'Mã loại công tác khảo thí không tồn tại', 1;
        
        -- Generate MaTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiKhaoThi;
        SET @MaTaiKhaoThi = 'KT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiKhaoThi (MaTaiKhaoThi, HocPhan, Lop, NamHoc, GhiChu, MaLoaiCongTacKhaoThi)
        VALUES (@MaTaiKhaoThi, @HocPhan, @Lop, @NamHoc, @GhiChu, @MaLoaiCongTacKhaoThi);
        
        SET @ErrorMessage = N'Thêm tài khảo thí thành công. Mã: ' + @MaTaiKhaoThi;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO

-- 5.2. Phân công khảo thí
CREATE OR ALTER PROCEDURE sp_KhaoThi_PhanCong
    @MaGV CHAR(15),
    @MaTaiKhaoThi CHAR(15),
    @SoBai INT,
    @MaChiTietTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50120, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50121, N'Mã tài khảo thí không tồn tại', 1;
            
        IF @SoBai <= 0 OR @SoBai > 1000
            THROW 50122, N'Số bài không hợp lệ (1-1000)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV AND MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50123, N'Giáo viên đã được phân công cho công tác khảo thí này', 1;
        
        -- Calculate SoGioQuyChuan based on type
        DECLARE @MaLoaiCongTacKhaoThi CHAR(15), @SoGioQuyChuan FLOAT;
        SELECT @MaLoaiCongTacKhaoThi = MaLoaiCongTacKhaoThi FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi;
        
        SET @SoGioQuyChuan = CASE 
            WHEN @MaLoaiCongTacKhaoThi = 'LKT01' THEN @SoBai * 0.5  -- Ra đề
            WHEN @MaLoaiCongTacKhaoThi = 'LKT02' THEN @SoBai * 0.3  -- Coi thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT03' THEN @SoBai * 0.4  -- Chấm thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT04' THEN @SoBai * 0.2  -- Phản biện
            WHEN @MaLoaiCongTacKhaoThi = 'LKT05' THEN @SoBai * 0.3  -- Phúc khảo
            ELSE @SoBai * 0.3
        END;
        
        -- Generate MaChiTietTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietTaiKhaoThi;
        SET @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietTaiKhaoThi (MaChiTietTaiKhaoThi, SoBai, SoGioQuyChuan, MaGV, MaTaiKhaoThi)
        VALUES (@MaChiTietTaiKhaoThi, @SoBai, @SoGioQuyChuan, @MaGV, @MaTaiKhaoThi);
        
        SET @ErrorMessage = N'Phân công khảo thí thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 6: QUẢN LÝ HỘI ĐỒNG
-- =============================================

-- 6.1. Thêm mới hội đồng
CREATE OR ALTER PROCEDURE sp_HoiDong_ThemMoi
    @SoLuong INT,
    @NamHoc NVARCHAR(20),
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @GhiChu NVARCHAR(200),
    @MaLoaiHoiDong CHAR(15),
    @MaHoiDong CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoLuong <= 0 OR @SoLuong > 20
            THROW 50130, N'Số lượng thành viên không hợp lệ (1-20)', 1;
            
        IF @ThoiGianBatDau >= @ThoiGianKetThuc
            THROW 50131, N'Thời gian kết thúc phải sau thời gian bắt đầu', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHoiDong WHERE MaLoaiHoiDong = @MaLoaiHoiDong)
            THROW 50132, N'Mã loại hội đồng không tồn tại', 1;
        
        -- Generate MaHoiDong
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHoiDong;
        SET @MaHoiDong = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHoiDong (MaHoiDong, SoLuong, NamHoc, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, MaLoaiHoiDong)
        VALUES (@MaHoiDong, @SoLuong, @NamHoc, @ThoiGianBatDau, @ThoiGianKetThuc, @GhiChu, @MaLoaiHoiDong);
        
        SET @ErrorMessage = N'Thêm hội đồng thành công. Mã: ' + @MaHoiDong;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHoiDong = NULL;
        THROW;
    END CATCH
END;
GO

-- 6.2. Thêm thành viên hội đồng
CREATE OR ALTER PROCEDURE sp_HoiDong_ThemThanhVien
    @MaGV CHAR(15),
    @MaHoiDong CHAR(15),
    @SoGio FLOAT,
    @MaThamGia CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50140, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong)
            THROW 50141, N'Mã hội đồng không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 100
            THROW 50142, N'Số giờ không hợp lệ (1-100)', 1;
        
        -- Check if already member
        IF EXISTS (SELECT 1 FROM ThamGia WHERE MaGV = @MaGV AND MaHoiDong = @MaHoiDong)
            THROW 50143, N'Giáo viên đã là thành viên của hội đồng này', 1;
        
        -- Check max members
        DECLARE @SoLuong INT, @SoThanhVienHienTai INT;
        SELECT @SoLuong = SoLuong FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong;
        SELECT @SoThanhVienHienTai = COUNT(*) FROM ThamGia WHERE MaHoiDong = @MaHoiDong;
        
        IF @SoThanhVienHienTai >= @SoLuong
            THROW 50144, N'Hội đồng đã đủ số lượng thành viên', 1;
        
        -- Generate MaThamGia
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGia;
        SET @MaThamGia = 'TG' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGia (MaThamGia, MaGV, MaHoiDong, SoGio)
        VALUES (@MaThamGia, @MaGV, @MaHoiDong, @SoGio);
        
        SET @ErrorMessage = N'Thêm thành viên hội đồng thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGia = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 7: QUẢN LÝ HƯỚNG DẪN
-- =============================================

-- 7.1. Thêm mới tài hướng dẫn
CREATE OR ALTER PROCEDURE sp_HuongDan_ThemTai
    @HoTenHocVien NVARCHAR(100),
    @Lop NVARCHAR(50),
    @He NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @TenDeTai NVARCHAR(200),
    @SoCBHD INT,
    @MaLoaiHinhHuongDan CHAR(15),
    @MaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoCBHD <= 0 OR @SoCBHD > 5
            THROW 50150, N'Số cán bộ hướng dẫn không hợp lệ (1-5)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHinhHuongDan WHERE MaLoaiHinhHuongDan = @MaLoaiHinhHuongDan)
            THROW 50151, N'Mã loại hình hướng dẫn không tồn tại', 1;
        
        -- Generate MaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHuongDan;
        SET @MaHuongDan = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHuongDan (MaHuongDan, HoTenHocVien, Lop, He, NamHoc, TenDeTai, SoCBHD, MaLoaiHinhHuongDan)
        VALUES (@MaHuongDan, @HoTenHocVien, @Lop, @He, @NamHoc, @TenDeTai, @SoCBHD, @MaLoaiHinhHuongDan);
        
        SET @ErrorMessage = N'Thêm tài hướng dẫn thành công. Mã: ' + @MaHuongDan;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO

-- 7.2. Phân công hướng dẫn
CREATE OR ALTER PROCEDURE sp_HuongDan_PhanCong
    @MaGV CHAR(15),
    @MaHuongDan CHAR(15),
    @SoGio FLOAT,
    @MaThamGiaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50160, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan)
            THROW 50161, N'Mã tài hướng dẫn không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 200
            THROW 50162, N'Số giờ không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ThamGiaHuongDan WHERE MaGV = @MaGV AND MaHuongDan = @MaHuongDan)
            THROW 50163, N'Giáo viên đã được phân công hướng dẫn này', 1;
        
        -- Check max advisors
        DECLARE @SoCBHD INT, @SoCBHDHienTai INT;
        SELECT @SoCBHD = SoCBHD FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan;
        SELECT @SoCBHDHienTai = COUNT(*) FROM ThamGiaHuongDan WHERE MaHuongDan = @MaHuongDan;
        
        IF @SoCBHDHienTai >= @SoCBHD
            THROW 50164, N'Đã đủ số cán bộ hướng dẫn', 1;
        
        -- Generate MaThamGiaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGiaHuongDan;
        SET @MaThamGiaHuongDan = 'TGHD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGiaHuongDan (MaThamGiaHuongDan, MaGV, MaHuongDan, SoGio)
        VALUES (@MaThamGiaHuongDan, @MaGV, @MaHuongDan, @SoGio);
        
        SET @ErrorMessage = N'Phân công hướng dẫn thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGiaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 8: QUẢN LÝ HỌC HÀM HỌC VỊ
-- =============================================

-- 8.1. Cập nhật học vị
CREATE OR ALTER PROCEDURE sp_HocVi_CapNhat
    @MaGV CHAR(15),
    @TenHocVi NVARCHAR(100),
    @NgayNhan DATE,
    @MaHocVi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50170, N'Mã giáo viên không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50171, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if same degree already exists
        IF EXISTS (SELECT 1 FROM HocVi WHERE MaGV = @MaGV AND TenHocVi = @TenHocVi)
            THROW 50172, N'Giáo viên đã có học vị này', 1;
        
        -- Generate MaHocVi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM HocVi;
        SET @MaHocVi = 'HV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO HocVi (MaHocVi, TenHocVi, NgayNhan, MaGV)
        VALUES (@MaHocVi, @TenHocVi, @NgayNhan, @MaGV);
        
        SET @ErrorMessage = N'Cập nhật học vị thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHocVi = NULL;
        THROW;
    END CATCH
END;
GO

-- 8.2. Cập nhật học hàm
CREATE OR ALTER PROCEDURE sp_HocHam_CapNhat
    @MaGV CHAR(15),
    @MaHocHam CHAR(15),
    @NgayNhan DATE,
    @MaLSHocHam CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50180, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM HocHam WHERE MaHocHam = @MaHocHam)
            THROW 50181, N'Mã học hàm không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50182, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if already has this title
        IF EXISTS (
            SELECT 1 FROM LichSuHocHam 
            WHERE MaGV = @MaGV AND MaHocHam = @MaHocHam
        )
            THROW 50183, N'Giáo viên đã có học hàm này', 1;
        
        -- Get TenHocHam
        DECLARE @TenHocHam NVARCHAR(100);
        SELECT @TenHocHam = TenHocHam FROM HocHam WHERE MaHocHam = @MaHocHam;
        
        -- Generate MaLSHocHam
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuHocHam;
        SET @MaLSHocHam = 'LSHH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuHocHam (MaLSHocHam, TenHocHam, NgayNhan, MaGV, MaHocHam)
        VALUES (@MaLSHocHam, @TenHocHam, @NgayNhan, @MaGV, @MaHocHam);
        
        SET @ErrorMessage = N'Cập nhật học hàm thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaLSHocHam = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 9: QUẢN LÝ CHỨC VỤ
-- =============================================

-- 9.1. Phân công chức vụ
CREATE OR ALTER PROCEDURE sp_ChucVu_PhanCong
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayNhan DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50190, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaChucVu = @MaChucVu)
            THROW 50191, N'Mã chức vụ không tồn tại', 1;
            
        IF @NgayNhan IS NULL
            SET @NgayNhan = GETDATE();
        
        -- Check if already has this position
        IF EXISTS (
            SELECT 1 FROM LichSuChucVu 
            WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL
        )
            THROW 50192, N'Giáo viên đang giữ chức vụ này', 1;
        
        -- Generate MaLichSuChucVu
        DECLARE @MaLichSuChucVu CHAR(15);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuChucVu;
        SET @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
        VALUES (@MaLichSuChucVu, @NgayNhan, NULL, @MaGV, @MaChucVu);
        
        SET @ErrorMessage = N'Phân công chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 9.2. Kết thúc chức vụ
CREATE OR ALTER PROCEDURE sp_ChucVu_KetThuc
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayKetThuc DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @NgayKetThuc IS NULL
            SET @NgayKetThuc = GETDATE();
        
        -- Update
        UPDATE LichSuChucVu
        SET NgayKetThuc = @NgayKetThuc
        WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50200, N'Không tìm thấy chức vụ đang hoạt động', 1;
        
        SET @ErrorMessage = N'Kết thúc chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 10: QUẢN LÝ NGƯỜI DÙNG VÀ PHÂN QUYỀN
-- =============================================

-- 10.1. Tạo tài khoản người dùng
CREATE OR ALTER PROCEDURE sp_NguoiDung_TaoTaiKhoan
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaGV CHAR(15) = NULL,
    @MaNhom NVARCHAR(50) = NULL,
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM NguoiDung WHERE TenDangNhap = @TenDangNhap)
            THROW 50210, N'Tên đăng nhập đã tồn tại', 1;
            
        IF @MaGV IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
                THROW 50211, N'Mã giáo viên không tồn tại', 1;
                
            IF EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV)
                THROW 50212, N'Giáo viên đã có tài khoản', 1;
        END
        
        -- Hash password (in production, use proper hashing)
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Generate MaNguoiDung
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NguoiDung;
        SET @MaNguoiDung = 'ND' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert user
        INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
        VALUES (@MaNguoiDung, @TenDangNhap, @HashedPassword, @MaGV);
        
        -- Add to group if specified
        IF @MaNhom IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WHERE MaNhom = @MaNhom)
                THROW 50213, N'Mã nhóm không tồn tại', 1;
                
            INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
            VALUES (@MaNguoiDung, @MaNhom);
        END
        
        SET @ErrorMessage = N'Tạo tài khoản thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        THROW;
    END CATCH
END;
GO

-- 10.2. Đổi mật khẩu
CREATE OR ALTER PROCEDURE sp_NguoiDung_DoiMatKhau
    @MaNguoiDung NVARCHAR(50),
    @MatKhauCu NVARCHAR(100),
    @MatKhauMoi NVARCHAR(100),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate old password
        DECLARE @HashedOldPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauCu);
        
        IF NOT EXISTS (
            SELECT 1 FROM NguoiDung 
            WHERE MaNguoiDung = @MaNguoiDung AND MatKhau = @HashedOldPassword
        )
            THROW 50220, N'Mật khẩu cũ không chính xác', 1;
        
        -- Validate new password
        IF LEN(@MatKhauMoi) < 6
            THROW 50221, N'Mật khẩu mới phải có ít nhất 6 ký tự', 1;
        
        -- Update password
        DECLARE @HashedNewPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauMoi);
        
        UPDATE NguoiDung
        SET MatKhau = @HashedNewPassword
        WHERE MaNguoiDung = @MaNguoiDung;
        
        SET @ErrorMessage = N'Đổi mật khẩu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 10.3. Đăng nhập
CREATE OR ALTER PROCEDURE sp_NguoiDung_DangNhap
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @MaLichSu NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Hash password
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Check credentials
        SELECT @MaNguoiDung = MaNguoiDung
        FROM NguoiDung
        WHERE TenDangNhap = @TenDangNhap AND MatKhau = @HashedPassword;
        
        IF @MaNguoiDung IS NULL
            THROW 50230, N'Tên đăng nhập hoặc mật khẩu không chính xác', 1;
        
        -- Generate MaLichSu
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuDangNhap;
        SET @MaLichSu = 'LS' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Log login
        INSERT INTO LichSuDangNhap (MaLichSu, ThoiDiemDangNhap, ThoiDiemDangXuat, MaNguoiDung)
        VALUES (@MaLichSu, GETDATE(), NULL, @MaNguoiDung);
        
        SET @ErrorMessage = N'Đăng nhập thành công';
        
        COMMIT TRANSACTION;
        
        -- Return user info
        SELECT 
            ND.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            GV.Email,
            STRING_AGG(NND.TenNhom, ', ') AS DanhSachNhom
        FROM NguoiDung ND
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        LEFT JOIN NguoiDung_Nhom NDN ON ND.MaNguoiDung = NDN.MaNguoiDung
        LEFT JOIN NhomNguoiDung NND ON NDN.MaNhom = NND.MaNhom
        WHERE ND.MaNguoiDung = @MaNguoiDung
        GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen, GV.Email;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        SET @MaLichSu = NULL;
        THROW;
    END CATCH
END;
GO

-- 10.4. Đăng xuất
CREATE OR ALTER PROCEDURE sp_NguoiDung_DangXuat
    @MaLichSu NVARCHAR(50),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE LichSuDangNhap
        SET ThoiDiemDangXuat = GETDATE()
        WHERE MaLichSu = @MaLichSu AND ThoiDiemDangXuat IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50240, N'Phiên đăng nhập không tồn tại hoặc đã kết thúc', 1;
        
        SET @ErrorMessage = N'Đăng xuất thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 10.5. Kiểm tra quyền
CREATE OR ALTER PROCEDURE sp_NguoiDung_KiemTraQuyen
    @MaNguoiDung NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @CoQuyen BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @CoQuyen = 0;
    
    IF EXISTS (
        SELECT 1
        FROM NguoiDung_Nhom NDN
        INNER JOIN Nhom_Quyen NQ ON NDN.MaNhom = NQ.MaNhom
        WHERE NDN.MaNguoiDung = @MaNguoiDung AND NQ.MaQuyen = @MaQuyen
    )
        SET @CoQuyen = 1;
END;
GO

-- =============================================
-- SECTION 11: NHẬT KÝ VÀ AUDIT
-- =============================================

-- 11.1. Ghi nhật ký thay đổi
CREATE OR ALTER PROCEDURE sp_NhatKy_GhiLog
    @MaLichSu NVARCHAR(50),
    @NoiDungThayDoi NVARCHAR(255),
    @ThongTinCu NVARCHAR(255),
    @ThongTinMoi NVARCHAR(255),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LichSuDangNhap WHERE MaLichSu = @MaLichSu)
            THROW 50250, N'Mã lịch sử không tồn tại', 1;
        
        -- Generate MaNhatKy
        DECLARE @MaNhatKy NVARCHAR(50);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NhatKyThayDoi;
        SET @MaNhatKy = 'NK' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO NhatKyThayDoi (MaNhatKy, MaLichSu, ThoiGianThayDoi, NoiDungThayDoi, ThongTinCu, ThongTinMoi)
        VALUES (@MaNhatKy, @MaLichSu, GETDATE(), @NoiDungThayDoi, @ThongTinCu, @ThongTinMoi);
        
        SET @ErrorMessage = N'Ghi nhật ký thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 11.2. Xem lịch sử hoạt động
CREATE OR ALTER PROCEDURE sp_NhatKy_XemLichSu
    @MaNguoiDung NVARCHAR(50) = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @TuNgay IS NULL
        SET @TuNgay = DATEADD(DAY, -30, GETDATE());
        
    IF @DenNgay IS NULL
        SET @DenNgay = GETDATE();
    
    WITH CTE AS (
        SELECT 
            NK.MaNhatKy,
            NK.ThoiGianThayDoi,
            NK.NoiDungThayDoi,
            NK.ThongTinCu,
            NK.ThongTinMoi,
            LS.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            ROW_NUMBER() OVER (ORDER BY NK.ThoiGianThayDoi DESC) AS RowNum
        FROM NhatKyThayDoi NK
        INNER JOIN LichSuDangNhap LS ON NK.MaLichSu = LS.MaLichSu
        INNER JOIN NguoiDung ND ON LS.MaNguoiDung = ND.MaNguoiDung
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        WHERE (@MaNguoiDung IS NULL OR LS.MaNguoiDung = @MaNguoiDung)
            AND CAST(NK.ThoiGianThayDoi AS DATE) BETWEEN @TuNgay AND @DenNgay
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 12: BÁO CÁO VÀ THỐNG KÊ
-- =============================================

 -- 12.1. Báo cáo tổng hợp khối lượng công tác
CREATE OR ALTER PROCEDURE sp_BaoCao_TongHopKhoiLuongCongTac
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH GiangDayStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTGD.SoTietQuyDoi), 0) AS TongGioGiangDay
        FROM GiaoVien GV
        LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE @NamHoc IS NULL OR TGD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH
        FROM GiaoVien GV
        LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE @NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTKT.SoGioQuyChuan), 0) AS TongGioKhaoThi
        FROM GiaoVien GV
        LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE @NamHoc IS NULL OR TKT.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TG.SoGio), 0) AS TongGioHoiDong
        FROM GiaoVien GV
        LEFT JOIN ThamGia TG ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TGHD.SoGio), 0) AS TongGioHuongDan
        FROM GiaoVien GV
        LEFT JOIN ThamGiaHuongDan TGHD ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    DinhMucStats AS (
        SELECT 
            GV.MaGV,
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
    )
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        GD.TongGioGiangDay,
        NC.TongGioNCKH,
        KT.TongGioKhaoThi,
        HD.TongGioHoiDong,
        HDan.TongGioHuongDan,
        GD.TongGioGiangDay + NC.TongGioNCKH + KT.TongGioKhaoThi + 
        HD.TongGioHoiDong + HDan.TongGioHuongDan AS TongGioQuyChuan,
        DM.DinhMucGiangDay,
        DM.DinhMucNCKH,
        CAST(GD.TongGioGiangDay * 100.0 / NULLIF(DM.DinhMucGiangDay, 0) AS DECIMAL(10,2)) AS PhanTramGiangDay,
        CAST(NC.TongGioNCKH * 100.0 / NULLIF(DM.DinhMucNCKH, 0) AS DECIMAL(10,2)) AS PhanTramNCKH,
        CASE 
            WHEN GD.TongGioGiangDay >= DM.DinhMucGiangDay AND NC.TongGioNCKH >= DM.DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThai
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiangDayStats GD ON GV.MaGV = GD.MaGV
    LEFT JOIN NCKHStats NC ON GV.MaGV = NC.MaGV
    LEFT JOIN KhaoThiStats KT ON GV.MaGV = KT.MaGV
    LEFT JOIN HoiDongStats HD ON GV.MaGV = HD.MaGV
    LEFT JOIN HuongDanStats HDan ON GV.MaGV = HDan.MaGV
    LEFT JOIN DinhMucStats DM ON GV.MaGV = DM.MaGV
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen;
END;
GO
-- =============================================
-- STORED PROCEDURES TỐI ƯU CHO HỆ THỐNG QUẢN LÝ GIÁO VIÊN
-- Version: 2.0
-- Updated: 2024
-- =============================================

USE QLGiaoVienFinal;
GO

-- =============================================
-- SECTION 1: QUẢN LÝ GIÁO VIÊN
-- =============================================

-- 1.1. Thêm mới giáo viên với đầy đủ validation
CREATE OR ALTER PROCEDURE sp_GiaoVien_ThemMoi
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaGV CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate inputs
        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
            THROW 50001, N'Họ tên không được để trống', 1;
            
        IF @NgaySinh > GETDATE() OR @NgaySinh < DATEADD(YEAR, -70, GETDATE())
            THROW 50002, N'Ngày sinh không hợp lệ', 1;
            
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50003, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email)
            THROW 50004, N'Email đã tồn tại trong hệ thống', 1;
            
        IF @SDT < 100000000 OR @SDT > 999999999
            THROW 50005, N'Số điện thoại phải có 9 chữ số', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50006, N'Mã bộ môn không tồn tại', 1;
        
        -- Generate MaGV
        DECLARE @NextId INT;
        UPDATE SequenceGenerator 
        SET @NextId = LastSequence = LastSequence + 1
        WHERE TableName = 'GiaoVien';
        
        SET @MaGV = 'GV' + RIGHT('0000' + CAST(@NextId AS VARCHAR(4)), 4);
        
        -- Insert
        INSERT INTO GiaoVien (MaGV, HoTen, NgaySinh, GioiTinh, QueQuan, DiaChi, SDT, Email, MaBM)
        VALUES (@MaGV, @HoTen, @NgaySinh, @GioiTinh, @QueQuan, @DiaChi, @SDT, @Email, @MaBM);
        
        SET @ErrorMessage = N'Thêm giáo viên thành công. Mã GV: ' + @MaGV;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaGV = NULL;
        THROW;
    END CATCH
END;
GO

-- 1.2. Cập nhật thông tin giáo viên
CREATE OR ALTER PROCEDURE sp_GiaoVien_CapNhat
    @MaGV CHAR(15),
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh BIT,
    @QueQuan NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @SDT INT,
    @Email NVARCHAR(100),
    @MaBM CHAR(15),
    @MaNguoiCapNhat NVARCHAR(50) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50010, N'Mã giáo viên không tồn tại', 1;
            
        -- Validate
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50011, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WHERE Email = @Email AND MaGV != @MaGV)
            THROW 50012, N'Email đã được sử dụng bởi giáo viên khác', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WHERE MaBM = @MaBM)
            THROW 50013, N'Mã bộ môn không tồn tại', 1;
        
        -- Store old data for audit
        DECLARE @OldData NVARCHAR(MAX);
        SELECT @OldData = (
            SELECT MaGV, HoTen, NgaySinh, GioiTinh, Email, MaBM
            FROM GiaoVien WHERE MaGV = @MaGV
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        
        -- Update
        UPDATE GiaoVien
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            QueQuan = @QueQuan,
            DiaChi = @DiaChi,
            SDT = @SDT,
            Email = @Email,
            MaBM = @MaBM
        WHERE MaGV = @MaGV;
        
        -- Log change if user provided
        IF @MaNguoiCapNhat IS NOT NULL
        BEGIN
            DECLARE @MaLichSu NVARCHAR(50);
            SELECT TOP 1 @MaLichSu = MaLichSu 
            FROM LichSuDangNhap 
            WHERE MaNguoiDung = @MaNguoiCapNhat 
                AND ThoiDiemDangXuat IS NULL
            ORDER BY ThoiDiemDangNhap DESC;
            
            IF @MaLichSu IS NOT NULL
                EXEC sp_NhatKy_GhiLog @MaLichSu, N'Cập nhật thông tin giáo viên', @OldData, NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật thông tin giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 1.3. Xóa giáo viên (soft delete)
--CREATE OR ALTER PROCEDURE sp_GiaoVien_Xoa
--    @MaGV CHAR(15),
--    @ForceDelete BIT = 0,
--    @MaNguoiXoa NVARCHAR(50) = NULL,
--    @ErrorMessage NVARCHAR(500) OUTPUT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    SET XACT_ABORT ON;
    
--    BEGIN TRY
--        BEGIN TRANSACTION;
        
--        -- Check existence
--        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
--            THROW 50020, N'Mã giáo viên không tồn tại', 1;
        
--        -- Check dependencies
--        DECLARE @Dependencies NVARCHAR(MAX) = '';
        
--        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV)
--            SET @Dependencies = @Dependencies + N'Giảng dạy, ';
            
--        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV)
--            SET @Dependencies = @Dependencies + N'NCKH, ';
            
--        IF EXISTS (SELECT 1 FROM Khoa WHERE MaChuNhiemKhoa = @MaGV)
--            SET @Dependencies = @Dependencies + N'Chủ nhiệm khoa, ';
            
--        IF EXISTS (SELECT 1 FROM BoMon WHERE MaChuNhiemBM = @MaGV)
--            SET @Dependencies = @Dependencies + N'Chủ nhiệm bộ môn, ';
        
--        IF LEN(@Dependencies) > 0 AND @ForceDelete = 0
--        BEGIN
--            SET @Dependencies = LEFT(@Dependencies, LEN(@Dependencies) - 1);
--            THROW 50021, N'Không thể xóa vì giáo viên đang có liên kết: ' + @Dependencies, 1;
--        END
        
--        IF @ForceDelete = 1
--        BEGIN
--            -- Remove all dependencies
--            UPDATE Khoa SET MaChuNhiemKhoa = NULL WHERE MaChuNhiemKhoa = @MaGV;
--            UPDATE BoMon SET MaChuNhiemBM = NULL WHERE MaChuNhiemBM = @MaGV;
--            DELETE FROM ChiTietGiangDay WHERE MaGV = @MaGV;
--            DELETE FROM ChiTietNCKH WHERE MaGV = @MaGV;
--            DELETE FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV;
--            DELETE FROM ThamGia WHERE MaGV = @MaGV;
--            DELETE FROM ThamGiaHuongDan WHERE MaGV = @MaGV;
--            DELETE FROM NguoiDung WHERE MaGV = @MaGV;
--        END
        
--        DELETE FROM GiaoVien WHERE MaGV = @MaGV;
        
--        SET @ErrorMessage = N'Xóa giáo viên thành công';
        
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;
            
--        SET @ErrorMessage = ERROR_MESSAGE();
--        THROW;
--    END CATCH
--END;
--GO

-- 1.4. Tìm kiếm giáo viên nâng cao
CREATE OR ALTER PROCEDURE sp_GiaoVien_TimKiem
    @SearchText NVARCHAR(100) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @HocVi NVARCHAR(100) = NULL,
    @HocHam NVARCHAR(100) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Count total records
    SELECT @TotalRecords = COUNT(DISTINCT GV.MaGV)
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
    WHERE (@SearchText IS NULL OR 
           GV.HoTen LIKE N'%' + @SearchText + '%' OR 
           GV.Email LIKE '%' + @SearchText + '%' OR
           GV.MaGV LIKE '%' + @SearchText + '%')
      AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
      AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
      AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
      AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam);
    
    -- Return paginated results
    WITH CTE AS (
        SELECT DISTINCT
            GV.MaGV,
            GV.HoTen,
            GV.NgaySinh,
            CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
            GV.Email,
            GV.SDT,
            GV.DiaChi,
            BM.TenBM,
            K.TenKhoa,
            STRING_AGG(HV.TenHocVi, ', ') WITHIN GROUP (ORDER BY HV.NgayNhan DESC) AS DanhSachHocVi,
            (SELECT TOP 1 TenHocHam FROM LichSuHocHam WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
            ROW_NUMBER() OVER (ORDER BY GV.HoTen) AS RowNum
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
        LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
        LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
        WHERE (@SearchText IS NULL OR 
               GV.HoTen LIKE N'%' + @SearchText + '%' OR 
               GV.Email LIKE '%' + @SearchText + '%' OR
               GV.MaGV LIKE '%' + @SearchText + '%')
          AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
          AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
          AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
          AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam)
        GROUP BY GV.MaGV, GV.HoTen, GV.NgaySinh, GV.GioiTinh, GV.Email, 
                 GV.SDT, GV.DiaChi, BM.TenBM, K.TenKhoa
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 2: QUẢN LÝ KHOA VÀ BỘ MÔN
-- =============================================

-- 2.1. Thêm mới khoa
CREATE OR ALTER PROCEDURE sp_Khoa_ThemMoi
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @MaKhoa CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa)
            THROW 50030, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
            THROW 50031, N'Mã chủ nhiệm khoa không tồn tại', 1;
        
        -- Generate MaKhoa
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM Khoa;
        SET @MaKhoa = 'KHOA' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, MaChuNhiemKhoa)
        VALUES (@MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemKhoa IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm khoa thành công. Mã khoa: ' + @MaKhoa;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaKhoa = NULL;
        THROW;
    END CATCH
END;
GO

-- 2.2. Cập nhật khoa
CREATE OR ALTER PROCEDURE sp_Khoa_CapNhat
    @MaKhoa CHAR(15),
    @TenKhoa NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaChuNhiemKhoa CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50040, N'Mã khoa không tồn tại', 1;
            
        -- Validate
        IF EXISTS (SELECT 1 FROM Khoa WHERE TenKhoa = @TenKhoa AND MaKhoa != @MaKhoa)
            THROW 50041, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL 
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemKhoa)
                THROW 50042, N'Mã chủ nhiệm khoa không tồn tại', 1;
                
            -- Check if teacher belongs to this faculty
            IF NOT EXISTS (
                SELECT 1 FROM GiaoVien GV
                INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
                WHERE GV.MaGV = @MaChuNhiemKhoa AND BM.MaKhoa = @MaKhoa
            )
                THROW 50043, N'Giáo viên không thuộc khoa này', 1;
        END
        
        -- Get old dean
        DECLARE @OldChuNhiem CHAR(15);
        SELECT @OldChuNhiem = MaChuNhiemKhoa FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        -- Update
        UPDATE Khoa
        SET TenKhoa = @TenKhoa,
            DiaChi = @DiaChi,
            MaChuNhiemKhoa = @MaChuNhiemKhoa
        WHERE MaKhoa = @MaKhoa;
        
        -- Update ChucVu
        IF @OldChuNhiem != @MaChuNhiemKhoa
        BEGIN
            IF @OldChuNhiem IS NOT NULL
                EXEC sp_ChucVu_KetThuc @OldChuNhiem, 'CV003', NULL;
                
            IF @MaChuNhiemKhoa IS NOT NULL
                EXEC sp_ChucVu_PhanCong @MaChuNhiemKhoa, 'CV003', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Cập nhật khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 2.3. Xóa khoa
CREATE OR ALTER PROCEDURE sp_Khoa_Xoa
    @MaKhoa CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check existence
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50050, N'Mã khoa không tồn tại', 1;
            
        -- Check dependencies
        IF EXISTS (SELECT 1 FROM BoMon WHERE MaKhoa = @MaKhoa)
            THROW 50051, N'Không thể xóa khoa vì còn bộ môn trực thuộc', 1;
        
        DELETE FROM Khoa WHERE MaKhoa = @MaKhoa;
        
        SET @ErrorMessage = N'Xóa khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 2.4. Thêm mới bộ môn
CREATE OR ALTER PROCEDURE sp_BoMon_ThemMoi
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @MaBM CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM Khoa WHERE MaKhoa = @MaKhoa)
            THROW 50060, N'Mã khoa không tồn tại', 1;
            
        IF EXISTS (SELECT 1 FROM BoMon WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa)
            THROW 50061, N'Tên bộ môn đã tồn tại trong khoa', 1;
            
        IF @MaChuNhiemBM IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaChuNhiemBM)
            THROW 50062, N'Mã chủ nhiệm bộ môn không tồn tại', 1;
        
        -- Generate MaBM
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM BoMon;
        SET @MaBM = 'BM' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO BoMon (MaBM, TenBM, DiaChi, MaKhoa, MaChuNhiemBM)
        VALUES (@MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM);
        
        -- Update ChucVu if needed
        IF @MaChuNhiemBM IS NOT NULL
        BEGIN
            EXEC sp_ChucVu_PhanCong @MaChuNhiemBM, 'CV005', NULL, NULL;
        END
        
        SET @ErrorMessage = N'Thêm bộ môn thành công. Mã bộ môn: ' + @MaBM;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaBM = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 3: QUẢN LÝ GIẢNG DẠY
-- =============================================

-- 3.1. Thêm mới tài giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_ThemTai
    @TenHocPhan NVARCHAR(100),
    @SiSo INT,
    @He NVARCHAR(20),
    @Lop NVARCHAR(20),
    @SoTinChi INT,
    @GhiChu NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @MaDoiTuong CHAR(15),
    @MaThoiGian CHAR(15),
    @MaNgonNgu CHAR(15),
    @MaTaiGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SiSo <= 0 OR @SiSo > 500
            THROW 50070, N'Sĩ số không hợp lệ (1-500)', 1;
            
        IF @SoTinChi <= 0 OR @SoTinChi > 10
            THROW 50071, N'Số tín chỉ không hợp lệ (1-10)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay WHERE MaDoiTuong = @MaDoiTuong)
            THROW 50072, N'Mã đối tượng giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay WHERE MaThoiGian = @MaThoiGian)
            THROW 50073, N'Mã thời gian giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay WHERE MaNgonNgu = @MaNgonNgu)
            THROW 50074, N'Mã ngôn ngữ giảng dạy không tồn tại', 1;
        
        -- Generate MaTaiGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiGiangDay;
        SET @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiGiangDay (MaTaiGiangDay, TenHocPhan, SiSo, He, Lop, SoTinChi, 
                                GhiChu, NamHoc, MaDoiTuong, MaThoiGian, MaNgonNgu)
        VALUES (@MaTaiGiangDay, @TenHocPhan, @SiSo, @He, @Lop, @SoTinChi, 
                @GhiChu, @NamHoc, @MaDoiTuong, @MaThoiGian, @MaNgonNgu);
        
        SET @ErrorMessage = N'Thêm tài giảng dạy thành công. Mã: ' + @MaTaiGiangDay;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiGiangDay = NULL;
        THROW;
    END CATCH
END;
GO

-- 3.2. Phân công giảng dạy với kiểm tra lịch trùng
CREATE OR ALTER PROCEDURE sp_GiangDay_PhanCong
    @MaGV CHAR(15),
    @MaTaiGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @MaNoiDungGiangDay CHAR(15),
    @CheckConflict BIT = 1,
    @MaChiTietGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50080, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50081, N'Mã tài giảng dạy không tồn tại', 1;
            
        IF @SoTiet <= 0 OR @SoTiet > 200
            THROW 50082, N'Số tiết không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WHERE MaGV = @MaGV AND MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50083, N'Giáo viên đã được phân công cho học phần này', 1;
        
        -- Check schedule conflict
        IF @CheckConflict = 1
        BEGIN
            DECLARE @MaThoiGian CHAR(15), @NamHoc NVARCHAR(20);
            SELECT @MaThoiGian = MaThoiGian, @NamHoc = NamHoc 
            FROM TaiGiangDay WHERE MaTaiGiangDay = @MaTaiGiangDay;
            
            IF EXISTS (
                SELECT 1 FROM ChiTietGiangDay CTGD
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = @MaGV 
                    AND TGD.MaThoiGian = @MaThoiGian 
                    AND TGD.NamHoc = @NamHoc
                    AND TGD.MaTaiGiangDay != @MaTaiGiangDay
            )
                THROW 50084, N'Giáo viên có lịch trùng trong thời gian này', 1;
        END
        
        -- Calculate SoTietQuyDoi
        DECLARE @HeSoDoiTuong FLOAT = 1, @HeSoThoiGian FLOAT = 1, @HeSoNgonNgu FLOAT = 1;
        
        SELECT 
            @HeSoDoiTuong = DT.HeSoQuyChuan,
            @HeSoThoiGian = TG.HeSoQuyChuan,
            @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD
        INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;
        
        DECLARE @SoTietQuyDoi FLOAT = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;
        
        -- Generate MaChiTietGiangDay
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietGiangDay;
        SET @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, 
                                    MaGV, MaTaiGiangDay, MaNoiDungGiangDay)
        VALUES (@MaChiTietGiangDay, @SoTiet, @SoTietQuyDoi, @GhiChu, 
                @MaGV, @MaTaiGiangDay, @MaNoiDungGiangDay);
        
        SET @ErrorMessage = N'Phân công giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietGiangDay = NULL;
        THROW;
    END CATCH
END;
GO

-- 3.3. Kiểm tra lịch trùng giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_KiemTraLichTrung
    @MaGV CHAR(15),
    @MaThoiGian CHAR(15),
    @NamHoc NVARCHAR(20),
    @HasConflict BIT OUTPUT,
    @ConflictDetails NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @HasConflict = 0;
    SET @ConflictDetails = '';
    
    IF EXISTS (
        SELECT 1 FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc
    )
    BEGIN
        SET @HasConflict = 1;
        
        SELECT @ConflictDetails = STRING_AGG(
            TGD.TenHocPhan + ' - ' + TGD.Lop + ' (' + CAST(CTGD.SoTiet AS NVARCHAR(10)) + ' tiết)', 
            '; '
        )
        FROM ChiTietGiangDay CTGD
        INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE CTGD.MaGV = @MaGV 
            AND TGD.MaThoiGian = @MaThoiGian 
            AND TGD.NamHoc = @NamHoc;
    END
END;
GO

-- =============================================
-- SECTION 4: QUẢN LÝ NGHIÊN CỨU KHOA HỌC
-- =============================================

-- 4.1. Thêm mới tài NCKH
CREATE OR ALTER PROCEDURE sp_NCKH_ThemTai
    @TenCongTrinhKhoaHoc NVARCHAR(200),
    @NamHoc NVARCHAR(20),
    @SoTacGia INT,
    @MaLoaiNCKH CHAR(15),
    @MaTaiNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoTacGia <= 0 OR @SoTacGia > 20
            THROW 50090, N'Số tác giả không hợp lệ (1-20)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiNCKH WHERE MaLoaiNCKH = @MaLoaiNCKH)
            THROW 50091, N'Mã loại NCKH không tồn tại', 1;
        
        -- Generate MaTaiNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiNCKH;
        SET @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiNCKH (MaTaiNCKH, TenCongTrinhKhoaHoc, NamHoc, SoTacGia, MaLoaiNCKH)
        VALUES (@MaTaiNCKH, @TenCongTrinhKhoaHoc, @NamHoc, @SoTacGia, @MaLoaiNCKH);
        
        SET @ErrorMessage = N'Thêm tài NCKH thành công. Mã: ' + @MaTaiNCKH;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiNCKH = NULL;
        THROW;
    END CATCH
END;
GO

-- 4.2. Phân công NCKH với validation số tác giả
CREATE OR ALTER PROCEDURE sp_NCKH_PhanCong
    @MaGV CHAR(15),
    @MaTaiNCKH CHAR(15),
    @VaiTro NVARCHAR(100),
    @SoGio FLOAT,
    @MaChiTietNCKH CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50100, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH)
            THROW 50101, N'Mã tài NCKH không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 500
            THROW 50102, N'Số giờ không hợp lệ (1-500)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WHERE MaGV = @MaGV AND MaTaiNCKH = @MaTaiNCKH)
            THROW 50103, N'Giáo viên đã được phân công cho công trình này', 1;
        
        -- Check number of authors
        DECLARE @SoTacGia INT, @SoTacGiaHienTai INT;
        SELECT @SoTacGia = SoTacGia FROM TaiNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        SELECT @SoTacGiaHienTai = COUNT(*) FROM ChiTietNCKH WHERE MaTaiNCKH = @MaTaiNCKH;
        
        IF @SoTacGiaHienTai >= @SoTacGia
            THROW 50104, N'Đã đủ số tác giả cho công trình này', 1;
        
        -- Check role
        IF @VaiTro = N'Chủ nhiệm' AND EXISTS (
            SELECT 1 FROM ChiTietNCKH 
            WHERE MaTaiNCKH = @MaTaiNCKH AND VaiTro = N'Chủ nhiệm'
        )
            THROW 50105, N'Đã có chủ nhiệm cho công trình này', 1;
        
        -- Generate MaChiTietNCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietNCKH;
        SET @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietNCKH (MaChiTietNCKH, VaiTro, MaGV, MaTaiNCKH, SoGio)
        VALUES (@MaChiTietNCKH, @VaiTro, @MaGV, @MaTaiNCKH, @SoGio);
        
        SET @ErrorMessage = N'Phân công NCKH thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietNCKH = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 5: QUẢN LÝ KHẢO THÍ
-- =============================================

-- 5.1. Thêm mới tài khảo thí
CREATE OR ALTER PROCEDURE sp_KhaoThi_ThemTai
    @HocPhan NVARCHAR(100),
    @Lop NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @GhiChu NVARCHAR(200),
    @MaLoaiCongTacKhaoThi CHAR(15),
    @MaTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LoaiCongTacKhaoThi WHERE MaLoaiCongTacKhaoThi = @MaLoaiCongTacKhaoThi)
            THROW 50110, N'Mã loại công tác khảo thí không tồn tại', 1;
        
        -- Generate MaTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiKhaoThi;
        SET @MaTaiKhaoThi = 'KT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiKhaoThi (MaTaiKhaoThi, HocPhan, Lop, NamHoc, GhiChu, MaLoaiCongTacKhaoThi)
        VALUES (@MaTaiKhaoThi, @HocPhan, @Lop, @NamHoc, @GhiChu, @MaLoaiCongTacKhaoThi);
        
        SET @ErrorMessage = N'Thêm tài khảo thí thành công. Mã: ' + @MaTaiKhaoThi;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO

-- 5.2. Phân công khảo thí
CREATE OR ALTER PROCEDURE sp_KhaoThi_PhanCong
    @MaGV CHAR(15),
    @MaTaiKhaoThi CHAR(15),
    @SoBai INT,
    @MaChiTietTaiKhaoThi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50120, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50121, N'Mã tài khảo thí không tồn tại', 1;
            
        IF @SoBai <= 0 OR @SoBai > 1000
            THROW 50122, N'Số bài không hợp lệ (1-1000)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WHERE MaGV = @MaGV AND MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50123, N'Giáo viên đã được phân công cho công tác khảo thí này', 1;
        
        -- Calculate SoGioQuyChuan based on type
        DECLARE @MaLoaiCongTacKhaoThi CHAR(15), @SoGioQuyChuan FLOAT;
        SELECT @MaLoaiCongTacKhaoThi = MaLoaiCongTacKhaoThi FROM TaiKhaoThi WHERE MaTaiKhaoThi = @MaTaiKhaoThi;
        
        SET @SoGioQuyChuan = CASE 
            WHEN @MaLoaiCongTacKhaoThi = 'LKT01' THEN @SoBai * 0.5  -- Ra đề
            WHEN @MaLoaiCongTacKhaoThi = 'LKT02' THEN @SoBai * 0.3  -- Coi thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT03' THEN @SoBai * 0.4  -- Chấm thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT04' THEN @SoBai * 0.2  -- Phản biện
            WHEN @MaLoaiCongTacKhaoThi = 'LKT05' THEN @SoBai * 0.3  -- Phúc khảo
            ELSE @SoBai * 0.3
        END;
        
        -- Generate MaChiTietTaiKhaoThi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietTaiKhaoThi;
        SET @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ChiTietTaiKhaoThi (MaChiTietTaiKhaoThi, SoBai, SoGioQuyChuan, MaGV, MaTaiKhaoThi)
        VALUES (@MaChiTietTaiKhaoThi, @SoBai, @SoGioQuyChuan, @MaGV, @MaTaiKhaoThi);
        
        SET @ErrorMessage = N'Phân công khảo thí thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietTaiKhaoThi = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 6: QUẢN LÝ HỘI ĐỒNG
-- =============================================

-- 6.1. Thêm mới hội đồng
CREATE OR ALTER PROCEDURE sp_HoiDong_ThemMoi
    @SoLuong INT,
    @NamHoc NVARCHAR(20),
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @GhiChu NVARCHAR(200),
    @MaLoaiHoiDong CHAR(15),
    @MaHoiDong CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoLuong <= 0 OR @SoLuong > 20
            THROW 50130, N'Số lượng thành viên không hợp lệ (1-20)', 1;
            
        IF @ThoiGianBatDau >= @ThoiGianKetThuc
            THROW 50131, N'Thời gian kết thúc phải sau thời gian bắt đầu', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHoiDong WHERE MaLoaiHoiDong = @MaLoaiHoiDong)
            THROW 50132, N'Mã loại hội đồng không tồn tại', 1;
        
        -- Generate MaHoiDong
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHoiDong;
        SET @MaHoiDong = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHoiDong (MaHoiDong, SoLuong, NamHoc, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, MaLoaiHoiDong)
        VALUES (@MaHoiDong, @SoLuong, @NamHoc, @ThoiGianBatDau, @ThoiGianKetThuc, @GhiChu, @MaLoaiHoiDong);
        
        SET @ErrorMessage = N'Thêm hội đồng thành công. Mã: ' + @MaHoiDong;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHoiDong = NULL;
        THROW;
    END CATCH
END;
GO

-- 6.2. Thêm thành viên hội đồng
CREATE OR ALTER PROCEDURE sp_HoiDong_ThemThanhVien
    @MaGV CHAR(15),
    @MaHoiDong CHAR(15),
    @SoGio FLOAT,
    @MaThamGia CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50140, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong)
            THROW 50141, N'Mã hội đồng không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 100
            THROW 50142, N'Số giờ không hợp lệ (1-100)', 1;
        
        -- Check if already member
        IF EXISTS (SELECT 1 FROM ThamGia WHERE MaGV = @MaGV AND MaHoiDong = @MaHoiDong)
            THROW 50143, N'Giáo viên đã là thành viên của hội đồng này', 1;
        
        -- Check max members
        DECLARE @SoLuong INT, @SoThanhVienHienTai INT;
        SELECT @SoLuong = SoLuong FROM TaiHoiDong WHERE MaHoiDong = @MaHoiDong;
        SELECT @SoThanhVienHienTai = COUNT(*) FROM ThamGia WHERE MaHoiDong = @MaHoiDong;
        
        IF @SoThanhVienHienTai >= @SoLuong
            THROW 50144, N'Hội đồng đã đủ số lượng thành viên', 1;
        
        -- Generate MaThamGia
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGia;
        SET @MaThamGia = 'TG' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGia (MaThamGia, MaGV, MaHoiDong, SoGio)
        VALUES (@MaThamGia, @MaGV, @MaHoiDong, @SoGio);
        
        SET @ErrorMessage = N'Thêm thành viên hội đồng thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGia = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 7: QUẢN LÝ HƯỚNG DẪN
-- =============================================

-- 7.1. Thêm mới tài hướng dẫn
CREATE OR ALTER PROCEDURE sp_HuongDan_ThemTai
    @HoTenHocVien NVARCHAR(100),
    @Lop NVARCHAR(50),
    @He NVARCHAR(50),
    @NamHoc NVARCHAR(20),
    @TenDeTai NVARCHAR(200),
    @SoCBHD INT,
    @MaLoaiHinhHuongDan CHAR(15),
    @MaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF @SoCBHD <= 0 OR @SoCBHD > 5
            THROW 50150, N'Số cán bộ hướng dẫn không hợp lệ (1-5)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHinhHuongDan WHERE MaLoaiHinhHuongDan = @MaLoaiHinhHuongDan)
            THROW 50151, N'Mã loại hình hướng dẫn không tồn tại', 1;
        
        -- Generate MaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHuongDan;
        SET @MaHuongDan = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO TaiHuongDan (MaHuongDan, HoTenHocVien, Lop, He, NamHoc, TenDeTai, SoCBHD, MaLoaiHinhHuongDan)
        VALUES (@MaHuongDan, @HoTenHocVien, @Lop, @He, @NamHoc, @TenDeTai, @SoCBHD, @MaLoaiHinhHuongDan);
        
        SET @ErrorMessage = N'Thêm tài hướng dẫn thành công. Mã: ' + @MaHuongDan;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO

-- 7.2. Phân công hướng dẫn
CREATE OR ALTER PROCEDURE sp_HuongDan_PhanCong
    @MaGV CHAR(15),
    @MaHuongDan CHAR(15),
    @SoGio FLOAT,
    @MaThamGiaHuongDan CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50160, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan)
            THROW 50161, N'Mã tài hướng dẫn không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 200
            THROW 50162, N'Số giờ không hợp lệ (1-200)', 1;
        
        -- Check if already assigned
        IF EXISTS (SELECT 1 FROM ThamGiaHuongDan WHERE MaGV = @MaGV AND MaHuongDan = @MaHuongDan)
            THROW 50163, N'Giáo viên đã được phân công hướng dẫn này', 1;
        
        -- Check max advisors
        DECLARE @SoCBHD INT, @SoCBHDHienTai INT;
        SELECT @SoCBHD = SoCBHD FROM TaiHuongDan WHERE MaHuongDan = @MaHuongDan;
        SELECT @SoCBHDHienTai = COUNT(*) FROM ThamGiaHuongDan WHERE MaHuongDan = @MaHuongDan;
        
        IF @SoCBHDHienTai >= @SoCBHD
            THROW 50164, N'Đã đủ số cán bộ hướng dẫn', 1;
        
        -- Generate MaThamGiaHuongDan
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGiaHuongDan;
        SET @MaThamGiaHuongDan = 'TGHD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO ThamGiaHuongDan (MaThamGiaHuongDan, MaGV, MaHuongDan, SoGio)
        VALUES (@MaThamGiaHuongDan, @MaGV, @MaHuongDan, @SoGio);
        
        SET @ErrorMessage = N'Phân công hướng dẫn thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaThamGiaHuongDan = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 8: QUẢN LÝ HỌC HÀM HỌC VỊ
-- =============================================

-- 8.1. Cập nhật học vị
CREATE OR ALTER PROCEDURE sp_HocVi_CapNhat
    @MaGV CHAR(15),
    @TenHocVi NVARCHAR(100),
    @NgayNhan DATE,
    @MaHocVi CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50170, N'Mã giáo viên không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50171, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if same degree already exists
        IF EXISTS (SELECT 1 FROM HocVi WHERE MaGV = @MaGV AND TenHocVi = @TenHocVi)
            THROW 50172, N'Giáo viên đã có học vị này', 1;
        
        -- Generate MaHocVi
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM HocVi;
        SET @MaHocVi = 'HV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO HocVi (MaHocVi, TenHocVi, NgayNhan, MaGV)
        VALUES (@MaHocVi, @TenHocVi, @NgayNhan, @MaGV);
        
        SET @ErrorMessage = N'Cập nhật học vị thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaHocVi = NULL;
        THROW;
    END CATCH
END;
GO

-- 8.2. Cập nhật học hàm
CREATE OR ALTER PROCEDURE sp_HocHam_CapNhat
    @MaGV CHAR(15),
    @MaHocHam CHAR(15),
    @NgayNhan DATE,
    @MaLSHocHam CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50180, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM HocHam WHERE MaHocHam = @MaHocHam)
            THROW 50181, N'Mã học hàm không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50182, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Check if already has this title
        IF EXISTS (
            SELECT 1 FROM LichSuHocHam 
            WHERE MaGV = @MaGV AND MaHocHam = @MaHocHam
        )
            THROW 50183, N'Giáo viên đã có học hàm này', 1;
        
        -- Get TenHocHam
        DECLARE @TenHocHam NVARCHAR(100);
        SELECT @TenHocHam = TenHocHam FROM HocHam WHERE MaHocHam = @MaHocHam;
        
        -- Generate MaLSHocHam
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuHocHam;
        SET @MaLSHocHam = 'LSHH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuHocHam (MaLSHocHam, TenHocHam, NgayNhan, MaGV, MaHocHam)
        VALUES (@MaLSHocHam, @TenHocHam, @NgayNhan, @MaGV, @MaHocHam);
        
        SET @ErrorMessage = N'Cập nhật học hàm thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaLSHocHam = NULL;
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 9: QUẢN LÝ CHỨC VỤ
-- =============================================

-- 9.1. Phân công chức vụ
CREATE OR ALTER PROCEDURE sp_ChucVu_PhanCong
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayNhan DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50190, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaChucVu = @MaChucVu)
            THROW 50191, N'Mã chức vụ không tồn tại', 1;
            
        IF @NgayNhan IS NULL
            SET @NgayNhan = GETDATE();
        
        -- Check if already has this position
        IF EXISTS (
            SELECT 1 FROM LichSuChucVu 
            WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL
        )
            THROW 50192, N'Giáo viên đang giữ chức vụ này', 1;
        
        -- Generate MaLichSuChucVu
        DECLARE @MaLichSuChucVu CHAR(15);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuChucVu;
        SET @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
        VALUES (@MaLichSuChucVu, @NgayNhan, NULL, @MaGV, @MaChucVu);
        
        SET @ErrorMessage = N'Phân công chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 9.2. Kết thúc chức vụ
CREATE OR ALTER PROCEDURE sp_ChucVu_KetThuc
    @MaGV CHAR(15),
    @MaChucVu CHAR(15),
    @NgayKetThuc DATE = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @NgayKetThuc IS NULL
            SET @NgayKetThuc = GETDATE();
        
        -- Update
        UPDATE LichSuChucVu
        SET NgayKetThuc = @NgayKetThuc
        WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50200, N'Không tìm thấy chức vụ đang hoạt động', 1;
        
        SET @ErrorMessage = N'Kết thúc chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 10: QUẢN LÝ NGƯỜI DÙNG VÀ PHÂN QUYỀN
-- =============================================

-- 10.1. Tạo tài khoản người dùng
CREATE OR ALTER PROCEDURE sp_NguoiDung_TaoTaiKhoan
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaGV CHAR(15) = NULL,
    @MaNhom NVARCHAR(50) = NULL,
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF EXISTS (SELECT 1 FROM NguoiDung WHERE TenDangNhap = @TenDangNhap)
            THROW 50210, N'Tên đăng nhập đã tồn tại', 1;
            
        IF @MaGV IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
                THROW 50211, N'Mã giáo viên không tồn tại', 1;
                
            IF EXISTS (SELECT 1 FROM NguoiDung WHERE MaGV = @MaGV)
                THROW 50212, N'Giáo viên đã có tài khoản', 1;
        END
        
        -- Hash password (in production, use proper hashing)
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Generate MaNguoiDung
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NguoiDung;
        SET @MaNguoiDung = 'ND' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert user
        INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
        VALUES (@MaNguoiDung, @TenDangNhap, @HashedPassword, @MaGV);
        
        -- Add to group if specified
        IF @MaNhom IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WHERE MaNhom = @MaNhom)
                THROW 50213, N'Mã nhóm không tồn tại', 1;
                
            INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
            VALUES (@MaNguoiDung, @MaNhom);
        END
        
        SET @ErrorMessage = N'Tạo tài khoản thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        THROW;
    END CATCH
END;
GO

-- 10.2. Đổi mật khẩu
CREATE OR ALTER PROCEDURE sp_NguoiDung_DoiMatKhau
    @MaNguoiDung NVARCHAR(50),
    @MatKhauCu NVARCHAR(100),
    @MatKhauMoi NVARCHAR(100),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate old password
        DECLARE @HashedOldPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauCu);
        
        IF NOT EXISTS (
            SELECT 1 FROM NguoiDung 
            WHERE MaNguoiDung = @MaNguoiDung AND MatKhau = @HashedOldPassword
        )
            THROW 50220, N'Mật khẩu cũ không chính xác', 1;
        
        -- Validate new password
        IF LEN(@MatKhauMoi) < 6
            THROW 50221, N'Mật khẩu mới phải có ít nhất 6 ký tự', 1;
        
        -- Update password
        DECLARE @HashedNewPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhauMoi);
        
        UPDATE NguoiDung
        SET MatKhau = @HashedNewPassword
        WHERE MaNguoiDung = @MaNguoiDung;
        
        SET @ErrorMessage = N'Đổi mật khẩu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 10.3. Đăng nhập
CREATE OR ALTER PROCEDURE sp_NguoiDung_DangNhap
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @MaLichSu NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Hash password
        DECLARE @HashedPassword NVARCHAR(100) = HASHBYTES('SHA2_256', @MatKhau);
        
        -- Check credentials
        SELECT @MaNguoiDung = MaNguoiDung
        FROM NguoiDung
        WHERE TenDangNhap = @TenDangNhap AND MatKhau = @HashedPassword;
        
        IF @MaNguoiDung IS NULL
            THROW 50230, N'Tên đăng nhập hoặc mật khẩu không chính xác', 1;
        
        -- Generate MaLichSu
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuDangNhap;
        SET @MaLichSu = 'LS' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Log login
        INSERT INTO LichSuDangNhap (MaLichSu, ThoiDiemDangNhap, ThoiDiemDangXuat, MaNguoiDung)
        VALUES (@MaLichSu, GETDATE(), NULL, @MaNguoiDung);
        
        SET @ErrorMessage = N'Đăng nhập thành công';
        
        COMMIT TRANSACTION;
        
        -- Return user info
        SELECT 
            ND.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            GV.Email,
            STRING_AGG(NND.TenNhom, ', ') AS DanhSachNhom
        FROM NguoiDung ND
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        LEFT JOIN NguoiDung_Nhom NDN ON ND.MaNguoiDung = NDN.MaNguoiDung
        LEFT JOIN NhomNguoiDung NND ON NDN.MaNhom = NND.MaNhom
        WHERE ND.MaNguoiDung = @MaNguoiDung
        GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen, GV.Email;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        SET @MaLichSu = NULL;
        THROW;
    END CATCH
END;
GO

-- 10.4. Đăng xuất
CREATE OR ALTER PROCEDURE sp_NguoiDung_DangXuat
    @MaLichSu NVARCHAR(50),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE LichSuDangNhap
        SET ThoiDiemDangXuat = GETDATE()
        WHERE MaLichSu = @MaLichSu AND ThoiDiemDangXuat IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50240, N'Phiên đăng nhập không tồn tại hoặc đã kết thúc', 1;
        
        SET @ErrorMessage = N'Đăng xuất thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 10.5. Kiểm tra quyền
CREATE OR ALTER PROCEDURE sp_NguoiDung_KiemTraQuyen
    @MaNguoiDung NVARCHAR(50),
    @MaQuyen NVARCHAR(50),
    @CoQuyen BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SET @CoQuyen = 0;
    
    IF EXISTS (
        SELECT 1
        FROM NguoiDung_Nhom NDN
        INNER JOIN Nhom_Quyen NQ ON NDN.MaNhom = NQ.MaNhom
        WHERE NDN.MaNguoiDung = @MaNguoiDung AND NQ.MaQuyen = @MaQuyen
    )
        SET @CoQuyen = 1;
END;
GO

-- =============================================
-- SECTION 11: NHẬT KÝ VÀ AUDIT
-- =============================================

-- 11.1. Ghi nhật ký thay đổi
CREATE OR ALTER PROCEDURE sp_NhatKy_GhiLog
    @MaLichSu NVARCHAR(50),
    @NoiDungThayDoi NVARCHAR(255),
    @ThongTinCu NVARCHAR(255),
    @ThongTinMoi NVARCHAR(255),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM LichSuDangNhap WHERE MaLichSu = @MaLichSu)
            THROW 50250, N'Mã lịch sử không tồn tại', 1;
        
        -- Generate MaNhatKy
        DECLARE @MaNhatKy NVARCHAR(50);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NhatKyThayDoi;
        SET @MaNhatKy = 'NK' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Insert
        INSERT INTO NhatKyThayDoi (MaNhatKy, MaLichSu, ThoiGianThayDoi, NoiDungThayDoi, ThongTinCu, ThongTinMoi)
        VALUES (@MaNhatKy, @MaLichSu, GETDATE(), @NoiDungThayDoi, @ThongTinCu, @ThongTinMoi);
        
        SET @ErrorMessage = N'Ghi nhật ký thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 11.2. Xem lịch sử hoạt động
CREATE OR ALTER PROCEDURE sp_NhatKy_XemLichSu
    @MaNguoiDung NVARCHAR(50) = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @TuNgay IS NULL
        SET @TuNgay = DATEADD(DAY, -30, GETDATE());
        
    IF @DenNgay IS NULL
        SET @DenNgay = GETDATE();
    
    WITH CTE AS (
        SELECT 
            NK.MaNhatKy,
            NK.ThoiGianThayDoi,
            NK.NoiDungThayDoi,
            NK.ThongTinCu,
            NK.ThongTinMoi,
            LS.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            ROW_NUMBER() OVER (ORDER BY NK.ThoiGianThayDoi DESC) AS RowNum
        FROM NhatKyThayDoi NK
        INNER JOIN LichSuDangNhap LS ON NK.MaLichSu = LS.MaLichSu
        INNER JOIN NguoiDung ND ON LS.MaNguoiDung = ND.MaNguoiDung
        LEFT JOIN GiaoVien GV ON ND.MaGV = GV.MaGV
        WHERE (@MaNguoiDung IS NULL OR LS.MaNguoiDung = @MaNguoiDung)
            AND CAST(NK.ThoiGianThayDoi AS DATE) BETWEEN @TuNgay AND @DenNgay
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 12: BÁO CÁO VÀ THỐNG KÊ
-- =============================================

-- 12.1. Báo cáo tổng hợp khối lượng công tác
CREATE OR ALTER PROCEDURE sp_BaoCao_TongHopKhoiLuongCongTac
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH GiangDayStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTGD.SoTietQuyDoi), 0) AS TongGioGiangDay
        FROM GiaoVien GV
        LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE @NamHoc IS NULL OR TGD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH
        FROM GiaoVien GV
        LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE @NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTKT.SoGioQuyChuan), 0) AS TongGioKhaoThi
        FROM GiaoVien GV
        LEFT JOIN ChiTietTaiKhaoThi CTKT ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE @NamHoc IS NULL OR TKT.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TG.SoGio), 0) AS TongGioHoiDong
        FROM GiaoVien GV
        LEFT JOIN ThamGia TG ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TGHD.SoGio), 0) AS TongGioHuongDan
        FROM GiaoVien GV
        LEFT JOIN ThamGiaHuongDan TGHD ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    DinhMucStats AS (
        SELECT 
            GV.MaGV,
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
    )
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        GD.TongGioGiangDay,
        NC.TongGioNCKH,
        KT.TongGioKhaoThi,
        HD.TongGioHoiDong,
        HDan.TongGioHuongDan,
        GD.TongGioGiangDay + NC.TongGioNCKH + KT.TongGioKhaoThi + 
        HD.TongGioHoiDong + HDan.TongGioHuongDan AS TongGioQuyChuan,
        DM.DinhMucGiangDay,
        DM.DinhMucNCKH,
        CAST(GD.TongGioGiangDay * 100.0 / NULLIF(DM.DinhMucGiangDay, 0) AS DECIMAL(10,2)) AS PhanTramGiangDay,
        CAST(NC.TongGioNCKH * 100.0 / NULLIF(DM.DinhMucNCKH, 0) AS DECIMAL(10,2)) AS PhanTramNCKH,
        CASE 
            WHEN GD.TongGioGiangDay >= DM.DinhMucGiangDay AND NC.TongGioNCKH >= DM.DinhMucNCKH THEN N'Đạt'
            ELSE N'Chưa đạt'
        END AS TrangThai
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiangDayStats GD ON GV.MaGV = GD.MaGV
    LEFT JOIN NCKHStats NC ON GV.MaGV = NC.MaGV
    LEFT JOIN KhaoThiStats KT ON GV.MaGV = KT.MaGV
    LEFT JOIN HoiDongStats HD ON GV.MaGV = HD.MaGV
    LEFT JOIN HuongDanStats HDan ON GV.MaGV = HDan.MaGV
    LEFT JOIN DinhMucStats DM ON GV.MaGV = DM.MaGV
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen;
END;
GO

-- 12.2. Báo cáo thống kê theo khoa
CREATE OR ALTER PROCEDURE sp_BaoCao_ThongKeTheoKhoa
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        COUNT(DISTINCT BM.MaBM) AS SoBoMon,
        COUNT(DISTINCT GV.MaGV) AS SoGiaoVien,
        COUNT(DISTINCT CASE WHEN HV.TenHocVi = N'Tiến sĩ' THEN GV.MaGV END) AS SoTienSi,
        COUNT(DISTINCT CASE WHEN HV.TenHocVi = N'Thạc sĩ' THEN GV.MaGV END) AS SoThacSi,
        COUNT(DISTINCT CASE WHEN LSHH.TenHocHam IN (N'Giáo sư', N'Phó giáo sư') THEN GV.MaGV END) AS SoGSPGS,
        ISNULL(SUM(CTGD.SoTietQuyDoi), 0) AS TongGioGiangDay,
        ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH,
        COUNT(DISTINCT TGD.MaTaiGiangDay) AS SoHocPhan,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoCongTrinhNCKH
    FROM Khoa K
    LEFT JOIN BoMon BM ON K.MaKhoa = BM.MaKhoa
    LEFT JOIN GiaoVien GV ON BM.MaBM = GV.MaBM
    LEFT JOIN HocVi HV ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH ON GV.MaGV = LSHH.MaGV
    LEFT JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    LEFT JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    LEFT JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    LEFT JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    GROUP BY K.MaKhoa, K.TenKhoa
    ORDER BY K.TenKhoa;
END;
GO

-- 12.3. Báo cáo chi tiết giảng dạy
CREATE OR ALTER PROCEDURE sp_BaoCao_ChiTietGiangDay
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TGD.TenHocPhan,
        TGD.Lop,
        TGD.SiSo,
        TGD.SoTinChi,
        TGD.He,
        TGD.NamHoc,
        DT.TenDoiTuong,
        TG.TenThoiGian,
        NN.TenNgonNgu,
        CTGD.SoTiet,
        CTGD.SoTietQuyDoi,
        DT.HeSoQuyChuan AS HeSoDoiTuong,
        TG.HeSoQuyChuan AS HeSoThoiGian,
        NN.HeSoQuyChuan AS HeSoNgonNgu,
        CTGD.GhiChu
    FROM ChiTietGiangDay CTGD
    INNER JOIN GiaoVien GV ON CTGD.MaGV = GV.MaGV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    INNER JOIN DoiTuongGiangDay DT ON TGD.MaDoiTuong = DT.MaDoiTuong
    INNER JOIN ThoiGianGiangDay TG ON TGD.MaThoiGian = TG.MaThoiGian
    INNER JOIN NgonNguGiangDay NN ON TGD.MaNgonNgu = NN.MaNgonNgu
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen, TGD.TenHocPhan;
END;
GO

-- 12.4. Báo cáo chi tiết NCKH
CREATE OR ALTER PROCEDURE sp_BaoCao_ChiTietNCKH
    @MaGV CHAR(15) = NULL,
    @MaBM CHAR(15) = NULL,
    @MaKhoa CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        K.TenKhoa,
        TNCKH.TenCongTrinhKhoaHoc,
        TNCKH.NamHoc,
        TNCKH.SoTacGia,
        LNCKH.TenLoaiNCKH,
        CTNCKH.VaiTro,
        CTNCKH.SoGio,
        QD.DonViTinh,
        QD.QuyRaGioChuan,
        QD.NhomCongViec,
        LNCKH.MoTa
    FROM ChiTietNCKH CTNCKH
    INNER JOIN GiaoVien GV ON CTNCKH.MaGV = GV.MaGV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    INNER JOIN LoaiNCKH LNCKH ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
    INNER JOIN QuyDoiGioChuanNCKH QD ON LNCKH.MaQuyDoi = QD.MaQuyDoi
    WHERE (@MaGV IS NULL OR GV.MaGV = @MaGV)
        AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
        AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
        AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    ORDER BY K.TenKhoa, BM.TenBM, GV.HoTen, TNCKH.TenCongTrinhKhoaHoc;
END;
GO

-- 12.5. Báo cáo xếp loại giáo viên
CREATE OR ALTER PROCEDURE sp_BaoCao_XepLoaiGiaoVien
    @NamHoc NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH ThongKe AS (
        SELECT 
            GV.MaGV,
            GV.HoTen,
            BM.TenBM,
            K.TenKhoa,
            -- Giảng dạy
            ISNULL((
                SELECT SUM(CTGD.SoTietQuyDoi)
                FROM ChiTietGiangDay CTGD
                INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
            ), 0) AS TongGioGiangDay,
            -- NCKH
            ISNULL((
                SELECT SUM(CTNCKH.SoGio)
                FROM ChiTietNCKH CTNCKH
                INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
                WHERE CTNCKH.MaGV = GV.MaGV AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
            ), 0) AS TongGioNCKH,
            -- Định mức
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH
                INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV
        INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    )
    SELECT 
        MaGV,
        HoTen,
        TenBM,
        TenKhoa,
        TongGioGiangDay,
        DinhMucGiangDay,
        CAST(TongGioGiangDay * 100.0 / NULLIF(DinhMucGiangDay, 0) AS DECIMAL(10,2)) AS PhanTramGiangDay,
        TongGioNCKH,
        DinhMucNCKH,
        CAST(TongGioNCKH * 100.0 / NULLIF(DinhMucNCKH, 0) AS DECIMAL(10,2)) AS PhanTramNCKH,
        CASE 
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.5 AND TongGioNCKH >= DinhMucNCKH * 1.5 THEN N'Xuất sắc'
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.2 AND TongGioNCKH >= DinhMucNCKH * 1.2 THEN N'Tốt'
            WHEN TongGioGiangDay >= DinhMucGiangDay AND TongGioNCKH >= DinhMucNCKH THEN N'Khá'
            WHEN TongGioGiangDay >= DinhMucGiangDay * 0.8 OR TongGioNCKH >= DinhMucNCKH * 0.8 THEN N'Trung bình'
            ELSE N'Yếu'
        END AS XepLoai
    FROM ThongKe
    ORDER BY 
        CASE 
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.5 AND TongGioNCKH >= DinhMucNCKH * 1.5 THEN 1
            WHEN TongGioGiangDay >= DinhMucGiangDay * 1.2 AND TongGioNCKH >= DinhMucNCKH * 1.2 THEN 2
            WHEN TongGioGiangDay >= DinhMucGiangDay AND TongGioNCKH >= DinhMucNCKH THEN 3
            WHEN TongGioGiangDay >= DinhMucGiangDay * 0.8 OR TongGioNCKH >= DinhMucNCKH * 0.8 THEN 4
            ELSE 5
        END,
        TenKhoa, TenBM, HoTen;
END;
GO

-- =============================================
-- SECTION 13: DASHBOARD VÀ TỔNG QUAN
-- =============================================

-- 13.1. Dashboard tổng quan
CREATE OR ALTER PROCEDURE sp_Dashboard_TongQuan
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thống kê tổng quan
    SELECT 
        (SELECT COUNT(*) FROM GiaoVien) AS TongGiaoVien,
        (SELECT COUNT(*) FROM Khoa) AS TongKhoa,
        (SELECT COUNT(*) FROM BoMon) AS TongBoMon,
        (SELECT COUNT(*) FROM NguoiDung) AS TongNguoiDung;
    
    -- Thống kê giáo viên theo học vị
    SELECT 
        HV.TenHocVi,
        COUNT(DISTINCT HV.MaGV) AS SoLuong
    FROM HocVi HV
    GROUP BY HV.TenHocVi
    ORDER BY SoLuong DESC;
    
    -- Thống kê giáo viên theo học hàm
    SELECT 
        LSHH.TenHocHam,
        COUNT(DISTINCT LSHH.MaGV) AS SoLuong
    FROM LichSuHocHam LSHH
    WHERE LSHH.NgayNhan = (
        SELECT MAX(LSHH2.NgayNhan)
        FROM LichSuHocHam LSHH2
        WHERE LSHH2.MaGV = LSHH.MaGV
    )
    GROUP BY LSHH.TenHocHam
    ORDER BY SoLuong DESC;
    
    -- Top 10 giáo viên giảng dạy nhiều nhất năm hiện tại
    SELECT TOP 10
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        SUM(CTGD.SoTietQuyDoi) AS TongGioGiangDay
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN ChiTietGiangDay CTGD ON GV.MaGV = CTGD.MaGV
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE TGD.NamHoc = (SELECT TOP 1 NamHoc FROM TaiGiangDay ORDER BY NamHoc DESC)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM
    ORDER BY TongGioGiangDay DESC;
    
    -- Top 10 giáo viên NCKH nhiều nhất năm hiện tại
    SELECT TOP 10
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        COUNT(DISTINCT TNCKH.MaTaiNCKH) AS SoCongTrinh,
        SUM(CTNCKH.SoGio) AS TongGioNCKH
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN ChiTietNCKH CTNCKH ON GV.MaGV = CTNCKH.MaGV
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE TNCKH.NamHoc = (SELECT TOP 1 NamHoc FROM TaiNCKH ORDER BY NamHoc DESC)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM
    ORDER BY TongGioNCKH DESC;
END;
GO

-- 13.2. Dashboard cho giáo viên
CREATE OR ALTER PROCEDURE sp_Dashboard_GiaoVien
    @MaGV CHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thông tin cá nhân
    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
        GV.Email,
        GV.SDT,
        BM.TenBM,
        K.TenKhoa,
        (SELECT TOP 1 TenHocVi FROM HocVi WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocViCaoNhat,
        (SELECT TOP 1 TenHocHam FROM LichSuHocHam WHERE MaGV = GV.MaGV ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
        (SELECT TOP 1 CV.TenChucVu 
         FROM LichSuChucVu LSCV 
         INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
         WHERE LSCV.MaGV = GV.MaGV AND LSCV.NgayKetThuc IS NULL
         ORDER BY LSCV.NgayNhan DESC) AS ChucVuHienTai
    FROM GiaoVien GV
    INNER JOIN BoMon BM ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K ON BM.MaKhoa = K.MaKhoa
    WHERE GV.MaGV = @MaGV;
    
    -- Thống kê khối lượng năm hiện tại
    DECLARE @NamHocHienTai NVARCHAR(20);
    SELECT TOP 1 @NamHocHienTai = NamHoc FROM TaiGiangDay ORDER BY NamHoc DESC;
    
    SELECT 
        ISNULL((
            SELECT SUM(CTGD.SoTietQuyDoi)
            FROM ChiTietGiangDay CTGD
            INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
            WHERE CTGD.MaGV = @MaGV AND TGD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioGiangDay,
        ISNULL((
            SELECT SUM(CTNCKH.SoGio)
            FROM ChiTietNCKH CTNCKH
            INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
            WHERE CTNCKH.MaGV = @MaGV AND TNCKH.NamHoc = @NamHocHienTai
        ), 0) AS TongGioNCKH,
        ISNULL((
            SELECT SUM(CTKT.SoGioQuyChuan)
            FROM ChiTietTaiKhaoThi CTKT
            INNER JOIN TaiKhaoThi TKT ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
            WHERE CTKT.MaGV = @MaGV AND TKT.NamHoc = @NamHocHienTai
        ), 0) AS TongGioKhaoThi,
        ISNULL((
            SELECT SUM(TG.SoGio)
            FROM ThamGia TG
            INNER JOIN TaiHoiDong THD ON TG.MaHoiDong = THD.MaHoiDong
            WHERE TG.MaGV = @MaGV AND THD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioHoiDong,
        ISNULL((
            SELECT SUM(TGHD.SoGio)
            FROM ThamGiaHuongDan TGHD
            INNER JOIN TaiHuongDan THD ON TGHD.MaHuongDan = THD.MaHuongDan
            WHERE TGHD.MaGV = @MaGV AND THD.NamHoc = @NamHocHienTai
        ), 0) AS TongGioHuongDan;
    
    -- Danh sách học phần đang giảng dạy
    SELECT 
        TGD.TenHocPhan,
        TGD.Lop,
        TGD.SoTinChi,
        CTGD.SoTiet,
        CTGD.SoTietQuyDoi
    FROM ChiTietGiangDay CTGD
    INNER JOIN TaiGiangDay TGD ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE CTGD.MaGV = @MaGV AND TGD.NamHoc = @NamHocHienTai
    ORDER BY TGD.TenHocPhan;
    
    -- Danh sách công trình NCKH
    SELECT 
        TNCKH.TenCongTrinhKhoaHoc,
        LNCKH.TenLoaiNCKH,
        CTNCKH.VaiTro,
        CTNCKH.SoGio
    FROM ChiTietNCKH CTNCKH
    INNER JOIN TaiNCKH TNCKH ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    INNER JOIN LoaiNCKH LNCKH ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
    WHERE CTNCKH.MaGV = @MaGV AND TNCKH.NamHoc = @NamHocHienTai
    ORDER BY TNCKH.TenCongTrinhKhoaHoc;
END;
GO

-- =============================================
-- SECTION 14: UTILITIES VÀ HELPER PROCEDURES
-- =============================================

-- 14.1. Kiểm tra tình trạng database
CREATE OR ALTER PROCEDURE sp_Utility_KiemTraDatabase
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Kiểm tra số lượng bản ghi trong các bảng chính
    SELECT 
        'GiaoVien' AS TenBang,
        COUNT(*) AS SoBanGhi,
        CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END AS TrangThai
    FROM GiaoVien
    UNION ALL
    SELECT 'Khoa', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM Khoa
    UNION ALL
    SELECT 'BoMon', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM BoMon
    UNION ALL
    SELECT 'NguoiDung', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM NguoiDung
    UNION ALL
    SELECT 'TaiGiangDay', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM TaiGiangDay
    UNION ALL
    SELECT 'TaiNCKH', COUNT(*), CASE WHEN COUNT(*) > 0 THEN N'OK' ELSE N'Rỗng' END FROM TaiNCKH
    ORDER BY TenBang;
    
    -- Kiểm tra các foreign key constraint
    SELECT 
        fk.name AS ForeignKeyName,
        tp.name AS ParentTable,
        cp.name AS ParentColumn,
        tr.name AS ReferencedTable,
        cr.name AS ReferencedColumn,
        CASE fk.is_disabled WHEN 0 THEN N'Hoạt động' ELSE N'Vô hiệu' END AS TrangThai
    FROM sys.foreign_keys fk
    INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
    INNER JOIN sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
    ORDER BY tp.name, fk.name;
END;
GO

-- 14.2. Backup dữ liệu
CREATE OR ALTER PROCEDURE sp_Utility_BackupData
    @TableName NVARCHAR(100),
    @BackupTableName NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Generate backup table name if not provided
        IF @BackupTableName IS NULL
            SET @BackupTableName = @TableName + '_Backup_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');
        
        -- Create backup table
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = 'SELECT * INTO ' + QUOTENAME(@BackupTableName) + ' FROM ' + QUOTENAME(@TableName);
        
        EXEC sp_executesql @SQL;
        
        -- Get row count
        DECLARE @RowCount INT;
        SET @SQL = 'SELECT @Count = COUNT(*) FROM ' + QUOTENAME(@BackupTableName);
        EXEC sp_executesql @SQL, N'@Count INT OUTPUT', @Count = @RowCount OUTPUT;
        
        PRINT N'Backup thành công. Tên bảng: ' + @BackupTableName + ', Số dòng: ' + CAST(@RowCount AS NVARCHAR(10));
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        THROW;
    END CATCH
END;
GO

-- 14.3. Khởi tạo dữ liệu mẫu cho demo
CREATE OR ALTER PROCEDURE sp_Utility_TaoDuLieuMau
    @SoLuongGiaoVien INT = 10,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @i INT = 1;
        DECLARE @MaGV CHAR(15);
        DECLARE @MaKhoa CHAR(15);
        DECLARE @MaBM CHAR(15);
        
        -- Tạo giáo viên mẫu
        WHILE @i <= @SoLuongGiaoVien
        BEGIN
            -- Get random BoMon
            SELECT TOP 1 @MaBM = MaBM FROM BoMon ORDER BY NEWID();
            
            -- Create teacher
            EXEC sp_GiaoVien_ThemMoi
                @HoTen = N'Giáo viên mẫu',
                @NgaySinh = '1980-01-01',
                @GioiTinh = 1,
                @QueQuan = N'Hà Nội',
                @DiaChi = N'Địa chỉ mẫu',
                @SDT = 900000000,
                @Email = 'demo@school.edu.vn',
                @MaBM = @MaBM,
                @MaGV = @MaGV OUTPUT,
                @ErrorMessage = @ErrorMessage OUTPUT;
            
            -- Update name and email
            UPDATE GiaoVien 
            SET HoTen = N'Giáo viên mẫu ' + CAST(@i AS NVARCHAR(10)),
                Email = 'demo' + CAST(@i AS VARCHAR(10)) + '@school.edu.vn',
                SDT = 900000000 + @i
            WHERE MaGV = @MaGV;
            
            -- Create user account
            EXEC sp_NguoiDung_TaoTaiKhoan
                @TenDangNhap = 'demo',
                @MatKhau = 'demo123',
                @MaGV = @MaGV,
                @MaNhom = 'NHOM004',
                @MaNguoiDung = NULL,
                @ErrorMessage = @ErrorMessage;
            
            -- Update username
            UPDATE NguoiDung 
            SET TenDangNhap = 'demo' + CAST(@i AS VARCHAR(10))
            WHERE MaGV = @MaGV;
            
            SET @i = @i + 1;
        END
        
        SET @ErrorMessage = N'Tạo dữ liệu mẫu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 14.4. Xóa dữ liệu mẫu
CREATE OR ALTER PROCEDURE sp_Utility_XoaDuLieuMau
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Delete demo data
        DELETE FROM NguoiDung WHERE TenDangNhap LIKE 'demo%';
        DELETE FROM ChiTietGiangDay WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ChiTietNCKH WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ChiTietTaiKhaoThi WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ThamGia WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM ThamGiaHuongDan WHERE MaGV IN (SELECT MaGV FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn');
        DELETE FROM GiaoVien WHERE Email LIKE 'demo%@school.edu.vn';
        
        SET @ErrorMessage = N'Xóa dữ liệu mẫu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 15: LÝ LỊCH KHOA HỌC
-- =============================================

-- 15.1. Cập nhật lý lịch khoa học
CREATE OR ALTER PROCEDURE sp_LyLichKhoaHoc_CapNhat
    @MaGV CHAR(15),
    @HeDaoTaoDH NVARCHAR(100),
    @NoiDaoTaoDH NVARCHAR(100),
    @NganhHocDH NVARCHAR(100),
    @NuocDaoTaoDH NVARCHAR(100),
    @NamTotNghiepDH INT,
    @ThacSiChuyenNganh NVARCHAR(100) = NULL,
    @NamCapBangTS INT = NULL,
    @NoiDaoTaoTS NVARCHAR(100) = NULL,
    @TenLuanVanTotNghiep NVARCHAR(200) = NULL,
    @TienSiChuyenNganh NVARCHAR(100) = NULL,
    @NamCapBangSauDH INT = NULL,
    @NoiDaoTaoSauDH NVARCHAR(100) = NULL,
    @TenLuanAnSauDH NVARCHAR(200) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WHERE MaGV = @MaGV)
            THROW 50260, N'Mã giáo viên không tồn tại', 1;
            
        IF @NamTotNghiepDH < 1950 OR @NamTotNghiepDH > YEAR(GETDATE())
            THROW 50261, N'Năm tốt nghiệp đại học không hợp lệ', 1;
        
        -- Check if record exists
        IF EXISTS (SELECT 1 FROM LyLichKhoaHoc WHERE MaGV = @MaGV)
        BEGIN
            -- Update existing
            UPDATE LyLichKhoaHoc
            SET HeDaoTaoDH = @HeDaoTaoDH,
                NoiDaoTaoDH = @NoiDaoTaoDH,
                NganhHocDH = @NganhHocDH,
                NuocDaoTaoDH = @NuocDaoTaoDH,
                NamTotNghiepDH = @NamTotNghiepDH,
                ThacSiChuyenNganh = @ThacSiChuyenNganh,
                NamCapBangTS = @NamCapBangTS,
                NoiDaoTaoTS = @NoiDaoTaoTS,
                TenLuanVanTotNghiep = @TenLuanVanTotNghiep,
                TienSiChuyenNganh = @TienSiChuyenNganh,
                NamCapBangSauDH = @NamCapBangSauDH,
                NoiDaoTaoSauDH = @NoiDaoTaoSauDH,
                TenLuanAnSauDH = @TenLuanAnSauDH,
                NgayKhai = GETDATE()
            WHERE MaGV = @MaGV;
        END
        ELSE
        BEGIN
            -- Generate MaLyLichKhoaHoc
            DECLARE @MaLyLichKhoaHoc CHAR(15);
            DECLARE @Count INT;
            SELECT @Count = COUNT(*) + 1 FROM LyLichKhoaHoc;
            SET @MaLyLichKhoaHoc = 'LLKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
            
            -- Get teacher name
            DECLARE @NguoiKhai NVARCHAR(100);
            SELECT @NguoiKhai = HoTen FROM GiaoVien WHERE MaGV = @MaGV;
            
            -- Insert new
            INSERT INTO LyLichKhoaHoc (
                MaLyLichKhoaHoc, HeDaoTaoDH, NoiDaoTaoDH, NganhHocDH, NuocDaoTaoDH, 
                NamTotNghiepDH, ThacSiChuyenNganh, NamCapBangTS, NoiDaoTaoTS, 
                TenLuanVanTotNghiep, TienSiChuyenNganh, NamCapBangSauDH, NoiDaoTaoSauDH, 
                TenLuanAnSauDH, NguoiKhai, NgayKhai, MaGV
            )
            VALUES (
                @MaLyLichKhoaHoc, @HeDaoTaoDH, @NoiDaoTaoDH, @NganhHocDH, @NuocDaoTaoDH,
                @NamTotNghiepDH, @ThacSiChuyenNganh, @NamCapBangTS, @NoiDaoTaoTS,
                @TenLuanVanTotNghiep, @TienSiChuyenNganh, @NamCapBangSauDH, @NoiDaoTaoSauDH,
                @TenLuanAnSauDH, @NguoiKhai, GETDATE(), @MaGV
            );
        END
        
        SET @ErrorMessage = N'Cập nhật lý lịch khoa học thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- =============================================
-- SECTION 16: ĐỊNH MỨC VÀ MIỄN GIẢM
-- =============================================

-- 16.1. Cập nhật định mức miễn giảm
CREATE OR ALTER PROCEDURE sp_DinhMucMienGiam_CapNhat
    @MaChucVu CHAR(15),
    @MaDinhMucMienGiam CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate
        IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaChucVu = @MaChucVu)
            THROW 50270, N'Mã chức vụ không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DinhMucMienGiam WHERE MaDinhMucMienGiam = @MaDinhMucMienGiam)
            THROW 50271, N'Mã định mức miễn giảm không tồn tại', 1;
        
        -- Update
        UPDATE ChucVu
        SET MaDinhMucMienGiam = @MaDinhMucMienGiam
        WHERE MaChucVu = @MaChucVu;
        
        SET @ErrorMessage = N'Cập nhật định mức miễn giảm thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- 16.2. Tính toán định mức thực tế
CREATE OR ALTER PROCEDURE sp_DinhMuc_TinhToan
    @MaGV CHAR(15),
    @DinhMucGiangDay INT OUTPUT,
    @DinhMucNCKH INT OUTPUT,
    @TyLeMienGiam FLOAT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get base quotas
    SELECT 
        @DinhMucGiangDay = ISNULL((
            SELECT TOP 1 DMGD.DinhMucGiangDay
            FROM LichSuHocHam LSHH
            INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
            INNER JOIN DinhMucGiangDay DMGD ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
            WHERE LSHH.MaGV = @MaGV
            ORDER BY LSHH.NgayNhan DESC
        ), 320),
        @DinhMucNCKH = ISNULL((
            SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
            FROM LichSuHocHam LSHH
            INNER JOIN HocHam HH ON LSHH.MaHocHam = HH.MaHocHam
            INNER JOIN DinhMucNghienCuu DMNC ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
            WHERE LSHH.MaGV = @MaGV
            ORDER BY LSHH.NgayNhan DESC
        ), 300);
    
    -- Get reduction rate
    SET @TyLeMienGiam = ISNULL((
        SELECT TOP 1 DMMG.TyLeMienGiam
        FROM LichSuChucVu LSCV
        INNER JOIN ChucVu CV ON LSCV.MaChucVu = CV.MaChucVu
        INNER JOIN DinhMucMienGiam DMMG ON CV.MaDinhMucMienGiam = DMMG.MaDinhMucMienGiam
        WHERE LSCV.MaGV = @MaGV AND LSCV.NgayKetThuc IS NULL
        ORDER BY DMMG.TyLeMienGiam DESC
    ), 0);
    
    -- Apply reduction
    SET @DinhMucGiangDay = @DinhMucGiangDay * (1 - @TyLeMienGiam);
    SET @DinhMucNCKH = @DinhMucNCKH * (1 - @TyLeMienGiam);
END;
GO

-- =============================================
-- Hoàn tất cài đặt Stored Procedures
-- =============================================
PRINT N'Đã hoàn tất cài đặt tất cả Stored Procedures cho hệ thống Quản lý Giáo viên';
GO