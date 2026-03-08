CREATE DATABASE hospital_db;
USE hospital_db;
-- ===============================
-- BLOCK TABLE
-- ===============================
CREATE TABLE block (
blockfloor INT NOT NULL,
blockcode INT NOT NULL,
PRIMARY KEY (blockfloor, blockcode)
);
INSERT INTO block VALUES
(1,1),(1,2),(1,3),
(2,1),(2,2),(2,3),
(3,1),(3,2),(3,3),
(4,1),(4,2),(4,3);
-- ===============================
-- ROOM TABLE
-- ===============================
CREATE TABLE room (
roomnumber INT PRIMARY KEY,
roomtype VARCHAR(20) NOT NULL,
blockfloor INT NOT NULL,
blockcode INT NOT NULL,
unavailable CHAR(1) NOT NULL,
FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);
INSERT INTO room VALUES

(101,'Single',1,1,'f'),
(102,'Single',1,1,'f'),
(103,'Single',1,1,'f'),
(111,'Single',1,2,'f'),
(112,'Single',1,2,'t'),
(113,'Single',1,2,'f'),
(121,'Single',1,3,'f'),
(122,'Single',1,3,'f'),
(123,'Single',1,3,'f'),
(201,'Single',2,1,'t'),
(202,'Single',2,1,'f'),
(203,'Single',2,1,'f'),
(211,'Single',2,2,'f'),
(212,'Single',2,2,'f'),
(213,'Single',2,2,'t'),
(221,'Single',2,3,'f'),
(222,'Single',2,3,'f'),
(223,'Single',2,3,'f'),
(301,'Single',3,1,'f'),
(302,'Single',3,1,'t'),
(303,'Single',3,1,'f'),
(311,'Single',3,2,'f'),
(312,'Single',3,2,'f'),
(313,'Single',3,2,'f'),
(321,'Single',3,3,'t'),
(322,'Single',3,3,'f'),
(323,'Single',3,3,'f'),
(401,'Single',4,1,'f'),
(402,'Single',4,1,'t'),
(403,'Single',4,1,'f'),
(411,'Single',4,2,'f'),
(412,'Single',4,2,'f'),
(413,'Single',4,2,'f'),
(421,'Single',4,3,'t'),
(422,'Single',4,3,'f'),
(423,'Single',4,3,'f');
-- ===============================
-- PHYSICIAN TABLE
-- ===============================
CREATE TABLE physician (
employeeid INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
ssn INT UNIQUE NOT NULL
);
INSERT INTO physician VALUES
(1,'John Dorian','Staff Internist',111111111),
(2,'Elliot Reid','Attending Physician',222222222),

(3,'Christopher Turk','Surgical Attending Physician',333333333),
(4,'Percival Cox','Senior Attending Physician',444444444),
(5,'Bob Kelso','Head Chief of Medicine',555555555),
(6,'Todd Quinlan','Surgical Attending Physician',666666666),
(7,'John Wen','Surgical Attending Physician',777777777),
(8,'Keith Dudemeister','MD Resident',888888888),
(9,'Molly Clock','Attending Psychiatrist',999999999);
-- ===============================
-- NURSE TABLE
-- ===============================
CREATE TABLE nurse (
employeeid INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
position VARCHAR(50) NOT NULL,
registered CHAR(1) NOT NULL,
ssn INT UNIQUE NOT NULL
);
INSERT INTO nurse VALUES
(101,'Carla Espinosa','Head Nurse','t',111111110),
(102,'Laverne Roberts','Nurse','t',222222220),
(103,'Paul Flowers','Nurse','f',333333330);
-- ===============================
-- DEPARTMENT TABLE
-- ===============================
CREATE TABLE department (
department_id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
head INT NOT NULL,
FOREIGN KEY (head) REFERENCES physician(employeeid)
);
INSERT INTO department VALUES
(1,'General Medicine',4),
(2,'Surgery',7),
(3,'Psychiatry',9);
-- ===============================
-- AFFILIATED_WITH TABLE
-- ===============================
CREATE TABLE affiliated_with (
physician INT,
department INT,
primaryaffiliation CHAR(1),
PRIMARY KEY (physician, department),
FOREIGN KEY (physician) REFERENCES physician(employeeid),
FOREIGN KEY (department) REFERENCES department(department_id)
);

