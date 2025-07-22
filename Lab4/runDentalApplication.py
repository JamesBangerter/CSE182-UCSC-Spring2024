#! /usr/bin/env python3


import psycopg2
import sys
import datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runDentalApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage


def countNumberOfPatients (myConn, theDentistID):

    checkStmt = "SELECT COUNT(*) FROM Dentists WHERE dentistID = %s;"

    try:
        myCursor = myConn.cursor()
        myCursor.execute(checkStmt,(theDentistID, ))
        checkDentist = myCursor.fetchone()[0]
    except:
        print("checkStmt query in countNumberOfPatients failed", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    if checkDentist == 0:
       return -1; # Invalid dentistID

    stmt = "SELECT COUNT(*) FROM (SELECT DISTINCT patientID FROM Visits WHERE dentistID = %s) AS foo;"

    try: 
        myCursor.execute(stmt,(theDentistID, ))
        count = myCursor.fetchone()[0]
    except:
        print("stmt query in countNumberOfPatients failed", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    return count


# end countNumberOfPatients



def emphasizeToothSide (myConn, toothSide):
    
    stmt = "UPDATE Teeth SET toothName= %s || toothName WHERE quadrant LIKE '_{}'".format(toothSide)

    if toothSide == 'L':
        emphasize = 'Left '
    elif toothSide == 'R':
        emphasize = 'Right '
    else:
        return -1 # Invalid toothSide 

    try:
        myCursor = myConn.cursor()
        myCursor.execute(stmt, (emphasize, ))
        rowsChanged = myCursor.rowcount
    except:
        print("stmt query in emphasizeToothSide failed", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    myCursor.close()

    return rowsChanged

# end emphasizeToothSide



def cancelSomeVisits (myConn, maxVisitCancellations):

    try:
        myCursor = myConn.cursor()
        sql = "SELECT cancelSomeVisitsFunction(%s)"
        myCursor.execute(sql, (maxVisitCancellations, ))
    except:
        print("Call of cancelSomeVisitsFunction with argument", 
		maxVisitCancellations, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()[0]
    row = row if row is not None else 0

    myCursor.close()
    return row

#end cancelSomeVisits


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    
    myConn.autocommit = True
    
        
    # Perform tests of countNumberOfPatients, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in countNumberOfPatients.
    def testCountNumberOfPatients(aDentistID):
        testCount = countNumberOfPatients(myConn, aDentistID)
        if testCount >= 0:
            print('Number of patients for dentist ', aDentistID, ' is ', testCount, '\n')
        elif testCount == -1:
            print('countNumberOfPatients returned -1; invalid dentistID. \n')
        else: print('invalid result; count ', testCount, ' is negative. \n')

    testCountNumberOfPatients(11)
    testCountNumberOfPatients(17)
    testCountNumberOfPatients(44)
    testCountNumberOfPatients(66)

    # Perform tests of emphasizeToothSide, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in emphasizeToothSide.
    
    def testEmphasizeToothSide(side):
        testEmph = emphasizeToothSide(myConn, side) 
        if testEmph == -1:
            print('emphasizeToothSide returned -1; invalid toothSide. \n')
        elif testEmph >= 0:
            print('Number of teeth whose toothName values for ', side, ' were updated by emphasizeToothSide is ', testEmph, '\n')
        else: print('invalid result; updated row count ', testEmph, ' is negative. \n')

    testEmphasizeToothSide('R')
    testEmphasizeToothSide('L')
    testEmphasizeToothSide('C')
 
    # Perform tests of cancelSomeVisits, as described in Section 6 of Lab4,
    # Print their outputs (including error outputs) here, not in cancelSomeVisits.
   
    def testCancelSomeVisits(maxCancel):
        testCan = cancelSomeVisits(myConn, maxCancel)
        if testCan >= 0:
            print('Number of visits which were cancelled for maxVisitCancellations value ', maxCancel, ' is ', testCan, '. \n')
        elif testCan == -1:
            print('cancelSomeVisits returned -1; maxVisitCancellations ', maxCancel, ' is less than 1. \n')
        else: print('Invalid result; numCancelled ', testCan, ' is negative. \n')

    testCancelSomeVisits(2)
    testCancelSomeVisits(4)
    testCancelSomeVisits(3)
    testCancelSomeVisits(1) 
    

  
    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end


