CREATE TABLE Staff (
    Staff_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Category VARCHAR2(50) NOT NULL,
    Employment_type VARCHAR2(50) NOT NULL,
    Hire_date DATE NOT NULL,

    CONSTRAINT chk_staff_category
    CHECK (Category IN ('Doctor','Nurse','Security','Utility','Frontdesk')),

    CONSTRAINT chk_employment_type
    CHECK (Employment_type IN ('Full-Time','Part-Time','Contract'))
);
  
CREATE TABLE Phones (
    Staff_ID NUMBER,
    Phone VARCHAR2(20),

    CONSTRAINT pk_phones PRIMARY KEY (Staff_ID, Phone),

    CONSTRAINT fk_phones_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID)
    ON DELETE CASCADE
);

CREATE TABLE Security (
    Staff_ID NUMBER,
    Assigned_Zone VARCHAR2(100) NOT NULL,
    Shift VARCHAR2(50) NOT NULL,
    Badge_number NUMBER UNIQUE NOT NULL,

    CONSTRAINT pk_security PRIMARY KEY (Staff_ID),

    CONSTRAINT fk_security_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID),

    CONSTRAINT chk_security_shift
    CHECK (Shift IN ('Morning','Evening','Night'))
);


CREATE TABLE Patient (
    Patient_ID NUMBER ,
    Name VARCHAR2(100) NOT NULL,
    Gender VARCHAR2(20) NOT NULL,
    Address VARCHAR2(200),
    Date_of_birth DATE NOT NULL,
    Emergency_contact VARCHAR2(100),
    Marital_status VARCHAR2(50),
    Contract VARCHAR2(100),

    CONSTRAINT pk_patient PRIMARY KEY (Patient_ID),

    CONSTRAINT chk_gender
    CHECK (Gender IN ('Male','Female'))
);

CREATE TABLE Department (
    Dept_ID NUMBER ,
    Dept_name VARCHAR2(100) UNIQUE NOT NULL,
    Location VARCHAR2(100),
    Head_doctor_ID NUMBER,

    CONSTRAINT pk_department PRIMARY KEY (Dept_ID)
);

CREATE TABLE Room (
    Room_ID NUMBER ,
    Dept_ID NUMBER NOT NULL,
    Room_type VARCHAR2(50),
    Room_number NUMBER UNIQUE NOT NULL,
    Floor NUMBER,
    Capacity NUMBER,
    Status VARCHAR2(50),

    CONSTRAINT pk_room PRIMARY KEY (Room_ID),

    CONSTRAINT fk_room_department
    FOREIGN KEY (Dept_ID)
    REFERENCES Department(Dept_ID),

    CONSTRAINT chk_capacity
    CHECK (Capacity > 0),

    CONSTRAINT chk_room_status
    CHECK (Status IN
    ('Available','Occupied','Maintenance'))
);

CREATE TABLE Nurse (
    Staff_ID NUMBER,
    Dept_ID NUMBER NOT NULL,
    Certification_level VARCHAR2(100),
    Shift VARCHAR2(50),
    Ward VARCHAR2(100),

    CONSTRAINT pk_nurse PRIMARY KEY (Staff_ID),

    CONSTRAINT fk_nurse_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID),

    CONSTRAINT fk_nurse_department
    FOREIGN KEY (Dept_ID)
    REFERENCES Department(Dept_ID),

    CONSTRAINT chk_nurse_shift
    CHECK (Shift IN ('Morning','Evening','Night'))
);

CREATE TABLE Frontdesk (
    Staff_ID NUMBER,
    desk_location VARCHAR2(100),

    CONSTRAINT pk_frontdesk PRIMARY KEY (Staff_ID),

    CONSTRAINT fk_frontdesk_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID)
);

CREATE TABLE Doctor (
    Staff_ID NUMBER,
    Licence_number VARCHAR2(100) UNIQUE NOT NULL,
    Specialty VARCHAR2(100),
    Qualification VARCHAR2(100),
    Dept_ID NUMBER NOT NULL,

    CONSTRAINT pk_doctor PRIMARY KEY (Staff_ID),

    CONSTRAINT fk_doctor_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID),

    CONSTRAINT fk_doctor_department
    FOREIGN KEY (Dept_ID)
    REFERENCES Department(Dept_ID)
);