INSERT INTO affiliated_with VALUES
(1,1,'t'),
(2,1,'t'),
(3,1,'f'),
(3,2,'t'),
(4,1,'t'),
(5,1,'t'),
(6,2,'t'),
(7,1,'f'),
(7,2,'t'),
(8,1,'t'),
(9,3,'t');
-- ===============================
-- PATIENT TABLE
-- ===============================
CREATE TABLE patient (
ssn INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL,
phone VARCHAR(15) NOT NULL,
insuranceid INT NOT NULL,
pcp INT NOT NULL,
FOREIGN KEY (pcp) REFERENCES physician(employeeid)
);
INSERT INTO patient VALUES
(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1),
(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2),
(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2),
(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);
-- ===============================
-- APPOINTMENT TABLE
-- ===============================
CREATE TABLE appointment (
appointmentid INT PRIMARY KEY,
patient INT NOT NULL,
prepnurse INT,
physician INT NOT NULL,
start_dt VARCHAR(20) NOT NULL,
end_dt VARCHAR(20) NOT NULL,
examinationroom CHAR(1) NOT NULL,
FOREIGN KEY (patient) REFERENCES patient(ssn),
FOREIGN KEY (prepnurse) REFERENCES nurse(employeeid),
FOREIGN KEY (physician) REFERENCES physician(employeeid)
);
INSERT INTO appointment VALUES

(13216584,100000001,101,1,'24/4/2008','24/4/2008','A'),
(26548913,100000002,101,2,'24/4/2008','24/4/2008','B'),
(36549879,100000001,102,1,'25/4/2008','25/4/2008','A'),
(46846589,100000004,103,4,'25/4/2008','25/4/2008','B'),
(59871321,100000004,NULL,4,'26/4/2008','26/4/2008','C'),
(69879231,100000003,103,2,'26/4/2008','26/4/2008','C'),
(76983231,100000001,NULL,3,'26/4/2008','26/4/2008','C'),
(86213939,100000004,102,9,'27/4/2008','27/4/2008','A'),
(93216548,100000002,101,2,'27/4/2008','27/4/2008','B');
-- ===============================
-- MEDICATION TABLE
-- ===============================
CREATE TABLE medication (
code INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
brand VARCHAR(50),
description VARCHAR(255)
);
INSERT INTO medication VALUES
(1,'Procrastin-X',NULL,'N/A'),
(2,'Thesisin','Foo Labs','N/A'),
(3,'Awakin','Bar Laboratories','N/A'),
(4,'Crescavitin','Baz Industries','N/A'),
(5,'Melioraurin','Snafu Pharmaceuticals','N/A');
-- ===============================
-- PRESCRIBES TABLE
-- ===============================
CREATE TABLE prescribes (
physician INT NOT NULL,
patient INT NOT NULL,
medication INT NOT NULL,
date VARCHAR(20) NOT NULL,
appointment INT,
dose INT NOT NULL,
FOREIGN KEY (physician) REFERENCES physician(employeeid),
FOREIGN KEY (patient) REFERENCES patient(ssn),
FOREIGN KEY (medication) REFERENCES medication(code),
FOREIGN KEY (appointment) REFERENCES appointment(appointmentid)
);
INSERT INTO prescribes VALUES
(1,100000001,1,'24/4/2008',13216584,5),
(9,100000004,2,'27/4/2008',86213939,10),
(9,100000004,2,'30/4/2008',NULL,5);
-- ===============================
-- PROCEDURES TABLE

