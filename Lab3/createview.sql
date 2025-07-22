-- James Barnson
-- CSE 182 Spring 2024
-- Lab 3 part 2.6

/* Create a view titled BadDurationVisitsView which identifies visits where
the difference between visitDuration and total duration of dental treatments
during visit is >= 5 mins. Attributs should be attributes in visit table
plus totalTreatmentDuration, the sum of treatmentDuration for all treatments
during that visit. */

CREATE VIEW BadDurationVisitsView AS
	SELECT v.patientID, v.dentistID, v.visitStartTimestamp,
		v.visitDuration, SUM(dt.treatmentDuration) 
		AS totalTreatmentDuration
	FROM Visits v, DentalTreatments dt, TreatmentsDuringVisits tdv
	WHERE v.patientID = tdv.patientID 
		AND v.dentistID = tdv.dentistID
		AND v.visitStartTimestamp = tdv.visitStartTimestamp
		AND tdv.treatmentType = dt.treatmentType
	GROUP BY v.patientID, v.dentistID, v.visitStartTimestamp
	HAVING ( SUM(dt.treatmentDuration) - v.visitDuration ) > INTERVAL'00:05:00'
	 OR ( v.visitDuration - SUM(dt.treatmentDuration) ) > INTERVAL'00:05:00';
