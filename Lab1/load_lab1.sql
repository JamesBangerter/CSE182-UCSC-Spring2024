-- Sample script file to populate the Dentist Schema

-- Patients(patientID, patientName, address, creditCardType, creditCardNumber, expirationDate, isCardValid)
COPY Patients FROM stdin USING DELIMITERS '|';
1|John Doe|123 Main St, New York, NY|V|123456789|2025-12-31|true
2|Jane Smith|456 Oak Ave, Los Angeles, CA|M|987654321|2024-06-30|false
3|Michael Johnson|789 Elm Rd, Chicago, IL|A|135792468|2028-10-15|true
4|Emily Davis|321 Pine Blvd, Houston, TX|D|246813579|2026-05-20|true
5|Robert Brown|654 Cedar Dr, Phoenix, AZ|V|369258147|2024-09-18|false
6|Jessica Wilson|987 Maple Ln, Philadelphia, PA|M|852147963|2023-03-05|true
7|William Martinez|741 Birch Ave, San Antonio, TX|A|741852963|2025-08-12|true
8|Amanda Taylor|369 Willow Ct, San Diego, CA|D|963852741|2026-11-30|false
\.

-- Dentists(dentistID, dentistName, address, dentalSchool, graduationDate, isMemberADA)
COPY Dentists FROM stdin USING DELIMITERS '|';
11|Michael Johnson|123 Main St, New York, NY|Michigan School of Dentistry|2015-05-20|true
22|Sarah Lee|456 Oak Ave, Los Angeles, CA|UCLA School of Dentistry|2016-08-15|true
33|David Smith|789 Elm Rd, Chicago, IL|Pennsylvania School of Dental Medicine|2014-12-10|false
44|Emily Davis|321 Pine Blvd, Houston, TX|UTHealth School of Dentistry|2017-03-25|true
55|John Anderson|654 Cedar Dr, Phoenix, AZ|Arizona School of Oral Health|2018-06-30|true
\.

-- Teeth(toothNumber, toothName, quadrant)
COPY Teeth FROM stdin USING DELIMITERS '|';
1|Wisdom Tooth|TR
2|Molar|TR
3|Molar|TR
4|Bicuspid|TR
5|Bicuspid|TR
6|Canine|TR
7|Incisor|TR
8|Incisor|TR
9|Incisor|TL
10|Incisor|TL
11|Canine|TL
12|Bicuspid|TL
13|Bicuspid|TL
14|Molar|TL
15|Molar|TL
16|Wisdom Tooth|TL
17|Wisdom Tooth|BL
18|Molar|BL
19|Molar|BL
20|Bicuspid|BL
21|Bicuspid|BL
22|Canine|BL
23|Incisor|BL
24|Incisor|BL
25|Incisor|BR
26|Incisor|BR
27|Canine|BR
28|Bicuspid|BR
29|Bicuspid|BR
30|Molar|BR
31|Molar|BR
32|Wisdom Tooth|BR
\.

-- Visits(patientID, dentistID visitStartTimestamp, visitDuration)
COPY Visits FROM stdin USING DELIMITERS '|';
1|44|2024-03-15 09:00:00|01:00:00
2|22|2024-03-16 10:30:00|00:45:00
3|11|2024-03-17 11:15:00|00:30:00
4|33|2024-03-18 13:00:00|01:15:00
5|11|2024-03-19 14:45:00|02:45:00
1|33|2024-03-20 16:30:00|01:00:00
2|44|2024-03-21 09:30:00|01:45:00
6|55|2024-03-22 11:00:00|00:45:00
\.

-- DentalTreatments(treatmentType, treatmentDuration, treatmentFee)
COPY DentalTreatments FROM stdin USING DELIMITERS '|';
Filling|30|25.00
Crown|60|50.00
Root canal|90|100.00
Extraction|40|48.25
X-rays|10|22.50
Cleaning|10|30.00
\.

-- TreatmentsDuringVisits(patientID, dentistID, visitStartTimestamp, toothNumber, treatmentType, wasPaymentReceived)
COPY TreatmentsDuringVisits FROM stdin USING DELIMITERS '|';
1|44|2024-03-15 09:00:00|20|Crown|true
1|33|2024-03-20 16:30:00|21|Crown|true
2|22|2024-03-16 10:30:00|30|Filling|true
2|44|2024-03-21 09:30:00|1|Extraction|false
3|11|2024-03-17 11:15:00|9|Extraction|true
4|33|2024-03-18 13:00:00|3|Filling|false
5|11|2024-03-19 14:45:00|9|Root canal|true
5|11|2024-03-19 14:45:00|31|Filling|false
6|55|2024-03-22 11:00:00|14|Root canal|false
\.
