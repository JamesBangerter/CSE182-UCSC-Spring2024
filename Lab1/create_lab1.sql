-- A file to create lab1.

-- Drop & recreate the Lab1 schema to prevent errors.
DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE Lab1.Patients (
	patientID INT PRIMARY KEY,
	patientName VARCHAR(40), 
	address VARCHAR(50), 
	creditCardType CHAR(1),
	creditCardNumber INT, 
	expirationDate DATE,
	isCardValid BOOLEAN
);

CREATE TABLE Lab1.Dentists (
	dentistID INT PRIMARY KEY,
	dentistName VARCHAR(40),
	address VARCHAR(50),
	dentalSchool VARCHAR(40),
	graduationDate DATE,
	isMemberADA BOOLEAN
);

CREATE TABLE Lab1.Teeth (
	toothNumber INT PRIMARY KEY,
	toothName CHAR(12), 
	quadrant CHAR(2)
);

CREATE TABLE Lab1.Visits (
	patientID INT,
	dentistID INT,
	visitStartTimestamp TIMESTAMP,
	visitDuration INTERVAL, 
	PRIMARY KEY (patientID,dentistID,visitStartTimestamp),
	FOREIGN KEY (patientID) REFERENCES Lab1.Patients(patientID),
	FOREIGN KEY (dentistID) REFERENCES Lab1.Dentists(dentistID)
); 

CREATE TABLE Lab1.DentalTreatments (
	treatmentType CHAR(12) PRIMARY KEY,
	treatmentDuration INTERVAL MINUTE, 
	treatmentFee NUMERIC(3) 
);

CREATE TABLE Lab1.TreatmentsDuringVisits (
	patientID INT,
	dentistID INT,
	visitStartTimestamp TIMESTAMP,
	toothNumber INT,
	treatmentType VARCHAR(15),
	wasPaymentReceived BOOLEAN,
	PRIMARY KEY (patientID,dentistID,visitStartTimestamp,
		toothNumber,treatmentType),
	FOREIGN KEY (patientID,dentistID,visitStartTimestamp)
		REFERENCES Lab1.Visits(patientID,dentistID,visitStartTimestamp)
);

