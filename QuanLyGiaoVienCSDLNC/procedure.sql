-- =============================================
-- HỆ THỐNG STORED PROCEDURES QUẢN LÝ GIÁO VIÊN
-- Version: 3.0
-- Cập nhật: 2024
-- Mô tả: Bộ stored procedures đầy đủ với transaction và locking
-- =============================================

USE QLGiaoVienFinal;
GO

-- =============================================
-- SECTION 1: QUẢN LÝ GIÁO VIÊN
-- =============================================

-- 1.1. Thêm mới giáo viên
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
        
        -- Validation với UPDLOCK để tránh duplicate
        IF EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE Email = @Email)
            THROW 50001, N'Email đã tồn tại trong hệ thống', 1;
            
        IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
            THROW 50002, N'Họ tên không được để trống', 1;
            
        IF @NgaySinh > GETDATE() OR @NgaySinh < DATEADD(YEAR, -70, GETDATE())
            THROW 50003, N'Ngày sinh không hợp lệ', 1;
            
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50004, N'Email không đúng định dạng', 1;
            
        IF @SDT < 100000000 OR @SDT > 999999999
            THROW 50005, N'Số điện thoại phải có 9 chữ số', 1;
            
        -- Kiểm tra bộ môn tồn tại với SLOCK
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (NOLOCK) WHERE MaBM = @MaBM)
            THROW 50006, N'Mã bộ môn không tồn tại', 1;
        
        -- Tạo mã giáo viên với XLOCK
        DECLARE @NextId INT;
        IF NOT EXISTS (SELECT 1 FROM SequenceGenerator WHERE TableName = 'GiaoVien')
            INSERT INTO SequenceGenerator (TableName, LastSequence) VALUES ('GiaoVien', 0);
            
        UPDATE SequenceGenerator WITH (XLOCK)
        SET @NextId = LastSequence = LastSequence + 1
        WHERE TableName = 'GiaoVien';
        
        SET @MaGV = 'GV' + RIGHT('000' + CAST(@NextId AS VARCHAR(4)), 4);
        
        -- Thêm giáo viên
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
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50010, N'Mã giáo viên không tồn tại', 1;
            
        -- Validation
        IF @Email NOT LIKE '%_@__%.__%'
            THROW 50011, N'Email không đúng định dạng', 1;
            
        IF EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE Email = @Email AND MaGV != @MaGV)
            THROW 50012, N'Email đã được sử dụng bởi giáo viên khác', 1;
            
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (NOLOCK) WHERE MaBM = @MaBM)
            THROW 50013, N'Mã bộ môn không tồn tại', 1;
        
        -- Cập nhật
        UPDATE GiaoVien WITH (XLOCK)
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            QueQuan = @QueQuan,
            DiaChi = @DiaChi,
            SDT = @SDT,
            Email = @Email,
            MaBM = @MaBM
        WHERE MaGV = @MaGV;
        
        SET @ErrorMessage = N'Cập nhật thông tin giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_GiaoVien_Xoa
    @MaGV CHAR(15),
    @ForceDelete BIT = 0,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            SET @ErrorMessage = N'Mã giáo viên không tồn tại';
            THROW 50020, N'Mã giáo viên không tồn tại', 1;
        END
        
        -- Kiểm tra ràng buộc
        DECLARE @Dependencies NVARCHAR(MAX) = '';
        
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WITH (NOLOCK) WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'Giảng dạy, ';
            
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WITH (NOLOCK) WHERE MaGV = @MaGV)
            SET @Dependencies = @Dependencies + N'NCKH, ';
            
        IF EXISTS (SELECT 1 FROM Khoa WITH (NOLOCK) WHERE MaChuNhiemKhoa = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm khoa, ';
            
        IF EXISTS (SELECT 1 FROM BoMon WITH (NOLOCK) WHERE MaChuNhiemBM = @MaGV)
            SET @Dependencies = @Dependencies + N'Chủ nhiệm bộ môn, ';
        
        IF LEN(@Dependencies) > 0 AND @ForceDelete = 0
        BEGIN
            SET @Dependencies = LEFT(@Dependencies, LEN(@Dependencies) - 2);
            SET @ErrorMessage = N'Không thể xóa vì giáo viên đang có liên kết: ' + @Dependencies;
            THROW 50021, @ErrorMessage, 1;
        END
        
        -- Xóa cascade nếu force delete
        IF @ForceDelete = 1
        BEGIN
            UPDATE Khoa WITH (ROWLOCK, UPDLOCK) SET MaChuNhiemKhoa = NULL WHERE MaChuNhiemKhoa = @MaGV;
            UPDATE BoMon WITH (ROWLOCK, UPDLOCK) SET MaChuNhiemBM = NULL WHERE MaChuNhiemBM = @MaGV;
            DELETE FROM ChiTietGiangDay WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM ChiTietNCKH WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM ChiTietTaiKhaoThi WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM ThamGia WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM ThamGiaHuongDan WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM LichSuChucVu WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM LichSuHocHam WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM HocVi WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM QuanHam WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM LyLichKhoaHoc WITH (ROWLOCK) WHERE MaGV = @MaGV;
            DELETE FROM NguoiDung WITH (ROWLOCK) WHERE MaGV = @MaGV;
        END
        
        DELETE FROM GiaoVien WITH (ROWLOCK) WHERE MaGV = @MaGV;
        
        SET @ErrorMessage = N'Xóa giáo viên thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        IF @ErrorMessage IS NULL OR @ErrorMessage = ''
            SET @ErrorMessage = N'Lỗi không xác định khi xóa giáo viên';
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
    
    -- Đếm tổng số bản ghi
    SELECT @TotalRecords = COUNT(DISTINCT GV.MaGV)
    FROM GiaoVien GV WITH (NOLOCK)
    INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K WITH (NOLOCK) ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN HocVi HV WITH (NOLOCK) ON GV.MaGV = HV.MaGV
    LEFT JOIN LichSuHocHam LSHH WITH (NOLOCK) ON GV.MaGV = LSHH.MaGV
    WHERE (@SearchText IS NULL OR 
           GV.HoTen LIKE N'%' + @SearchText + '%' OR 
           GV.Email LIKE '%' + @SearchText + '%' OR
           GV.MaGV LIKE '%' + @SearchText + '%')
      AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
      AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
      AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
      AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam);
    
    -- Trả về kết quả phân trang
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
            (SELECT STRING_AGG(TenHocVi, ', ') 
             FROM HocVi WHERE MaGV = GV.MaGV) AS DanhSachHocVi,
            (SELECT TOP 1 TenHocHam 
             FROM LichSuHocHam WHERE MaGV = GV.MaGV 
             ORDER BY NgayNhan DESC) AS HocHamCaoNhat,
            ROW_NUMBER() OVER (ORDER BY GV.HoTen) AS RowNum
        FROM GiaoVien GV WITH (NOLOCK)
        INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
        INNER JOIN Khoa K WITH (NOLOCK) ON BM.MaKhoa = K.MaKhoa
        LEFT JOIN HocVi HV WITH (NOLOCK) ON GV.MaGV = HV.MaGV
        LEFT JOIN LichSuHocHam LSHH WITH (NOLOCK) ON GV.MaGV = LSHH.MaGV
        WHERE (@SearchText IS NULL OR 
               GV.HoTen LIKE N'%' + @SearchText + '%' OR 
               GV.Email LIKE '%' + @SearchText + '%' OR
               GV.MaGV LIKE '%' + @SearchText + '%')
          AND (@MaKhoa IS NULL OR K.MaKhoa = @MaKhoa)
          AND (@MaBM IS NULL OR BM.MaBM = @MaBM)
          AND (@HocVi IS NULL OR HV.TenHocVi = @HocVi)
          AND (@HocHam IS NULL OR LSHH.TenHocHam = @HocHam)
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO


