-- MANAJEMEN BASIS DATA
-- PERTEMUAN 4 
-- 4 MAR 2025
-- --------------------------------------------------

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;

-- ------------------- PEMANASAN -------------------
-- -------------------- CONTOH 1 -------------------
-- Buat VIEW untuk menampilkan semua data employee
create view getAllEmp as
select * from employee;
-- test contoh 1
select * from getAllEmp;
-- --------------------------------------------------
-- -------------------- CONTOH 2 -------------------
-- Buat VIEW untuk menampilkan nomor & nama department
create view getDept as
select
    Dnumber,
    Dname
from department;
-- test contoh 2
select * from getDept;
-- --------------------------------------------------

-- --------------------- VIEW ----------------------
-- --------------------- SOAL 1 --------------------
-- Buatlah sebuah VIEW untuk menampilkan nama karyawan dan rata-rata jam kerja mereka 
-- berdasarkan data dari tabel `employee` dan `works_on`. Setelah itu, tampilkan seluruh isi dari view tersebut. 
CREATE VIEW emp_avg AS  
SELECT  
    e.Fname AS nama_emp,  
    AVG(w.hours) AS rata_rata  
FROM employee e  
JOIN works_on w ON e.SSN = w.Essn  
GROUP BY e.Fname;
-- test soal 1
SELECT * FROM emp_avg;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 2 ---------------------
-- Buatlah VIEW bernama untuk menampilkan nama karyawan dan rata-rata jam kerja mereka. 
-- Dta dari tabel `employee` dan `works_on`, dengan pengelompokan berdasarkan SSN dan Fname 
CREATE VIEW emp_avg_work AS  
SELECT  
    E.Fname AS Nama_EMP,  
    AVG(W.Hours) AS Rata_Rata_Jam_Kerja  
FROM employee E  
JOIN works_on W ON E.SSN = W.ESSN  
GROUP BY E.SSN, E.Fname;  
-- test soal 2
SELECT * FROM emp_avg_work;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 3 ---------------------
-- Buatlah VIEW untuk menampilkan nama karyawan dan jumlah tanggungan mereka 
-- Data dari tabel employee dan DEPENDENT
CREATE VIEW EMP_DEP AS  
SELECT  
    E.FNAME,  
    COUNT(D.ESSN) AS DEPENDENT  
FROM employee E  
JOIN DEPENDENT D ON E.SSN = D.ESSN  
GROUP BY E.SSN, D.ESSN;  
-- test soal 3
SELECT * FROM EMP_DEP;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 4 ---------------------
-- Buatlah sebuah VIEW yang berisi informasi tentang karyawan dan departemen tempat mereka bekerja. 
-- View menampilkan nama karyawan, nama departemen, lokasi departemen, serta jumlah tanggungan yang dimiliki oleh setiap karyawan. 
-- Data diambil dari tabel employee, department, dept_locations, dan dependent
-- Karyawan tetap ditampilkan meskipun tidak memiliki tanggungan.
CREATE VIEW emp_dept_info AS  
SELECT  
    E.Fname AS Nama_EMP,  
    D.Dname AS NamaDEPT,  
    L.Dlocation AS Lokasi_DEPT,  
    COUNT(P.Ssn) AS JMLH_DEPENDENT  
FROM employee E  
JOIN department D ON E.Dno = D.Dnumber  
JOIN dept_locations L ON D.Dnumber = L.Dnumber  
JOIN dependent P ON E.Ssn = P.EmpSsn  
GROUP BY E.Ssn, E.Fname, D.Dname, L.Dlocation;  
-- test soal 4
SELECT * FROM emp_dept_info;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 5 ---------------------
-- Buatlah sebuah VIEW untuk menampilkan jumlah total karyawan dengan gaji lebih dari 30.000
CREATE VIEW EMP_30 AS  
SELECT  
    COUNT(*) AS TOTAL  
FROM EMPLOYEE  
WHERE SALARY > 30000; 
-- test soal 5
SELECT * FROM EMP_30;

-- --------------------------------------------------
-- --------------------- SOAL 6 ---------------------
-- Buatlah sebuah VIEW yang menampilkan daftar nsms proyek beserta jumlah total karyawan yang bekerja pada setiap proyek. 
select * from works_on;
CREATE VIEW v_proj AS  
SELECT  
    p.Pname,  
    COUNT(w.Essn) AS total_karyawan  
FROM project p  
JOIN works_on w ON p.Pnumber = w.Pno  
GROUP BY w.Pno, p.Pname;  
-- test soal 6
SELECT * FROM v_proj;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 7 ---------------------  
-- Buatlah sebuah VIEW untuk menampilkan informasi karyawan beserta departemen tempat mereka bekerja. 
-- View menampilkan `Fname`, `Lname`), dan `Dname` 
CREATE VIEW emp_dept AS  
SELECT  
    e.Fname,  
    e.Lname,  
    d.Dname  
