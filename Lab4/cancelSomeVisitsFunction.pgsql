/* James Barnson
CSE 182 Spring 2024
Lab 4 */

CREATE OR REPLACE FUNCTION
cancelSomeVisitsFunction(maxVisitCancellations INTEGER)
RETURNS INTEGER AS $$

  DECLARE
    numCancelled INTEGER := 0; /* Number of visits cancelled; return value */
    thePatientID INTEGER; /* The patient to cancel visits of */
    numVisits INTEGER; /* The future visits of the patient */
    visitsCancelled BOOLEAN := FALSE; /* Check whether any visits were cancelled */

  DECLARE patientCursor CURSOR FOR
    SELECT p.patientID 
    FROM Patients p, TreatmentsDuringVisits tdv
    WHERE p.patientID = tdv.patientID
    AND tdv.wasPaymentReceived IS FALSE
    GROUP BY p.patientID
    ORDER BY COUNT(*) DESC, p.patientName;


  BEGIN

    IF maxVisitCancellations <= 0 THEN
      RETURN -1;
      END IF;


    OPEN patientCursor;

    LOOP

      FETCH FROM patientCursor INTO thePatientID;

      IF NOT FOUND THEN
        EXIT;
      END IF;

      SELECT COUNT(*) INTO numVisits 
      FROM Visits v
      WHERE patientID = thePatientID
      AND DATE(v.visitStartTimestamp) > DATE'2024-06-04'
      GROUP BY v.patientID;

      IF numVisits + numCancelled > maxVisitCancellations THEN
        EXIT;
      END IF;

      visitsCancelled := TRUE;

      DELETE FROM Visits v
      WHERE patientID = thePatientID
      AND DATE(v.visitStartTimestamp) > DATE'2024-06-04';

      numCancelled := numCancelled + numVisits;

    END LOOP;

    CLOSE patientCursor;


    IF visitsCancelled THEN
      RETURN numCancelled;
    ELSE
      RETURN 0;
    END IF;

  END;

$$ LANGUAGE plpgsql;
