-- James Barnson
-- CSE182 Spring 2024
-- Lab3 section 2.3

/* Each patientID in Visits must appear in Patients as patientID (primary key).
If tuple in Patients is deleted, all Visits tuples with matching patientID
should also be deleted. If patientID of tuple in Patients is updated, all
Visits tuples with matching patientID should update to that value. */
ALTER TABLE Visits
	ADD FOREIGN KEY (patientID)
	REFERENCES Patients(patientID)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

/* Each dentistID in Visits must appear in Dentists as dentistID (primary key).
If tuple in Dentists is deleted and matching dentistID is in Visits tuple,
Dentist tuple deletion should be rejected. If dentistID of tuple in Dentists
is updated, all Visits tuples with matching dentistID should update to that
value. */
ALTER TABLE Visits
	ADD FOREIGN KEY (dentistID)
	REFERENCES Dentists(dentistID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE;

/* Each (patientID, dentistID, visitStartTimestamp) that appears in 
TreatmentsDuringVisits must appear in Visits as a primary key 
(patientID, dentistID, visitStartTimestamp). If a tuple is deleted in Visits,
matching TreatmentsDuringVisits tuples should also be deleted. If a 
primary key in Visits is updated, then all corresponding tuples in
TreatmentsDuringVisits should also be updated. */
ALTER TABLE TreatmentsDuringVisits
	ADD FOREIGN KEY (patientID, dentistID, visitStartTimestamp)
	REFERENCES Visits(patientID, dentistID, visitStartTimestamp)
		ON DELETE CASCADE
		ON UPDATE CASCADE; 