FROM employee e  
JOIN department d ON e.Dno = d.Dnumber;
-- test soal 7
SELECT * FROM emp_dept;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 8 ---------------------
-- Buatlah sebuah VIEW untuk menampilkan seluruh data karyawan yang bekerja di departemen dengan nomor 5
CREATE VIEW emp_lima AS  
SELECT *  
FROM employee  
WHERE Dno = 5; 
-- test soal 8
SELECT * FROM emp_lima;
-- --------------------------------------------------


-- -------------------- TRIGGER --------------------- 
-- --------------------- SOAL 9 ---------------------
-- Buatlah sebuah TRIGGER yang akan dijalankan sebelum melakukan INSERT pada tabel `employee`. 
-- Trigger ini harus memeriksa apakah SSN yang dimasukkan sudah ada dalam tabel. 
-- Jika SSN tersebut sudah terdaftar, maka proses insert harus dibatalkan dan 
-- menampilkan pesan error "SSN sudah terdaftar, input ditolak"
select * from employee;
DELIMITER $$
CREATE TRIGGER before_insert_karyawan
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM employee WHERE ssn = NEW.ssn) > 0 THEN
    -- cara lain: IF (OLD.SSN <> NEW.SSN) THEN
    -- cara lain: IF EXISTS (SELECT 1 FROM EMPLOYEE WHERE SSN = NEW.SSN) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'SSN sudah terdaftar, input ditolak';
    END IF;
END$$
DELIMITER ;
-- Test Trigger before_insert_karyawan
INSERT INTO employee (Fname, ssn) VALUES ('Wonbin', '333445555');
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 10 ---------------------
-- Buatlah sebuah TRIGGER bernama before_salary yang akan dijalankan sebelum melakukan UPDATE pada tabel employee. 
-- Trigger ini harus memastikan bahwa gaji karyawan tidak boleh kurang dari 30.000. 
-- Jika ada percobaan untuk mengubah gaji menjadi kurang dari nilai tersebut, maka proses update harus dibatalkan. 
DELIMITER $$
CREATE TRIGGER before_salary  
BEFORE UPDATE ON employee  
FOR EACH ROW  
BEGIN  
    IF NEW.salary < 30000 THEN  
        SIGNAL SQLSTATE '45000'  
        SET MESSAGE_TEXT = 'GAJI UDAH KECIL';  
    END IF;  
END $$
DELIMITER ;
-- Test Trigger before_salary
UPDATE EMPLOYEE
SET SALARY = '9000'
where fname = 'john';
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 11 --------------------
-- Buat trigger untuk mencegah nama dept dengan nama yang sama
SELECT * FROM DEPARTMENT;
DELIMITER $$
CREATE TRIGGER before_insert_dept
BEFORE INSERT ON department
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM department WHERE DNAME = NEW.DNAME) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nama department sudah ada, input ditolak';
    END IF;
END$$
DELIMITER ;
-- Test Trigger before_insert_dept
INSERT INTO DEPARTMENT(DNAME) VALUES ('Research');

-- Cara Lain:
DELIMITER $$
CREATE TRIGGER before_insert_department
BEFORE INSERT ON DEPARTMENT
FOR EACH ROW
BEGIN
    DECLARE dept_count INT;
    -- Periksa apakah nama departemen sudah ada
    SELECT COUNT(*) INTO dept_count
    FROM DEPARTMENT
    WHERE Dname = NEW.Dname;
    -- Jika nama departemen sudah ada, batalkan operasi
    IF dept_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Nama departemen sudah ada.';
    END IF;
END $$
DELIMITER ;
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 12 --------------------
-- Buat trigger untuk mencegah penghapusan department jika ada karyawannya
DELIMITER $$
CREATE TRIGGER avoidDelDept
BEFORE DELETE ON DEPARTMENT
FOR EACH ROW
begin
	IF EXISTS (SELECT 1 FROM DEPARTMENT d join EMPLOYEE e on d.Dnumber = e.Dno) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gagal! ada karyawan di dalam department';
	END IF;
END$$
DELIMITER ;
-- Test Trigger avoidDelDept
SET SQL_SAFE_UPDATES = 0;
DELETE FROM DEPARTMENT
WHERE Dname = 'Research';
-- --------------------------------------------------

-- --------------------------------------------------
-- --------------------- SOAL 13 --------------------
-- Buat trigger untuk mencegah penghapusan karyawan yg punya dependent
DELIMITER $$
CREATE TRIGGER avoidDelDepend
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
begin
	IF EXISTS (SELECT 1 FROM EMPLOYEE e join DEPENDENT d on e.ssn = d.essn) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gagal! Pegawai sudah punya Dependent';
	END IF;
END$$
DELIMITER ;
-- Test Trigger avoidDelDepend
SET SQL_SAFE_UPDATES = 0;
DELETE FROM EMPLOYEE
WHERE FNAME = 'john';
-- --------------------------------------------------

-- ----------------------------------------------------------
-- ---------------------  MERCI  ----------------------------
-- ----------------------------------------------------------