-- James Barnson
-- CSE182 Spring 2024
-- Lab 2 Query 3

/*
Write a SQL query which finds all dentists whose dental school is NOT
'UCLA School of Dentistry', and who treated the exact same left tooth 
for at least 2 different patients. The attribute in your result should
be the dentist's ID, which should appear as theDentistID.
No duplicates should appear in your result.
*/

-- Get dentists who didn't go to UCLA
SELECT d.dentistID AS "theDentistID"
FROM Dentists d
WHERE d.dentalSchool != 'UCLA School of Dentistry'
AND d.dentistID IN (
	-- Get dentists who treated the same tooth for more than 1 patient
	-- This could use HAVING and GROUP BY but this seemed simpler.
	SELECT t1.dentistID
	FROM TreatmentsDuringVisits t1, TreatmentsDuringVisits t2
	WHERE t1.toothNumber = t2.toothNumber
	AND t1.dentistID = t2.dentistID
	AND t1.patientID != t2.patientID
	AND t1.dentistID IN (
		-- Get tooth numbers in a left quadrant ("BL" or "TL")
		SELECT toothNumber
		FROM Teeth t
		WHERE t.quadrant = 'BL' 
		OR t.quadrant = 'TL'));