-- ===============================
CREATE TABLE procedures (
code INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
cost INT NOT NULL
);
INSERT INTO procedures VALUES
(1,'Reverse Rhinopodoplasty',1500),
(2,'Obtuse Pyloric Recombobulation',3750),
(3,'Folded Demiophtalmectomy',4500),
(4,'Complete Walletectomy',10000),
(5,'Obfuscated Dermogastrotomy',4899),
(6,'Reversible Pancreomyoplasty',5600),
(7,'Follicular Demiectomy',25);
-- ===============================
-- TRAINED_IN TABLE
-- ===============================
CREATE TABLE trained_in (
physician INT NOT NULL,
treatment INT NOT NULL,
certificationdate VARCHAR(20) NOT NULL,
certificationexpires VARCHAR(20) NOT NULL,
PRIMARY KEY (physician, treatment),
FOREIGN KEY (physician) REFERENCES physician(employeeid),
FOREIGN KEY (treatment) REFERENCES procedures(code)
);
INSERT INTO trained_in VALUES
(3,1,'1/1/2008','31/12/2008'),
(3,2,'1/1/2008','31/12/2008'),
(3,5,'1/1/2008','31/12/2008'),
(3,6,'1/1/2008','31/12/2008'),
(3,7,'1/1/2008','31/12/2008'),
(6,2,'1/1/2008','31/12/2008'),
(6,5,'1/1/2007','31/12/2007'),
(6,6,'1/1/2008','31/12/2008'),
(7,1,'1/1/2008','31/12/2008'),
(7,2,'1/1/2008','31/12/2008'),
(7,3,'1/1/2008','31/12/2008'),
(7,4,'1/1/2008','31/12/2008'),
(7,5,'1/1/2008','31/12/2008'),
(7,6,'1/1/2008','31/12/2008'),
(7,7,'1/1/2008','31/12/2008');
-- ===============================
-- STAY TABLE
-- ===============================
CREATE TABLE stay (

stayid INT PRIMARY KEY,
patient INT NOT NULL,
roomnumber INT NOT NULL,
start_time VARCHAR(20) NOT NULL,
end_time VARCHAR(20) NOT NULL,
FOREIGN KEY (patient) REFERENCES patient(ssn),
FOREIGN KEY (roomnumber) REFERENCES room(roomnumber)
);
INSERT INTO stay VALUES
(3215,100000001,111,'1/5/2008','4/5/2008'),
(3216,100000003,123,'3/5/2008','14/5/2008'),
(3217,100000004,112,'2/5/2008','3/5/2008');
-- ===============================
-- ON_CALL TABLE
-- ===============================
CREATE TABLE on_call (
nurse INT NOT NULL,
blockfloor INT NOT NULL,
blockcode INT NOT NULL,
oncall VARCHAR(20) NOT NULL,
oncallend VARCHAR(20) NOT NULL,
PRIMARY KEY (nurse, blockfloor, blockcode, oncall),
FOREIGN KEY (nurse) REFERENCES nurse(employeeid),
FOREIGN KEY (blockfloor, blockcode) REFERENCES block(blockfloor, blockcode)
);
INSERT INTO on_call VALUES
(101,1,1,'4/11/2008','4/11/2008'),
(101,1,2,'4/11/2008','4/11/2008'),
(102,1,3,'4/11/2008','4/11/2008'),
(103,1,1,'4/11/2008','4/11/2008'),
(103,1,2,'4/11/2008','4/11/2008'),
(103,1,3,'4/11/2008','4/11/2008');
-- ===============================
-- UNDERGOES TABLE
-- ===============================
CREATE TABLE undergoes (
patient INT NOT NULL,
procedure_id INT NOT NULL,
stay INT NOT NULL,
date VARCHAR(20) NOT NULL,
physicianassist INT NOT NULL,
ingnurse INT,
FOREIGN KEY (patient) REFERENCES patient(ssn),
FOREIGN KEY (procedure_id) REFERENCES procedures(code),
FOREIGN KEY (stay) REFERENCES stay(stayid),
FOREIGN KEY (physicianassist) REFERENCES physician(employeeid),

FOREIGN KEY (ingnurse) REFERENCES nurse(employeeid)
);
INSERT INTO undergoes VALUES
(100000001,6,3215,'2/5/2008',3,101),
(100000001,2,3215,'3/5/2008',7,101),
(100000004,1,3217,'7/5/2008',3,102),
(100000004,5,3217,'9/5/2008',6,NULL),
(100000001,7,3217,'10/5/2008',7,101),
(100000004,4,3217,'13/5/2008',3,103);


USE hospital_db;

-- 1. Physicians who are not yet primarily affiliated with a department
SELECT p.name AS Physician_Name, d.name AS Department_Name
FROM physician p
JOIN affiliated_with a ON p.employeeid = a.physician
JOIN department d ON a.department = d.department_id
WHERE a.primaryaffiliation = 'f';


-- 2. Patients and their primary physicians (preliminary treatment)
SELECT pt.name AS Patient_Name, ph.name AS Primary_Physician
FROM patient pt
JOIN physician ph ON pt.pcp = ph.employeeid;


-- 3. Patients and number of physicians they took appointments with
SELECT pt.name AS Patient_Name,
       COUNT(DISTINCT a.physician) AS Number_of_Physicians_Visited
