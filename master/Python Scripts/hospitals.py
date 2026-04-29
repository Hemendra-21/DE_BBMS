import pandas as pd
import random

NUM_RECORDS = 1500

# ---------------- INDIA CITY DATA ----------------

india_states = {
    "Andhra Pradesh": ["Visakhapatnam","Vijayawada","Guntur","Tirupati","Kurnool"],
    "Telangana": ["Hyderabad","Warangal","Nizamabad","Karimnagar"],
    "Tamil Nadu": ["Chennai","Coimbatore","Madurai","Trichy","Salem"],
    "Karnataka": ["Bengaluru","Mysuru","Mangalore","Hubli"],
    "Kerala": ["Kochi","Thiruvananthapuram","Kozhikode","Thrissur"],
    "Maharashtra": ["Mumbai","Pune","Nagpur","Nashik","Thane"],
    "Delhi": ["New Delhi"],
    "West Bengal": ["Kolkata","Howrah","Durgapur"],
    "Gujarat": ["Ahmedabad","Surat","Vadodara","Rajkot"],
    "Rajasthan": ["Jaipur","Jodhpur","Udaipur"],
    "Uttar Pradesh": ["Lucknow","Kanpur","Varanasi","Agra","Noida"],
    "Madhya Pradesh": ["Indore","Bhopal","Gwalior"],
    "Punjab": ["Ludhiana","Amritsar","Jalandhar"],
    "Haryana": ["Gurgaon","Faridabad"],
    "Odisha": ["Bhubaneswar","Cuttack"],
    "Bihar": ["Patna","Gaya"],
    "Assam": ["Guwahati"],
    "Jharkhand": ["Ranchi"],
    "Chhattisgarh": ["Raipur"]
}

# flatten weighted list (big states appear more)
regions = []
for state, cities in india_states.items():
    weight = 5 if len(cities) > 3 else 2
    for _ in range(weight):
        regions.append((state, cities))

# ---------------- HELPERS ----------------

hospital_prefix = [
    "City","General","Government","Apollo","Care","Global",
    "LifeCare","Sunrise","Medico","HealthPlus","Prime"
]

hospital_suffix = [
    "Hospital","Medical Center","Clinic","Health Institute",
    "Care Hospital","Speciality Hospital"
]

hospital_types = ["Government","Private","Trust","Multi-speciality"]
operating_hours = ["24/7","6 AM - 10 PM","24 Hours Emergency"]
accreditation = ["NABH Accredited","ISO Certified","State Certified"]

street_names = ["MG Road","Station Road","Nehru Street","Main Road","Ring Road","Market Road"]

domains = ["hospital.com","healthcare.in","medico.in"]

def generate_hospital_name(city):
    return f"{random.choice(hospital_prefix)} {city} {random.choice(hospital_suffix)}"

def generate_address():
    return f"{random.randint(1,999)}, {random.choice(street_names)}"

def generate_pincode():
    return str(random.randint(100000, 999999))

def generate_phone():
    return f"+91{random.randint(6000000000,9999999999)}"

def generate_email(name):
    clean = name.lower().replace(" ", "")
    return f"{clean[:15]}@{random.choice(domains)}"

# ---------------- GENERATION ----------------

data = []

for i in range(1, NUM_RECORDS + 1):
    state, cities = random.choice(regions)
    city = random.choice(cities)

    name = generate_hospital_name(city)

    record = {
        "hospital_id": i,
        "name": name,
        "street_address": generate_address(),
        "city": city,
        "province": state,
        "postal_code": generate_pincode(),
        "country": "India",
        "phone_number": generate_phone(),
        "email_address": generate_email(name),
        "hospital_type": random.choice(hospital_types),
        "operating_hours": random.choice(operating_hours),
        "accreditation_status": random.choice(accreditation),
        "emergency_contact": generate_phone()
    }

    data.append(record)

df = pd.DataFrame(data)

# enforce column order (COPY-safe)
df = df[[
"hospital_id","name","street_address","city","province","postal_code","country",
"phone_number","email_address","hospital_type","operating_hours",
"accreditation_status","emergency_contact"
]]

df.to_csv("hospitals.csv", index=False)

print("Hospitals data generated successfully!")