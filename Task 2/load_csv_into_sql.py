import warnings
from sqlalchemy import create_engine, text
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

warnings.filterwarnings('ignore')
##ДРУГИЙ ПУНКТ
engine = create_engine("mysql+pymysql://root@127.0.0.1:3306/data_mysql")

make_details = pd.read_csv('make_details.csv')
locations = pd.read_csv('locations.csv')
#Will drop all NA rows, since the foreign key cannot be created with null values, and the other rows have a null in vehicle type
stolen_vehicles = pd.read_csv('stolen_vehicles.csv')
stolen_vehicles = stolen_vehicles.dropna()
with engine.connect() as conn:
    make_details.to_sql('make_details', conn, index=False, if_exists='replace')
    conn.execute(text("ALTER TABLE make_details ADD PRIMARY KEY (make_id);"))
    locations.to_sql('locations', conn, index=False, if_exists='replace')
    conn.execute(text("ALTER TABLE locations ADD PRIMARY KEY (location_id);"))
    stolen_vehicles.to_sql('stolen_vehicles', conn, index = False, if_exists='replace')
    conn.execute(text("ALTER TABLE stolen_vehicles ADD PRIMARY KEY (vehicle_id), ADD CONSTRAINT fk_loc FOREIGN KEY (location_id) REFERENCES locations(location_id);"))
    conn.execute(text("ALTER TABLE stolen_vehicles MODIFY COLUMN make_id BIGINT;"))
    conn.execute(text("DELETE FROM make_details WHERE make_id IS NULL;"))
    conn.execute(text("ALTER TABLE stolen_vehicles ADD CONSTRAINT fk_make FOREIGN KEY (make_id) REFERENCES make_details(make_id);"))