create table if not exists raw.blood_inventory(
	inventory_id text,
	donation_id text,
	blood_group text,
	units_available text,
	quality text,
	status text,
	date_received text,
	expiration_date text,
	temperature text,
	volume text,
	recipient_id text
)



INSERT INTO raw.blood_inventory 
(inventory_id, donation_id, blood_group, units_available, quality, status, date_received, expiration_date, temperature, volume, recipient_id) 
VALUES
(1, 1, 'A+', 10, 'Good', 'stored', '2024-01-01', '2024-06-01', 4.0, 500, NULL),
(2, 2, 'O-', 8, 'Good', 'tested', '2024-01-05', '2024-06-05', 4.0, 450, NULL),
(3, 3, 'B+', 15, 'Good', 'stored', '2024-01-10', '2024-06-10', 4.0, 500, NULL),
(4, 4, 'AB-', 5, 'Contaminated', 'discarded', '2024-01-15', '2024-06-15', 4.0, 400, NULL),
(5, 5, 'A-', 7, 'Good', 'distributed', '2024-01-20', '2024-06-20', 4.0, 350, 3),
(6, 6, 'B-', 9, 'Good', 'tested', '2024-01-25', '2024-06-25', 4.0, 500, NULL),
(7, 7, 'O+', 12, 'Good', 'stored', '2024-01-25', '2024-06-25', 4.0, 500, NULL),
(8, 8, 'AB+', 6, 'Good', 'stored', '2024-01-25', '2024-06-25', 4.0, 450, NULL),
(9, 9, 'A+', 11, 'Good', 'stored', '2024-02-01', '2024-07-01', 4.0, 550, NULL),
(10, 10, 'O-', 5, 'Good', 'distributed', '2024-02-01', '2024-07-01', 4.0, 300, 4),
(11, 11, 'B+', 14, 'Good', 'stored', '2024-02-05', '2024-07-05', 4.0, 520, NULL),
(12, 12, 'AB-', 4, 'Contaminated', 'discarded', '2024-02-05', '2024-07-05', 4.0, 400, NULL),
(13, 13, 'A-', 6, 'Good', 'tested', '2024-02-05', '2024-07-05', 4.0, 350, NULL),
(14, 14, 'B-', 10, 'Good', 'stored', '2024-02-05', '2024-07-05', 4.0, 500, NULL),
(15, 15, 'O+', 13, 'Good', 'stored', '2024-02-05', '2024-07-05', 4.0, 530, NULL),
(16, 16, 'AB+', 7, 'Good', 'tested', '2024-02-05', '2024-07-05', 4.0, 470, NULL);
