import pandas as pd
import random
from datetime import datetime, timedelta
import os

# ---------------- CONFIG ----------------
TOTAL_REQUESTS = 2_500_000
CHUNK_SIZE = 100_000

BASE_PATH = r"C:\Users\Hemendra Chandaluri\DE_CAPSTONE_PROJECT\master\CSV Files"

RECIPIENTS_FILE = os.path.join(BASE_PATH, "recipients.csv")
HOSPITALS_FILE = os.path.join(BASE_PATH, "hospitals.csv")
INVENTORY_FILE = os.path.join(BASE_PATH, "blood_inventory.csv")
OUTPUT_FILE = os.path.join(BASE_PATH, "recipient_requests.csv")

# ---------------- LOAD DATA ----------------

recipients_df = pd.read_csv(
    RECIPIENTS_FILE,
    usecols=["recipient_id","location","blood_group"]
)

hospitals_df = pd.read_csv(
    HOSPITALS_FILE,
    usecols=["hospital_id","province"]
)

inventory_df = pd.read_csv(
    INVENTORY_FILE,
    usecols=["blood_group","date_received"]
)

inventory_df["date_received"] = pd.to_datetime(inventory_df["date_received"])

# ---------------- PREP ----------------

# extract state
recipients_df["state"] = recipients_df["location"].apply(lambda x: x.split(", ")[1])

# recipients grouped by blood group
bg_groups = recipients_df.groupby("blood_group")["recipient_id"].apply(list).to_dict()

# fast lookup maps
recipient_state_map = dict(zip(recipients_df["recipient_id"], recipients_df["state"]))

# hospital mapping
hospital_map = {}
for _, row in hospitals_df.iterrows():
    hospital_map.setdefault(row["province"], []).append(row["hospital_id"])

all_hospitals = hospitals_df["hospital_id"].tolist()

# inventory grouped by blood group
inv_groups = inventory_df.groupby("blood_group")["date_received"].apply(list).to_dict()

# ---------------- DEMAND WEIGHTS ----------------

demand_weights = {
    "O-": 25,
    "O+": 20,
    "A+": 15,
    "B+": 15,
    "A-": 8,
    "B-": 8,
    "AB+": 5,
    "AB-": 4
}

blood_groups = list(demand_weights.keys())
weights = list(demand_weights.values())

# ---------------- URGENCY DISTRIBUTION (FIX) ----------------

urgency_weights_map = {
    "O-":  [10, 50, 40],  # high emergency
    "O+":  [15, 55, 30],
    "A+":  [20, 60, 20],
    "B+":  [20, 60, 20],
    "A-":  [15, 60, 25],
    "B-":  [15, 60, 25],
    "AB+": [30, 60, 10],  # low urgency
    "AB-": [25, 65, 10]
}

# ---------------- CLEAN OUTPUT ----------------

if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)

with open(OUTPUT_FILE, "w") as f:
    f.write("request_id,recipient_id,hospital_id,required_date,urgency\n")

# ---------------- HELPERS ----------------

def get_urgency(bg):
    weights = urgency_weights_map.get(bg, [15,60,25])
    return random.choices(
        ["low","medium","high"],
        weights=weights
    )[0]

def get_required_date(bg, urgency):

    base_dates = inv_groups.get(bg)

    if not base_dates:
        base_date = datetime.now()
    else:
        base_date = random.choice(base_dates)

    if urgency == "high":
        return base_date + timedelta(days=random.randint(-2, 1))

    elif urgency == "medium":
        return base_date + timedelta(days=random.randint(-5, 5))

    else:
        return base_date + timedelta(days=random.randint(3, 15))

# ---------------- GENERATION ----------------

request_id = 1

while request_id <= TOTAL_REQUESTS:

    lines = []

    for _ in range(CHUNK_SIZE):

        if request_id > TOTAL_REQUESTS:
            break

        # demand skew
        bg = random.choices(blood_groups, weights=weights)[0]

        if bg not in bg_groups:
            continue

        recipient_id = random.choice(bg_groups[bg])
        state = recipient_state_map[recipient_id]

        urgency = get_urgency(bg)
        req_date = get_required_date(bg, urgency)

        # geo-aware hospital
        if state in hospital_map and random.random() < 0.8:
            hospital_id = random.choice(hospital_map[state])
        else:
            hospital_id = random.choice(all_hospitals)

        lines.append(",".join([
            str(request_id),
            str(recipient_id),
            str(hospital_id),
            str(req_date.date()),
            urgency
        ]))

        request_id += 1

    with open(OUTPUT_FILE, "a") as f:
        f.write("\n".join(lines) + "\n")

    print(f"{request_id} requests generated...")

print("Recipient requests generated successfully!")