
--
-- Table structure for table `blood_inventory`
--

CREATE TABLE `blood_inventory` (
  `inventory_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for inventory items',
  `donation_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Reference to the donation from which this blood unit originated',
  `blood_group` varchar(3) NOT NULL COMMENT 'Blood group category',
  `units_available` int(10) UNSIGNED NOT NULL COMMENT 'Number of units available',
  `quality` enum('Good','Contaminated') NOT NULL DEFAULT 'Good' COMMENT 'Quality status of the blood',
  `status` enum('stored','tested','distributed','discarded') NOT NULL DEFAULT 'stored' COMMENT 'Current status of the blood unit',
  `date_received` date NOT NULL COMMENT 'The date when the blood unit was received',
  `expiration_date` date NOT NULL COMMENT 'The expiration date for the blood unit, after which it cannot be used',
  `temperature` decimal(3,1) NOT NULL COMMENT 'Storage temperature of the blood unit in Celsius',
  `volume` int(10) UNSIGNED NOT NULL COMMENT 'Volume of the blood unit in milliliters (ml)',
  `recipient_id` int(10) UNSIGNED DEFAULT NULL
) ;






-- Table structure for table `blood_tests`
--

CREATE TABLE `blood_tests` (
  `test_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each blood test',
  `donor_id` int(10) UNSIGNED NOT NULL COMMENT 'References the donor''s unique identifier',
  `donation_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'References the donation associated with this test',
  `technician_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'References the technician responsible for the test',
   `test_type` varchar(255) NOT NULL COMMENT 'The type of test performed, such as blood typing or disease screening',
  `date` date NOT NULL COMMENT 'Date the test was performed',
  `result` enum('Positive','Negative') DEFAULT NULL COMMENT 'Result of the test',
  `comments` text DEFAULT NULL COMMENT 'Additional observations or notes about the test'
);
------------------------------------------






--
-- Table structure for table `blood_type_compatibility`
--

CREATE TABLE `blood_type_compatibility` (
  `donor_blood_type` varchar(3) DEFAULT NULL,
  `recipient_blood_type` varchar(3) DEFAULT NULL
) 






--
-- Table structure for table `donations`
--

CREATE TABLE `donations` (
  `donation_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each donation',
  `donor_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the donor who made this donation',
  `hospital_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the hospital where this donation took place',
  `recipient_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the recipient for this donation, if applicable',
  `collection_technician_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the technician who collected this donation',
  `processed_by_technician_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the technician who processed this donation',
  `test_result_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier of the test result associated with this donation',
  `date` date NOT NULL COMMENT 'Date of the donation',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT 'Quantity of blood donated',
  `blood_group` varchar(3) NOT NULL COMMENT 'Blood group of the donated blood',
  `status` enum('pending','complete','tested','distributed') NOT NULL DEFAULT 'pending' COMMENT 'The current status of the donation',
  `bag_serial_number` varchar(255) DEFAULT NULL COMMENT 'References the ID of the collection technician',
  `storage_temperature` decimal(10,0) DEFAULT NULL COMMENT 'Temperature at which the blood was stored',
  `expiration_date` date NOT NULL COMMENT 'The date when the blood is no longer usable',
  `donation_type` enum('whole_blood','platelets','plasma') DEFAULT NULL COMMENT 'Type of donation'
) ;







--
-- Table structure for table `donors`
--