CREATE TABLE Clinic_Appointment (
    Appointment_ID NUMBER ,
    Patient_ID NUMBER NOT NULL,
    Doctor_ID NUMBER NOT NULL,
    FrontDesk_ID NUMBER NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIMESTAMP,
    Status VARCHAR2(50),
    Clinical_decision VARCHAR2(255),

    CONSTRAINT pk_appointment
    PRIMARY KEY (Appointment_ID),

    CONSTRAINT fk_appointment_patient
    FOREIGN KEY (Patient_ID)
    REFERENCES Patient(Patient_ID),

    CONSTRAINT fk_appointment_doctor
    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctor(Staff_ID),

    CONSTRAINT fk_appointment_frontdesk
    FOREIGN KEY (FrontDesk_ID)
    REFERENCES Frontdesk(Staff_ID),

    CONSTRAINT chk_appointment_status
    CHECK (Status IN
    ('Pending','Completed','Cancelled'))
);

CREATE TABLE Medical_Record (
    Record_ID NUMBER ,
    Patient_ID NUMBER NOT NULL,
    Doctor_ID NUMBER NOT NULL,
    Appointment_ID NUMBER,
    Diagnoses VARCHAR2(255),
    Treatment VARCHAR2(255),
    Record_Date DATE NOT NULL,

    CONSTRAINT pk_medical_record
    PRIMARY KEY (Record_ID),

    CONSTRAINT fk_record_patient
    FOREIGN KEY (Patient_ID)
    REFERENCES Patient(Patient_ID),

    CONSTRAINT fk_record_doctor
    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctor(Staff_ID),

    CONSTRAINT fk_record_appointment
    FOREIGN KEY (Appointment_ID)
    REFERENCES Clinic_Appointment(Appointment_ID)
);

CREATE TABLE Admission (
    Admission_ID NUMBER ,
    Patient_ID NUMBER NOT NULL,
    Frontdesk_ID NUMBER NOT NULL,
    Room_ID NUMBER NOT NULL,
    Admission_date DATE NOT NULL,
    Discharge_date DATE,
    Status VARCHAR2(50),

    CONSTRAINT pk_admission
    PRIMARY KEY (Admission_ID),

    CONSTRAINT fk_admission_patient
    FOREIGN KEY (Patient_ID)
    REFERENCES Patient(Patient_ID),

    CONSTRAINT fk_admission_frontdesk
    FOREIGN KEY (Frontdesk_ID)
    REFERENCES Frontdesk(Staff_ID),

    CONSTRAINT fk_admission_room
    FOREIGN KEY (Room_ID)
    REFERENCES Room(Room_ID),

    CONSTRAINT chk_admission_status
    CHECK (Status IN
    ('Admitted','Discharged','Observation')),

    CONSTRAINT chk_discharge_date
    CHECK (Discharge_date >= Admission_date)
);

CREATE TABLE Nurse_Admission (
    Nurse_ID NUMBER,
    Admission_ID NUMBER,

    CONSTRAINT pk_nurse_admission
    PRIMARY KEY (Nurse_ID, Admission_ID),

    CONSTRAINT fk_nurseadmission_nurse
    FOREIGN KEY (Nurse_ID)
    REFERENCES Nurse(Staff_ID),

    CONSTRAINT fk_nurseadmission_admission
    FOREIGN KEY (Admission_ID)
    REFERENCES Admission(Admission_ID)
);

CREATE TABLE Patient_Phones (
    Patient_ID NUMBER,
    Phones VARCHAR2(20) UNIQUE,

    CONSTRAINT pk_patient_phones
    PRIMARY KEY (Patient_ID, Phones),

    CONSTRAINT fk_patientphones_patient
    FOREIGN KEY (Patient_ID)
    REFERENCES Patient(Patient_ID)
);

CREATE TABLE Utility (
    Staff_ID NUMBER PRIMARY KEY,
    Role VARCHAR2(100),

    CONSTRAINT fk_utility_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID)
    ON DELETE CASCADE
);

CREATE TABLE Assigned_Area (
    Staff_ID NUMBER,
    Area_ID NUMBER,
    Area VARCHAR2(100),

    CONSTRAINT pk_assigned_area PRIMARY KEY (Staff_ID, Area_ID),

    CONSTRAINT fk_area_staff
    FOREIGN KEY (Staff_ID)
    REFERENCES Staff(Staff_ID)
    ON DELETE CASCADE
);


INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(2, 'basma', 'Security', 'Full-Time', DATE '2021-03-15');
INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(4, 'Sara Adel', 'Frontdesk', 'Part-Time', DATE '2023-02-01');

INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(1, 'Ahmed Ali', 'Doctor', 'Full-Time', DATE '2020-05-10');

INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(5, 'Mahmoud Hany', 'Utility', 'Full-Time', DATE '2021-11-12');

INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(6, 'Nouran Ahmed', 'Nurse', 'Full-Time', DATE '2022-06-18');
 
