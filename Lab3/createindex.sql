-- James Barnson
-- CSE 182 Spring 2024
-- Lab3 part 2.7

/* Create an index named VisitsForPatientToDentist over patientID and dentistID
columns (in that order) of Visits. */

CREATE INDEX VisitsForPatientToDentist ON Visits(patientID, dentistID);
