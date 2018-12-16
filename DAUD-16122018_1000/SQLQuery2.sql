CREATE DATABASE QLKS;
---Tạo các bảng---

CREATE TABLE NHANVIEN( MSNV CHAR(10) ,HOTENNV NVARCHAR(50) , TAIKHOAN NVARCHAR(20), MATKHAU CHAR(10) , NGAYSINH DATE ,
GIOITINH  NVARCHAR (10) , DIACHI NVARCHAR(50) , DIENTHOAI CHAR(15) , NGAYVAOLAM DATE, CHUCVU NVARCHAR(30)
PRIMARY KEY (MSNV))

CREATE TABLE KHACHHANG( MSKH CHAR(10) , HOTENKH NVARCHAR (50) , GIOITINHKH NVARCHAR(10) , DIACHIKH NVARCHAR(50) , CMND CHAR(15) , DIENTHOAIKH CHAR(15) , QUOCTICH NVARCHAR(20)
PRIMARY KEY (MSKH))

CREATE TABLE THUEPHONG (SOHDONGTHUEPHONG NVARCHAR(50), MSNV CHAR(10) , NGAYTHUE DATE , NGAYTRADK DATE,MSKH CHAR(10),MSPHONG CHAR(10)
PRIMARY KEY (SOHDONGTHUEPHONG))


CREATE TABLE HDTHANHTOANPHONG ( SOTHANHTOAN CHAR(20) , SOHDONGTHUEPHONG NVARCHAR(50) , MSNV CHAR(10) , NGAYTHANHTOAN DATE , TIENPHONG FLOAT
PRIMARY KEY (SOTHANHTOAN))

CREATE TABLE PHONG ( MSPHONG CHAR(10) , TINHTRANG NVARCHAR(20) , GIATIEN FLOAT
PRIMARY KEY (MSPHONG))

---Tao cac rang buoc

---rang buoc khoa ngoai giua  nhan vien voi hdthanhtoanphong

ALTER TABLE HDTHANHTOANPHONG 
ADD CONSTRAINT FK_NV_HDTHANHTOANPHONG FOREIGN KEY(MSNV)
REFERENCES NHANVIEN(MSNV)

---rang buoc khoa ngoai giua  nhan vien voi thue phong

ALTER TABLE THUEPHONG 
ADD CONSTRAINT FK_NV_THUEPHONG FOREIGN KEY (MSNV)
REFERENCES NHANVIEN(MSNV)

---rang buoc khoa ngoai giua  thue phong voi hdthanhtoanphong

ALTER TABLE HDTHANHTOANPHONG
ADD CONSTRAINT FK_TP_HDTHANHTOANPHONG FOREIGN KEY (SOHDONGTHUEPHONG)
REFERENCES THUEPHONG (SOHDONGTHUEPHONG)

ALTER TABLE THUEPHONG
ADD CONSTRAINT FK_TP_THUEPHONG FOREIGN KEY (MSKH)
REFERENCES KHACHHANG (MSKH)

ALTER TABLE THUEPHONG
ADD CONSTRAINT FK_P_THUEPHONG FOREIGN KEY (MSPHONG)
REFERENCES PHONG (MSPHONG)

create proc sp_ThemNhanVien(@MSNV CHAR(10) ,@HOTENNV NVARCHAR(50) , @TAIKHOAN NVARCHAR(20), @MATKHAU CHAR(10) , @NGAYSINH DATE ,
@GIOITINH  NVARCHAR (10) , @DIACHI NVARCHAR(50) , @DIENTHOAI CHAR(15) , @NGAYVAOLAM DATE, @CHUCVU NVARCHAR(30))
as
INSERT INTO NHANVIEN(MSNV,HOTENNV,TAIKHOAN,MATKHAU,NGAYSINH,GIOITINH,DIACHI,DIENTHOAI,NGAYVAOLAM,CHUCVU)

VALUES(@MSNV,@HOTENNV,@TAIKHOAN,@MATKHAU,@NGAYSINH,@GIOITINH,@DIACHI,@DIENTHOAI,@NGAYVAOLAM,@CHUCVU)


create proc sp_XoaNhanVien(@MSNV CHAR(10))
as
delete from NHANVIEN
where MSNV = @MSNV 

