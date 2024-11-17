# KNU-Hackathon
## Завдання 1
Загальний вигляд дашборду:

<img width="601" alt="image" src="https://github.com/user-attachments/assets/5a9ad847-d057-49d6-93d5-349fbe560638">

### Пункт 1: 

<img width="198" alt="image" src="https://github.com/user-attachments/assets/eab76364-d140-4aa9-9f4e-425ee70fba74">

Назви продуктів також відображені в легенді. Локації клієнтів відображені на осі У.
### Пункт 2:

<img width="201" alt="image" src="https://github.com/user-attachments/assets/7bc6d56b-2b44-49b3-8ad6-facb41fb4328">

Ми можемо бачити тренд на зниження кількості замовлень у березні та квітн. Однак, потім вони швидко нормалізуються.
### Пункт 3 (Який середній час доставки у днях? Чи має він тенденцію до зміни з часом?):

<img width="195" alt="image" src="https://github.com/user-attachments/assets/f8728018-c836-4be0-b183-372b68018d3d">

Загалом, середній час доставки за весь спостережуваний термін: 5 днів. Ми можемо бачити що терміни доставки спочатку були вищими (приблизно 8 днів). Однак по мірі розвитку компанії час доставки вдалося скоротити терміни та стабілізувати показник на 4 днях.
### Пункт 4 (Чи є різниця в середньому чеку для онлайн продажів та продажів в магазині?):

<img width="372" alt="image" src="https://github.com/user-attachments/assets/591afff6-0d68-423f-939b-e31e6016d498">

Середній чек є більшим для продажів в магазині.
### Пункт 5 (Наведіть топ 3 найбільш прибуткові товари в розрізі кожного місяця):

<img width="191" alt="image" src="https://github.com/user-attachments/assets/a676789f-c6d6-4a92-b832-60e3ddfbb96c">

За допомогою слайсера вгорі користувач сам може обирати який місяць він бажає подивитися в даний момент.
### Пункт 6 (Наведіть країну з найбільшим та найменшим доходом на одного клієнта в розрізі кожного року):

<img width="195" alt="image" src="https://github.com/user-attachments/assets/380a39d3-5a42-4e09-b9aa-2af851e6f340">

Аналогічно з минулим пунктом, користувач може сам обирати рік який його цікавить.
### Пункт 7 (Показати динаміку по найбільш завантаженим магазинам мережі. (Бонусний бал за коректний вибір параметрів)):

<img width="199" alt="image" src="https://github.com/user-attachments/assets/39ebf11a-b185-477d-814b-c51894addbde">

У якості параметру завантаженості магазину була обрана середня кількість замовлень, яку обробляє магазин за місяць. На основі цього був створений ранг, за яким користувач може фільтрувати графік. Локація магазину показана у заголовку, а середня кількість оброблених замовлень за місяць за весь час показана у підзаголовку.

## Завдання 2
## Пункт 1
Схема бази даних має наступний вигляд:

![database_schema](https://github.com/user-attachments/assets/80cdb5d3-2250-44f6-ad94-59fd074416c1)

Назва файлу: database_schema
## Пункт 2
Скріпт виглядає наступним чином:
```python
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
    conn.execute(text("ALTER TABLE stolen_vehicles ADD PRIMARY KEY (vehicle_id), ADD CONSTRAINT fk_loc FOREIGN KEY 
    (location_id) REFERENCES locations(location_id);"))
    conn.execute(text("ALTER TABLE stolen_vehicles MODIFY COLUMN make_id BIGINT;"))
    conn.execute(text("DELETE FROM make_details WHERE make_id IS NULL;"))
    conn.execute(text("ALTER TABLE stolen_vehicles ADD CONSTRAINT fk_make FOREIGN KEY (make_id) REFERENCES     
    make_details(make_id);"))
```
## Пункти 3-5
Для цих пунктів рекомендую одразу дивитися основний файл Second_task(3-5) (коментарі прописані вже там).
## Пункти 6-9
Ці пункти я також рекомендую перевіряти у основному файлі sql_queries (коментарі прописані вже там).
