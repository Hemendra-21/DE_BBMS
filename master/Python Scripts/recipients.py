import pandas as pd
import random

NUM_RECORDS = 800_000

# ---------------- REGION DATA ----------------

regions_data = {
    # SOUTH (dominant)
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

    # EAST (low weight)
    "West Bengal": {
        "weight": 1,
        "cities": ["Kolkata","Howrah"],
        "male_first": ["Subhajit","Sourav"],
        "female_first": ["Ananya","Mousumi"],
        "last": ["Banerjee","Chatterjee","Mukherjee"]
    }
}

# build weighted region list
regions = []
for state, data in regions_data.items():
    for _ in range(data["weight"]):
        regions.append((state, data))

# ---------------- HELPERS ----------------

blood_groups = ["O+","A+","B+","AB+","O-","A-","B-","AB-"]
blood_weights = [40, 25, 20, 5, 5, 2, 2, 1]

def generate_name(state_data, gender):
    if gender == "Male":
        first = random.choice(state_data["male_first"])
    elif gender == "Female":
        first = random.choice(state_data["female_first"])
    else:
        first = random.choice(state_data["male_first"] + state_data["female_first"])
    last = random.choice(state_data["last"])
    return f"{first} {last}"

# ---------------- GENERATION ----------------

data = []

for i in range(1, NUM_RECORDS + 1):

    state, state_data = random.choice(regions)
    city = random.choice(state_data["cities"])
    location = f"{city}, {state}"

    gender = random.choices(["Male","Female","Other"], weights=[49,49,2])[0]
    name = generate_name(state_data, gender)

    # realistic age distribution
    age = int(random.triangular(0, 90, 35))

    record = {
        "recipient_id": i,
        "name": name,
        "age": age,
        "blood_group": random.choices(blood_groups, weights=blood_weights)[0],
        "location": location
    }

    data.append(record)

df = pd.DataFrame(data)

df = df[["recipient_id","name","age","blood_group","location"]]

df.to_csv("recipients.csv", index=False)

print("Recipients data generated successfully!")