create proc sp_Suanv(@MSNV CHAR(10) ,@HOTENNV NVARCHAR(50) , @TAIKHOAN NVARCHAR(20), @MATKHAU CHAR(10) , @NGAYSINH DATE ,
@GIOITINH  NVARCHAR (10) , @DIACHI NVARCHAR(50) , @DIENTHOAI CHAR(15) , @NGAYVAOLAM DATE, @CHUCVU NVARCHAR(30))
as
update NHANVIEN
set HOTENNV = @HOTENNV ,TAIKHOAN = @TAIKHOAN, MATKHAU = @MATKHAU , NGAYSINH = @NGAYSINH,GIOITINH = @GIOITINH,DIACHI = @DIACHI,DIENTHOAI = @DIENTHOAI, NGAYVAOLAM = @NGAYVAOLAM, CHUCVU = @CHUCVU
where MSNV = @MSNV

create proc sp_LayNV
as
SELECT * FROM NHANVIEN

-- SP KHACH HANG
create proc sp_ThemKhachHang(@MSKH CHAR(10) , @HOTENKH NVARCHAR (50) , @GIOITINHKH NVARCHAR(10) , @DIACHIKH NVARCHAR(50) , @CMND CHAR(15) , @DIENTHOAIKH CHAR(15) , @QUOCTICH NVARCHAR(20))
as
INSERT INTO KHACHHANG(MSKH,HOTENKH,GIOITINHKH,DIACHIKH,CMND,DIENTHOAIKH,QUOCTICH)
VALUES(@MSKH,@HOTENKH,@GIOITINHKH,@DIACHIKH,@CMND,@DIENTHOAIKH,@QUOCTICH)

create proc sp_XoaKhachHang(@MSKH CHAR(10))
as
delete from KHACHHANG
where MSKH = @MSKH

create proc sp_SuaKhachHang(@MSKH CHAR(10) , @HOTENKH NVARCHAR (50) , @GIOITINHKH NVARCHAR(10) , @DIACHIKH NVARCHAR(50) , @CMND CHAR(15) , @DIENTHOAIKH CHAR(15) , @QUOCTICH NVARCHAR(20))
as
update KHACHHANG
set HOTENKH = @HOTENKH,GIOITINHKH = @GIOITINHKH,DIACHIKH = @DIACHIKH,CMND = @CMND,DIENTHOAIKH = @DIENTHOAIKH,QUOCTICH = @QUOCTICH
where MSKH = @MSKH

create proc sp_LayKhachHang
as
SELECT *FROM KHACHHANG
-- SP THUE PHONG
create proc sp_ThemThuePhong(@SOHDONGTHUEPHONG NVARCHAR(50), @MSNV CHAR(10) , @NGAYTHUE DATE , @NGAYTRADK DATE,@MSKH CHAR(10),@MSPHONG CHAR(10))
as
insert into THUEPHONG(SOHDONGTHUEPHONG,MSNV,NGAYTHUE,NGAYTRADK,MSKH,MSPHONG)
values(@SOHDONGTHUEPHONG,@MSNV,@NGAYTHUE,@NGAYTRADK,@MSKH,@MSPHONG)

create proc sp_xoaThuePhong(@SOHDONGTHUEPHONG NVARCHAR(50))
as
delete from THUEPHONG
where SOHDONGTHUEPHONG = @SOHDONGTHUEPHONG

create proc sp_SuathuePhong(@SOHDONGTHUEPHONG NVARCHAR(50), @MSNV CHAR(10) , @NGAYTHUE DATE , @NGAYTRADK DATE,@MSKH CHAR(10),@MSPHONG CHAR(10))
as
update THUEPHONG
set MSNV = @MSNV,NGAYTHUE = @NGAYTHUE, NGAYTRADK=@NGAYTRADK,MSKH =@MSKH,MSPHONG = @MSPHONG
where SOHDONGTHUEPHONG = @SOHDONGTHUEPHONG

