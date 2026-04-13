create table if not exists raw.donations(
	donation_id text,
	donor_id text,
	hospital_id text,
	recipient_id text,
	collection_technician_id text,
	processed_by_technician_id text,
	test_result_id text,
	date text,
	quantity text,
	blood_group text,
	status text,
	bag_serial_number text,
	storage_temperature text,
	expiration_date text,
	donation_type text
)



INSERT INTO raw.donations
(donation_id, donor_id, hospital_id, recipient_id, collection_technician_id,
 processed_by_technician_id, test_result_id, date, quantity, blood_group,
 status, bag_serial_number, storage_temperature, expiration_date, donation_type)
VALUES

-- 2020–2021 (Processed Historical Data)

(1,1,3,NULL,3,3,NULL,DATE '2020-10-15',500,'A+','distributed','BAG1001',4,DATE '2021-04-13','whole_blood'),
(2,2,4,NULL,3,3,NULL,DATE '2021-01-20',450,'O-','completed','BAG1002',4,DATE '2021-07-19','whole_blood'),
(3,3,5,NULL,3,3,NULL,DATE '2021-02-18',480,'B+','distributed','BAG1003',4,DATE '2022-02-18','plasma'),
(4,4,6,NULL,3,3,NULL,DATE '2020-12-05',470,'AB-','discarded','BAG1004',4,DATE '2020-12-10','platelets'),
(5,5,7,NULL,5,5,NULL,DATE '2021-03-10',510,'A-','completed','BAG1005',4,DATE '2021-09-06','whole_blood'),
(6,6,8,NULL,5,5,NULL,DATE '2020-09-22',500,'B-','distributed','BAG1006',4,DATE '2021-03-21','whole_blood'),
(7,7,9,NULL,5,5,NULL,DATE '2020-11-12',480,'O+','completed','BAG1007',4,DATE '2021-11-12','plasma'),
(8,8,10,NULL,5,5,NULL,DATE '2021-01-30',470,'AB+','distributed','BAG1008',4,DATE '2021-02-04','platelets'),
(9,9,3,NULL,3,3,NULL,DATE '2020-08-19',510,'A+','completed','BAG1009',4,DATE '2021-02-15','whole_blood'),
(10,10,4,NULL,3,3,NULL,DATE '2021-03-05',500,'B+','distributed','BAG1010',4,DATE '2021-09-01','whole_blood'),
(11,11,5,NULL,3,3,NULL,DATE '2020-07-11',480,'O-','completed','BAG1011',4,DATE '2021-07-11','plasma'),
(12,12,6,NULL,3,3,NULL,DATE '2021-02-05',470,'A-','discarded','BAG1012',4,DATE '2021-02-10','platelets'),
(13,13,7,NULL,3,3,NULL,DATE '2020-10-28',510,'AB-','completed','BAG1013',4,DATE '2021-04-26','whole_blood'),
(14,14,8,NULL,3,3,NULL,DATE '2021-04-09',500,'B-','distributed','BAG1014',4,DATE '2021-10-06','whole_blood'),
(15,15,9,NULL,3,3,NULL,DATE '2020-08-30',480,'O+','completed','BAG1015',4,DATE '2021-08-30','plasma'),
(16,16,10,NULL,3,3,NULL,DATE '2021-01-15',470,'A+','distributed','BAG1016',4,DATE '2021-01-20','platelets'),
(17,17,3,NULL,3,3,NULL,DATE '2020-11-20',510,'AB+','completed','BAG1017',4,DATE '2021-05-19','whole_blood'),
(18,18,4,NULL,3,3,NULL,DATE '2021-03-20',500,'B+','distributed','BAG1018',4,DATE '2021-09-16','whole_blood'),
(19,19,5,NULL,3,3,NULL,DATE '2020-09-05',480,'O-','completed','BAG1019',4,DATE '2021-09-05','plasma'),
(20,20,6,NULL,3,3,NULL,DATE '2021-02-25',470,'A-','discarded','BAG1020',4,DATE '2021-03-02','platelets'),

