-- MANAJEMEN BASIS DATA
-- PERTEMUAN 2
-- 18 FEB 2025
-- ----------------------------------------------------------

-- -------------------- TANPA PARAMETER -------------------- --
-- Buatlah Procedure untuk menampilkan semua proyek yg berlokasi di 'Stafford'
DELIMITER $$

DROP PROCEDURE getProjectsByLocation;
CREATE PROCEDURE getProjectsByLocation()
BEGIN
	SELECT * FROM PROJECT
    WHERE PLOCATION = 'Stafford';
END$$

DELIMITER ;

CALL getProjectsByLocation();


-- --------------------- PARAMETER IN ---------------------- --
-- Buatlah sebuah stored procedure untuk menampilkan semua proyek yg berlokasi di 'Stafford'
DELIMITER $$

DROP PROCEDURE getProjectsByLocation2;
CREATE PROCEDURE getProjectsByLocation2(IN location varchar(15))
BEGIN
	SELECT * FROM project
    WHERE Plocation = location;
END$$

DELIMITER ;

CALL getProjectsByLocation2("Stafford");


-- --------------------- PARAMETER OUT --------------------- --
-- Buatlah Procedure untuk menampilkan jumlah proyek yg berlokasi di 'Stafford'
DELIMITER $$
DROP PROCEDURE getPorjectsCountByLocation3;
CREATE PROCEDURE getPorjectsCountByLocation3(
	IN location varchar (15),
    OUT amount INT
)
BEGIN
	SELECT COUNT(Pnumber) INTO amount
    FROM project
    WHERE Plocation = location;
END$$
DELIMITER ;
CALL getPorjectsCountByLocation3('Stafford', @jumlah);
SELECT @jumlah AS jumlah_project;


-- ------------------- PARAMETER IN OUT -------------------- --
-- Ubah salary, untuk employee yang salary < 30000 menjadi salary = 320000
DELIMITER $$
DROP PROCEDURE modifySalary;
CREATE PROCEDURE modifySalary(INOUT Salary decimal(5,0))
BEGIN
	IF Salary<26000 THEN
		SET Salary = 27000;
    END IF;
END$$
DELIMITER ;

SELECT Salary into @newSalary
FROM employee
WHERE Ssn = 999887777;
SELECT @newSalary;
CALL modifySalary(@newSalary);
SELECT @newSalary;


