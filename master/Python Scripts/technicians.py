import pandas as pd
import random

NUM_RECORDS = 10_000
HOSPITAL_COUNT = 1500  # must match your hospitals table

# ---------------- NAME DATA (same pattern as donors) ----------------

south_states = {
    "male_first": ["Srinivas","Venkatesh","Ravi","Mahesh","Prasad","Ramesh","Naresh","Suresh","Anil","Harish"],
    "female_first": ["Lakshmi","Anusha","Swathi","Deepika","Keerthi","Bhavani"],
    "last": ["Reddy","Naidu","Chowdary","Goud","Rao","Varma","Raju","Kumar"]
}

other_names = {
    "male_first": ["Ajay","Sachin","Rohit","Vishal"],
    "female_first": ["Sneha","Aarti","Pallavi"],
    "last": ["Patil","Deshmukh","Kulkarni","Shinde","Pawar"]
}

regions = [south_states]*6 + [other_names]*2

# ---------------- HELPERS ----------------

qualifications = [
    "DMLT","BMLT","MSc Medical Lab Technology",
    "Diploma in Lab Technician","BSc Microbiology",
    "Phlebotomy Certification"
]

domains = ["hospital.com","healthcare.in","medico.in"]

def generate_name(data, gender):
    if gender == "Male":
        first = random.choice(data["male_first"])
    elif gender == "Female":
        first = random.choice(data["female_first"])
    else:
        first = random.choice(data["male_first"] + data["female_first"])

    last = random.choice(data["last"])
    return f"{first} {last}"

def generate_phone():
    return f"+91{random.randint(6000000000,9999999999)}"

def generate_email(name):
    clean = name.replace(" ", "").lower()
    return f"{clean[:12]}{random.randint(1,999)}@{random.choice(domains)}"

# ---------------- GENERATION ----------------

data = []

for i in range(1, NUM_RECORDS + 1):
    region = random.choice(regions)

    gender = random.choices(["Male","Female","Other"], weights=[49,49,2])[0]
    name = generate_name(region, gender)

    primary_hospital = random.randint(1, HOSPITAL_COUNT)

    # 30% technicians have secondary hospital
    if random.random() < 0.3:
        secondary_hospital = random.randint(1, HOSPITAL_COUNT)
        if secondary_hospital == primary_hospital:
            secondary_hospital = None
    else:
        secondary_hospital = None

    record = {
        "technician_id": i,
        "hospital_id": primary_hospital,
        "assigned_hospital_id": secondary_hospital,
        "name": name,
        "qualification": random.choice(qualifications),
        "phone_number": generate_phone(),
        "email_address": generate_email(name)
    }

    data.append(record)

df = pd.DataFrame(data)


# 🔥 FIX: prevent float conversion
df["assigned_hospital_id"] = df["assigned_hospital_id"].astype("Int64")

# enforce column order
df = df[[
"technician_id",
"hospital_id",
"assigned_hospital_id",
"name",
"qualification",
"phone_number",
"email_address"
]]

df.to_csv("technicians.csv", index=False)

print("Technicians data generated successfully!")