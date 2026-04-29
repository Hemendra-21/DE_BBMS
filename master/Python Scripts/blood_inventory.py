import pandas as pd
import random
from datetime import datetime
import os

# ---------------- CONFIG ----------------
CHUNK_SIZE = 100_000

BASE_PATH = r"C:\Users\Hemendra Chandaluri\DE_CAPSTONE_PROJECT\master\CSV Files"

DONATIONS_FILE = os.path.join(BASE_PATH, "donations.csv")
TESTS_FILE = os.path.join(BASE_PATH, "blood_tests.csv")
REQUESTS_FILE = os.path.join(BASE_PATH, "recipient_requests.csv")
OUTPUT_FILE = os.path.join(BASE_PATH, "blood_inventory.csv")

# ---------------- CLEAN OUTPUT ----------------
if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)

with open(OUTPUT_FILE, "w") as f:
    f.write(",".join([
        "inventory_id","donation_id","blood_group","units_available",
        "quality","status","date_received","expiration_date",
        "temperature","volume","recipient_id"
    ]) + "\n")

# ---------------- LOAD TEST RESULTS ----------------
test_df = pd.read_csv(TESTS_FILE, usecols=["donation_id","result"])
test_map = dict(zip(test_df["donation_id"], test_df["result"]))

# ---------------- LOAD REQUESTS (DEMAND DRIVER) ----------------
requests_df = pd.read_csv(
    REQUESTS_FILE,
    usecols=["required_date"]
)

requests_df["required_date"] = pd.to_datetime(requests_df["required_date"])

# demand per day
daily_demand = requests_df.groupby("required_date").size().to_dict()

inventory_id = 1
now = datetime.now()

# ---------------- PROCESS ----------------

for chunk in pd.read_csv(DONATIONS_FILE, chunksize=CHUNK_SIZE):

    chunk["recipient_id"] = chunk["recipient_id"].where(pd.notnull(chunk["recipient_id"]), "")
    chunk["expiration_date"] = pd.to_datetime(chunk["expiration_date"])

    lines = []

    for row in chunk.itertuples(index=False):

        donation_id = int(row.donation_id)
        blood_group = row.blood_group
        donation_date = pd.to_datetime(row.date)
        expiry_date = row.expiration_date
        quantity = int(row.quantity)

        recipient_id = row.recipient_id
        if recipient_id != "":
            recipient_id = str(int(recipient_id))
        else:
            recipient_id = ""

        result = test_map.get(donation_id, "Negative")

        # ---------------- QUALITY ----------------
        quality = "Good" if result == "Negative" else "Contaminated"

        # ---------------- DEMAND-AWARE LOGIC ----------------
        demand = daily_demand.get(donation_date, 0)

        # demand tiers
        if demand > 5000:
            demand_factor = 0.8
        elif demand > 2000:
            demand_factor = 0.5
        else:
            demand_factor = 0.2

        # ---------------- STATUS ----------------
        if result == "Positive":
            status = "discarded"
            rec_id = ""

        elif expiry_date < now:
            status = "discarded"
            rec_id = ""

        elif random.random() < demand_factor:
            status = "distributed"
            rec_id = recipient_id if recipient_id != "" else ""

        else:
            status = "stored"
            rec_id = ""

        # ---------------- WRITE RECORD ----------------
        lines.append(",".join([
            str(inventory_id),
            str(donation_id),
            blood_group,
            "1",
            quality,
            status,
            str(donation_date.date()),
            str(expiry_date.date()),
            str(round(random.uniform(2.0, 6.0), 1)),
            str(quantity),
            rec_id
        ]))

        inventory_id += 1

    with open(OUTPUT_FILE, "a") as f:
        f.write("\n".join(lines) + "\n")

    print(f"{inventory_id} inventory rows done...")

print("Blood inventory generated successfully!")