-- 1.5. Lấy thông tin chi tiết giáo viên
CREATE OR ALTER PROCEDURE sp_GiaoVien_ChiTiet
    @MaGV CHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thông tin cơ bản
    SELECT 
        GV.MaGV,
        GV.HoTen,
        GV.NgaySinh,
        CASE GV.GioiTinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END AS GioiTinh,
        GV.QueQuan,
        GV.DiaChi,
        GV.SDT,
        GV.Email,
        BM.MaBM,
        BM.TenBM,
        K.MaKhoa,
        K.TenKhoa
    FROM GiaoVien GV WITH (NOLOCK)
    INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K WITH (NOLOCK) ON BM.MaKhoa = K.MaKhoa
    WHERE GV.MaGV = @MaGV;
    
    -- Học vị
    SELECT MaHocVi, TenHocVi, NgayNhan
    FROM HocVi WITH (NOLOCK)
    WHERE MaGV = @MaGV
    ORDER BY NgayNhan DESC;
    
    -- Học hàm
    SELECT LSHH.MaLSHocHam, LSHH.TenHocHam, LSHH.NgayNhan, HH.TenHocHam AS TenHocHamChinhThuc
    FROM LichSuHocHam LSHH WITH (NOLOCK)
    LEFT JOIN HocHam HH WITH (NOLOCK) ON LSHH.MaHocHam = HH.MaHocHam
    WHERE LSHH.MaGV = @MaGV
    ORDER BY LSHH.NgayNhan DESC;
    
    -- Chức vụ hiện tại
    SELECT 
        CV.MaChucVu,
        CV.TenChucVu,
        LSCV.NgayNhan
    FROM LichSuChucVu LSCV WITH (NOLOCK)
    INNER JOIN ChucVu CV WITH (NOLOCK) ON LSCV.MaChucVu = CV.MaChucVu
    WHERE LSCV.MaGV = @MaGV AND LSCV.NgayKetThuc IS NULL;
    
    -- Lý lịch khoa học
    SELECT *
    FROM LyLichKhoaHoc WITH (NOLOCK)
    WHERE MaGV = @MaGV;
END;
GO

-- =============================================
-- SECTION 2: QUẢN LÝ KHOA
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
        
        -- Validation với UPDLOCK
        IF EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE TenKhoa = @TenKhoa)
            THROW 50030, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL 
            AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaChuNhiemKhoa)
            THROW 50031, N'Mã chủ nhiệm khoa không tồn tại', 1;
        
        -- Tạo mã khoa
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM Khoa WITH (XLOCK);
        SET @MaKhoa = 'KHOA' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm khoa
        INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, MaChuNhiemKhoa)
        VALUES (@MaKhoa, @TenKhoa, @DiaChi, @MaChuNhiemKhoa);
        
        SET @ErrorMessage = N'Thêm khoa thành công. Mã khoa: ' + @MaKhoa;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaKhoa = NULL;
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
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
            THROW 50040, N'Mã khoa không tồn tại', 1;
            
        -- Validate trùng tên
        IF EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE TenKhoa = @TenKhoa AND MaKhoa != @MaKhoa)
            THROW 50041, N'Tên khoa đã tồn tại', 1;
            
        IF @MaChuNhiemKhoa IS NOT NULL 
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaChuNhiemKhoa)
                THROW 50042, N'Mã chủ nhiệm khoa không tồn tại', 1;
                
            -- Kiểm tra giáo viên thuộc khoa
            IF NOT EXISTS (
                SELECT 1 FROM GiaoVien GV WITH (NOLOCK)
                INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
                WHERE GV.MaGV = @MaChuNhiemKhoa AND BM.MaKhoa = @MaKhoa
            )
                THROW 50043, N'Giáo viên không thuộc khoa này', 1;
        END
        
        -- Cập nhật
        UPDATE Khoa WITH (XLOCK)
        SET TenKhoa = @TenKhoa,
            DiaChi = @DiaChi,
            MaChuNhiemKhoa = @MaChuNhiemKhoa
        WHERE MaKhoa = @MaKhoa;
        
        SET @ErrorMessage = N'Cập nhật khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
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
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (UPDLOCK) WHERE MaKhoa = @MaKhoa)
            THROW 50050, N'Mã khoa không tồn tại', 1;
            
        -- Kiểm tra ràng buộc
        IF EXISTS (SELECT 1 FROM BoMon WITH (NOLOCK) WHERE MaKhoa = @MaKhoa)
            THROW 50051, N'Không thể xóa khoa vì còn bộ môn trực thuộc', 1;
        
        DELETE FROM Khoa WITH (XLOCK) WHERE MaKhoa = @MaKhoa;
        
        SET @ErrorMessage = N'Xóa khoa thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 2.4. Danh sách khoa
CREATE OR ALTER PROCEDURE sp_Khoa_DanhSach
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        K.MaKhoa,
        K.TenKhoa,
        K.DiaChi,
        K.MaChuNhiemKhoa,
        GV.HoTen AS TenChuNhiemKhoa,
        (SELECT COUNT(*) FROM BoMon WHERE MaKhoa = K.MaKhoa) AS SoBoMon,
        (SELECT COUNT(*) FROM GiaoVien GV2 
         INNER JOIN BoMon BM ON GV2.MaBM = BM.MaBM 
         WHERE BM.MaKhoa = K.MaKhoa) AS SoGiaoVien
    FROM Khoa K WITH (NOLOCK)
    LEFT JOIN GiaoVien GV WITH (NOLOCK) ON K.MaChuNhiemKhoa = GV.MaGV
    ORDER BY K.TenKhoa;
END;
GO

-- =============================================
-- SECTION 3: QUẢN LÝ BỘ MÔN
-- =============================================

-- 3.1. Thêm mới bộ môn
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (NOLOCK) WHERE MaKhoa = @MaKhoa)
            THROW 50060, N'Mã khoa không tồn tại', 1;
            
        IF EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa)
            THROW 50061, N'Tên bộ môn đã tồn tại trong khoa', 1;
            
        IF @MaChuNhiemBM IS NOT NULL 
            AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaChuNhiemBM)
            THROW 50062, N'Mã chủ nhiệm bộ môn không tồn tại', 1;
        
        -- Tạo mã bộ môn
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM BoMon WITH (XLOCK);
        SET @MaBM = 'BM' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm bộ môn
        INSERT INTO BoMon (MaBM, TenBM, DiaChi, MaKhoa, MaChuNhiemBM)
        VALUES (@MaBM, @TenBM, @DiaChi, @MaKhoa, @MaChuNhiemBM);
        
        SET @ErrorMessage = N'Thêm bộ môn thành công. Mã bộ môn: ' + @MaBM;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaBM = NULL;
    END CATCH
END;
GO

-- 3.2. Cập nhật bộ môn
CREATE OR ALTER PROCEDURE sp_BoMon_CapNhat
    @MaBM CHAR(15),
    @TenBM NVARCHAR(100),
    @DiaChi NVARCHAR(100),
    @MaKhoa CHAR(15),
    @MaChuNhiemBM CHAR(15) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
            THROW 50070, N'Mã bộ môn không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM Khoa WITH (NOLOCK) WHERE MaKhoa = @MaKhoa)
            THROW 50071, N'Mã khoa không tồn tại', 1;
            
        IF EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) 
                   WHERE TenBM = @TenBM AND MaKhoa = @MaKhoa AND MaBM != @MaBM)
            THROW 50072, N'Tên bộ môn đã tồn tại trong khoa', 1;
            
        IF @MaChuNhiemBM IS NOT NULL 
            AND NOT EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaChuNhiemBM)
            THROW 50073, N'Mã chủ nhiệm bộ môn không tồn tại', 1;
        
        -- Cập nhật
        UPDATE BoMon WITH (XLOCK)
        SET TenBM = @TenBM,
            DiaChi = @DiaChi,
            MaKhoa = @MaKhoa,
            MaChuNhiemBM = @MaChuNhiemBM
        WHERE MaBM = @MaBM;
        
        SET @ErrorMessage = N'Cập nhật bộ môn thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 3.3. Xóa bộ môn
CREATE OR ALTER PROCEDURE sp_BoMon_Xoa
    @MaBM CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM BoMon WITH (UPDLOCK) WHERE MaBM = @MaBM)
            THROW 50080, N'Mã bộ môn không tồn tại', 1;
            
        -- Kiểm tra ràng buộc
        IF EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaBM = @MaBM)
            THROW 50081, N'Không thể xóa bộ môn vì còn giáo viên trực thuộc', 1;
        
        DELETE FROM BoMon WITH (XLOCK) WHERE MaBM = @MaBM;
        
        SET @ErrorMessage = N'Xóa bộ môn thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 3.4. Danh sách bộ môn theo khoa
