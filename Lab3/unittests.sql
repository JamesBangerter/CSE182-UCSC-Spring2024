-- James Barnson
-- CSE182 Spring 2024
-- Lab 3 part 2.5

/* Write unit tests. */

/* For each of the 3 foreign key constraints in 2.3, write an INSERT command
that violates the foreign key constraint, eliciting an error. */

-- Constraint: patientID in Visits must be in Patients
INSERT INTO Visits(patientID, dentistID, visitStartTimestamp, visitDuration)
	VALUES ( 9, 11, '2023-12-15 10:00:00', '00:30:00' );

-- Constraint: dentistID in Visits must be in Dentists
INSERT INTO Visits(patientID, dentistID, visitStartTimestamp, visitDuration)
	VALUES ( 8, 77, '2023-12-15 10:00:00', '00:30:00' );

-- Constraint: visit in TreatmentsDuringVisits must match Visits primary key
INSERT INTO TreatmentsDuringVisits(patientID, dentistID, visitStartTimestamp,
		toothNumber, treatmentType, wasPaymentReceived)
	VALUES ( 3, 44, '2022-12-30 9:00:00', 20, 'Crown', 'true' );


/* For each of the 3 general constraints, write an UPDATE command that
meets the constraint and an UPDATE command that violates the constraint,
eliciting an error. */

-- Constraint:  visitDurationPositive
UPDATE Visits
	SET visitDuration = '30 minutes'
	WHERE visitDuration = '40 minutes';

UPDATE Visits
	SET visitDuration = '-30 minutes'
	WHERE patientID = 1 AND dentistID = 44 
		AND visitStartTimestamp = '2023-12-15 09:00:00'; 

-- Constraint: validToothQuadrant 
UPDATE Teeth
	SET quadrant = 'TR'
	WHERE toothNumber = 23;

UPDATE Teeth
	SET quadrant = 'LR'
	WHERE quadrant = 'BR';

-- Constraint: ifNullTypeThenNullNumber
UPDATE Patients
	SET creditCardType = NULL, creditCardNumber = NULL
	WHERE patientID = 4;

UPDATE Patients
	SET creditCardType = NULL
	WHERE patientID = 7;



