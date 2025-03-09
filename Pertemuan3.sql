-- MANAJEMEN BASIS DATA
-- PERTEMUAN 3 
-- 25 FEB 2025
-- ----------------------------------------------------------

-- -------------------- TANPA PARAMETER --------------------
-- ----------------------- SOAL 1 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua proyek yang berlokasi di 'Houston'
DELIMITER $$
CREATE PROCEDURE ProjectByLocation()
BEGIN
	SELECT * from project
    Where Plocation = 'Houston';
END $$
DELIMITER ;
CALL ProjectByLocation;


-- ----------------------- SOAL 2 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua proyek yang berlokasi di 'Sugarland'
DELIMITER $$
DROP PROCEDURE ProjectByLocation;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ProjectByLocation()
BEGIN
	SELECT * from project
    Where Plocation = 'Sugarland';
END $$
DELIMITER ;
CALL ProjectByLocation;


-- ----------------------- SOAL 3 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data dari tabel DEPARTMENT 'Headquarters' 
SELECT * FROM DEPARTMENT;
DELIMITER $$
CREATE PROCEDURE Dept_Name()
BEGIN
	SELECT * FROM DEPARTMENT
    WHERE Dname = 'Headquarters';
END $$
DELIMITER ;
CALL Dept_Name;


-- ----------------------- SOAL 4 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data karyawan yang bekerja di departemen nomor 5 
DELIMITER $$
CREATE PROCEDURE Emp_5()
BEGIN
	SELECT * FROM EMPLOYEE
    WHERE Dno = 5;
END $$
DELIMITER ;
CALL Emp_5;


-- ----------------------- SOAL 5 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data karyawan yang bekerja di departemen 'Research' (Pakai JOIN)
DELIMITER $$
CREATE PROCEDURE Emp_Research()
BEGIN
	SELECT * 
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.Dno = D.Dnumber
    WHERE D.Dname = 'Research';
END $$
DELIMITER ;
Call Emp_Research;
select * from department;

-- ----------------------- SOAL 6 -------------------------- 
-- Buatlah Procedure untuk menampilkan semua data proyek yang berada di bawah departemen 'Research' (Pakai JOIN)
select * from project;
select * from department;
DELIMITER $$
CREATE PROCEDURE Proj_Research()
BEGIN
	SELECT * 
    FROM project P
    JOIN department D ON p.Dnum = D.Dnumber
    WHERE D.Dname = 'Research';
END $$
DELIMITER ;
Call Proj_Research();
select * from department;

-- Buatlah Procedure untuk menampilkan semua data proyek yang berada di bawah departemen 'Research' (Tidak Pakai JOIN)
select * from project;
DELIMITER $$
CREATE PROCEDURE Proj_Lima()
BEGIN
	SELECT * 
    FROM project P
    WHERE Dnum = 5;
END $$
DELIMITER ;
Call Proj_Lima;

-- ----------------------- SOAL 7 -------------------------- 
-- Buatlah Procedure untuk menampilkan nama department dari product yg nama nya adalah 'productX' (Pakai JOIN)
DELIMITER $$
CREATE PROCEDURE getDeptProductX()
BEGIN
	SELECT d.Dname FROM department d join project p on p.Dnum = d.Dnumber
    WHERE p.pname = 'productX';
END $$
DELIMITER ;
CALL getDeptProductX();

-- ----------------------- SOAL 8 -------------------------- 
-- Buatlah Procedure untuk menampilkan nama & tanggal lahir dari employee yg lahir sebelum tahun 1970
DELIMITER $$
CREATE PROCEDURE getEmployee()
BEGIN
	SELECT Fname, Bdate from employee
    WHERE Year(Bdate) < 1970;
END $$
DELIMITER ;
CALL getEmployee();

-- --------------------- PARAMETER IN ----------------------
-- ----------------------- SOAL 9 -------------------------- 
-- Buatlah Procedure untuk menampilkan nama & nomor department yang department namenya adalah 'Research'
DELIMITER $$
CREATE PROCEDURE getDepResearch(IN name varchar(15))
BEGIN
	SELECT dname, dnumber FROM department
    WHERE dname = name;
END $$
DELIMITER ;
CALL getDepResearch('Research');

-- ----------------------- SOAL 10 -------------------------- 
-- Buatlah Procedure untuk menampilkan nama depan & nama belakang karyawan yg berkerja di department 'Research'
DELIMITER $$
CREATE PROCEDURE getEmp(IN name varchar(15))
BEGIN
	SELECT e.fname, e.lname FROM employee e join department d
    on e.Dno = d.Dnumber
    WHERE dname = name;
END $$
DELIMITER ;
CALL getEmp('Research');