CREATE OR ALTER PROCEDURE sp_BoMon_DanhSachTheoKhoa
    @MaKhoa CHAR(15) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        BM.MaBM,
        BM.TenBM,
        BM.DiaChi,
        BM.MaKhoa,
        K.TenKhoa,
        BM.MaChuNhiemBM,
        GV.HoTen AS TenChuNhiemBM,
        (SELECT COUNT(*) FROM GiaoVien WHERE MaBM = BM.MaBM) AS SoGiaoVien
    FROM BoMon BM WITH (NOLOCK)
    INNER JOIN Khoa K WITH (NOLOCK) ON BM.MaKhoa = K.MaKhoa
    LEFT JOIN GiaoVien GV WITH (NOLOCK) ON BM.MaChuNhiemBM = GV.MaGV
    WHERE (@MaKhoa IS NULL OR BM.MaKhoa = @MaKhoa)
    ORDER BY K.TenKhoa, BM.TenBM;
END;
GO

-- =============================================
-- SECTION 4: QUẢN LÝ GIẢNG DẠY
-- =============================================

-- 4.1. Thêm mới tài giảng dạy
CREATE OR ALTER PROCEDURE sp_TaiGiangDay_ThemMoi
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
        
        -- Validation
        IF @SiSo <= 0 OR @SiSo > 500
            THROW 50090, N'Sĩ số không hợp lệ (1-500)', 1;
            
        IF @SoTinChi <= 0 OR @SoTinChi > 10
            THROW 50091, N'Số tín chỉ không hợp lệ (1-10)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay WITH (NOLOCK) WHERE MaDoiTuong = @MaDoiTuong)
            THROW 50092, N'Mã đối tượng giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay WITH (NOLOCK) WHERE MaThoiGian = @MaThoiGian)
            THROW 50093, N'Mã thời gian giảng dạy không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay WITH (NOLOCK) WHERE MaNgonNgu = @MaNgonNgu)
            THROW 50094, N'Mã ngôn ngữ giảng dạy không tồn tại', 1;
        
        -- Tạo mã tài giảng dạy
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiGiangDay WITH (XLOCK);
        SET @MaTaiGiangDay = 'TGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm tài giảng dạy
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
    END CATCH
END;
GO

-- 4.2. Phân công giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_PhanCong
    @MaGV CHAR(15),
    @MaTaiGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @NoiDungGiangDay nvarchar(200),
    @CheckConflict BIT = 1,
    @MaChiTietGiangDay CHAR(15) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validation với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50100, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiGiangDay WITH (UPDLOCK) WHERE MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50101, N'Mã tài giảng dạy không tồn tại', 1;
            
        IF @SoTiet <= 0 OR @SoTiet > 200
            THROW 50102, N'Số tiết không hợp lệ (1-200)', 1;
        
        -- Kiểm tra đã phân công chưa
        IF EXISTS (SELECT 1 FROM ChiTietGiangDay WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaTaiGiangDay = @MaTaiGiangDay)
            THROW 50103, N'Giáo viên đã được phân công cho học phần này', 1;
        
        -- Kiểm tra lịch trùng
        IF @CheckConflict = 1
        BEGIN
            DECLARE @MaThoiGian CHAR(15), @NamHoc NVARCHAR(20);
            SELECT @MaThoiGian = MaThoiGian, @NamHoc = NamHoc 
            FROM TaiGiangDay WITH (NOLOCK) WHERE MaTaiGiangDay = @MaTaiGiangDay;
            
            IF EXISTS (
                SELECT 1 FROM ChiTietGiangDay CTGD WITH (NOLOCK)
                INNER JOIN TaiGiangDay TGD WITH (NOLOCK) ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
                WHERE CTGD.MaGV = @MaGV 
                    AND TGD.MaThoiGian = @MaThoiGian 
                    AND TGD.NamHoc = @NamHoc
                    AND TGD.MaTaiGiangDay != @MaTaiGiangDay
            )
                THROW 50104, N'Giáo viên có lịch trùng trong thời gian này', 1;
        END
        
        -- Tính số tiết quy đổi
        DECLARE @HeSoDoiTuong FLOAT = 1, @HeSoThoiGian FLOAT = 1, @HeSoNgonNgu FLOAT = 1;
        
        SELECT 
            @HeSoDoiTuong = DT.HeSoQuyChuan,
            @HeSoThoiGian = TG.HeSoQuyChuan,
            @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD WITH (NOLOCK)
        INNER JOIN DoiTuongGiangDay DT WITH (NOLOCK) ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG WITH (NOLOCK) ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN WITH (NOLOCK) ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;
        
        DECLARE @SoTietQuyDoi FLOAT = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;
        
        -- Tạo mã chi tiết giảng dạy
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietGiangDay WITH (XLOCK);
        SET @MaChiTietGiangDay = 'CTGD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm chi tiết giảng dạy
        INSERT INTO ChiTietGiangDay (MaChiTietGiangDay, SoTiet, SoTietQuyDoi, GhiChu, 
                                    MaGV, MaTaiGiangDay, NoiDungGiangDay)
        VALUES (@MaChiTietGiangDay, @SoTiet, @SoTietQuyDoi, @GhiChu, 
                @MaGV, @MaTaiGiangDay, @NoiDungGiangDay);
        
        SET @ErrorMessage = N'Phân công giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaChiTietGiangDay = NULL;
    END CATCH
END;
GO

-- 4.3. Cập nhật chi tiết giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_CapNhat
    @MaChiTietGiangDay CHAR(15),
    @SoTiet INT,
    @GhiChu NVARCHAR(200),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ChiTietGiangDay WITH (UPDLOCK) WHERE MaChiTietGiangDay = @MaChiTietGiangDay)
            THROW 50110, N'Mã chi tiết giảng dạy không tồn tại', 1;
            
        IF @SoTiet <= 0 OR @SoTiet > 200
            THROW 50111, N'Số tiết không hợp lệ (1-200)', 1;
        
        -- Tính lại số tiết quy đổi
        DECLARE @HeSoDoiTuong FLOAT = 1, @HeSoThoiGian FLOAT = 1, @HeSoNgonNgu FLOAT = 1;
        DECLARE @MaTaiGiangDay CHAR(15);
        
        SELECT @MaTaiGiangDay = MaTaiGiangDay 
        FROM ChiTietGiangDay WITH (NOLOCK) 
        WHERE MaChiTietGiangDay = @MaChiTietGiangDay;
        
        SELECT 
            @HeSoDoiTuong = DT.HeSoQuyChuan,
            @HeSoThoiGian = TG.HeSoQuyChuan,
            @HeSoNgonNgu = NN.HeSoQuyChuan
        FROM TaiGiangDay TGD WITH (NOLOCK)
        INNER JOIN DoiTuongGiangDay DT WITH (NOLOCK) ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG WITH (NOLOCK) ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN WITH (NOLOCK) ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE TGD.MaTaiGiangDay = @MaTaiGiangDay;
        
        DECLARE @SoTietQuyDoi FLOAT = @SoTiet * @HeSoDoiTuong * @HeSoThoiGian * @HeSoNgonNgu;
        
        -- Cập nhật
        UPDATE ChiTietGiangDay WITH (XLOCK)
        SET SoTiet = @SoTiet,
            SoTietQuyDoi = @SoTietQuyDoi,
            GhiChu = @GhiChu
        WHERE MaChiTietGiangDay = @MaChiTietGiangDay;
        
        SET @ErrorMessage = N'Cập nhật chi tiết giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 4.4. Xóa phân công giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_XoaPhanCong
    @MaChiTietGiangDay CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ChiTietGiangDay WITH (UPDLOCK) WHERE MaChiTietGiangDay = @MaChiTietGiangDay)
            THROW 50120, N'Mã chi tiết giảng dạy không tồn tại', 1;
        
        DELETE FROM ChiTietGiangDay WITH (XLOCK) WHERE MaChiTietGiangDay = @MaChiTietGiangDay;
        
        SET @ErrorMessage = N'Xóa phân công giảng dạy thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 4.5. Danh sách giảng dạy
