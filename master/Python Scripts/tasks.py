import pandas as pd

tasks_list = [
"Blood sample collection",
"Blood typing (ABO/Rh)",
"Crossmatching",
"Infectious disease screening",
"Component separation",
"Plasma extraction",
"Platelet preparation",
"Blood storage monitoring",
"Inventory management",
"Label verification",
"Donor health check",
"Hemoglobin testing",
"Serology testing",
"Equipment sterilization",
"Lab equipment maintenance",
"Quality control testing",
"Cold chain monitoring",
"Emergency blood preparation",
"Sample transport handling",
"Data entry and reporting",
"Compatibility testing",
"Transfusion support",
"Reagent preparation",
"Waste disposal management",
"Lab safety compliance"
]

data = []
for i, task in enumerate(tasks_list, start=1):
    data.append({
        "task_id": i,
        "description": task
    })

df = pd.DataFrame(data)

df.to_csv("tasks.csv", index=False)

print("Tasks generated successfully!")