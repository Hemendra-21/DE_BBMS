import pandas as pd
import random
import os

# ---------------- CONFIG ----------------
TARGET_ROWS = 2_000_000
CHUNK_SIZE = 100_000

BASE_PATH = r"C:\Users\Hemendra Chandaluri\DE_CAPSTONE_PROJECT\master\CSV Files"

DONATIONS_FILE = os.path.join(BASE_PATH, "donations.csv")
OUTPUT_FILE = os.path.join(BASE_PATH, "donor_history.csv")

# ---------------- CLEAN OUTPUT ----------------
if os.path.exists(OUTPUT_FILE):
    os.remove(OUTPUT_FILE)

with open(OUTPUT_FILE, "w") as f:
    f.write("history_id,donor_id,donation_id,reaction,notes\n")

# ---------------- DONOR PROFILE (NEW 🔥) ----------------

donor_reaction_profile = {}

def assign_donor_profile(donor_id):
    # assign once per donor
    if donor_id not in donor_reaction_profile:
        donor_reaction_profile[donor_id] = random.choices(
            ["always_none", "mostly_none", "sensitive"],
            weights=[70, 25, 5]
        )[0]
    return donor_reaction_profile[donor_id]

def get_reaction(donor_id):
    profile = assign_donor_profile(donor_id)

    if profile == "always_none":
        return "none"

    elif profile == "mostly_none":
        return random.choices(
            ["none","mild"],
            weights=[90,10]
        )[0]

    else:  # sensitive
        return random.choices(
            ["none","mild","severe"],
            weights=[70,25,5]
        )[0]

def get_notes(reaction):
    if reaction == "none":
        return ""
    elif reaction == "mild":
        return random.choice([
            "Slight dizziness",
            "Minor fatigue",
            "Lightheadedness observed"
        ])
    else:
        return random.choice([
            "Severe dizziness",
            "Fainting episode",
            "Required medical attention"
        ])

# ---------------- GENERATION ----------------

history_id = 1
rows_written = 0

for chunk in pd.read_csv(DONATIONS_FILE, chunksize=CHUNK_SIZE):

    # 🔥 FIX: remove fixed seed (true randomness)
    chunk = chunk.sample(frac=0.8)

    lines = []

    # 🔥 FAST iteration
    for row in chunk.itertuples(index=False):

        if rows_written >= TARGET_ROWS:
            break

        donor_id = int(row.donor_id)
        donation_id = int(row.donation_id)

        reaction = get_reaction(donor_id)
        notes = get_notes(reaction)

        lines.append(",".join([
            str(history_id),
            str(donor_id),
            str(donation_id),
            reaction,
            notes.replace(",", "")
        ]))

        history_id += 1
        rows_written += 1

    with open(OUTPUT_FILE, "a") as f:
        f.write("\n".join(lines) + "\n")

    print(f"{rows_written} history rows generated...")

    if rows_written >= TARGET_ROWS:
        break

print("Donor history generated successfully!")