FROM patient pt
JOIN appointment a ON pt.ssn = a.patient
GROUP BY pt.name;


-- 4. Count of unique patients who had appointment in Room C
SELECT COUNT(DISTINCT patient) AS Unique_Patients_In_Room_C
FROM appointment
WHERE examinationroom = 'C';


-- 5. Patients and room number where they stayed for treatment
SELECT pt.name AS Patient_Name, s.roomnumber AS Room_Number
FROM patient pt
JOIN stay s ON pt.ssn = s.patient;


-- 6. Nurses and rooms where they assisted physicians
SELECT n.name AS Nurse_Name, a.examinationroom AS Room_Scheduled
FROM nurse n
JOIN appointment a ON n.employeeid = a.prepnurse;


-- 7. Patients who had appointment on 25/4/2008 with physician, nurse & room
SELECT pt.name AS Patient_Name,
       ph.name AS Physician,
       n.name AS Assisting_Nurse,
       a.examinationroom AS Room_Number
FROM appointment a
JOIN patient pt ON a.patient = pt.ssn
JOIN physician ph ON a.physician = ph.employeeid
LEFT JOIN nurse n ON a.prepnurse = n.employeeid
WHERE a.start_dt = '25/4/2008';


-- 8. Patients and physicians where no nurse assistance was required
SELECT pt.name AS Patient_Name, ph.name AS Physician
FROM appointment a
JOIN patient pt ON a.patient = pt.ssn
JOIN physician ph ON a.physician = ph.employeeid
WHERE a.prepnurse IS NULL;


-- 9. Patients, their physicians and prescribed medication
SELECT pt.name AS Patient_Name,
       ph.name AS Physician,
       m.name AS Medication_Name
FROM prescribes pr
JOIN patient pt ON pr.patient = pt.ssn
JOIN physician ph ON pr.physician = ph.employeeid
JOIN medication m ON pr.medication = m.code;


-- 10. Patients with advanced appointment (prescription without appointment)
SELECT pt.name AS Patient_Name,
       ph.name AS Physician,
       m.name AS Medication_Name
FROM prescribes pr
JOIN patient pt ON pr.patient = pt.ssn
JOIN physician ph ON pr.physician = ph.employeeid
JOIN medication m ON pr.medication = m.code
WHERE pr.appointment IS NULL;


-- 11. Count available rooms for each block in each floor
SELECT blockfloor AS Floor,
       blockcode AS Block,
       COUNT(*) AS Available_Rooms
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor, blockcode
ORDER BY blockfloor, blockcode;


-- 12. Floor with minimum available rooms
SELECT blockfloor AS Floor,
       COUNT(*) AS Available_Rooms
FROM room
WHERE unavailable = 'f'
GROUP BY blockfloor
ORDER BY Available_Rooms ASC
LIMIT 1;


-- 13. Patients with their block, floor and room where admitted
SELECT pt.name AS Patient_Name,
       r.blockfloor AS Floor,
       r.blockcode AS Block,
       r.roomnumber AS Room_Number
FROM stay s
JOIN patient pt ON s.patient = pt.ssn
JOIN room r ON s.roomnumber = r.roomnumber;


-- 14. Physicians who performed procedure after certificate expiry
SELECT DISTINCT ph.name AS Physician_Name,
       ph.position AS Position
FROM undergoes u
JOIN trained_in t ON u.physicianassist = t.physician
                   AND u.procedure_id = t.treatment
JOIN physician ph ON u.physicianassist = ph.employeeid
WHERE STR_TO_DATE(u.date,'%d/%m/%Y') >
      STR_TO_DATE(t.certificationexpires,'%d/%m/%Y');


-- 15. Detailed info of physicians who performed procedure after certificate expiry
SELECT ph.name AS Physician_Name,
       ph.position AS Position,
       pr.name AS Procedure_Name,
       u.date AS Procedure_Date,
       pt.name AS Patient_Name,
       t.certificationexpires AS Certificate_Expired_On
FROM undergoes u
JOIN trained_in t ON u.physicianassist = t.physician
                   AND u.procedure_id = t.treatment
JOIN physician ph ON u.physicianassist = ph.employeeid
JOIN procedures pr ON u.procedure_id = pr.code
JOIN patient pt ON u.patient = pt.ssn
WHERE STR_TO_DATE(u.date,'%d/%m/%Y') >
      STR_TO_DATE(t.certificationexpires,'%d/%m/%Y');

