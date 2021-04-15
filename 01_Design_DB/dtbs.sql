-- MySQL Workbench Forward Engineering


DROP SCHEMA IF EXISTS `mydb` ;

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

DROP TABLE IF EXISTS `mydb`.`ViTri` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ViTri` (
  `idViTri` INT NOT NULL,
  `TenViTri` VARCHAR(45) NULL,
  PRIMARY KEY (`idViTri`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`TrinhDo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TrinhDo` (
  `idTrinhDo` INT NOT NULL,
  `TrinhDo` VARCHAR(45) NULL,
  PRIMARY KEY (`idTrinhDo`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`BoPhan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BoPhan` (
  `idBoPhan` INT NOT NULL,
  `TenBoPhan` VARCHAR(45) NULL,
  PRIMARY KEY (`idBoPhan`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`NhanVien` (
  `IDNhanVien` INT NOT NULL,
  `HoTen` VARCHAR(45) NULL,
  `NgaySinh` DATE NULL,
  `SoCMTND` VARCHAR(45) NULL,
  `Luong` VARCHAR(45) NULL,
  `SDT` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `DiaChi` VARCHAR(45) NULL,
  `NhanViencol` VARCHAR(45) NULL,
  `ViTri_idViTri` INT NOT NULL,
  `TrinhDo_idTrinhDo` INT NOT NULL,
  `BoPhan_idBoPhan` INT NOT NULL,
  PRIMARY KEY (`IDNhanVien`))
ENGINE = InnoDB;

CREATE INDEX `fk_NhanVien_ViTri_idx` ON `mydb`.`NhanVien` (`ViTri_idViTri` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_TrinhDo1_idx` ON `mydb`.`NhanVien` (`TrinhDo_idTrinhDo` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_BoPhan1_idx` ON `mydb`.`NhanVien` (`BoPhan_idBoPhan` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`KieuThue` ;

CREATE TABLE IF NOT EXISTS `mydb`.`KieuThue` (
  `idKieuThue` INT NOT NULL,
  `TenKieuThue` VARCHAR(45) NULL,
  `Gia` INT NULL,
  PRIMARY KEY (`idKieuThue`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`LoaiDichVu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LoaiDichVu` (
  `idLoaiDichVu` INT NOT NULL,
  `TenCuaDichVu` VARCHAR(45) NULL,
  PRIMARY KEY (`idLoaiDichVu`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`DichVu` (
  `idDichVu` INT NOT NULL,
  `TenDichVu` VARCHAR(45) NULL,
  `DienTich` INT NULL,
  `SoTang` INT NULL,
  `SoNguoiToiDa` VARCHAR(45) NULL,
  `ChiPhiThue` VARCHAR(45) NULL,
  `TrangThai` VARCHAR(45) NULL,
  `DichVucol` VARCHAR(45) NULL,
  `KieuThue_idKieuThue` INT NOT NULL,
  `LoaiDichVu_idLoaiDichVu` INT NOT NULL,
  PRIMARY KEY (`idDichVu`))
ENGINE = InnoDB;

CREATE INDEX `fk_DichVu_KieuThue1_idx` ON `mydb`.`DichVu` (`KieuThue_idKieuThue` ASC) VISIBLE;

CREATE INDEX `fk_DichVu_LoaiDichVu1_idx` ON `mydb`.`DichVu` (`LoaiDichVu_idLoaiDichVu` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`LoaiKhach` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LoaiKhach` (
  `idLoaiKhach` INT NOT NULL,
  `TenLoaiKhach` VARCHAR(45) NULL,
  PRIMARY KEY (`idLoaiKhach`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`KhachHang` ;

CREATE TABLE IF NOT EXISTS `mydb`.`KhachHang` (
  `idKhachHang` INT NOT NULL,
  `HoTen` VARCHAR(45) NULL,
  `NgaySinh` VARCHAR(45) NULL,
  `KhachHangcol1` DATE NULL,
  `SoCMTND` VARCHAR(45) NULL,
  `SDT` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `NhanVien` VARCHAR(45) NULL,
  `LoaiKhach_idLoaiKhach` INT NOT NULL,
  PRIMARY KEY (`idKhachHang`))
ENGINE = InnoDB;

CREATE INDEX `fk_KhachHang_LoaiKhach1_idx` ON `mydb`.`KhachHang` (`LoaiKhach_idLoaiKhach` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`HopDong` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HopDong` (
  `idHopDong` INT NOT NULL,
  `IDNhanVien` VARCHAR(45) NULL,
  `IDKhachHang` VARCHAR(45) NULL,
  `IDDichVu` VARCHAR(45) NULL,
  `NgayLamHopDong` DATE NULL,
  `NgayKetThuc` DATE NULL,
  `TienDatCoc` INT NULL,
  `TongTien` INT NULL,
  `DichVu_idDichVu` INT NOT NULL,
  `KhachHang_idKhachHang` INT NOT NULL,
  `NhanVien_IDNhanVien` INT NOT NULL,
  PRIMARY KEY (`idHopDong`))
ENGINE = InnoDB;

CREATE INDEX `fk_HopDong_DichVu1_idx` ON `mydb`.`HopDong` (`DichVu_idDichVu` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_KhachHang1_idx` ON `mydb`.`HopDong` (`KhachHang_idKhachHang` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_NhanVien1_idx` ON `mydb`.`HopDong` (`NhanVien_IDNhanVien` ASC) VISIBLE;

DROP TABLE IF EXISTS `mydb`.`DichVuDiKem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DichVuDiKem` (
  `idDichVuDiKem` INT NOT NULL,
  `TenDichVuDiKem` VARCHAR(45) NULL,
  `Gia` INT NULL,
  `DonVi` INT NULL,
  `TrangThaiKhaDung` VARCHAR(45) NULL,
  PRIMARY KEY (`idDichVuDiKem`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `mydb`.`HopDongChiTiet` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HopDongChiTiet` (
  `idHopDongChiTiet` INT NOT NULL,
  `idHopDong` INT NULL,
  `idDichVuDiKem` INT NULL,
  `SoLuong` INT NULL,
  `HopDongChiTietcol` VARCHAR(45) NULL,
  `DichVuDiKem_idDichVuDiKem` INT NOT NULL,
  `HopDong_idHopDong` INT NOT NULL,
  PRIMARY KEY (`idHopDongChiTiet`))
ENGINE = InnoDB;

CREATE INDEX `fk_HopDongChiTiet_DichVuDiKem1_idx` ON `mydb`.`HopDongChiTiet` (`DichVuDiKem_idDichVuDiKem` ASC) VISIBLE;

CREATE INDEX `fk_HopDongChiTiet_HopDong1_idx` ON `mydb`.`HopDongChiTiet` (`HopDong_idHopDong` ASC) VISIBLE;

