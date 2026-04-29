import pandas as pd
import random
from datetime import timedelta
import os

# ---------------- CONFIG ----------------
CHUNK_SIZE = 100_000
TECHNICIAN_COUNT = 10000

BASE_PATH = r"C:\Users\Hemendra Chandaluri\DE_CAPSTONE_PROJECT\master\CSV Files"
DONATIONS_FILE = os.path.join(BASE_PATH, "donations.csv")
OUTPUT_FILE = os.path.join(BASE_PATH, "blood_tests.csv")

# ---------------- CLEAN OUTPUT ----------------
if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)

# write header
with open(OUTPUT_FILE, "w") as f:
    f.write(",".join([
        "test_id","donor_id","donation_id","technician_id",
        "test_type","date","result","comments"
    ]) + "\n")

# ---------------- TEST TYPES ----------------
test_types = [
    "Blood Group Verification",
    "Infectious Disease Screening",
    "HIV Test",
    "Hepatitis B Test",
    "Hepatitis C Test",
    "Malaria Test",
    "Syphilis Test"
]

# ---------------- PROCESS ----------------

test_id = 1

for chunk in pd.read_csv(DONATIONS_FILE, chunksize=CHUNK_SIZE):

    # 🔥 Convert once per chunk (not per row)
    chunk["date"] = pd.to_datetime(chunk["date"])

    lines = []

    # 🔥 FAST LOOP
    for row in chunk.itertuples(index=False):

        donation_id = row.donation_id
        donor_id = row.donor_id
        donation_date = row.date

        test_date = donation_date + timedelta(days=random.randint(0, 3))

        result = "Negative" if random.random() < 0.95 else "Positive"
        comments = "" if result == "Negative" else "Further screening required"

        lines.append(",".join([
            str(test_id),
            str(donor_id),
            str(donation_id),
            str(random.randint(1, TECHNICIAN_COUNT)),
            random.choice(test_types),
            str(test_date.date()),
            result,
            comments
        ]))

        test_id += 1

    with open(OUTPUT_FILE, "a") as f:
        f.write("\n".join(lines) + "\n")

    print(f"{test_id} tests processed...")

print("Blood tests generated successfully!")