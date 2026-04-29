CREATE TABLE raw.donors (
donor_id BIGINT PRIMARY KEY,
registered_by_staff_id BIGINT,
primary_contact_id BIGINT,
name VARCHAR(255) NOT NULL,
age INT NOT NULL CHECK (age BETWEEN 18 AND 60),
gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male','Female','Other')),
weight NUMERIC(5,2) CHECK (weight BETWEEN 40 AND 150),
blood_group VARCHAR(3) NOT NULL CHECK (blood_group IN ('A+','A-','B+','B-','O+','O-','AB+','AB-')),
last_donation_date DATE,
is_eligible BOOLEAN NOT NULL DEFAULT FALSE,
donations_count INT DEFAULT 0 CHECK (donations_count >= 0),
contact_method_type VARCHAR(10) NOT NULL DEFAULT 'phone' CHECK (contact_method_type IN ('phone','email')),
contact_detail VARCHAR(255),
donor_type VARCHAR(20) DEFAULT 'individual' CHECK (donor_type IN ('individual','corporation','anonymous')),
notes TEXT,
last_health_check_date DATE,
donation_frequency_allowed INT CHECK (donation_frequency_allowed BETWEEN 1 AND 12),
location VARCHAR(255),
days_since_last_donation INT,
blood_group_A_plus BOOLEAN DEFAULT FALSE,
blood_group_A_minus BOOLEAN DEFAULT FALSE,
blood_group_B_plus BOOLEAN DEFAULT FALSE,
blood_group_B_minus BOOLEAN DEFAULT FALSE,
blood_group_O_plus BOOLEAN DEFAULT FALSE,
blood_group_O_minus BOOLEAN DEFAULT FALSE,
blood_group_AB_plus BOOLEAN DEFAULT FALSE,
blood_group_AB_minus BOOLEAN DEFAULT FALSE
);





CREATE TABLE raw.recipients (
recipient_id BIGINT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
age INT NOT NULL CHECK (age BETWEEN 0 AND 100),
blood_group VARCHAR(3) NOT NULL CHECK (
    blood_group IN ('A+','A-','B+','B-','O+','O-','AB+','AB-')
),
location VARCHAR(255)
);






CREATE TABLE raw.hospitals (
hospital_id BIGINT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
street_address VARCHAR(255) NOT NULL,
city VARCHAR(100) NOT NULL,
province VARCHAR(100) NOT NULL,
postal_code VARCHAR(10) NOT NULL,
country VARCHAR(100) NOT NULL DEFAULT 'India',
phone_number VARCHAR(20) NOT NULL,
email_address VARCHAR(255) NOT NULL,
hospital_type VARCHAR(100),
operating_hours VARCHAR(100),
accreditation_status VARCHAR(100),
emergency_contact VARCHAR(20)
);






CREATE TABLE raw.technicians (
technician_id BIGINT PRIMARY KEY,
hospital_id BIGINT,
assigned_hospital_id BIGINT,
name VARCHAR(255) NOT NULL,
qualification VARCHAR(255),
phone_number VARCHAR(20) NOT NULL,
email_address VARCHAR(255) NOT NULL
);





CREATE TABLE raw.tasks (
task_id BIGINT PRIMARY KEY,
description VARCHAR(255)
);




CREATE TABLE raw.technician_tasks (
technician_id BIGINT NOT NULL,
task_id BIGINT NOT NULL
);




CREATE TABLE raw.donations (
donation_id BIGINT PRIMARY KEY,
donor_id BIGINT,
hospital_id BIGINT,
recipient_id BIGINT,
collection_technician_id BIGINT,
processed_by_technician_id BIGINT,
test_result_id BIGINT,
date DATE NOT NULL,
quantity INT NOT NULL,
blood_group VARCHAR(3) NOT NULL CHECK (
    blood_group IN ('A+','A-','B+','B-','O+','O-','AB+','AB-')
),
status VARCHAR(20) NOT NULL CHECK (
    status IN ('pending','complete','tested','distributed')
) DEFAULT 'pending',
bag_serial_number VARCHAR(255),
storage_temperature NUMERIC(5,0),
expiration_date DATE NOT NULL,
donation_type VARCHAR(20) CHECK (
    donation_type IN ('whole_blood','platelets','plasma')
)
);






CREATE TABLE raw.blood_tests (
test_id BIGINT PRIMARY KEY,
donor_id BIGINT NOT NULL,
donation_id BIGINT,
technician_id BIGINT,
test_type VARCHAR(100) NOT NULL,
date DATE NOT NULL,
result VARCHAR(10),
comments TEXT
);





CREATE TABLE raw.blood_inventory (
inventory_id BIGINT PRIMARY KEY,
donation_id BIGINT,
blood_group VARCHAR(3) NOT NULL,
units_available INT NOT NULL,
quality VARCHAR(20) NOT NULL,
status VARCHAR(20) NOT NULL,
date_received DATE NOT NULL,
expiration_date DATE NOT NULL,
temperature NUMERIC(3,1) NOT NULL,
volume INT NOT NULL,
recipient_id BIGINT
);





CREATE TABLE raw.recipient_requests (
request_id BIGINT PRIMARY KEY,
recipient_id BIGINT NOT NULL,
hospital_id BIGINT,
required_date DATE NOT NULL,
urgency VARCHAR(10) NOT NULL
);




CREATE TABLE raw.donor_history (
history_id BIGINT PRIMARY KEY,
donor_id BIGINT,
donation_id BIGINT,
reaction VARCHAR(10),
notes TEXT
);



CREATE TABLE raw.blood_type_compatibility (
donor_blood_type VARCHAR(3),
recipient_blood_type VARCHAR(3)
);