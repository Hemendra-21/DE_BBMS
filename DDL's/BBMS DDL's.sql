-- Blood Inventory
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
	





-- Blood Tests

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




-- Blood Type Compatibility

create table if not exists raw.blood_type_compatibility(
	donor_blood_type text,
	recipient_blood_type text
)

-- Donations 

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


-- Donor History

create table if not exists raw.donor_history(
	history_id text,
	donor_id text,
	donation_id text,
	reaction text,
	notes text
);



-- Donors 

create table if not exists raw.donors(
	donor_id text,
	registered_by_staff_id text,
	primary_contact_id text,
	name text,
	age text,
	gender text,
	weight text,
	blood_group text,
	last_donation_date text,
	is_eligible text,
	donations_count text,
	contact_method_type text,
	contact_detail text,
	donor_type text,
	notes text,
	last_health_check_date text,
	donation_frequency_allowed text,
	location text,
	days_since_last_donation text,
	blood_group_A_plus text,
	blood_group_A_minus text,
	blood_group_B_plus text,
	blood_group_B_minus text,
	blood_group_O_plus text,
	blood_group_O_minus text,
	blood_group_AB_plus text,
	blood_group_AB_minus text
)




-- Hospitals 

create table if not exists raw.hospitals(
	hospital_id text,
	name text,
	street_address text,
	city text,
	province text,
	postal_code text,
	country text,
	phone_number text,
	email_address text,
	hospital_type text,
	operating_hours text,
	accreditation_status text,
	emergency_contact text
);





-- Recipients

create table if not exists raw.recipients(
	recipient_id text,
	hospital_id text,
	name text, 
	age text,
	blood_group text,
	required_date text,
	urgency text,
	location text
);






-- Tasks 

create table if not exists raw.tasks(
	task_id text,
	description text
);





-- Technician Tasks 

create table if not exists raw.technician_tasks(
	technician_id text,
	task_id text
);


-- Technicians 

create table if not exists raw.technicians(
	technician_id text,
	hospital_id text,
	assigned_hospital_id text,
	name text,
	qualification text,
	phone_number text,
	email_address text
);
