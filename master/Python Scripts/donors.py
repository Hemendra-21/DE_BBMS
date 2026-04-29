import pandas as pd
import random
from datetime import datetime, timedelta

NUM_RECORDS = 400_000
START_DATE = datetime(2023, 1, 1)
END_DATE = datetime.now()

# ---------------- REGION DATA ----------------

regions_data = {
    # SOUTH (heavy weight)
    "Andhra Pradesh": {
        "weight": 5,
        "cities": ["Visakhapatnam","Vijayawada","Guntur","Tirupati","Kurnool","Nellore"],
        "male_first": ["Srinivas","Venkatesh","Ravi","Mahesh","Prasad","Ramesh","Naresh","Suresh"],
        "female_first": ["Lakshmi","Anusha","Swathi","Deepika","Keerthi","Bhavani"],
        "last": ["Reddy","Naidu","Chowdary","Goud","Rao","Varma"]
    },
    "Tamil Nadu": {
        "weight": 5,
        "cities": ["Chennai","Coimbatore","Madurai","Trichy","Salem","Erode"],
        "male_first": ["Arun","Karthik","Vijay","Suresh","Dinesh","Saravanan"],
        "female_first": ["Priya","Divya","Meena","Kavya","Revathi"],
        "last": ["Iyer","Pillai","Subramanian","Krishnan","Raman"]
    },
    "Karnataka": {
        "weight": 4,
        "cities": ["Bengaluru","Mysuru","Mangalore","Hubli"],
        "male_first": ["Raghavendra","Manjunath","Shivakumar","Anil"],
        "female_first": ["Deepa","Nisha","Asha"],
        "last": ["Gowda","Shetty","Hegde","Rao"]
    },
    "Kerala": {
        "weight": 3,
        "cities": ["Kochi","Trivandrum","Kozhikode"],
        "male_first": ["Anoop","Sajith","Thomas","Joseph"],
        "female_first": ["Anu","Lekshmi","Mary"],
        "last": ["Menon","Nair","Kurup","Varghese"]
    },

    # WEST
    "Maharashtra": {
        "weight": 3,
        "cities": ["Mumbai","Pune","Nagpur","Nashik"],
        "male_first": ["Ajay","Sachin","Rohit","Vishal"],
        "female_first": ["Sneha","Aarti","Pallavi"],
        "last": ["Patil","Deshmukh","Kulkarni","Pawar"]
    },
    "Gujarat": {
        "weight": 2,
        "cities": ["Ahmedabad","Surat","Vadodara"],
        "male_first": ["Harsh","Raj","Amit"],
        "female_first": ["Pooja","Riya"],
        "last": ["Patel","Shah","Mehta"]
    },

    # NORTH
    "Uttar Pradesh": {
        "weight": 2,
        "cities": ["Lucknow","Kanpur","Varanasi","Agra"],
        "male_first": ["Amit","Rahul","Vikas"],
        "female_first": ["Neha","Pooja","Ritu"],
        "last": ["Sharma","Yadav","Verma"]
    },
    "Delhi": {
        "weight": 2,
        "cities": ["New Delhi"],
        "male_first": ["Rohit","Aman","Karan"],
        "female_first": ["Simran","Anjali"],
        "last": ["Malhotra","Khanna","Kapoor"]
    },

    # EAST (light weight)
    "West Bengal": {
        "weight": 1,
        "cities": ["Kolkata","Howrah"],
        "male_first": ["Subhajit","Sourav"],
        "female_first": ["Ananya","Mousumi"],
        "last": ["Banerjee","Chatterjee","Mukherjee"]
    }
}

# build weighted regions
regions = []
for state, data in regions_data.items():
    for _ in range(data["weight"]):
        regions.append((state, data))

# ---------------- HELPERS ----------------

blood_groups = ["O+","A+","B+","AB+","O-","A-","B-","AB-"]
blood_weights = [40,25,20,5,5,2,2,1]

def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

def generate_name(state_data, gender):
    if gender == "Male":
        first = random.choice(state_data["male_first"])
    elif gender == "Female":
        first = random.choice(state_data["female_first"])
    else:
        first = random.choice(state_data["male_first"] + state_data["female_first"])
    last = random.choice(state_data["last"])
    return f"{first} {last}"

def assign_blood_flags(bg):
    return {
        "blood_group_A_plus": int(bg == "A+"),
        "blood_group_A_minus": int(bg == "A-"),
        "blood_group_B_plus": int(bg == "B+"),
        "blood_group_B_minus": int(bg == "B-"),
        "blood_group_O_plus": int(bg == "O+"),
        "blood_group_O_minus": int(bg == "O-"),
        "blood_group_AB_plus": int(bg == "AB+"),
        "blood_group_AB_minus": int(bg == "AB-"),
    }

# ---------------- GENERATION ----------------

data = []

for i in range(1, NUM_RECORDS + 1):

    state, state_data = random.choice(regions)
    city = random.choice(state_data["cities"])
    location = f"{city}, {state}"

    gender = random.choices(["Male","Female","Other"], weights=[49,49,2])[0]
    name = generate_name(state_data, gender)

    last_donation_date = random_date(START_DATE, END_DATE)
    days_since_last = (END_DATE - last_donation_date).days

    record = {
        "donor_id": i,
        "registered_by_staff_id": random.randint(1, 10000),
        "primary_contact_id": random.randint(1, 10000),
        "name": name,
        "age": random.randint(18, 60),
        "gender": gender,
        "weight": round(random.uniform(50, 90), 2),
        "blood_group": random.choices(blood_groups, weights=blood_weights)[0],
        "last_donation_date": last_donation_date.date(),
        "is_eligible": 1 if days_since_last >= 90 else 0,
        "donations_count": random.randint(0, 10),
        "contact_method_type": "phone",
        "contact_detail": f"+91{random.randint(6000000000,9999999999)}",
        "donor_type": "individual",
        "notes": "",
        "last_health_check_date": last_donation_date.date(),
        "donation_frequency_allowed": 3,
        "location": location,
        "days_since_last_donation": days_since_last,
    }

    record.update(assign_blood_flags(record["blood_group"]))
    data.append(record)

df = pd.DataFrame(data)

# enforce order
df = df[[
"donor_id","registered_by_staff_id","primary_contact_id","name","age","gender","weight",
"blood_group","last_donation_date","is_eligible","donations_count",
"contact_method_type","contact_detail","donor_type","notes",
"last_health_check_date","donation_frequency_allowed","location",
"days_since_last_donation",
"blood_group_A_plus","blood_group_A_minus","blood_group_B_plus","blood_group_B_minus",
"blood_group_O_plus","blood_group_O_minus","blood_group_AB_plus","blood_group_AB_minus"
]]

df.to_csv("donors.csv", index=False)

print("Done")