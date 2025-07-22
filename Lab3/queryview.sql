-- James Barnson
-- CSE 182 Spring 2024
-- Lab 3 part 2.6.2

/* Write a query which finds the totalDurationDifference for each dentist who
appears in BadDurationVisitsView, and the number of tuples for that dentist
in said view as badDurationVisitsCount. */

SELECT b.dentistID, b.dentistID,
	SUM(b.visitDuration - b.totalTreatmentDuration) AS totalDurationDifference,
	COUNT(*) AS badDurationVisitsCount
FROM BadDurationVisitsView b
GROUP BY b.dentistID;

/* Results:
 dentistid | dentistid | totaldurationdifference | baddurationvisitscount 
-----------+-----------+-------------------------+------------------------
        11 |        11 | -00:28:00               |                      1
        33 |        33 | -00:20:00               |                      3
(2 rows)
*/

/* Delete tuples with these primary keys in TreatmentsDuringVisits:
	(5, 33, TIMESTAMP'2024-03-30 15:00:00' 32, 'Extraction')
	(5, 11, TIMESTAMP'2024-03-19 14:45:00', 31, 'Filling')	*/

DELETE FROM TreatmentsDuringVisits
	WHERE patientID = 5 AND dentistID = 33
	AND visitStartTimestamp = TIMESTAMP'2024-03-30 15:00:00'
	AND toothNumber = 32 AND treatmentType = 'Extraction';

DELETE FROM TreatmentsDuringVisits
	WHERE patientID = 5 AND dentistID = 11
	AND visitStartTimestamp = TIMESTAMP'2024-03-19 14:45:00'
	AND toothNumber = 31 AND treatmentType = 'Filling'; 

/* Run the query again */
SELECT b.dentistID, b.dentistID,
	SUM(b.visitDuration - b.totalTreatmentDuration) AS totalDurationDifference,
	COUNT(*) AS badDurationVisitsCount
FROM BadDurationVisitsView b
GROUP BY b.dentistID;

/* Results:
tid | dentistid | totaldurationdifference | baddurationvisitscount 
-----------+-----------+-------------------------+------------------------
        33 |        33 | -00:40:00               |                      2
(1 row)
*/