create proc sp_LaythuePhong
as
select *from THUEPHONG
-- sp_hop dong thanh toan
create proc sp_ThemHopDong(@SOTHANHTOAN CHAR(20) , @SOHDONGTHUEPHONG NVARCHAR(50) , @MSNV CHAR(10) , @NGAYTHANHTOAN DATE , @TIENPHONG FLOAT)
as
insert into HDTHANHTOANPHONG(SOTHANHTOAN,SOHDONGTHUEPHONG,MSNV,NGAYTHANHTOAN,TIENPHONG)
values(@SOTHANHTOAN,@SOHDONGTHUEPHONG,@MSNV,@NGAYTHANHTOAN,@TIENPHONG)

create proc sp_xoaHopDong(@SOTHANHTOAN CHAR(20))
as
delete from HDTHANHTOANPHONG
where SOTHANHTOAN = @SOTHANHTOAN

create proc sp_SuaHopDong(@SOTHANHTOAN CHAR(20), @NGAYTHANHTOAN DATE)
as 
update HDTHANHTOANPHONG
set NGAYTHANHTOAN = @NGAYTHANHTOAN
where SOTHANHTOAN = @SOTHANHTOAN

create proc sp_layHopDong
as
select *from HDTHANHTOANPHONG

--SP PHONG
CREATE PROC sp_themPhong(@MSPHONG CHAR(10) , @TINHTRANG NVARCHAR(20) , @GIATIEN FLOAT)
as
insert into PHONG(MSPHONG,TINHTRANG,GIATIEN)
VALUES (@MSPHONG,@TINHTRANG,@GIATIEN)

CREATE PROC SP_XOAPHONG(@MSPHONG CHAR(10))
AS
DELETE FROM PHONG
WHERE MSPHONG = @MSPHONG

CREATE PROC SP_SUAPHONG(@MSPHONG CHAR(10) , @TINHTRANG NVARCHAR(20) , @GIATIEN FLOAT)
AS
UPDATE PHONG
SET TINHTRANG = @TINHTRANG, GIATIEN = @GIATIEN
WHERE MSPHONG = @MSPHONG

CREATE PROC SP_LAYPHONG
AS
SELECT * FROM PHONG


CREATE TABLE DANGNHAP ( MSNV CHAR(10),TAIKHOAN CHAR(20) , MATKHAU NVARCHAR(10) 
PRIMARY KEY (MSNV))

CREATE PROC SP_LogOut
AS
DELETE FROM DANGNHAP

CREATE PROC SP_Login(@MSNV CHAR(10) , @TAIKHOAN CHAR(20) , @MATKHAU NVARCHAR(10))
as
insert into DANGNHAP(MSNV,TAIKHOAN,MATKHAU)
VALUES (@MSNV,@TAIKHOAN,@MATKHAU)

CREATE PROC SP_UPDATE(@MSPHONG CHAR(10))
AS
UPDATE PHONG
SET TINHTRANG = 'DaThue'
WHERE MSPHONG = @MSPHONG

CREATE PROC SP_XoaUPDATE(@MSPHONG CHAR(10))
AS
UPDATE PHONG
SET TINHTRANG = 'Trong'
WHERE MSPHONG = @MSPHONG

CREATE PROC SP_GIATIEN(@MSPHONG CHAR(10))
AS
SELECT MSPHONG,GIATIEN FROM PHONG
WHERE MSPHONG = @MSPHONG

-- tìm nV
CREATE PROC SP_TimNV1(@MSNV CHAR(10))
AS
SELECT * FROM NHANVIEN
WHERE MSNV = @MSNV

CREATE PROC SP_TimPHONG(@MSPHONG CHAR(10))
AS
SELECT * FROM PHONG
WHERE MSPHONG = @MSPHONG

CREATE PROC SP_TimTP(@SOHDONGTHUEPHONG CHAR(50))
AS
SELECT * FROM THUEPHONG
WHERE SOHDONGTHUEPHONG = @SOHDONGTHUEPHONG

CREATE PROC SP_TimKH(@MSKH CHAR(10))
AS
SELECT * FROM KHACHHANG
WHERE MSKH = @MSKH

CREATE PROC SP_TimHD(@SOTHANHTOAN CHAR(10))
AS
SELECT * FROM HDTHANHTOANPHONG
WHERE SOTHANHTOAN = @SOTHANHTOAN