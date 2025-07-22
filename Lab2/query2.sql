-- James Barnson
-- CSE182 Spring 2024
-- Lab2 Query 2

/*
Write a SQL query which finds all patients who have a Visa credit card and
who have never visited a dentist who graduated before February 27, 2005.
The attributes in your result should be address and patientID. Tuples in
your result should be in reverse alphabetical order by address; if two tuples
have the same address, they should appear in increasing order of patientID.
No duplicates should appear in your result.
*/

SELECT DISTINCT p.address, p.patientID, 
FROM Patients p, Dentists d, Visits v
WHERE p.patientID = v.patientID
	AND d.dentistID = v.dentistID 
	AND p.creditCardType = 'V'
	AND d.graduationDate >= '2005-02-27'
ORDER BY p.address DESC, p.patientID ASC;
