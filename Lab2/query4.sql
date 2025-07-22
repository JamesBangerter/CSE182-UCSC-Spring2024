-- James Barnson
-- CSE 182 Spring 2024
-- Lab 2 Query 4

/*
Write a SQL query which finds all treatments during visits where all of the following
are true:
	- Payment has not been received (using wasPaymentReceived)
	- The date in the visitStartTimestamp is Jan 12, 2024 or later
	- The dentist's address has 'en' anywhere in it (that capitalization)
	- The fee for treatment is >= 50.00
	- Patient's credit card number is NULL
Attributes in your result should be patientID, dentistID, visitStartTimestamp,
toothNumber, treatmentType.
No duplicates should appear in your result. 
*/

SELECT t.patientID, t.dentistID, t.visitStartTimestamp, 
	t.toothNumber, t.treatmentType
FROM TreatmentsDuringVisits t
WHERE NOT wasPaymentReceived
AND date(t.visitStartTimestamp) >= '2024-01-12'
AND t.dentistID IN (
	SELECT d.dentistID
	FROM Dentists d
	WHERE d.address LIKE '%en%' )
AND t.treatmentType IN (
	SELECT dt.treatmentType
	FROM DentalTreatments dt
	WHERE dt.treatmentFee >= 50.00 )
AND t.patientID IN (
	SELECT p.patientID
	FROM Patients p
	WHERE p.creditCardNumber IS NULL );