CREATE OR ALTER PROCEDURE sp_GiangDay_DanhSach
    @MaGV CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Đếm tổng số bản ghi
    SELECT @TotalRecords = COUNT(*)
    FROM ChiTietGiangDay CTGD WITH (NOLOCK)
    INNER JOIN GiaoVien GV WITH (NOLOCK) ON CTGD.MaGV = GV.MaGV
    INNER JOIN TaiGiangDay TGD WITH (NOLOCK) ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE (@MaGV IS NULL OR CTGD.MaGV = @MaGV)
      AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc);
    
    -- Trả về kết quả phân trang
    WITH CTE AS (
        SELECT 
            CTGD.MaChiTietGiangDay,
            GV.MaGV,
            GV.HoTen,
            TGD.MaTaiGiangDay,
            TGD.TenHocPhan,
            TGD.Lop,
            TGD.SiSo,
            TGD.SoTinChi,
            TGD.He,
            TGD.NamHoc,
            CTGD.SoTiet,
            CTGD.SoTietQuyDoi,
            CTGD.GhiChu,
            DT.TenDoiTuong,
            TG.TenThoiGian,
            NN.TenNgonNgu,
            ROW_NUMBER() OVER (ORDER BY TGD.NamHoc DESC, GV.HoTen, TGD.TenHocPhan) AS RowNum
        FROM ChiTietGiangDay CTGD WITH (NOLOCK)
        INNER JOIN GiaoVien GV WITH (NOLOCK) ON CTGD.MaGV = GV.MaGV
        INNER JOIN TaiGiangDay TGD WITH (NOLOCK) ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        INNER JOIN DoiTuongGiangDay DT WITH (NOLOCK) ON TGD.MaDoiTuong = DT.MaDoiTuong
        INNER JOIN ThoiGianGiangDay TG WITH (NOLOCK) ON TGD.MaThoiGian = TG.MaThoiGian
        INNER JOIN NgonNguGiangDay NN WITH (NOLOCK) ON TGD.MaNgonNgu = NN.MaNgonNgu
        WHERE (@MaGV IS NULL OR CTGD.MaGV = @MaGV)
          AND (@NamHoc IS NULL OR TGD.NamHoc = @NamHoc)
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 5: QUẢN LÝ NGHIÊN CỨU KHOA HỌC
-- =============================================

-- 5.1. Thêm mới tài NCKH
CREATE OR ALTER PROCEDURE sp_TaiNCKH_ThemMoi
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
        
        -- Validation
        IF @SoTacGia <= 0 OR @SoTacGia > 20
            THROW 50130, N'Số tác giả không hợp lệ (1-20)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiNCKH WITH (NOLOCK) WHERE MaLoaiNCKH = @MaLoaiNCKH)
            THROW 50131, N'Mã loại NCKH không tồn tại', 1;
        
        -- Tạo mã tài NCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiNCKH WITH (XLOCK);
        SET @MaTaiNCKH = 'TNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm tài NCKH
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
    END CATCH
END;
GO

-- 5.2. Phân công NCKH
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
        
        -- Validation với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50140, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiNCKH WITH (UPDLOCK) WHERE MaTaiNCKH = @MaTaiNCKH)
            THROW 50141, N'Mã tài NCKH không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 500
            THROW 50142, N'Số giờ không hợp lệ (1-500)', 1;
        
        -- Kiểm tra đã phân công chưa
        IF EXISTS (SELECT 1 FROM ChiTietNCKH WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaTaiNCKH = @MaTaiNCKH)
            THROW 50143, N'Giáo viên đã được phân công cho công trình này', 1;
        
        -- Kiểm tra số tác giả
        DECLARE @SoTacGia INT, @SoTacGiaHienTai INT;
        SELECT @SoTacGia = SoTacGia FROM TaiNCKH WITH (NOLOCK) WHERE MaTaiNCKH = @MaTaiNCKH;
        SELECT @SoTacGiaHienTai = COUNT(*) FROM ChiTietNCKH WITH (NOLOCK) WHERE MaTaiNCKH = @MaTaiNCKH;
        
        IF @SoTacGiaHienTai >= @SoTacGia
            THROW 50144, N'Đã đủ số tác giả cho công trình này', 1;
        
        -- Kiểm tra vai trò chủ nhiệm
        IF @VaiTro = N'Chủ nhiệm' AND EXISTS (
            SELECT 1 FROM ChiTietNCKH WITH (UPDLOCK)
            WHERE MaTaiNCKH = @MaTaiNCKH AND VaiTro = N'Chủ nhiệm'
        )
            THROW 50145, N'Đã có chủ nhiệm cho công trình này', 1;
        
        -- Tạo mã chi tiết NCKH
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietNCKH WITH (XLOCK);
        SET @MaChiTietNCKH = 'CTNCKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm chi tiết NCKH
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
    END CATCH
END;
GO

-- 5.3. Cập nhật chi tiết NCKH
CREATE OR ALTER PROCEDURE sp_NCKH_CapNhat
    @MaChiTietNCKH CHAR(15),
    @VaiTro NVARCHAR(100),
    @SoGio FLOAT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ChiTietNCKH WITH (UPDLOCK) WHERE MaChiTietNCKH = @MaChiTietNCKH)
            THROW 50150, N'Mã chi tiết NCKH không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 500
            THROW 50151, N'Số giờ không hợp lệ (1-500)', 1;
        
        -- Kiểm tra vai trò chủ nhiệm nếu thay đổi
        DECLARE @VaiTroCu NVARCHAR(100), @MaTaiNCKH CHAR(15);
        SELECT @VaiTroCu = VaiTro, @MaTaiNCKH = MaTaiNCKH 
        FROM ChiTietNCKH WITH (NOLOCK) WHERE MaChiTietNCKH = @MaChiTietNCKH;
        
        IF @VaiTro = N'Chủ nhiệm' AND @VaiTroCu != N'Chủ nhiệm'
            AND EXISTS (
                SELECT 1 FROM ChiTietNCKH WITH (UPDLOCK)
                WHERE MaTaiNCKH = @MaTaiNCKH AND VaiTro = N'Chủ nhiệm'
                  AND MaChiTietNCKH != @MaChiTietNCKH
            )
            THROW 50152, N'Đã có chủ nhiệm cho công trình này', 1;
        
        -- Cập nhật
        UPDATE ChiTietNCKH WITH (XLOCK)
        SET VaiTro = @VaiTro,
            SoGio = @SoGio
        WHERE MaChiTietNCKH = @MaChiTietNCKH;
        
        SET @ErrorMessage = N'Cập nhật chi tiết NCKH thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 5.4. Xóa phân công NCKH
CREATE OR ALTER PROCEDURE sp_NCKH_XoaPhanCong
    @MaChiTietNCKH CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ChiTietNCKH WITH (UPDLOCK) WHERE MaChiTietNCKH = @MaChiTietNCKH)
            THROW 50160, N'Mã chi tiết NCKH không tồn tại', 1;
        
        DELETE FROM ChiTietNCKH WITH (XLOCK) WHERE MaChiTietNCKH = @MaChiTietNCKH;
        
        SET @ErrorMessage = N'Xóa phân công NCKH thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 5.5. Danh sách NCKH
