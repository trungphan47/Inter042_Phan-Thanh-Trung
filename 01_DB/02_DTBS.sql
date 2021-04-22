-- 2
SELECT * FROM nhanvien
where left(HoTen,1)=('H'or'T'or'K')and length(HoTen)<11;

-- 3
SELECT * FROM khachhang
where  (DiaChi='Đà Nẵng' or DiaChi='Huế')  
and (YEAR(curdate())-year(NgaySinh))>18 and (YEAR(curdate())-year(NgaySinh))<50;

-- 4
SELECt  hd.idKhachHang,count(*)as solandatphong
FROM hopdong hd
inner join khachhang kh 
ON kh.idKhachHang=hd.idKhachHang
inner join loaikhach lk
ON kh.LoaiKhach_idLoaiKhach=lk.idLoaiKhach
WHERE lk.idLoaiKhach=1
group by idKhachHang
order by solandatphong asc;
-- 5
SELECT hd.idKhachHang,kh.HoTen,lk.TenLoaiKhach,hd.idHopDong,dv.TenDichVu,hd.NgayLamHopDong,hd.NgayKetThuc,dvdk.TenDichVuDiKem,sum(hd.TongTien+dvdk.Gia*dvdk.DonVi) Total
from hopdong hd
inner join khachhang kh 
ON kh.idKhachHang=hd.idKhachHang
inner join loaikhach lk
ON kh.LoaiKhach_idLoaiKhach=lk.idLoaiKhach
inner join dichvu dv
ON hd.IDdichvu=dv.idDichVu
inner join hopdongchitiet hdct
ON hdct.HopDong_idHopDong=hd.idHopDong
inner join dichvudikem dvdk
ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
GROUP BY idHopDongChiTiet
order by Total
;

-- 6
with ldv_cte as (
	select distinct ldv.idLoaiDichVu
	from dichvu dv
	join hopdong hd on dv.idDichVu = hd.idDichVu
	join loaidichvu ldv on ldv.idLoaiDichVu = dv.idLoaiDichVu
    where year(NgayLamHopDong)>2019
)
select ldv.idLoaiDichVu, ldv.TenCuaDichVu
from ldv_cte cte
right join loaidichvu ldv on cte.idLoaiDichVu = ldv.idLoaiDichVu
where cte.idLoaiDichVu is null or ldv.idLoaiDichVu is null;
-- 7
SELECT dv.idDichVu,dv.TenDichVu,dv.DienTich,dv.SoNguoiToiDa,dv.ChiPhiThue,ldv.TenCuaDichVu
FROM hopdong hd
inner join dichvu dv
ON dv.idDichVu=hd.IDDichvu
inner join loaidichvu ldv
ON ldv.idLoaiDichVu=dv.idLoaiDichVu
where year(hd.NgayLamHopDong)=2018 and year(NgayKetThuc)<2019;
-- 8.	Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau
select *
from khachhang
group by HoTen
having count(*)<2;
-- 9.
SELECT month(NgayLamHopDong), sum(TongTien) Doanhthu
from hopdong
where year(NgayLamHopDong)=2019
group by date_format(NgayLamHopDong, '%Y-%m' )
order by NgayLamHopDong;

-- 10. Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu 
-- Dịch vụ đi kèm. Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem
 -- (được tính dựa trên việc count các IDHopDongChiTiet).
 SELECT hd.idHopDong,hd.NgayLamHopDong,hd.NgayKetThuc,hd.TienDatCoc,count(*) as SoLuongDichVuDiKem
 FROM hopdong hd
 inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
 group by idHopDong;
-- 11.Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.
 SELECT dvdk.TenDichVuDiKem,kh.idKhachHang,kh.HoTen,dvdk.Gia,dvdk.DonVi
 FROM khachhang kh
 inner join loaikhach lk
 ON kh.idLoaiKhach=lk.idLoaiKhach
 inner join hopdong hd
 ON hd.idKhachHang=kh.idKhachHang
inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
 where TenLoaiKhach='Diamond' and (kh.DiaChi='Huế' or kh.DiaChi='Đà Nẵng')  
 -- 12.
