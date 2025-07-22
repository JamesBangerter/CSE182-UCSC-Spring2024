-- James Barnson
-- CSE182 Spring 2024
-- Lab2 Query 1

/*
Write a SQL query which finds the visits for which the name of the patient
starts with "J" (with that capitalization), the dentist is a member of the
American Dental Association, and the duration of the visit is greater than 
45 minutes. The attributes in your result should be the name of the patient,
the name of the dentist, and the duration of the visit, which should appear
in your result as thePatientName, theDentistName, and theVisitLength.
No duplicates should appear in your result.
*/

SELECT DISTINCT p.patientName AS "thePatientName",
	d.dentistName AS "theDentistName",
	v.visitDuration AS "theVisitLength"
FROM Patients p, Dentists d, Visits v
WHERE p.patientID = v.patientID
	AND d.dentistID = v.dentistID
	AND p.patientName LIKE 'J%'
	AND d.isMemberADA
	AND v.visitDuration > '00:45:00';  