CREATE OR ALTER PROCEDURE sp_NCKH_DanhSach
    @MaGV CHAR(15) = NULL,
    @NamHoc NVARCHAR(20) = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @TotalRecords INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Đếm tổng số bản ghi
    SELECT @TotalRecords = COUNT(*)
    FROM ChiTietNCKH CTNCKH WITH (NOLOCK)
    INNER JOIN GiaoVien GV WITH (NOLOCK) ON CTNCKH.MaGV = GV.MaGV
    INNER JOIN TaiNCKH TNCKH WITH (NOLOCK) ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
    WHERE (@MaGV IS NULL OR CTNCKH.MaGV = @MaGV)
      AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc);
    
    -- Trả về kết quả phân trang
    WITH CTE AS (
        SELECT 
            CTNCKH.MaChiTietNCKH,
            GV.MaGV,
            GV.HoTen,
            TNCKH.MaTaiNCKH,
            TNCKH.TenCongTrinhKhoaHoc,
            TNCKH.NamHoc,
            TNCKH.SoTacGia,
            LNCKH.TenLoaiNCKH,
            CTNCKH.VaiTro,
            CTNCKH.SoGio,
            QD.DonViTinh,
            QD.QuyRaGioChuan,
            ROW_NUMBER() OVER (ORDER BY TNCKH.NamHoc DESC, GV.HoTen, TNCKH.TenCongTrinhKhoaHoc) AS RowNum
        FROM ChiTietNCKH CTNCKH WITH (NOLOCK)
        INNER JOIN GiaoVien GV WITH (NOLOCK) ON CTNCKH.MaGV = GV.MaGV
        INNER JOIN TaiNCKH TNCKH WITH (NOLOCK) ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        INNER JOIN LoaiNCKH LNCKH WITH (NOLOCK) ON TNCKH.MaLoaiNCKH = LNCKH.MaLoaiNCKH
        INNER JOIN QuyDoiGioChuanNCKH QD WITH (NOLOCK) ON LNCKH.MaQuyDoi = QD.MaQuyDoi
        WHERE (@MaGV IS NULL OR CTNCKH.MaGV = @MaGV)
          AND (@NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc)
    )
    SELECT * FROM CTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY RowNum;
END;
GO

-- =============================================
-- SECTION 6: QUẢN LÝ KHẢO THÍ
-- =============================================

-- 6.1. Thêm mới tài khảo thí
CREATE OR ALTER PROCEDURE sp_TaiKhaoThi_ThemMoi
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM LoaiCongTacKhaoThi WITH (NOLOCK) WHERE MaLoaiCongTacKhaoThi = @MaLoaiCongTacKhaoThi)
            THROW 50170, N'Mã loại công tác khảo thí không tồn tại', 1;
        
        -- Tạo mã tài khảo thí
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiKhaoThi WITH (XLOCK);
        SET @MaTaiKhaoThi = 'TKT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm tài khảo thí
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
    END CATCH
END;
GO

-- 6.2. Phân công khảo thí
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
        
        -- Validation với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50180, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiKhaoThi WITH (UPDLOCK) WHERE MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50181, N'Mã tài khảo thí không tồn tại', 1;
            
        IF @SoBai <= 0 OR @SoBai > 1000
            THROW 50182, N'Số bài không hợp lệ (1-1000)', 1;
        
        -- Kiểm tra đã phân công chưa
        IF EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaTaiKhaoThi = @MaTaiKhaoThi)
            THROW 50183, N'Giáo viên đã được phân công cho công tác khảo thí này', 1;
        
        -- Tính số giờ quy chuẩn dựa trên loại
        DECLARE @MaLoaiCongTacKhaoThi CHAR(15), @SoGioQuyChuan FLOAT;
        SELECT @MaLoaiCongTacKhaoThi = MaLoaiCongTacKhaoThi FROM TaiKhaoThi WITH (NOLOCK) WHERE MaTaiKhaoThi = @MaTaiKhaoThi;
        
        SET @SoGioQuyChuan = CASE 
            WHEN @MaLoaiCongTacKhaoThi = 'LKT01' THEN @SoBai * 0.5  -- Ra đề
            WHEN @MaLoaiCongTacKhaoThi = 'LKT02' THEN @SoBai * 0.3  -- Coi thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT03' THEN @SoBai * 0.4  -- Chấm thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT04' THEN @SoBai * 0.2  -- Phản biện
            WHEN @MaLoaiCongTacKhaoThi = 'LKT05' THEN @SoBai * 0.3  -- Phúc khảo
            ELSE @SoBai * 0.3
        END;
        
        -- Tạo mã chi tiết khảo thí
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ChiTietTaiKhaoThi WITH (XLOCK);
        SET @MaChiTietTaiKhaoThi = 'CTKT' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm chi tiết khảo thí
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
    END CATCH
END;
GO

-- 6.3. Cập nhật chi tiết khảo thí
CREATE OR ALTER PROCEDURE sp_KhaoThi_CapNhat
    @MaChiTietTaiKhaoThi CHAR(15),
    @SoBai INT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ChiTietTaiKhaoThi WITH (UPDLOCK) WHERE MaChiTietTaiKhaoThi = @MaChiTietTaiKhaoThi)
            THROW 50190, N'Mã chi tiết khảo thí không tồn tại', 1;
            
        IF @SoBai <= 0 OR @SoBai > 1000
            THROW 50191, N'Số bài không hợp lệ (1-1000)', 1;
        
        -- Tính lại số giờ quy chuẩn
        DECLARE @MaLoaiCongTacKhaoThi CHAR(15), @SoGioQuyChuan FLOAT, @MaTaiKhaoThi CHAR(15);
        
        SELECT @MaTaiKhaoThi = MaTaiKhaoThi 
        FROM ChiTietTaiKhaoThi WITH (NOLOCK) 
        WHERE MaChiTietTaiKhaoThi = @MaChiTietTaiKhaoThi;
        
        SELECT @MaLoaiCongTacKhaoThi = MaLoaiCongTacKhaoThi 
        FROM TaiKhaoThi WITH (NOLOCK) WHERE MaTaiKhaoThi = @MaTaiKhaoThi;
        
        SET @SoGioQuyChuan = CASE 
            WHEN @MaLoaiCongTacKhaoThi = 'LKT01' THEN @SoBai * 0.5  -- Ra đề
            WHEN @MaLoaiCongTacKhaoThi = 'LKT02' THEN @SoBai * 0.3  -- Coi thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT03' THEN @SoBai * 0.4  -- Chấm thi
            WHEN @MaLoaiCongTacKhaoThi = 'LKT04' THEN @SoBai * 0.2  -- Phản biện
            WHEN @MaLoaiCongTacKhaoThi = 'LKT05' THEN @SoBai * 0.3  -- Phúc khảo
            ELSE @SoBai * 0.3
        END;
        
        -- Cập nhật
        UPDATE ChiTietTaiKhaoThi WITH (XLOCK)
        SET SoBai = @SoBai,
            SoGioQuyChuan = @SoGioQuyChuan
        WHERE MaChiTietTaiKhaoThi = @MaChiTietTaiKhaoThi;
        
        SET @ErrorMessage = N'Cập nhật chi tiết khảo thí thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- =============================================
-- SECTION 7: QUẢN LÝ HỘI ĐỒNG
-- =============================================

-- 7.1. Thêm mới hội đồng
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
        
        -- Validation
        IF @SoLuong <= 0 OR @SoLuong > 20
            THROW 50200, N'Số lượng thành viên không hợp lệ (1-20)', 1;
            
        IF @ThoiGianBatDau >= @ThoiGianKetThuc
            THROW 50201, N'Thời gian kết thúc phải sau thời gian bắt đầu', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHoiDong WITH (NOLOCK) WHERE MaLoaiHoiDong = @MaLoaiHoiDong)
            THROW 50202, N'Mã loại hội đồng không tồn tại', 1;
        
        -- Tạo mã hội đồng
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHoiDong WITH (XLOCK);
        SET @MaHoiDong = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm hội đồng
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
    END CATCH
END;
GO

-- 7.2. Thêm thành viên hội đồng
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
        
        -- Validation với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50210, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHoiDong WITH (UPDLOCK) WHERE MaHoiDong = @MaHoiDong)
            THROW 50211, N'Mã hội đồng không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 100
            THROW 50212, N'Số giờ không hợp lệ (1-100)', 1;
        
        -- Kiểm tra đã là thành viên chưa
        IF EXISTS (SELECT 1 FROM ThamGia WITH (UPDLOCK) WHERE MaGV = @MaGV AND MaHoiDong = @MaHoiDong)
            THROW 50213, N'Giáo viên đã là thành viên của hội đồng này', 1;
        
        -- Kiểm tra số lượng thành viên tối đa
        DECLARE @SoLuong INT, @SoThanhVienHienTai INT;
        SELECT @SoLuong = SoLuong FROM TaiHoiDong WITH (NOLOCK) WHERE MaHoiDong = @MaHoiDong;
        SELECT @SoThanhVienHienTai = COUNT(*) FROM ThamGia WITH (NOLOCK) WHERE MaHoiDong = @MaHoiDong;
        
        IF @SoThanhVienHienTai >= @SoLuong
            THROW 50214, N'Hội đồng đã đủ số lượng thành viên', 1;
        
        -- Tạo mã tham gia
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGia WITH (XLOCK);
        SET @MaThamGia = 'TG' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm thành viên
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
    END CATCH
