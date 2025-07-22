-- James Barnson
-- CSE182 Spring 2024
-- Lab 3

/* Write a serializable transaction. For each tuple in 
UpgradeDentalTreatments, there may already be a tuple in DentalTreatments
with the same Primary Key (same value for treatmentType). If there isn't,
this is a new dental treatment which should be inserted into the 
DentalTreatments table. If there is, then this is an update of information
about the dental treatment. */

-- Transaction must be serializable
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/* if there is already a tuple in DentalTreatments with that treatmentType,
then update the tuple in DentalTreatments with that treatmentType to have
the treatmentDuration value in the UpgradeDentalTreatments tuple, and
increase the treatmentFee for it by 2.00. */
UPDATE DentalTreatments d
SET treatmentFee = treatmentFee + 2.00
WHERE d.treatmentType IN ( 
	SELECT ud.treatmentType
	FROM UpgradeDentalTreatments ud);

UPDATE DentalTreatments d 
SET treatmentDuration = u.treatmentDuration
FROM UpgradeDentalTreatments u
WHERE d.treatmentType = u.treatmentType;

/* if there isn't already a tuple in DentalTreatments with that treatmentType,
insert a tuple into DentalTreatments with that treatmentType and
treatmentDuration value from UpgradeDentalTreatments tuple with 
treatmentFee = 34.50 */
INSERT INTO DentalTreatments
	SELECT u.treatmentType, treatmentDuration, 34.50
	FROM UpgradeDentalTreatments u
	WHERE NOT EXISTS ( 
		SELECT * FROM DentalTreatments d 
		WHERE d.treatmentType = u.treatmentType );
-- End transaction
COMMIT TRANSACTION;