-- 2024 (Active Lifecycle)

(21,21,3,NULL,4,4,NULL,DATE '2024-02-10',500,'A+','collected','BAG2021',4,DATE '2024-08-08','whole_blood'),
(22,22,4,NULL,4,4,NULL,DATE '2024-02-20',450,'O-','collected','BAG2022',4,DATE '2024-08-18','whole_blood'),
(23,23,5,NULL,4,4,NULL,DATE '2024-02-15',480,'B+','tested','BAG2023',4,DATE '2025-02-15','plasma'),
(24,24,6,NULL,4,4,NULL,DATE '2024-02-05',470,'AB-','tested','BAG2024',4,DATE '2024-02-10','platelets'),
(25,25,7,NULL,4,4,NULL,DATE '2024-02-12',500,'A-','completed','BAG2025',4,DATE '2024-08-10','whole_blood'),
(26,26,8,NULL,4,4,NULL,DATE '2024-02-07',450,'B-','tested','BAG2026',4,DATE '2024-08-05','whole_blood'),
(27,27,9,NULL,4,4,NULL,DATE '2024-02-14',480,'O+','collected','BAG2027',4,DATE '2025-02-14','plasma'),
(28,28,10,NULL,4,4,NULL,DATE '2024-02-21',500,'AB+','completed','BAG2028',4,DATE '2024-02-26','platelets'),
(29,29,3,NULL,4,4,NULL,DATE '2024-02-18',470,'A+','tested','BAG2029',4,DATE '2024-08-16','whole_blood'),
(30,30,4,NULL,4,4,NULL,DATE '2024-02-25',450,'O-','collected','BAG2030',4,DATE '2024-08-23','whole_blood'),
(31,31,5,NULL,4,4,NULL,DATE '2024-02-28',480,'B+','completed','BAG2031',4,DATE '2025-02-28','plasma'),
(32,32,6,NULL,4,4,NULL,DATE '2024-02-03',500,'AB-','tested','BAG2032',4,DATE '2024-02-08','platelets'),
(33,33,7,NULL,4,4,NULL,DATE '2024-02-11',450,'A-','collected','BAG2033',4,DATE '2024-08-09','whole_blood'),
(34,34,8,NULL,4,4,NULL,DATE '2024-02-17',480,'B-','completed','BAG2034',4,DATE '2024-08-15','whole_blood'),
(35,35,9,NULL,4,4,NULL,DATE '2024-02-22',500,'O+','tested','BAG2035',4,DATE '2025-02-22','plasma'),
(36,36,10,NULL,4,4,NULL,DATE '2024-02-26',470,'AB+','collected','BAG2036',4,DATE '2024-03-02','platelets'),
(37,37,3,NULL,4,4,NULL,DATE '2024-02-08',450,'A+','completed','BAG2037',4,DATE '2024-08-06','whole_blood'),
(38,38,4,NULL,5,5,NULL,DATE '2024-02-16',480,'O-','tested','BAG2038',4,DATE '2024-08-14','whole_blood'),
(39,39,5,NULL,5,5,NULL,DATE '2024-02-19',500,'B+','collected','BAG2039',4,DATE '2025-02-19','plasma'),
(40,40,6,NULL,5,5,NULL,DATE '2024-02-23',470,'AB-','completed','BAG2040',4,DATE '2024-02-28','platelets'),
(41,41,7,NULL,5,5,NULL,DATE '2024-02-12',500,'A-','tested','BAG2041',4,DATE '2024-08-10','whole_blood'),
(42,42,8,NULL,5,5,NULL,DATE '2024-02-20',450,'O+','completed','BAG2042',4,DATE '2025-02-20','plasma'),
(43,43,9,NULL,5,5,NULL,DATE '2024-02-24',480,'B-','collected','BAG2043',4,DATE '2024-08-22','whole_blood');