END;
GO

-- 7.3. Xóa thành viên hội đồng
CREATE OR ALTER PROCEDURE sp_HoiDong_XoaThanhVien
    @MaThamGia CHAR(15),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra tồn tại với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM ThamGia WITH (UPDLOCK) WHERE MaThamGia = @MaThamGia)
            THROW 50220, N'Mã tham gia không tồn tại', 1;
        
        DELETE FROM ThamGia WITH (XLOCK) WHERE MaThamGia = @MaThamGia;
        
        SET @ErrorMessage = N'Xóa thành viên hội đồng thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- =============================================
-- SECTION 8: QUẢN LÝ HƯỚNG DẪN
-- =============================================

-- 8.1. Thêm mới tài hướng dẫn
CREATE OR ALTER PROCEDURE sp_TaiHuongDan_ThemMoi
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
        
        -- Validation
        IF @SoCBHD <= 0 OR @SoCBHD > 5
            THROW 50230, N'Số cán bộ hướng dẫn không hợp lệ (1-5)', 1;
            
        IF NOT EXISTS (SELECT 1 FROM LoaiHinhHuongDan WITH (NOLOCK) WHERE MaLoaiHinhHuongDan = @MaLoaiHinhHuongDan)
            THROW 50231, N'Mã loại hình hướng dẫn không tồn tại', 1;
        
        -- Tạo mã hướng dẫn
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM TaiHuongDan WITH (XLOCK);
        SET @MaHuongDan = 'HD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm tài hướng dẫn
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
    END CATCH
END;
GO

-- 8.2. Phân công hướng dẫn
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
        
        -- Validation với UPDLOCK
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50240, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM TaiHuongDan WITH (UPDLOCK) WHERE MaHuongDan = @MaHuongDan)
            THROW 50241, N'Mã tài hướng dẫn không tồn tại', 1;
            
        IF @SoGio <= 0 OR @SoGio > 200
            THROW 50242, N'Số giờ không hợp lệ (1-200)', 1;
        
        -- Kiểm tra đã phân công chưa
        IF EXISTS (SELECT 1 FROM ThamGiaHuongDan WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaHuongDan = @MaHuongDan)
            THROW 50243, N'Giáo viên đã được phân công hướng dẫn này', 1;
        
        -- Kiểm tra số CBHD tối đa
        DECLARE @SoCBHD INT, @SoCBHDHienTai INT;
        SELECT @SoCBHD = SoCBHD FROM TaiHuongDan WITH (NOLOCK) WHERE MaHuongDan = @MaHuongDan;
        SELECT @SoCBHDHienTai = COUNT(*) FROM ThamGiaHuongDan WITH (NOLOCK) WHERE MaHuongDan = @MaHuongDan;
        
        IF @SoCBHDHienTai >= @SoCBHD
            THROW 50244, N'Đã đủ số cán bộ hướng dẫn', 1;
        
        -- Tạo mã tham gia hướng dẫn
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM ThamGiaHuongDan WITH (XLOCK);
        SET @MaThamGiaHuongDan = 'TGHD' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm phân công hướng dẫn
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
    END CATCH
END;
GO

-- =============================================
-- SECTION 9: QUẢN LÝ HỌC VỊ VÀ HỌC HÀM
-- =============================================

-- 9.1. Cập nhật học vị
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50250, N'Mã giáo viên không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50251, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Kiểm tra học vị đã có chưa
        IF EXISTS (SELECT 1 FROM HocVi WITH (UPDLOCK) WHERE MaGV = @MaGV AND TenHocVi = @TenHocVi)
            THROW 50252, N'Giáo viên đã có học vị này', 1;
        
        -- Tạo mã học vị
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM HocVi WITH (XLOCK);
        SET @MaHocVi = 'HV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm học vị
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
    END CATCH
END;
GO

-- 9.2. Cập nhật học hàm
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50260, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM HocHam WITH (NOLOCK) WHERE MaHocHam = @MaHocHam)
            THROW 50261, N'Mã học hàm không tồn tại', 1;
            
        IF @NgayNhan > GETDATE()
            THROW 50262, N'Ngày nhận không thể trong tương lai', 1;
        
        -- Kiểm tra học hàm đã có chưa
        IF EXISTS (SELECT 1 FROM LichSuHocHam WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaHocHam = @MaHocHam)
            THROW 50263, N'Giáo viên đã có học hàm này', 1;
        
        -- Lấy tên học hàm
        DECLARE @TenHocHam NVARCHAR(100);
        SELECT @TenHocHam = TenHocHam FROM HocHam WITH (NOLOCK) WHERE MaHocHam = @MaHocHam;
        
        -- Tạo mã lịch sử học hàm
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuHocHam WITH (XLOCK);
        SET @MaLSHocHam = 'LSHH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm lịch sử học hàm
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
    END CATCH
END;
GO

-- =============================================
-- SECTION 10: QUẢN LÝ CHỨC VỤ
-- =============================================

-- 10.1. Phân công chức vụ
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50270, N'Mã giáo viên không tồn tại', 1;
            
        IF NOT EXISTS (SELECT 1 FROM ChucVu WITH (NOLOCK) WHERE MaChucVu = @MaChucVu)
            THROW 50271, N'Mã chức vụ không tồn tại', 1;
            
        IF @NgayNhan IS NULL
            SET @NgayNhan = GETDATE();
        
        -- Kiểm tra đã có chức vụ này chưa
        IF EXISTS (SELECT 1 FROM LichSuChucVu WITH (UPDLOCK) 
                   WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL)
            THROW 50272, N'Giáo viên đang giữ chức vụ này', 1;
        
        -- Tạo mã lịch sử chức vụ
        DECLARE @MaLichSuChucVu CHAR(15);
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuChucVu WITH (XLOCK);
        SET @MaLichSuChucVu = 'LSCV' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm lịch sử chức vụ
        INSERT INTO LichSuChucVu (MaLichSuChucVu, NgayNhan, NgayKetThuc, MaGV, MaChucVu)
        VALUES (@MaLichSuChucVu, @NgayNhan, NULL, @MaGV, @MaChucVu);
        
        SET @ErrorMessage = N'Phân công chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 10.2. Kết thúc chức vụ
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
        
        -- Cập nhật ngày kết thúc
        UPDATE LichSuChucVu WITH (XLOCK)
        SET NgayKetThuc = @NgayKetThuc
        WHERE MaGV = @MaGV AND MaChucVu = @MaChucVu AND NgayKetThuc IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50280, N'Không tìm thấy chức vụ đang hoạt động', 1;
        
        SET @ErrorMessage = N'Kết thúc chức vụ thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- =============================================
-- SECTION 11: QUẢN LÝ NGƯỜI DÙNG VÀ BẢO MẬT
-- =============================================

-- 11.1. Tạo tài khoản người dùng
CREATE OR ALTER PROCEDURE sp_NguoiDung_TaoTaiKhoan
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100),
    @MaGV CHAR(15) = NULL,
    @MaNhom NVARCHAR(50) = 'NHOM001',
    @MaNguoiDung NVARCHAR(50) OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validation với UPDLOCK
        IF EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE TenDangNhap = @TenDangNhap)
            THROW 50290, N'Tên đăng nhập đã tồn tại', 1;
            
        IF @MaGV IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaGV)
                THROW 50291, N'Mã giáo viên không tồn tại', 1;
                
            IF EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK) WHERE MaGV = @MaGV)
                THROW 50292, N'Giáo viên đã có tài khoản', 1;
        END
        
        IF NOT EXISTS (SELECT 1 FROM NhomNguoiDung WITH (NOLOCK) WHERE MaNhom = @MaNhom)
            THROW 50293, N'Mã nhóm không tồn tại', 1;
        
        -- Mã hóa mật khẩu (sử dụng SHA2_256)
        DECLARE @HashedPassword NVARCHAR(MAX);
        SET @HashedPassword = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', @MatKhau), 2);
        
        -- Tạo mã người dùng
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM NguoiDung WITH (XLOCK);
        SET @MaNguoiDung = 'ND' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Thêm người dùng
        INSERT INTO NguoiDung (MaNguoiDung, TenDangNhap, MatKhau, MaGV)
        VALUES (@MaNguoiDung, @TenDangNhap, @HashedPassword, @MaGV);
        
        -- Thêm vào nhóm
        INSERT INTO NguoiDung_Nhom (MaNguoiDung, MaNhom)
        VALUES (@MaNguoiDung, @MaNhom);
        
        SET @ErrorMessage = N'Tạo tài khoản thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
    END CATCH