INSERT INTO Staff
(Staff_ID, Name, Category, Employment_type, Hire_date)
VALUES
(7, 'Salma Mostafa', 'Nurse', 'Part-Time', DATE '2023-01-10');




INSERT INTO Security
(Staff_ID, Assigned_Zone, Shift, Badge_number)
VALUES
(2, 'Emergency Gate', 'Night', 5001);

INSERT INTO Department
(Dept_ID, Dept_name, Location)
VALUES
(2, 'Neurology', 'Second Floor');




INSERT INTO Doctor
(Staff_ID, Licence_number,
 Specialty, Qualification, Dept_ID)
VALUES
(1, 'DOC12345',
 'Neurology', 'Master Degree', 2);

INSERT INTO Room
(Room_ID, Dept_ID, Room_type,
 Room_number, Floor, Capacity, Status)
VALUES
(3, 2, 'Normal',
 202, 2, 4, 'Occupied');

INSERT INTO Room
(Room_ID, Dept_ID, Room_type,
 Room_number, Floor, Capacity, Status)
VALUES
(1, 2, 'ICU',
 101, 1, 2, 'Available');


INSERT INTO Room
(Room_ID, Dept_ID, Room_type,
 Room_number, Floor, Capacity, Status)
VALUES
(2, 2, 'Emergency',
 102, 1, 2, 'Available');

INSERT INTO Nurse
(Staff_ID, Dept_ID, Certification_level, Shift, Ward)
VALUES
(7, 2, 'ccrn', 'Morning', 'Ward A');

INSERT INTO Nurse
(Staff_ID, Dept_ID, Certification_level, Shift, Ward)
VALUES
(6, 2, 'ccrn', 'Evening', 'Ward B');


INSERT INTO Phones (Staff_ID, Phone) VALUES (1, '01012345678');
INSERT INTO Phones (Staff_ID, Phone) VALUES (1, '01012393217');


INSERT INTO Patient
(Patient_ID, Name, Gender, Address,
 Date_of_birth, Emergency_contact,
 Marital_status, Contract)
VALUES
(2, 'Nour Ahmed', 'Female', 'Cairo',
 DATE '2001-04-22',
 '01122334455',
 'Married', 'Cash');

INSERT INTO Patient_Phones
(Patient_ID, Phones)
VALUES
(2, '01155668');
INSERT INTO Patient_Phones
(Patient_ID, Phones)
VALUES
(2, '01120098');
INSERT INTO Utility (Staff_ID, Role) VALUES (5, 'Cleaning');

INSERT INTO Frontdesk
(Staff_ID, desk_location)
VALUES
(4, 'Main Entrance');


INSERT INTO Clinic_Appointment
(Appointment_ID, Patient_ID,
 Doctor_ID, FrontDesk_ID,
 Appointment_Date,
 Appointment_Time,
 Status, Clinical_decision)
VALUES
(1, 2,
 1, 4,
 DATE '2026-05-10',
 TO_TIMESTAMP('10:30:00', 'HH24:MI:SS'),
 'Completed',
 'Patient needs medication');

INSERT INTO Medical_Record
(Record_ID, Patient_ID,
 Doctor_ID, Appointment_ID,
 Diagnoses, Treatment, Record_Date)
VALUES
(1, 2,
 1, 1,
 'High Blood Pressure',
 'Blood pressure medication',
 DATE '2026-05-10');





INSERT INTO Admission
(Admission_ID, Patient_ID,
 Frontdesk_ID, Room_ID,
 Admission_date,
 Discharge_date, Status)
VALUES
(1, 2,
 4, 2,
 DATE '2026-05-09',
 DATE '2026-05-15',
 'Admitted');

INSERT INTO Nurse_Admission
(Nurse_ID, Admission_ID)
VALUES
(7, 1);



INSERT INTO Assigned_Area (Staff_ID, Area_ID, Area) VALUES (5, 1, 'Emergency Wing');
INSERT INTO Assigned_Area (Staff_ID, Area_ID, Area) VALUES (5, 2, 'ICU');
INSERT INTO Assigned_Area (Staff_ID, Area_ID, Area) VALUES (5, 3, 'Pharmacy');



SELECT * FROM Staff;

SELECT * FROM Admission;

SELECT * FROM Assigned_Area ;

SELECT * FROM Medical_Record ;

SELECT * FROM Department ;

SELECT * FROM Patient_Phones ;

SELECT * FROM Nurse_Admission ;
 
SELECT * FROM Security;

SELECT * FROM Patient;

SELECT * FROM Doctor;

SELECT * FROM Room;

SELECT * FROM Utility ;

SELECT * FROM Clinic_Appointment;

SELECT * FROM phones;

SELECT * FROM Frontdesk;