with dvct as(
SELECT distinct dv.TenDichVu, hd.idHopDong, dv.idDichVu
FROM hopdong hd
inner join khachhang kh
ON hd.idKhachHang=kh.idKhachHang
inner join nhanvien nv
ON hd.idNhanVien=nv.idNhanVien
inner join dichvu dv
ON dv.idDichVu=hd.DichVu_idDichVu
inner join hopdongchitiet hdct
ON hd.idHopDong=hdct.HopDong_idHopDong
where year(NgayLamHopDong)=2019
group by dv.TenDichVu
)
SELECT hd.idHopDong,nv.HoTen HoTenNhanVien,kh.HoTen HoTenKhachHang,kh.SDT,dv.TenDichVu,hd.TienDatCoc
FROM hopdong hd
inner join khachhang kh
ON hd.idKhachHang=kh.idKhachHang
inner join nhanvien nv
ON hd.idNhanVien=nv.idNhanVien
inner join dichvu dv
ON dv.idDichVu=hd.DichVu_idDichVu
inner join hopdongchitiet hdct
ON hd.idHopDong=hdct.HopDong_idHopDong
inner join dichvudikem dvdk
ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
left join dvct cte on dv.idDichVu = cte.idDichVu
where cte.idDichVu is null or dv.idDichVu is null and year(NgayLamHopDong)=2018
group by hd.idHopDong;
-- 13. Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
with slcdv as(
SELECT hd.idHopDong,hd.NgayLamHopDong,hd.NgayKetThuc,hd.TienDatCoc,count(*) as SoLuongDichVuDiKem
 FROM hopdong hd
 inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
 group by idHopDong
 )
 select max(SoLuongDichVuDiKem) SoLanSuDungDichVu,dvdk.TenDichVuDiKem
 from slcdv
 inner join hopdong hd
 ON hd.idHopDong=slcdv.idHopDong
 inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
-- 14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.
select hd.idHopDong,dvdk.TenDichVuDiKem,count(*) solansudung
from hopdong hd
inner join hopdongchitiet hdct
ON hd.idHopDong=hdct.HopDong_idHopDong
inner join dichvudikem dvdk
ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
group by hdct.DichVuDiKem_idDichVuDiKem
having solansudung<2 

-- 15 Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, DiaChi mới chỉ lập được tối đa 3 hợpđồng từ năm 2018 đến 2019
SELECT nv.idNhanVien,nv.HoTen,td.TrinhDo,bp.TenBoPhan,nv.SDT,nv.DiaChi,count(*) sohopdongdalam
from nhanvien nv
inner join trinhdo td
ON td.idTrinhDo=nv.TrinhDo_idTrinhDo
inner join bophan bp
ON bp.idBoPhan=nv.BoPhan_idBoPhan
inner join hopdong hd
ON nv.idNhanVien=hd.idNhanVien
where year(hd.NgayLamHopDong)=2018 or year(hd.NgayLamHopDong)=2019
group by hd.idNhanVien
having sohopdongdalam<4
-- 19
with sl as(
with slcdv as(
SELECT hd.idHopDong,hd.NgayLamHopDong,hd.NgayKetThuc,hd.TienDatCoc,count(*) as SoLuongDichVuDiKem
 FROM hopdong hd
 inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
 group by idHopDong
 )
 select count(SoLuongDichVuDiKem) SoLanSuDungDichVu,dvdk.TenDichVuDiKem
 from slcdv
 inner join hopdong hd
 ON hd.idHopDong=slcdv.idHopDong
 inner join hopdongchitiet hdct
 ON hd.idHopDong=hdct.HopDong_idHopDong
 inner join dichvudikem dvdk
 ON dvdk.idDichVuDiKem=hdct.DichVuDiKem_idDichVuDiKem
 group by hdct.DichVuDiKem_idDichVuDiKem)
 select *
 from sl
 inner join dichvudikem dvdk
 ON dvdk.TenDichVuDiKem=sl.TenDichVuDiKem
 update dichvudikem
 set dvdk.Gia=Gia*2
 where sl.SoLanSuDungDichVu>=2;