END;
GO

-- 11.2. Đăng nhập
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
        
        -- Mã hóa mật khẩu để so sánh
        DECLARE @HashedPassword NVARCHAR(MAX);
        SET @HashedPassword = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', @MatKhau), 2);
        
        -- Kiểm tra thông tin đăng nhập với UPDLOCK
        SELECT @MaNguoiDung = MaNguoiDung
        FROM NguoiDung WITH (UPDLOCK)
        WHERE TenDangNhap = @TenDangNhap AND MatKhau = @HashedPassword;
        
        IF @MaNguoiDung IS NULL
            THROW 50300, N'Tên đăng nhập hoặc mật khẩu không chính xác', 1;
        
        -- Tạo mã lịch sử đăng nhập
        DECLARE @Count INT;
        SELECT @Count = COUNT(*) + 1 FROM LichSuDangNhap WITH (XLOCK);
        SET @MaLichSu = 'LS' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
        
        -- Ghi lịch sử đăng nhập
        INSERT INTO LichSuDangNhap (MaLichSu, ThoiDiemDangNhap, ThoiDiemDangXuat, MaNguoiDung)
        VALUES (@MaLichSu, GETDATE(), NULL, @MaNguoiDung);
        
        SET @ErrorMessage = N'Đăng nhập thành công';
        
        COMMIT TRANSACTION;
        
        -- Trả về thông tin người dùng
        SELECT 
            ND.MaNguoiDung,
            ND.TenDangNhap,
            GV.HoTen,
            GV.Email,
            STRING_AGG(NND.TenNhom, ', ') AS DanhSachNhom
        FROM NguoiDung ND WITH (NOLOCK)
        LEFT JOIN GiaoVien GV WITH (NOLOCK) ON ND.MaGV = GV.MaGV
        LEFT JOIN NguoiDung_Nhom NDN WITH (NOLOCK) ON ND.MaNguoiDung = NDN.MaNguoiDung
        LEFT JOIN NhomNguoiDung NND WITH (NOLOCK) ON NDN.MaNhom = NND.MaNhom
        WHERE ND.MaNguoiDung = @MaNguoiDung
        GROUP BY ND.MaNguoiDung, ND.TenDangNhap, GV.HoTen, GV.Email;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @MaNguoiDung = NULL;
        SET @MaLichSu = NULL;
    END CATCH
END;
GO

-- 11.3. Đăng xuất
CREATE OR ALTER PROCEDURE sp_NguoiDung_DangXuat
    @MaLichSu NVARCHAR(50),
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE LichSuDangNhap WITH (XLOCK)
        SET ThoiDiemDangXuat = GETDATE()
        WHERE MaLichSu = @MaLichSu AND ThoiDiemDangXuat IS NULL;
        
        IF @@ROWCOUNT = 0
            THROW 50310, N'Phiên đăng nhập không tồn tại hoặc đã kết thúc', 1;
        
        SET @ErrorMessage = N'Đăng xuất thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 11.4. Đổi mật khẩu
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
        
        -- Validation mật khẩu cũ
        DECLARE @HashedOldPassword NVARCHAR(MAX);
        SET @HashedOldPassword = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', @MatKhauCu), 2);
        
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WITH (UPDLOCK)
                       WHERE MaNguoiDung = @MaNguoiDung AND MatKhau = @HashedOldPassword)
            THROW 50320, N'Mật khẩu cũ không chính xác', 1;
        
        -- Validation mật khẩu mới
        IF LEN(@MatKhauMoi) < 6
            THROW 50321, N'Mật khẩu mới phải có ít nhất 6 ký tự', 1;
        
        -- Mã hóa mật khẩu mới
        DECLARE @HashedNewPassword NVARCHAR(MAX);
        SET @HashedNewPassword = CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', @MatKhauMoi), 2);
        
        -- Cập nhật mật khẩu
        UPDATE NguoiDung WITH (XLOCK)
        SET MatKhau = @HashedNewPassword
        WHERE MaNguoiDung = @MaNguoiDung;
        
        SET @ErrorMessage = N'Đổi mật khẩu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 11.5. Kiểm tra quyền
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
        FROM NguoiDung_Nhom NDN WITH (NOLOCK)
        INNER JOIN Nhom_Quyen NQ WITH (NOLOCK) ON NDN.MaNhom = NQ.MaNhom
        WHERE NDN.MaNguoiDung = @MaNguoiDung AND NQ.MaQuyen = @MaQuyen
    )
        SET @CoQuyen = 1;
END;
GO

-- =============================================
-- SECTION 12: QUẢN LÝ LÝ LỊCH KHOA HỌC
-- =============================================

-- 12.1. Cập nhật lý lịch khoa học
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
        
        -- Validation
        IF NOT EXISTS (SELECT 1 FROM GiaoVien WITH (UPDLOCK) WHERE MaGV = @MaGV)
            THROW 50330, N'Mã giáo viên không tồn tại', 1;
            
        IF @NamTotNghiepDH < 1950 OR @NamTotNghiepDH > YEAR(GETDATE())
            THROW 50331, N'Năm tốt nghiệp đại học không hợp lệ', 1;
        
        -- Kiểm tra có bản ghi chưa
        IF EXISTS (SELECT 1 FROM LyLichKhoaHoc WITH (UPDLOCK) WHERE MaGV = @MaGV)
        BEGIN
            -- Cập nhật
            UPDATE LyLichKhoaHoc WITH (XLOCK)
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
            -- Tạo mã lý lịch khoa học
            DECLARE @MaLyLichKhoaHoc CHAR(15);
            DECLARE @Count INT;
            SELECT @Count = COUNT(*) + 1 FROM LyLichKhoaHoc WITH (XLOCK);
            SET @MaLyLichKhoaHoc = 'LLKH' + RIGHT('000' + CAST(@Count AS VARCHAR(3)), 3);
            
            -- Lấy tên giáo viên
            DECLARE @NguoiKhai NVARCHAR(100);
            SELECT @NguoiKhai = HoTen FROM GiaoVien WITH (NOLOCK) WHERE MaGV = @MaGV;
            
            -- Thêm mới
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
    END CATCH
END;
GO

-- =============================================
-- SECTION 13: BÁO CÁO VÀ THỐNG KÊ
-- =============================================

