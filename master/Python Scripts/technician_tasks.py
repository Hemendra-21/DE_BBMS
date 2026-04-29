import pandas as pd
import random

NUM_TECHNICIANS = 10000
NUM_TASKS = 25

data = []

# Weighted tasks (some are more common)
task_ids = list(range(1, NUM_TASKS + 1))
task_weights = [
10,10,8,8,7,7,6,6,9,8,
9,8,7,5,5,6,6,7,5,6,
8,7,5,5,6
]

for tech_id in range(1, NUM_TECHNICIANS + 1):
    num_tasks = random.randint(3, 8)

    assigned_tasks = set(
        random.choices(task_ids, weights=task_weights, k=num_tasks)
    )

    for task_id in assigned_tasks:
        data.append({
            "technician_id": tech_id,
            "task_id": task_id
        })

df = pd.DataFrame(data)

# enforce column order
df = df[["technician_id","task_id"]]

df.to_csv("technician_tasks.csv", index=False)

print("Technician tasks generated successfully!")