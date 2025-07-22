-- James Barnson
-- CSE 182 Spring 2024
-- Lab 2 Query 5

/*
Write a SQL query which finds the dentistID, dentistName, and address
for all the dentists who have the earliest graduation date.
No duplicates should appear in your result.
*/

SELECT d.dentistID, d.dentistName, d.address
FROM Dentists d
WHERE d.graduationDate IN (
	SELECT MIN(d2.graduationDate)
	FROM Dentists d2 );

-- I could have used <= ALL here but this felt simpler.
