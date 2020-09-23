/*
Bài 1: Để quản lý Thực tập nghề nghiệp của sinh viên, người ta xây dựng một cơ sở dữ liệu có tên là ThucTap gồm các sơ đồ quan hệ sau:
Khoa(makhoa char(10), tenkhoa char(30), dienthoai char(10))
GiangVien(magv int, hotengv char(30), luong decimal(5,2), makhoa char(10))
SinhVien(masv int, hotensv char(30), makhoa char(10), namsinh int, quequan char(30))
DeTai(madt char(10), tendt char(30), kinhphi int, NoiThucTap char(30))
HuongDan(masv int, madt char(10), magv int, ketqua decimal(5,2))
*/
create database controllerFresher
use controllerFresher
create table khoa(
IdOfDepartment nvarchar(10) not null primary key,--mã khoa
nameDepartment nvarchar(50),--tên khoa
phone nvarchar(10),--số điện thoại
)
go
create table GiangVien(
IdOfTeacher int not null primary key,--mã giáo viên
nameTeacher nvarchar(100),--tên giáo viên
salary decimal(5,2),--mức lương
IdOfDepartment nvarchar(10),--mã khoa sẽ làm khóa ngoại tham chiếu đến mã khoa
--<=> giáo viên này dạy ở khoa nào
constraint FK1 foreign key(IdOfDepartment) references khoa(idOfDepartment) 
)
go
create table student(
IdOfStudent int not null primary key,--mã học sinh
nsnt nvarchar(100) not null,--tên học sinh
IdOfDepartment nvarchar(10),--mã khoa<=>sinh viên này học khoa nào
yearOfBirth int,--năm sinh
address nvarchar(100),--địa chỉ của sinh viên này
constraint FK2 foreign key (IdOfDepartment) references khoa(idOfDepartment)
)
go
create table topic(
IdOfTopic varchar(10) not null primary key,--mã đề tài
nameTopic nvarchar(50),--tên đề tài làm là gì
feeOfTopic int,--mức phí để hoàn thành là bao nhiêu
placeOfWork nvarchar(100)--nơi thực tập
)
go
/*
HuongDan(masv int, madt char(10), magv int, ketqua decimal(5,2))*/
create table support(
IdOfStudent int not null primary key,
IdOfTopic varchar(10) not null,
IdOfTeacher int not null,
result decimal(5,2) not null,
constraint FK3 foreign key(IdOfTopic) references topic(IdOfTopic),
constraint FK4 foreign key(IdOfTeacher) references GiangVien(IdOfTeacher)
)
go
use controllerFresher
insert into khoa values
('DT1','Dien Dien Tu','09055873'),
('DT2','Cong Nghe Thong Tin','03382574'),
('DT3','Cong Nghe Da Phuong Tien','09083456'),
('DT4','Dien Tu Vien Thong','090558744'),
('DT5','Marketing','09072345'),
('DT6','Ke Toan','07755588'),
('DT7','Dieu Khien Tu Dong Hoa','090559873'),
('DT8','Thuong Mai Dien Tu','09934514'),
('DT9','Dien Tu Vien Thong','09988725')
go
insert into GiangVien values
(1,'Nguyen Truong Giang',123,'DT2'),
(2,'Nguyen Thu Diem',135,'DT1'),
(3,'Nguyen Hong An',199,'DT1'),
(4,'Duong Truong Giang',255,'DT3'),
(5,'La Quoc Tuan',247,'DT4'),
(6,'Le Thi Anh Nhi',999,'DT5'),
(7,'Nguyen Thai Hoang',123,'DT6'),
(8,'Lai Thi Thanh Huong',245,'DT6'),
(9,'Nguyen Thai Sum',433,'DT7'),
(10,'Nguyen Hoang Duong',998,'DT8'),
(11,'Thai Thieu Phan',123,'DT9')
go
insert into student values
(1,'Le Quang Tung','DT1',2000,'Quang Ngai'),
(2,'Le Thi Yen Nhi','DT1', 2000,'Quang Nam'),
(3,'Nguyen Van Chung','DT1',2000,'Ha Noi'),
(4,'Le Quy Quang','DT2',1998,'Thanh Hoa'),
(5,'Tran Thi Huyen Trang','DT3',2001,'Da Nang'),
(6,'La Thai Phuc','DT4',2003,'Hue'),
(7,'Nguyen Truong My Thuan,','DT5',2004,'Nam Dinh'),
(8,'Duong Ngoc Vien','DT6',2001,'Nha Trang'),
(9,'Tran Minh Vuong','DT7',2002,'Thai Nguyen'),
(10,'La Thai Long','DT8',2008,'Ha Giang'),
(11,'Nguyen Ngoc Trang','DT9',2003,'Cao Bang')
go
insert into topic values
('KT1','Dieu Khien Tu Dong',1500000,'FPT'),
('KT2','ROBOT',1000000,'Nash Tech'),
('KT3','ChatBox',2000000,'ReNaSat'),
('KT4','Nhan Dien Giong Noi',1300000,'FPT'),
('KT5','Tri Tue Nhan Tao Y Hoc',5000000,'AXON'),
('KT6','May Phat Hien Tam Trang Ung Dung AI',3000000,'Bosch'),
('KTT1','startUp Cafe Chon',20000000,'Lik'),
('KTT2','StartUp Ong Hut Tre',10000000,'Bik'),
('KTT3','Cong Ty Thuong Mai Dien Tu',30000000,'LOPKP'),
('KTTT4','Tam Hut Vang Dau',2000000,'KOPLOP')
insert into support values
(1,'KT1',1,100),
(2,'KT2',2,200),
(3,'KT3',1,300),
(4,'KT4',2,290),
(5,'KT5',3,150),
(6,'KTT1',4,270),
(7,'KTT2',4,250),
(8,'KTT3',6,189),
(9,'KTTT4',7,370),
(10,'KT1',8,990),
(11,'KTTT4',9,120),
(12,'KTT3',10,210)
/*
1.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
2.xuat ra thong tin nhung giang vien khong day khoa nao
2.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa DT1, DT5
3.Cho biết số sinh viên của khoa ‘Cong Nghe Thong Tin’
4.Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘DT6’
5.Cho biết số giảng viên của khoa ‘DT1’
6.Cho biết thông tin về sinh viên không tham gia thực tập.i
7.Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
7.Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học*/
use controllerFresher
select gv.IdOfTeacher, gv.nameTeacher, dp.nameDepartment from GiangVien as gv,khoa as dp
where dp.IdOfDepartment = gv.IdOfDepartment
--------------------------------------------------------------------------------------------------------------
select gv.nameTeacher from GiangVien as gv
where gv.IdOfDepartment not in (select dp.IdOfDepartment from khoa as dp)
--------------------------------------------------------------------------------------------------------------
select gv.IdOfteacher,gv.nameTeacher,dp.nameDepartment from GiangVien as gv
inner join khoa as dp on dp.IdOfDepartment = gv.IdOfDepartment
where gv.IdOfDepartment ='DT1' or gv.IdOfDepartment ='DT5'
--<=>
select gv.IdOfTeacher,gv.nameTeacher,dp.nameDepartment from GiangVien as gv, khoa as dp
where gv.IdOfDepartment = dp.IdOfDepartment
and (dp.nameDepartment ='Dien Dien Tu'or dp.nameDepartment ='Cong Nghe Thong Tin')
----------------------------------------------------------------------------------------------------------------
declare @countStudent int 
select @countStudent = count(*) from student as st where st.IdOfDepartment ='DT1'
print @countStudent
----------------------------------------------------------------------------------------------------------------
select s.IdOfStudent, s.nameStudent, s.yearOfBirth from student as s where s.IdOfDepartment ='DT1'
-----------------------------------------------------------------------------------------------------------------
declare @count int
select @count = count(*) from GiangVien as gv where gv.IdOfDepartment = 'DT1'
print @count
-----------------------------------------------------------------------------------------------------------------
select k.IdOfDepartment, k.nameDepartment,COUNT(gv.IdOfTeacher) from khoa as k, GiangVien as gv
where gv.IdOfDepartment = k.IdOfDepartment
group by k.IdOfDepartment, k.nameDepartment
-----------------------------------------------------------------------------------------------------------------
select dp.phone from khoa as dp
inner join student as s on s.IdOfDepartment = dp.IdOfDepartment
where s.nameStudent= 'Tran Thi Huyen Trang'
------------------------------------------------------------------------------------------------------------------
/*
Cho biết mã số và tên của các đề tài do giảng viên ‘Nguyen Thai Sum’ hướng dẫn
Cho biết tên đề tài không có sinh viên nào thực tập
Cho biết gvsố, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘Dien Dien Tu và Cong Nghe Thong Tin’
Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
Cho biết thông tin về các sinh viên thực tập tại quê nhà
Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng lon hon 300
*/
select tp.IdOfTopic,tp.nameTopic from topic as tp
inner join support as sp on sp.IdOfTopic = tp.IdOfTopic
inner join GiangVien as gv on gv.IdOfTeacher = sp.IdOfTeacher
where gv.nameTeacher ='Nguyen Thai Sum'
------------------------------------------------------------------------------------------------------------------
/*
minh nghi la no thieu: mot topic se co nhieu sinh vien dang ki
*/
declare @IdOfStudent int
select @IdOfStudent = IdOfStudent from student
select tp.nameTopic from topic as tp
inner join support as sp on sp.IdOfTopic = tp.IdOfTopic
inner join student as s on s.IdOfStudent <> sp.IdOfStudent
------------------------------------------------------------------------------------------------------------------
declare @maxfee int
select @maxfee = max(t.feeOfTopic) from topic as t
select t.nameTopic from topic as t
where t.feeOfTopic = @maxfee
------------------------------------------------------------------------------------------------------------------
--sp: tim ten topic co muc phi thu hai
declare @secondMaxOfFee int
select @secondMaxOfFee =(select max(result.feeOfTopic)from(
select t.feeOfTopic from topic as t
where t.feeOfTopic != (select max(t.feeOfTopic) from topic as t)) as result)
select t.nameTopic from topic as t 
where t.feeOfTopic = @secondMaxOfFee
-------------------------------------------------------------------------------------------------------------------
---------checkagain---------
select gv.IdOfTeacher, gv.nameTeacher,gv.IdOfDepartment from GiangVien as gv
inner join khoa as dp on gv.IdOfDepartment = dp.IdOfDepartment
-------------------------------------------------------------------------------------------------------------------
select s.nameStudent , s.IdOfStudent from student as s 
inner join khoa as dp on dp.IdOfDepartment = s.IdOfDepartment
where dp.nameDepartment ='Dien Dien Tu' or dp.nameDepartment ='Cong Nghe Thong Tin'
--------------------------------------------------------------------------------------------------------------------
select dp.nameDepartment, count(s.IdOfStudent) from khoa as dp, student as s
where s.IdOfDepartment = dp.IdOfDepartment
group by dp.nameDepartment
--------------------------------------------------------------------------------------------------------------------
select s.IdOfStudent, s.nameStudent from student as s
inner join support as sp on sp.IdOfStudent = s.IdOfStudent
where sp.result >300