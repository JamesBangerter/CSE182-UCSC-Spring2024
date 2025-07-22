-- James Barnson
-- CSE182 Spring 2024
-- Lab3 part 2.4

/* Write CHECK constraints. */

/* In Visits, visitDuration must be greater than 0. Name this constraint
visitDurationPositive. */
ALTER TABLE Visits 
	ADD CONSTRAINT visitDurationPositive
		CHECK ( visitDuration > INTERVAL'00:00:00' );

/* In Teeth, the value of the quadrant must be 'TR', 'BR', 'TL', 'BL', or
NULL. Name this constraint validToothQuadrant. */
ALTER TABLE Teeth
	ADD CONSTRAINT validToothQuadrant
		CHECK ( quadrant IN ('TR','BR','TL','BL') );
		-- NULL is not limited by these constraints

/* In Patients, if creditCardType is NULL then creditCardNumber must also
be NULL. Name this constraint ifNullTypeThenNullNumber. */
ALTER TABLE Patients
	ADD CONSTRAINT ifNullTypeThenNullNumber
		CHECK ( NOT (creditCardType IS NULL 
				AND creditCardNumber IS NOT NULL ) );
