import pandas as pd
import random
from datetime import datetime, timedelta
import os

# ---------------- CONFIG ----------------
TOTAL_DONATIONS = 2_500_000
CHUNK_SIZE = 100_000

START_DATE = datetime(2023, 1, 1)
END_DATE = datetime.now()

BASE_PATH = r"C:\Users\Hemendra Chandaluri\DE_CAPSTONE_PROJECT\master\CSV Files"
OUTPUT_FILE = os.path.join(BASE_PATH, "donations.csv")

# ---------------- LOAD DATA ----------------
donors_df = pd.read_csv(
    os.path.join(BASE_PATH, "donors.csv"),
    usecols=["donor_id","blood_group","location"]
)

recipients_df = pd.read_csv(
    os.path.join(BASE_PATH, "recipients.csv"),
    usecols=["recipient_id","blood_group"]
)

hospitals_df = pd.read_csv(
    os.path.join(BASE_PATH, "hospitals.csv"),
    usecols=["hospital_id","province"]
)

# ---------------- PREP ----------------

# donor state
donors_df["state"] = donors_df["location"].apply(lambda x: x.split(", ")[1])
donor_list = donors_df[["donor_id","blood_group","state"]].values.tolist()

# hospital map
hospital_map = {}
for _, row in hospitals_df.iterrows():
    hospital_map.setdefault(row["province"], []).append(row["hospital_id"])
all_hospitals = hospitals_df["hospital_id"].tolist()

# recipient groups
recipient_groups = {}
for bg in ["O-","O+","A-","A+","B-","B+","AB-","AB+"]:
    recipient_groups[bg] = recipients_df[
        recipients_df["blood_group"] == bg
    ]["recipient_id"].tolist()

# 🔥 PRECOMPUTE compatibility (CRITICAL FIX)
compatibility = {
    "O-": ["O-","O+","A-","A+","B-","B+","AB-","AB+"],
    "O+": ["O+","A+","B+","AB+"],
    "A-": ["A-","A+","AB-","AB+"],
    "A+": ["A+","AB+"],
    "B-": ["B-","B+","AB-","AB+"],
    "B+": ["B+","AB+"],
    "AB-": ["AB-","AB+"],
    "AB+": ["AB+"]
}

# 👉 Flatten once
compatibility_map = {}
for donor_bg, rec_bgs in compatibility.items():
    combined = []
    for bg in rec_bgs:
        combined.extend(recipient_groups[bg])
    compatibility_map[donor_bg] = combined

# ---------------- HELPERS ----------------

def seasonal_random_date():
    while True:
        d = START_DATE + timedelta(days=random.randint(0, (END_DATE - START_DATE).days))
        m = d.month

        p = 0.9 if m in [1,2,3,10,11,12] else 0.6 if m in [7,8,9] else 0.4
        if d.weekday() >= 5:
            p += 0.1

        if random.random() < p:
            return d

def get_status():
    return random.choices(
        ["pending","tested","complete","distributed"],
        weights=[5,15,40,40]
    )[0]

def get_type():
    return random.choices(
        ["whole_blood","platelets","plasma"],
        weights=[70,20,10]
    )[0]

# ---------------- GENERATION ----------------

if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)

with open(OUTPUT_FILE, "w") as f:
    f.write(",".join([
        "donation_id","donor_id","hospital_id","recipient_id",
        "collection_technician_id","processed_by_technician_id",
        "test_result_id","date","quantity","blood_group","status",
        "bag_serial_number","storage_temperature","expiration_date","donation_type"
    ]) + "\n")

donation_id = 1

while donation_id <= TOTAL_DONATIONS:

    lines = []

    for _ in range(CHUNK_SIZE):

        if donation_id > TOTAL_DONATIONS:
            break

        donor_id, donor_bg, donor_state = random.choice(donor_list)

        d = seasonal_random_date()

        # geo sync
        if donor_state in hospital_map and random.random() < 0.8:
            hospital_id = random.choice(hospital_map[donor_state])
        else:
            hospital_id = random.choice(all_hospitals)

        # 🔥 FAST compatibility lookup
        if random.random() < 0.5:
            pool = compatibility_map[donor_bg]
            recipient_id = random.choice(pool) if pool else ""
        else:
            recipient_id = ""

        d_type = get_type()

        if d_type == "whole_blood":
            quantity = 450
        elif d_type == "platelets":
            quantity = random.choice([200, 250, 300])
        else:
            quantity = random.choice([250, 300, 350])

        lines.append(",".join([
            str(donation_id),
            str(donor_id),
            str(hospital_id),
            str(recipient_id),
            str(random.randint(1,10000)),
            str(random.randint(1,10000)),
            "",
            str(d.date()),
            str(quantity),
            donor_bg,
            get_status(),
            f"BAG{donation_id}",
            str(random.choice([2,3,4,5])),
            str((d + timedelta(days=35)).date()),
            d_type
        ]))

        donation_id += 1

    with open(OUTPUT_FILE, "a") as f:
        f.write("\n".join(lines) + "\n")

    print(f"{donation_id} rows done")

print("DONE")