-- ----------------------- SOAL 11 -------------------------- 
-- Buatlah Procedure untuk menampilkan nama dependent dari karyawan yg nama depannya 'Franklin'
DELIMITER $$
CREATE PROCEDURE getDep(IN name varchar(15))
BEGIN
	SELECT d.Dependent_name FROM dependent d join employee e
    on d.essn = e.ssn
    WHERE e.fname = name;
END $$
DELIMITER ;
CALL getDep('Franklin');

-- ----------------------- SOAL 12 -------------------------- 
-- Buatlah Procedure untuk menampilkan karyawan dengan gaji sebesar 30.000.
SELECT * FROM EMPLOYEE;
DELIMITER $$
CREATE PROCEDURE Emp_tiga(IN Gaji Decimal(5,0))
BEGIN
	SELECT * 
    FROM EMPLOYEE E
    WHERE Salary = Gaji;
END $$
DELIMITER ;
CALL Emp_tiga(30000);


-- ----------------------- SOAL 13 -------------------------- 
-- Buatlah procedure unyuk menampilkan Essn dari tabel dependent berdasarkan nama = 'Alice'
select * from dependent;
select * from employee;
DESCRIBE dependent;
DELIMITER $$
CREATE PROCEDURE E_Alice(IN nama VARCHAR(15))
BEGIN
	SELECT Essn
    FROM dependent
    WHERE Dependent_name = nama;
END $$
DELIMITER ;
CALL E_Alice('Alice');


-- -------------------- PARAMETER OUT ----------------------
-- ----------------------- SOAL 14 -------------------------- 
-- Buatlah Procedure untuk menghitung jumlah proyek di Stafford. 
select * from project; 
DELIMITER $$ 
CREATE PROCEDURE sumStafford(IN location varchar(15), OUT jum INT)
BEGIN
	SELECT COUNT(Pnumber) into jum
    from project
    Where Plocation = location;
END $$ 
DELIMITER ;
CALL sumStafford('Stafford', @jumlah);
select @jum as Jumlah_Stafford;


-- ----------------------- SOAL 15 -------------------------- 
-- Buatlah Procedure untuk menghitung jumlah proyek di Houston
DELIMITER $$ 
CREATE PROCEDURE sumHouston(IN location varchar(15), OUT suma INT)
BEGIN
	SELECT COUNT(Pnumber) into suma
    from project
    Where Plocation = location;
END $$ 
DELIMITER ;
CALL sumHouston('Houston', @jumlah);
select @jumlah as Jumlah_Houston;


-- ----------------------- SOAL 16 -------------------------- 
-- Buatlah Procedure Emp_lima untuk menghitung jumlah karyawan dalam suatu departemen, nomor departemen = 5
select * from employee;
describe employee;
DELIMITER $$ 
CREATE PROCEDURE Emp_lima(IN denum int, OUT jml INT)
BEGIN
	SELECT COUNT(Ssn) into jml
    from employee
    Where Dno = denum;
END $$ 
DELIMITER ;
call Emp_lima(5, @jmlh);
select @jmlh as Jumlah_dept5;

-- ----------------------- SOAL 17 -------------------------- 
-- Buatlah Procedure untuk menghitung jumlah dependent dari karyawan yg nama depannya 'Franklin'
DELIMITER $$
CREATE PROCEDURE sumDep(IN name varchar(15) , OUT amount INT)
BEGIN
	SELECT COUNT(d.dependent_name) INTO amount
    FROM employee e join dependent d on e.ssn = d.essn
    WHERE e.fname = name ;
END $$
DELIMITER ;
CALL sumDep("Franklin", @jumlah);
SELECT @jumlah AS total;

-- ------------------ PARAMETER INOUT ---------------------
-- ----------------------- SOAL 18 -------------------------- 
-- Ubah salary, untuk employee yang salary < 30000 menjadi salary = 320000
DELIMITER $$
CREATE PROCEDURE modifySalary(INOUT gaji decimal(5,0))
BEGIN
	IF gaji <=30000 THEN
    SET gaji = 32000;
    END IF;
END $$
DELIMITER ;


SELECT Salary into @newSalary
	FROM employee
	WHERE Ssn = '987987987';
select @newSalary;
Call modifySalary(@newSalary);
select @newSalary;

-- ----------------------- SOAL 19 -------------------------- 
-- Ubah nama depan, untuk employee yang nama depannya 'Jennifer' menjadi 'Ica'
DELIMITER $$
CREATE PROCEDURE modifyName(INOUT fname varchar(15))
BEGIN
	IF fname = 'Jennifer' THEN
		SET fname = 'Ica' ;
    END IF;
END $$
DELIMITER ;

SELECT fname into @newName
    FROM employee
    WHERE Ssn = '987654321';
SELECT @newName;
CALL modifyName(@newName);
SELECT @newName;

-- ----------------------------------------------------------
-- ---------------------  MERCI  ----------------------------
-- ----------------------------------------------------------