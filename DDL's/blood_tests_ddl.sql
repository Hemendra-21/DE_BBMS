create table if not exists raw.blood_tests(
	test_id text,
	donor_id text,
	technician_id text,
	date text,
	disease_tested text,
	result text,
	test_type text,
	comments text
)

INSERT INTO raw.blood_tests
(test_id, donor_id, technician_id, test_date, disease_tested, result, test_type, comments, ingested_at)
VALUES
(61, 1, 3, DATE '2020-10-16', 'Blood Group', 'A+', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(62, 2, 4, DATE '2021-01-21', 'HIV', 'Negative', 'Disease Screening', 'Clear of HIV', TIMESTAMP '2026-03-03 12:51:06'),
(63, 3, 3, DATE '2021-02-19', 'Blood Group', 'B+', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(64, 4, 17, DATE '2020-12-06', 'Hepatitis B', 'Negative', 'Disease Screening', 'No hepatitis B detected', TIMESTAMP '2026-03-03 12:51:06'),
(65, 5, 9, DATE '2021-03-11', 'General Health', 'Healthy', 'General Health', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(66, 6, 6, DATE '2020-09-23', 'HIV', 'Negative', 'Disease Screening', 'No HIV', TIMESTAMP '2026-03-03 12:51:06'),
(67, 7, 20, DATE '2020-11-13', 'Blood Group', 'O-', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(68, 8, 9, DATE '2021-01-31', 'Hepatitis B', 'Negative', 'Disease Screening', 'No issues detected', TIMESTAMP '2026-03-03 12:51:06'),
(69, 9, 16, DATE '2020-08-20', 'General Health', 'Healthy', 'General Health', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(70, 10, 11, DATE '2021-03-06', 'HIV', 'Negative', 'Disease Screening', 'Negative result', TIMESTAMP '2026-03-03 12:51:06'),
(71, 11, 13, DATE '2020-07-12', 'Blood Group', 'AB+', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(72, 12, 14, DATE '2021-02-06', 'Hepatitis B', 'Negative', 'Disease Screening', 'Test is clear', TIMESTAMP '2026-03-03 12:51:06'),
(73, 13, 15, DATE '2020-10-29', 'General Health', 'Healthy', 'General Health', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(74, 14, 5, DATE '2021-04-10', 'HIV', 'Negative', 'Disease Screening', 'HIV test negative', TIMESTAMP '2026-03-03 12:51:06'),
(75, 15, 5, DATE '2020-08-31', 'Blood Group', 'A-', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(76, 16, 7, DATE '2021-01-16', 'Hepatitis B', 'Negative', 'Disease Screening', 'Negative for hepatitis B', TIMESTAMP '2026-03-03 12:51:06'),
(77, 17, 7, DATE '2020-11-21', 'General Health', 'Healthy', 'General Health', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(78, 18, 7, DATE '2021-03-21', 'HIV', 'Negative', 'Disease Screening', 'All clear', TIMESTAMP '2026-03-03 12:51:06'),
(79, 19, 16, DATE '2020-09-06', 'Blood Group', 'O+', 'Blood Typing', NULL, TIMESTAMP '2026-03-03 12:51:06'),
(80, 20, 16, NULL, 'Hepatitis B', 'Negative', 'Disease Screening', 'Hepatitis B not detected', TIMESTAMP '2026-03-03 12:51:06');