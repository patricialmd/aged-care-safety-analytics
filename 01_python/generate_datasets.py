import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

number_seniors = 1000 
locations = ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide', 'Canberra'] 
genders = ['Male', 'Female'] 

seniors_data = {
    'senior_id': range(1, number_seniors + 1), 
    'first_name': [f'Senior{i}' for i in range(1, number_seniors + 1)],
    'age': np.random.randint(65, 95, number_seniors), 
    'gender': np.random.choice(genders, number_seniors, p=[0.48, 0.52]), 
    'location': np.random.choice(locations, number_seniors),
    'admission_date': [
        (datetime.now() - timedelta(days=random.randint(30, 1000))).strftime('%Y-%m-%d')
        for _ in range(number_seniors)
    ]
}

seniors_df = pd.DataFrame(seniors_data)

def calculate_risk_category(age):
    if age >= 85:
        return 'High'
    elif age >= 75:
        return 'Medium'
    else:
        return 'Low'

seniors_df['risk_category'] = seniors_df['age'].apply(calculate_risk_category)
seniors_df.to_csv('seniors.csv', index=False)

number_days = 365 
dates = [(datetime.now() - timedelta(days=number_days)) + timedelta(days=d) for d in range(number_days)]
health_data = []
record_id = 1   

for senior_id in range(1, number_seniors + 1):
    age = seniors_df.loc[seniors_df['senior_id'] == senior_id, 'age'].values[0]
    
    for date in dates:
        health_data.append({
            'metric_id': record_id,
            'senior_id': senior_id,
            'date': date.strftime('%Y-%m-%d'),
            'step_count': max(500, min(10000, int((8000 - (age-65)*80) * np.random.uniform(0.7, 1.3)))),
            'heart_rate': max(55, min(110, int(70 + (age-65)*0.3 + np.random.normal(0, 5)))),
            'room_temp': round(22 + np.random.normal(0, 2), 1),
            'smoke_level': np.random.randint(10, 40) if np.random.random() < 0.02 else 0
        })
        record_id += 1

health_metrics_df = pd.DataFrame(health_data)
health_metrics_df.to_csv('health_metrics.csv', index=False)   

number_incidents = int(number_seniors * number_days / 30 * 0.05)  


types, type_p = ['Fall','Fire Alarm','Medical Emergency','Wandering','Medication Error'], [0.36,0.15,0.26,0.15,0.08]
sevs, sev_p = ['Low','Medium','High'], [0.50,0.35,0.15]
fall_hours = [6,7,8,18,19,20,21]

incidents_df = pd.DataFrame([{
    'incident_id': i,
    'senior_id': random.randint(1, number_seniors),
    'incident_date': (datetime.now() - timedelta(days=random.randint(0, number_days-1))).strftime('%Y-%m-%d'),
    'incident_time': f"{(random.choice(fall_hours) if (t := np.random.choice(types,p=type_p))=='Fall' else random.randint(0,23)):02d}:{random.randint(0,59):02d}:00",
    'incident_type': t,
    'severity': (s := np.random.choice(sevs, p=[0.50,0.44,0.06] if t=='Fall' else sev_p)),
    'response_time_minutes': random.randint(*(1,8) if s=='High' else (3,15) if s=='Medium' else (5,30)),
    'resolved': random.choice(['Yes','Yes','Yes','No'])
} for i in range(1, number_incidents + 1)])

incidents_df.to_csv('incidents.csv', index=False)