CREATE TABLE `donors` (
  `donor_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each donor',
  `registered_by_staff_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the staff member who registered this donor',
  `primary_contact_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the primary contact of this donor',
  `name` varchar(255) NOT NULL COMMENT 'Full name of the donor',
  `age` int(10) UNSIGNED NOT NULL COMMENT 'Age of the donor',
  `gender` enum('Male','Female','Other') NOT NULL COMMENT 'Gender of the donor',
  `weight` decimal(5,2) DEFAULT NULL COMMENT 'Weight of the donor in kilograms',
  `blood_group` varchar(3) NOT NULL COMMENT 'Blood group of the donor',
  `last_donation_date` date DEFAULT NULL COMMENT 'The last date the donor donated blood',
  `is_eligible` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Whether the donor is currently eligible to donate',
  `donations_count` int(10) UNSIGNED DEFAULT 0 COMMENT 'Total number of donations made by the donor',
  `contact_method_type` enum('phone','email') NOT NULL DEFAULT 'phone' COMMENT 'Preferred contact method of the donor',
  `contact_detail` varchar(255) DEFAULT NULL COMMENT 'Contact detail corresponding to the selected contact method',
  `donor_type` enum('individual','corporation','anonymous') DEFAULT 'individual' COMMENT 'Type of donor',
  `notes` text DEFAULT NULL COMMENT 'Additional notes about the donor',
  `last_health_check_date` date DEFAULT NULL COMMENT 'Date of the last health check for the donor',
  `donation_frequency_allowed` int(10) UNSIGNED DEFAULT NULL COMMENT 'Frequency of donations allowed per year',
  `location` varchar(255) DEFAULT NULL COMMENT 'Geographical location of the donor',
  `days_since_last_donation` int(11) DEFAULT NULL COMMENT 'Calculated days since the last donation',
  `blood_group_A_plus` tinyint(1) DEFAULT 0,
  `blood_group_O_minus` tinyint(1) DEFAULT 0,
  `blood_group_B_plus` tinyint(1) DEFAULT 0,
  `blood_group_AB_minus` tinyint(1) DEFAULT 0,
  `blood_group_A_minus` tinyint(1) DEFAULT 0,
  `blood_group_B_minus` tinyint(1) DEFAULT 0,
  `blood_group_O_plus` tinyint(1) DEFAULT 0,
  `blood_group_AB_plus` tinyint(1) DEFAULT 0
) ;







--
-- Table structure for table `donor_history`
--

CREATE TABLE `donor_history` (
  `history_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each donor history record',
  `donor_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the donor',
  `donation_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the donation associated with this donor history',
  `reaction` enum('none','mild','severe') DEFAULT NULL COMMENT 'Type of reaction experienced by the donor post-donation (none, mild, or severe)',
  `notes` text DEFAULT NULL COMMENT 'Additional notes or details about the donor’s history'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;








--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `hospital_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each hospital',
  `name` varchar(255) NOT NULL COMMENT 'Name of the hospital',
  `street_address` varchar(255) NOT NULL COMMENT 'Street address including building number and street name.',
  `city` varchar(100) NOT NULL COMMENT 'City or municipality where the hospital is located.',
  `province` varchar(100) NOT NULL DEFAULT 'Quebec' COMMENT 'Province or state where the hospital is situated.',
  `postal_code` varchar(7) NOT NULL COMMENT 'Postal or ZIP code of the hospital''s location.',
  `country` varchar(100) NOT NULL DEFAULT 'Canada' COMMENT 'Country in which the hospital operates.',
  `phone_number` varchar(255) NOT NULL COMMENT 'Primary contact phone number for the hospital',
  `email_address` varchar(255) NOT NULL COMMENT 'Primary contact email address for the hospital',
  `hospital_type` varchar(255) DEFAULT NULL COMMENT 'Type of hospital',
  `operating_hours` varchar(255) DEFAULT NULL COMMENT 'Operating hours of the hospital',
  `accreditation_status` varchar(255) DEFAULT NULL COMMENT 'Accreditation status of the hospital',
  `emergency_contact` varchar(255) DEFAULT NULL COMMENT 'Emergency contact number for the hospital'
) ;









--
-- Table structure for table `recipients`
--

CREATE TABLE `recipients` (
  `recipient_id` int(11) UNSIGNED NOT NULL COMMENT 'Unique identifier for each recipient',
  `name` varchar(255) NOT NULL COMMENT 'Full name of the blood recipient',
  `age` int(11) UNSIGNED NOT NULL COMMENT 'Age of the recipient',
  `blood_group` varchar(3) NOT NULL COMMENT 'Blood group of the recipient',
  `location` varchar(255) DEFAULT NULL COMMENT 'Location of the recipient'
) ;







--
-- Table structure for table `recipient_requests`
--

CREATE TABLE `recipient_requests` (
  `request_id` int(11) UNSIGNED NOT NULL COMMENT 'Unique identifier for each recipient request',
  `recipient_id` int(11) UNSIGNED NOT NULL COMMENT 'identifier for each recipient who made blood request',
  `hospital_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Unique identifier for each hospital',
  `required_date` date NOT NULL COMMENT 'Date when the blood is required for the recipient',
  `urgency` enum('low','medium','high') NOT NULL DEFAULT 'medium' COMMENT 'Describes the urgency level of the request'
) ;








--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `task_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each task',
  `description` varchar(255) DEFAULT NULL COMMENT 'Detailed description of the task'
) 







--
-- Table structure for table `technicians`
--

CREATE TABLE `technicians` (
  `technician_id` int(10) UNSIGNED NOT NULL COMMENT 'Unique identifier for each technician',
  `hospital_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the primary hospital where the technician works.',
  `assigned_hospital_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Identifier for the secondary hospital where the technician may be assigned.',
  `name` varchar(255) NOT NULL COMMENT 'Full name of the technician.',
  `qualification` varchar(255) DEFAULT NULL COMMENT 'Professional qualifications and certifications of the technician.',
  `phone_number` varchar(255) NOT NULL COMMENT 'Primary contact phone number for the technician',
  `email_address` varchar(255) NOT NULL COMMENT 'Primary contact email address for the technician'
) ;






--
-- Table structure for table `technician_tasks`
--

CREATE TABLE `technician_tasks` (
  `technician_id` int(10) UNSIGNED NOT NULL COMMENT 'Identifier for the technician',
  `task_id` int(10) UNSIGNED NOT NULL COMMENT 'Identifier for the task assigned to the technician'
)