-- 13.1. Báo cáo tổng hợp khối lượng công tác
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
        FROM GiaoVien GV WITH (NOLOCK)
        LEFT JOIN ChiTietGiangDay CTGD WITH (NOLOCK) ON GV.MaGV = CTGD.MaGV
        LEFT JOIN TaiGiangDay TGD WITH (NOLOCK) ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
        WHERE @NamHoc IS NULL OR TGD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    NCKHStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTNCKH.SoGio), 0) AS TongGioNCKH
        FROM GiaoVien GV WITH (NOLOCK)
        LEFT JOIN ChiTietNCKH CTNCKH WITH (NOLOCK) ON GV.MaGV = CTNCKH.MaGV
        LEFT JOIN TaiNCKH TNCKH WITH (NOLOCK) ON CTNCKH.MaTaiNCKH = TNCKH.MaTaiNCKH
        WHERE @NamHoc IS NULL OR TNCKH.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    KhaoThiStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(CTKT.SoGioQuyChuan), 0) AS TongGioKhaoThi
        FROM GiaoVien GV WITH (NOLOCK)
        LEFT JOIN ChiTietTaiKhaoThi CTKT WITH (NOLOCK) ON GV.MaGV = CTKT.MaGV
        LEFT JOIN TaiKhaoThi TKT WITH (NOLOCK) ON CTKT.MaTaiKhaoThi = TKT.MaTaiKhaoThi
        WHERE @NamHoc IS NULL OR TKT.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HoiDongStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TG.SoGio), 0) AS TongGioHoiDong
        FROM GiaoVien GV WITH (NOLOCK)
        LEFT JOIN ThamGia TG WITH (NOLOCK) ON GV.MaGV = TG.MaGV
        LEFT JOIN TaiHoiDong THD WITH (NOLOCK) ON TG.MaHoiDong = THD.MaHoiDong
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    HuongDanStats AS (
        SELECT 
            GV.MaGV,
            ISNULL(SUM(TGHD.SoGio), 0) AS TongGioHuongDan
        FROM GiaoVien GV WITH (NOLOCK)
        LEFT JOIN ThamGiaHuongDan TGHD WITH (NOLOCK) ON GV.MaGV = TGHD.MaGV
        LEFT JOIN TaiHuongDan THD WITH (NOLOCK) ON TGHD.MaHuongDan = THD.MaHuongDan
        WHERE @NamHoc IS NULL OR THD.NamHoc = @NamHoc
        GROUP BY GV.MaGV
    ),
    DinhMucStats AS (
        SELECT 
            GV.MaGV,
            ISNULL((
                SELECT TOP 1 DMGD.DinhMucGiangDay
                FROM LichSuHocHam LSHH WITH (NOLOCK)
                INNER JOIN HocHam HH WITH (NOLOCK) ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucGiangDay DMGD WITH (NOLOCK) ON HH.MaDinhMucGiangDay = DMGD.MaDinhMucGiangDay
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 320) AS DinhMucGiangDay,
            ISNULL((
                SELECT TOP 1 DMNC.DinhMucGioChuanHoatDongNghienCuuKhoaHoc
                FROM LichSuHocHam LSHH WITH (NOLOCK)
                INNER JOIN HocHam HH WITH (NOLOCK) ON LSHH.MaHocHam = HH.MaHocHam
                INNER JOIN DinhMucNghienCuu DMNC WITH (NOLOCK) ON HH.MaDinhMucNghienCuu = DMNC.MaDinhMucNghienCuu
                WHERE LSHH.MaGV = GV.MaGV
                ORDER BY LSHH.NgayNhan DESC
            ), 300) AS DinhMucNCKH
        FROM GiaoVien GV WITH (NOLOCK)
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
    FROM GiaoVien GV WITH (NOLOCK)
    INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
    INNER JOIN Khoa K WITH (NOLOCK) ON BM.MaKhoa = K.MaKhoa
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

-- 13.2. Dashboard tổng quan
CREATE OR ALTER PROCEDURE sp_Dashboard_TongQuan
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Thống kê tổng quan
    SELECT 
        (SELECT COUNT(*) FROM GiaoVien WITH (NOLOCK)) AS TongGiaoVien,
        (SELECT COUNT(*) FROM Khoa WITH (NOLOCK)) AS TongKhoa,
        (SELECT COUNT(*) FROM BoMon WITH (NOLOCK)) AS TongBoMon,
        (SELECT COUNT(*) FROM NguoiDung WITH (NOLOCK)) AS TongNguoiDung;
    
    -- Thống kê theo học vị
    SELECT 
        HV.TenHocVi,
        COUNT(DISTINCT HV.MaGV) AS SoLuong
    FROM HocVi HV WITH (NOLOCK)
    GROUP BY HV.TenHocVi
    ORDER BY SoLuong DESC;
    
    -- Thống kê theo học hàm
    SELECT 
        LSHH.TenHocHam,
        COUNT(DISTINCT LSHH.MaGV) AS SoLuong
    FROM LichSuHocHam LSHH WITH (NOLOCK)
    WHERE LSHH.NgayNhan = (
        SELECT MAX(LSHH2.NgayNhan)
        FROM LichSuHocHam LSHH2 WITH (NOLOCK)
        WHERE LSHH2.MaGV = LSHH.MaGV
    )
    GROUP BY LSHH.TenHocHam
    ORDER BY SoLuong DESC;
    
    -- Top 10 giáo viên giảng dạy nhiều nhất
    SELECT TOP 10
        GV.MaGV,
        GV.HoTen,
        BM.TenBM,
        SUM(CTGD.SoTietQuyDoi) AS TongGioGiangDay
    FROM GiaoVien GV WITH (NOLOCK)
    INNER JOIN BoMon BM WITH (NOLOCK) ON GV.MaBM = BM.MaBM
    INNER JOIN ChiTietGiangDay CTGD WITH (NOLOCK) ON GV.MaGV = CTGD.MaGV
    INNER JOIN TaiGiangDay TGD WITH (NOLOCK) ON CTGD.MaTaiGiangDay = TGD.MaTaiGiangDay
    WHERE TGD.NamHoc = (SELECT TOP 1 NamHoc FROM TaiGiangDay WITH (NOLOCK) ORDER BY NamHoc DESC)
    GROUP BY GV.MaGV, GV.HoTen, BM.TenBM
    ORDER BY TongGioGiangDay DESC;
END;
GO

-- =============================================
-- SECTION 14: UTILITIES VÀ HELPER PROCEDURES
-- =============================================

-- 14.1. Khởi tạo dữ liệu mẫu
CREATE OR ALTER PROCEDURE sp_Utility_KhoiTaoDuLieuMau
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Khởi tạo SequenceGenerator nếu chưa có
        IF NOT EXISTS (SELECT 1 FROM SequenceGenerator WHERE TableName = 'GiaoVien')
            INSERT INTO SequenceGenerator (TableName, LastSequence) VALUES ('GiaoVien', 0);
        
        -- Thêm dữ liệu mẫu cho các bảng reference
        IF NOT EXISTS (SELECT 1 FROM DoiTuongGiangDay)
        BEGIN
            INSERT INTO DoiTuongGiangDay VALUES 
                ('DT001', N'Đại học', 1.0, N'Giảng dạy đại học chính quy'),
                ('DT002', N'Thạc sĩ', 1.2, N'Giảng dạy thạc sĩ'),
                ('DT003', N'Tiến sĩ', 1.5, N'Giảng dạy tiến sĩ');
        END
        
        IF NOT EXISTS (SELECT 1 FROM ThoiGianGiangDay)
        BEGIN
            INSERT INTO ThoiGianGiangDay VALUES 
                ('TG001', N'Sáng', 1.0, N'Buổi sáng'),
                ('TG002', N'Chiều', 1.0, N'Buổi chiều'),
                ('TG003', N'Tối', 1.2, N'Buổi tối');
        END
        
        IF NOT EXISTS (SELECT 1 FROM NgonNguGiangDay)
        BEGIN
            INSERT INTO NgonNguGiangDay VALUES 
                ('NN001', N'Tiếng Việt', 1.0, N'Giảng dạy bằng tiếng Việt'),
                ('NN002', N'Tiếng Anh', 1.3, N'Giảng dạy bằng tiếng Anh');
        END
        
        SET @ErrorMessage = N'Khởi tạo dữ liệu mẫu thành công';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- 14.2. Sao lưu dữ liệu
CREATE OR ALTER PROCEDURE sp_Utility_SaoLuuBang
    @TenBang NVARCHAR(100),
    @TenBangSaoLuu NVARCHAR(100) = NULL,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Tạo tên bảng sao lưu nếu không được cung cấp
        IF @TenBangSaoLuu IS NULL
            SET @TenBangSaoLuu = @TenBang + '_Backup_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');
        
        -- Tạo bảng sao lưu
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = 'SELECT * INTO ' + QUOTENAME(@TenBangSaoLuu) + ' FROM ' + QUOTENAME(@TenBang);
        
        EXEC sp_executesql @SQL;
        
        SET @ErrorMessage = N'Sao lưu bảng thành công: ' + @TenBangSaoLuu;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;
GO

-- =============================================
-- KẾT THÚC HỆ THỐNG STORED PROCEDURES
-- =============================================

PRINT N'Đã hoàn tất cài đặt tất cả Stored Procedures cho hệ thống Quản lý Giáo viên';
PRINT N'Tổng cộng: 50+ procedures được tạo với đầy đủ transaction management và locking';
GO