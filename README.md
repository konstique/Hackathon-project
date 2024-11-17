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

{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": []
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "code",
      "execution_count": 1,
      "metadata": {
        "id": "5DttOUXDOPfW"
      },
      "outputs": [],
      "source": [
        "import warnings\n",
        "from sqlalchemy import create_engine\n",
        "import pandas as pd\n",
        "import matplotlib.pyplot as plt\n",
        "import seaborn as sns"
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "#Загружаємо необхідні дані, з поправкою на те що, ми прибрали всі ряди з NA значеннями.\n",
        "#Таке рішення було прийняте з поправкуою на те, що NA значень в колонці make_id не повино бути, оскільки це foreign key.\n",
        "#Окрім того, не логічно тримати в датасеті ряди з інформацією по викраденим автомобілям, коли ми навіть не знаємо що це за автомобіль\n",
        "make_details = pd.read_csv('make_details.csv')\n",
        "locations = pd.read_csv('locations.csv')\n",
        "stolen_vehicles = pd.read_csv('stolen_vehicles.csv')\n",
        "stolen_vehicles = stolen_vehicles.dropna()\n",
        "\n"
      ],
      "metadata": {
        "id": "pjQS0r2flNpb"
      },
      "execution_count": 2,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "###ТРЕТІЙ ПУНКТ"
      ],
      "metadata": {
        "id": "xZF62b3o71ch"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "stolen_vehicles['date_stolen'] = pd.to_datetime(stolen_vehicles['date_stolen'])\n",
        "stolen_vehicles['day_stolen'] = stolen_vehicles['date_stolen'].dt.day_name()\n",
        "df = stolen_vehicles.groupby('day_stolen')['vehicle_id'].nunique().sort_values(ascending= False)\n",
        "result = pd.concat([df.head(1), df.tail(1)], axis = 0)\n",
        "result\n",
        "###Як ми можемо бачити, найбільше автомобілів викрадається у понеділок, найменше у суботу"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 233
        },
        "id": "UZsO5l1klh4k",
        "outputId": "c5cbdb91-c70b-41e6-8c7d-e889f13af831"
      },
      "execution_count": 3,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "<ipython-input-3-c98618bfdd95>:1: UserWarning: Could not infer format, so each element will be parsed individually, falling back to `dateutil`. To ensure parsing is consistent and as-expected, please specify a format.\n",
            "  stolen_vehicles['date_stolen'] = pd.to_datetime(stolen_vehicles['date_stolen'])\n"
          ]
        },
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "day_stolen\n",
              "Monday      759\n",
              "Saturday    574\n",
              "Name: vehicle_id, dtype: int64"
            ],
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>vehicle_id</th>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>day_stolen</th>\n",
              "      <th></th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <th>Monday</th>\n",
              "      <td>759</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>Saturday</th>\n",
              "      <td>574</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div><br><label><b>dtype:</b> int64</label>"
            ]
          },
          "metadata": {},
          "execution_count": 3
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "###ЧЕТВЕРТИЙ пункт"
      ],
      "metadata": {
        "id": "1QXl1ikP9A2m"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "!pip install dash"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "BcLFlau_sWGL",
        "outputId": "bc464ca8-386f-4d1c-b713-0d3812328a65"
      },
      "execution_count": 4,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "Collecting dash\n",
            "  Downloading dash-2.18.2-py3-none-any.whl.metadata (10 kB)\n",
            "Requirement already satisfied: Flask<3.1,>=1.0.4 in /usr/local/lib/python3.10/dist-packages (from dash) (3.0.3)\n",
            "Collecting Werkzeug<3.1 (from dash)\n",
            "  Downloading werkzeug-3.0.6-py3-none-any.whl.metadata (3.7 kB)\n",
            "Requirement already satisfied: plotly>=5.0.0 in /usr/local/lib/python3.10/dist-packages (from dash) (5.24.1)\n",
            "Collecting dash-html-components==2.0.0 (from dash)\n",
            "  Downloading dash_html_components-2.0.0-py3-none-any.whl.metadata (3.8 kB)\n",
            "Collecting dash-core-components==2.0.0 (from dash)\n",
            "  Downloading dash_core_components-2.0.0-py3-none-any.whl.metadata (2.9 kB)\n",
            "Collecting dash-table==5.0.0 (from dash)\n",
            "  Downloading dash_table-5.0.0-py3-none-any.whl.metadata (2.4 kB)\n",
            "Requirement already satisfied: importlib-metadata in /usr/local/lib/python3.10/dist-packages (from dash) (8.5.0)\n",
            "Requirement already satisfied: typing-extensions>=4.1.1 in /usr/local/lib/python3.10/dist-packages (from dash) (4.12.2)\n",
            "Requirement already satisfied: requests in /usr/local/lib/python3.10/dist-packages (from dash) (2.32.3)\n",
            "Collecting retrying (from dash)\n",
            "  Downloading retrying-1.3.4-py3-none-any.whl.metadata (6.9 kB)\n",
            "Requirement already satisfied: nest-asyncio in /usr/local/lib/python3.10/dist-packages (from dash) (1.6.0)\n",
            "Requirement already satisfied: setuptools in /usr/local/lib/python3.10/dist-packages (from dash) (75.1.0)\n",
            "Requirement already satisfied: Jinja2>=3.1.2 in /usr/local/lib/python3.10/dist-packages (from Flask<3.1,>=1.0.4->dash) (3.1.4)\n",
            "Requirement already satisfied: itsdangerous>=2.1.2 in /usr/local/lib/python3.10/dist-packages (from Flask<3.1,>=1.0.4->dash) (2.2.0)\n",
            "Requirement already satisfied: click>=8.1.3 in /usr/local/lib/python3.10/dist-packages (from Flask<3.1,>=1.0.4->dash) (8.1.7)\n",
            "Requirement already satisfied: blinker>=1.6.2 in /usr/local/lib/python3.10/dist-packages (from Flask<3.1,>=1.0.4->dash) (1.9.0)\n",
            "Requirement already satisfied: tenacity>=6.2.0 in /usr/local/lib/python3.10/dist-packages (from plotly>=5.0.0->dash) (9.0.0)\n",
            "Requirement already satisfied: packaging in /usr/local/lib/python3.10/dist-packages (from plotly>=5.0.0->dash) (24.2)\n",
            "Requirement already satisfied: MarkupSafe>=2.1.1 in /usr/local/lib/python3.10/dist-packages (from Werkzeug<3.1->dash) (3.0.2)\n",
            "Requirement already satisfied: zipp>=3.20 in /usr/local/lib/python3.10/dist-packages (from importlib-metadata->dash) (3.21.0)\n",
            "Requirement already satisfied: charset-normalizer<4,>=2 in /usr/local/lib/python3.10/dist-packages (from requests->dash) (3.4.0)\n",
            "Requirement already satisfied: idna<4,>=2.5 in /usr/local/lib/python3.10/dist-packages (from requests->dash) (3.10)\n",
            "Requirement already satisfied: urllib3<3,>=1.21.1 in /usr/local/lib/python3.10/dist-packages (from requests->dash) (2.2.3)\n",
            "Requirement already satisfied: certifi>=2017.4.17 in /usr/local/lib/python3.10/dist-packages (from requests->dash) (2024.8.30)\n",
            "Requirement already satisfied: six>=1.7.0 in /usr/local/lib/python3.10/dist-packages (from retrying->dash) (1.16.0)\n",
            "Downloading dash-2.18.2-py3-none-any.whl (7.8 MB)\n",
            "\u001b[2K   \u001b[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\u001b[0m \u001b[32m7.8/7.8 MB\u001b[0m \u001b[31m43.9 MB/s\u001b[0m eta \u001b[36m0:00:00\u001b[0m\n",
            "\u001b[?25hDownloading dash_core_components-2.0.0-py3-none-any.whl (3.8 kB)\n",
            "Downloading dash_html_components-2.0.0-py3-none-any.whl (4.1 kB)\n",
            "Downloading dash_table-5.0.0-py3-none-any.whl (3.9 kB)\n",
            "Downloading werkzeug-3.0.6-py3-none-any.whl (227 kB)\n",
            "\u001b[2K   \u001b[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\u001b[0m \u001b[32m228.0/228.0 kB\u001b[0m \u001b[31m13.6 MB/s\u001b[0m eta \u001b[36m0:00:00\u001b[0m\n",
            "\u001b[?25hDownloading retrying-1.3.4-py3-none-any.whl (11 kB)\n",
            "Installing collected packages: dash-table, dash-html-components, dash-core-components, Werkzeug, retrying, dash\n",
            "  Attempting uninstall: Werkzeug\n",
            "    Found existing installation: Werkzeug 3.1.3\n",
            "    Uninstalling Werkzeug-3.1.3:\n",
            "      Successfully uninstalled Werkzeug-3.1.3\n",
            "Successfully installed Werkzeug-3.0.6 dash-2.18.2 dash-core-components-2.0.0 dash-html-components-2.0.0 dash-table-5.0.0 retrying-1.3.4\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "#Найкращим рішенням, на мою думку, буде надати можливість юзеру самому досліджувати статистику по викраденим типам автомобілів у розрізі регіонів\n",
        "#Тому я створю інтерактивний графік у plotly, щоб динамічно оновлювати дані\n",
        "import plotly.graph_objects as go\n",
        "import dash\n",
        "import dash_core_components as dcc\n",
        "import dash_html_components as html\n",
        "from dash.dependencies import Input, Output\n",
        "df = stolen_vehicles.merge(locations, how= 'right', on = 'location_id')\n",
        "df1 = df.groupby(['vehicle_type', 'region'])['vehicle_id'].nunique().sort_values(ascending=False).reset_index()\n",
        "fig = go.Figure()\n",
        "fig.add_trace(go.Bar(x = df1['vehicle_type'], y = df1['vehicle_id']))\n",
        "fig.update_layout(\n",
        "    title=dict(text = 'Total amount stolen by vehicle type', x = 0.5, xanchor = 'center'),\n",
        "    xaxis_title='Vehicle Types',\n",
        "    yaxis_title='Amount stolen'\n",
        ")\n",
        "app = dash.Dash()\n",
        "app.layout = [dcc.Dropdown(id = 'region-dropdown',\n",
        "                           options = df1['region'].unique(),\n",
        "                           placeholder= 'Select the region',\n",
        "                           value = 'Auckland'),\n",
        "              dcc.Graph(id = 'bar-chart')]\n",
        "\n",
        "@app.callback(\n",
        "    Output('bar-chart', 'figure'),\n",
        "    Input('region-dropdown', 'value')\n",
        ")\n",
        "def update_graph(reg):\n",
        "  filt_df = df1[df1['region'] == reg]\n",
        "\n",
        "  fig = go.Figure()\n",
        "  fig.add_trace(go.Bar(x = filt_df['vehicle_type'], y = filt_df['vehicle_id']))\n",
        "  fig.update_layout(\n",
        "    title=dict(text = 'Total amount stolen by vehicle type', x = 0.5, xanchor = 'center'),\n",
        "    xaxis_title='Vehicle Types',\n",
        "    yaxis_title='Amount stolen'\n",
        "  )\n",
        "  return fig\n",
        "\n",
        "app.run()\n",
        "#Як ми можемо бачити, статистика по найбільш популярним типам автомобілів у розрізі регіонів відрізняється. Однак автомобілі типу Saloon та Stationwagon знаходяться у топі по викраденням у майже всіх регіонах"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 810
        },
        "id": "DMPudXzi8Vke",
        "outputId": "8e9d6065-0986-43e7-d41c-241a25f94300"
      },
      "execution_count": 5,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "<ipython-input-5-f28ee73c4cc6>:5: UserWarning: \n",
            "The dash_core_components package is deprecated. Please replace\n",
            "`import dash_core_components as dcc` with `from dash import dcc`\n",
            "  import dash_core_components as dcc\n",
            "<ipython-input-5-f28ee73c4cc6>:6: UserWarning: \n",
            "The dash_html_components package is deprecated. Please replace\n",
            "`import dash_html_components as html` with `from dash import html`\n",
            "  import dash_html_components as html\n"
          ]
        },
        {
          "output_type": "display_data",
          "data": {
            "text/plain": [
              "<IPython.core.display.Javascript object>"
            ],
            "application/javascript": [
              "(async (port, path, width, height, cache, element) => {\n",
              "    if (!google.colab.kernel.accessAllowed && !cache) {\n",
              "      return;\n",
              "    }\n",
              "    element.appendChild(document.createTextNode(''));\n",
              "    const url = await google.colab.kernel.proxyPort(port, {cache});\n",
              "    const iframe = document.createElement('iframe');\n",
              "    iframe.src = new URL(path, url).toString();\n",
              "    iframe.height = height;\n",
              "    iframe.width = width;\n",
              "    iframe.style.border = 0;\n",
              "    iframe.allow = [\n",
              "        'accelerometer',\n",
              "        'autoplay',\n",
              "        'camera',\n",
              "        'clipboard-read',\n",
              "        'clipboard-write',\n",
              "        'gyroscope',\n",
              "        'magnetometer',\n",
              "        'microphone',\n",
              "        'serial',\n",
              "        'usb',\n",
              "        'xr-spatial-tracking',\n",
              "    ].join('; ');\n",
              "    element.appendChild(iframe);\n",
              "  })(8050, \"/\", \"100%\", 650, false, window.element)"
            ]
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "###П'ятий пункт"
      ],
      "metadata": {
        "id": "FSiFtfD4FcOi"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "#Ми можемо використати показник R^2 для визначення зв'язку.\n",
        "#Plotly дає нам змогу побудувати діаграму розсіювання, що дасть візуальне представлення зв'язку, та побудувати лінійну регресію за допомогою методу OLS, що дасть числове представлення сили зв'язку"
      ],
      "metadata": {
        "id": "uBYzrIDEFhfn"
      },
      "execution_count": 54,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "#Спочатку варто дослідити дані, які в нас є\n",
        "df = stolen_vehicles.merge(locations, how = 'right', on = 'location_id')\n",
        "df1 = df.groupby('population')['vehicle_id'].count().sort_values(ascending = False).reset_index()\n",
        "df1['population'] = df1['population'].apply(lambda x: x.replace(',','')).astype(int)\n",
        "df1['population'] = df1['population']/1000\n",
        "sns.scatterplot(data = df1, x = 'population', y = 'vehicle_id')\n",
        "plt.show()\n"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 449
        },
        "id": "e-4EmTMbHhH0",
        "outputId": "a9824d52-58aa-41cd-fc34-2a10795087ad"
      },
      "execution_count": 71,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/plain": [
              "<Figure size 640x480 with 1 Axes>"
            ],
            "image/png": "iVBORw0KGgoAAAANSUhEUgAAAk4AAAGwCAYAAABfKeoBAAAAOXRFWHRTb2Z0d2FyZQBNYXRwbG90bGliIHZlcnNpb24zLjguMCwgaHR0cHM6Ly9tYXRwbG90bGliLm9yZy81sbWrAAAACXBIWXMAAA9hAAAPYQGoP6dpAABAiElEQVR4nO3deXxU5d3///eE7ISZEGISoglFTYEoIGWJcYmouQmIW6ULmAoohbs2URHlC9y34FpB7O2CVSmtCq27t0KFujSyGMUYIBKRLUaKBoUkYsgMEclCrt8f/nJuxgQ4hiQzk7yej8c8ZK7rmpnPOY8D8/aca67jMMYYAQAA4ISCfF0AAABAoCA4AQAA2ERwAgAAsIngBAAAYBPBCQAAwCaCEwAAgE0EJwAAAJuCfV1AoGhsbNTevXvVo0cPORwOX5cDAABsMMbo4MGDSkxMVFDQyZ8vIjjZtHfvXiUlJfm6DAAA0Ap79uzRaaeddtLvQ3CyqUePHpK+3/FOp9PH1QAAADs8Ho+SkpKs7/GTRXCyqenynNPpJDgBABBg2mqaDZPDAQAAbCI4AQAA2ERwAgAAsIngBAAAYBPBCQAAwCaCEwAAgE0EJwAAAJsITgAAADYRnAAAAGwiOAEAANjELVcAAIDPuA/VaX9NnTyH6+WMCFFs91C5IkN9XdYxEZwAAIBP7K3+TrNe3aL3SvdbbRkpsVowbpASoyN8WNmxcakOAAB0OPehumahSZLyS/dr9qtb5D5U56PKjo/gBAAAOtz+mrpmoalJful+7a8hODWTn5+vK664QomJiXI4HFqxYkWzMTt27NCVV14pl8ul7t27a/jw4SorK7P6Dx8+rJycHPXq1UtRUVEaN26cKioqvN6jrKxMY8eOVWRkpOLi4jRz5kw1NDS09+YBAIBj8ByuP27/wRP0+4pPg9O3336rwYMH6/HHH2+xf9euXbrgggvUv39/rVu3Tlu2bNHcuXMVHh5ujbn11lu1cuVKvfLKK3r33Xe1d+9eXXPNNVb/kSNHNHbsWNXV1emDDz7QsmXLtHTpUs2bN6/dtw8AALTMGR5y3P4eJ+j3FYcxxvi6CElyOBxavny5rr76aqtt/PjxCgkJ0d///vcWX+N2u3XKKafo+eef1y9+8QtJ0s6dOzVgwAAVFBTo3HPP1ZtvvqnLL79ce/fuVXx8vCRp8eLFmjVrlr7++muFhtqbue/xeORyueR2u+V0Ok9uYwEA6OLch+p00wubld/C5bqMlFg9NmFIm/y6rq2/v/12jlNjY6P++c9/6qc//amysrIUFxentLQ0r8t5RUVFqq+vV2ZmptXWv39/JScnq6CgQJJUUFCggQMHWqFJkrKysuTxeLRt27Zjfn5tba08Ho/XAwAAtA1XZKgWjBukjJRYr/aMlFg9MG6Q3y5J4LfLEVRWVqqmpkYLFizQfffdpwceeEBvvfWWrrnmGq1du1YXXXSRysvLFRoaqujoaK/XxsfHq7y8XJJUXl7uFZqa+pv6jmX+/Pm6++6723ajAACAJTE6Qo9NGKL9NXU6eLhePcJDFBvFOk6t0tjYKEm66qqrdOutt0qSzjnnHH3wwQdavHixLrroonb9/Dlz5mjGjBnWc4/Ho6SkpHb9TAAAuhpXpH8HpR/y20t1sbGxCg4OVmpqqlf7gAEDrF/VJSQkqK6uTtXV1V5jKioqlJCQYI354a/smp43jWlJWFiYnE6n1wMAAHRtfhucQkNDNXz4cJWUlHi1f/rpp+rTp48kaejQoQoJCdHq1aut/pKSEpWVlSk9PV2SlJ6erk8++USVlZXWmLy8PDmdzmahDAAA4Hh8eqmupqZGn332mfV89+7dKi4uVkxMjJKTkzVz5kz9+te/VkZGhi6++GK99dZbWrlypdatWydJcrlcmjJlimbMmKGYmBg5nU7ddNNNSk9P17nnnitJGjVqlFJTU3Xddddp4cKFKi8v1x133KGcnByFhYX5YrMBAECgMj60du1aI6nZY9KkSdaYp556ypx55pkmPDzcDB482KxYscLrPb777jvz+9//3vTs2dNERkaan//852bfvn1eYz7//HMzZswYExERYWJjY81tt91m6uvrf1StbrfbSDJut7vV2wsAADpWW39/+806Tv6OdZwAAAg8XWYdJwAAAH9DcAIAALCJ4AQAAGATwQkAAMAmghMAAIBNBCcAAACbCE4AAAA2EZwAAABsIjgBAADYRHACAACwieAEAABgE8EJAADAJoITAACATQQnAAAAmwhOAAAANhGcAAAAbCI4AQAA2ERwAgAAsIngBAAAYBPBCQAAwCaCEwAAgE0EJwAAAJsITgAAADYRnAAAAGwiOAEAANhEcAIAALCJ4AQAAGATwQkAAMAmghMAAIBNBCcAAACbCE4AAAA2+TQ45efn64orrlBiYqIcDodWrFhxzLG/+93v5HA49Mgjj3i1V1VVKTs7W06nU9HR0ZoyZYpqamq8xmzZskUXXnihwsPDlZSUpIULF7bD1gAAgM7Op8Hp22+/1eDBg/X4448fd9zy5cv14YcfKjExsVlfdna2tm3bpry8PK1atUr5+fmaNm2a1e/xeDRq1Cj16dNHRUVFevDBB3XXXXdpyZIlbb49AACgcwv25YePGTNGY8aMOe6Yr776SjfddJPefvttjR071qtvx44deuutt7Rx40YNGzZMkvTYY4/psssu0x//+EclJibqueeeU11dnZ5++mmFhobqrLPOUnFxsR566CGvgAUAAHAifj3HqbGxUdddd51mzpyps846q1l/QUGBoqOjrdAkSZmZmQoKClJhYaE1JiMjQ6GhodaYrKwslZSU6MCBA8f87NraWnk8Hq8HAADo2vw6OD3wwAMKDg7WzTff3GJ/eXm54uLivNqCg4MVExOj8vJya0x8fLzXmKbnTWNaMn/+fLlcLuuRlJR0MpsCAAA6Ab8NTkVFRXr00Ue1dOlSORyODv/8OXPmyO12W489e/Z0eA0AAMC/+G1weu+991RZWank5GQFBwcrODhYX3zxhW677Tb95Cc/kSQlJCSosrLS63UNDQ2qqqpSQkKCNaaiosJrTNPzpjEtCQsLk9Pp9HoAAICuzW+D03XXXactW7aouLjYeiQmJmrmzJl6++23JUnp6emqrq5WUVGR9bo1a9aosbFRaWlp1pj8/HzV19dbY/Ly8tSvXz/17NmzYzcKAAAENJ/+qq6mpkafffaZ9Xz37t0qLi5WTEyMkpOT1atXL6/xISEhSkhIUL9+/SRJAwYM0OjRozV16lQtXrxY9fX1ys3N1fjx462lC6699lrdfffdmjJlimbNmqWtW7fq0Ucf1cMPP9xxGwoAADoFnwanTZs26eKLL7aez5gxQ5I0adIkLV261NZ7PPfcc8rNzdWll16qoKAgjRs3TosWLbL6XS6X/vWvfyknJ0dDhw5VbGys5s2bx1IEAADgR3MYY4yviwgEHo9HLpdLbreb+U4AAASItv7+9ts5TgAAAP6G4AQAAGATwQkAAMAmghMAAIBNBCcAAACbCE4AAAA2EZwAAABsIjgBAADYRHACAACwieAEAABgE8EJAADAJoITAACATQQn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ODk5WcnJySddBAAAQCCwHZxmzJhh+00feuihVhUDAADgz2zPcdq8ebOtR3FxcZsWeOTIEc2dO1d9+/ZVRESEzjjjDN177706+gqjMUbz5s1T7969FRERoczMTJWWlnq9T1VVlbKzs+V0OhUdHa0pU6ZYC3cCAADYYfuM09q1a9uzjmN64IEH9OSTT2rZsmU666yztGnTJl1//fVyuVy6+eabJUkLFy7UokWLtGzZMvXt21dz585VVlaWtm/frvDwcElSdna29u3bp7y8PNXX1+v666/XtGnT9Pzzz/tkuwAAQOBp1eRwt9utI0eOKCYmxqu9qqpKwcHBbTp5+vLLL1d8fLyeeuopq23cuHGKiIjQs88+K2OMEhMTddttt+n222+36ouPj9fSpUs1fvx47dixQ6mpqdq4caOGDRsmSXrrrbd02WWX6csvv1RiYuIJ62ByOAAAgaetv79bvY7Tiy++2Kz95Zdf1vjx40+6qKOdd955Wr16tT799FNJ398P7/3339eYMWMkSbt371Z5ebkyMzOt17hcLqWlpamgoECSVFBQoOjoaCs0SVJmZqaCgoJUWFjY4ufW1tbK4/F4PQAAQNfWquBUWFioiy++uFn7yJEjjxlEWmv27NkaP368+vfvr5CQEA0ZMkTTp09Xdna2JKm8vFySFB8f7/W6+Ph4q6+8vFxxcXFe/cHBwYqJibHG/ND8+fPlcrmsR1JSUptuFwAACDytCk61tbVqaGho1l5fX6/vvvvupIs62ssvv6znnntOzz//vD766CMtW7ZMf/zjH7Vs2bI2/ZwfmjNnjtxut/XYs2dPu34eAADwf60KTiNGjNCSJUuatS9evFhDhw496aKONnPmTOus08CBA3Xdddfp1ltv1fz58yVJCQkJkqSKigqv11VUVFh9CQkJqqys9OpvaGhQVVWVNeaHwsLC5HQ6vR4AAKBra9UCmPfdd58yMzP18ccf69JLL5UkrV69Whs3btS//vWvNi3w0KFDCgryznfdunVTY2OjJKlv375KSEjQ6tWrdc4550j6fiJYYWGhbrzxRklSenq6qqurVVRUZAW7NWvWqLGxUWlpaW1aLwAA6LxaFZzOP/98FRQU6MEHH9TLL7+siIgIDRo0SE899VSb33bliiuu0B/+8AclJyfrrLPO0ubNm/XQQw/phhtukCQ5HA5Nnz5d9913n1JSUqzlCBITE3X11VdLkgYMGKDRo0dr6tSpWrx4serr65Wbm6vx48fb+kUdAACAdJL3qusIBw8e1Ny5c7V8+XJVVlYqMTFREyZM0Lx58xQaGirp+wUw77zzTi1ZskTV1dW64IIL9MQTT+inP/2p9T5VVVXKzc3VypUrFRQUpHHjxmnRokWKioqyVQfLEQAAEHja+vvbdnDyeDzWB57op/mdMVgQnAAACDw+u8lvz549tW/fPsXFxSk6OloOh6PZGGOMHA6Hjhw5ctKFAQAA+BvbwWnNmjXWSuG+uv0KAACAL/n9HCd/waU6AAACj88u1f1QdXW1NmzYoMrKSmtpgCYTJ0486cIAAAD8TauC08qVK5Wdna2amho5nU6v+U4Oh4PgBAAAOqVWrRx+22236YYbblBNTY2qq6t14MAB61FVVdXWNQIAAPiFVgWnr776SjfffLMiIyPbuh4AAAC/1arglJWVpU2bNrV1LQAAAH7N9hyn119/3frz2LFjNXPmTG3fvl0DBw5USEiI19grr7yy7SoEAADwE7aXI/jhjXaP+YaddAFMliMAACDw+Gw5gh8uOQAAANDVtGqO09EOHz7cFnUAAAD4vVYFpyNHjujee+/VqaeeqqioKP373/+WJM2dO1dPPfVUmxYIAADgL1oVnP7whz9o6dKlWrhwoUJDQ632s88+W3/961/brDgAAAB/0qrg9Le//U1LlixRdna2unXrZrUPHjxYO3fubLPiAAAA/EmrF8A888wzm7U3Njaqvr7+pIsCAADwR60KTqmpqXrvvfeatf/v//6vhgwZctJFAQAA+KNW3eR33rx5mjRpkr766is1NjbqtddeU0lJif72t79p1apVbV0jAACAX2jVGaerrrpKK1eu1DvvvKPu3btr3rx52rFjh1auXKn/+I//aOsaAQAA/EKrzjj99re/1W9+8xvl5eW1dT0A/Ij7UJ3219TJc7hezogQxXYPlSsy9MQvBIBOqlXB6euvv9bo0aN1yimnaMKECcrOztbgwYPbujYAPrS3+jvNenWL3ivdb7VlpMRqwbhBSoyO8GFlAOA7rbpU949//EP79u3T3LlztWHDBv3sZz/TWWedpfvvv1+ff/55G5cIoKO5D9U1C02SlF+6X7Nf3SL3oTofVQYAvtXqW6707NlT06ZN07p16/TFF19o8uTJ+vvf/97i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8+apd+/eioiIUGZmpkpLS73GVFVVKTs7W06nU9HR0ZoyZYpqamq8xmzZskUXXnihwsPDlZSUpIULF7b3pv1ox9sX9fX1mjVrlgYOHKju3bsrMTFREydO1N69e73eo6XjacGCBV5jAmFfSCc+NiZPntxsW0ePHu01prMcG9KJ90dL/444HA49+OCD1pgOOz4M2sWLL75oQkNDzdNPP222bdtmpk6daqKjo01FRYWvS2tTWVlZ5plnnjFbt241xcXF5rLLLjPJycmmpqbGGnPRRReZqVOnmn379lkPt9tt9Tc0NJizzz7bZGZmms2bN5s33njDxMbGmjlz5vhik07KnXfeac466yyvbf3666+t/t/97ncmKSnJrF692mzatMmce+655rzzzrP6O9O+MMaYyspKr32Rl5dnJJm1a9caYzr/sfHGG2+Y//7v/zavvfaakWSWL1/u1b9gwQLjcrnMihUrzMcff2yuvPJK07dvX/Pdd99ZY0aPHm0GDx5sPvzwQ/Pee++ZM88800yYMMHqd7vdJj4+3mRnZ5utW7eaF154wURERJg///nPHbWZthxvX1RXV5vMzEzz0ksvmZ07d5qCggIzYsQIM3ToUK/36NOnj7nnnnu8jpej/60JlH1hzImPjUmTJpnRo0d7bWtVVZXXmM5ybBhz4v1x9H7Yt2+fefrpp43D4TC7du2yxnTU8UFwaicjRowwOTk51vMjR46YxMREM3/+fB9W1f4qKyuNJPPuu+9abRdddJG55ZZbjvmaN954wwQFBZny8nKr7cknnzROp9PU1ta2Z7lt7s477zSDBw9usa+6utqEhISYV155xWrbsWOHkWQKCgqMMZ1rX7TklltuMWeccYZpbGw0xnStY+OHXwaNjY0mISHBPPjgg1ZbdXW1CQsLMy+88IIxxpjt27cbSWbjxo3WmDfffNM4HA7z1VdfGWOMeeKJJ0zPnj299sesWbNMv3792nmLWq+lL8Yf2rBhg5FkvvjiC6utT58+5uGHHz7mawJxXxjT8v6YNGmSueqqq475ms56bBhj7/i46qqrzCWXXOLV1lHHB5fq2kFdXZ2KioqUmZlptQUFBSkzM1MFBQU+rKz9ud1uSVJMTIxX+3PPPafY2FidffbZmjNnjg4dOmT1FRQUaODAgYqPj7fasrKy5PF4tG3bto4pvA2VlpYqMTFRp59+urKzs1VWViZJKioqUn19vddx0b9/fyUnJ1vHRWfbF0erq6vTs88+qxtuuMHrRtld6dg42u7du1VeXu51PLhcLqWlpXkdD9HR0Ro2bJg1JjMzU0FBQSosLLTGZGRkKDQ01BqTlZWlkpISHThwoIO2pu253W45HA5FR0d7tS9YsEC9evXSkCFD9OCDD3pdtu1s+2LdunWKi4tTv379dOONN+qbb76x+rrysVFRUaF//vOfmjJlSrO+jjg+uMlvO9i/f7+OHDni9Y+9JMXHx2vnzp0+qqr9NTY2avr06Tr//PN19tlnW+3XXnut+vTpo8TERG3ZskWzZs1SSUmJXnvtNUlSeXl5i/uqqS+QpKWlaenSperXr5/27dunu+++WxdeeKG2bt2q8vJyhYaGNvsiiI+Pt7azM+2LH1qxYoWqq6s1efJkq60rHRs/1FR/S9t39PEQFxfn1R8cHKyYmBivMX379m32Hk19PXv2bJf629Phw4c1a9YsTZgwweumrTfffLN+9rOfKSYmRh988IHmzJmjffv26aGHHpLUufbF6NGjdc0116hv377atWuX/uu//ktjxoxRQUGBunXr1mWPDUlatmyZevTooWuuucarvaOOD4IT2kxOTo62bt2q999/36t92rRp1p8HDhyo3r1769JLL9WuXbt0xhlndHSZ7WrMmDHWnwcNGqS0tDT16dNHL7/8siIiInxYme899dRTGjNmjBITE622rnRswJ76+nr96le/kjFGTz75pFffjBkzrD8PGjRIoaGh+s///E/Nnz+/091+ZPz48dafBw4cqEGDBumMM87QunXrdOmll/qwMt97+umnlZ2drfDwcK/2jjo+uFTXDmJjY9WtW7dmv5aqqKhQQkKCj6pqX7m5uVq1apXWrl2r00477bhj09LSJEmfffaZJCkhIaHFfdXUF8iio6P105/+VJ999pkSEhJUV1en6upqrzFHHxeddV988cUXeuedd/Tb3/72uOO60rHRVP/x/p1ISEhQZWWlV39DQ4Oqqqo65THTFJq++OIL5eXleZ1taklaWpoaGhr0+eefS+pc++KHTj/9dMXGxnr93ehKx0aT9957TyUlJSf8t0Rqv+OD4NQOQkNDNXToUK1evdpqa2xs1OrVq5Wenu7DytqeMUa5ublavny51qxZ0+w0aEuKi4slSb1795Ykpaen65NP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gEJDQyVJR44cOeb7DBgwwFb9AAIPwQmAz5SVlWnGjBkqKSnRCy+8oMcee0y33HKLUlJSdNVVV2nq1Kl6//339fHHH+s3v/mNTj31VF111VXW60NCQnTTTTepsLBQRUVFmjx5ss4991xrftMll1yiTZs26W9/+5tKS0t15513auvWrcesJzk5WaGhoXrsscf073//W6+//rruvfderzF9+vSRw+HQqlWr9PXXX6umpqbZ+9itH0DgITgB8JmJEyfqu+++04gRI5STk6NbbrlF06ZNkyQ988wzGjp0qC6//HKlp6fLGKM33njD6/JWZGSkZs2apWuvvVbnn3++oqKi9NJLL1n9WVlZmjt3rv7f//t/Gj58uA4ePKiJEyces55TTjlFS5cu1SuvvKLU1FQtWLBAf/zjH73GnHrqqbr77rs1e/ZsxcfHKzc3t8X3slM/gMDjMFxQB+ADI0eO1DnnnKNHHnmkVa9funSppk+frurq6jatCwCOhzNOAAAANhGcAAAAbOJSHQAAgE2ccQIAALCJ4AQAAGATwQkAAMAmghMAAIBNBCcAAACbCE4AAAA2EZwAAABsIjgBAADY9P8BHS21T36ULsAAAAAASUVORK5CYII=\n"
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "##Бачимо очевидний викид, спробуємо його прибрати\n",
        "import plotly.express as px\n",
        "df1 = df1[df1['population'] != df1['population'].max()]\n",
        "#Далі будуємо основний графік (для того щоб подивитися значення R^2 треба навести курсор на лінію)\n",
        "fig = px.scatter(df1, x='population', y='vehicle_id', trendline=\"ols\")\n",
        "fig.update_xaxes(title = dict(text = 'Population in thousands'))\n",
        "fig.show()\n",
        "#Отримали високе значення R^2: 0,84, це підштовхує на думку що між популяцією та кількістю крадіжок є сильний зв'язок, однак варто зважати на те, що даних доволі мало"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 542
        },
        "id": "NqOW5KTyK2n4",
        "outputId": "e3d0923e-17cd-4208-cd1a-b9efe7fcadef"
      },
      "execution_count": 70,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/html": [
              "<html>\n",
              "<head><meta charset=\"utf-8\" /></head>\n",
              "<body>\n",
              "    <div>            <script src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG\"></script><script type=\"text/javascript\">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: \"STIX-Web\"}});}</script>                <script type=\"text/javascript\">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>\n",
              "        <script charset=\"utf-8\" src=\"https://cdn.plot.ly/plotly-2.35.2.min.js\"></script>                <div id=\"68dd100f-1a48-4147-8c58-c77e96a50552\" class=\"plotly-graph-div\" style=\"height:525px; width:100%;\"></div>            <script type=\"text/javascript\">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById(\"68dd100f-1a48-4147-8c58-c77e96a50552\")) {                    Plotly.newPlot(                        \"68dd100f-1a48-4147-8c58-c77e96a50552\",                        [{\"hovertemplate\":\"population=%{x}\\u003cbr\\u003evehicle_id=%{y}\\u003cextra\\u003e\\u003c\\u002fextra\\u003e\",\"legendgroup\":\"\",\"marker\":{\"color\":\"#636efa\",\"symbol\":\"circle\"},\"mode\":\"markers\",\"name\":\"\",\"orientation\":\"v\",\"showlegend\":false,\"x\":[655.0,347.7,543.5,513.8,201.5,52.1,258.2,246.0,127.3,182.7,54.5,102.4,32.7,51.9,58.7],\"xaxis\":\"x\",\"y\":[657,442,417,365,233,173,138,135,112,100,91,26,0,0,0],\"yaxis\":\"y\",\"type\":\"scatter\"},{\"hovertemplate\":\"\\u003cb\\u003eOLS trendline\\u003c\\u002fb\\u003e\\u003cbr\\u003evehicle_id = 0.887541 * population + -10.2327\\u003cbr\\u003eR\\u003csup\\u003e2\\u003c\\u002fsup\\u003e=0.841085\\u003cbr\\u003e\\u003cbr\\u003epopulation=%{x}\\u003cbr\\u003evehicle_id=%{y} \\u003cb\\u003e(trend)\\u003c\\u002fb\\u003e\\u003cextra\\u003e\\u003c\\u002fextra\\u003e\",\"legendgroup\":\"\",\"marker\":{\"color\":\"#636efa\",\"symbol\":\"circle\"},\"mode\":\"lines\",\"name\":\"\",\"showlegend\":false,\"x\":[32.7,51.9,52.1,54.5,58.7,102.4,127.3,182.7,201.5,246.0,258.2,347.7,513.8,543.5,655.0],\"xaxis\":\"x\",\"y\":[18.789904370641406,35.83068991660064,36.00819809937106,38.13829629261596,41.86596813079455,80.65150606612887,102.75127482104476,151.92104144844797,168.6068106288664,208.10238129528238,218.93038044427732,298.3652922340352,445.7858380248597,472.14580316626547,571.1066150607683],\"yaxis\":\"y\",\"type\":\"scatter\"}],                        {\"template\":{\"data\":{\"histogram2dcontour\":[{\"type\":\"histogram2dcontour\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"choropleth\":[{\"type\":\"choropleth\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"histogram2d\":[{\"type\":\"histogram2d\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"heatmap\":[{\"type\":\"heatmap\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"heatmapgl\":[{\"type\":\"heatmapgl\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"contourcarpet\":[{\"type\":\"contourcarpet\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"contour\":[{\"type\":\"contour\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"surface\":[{\"type\":\"surface\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"mesh3d\":[{\"type\":\"mesh3d\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"scatter\":[{\"fillpattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2},\"type\":\"scatter\"}],\"parcoords\":[{\"type\":\"parcoords\",\"line\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterpolargl\":[{\"type\":\"scatterpolargl\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"bar\":[{\"error_x\":{\"color\":\"#2a3f5f\"},\"error_y\":{\"color\":\"#2a3f5f\"},\"marker\":{\"line\":{\"color\":\"#E5ECF6\",\"width\":0.5},\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"bar\"}],\"scattergeo\":[{\"type\":\"scattergeo\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterpolar\":[{\"type\":\"scatterpolar\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"histogram\":[{\"marker\":{\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"histogram\"}],\"scattergl\":[{\"type\":\"scattergl\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatter3d\":[{\"type\":\"scatter3d\",\"line\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}},\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scattermapbox\":[{\"type\":\"scattermapbox\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterternary\":[{\"type\":\"scatterternary\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scattercarpet\":[{\"type\":\"scattercarpet\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"carpet\":[{\"aaxis\":{\"endlinecolor\":\"#2a3f5f\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"minorgridcolor\":\"white\",\"startlinecolor\":\"#2a3f5f\"},\"baxis\":{\"endlinecolor\":\"#2a3f5f\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"minorgridcolor\":\"white\",\"startlinecolor\":\"#2a3f5f\"},\"type\":\"carpet\"}],\"table\":[{\"cells\":{\"fill\":{\"color\":\"#EBF0F8\"},\"line\":{\"color\":\"white\"}},\"header\":{\"fill\":{\"color\":\"#C8D4E3\"},\"line\":{\"color\":\"white\"}},\"type\":\"table\"}],\"barpolar\":[{\"marker\":{\"line\":{\"color\":\"#E5ECF6\",\"width\":0.5},\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"barpolar\"}],\"pie\":[{\"automargin\":true,\"type\":\"pie\"}]},\"layout\":{\"autotypenumbers\":\"strict\",\"colorway\":[\"#636efa\",\"#EF553B\",\"#00cc96\",\"#ab63fa\",\"#FFA15A\",\"#19d3f3\",\"#FF6692\",\"#B6E880\",\"#FF97FF\",\"#FECB52\"],\"font\":{\"color\":\"#2a3f5f\"},\"hovermode\":\"closest\",\"hoverlabel\":{\"align\":\"left\"},\"paper_bgcolor\":\"white\",\"plot_bgcolor\":\"#E5ECF6\",\"polar\":{\"bgcolor\":\"#E5ECF6\",\"angularaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"radialaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"}},\"ternary\":{\"bgcolor\":\"#E5ECF6\",\"aaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"baxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"caxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"}},\"coloraxis\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}},\"colorscale\":{\"sequential\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]],\"sequentialminus\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]],\"diverging\":[[0,\"#8e0152\"],[0.1,\"#c51b7d\"],[0.2,\"#de77ae\"],[0.3,\"#f1b6da\"],[0.4,\"#fde0ef\"],[0.5,\"#f7f7f7\"],[0.6,\"#e6f5d0\"],[0.7,\"#b8e186\"],[0.8,\"#7fbc41\"],[0.9,\"#4d9221\"],[1,\"#276419\"]]},\"xaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\",\"title\":{\"standoff\":15},\"zerolinecolor\":\"white\",\"automargin\":true,\"zerolinewidth\":2},\"yaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\",\"title\":{\"standoff\":15},\"zerolinecolor\":\"white\",\"automargin\":true,\"zerolinewidth\":2},\"scene\":{\"xaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2},\"yaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2},\"zaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2}},\"shapedefaults\":{\"line\":{\"color\":\"#2a3f5f\"}},\"annotationdefaults\":{\"arrowcolor\":\"#2a3f5f\",\"arrowhead\":0,\"arrowwidth\":1},\"geo\":{\"bgcolor\":\"white\",\"landcolor\":\"#E5ECF6\",\"subunitcolor\":\"white\",\"showland\":true,\"showlakes\":true,\"lakecolor\":\"white\"},\"title\":{\"x\":0.05},\"mapbox\":{\"style\":\"light\"}}},\"xaxis\":{\"anchor\":\"y\",\"domain\":[0.0,1.0],\"title\":{\"text\":\"Population in thousands\"}},\"yaxis\":{\"anchor\":\"x\",\"domain\":[0.0,1.0],\"title\":{\"text\":\"vehicle_id\"}},\"legend\":{\"tracegroupgap\":0},\"margin\":{\"t\":60}},                        {\"responsive\": true}                    ).then(function(){\n",
              "                            \n",
              "var gd = document.getElementById('68dd100f-1a48-4147-8c58-c77e96a50552');\n",
              "var x = new MutationObserver(function (mutations, observer) {{\n",
              "        var display = window.getComputedStyle(gd).display;\n",
              "        if (!display || display === 'none') {{\n",
              "            console.log([gd, 'removed!']);\n",
              "            Plotly.purge(gd);\n",
              "            observer.disconnect();\n",
              "        }}\n",
              "}});\n",
              "\n",
              "// Listen for the removal of the full notebook cells\n",
              "var notebookContainer = gd.closest('#notebook-container');\n",
              "if (notebookContainer) {{\n",
              "    x.observe(notebookContainer, {childList: true});\n",
              "}}\n",
              "\n",
              "// Listen for the clearing of the current output cell\n",
              "var outputEl = gd.closest('.output');\n",
              "if (outputEl) {{\n",
              "    x.observe(outputEl, {childList: true});\n",
              "}}\n",
              "\n",
              "                        })                };                            </script>        </div>\n",
              "</body>\n",
              "</html>"
            ]
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "#Повторимо ті самі операції з щільністю населення\n",
        "df2 = stolen_vehicles.merge(locations, how = 'right', on = 'location_id')\n",
        "df3 = df.groupby('density')['vehicle_id'].count().sort_values(ascending = False).reset_index()\n",
        "sns.scatterplot(data = df1, x = 'density', y = 'vehicle_id')\n",
        "plt.show()"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 449
        },
        "id": "Tq6D1Sz4NIQY",
        "outputId": "1c598b0f-7d7e-4f63-9515-657bc0179adb"
      },
      "execution_count": 73,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/plain": [
              "<Figure size 640x480 with 1 Axes>"
            ],
            "image/png": "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7bffruDgYE2cOFF79+7Va6+9pmeeeUZTp0710VEDAAC/46VVb43auHGjIanBNn78eMMwTi69nzNnjhEbG2uEhIQYQ4cONQoLCz328d133xljx441IiIiDLvdbtx5553GsWPHPNr85z//Ma666iojJCTEOPfcc40FCxb87L6y7B4AgLanqb/fNsMwDB/msTbD7XbL4XDI5XIxnwgAgDaiqb/ffjuHCAAAwFsCm9pw4MCBstlsTWq7Y8eOZncIAADA25ociOonMktSRUWFnnvuOSUmJporvj755BPt3btXv/vd71q8kwAAAK2pyYHooYceMv9999136/7779ejjz7aoA03MAQAAG1NsyZVOxwObd++Xb169fIo379/vwYPHiyXy9ViHfQXTKoGAKDtadVJ1WFhYdqyZUuD8i1btig0NLQ5uwQAAPCZJl8y+7EpU6bo3nvv1Y4dOzRkyBBJUl5enl588UXNmTOnRTsIAADQ2poViGbNmqXzzz9fzzzzjF566SVJJ+8avXz5ct16660t2kEAAIDWxo0Zm4g5RAAAtD3cmBEAAKCJmnzJLCoqSp9//rmio6PVuXPn096ksbS0tEU6BwAA4A1NDkRPPfWUOnXqJEl6+umnW6s/AAAAXteqc4gWLFige+65R5GRka31EV7DHCIAANoev5hD9Pjjj3P5DAAA+L1WDUQsYAMAAG0Bq8wAAIDlEYgAAIDlEYgAAIDlEYgAAIDltWoguvrqqxUWFtaaHwEAAHDWmh2IDhw4oAcffFBjx45VSUmJJOm9997T3r17zTb/+te/1LVr17PvJQAAQCtqViDavHmz+vXrp7y8PL311lsqLy+XJP3nP//RQw891KIdBAAAaG3NCkSzZs3SY489puzsbAUHB5vl119/vT755JMW6xwAAIA3NCsQ7d69WzfffHOD8piYGB09evSsOwUAAOBNzQpEkZGROnLkSIPynTt36txzzz3rTgEAAHhTswLRmDFjNHPmTDmdTtlsNtXV1WnLli2aPn26xo0b19J9BAAAaFXNCkSPP/64+vTpo4SEBJWXlysxMVEpKSm64oor9OCDD7Z0HwEAAFqVzTiLJ7AWFRVpz549Ki8v18CBA9WrV6+W7Jtfcbvdcjgccrlcstvtvu4OAABogqb+fgeezYd069ZN3bp1O5tdAAAA+FyTA9HUqVObvNMnn3yyWZ0BAADwhSbPIdq5c2eTtoKCghbtYG1trebMmaMePXooLCxMPXv21KOPPqofX+kzDENz585V165dFRYWptTUVO3fv99jP6WlpcrIyJDdbldkZKQmTpxo3lASAABYW5PPEG3cuLE1+3FKTzzxhJ5//nmtXLlSF110kbZv364777xTDodD999/vyRp4cKFWrx4sVauXKkePXpozpw5SktL0759+xQaGipJysjI0JEjR5Sdna3q6mrdeeedmjx5slatWuWT4wIAAP6jWZOqXS6XamtrFRUV5VFeWlqqwMDAFp10fOONNyo2NlYvvPCCWZaenq6wsDC99NJLMgxD8fHxmjZtmqZPn272LzY2VitWrNCYMWP06aefKjExUdu2bdPgwYMlSevWrdMNN9ygr7/+WvHx8WfsB5OqAQBoe5r6+93s+xC9+uqrDcpff/11jRkzpjm7PKUrrrhC69ev1+effy7p5PPSPvroI40YMUKSdPDgQTmdTqWmpprvcTgcSkpKUm5uriQpNzdXkZGRZhiSpNTUVAUEBCgvL6/Rz62srJTb7fbYAABA+9SsQJSXl6frrruuQfm11157yoDRXLNmzdKYMWPUp08fBQUFaeDAgZoyZYoyMjIkSU6nU5IUGxvr8b7Y2Fizzul0KiYmxqM+MDBQUVFRZpufmj9/vhwOh7klJCS06HEBAAD/0axAVFlZqZqamgbl1dXV+uGHH866Uz/2+uuv6+WXX9aqVau0Y8cOrVy5Un/605+0cuXKFv2cn5o9e7ZcLpe5HTp0qFU/DwAA+E6zAtGQIUO0bNmyBuVLly7VoEGDzrpTPzZjxgzzLFG/fv10xx136IEHHtD8+fMlSXFxcZKk4uJij/cVFxebdXFxcSopKfGor6mpUWlpqdnmp0JCQmS32z02AADQPjXrxoyPPfaYUlNT9Z///EdDhw6VJK1fv17btm3TBx980KIdPHHihAICPHNbhw4dVFdXJ0nq0aOH4uLitH79el1yySWSTk6gysvL07333itJSk5OVllZmfLz883AtmHDBtXV1SkpKalF+wsAANqeZgWiK6+8Urm5uVq0aJFef/11hYWFqX///nrhhRda/PEdo0aN0h//+Ed169ZNF110kXbu3Kknn3xSd911lyTJZrNpypQpeuyxx9SrVy9z2X18fLxGjx4tSerbt6+GDx+uSZMmaenS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rIqKCkVERGj16tVKTExUQUGBpb4LpxoHybvfBQIRvGLEiBHmv/v376+kpCR1795dr7/+usLCwnzYM/iDMWPGmP/u16+f+vfvr549e2rTpk0aOnSoD3vWOjIzM7Vnzx6PeXRWdKpx+PHcsH79+qlr164aOnSoDhw4oJ49e3q7m62md+/eKigokMvl0j/+8Q+NHz9emzdv9nW3vO5U45CYmOjV7wKXzLwsOjpaHTp0aLBaoLi4WHFxcT7qlfdFRkbqwgsv1BdffKG4uDhVVVWprKzMo017H5P6YzvddyEuLq7BZPuamhqVlpa267E5//zzFR0drS+++EJS+xqHrKwsrV27Vhs3btR5551nljfl7yAuLq7R70t9XVtyqnFoTFJSkiR5fB/awzgEBwfrggsu0KBBgzR//nwNGDBAzzzzjOW+C6cah8a05neBQORlwcHBGjRokNavX2+W1dXVaf369R7XTNu78vJyHThwQF27dtWgQYMUFBTkMSaFhYUqKipq12PSo0cPxcXFeRy32+1WXl6eedzJyckqKytTfn6+2WbDhg2qq6sz/8PQHn399df67rvv1LVrV0ntYxwMw1BWVpZWr16tDRs2qEePHh71Tfk7SE5O1u7duz3CYXZ2tux2u3mJwd+daRwaU1BQIEke34e2Pg6NqaurU2VlpWW+C6dSPw6NadXvQjMmgOMsvfrqq0ZISIixYsUKY9++fcbkyZONyMhIj1ny7c20adOMTZs2GQcPHjS2bNlipKamGtHR0UZJSYlhGIZxzz33GN26dTM2bNhgbN++3UhOTjaSk5N93Ouzd+zYMWPnzp3Gzp07DUnGk08+aezcudP46quvDMMwjAULFhiRkZHGO++8Y+zatcu46aabjB49ehg//PCDuY/hw4cbAwcONPLy8oyPPvrI6NWrlzF27FhfHVKznG4cjh07ZkyfPt3Izc01Dh48aPz73/82Lr30UqNXr15GRUWFuY+2Pg733nuv4XA4jE2bNhlHjhwxtxMnTphtzvR3UFNTY1x88cXGsGHDjIKCAmPdunXGOeecY8yePdsXh9QsZxqHL774wnjkkUeM7du3GwcPHjTeeecd4/zzzzdSUlLMfbSHcZg1a5axefNm4+DBg8auXbuMWbNmGTabzfjggw8Mw7DGd8EwTj8O3v4uEIh85NlnnzW6detmBAcHG0OGDDE++eQTX3epVd12221G165djeDgYOPcc881brvtNuOLL74w63/44Qfjd7/7ndG5c2cjPDzcuPnmm40jR474sMctY+PGjYakBtv48eMNwzi59H7OnDlGbGysERISYgwdOtQoLCz02Md3331njB071oiIiDDsdrtx5513GseOHfPB0TTf6cbhxIkTxrBhw4xzzjnHCAoKMrp3725MmjSpwf9BaOvj0NjxSzKWL19utmnK38GXX35pjBgxwggLCzOio6ONadOmGdXV1V4+muY70zgUFRUZKSkpRlRUlBESEmJccMEFxowZMwyXy+Wxn7Y+DnfddZfRvXt3Izg42DjnnHOMoUOHmmHIMKzxXTCM04+Dt78LNsMwjJ93TgkAAKB9YQ4RAACwPAIRAACwPAIRAACwPAIRAACwPAIRAACwPAIRAACwPAIRAACwPAIRAACwPAIRgDbr2muv1ZQpU7zyWfPmzdMll1zilc8C4H0EIgBogunTp3s8bHPChAkaPXq07zoEoEUF+roDANAWREREKCIiwtfdANBKOEMEoE04fvy4xo0bp4iICHXt2lV//vOfPeorKys1ffp0nXvuuerYsaOSkpK0adMms37FihWKjIzU+++/r759+yoiIkLDhw/XkSNHzDabNm3SkCFD1LFjR0VGRurKK6/UV199Jcnzktm8efO0cuVKvfPOO7LZbLLZbNq0aZOuv/56ZWVlefTr22+/VXBwsMfZJQD+h0AEoE2YMWOGNm/erHfeeUcffPCBNm3apB07dpj1WVlZys3N1auvvqpdu3bpN7/5jYYPH679+/ebbU6cOKE//elP+vvf/66cnBwVFRVp+vTpkqSamhqNHj1a11xzjXbt2qXc3FxNnjxZNputQV+mT5+uW2+91QxUR44c0RVXXKG7775bq1atUmVlpdn2pZde0rnnnqvrr7++FUcHwNnikhkAv1deXq4XXnhBL730koYOHSpJWrlypc477zxJUlFRkZYvX66ioiLFx8dLOhla1q1bp+XLl+vxxx+XJFVXV2vp0qXq2bOnpJMh6pFHHpEkud1uuVwu3XjjjWZ93759G+1PRESEwsLCVFlZqbi4OLP8lltuUVZWlt555x3deuutkk6emZowYUKjwQqA/yAQAfB7Bw4cUFVVlZKSksyyqKgo9e7dW5K0e/du1dbW6sILL/R4X2Vlpbp06WK+Dg8PN8OOJHXt2lUlJSXm/iZMmKC0tDT98pe/VGpqqm699VZ17dq1yf0MDQ3VHXfcoRdffFG33nqrduzYoT179ujdd99t1nED8B4CEYA2r7y8XB06dFB+fr46dOjgUffjidBBQUEedTabTYZhmK+XL1+u+++/X+vWrdNrr72mBx98UNnZ2br88sub3Je7775bl1xyib7++mstX75c119/vbp3797MIwPgLcwhAuD3evbsqaCgIOXl5Zll33//vT7//HNJ0sCBA1VbW6uSkhJdcMEFHtuPL2k1xcCBAzV79mx9/PHHuvjii7Vq1apG2wUHB6u2trZBeb9+/TR48GD95S9/0apVq3TXXXf9rM8H4BsEIgB+LyIiQhMnTtSMGTO0YcMG7dmzRxMmTFBAwMn/hF144YXKyMjQuHHj9NZbb+ngwYPaunWr5s+fr3/+859N+oyDBw9q9uzZys3N1VdffaUPPvhA+/fvP+U8ol/84hfatWuXCgsLdfToUVVXV5t1d999txYsWCDDMHTzzTef/QAAaHUEIgBtwqJFi3T11Vdr1KhRSk1N1VVXXaVBgwaZ9cuXL9e4ceM0bdo09e7dW6NHj9a2bdvUrVu3Ju0/PDxcn332mdLT03XhhRdq8uTJyszM1P/8z/802n7SpEnq3bu3Bg8erHPOOUdbtmwx68aOHavAwECNHTtWoaGhZ3fgALzCZvz4AjoA4Kx9+eWX6tmzp7Zt26ZLL73U190B0AQEIgBoIdXV1fruu+80ffp0HTx40OOsEQD/xiUzAGghW7ZsUdeuXbVt2zYtXbrU190B8DNwhggAAFgeZ4gAAIDlEYgAAIDlEYgAAIDlEYgAAIDlEYgAAIDlEYgAAIDlEYgAAIDlEYgAAIDl/V+vmeePxcgtDgAAAABJRU5ErkJggg==\n"
          },
          "metadata": {}
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "#Знову маємо викид, приберемо його та побудумо графік в plotly\n",
        "df3 = df3[df3['density'] != df3['density'].max()]\n",
        "fig = px.scatter(df3, x='density', y='vehicle_id', trendline=\"ols\")\n",
        "fig.show()\n",
        "#Маємо значення R^2: 0.33. Взявши квадратий корінь отримуємо значення коефіцієнту регресії 0.57, що підштовхує до висновку, що міє щільністю населення та кількістю крадіжок є зв'язок, однак не такий сильний як з популяцією"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 542
        },
        "id": "-VJR26WPNdi2",
        "outputId": "04921584-568c-4aa2-b777-fa46a920305d"
      },
      "execution_count": 75,
      "outputs": [
        {
          "output_type": "display_data",
          "data": {
            "text/html": [
              "<html>\n",
              "<head><meta charset=\"utf-8\" /></head>\n",
              "<body>\n",
              "    <div>            <script src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG\"></script><script type=\"text/javascript\">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: \"STIX-Web\"}});}</script>                <script type=\"text/javascript\">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>\n",
              "        <script charset=\"utf-8\" src=\"https://cdn.plot.ly/plotly-2.35.2.min.js\"></script>                <div id=\"41e92d7c-fbee-4053-ad32-28d63f20a84a\" class=\"plotly-graph-div\" style=\"height:525px; width:100%;\"></div>            <script type=\"text/javascript\">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById(\"41e92d7c-fbee-4053-ad32-28d63f20a84a\")) {                    Plotly.newPlot(                        \"41e92d7c-fbee-4053-ad32-28d63f20a84a\",                        [{\"hovertemplate\":\"density=%{x}\\u003cbr\\u003evehicle_id=%{y}\\u003cextra\\u003e\\u003c\\u002fextra\\u003e\",\"legendgroup\":\"\",\"marker\":{\"color\":\"#636efa\",\"symbol\":\"circle\"},\"mode\":\"markers\",\"name\":\"\",\"orientation\":\"v\",\"showlegend\":false,\"x\":[14.72,28.8,67.52,21.5,16.11,6.21,11.62,7.89,17.55,12.92,3.28,1.41,4.94,6.1],\"xaxis\":\"x\",\"y\":[657,442,417,365,233,173,138,135,112,100,26,0,0,0],\"yaxis\":\"y\",\"type\":\"scatter\"},{\"hovertemplate\":\"\\u003cb\\u003eOLS trendline\\u003c\\u002fb\\u003e\\u003cbr\\u003evehicle_id = 6.91827 * density + 90.8599\\u003cbr\\u003eR\\u003csup\\u003e2\\u003c\\u002fsup\\u003e=0.334987\\u003cbr\\u003e\\u003cbr\\u003edensity=%{x}\\u003cbr\\u003evehicle_id=%{y} \\u003cb\\u003e(trend)\\u003c\\u002fb\\u003e\\u003cextra\\u003e\\u003c\\u002fextra\\u003e\",\"legendgroup\":\"\",\"marker\":{\"color\":\"#636efa\",\"symbol\":\"circle\"},\"mode\":\"lines\",\"name\":\"\",\"showlegend\":false,\"x\":[1.41,3.28,4.94,6.1,6.21,7.89,11.62,12.92,14.72,16.11,17.55,21.5,28.8,67.52],\"xaxis\":\"x\",\"y\":[100.61462755190414,113.55178360772823,125.03610395674853,133.06129167052177,133.82230085027612,145.44498650470632,171.25011596364953,180.24386081529195,192.69673830218144,202.3131270281683,212.27542901767993,239.60257683613187,290.10591331073925,557.9811445842732],\"yaxis\":\"y\",\"type\":\"scatter\"}],                        {\"template\":{\"data\":{\"histogram2dcontour\":[{\"type\":\"histogram2dcontour\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"choropleth\":[{\"type\":\"choropleth\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"histogram2d\":[{\"type\":\"histogram2d\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"heatmap\":[{\"type\":\"heatmap\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"heatmapgl\":[{\"type\":\"heatmapgl\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"contourcarpet\":[{\"type\":\"contourcarpet\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"contour\":[{\"type\":\"contour\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"surface\":[{\"type\":\"surface\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"},\"colorscale\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]]}],\"mesh3d\":[{\"type\":\"mesh3d\",\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}],\"scatter\":[{\"fillpattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2},\"type\":\"scatter\"}],\"parcoords\":[{\"type\":\"parcoords\",\"line\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterpolargl\":[{\"type\":\"scatterpolargl\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"bar\":[{\"error_x\":{\"color\":\"#2a3f5f\"},\"error_y\":{\"color\":\"#2a3f5f\"},\"marker\":{\"line\":{\"color\":\"#E5ECF6\",\"width\":0.5},\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"bar\"}],\"scattergeo\":[{\"type\":\"scattergeo\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterpolar\":[{\"type\":\"scatterpolar\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"histogram\":[{\"marker\":{\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"histogram\"}],\"scattergl\":[{\"type\":\"scattergl\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatter3d\":[{\"type\":\"scatter3d\",\"line\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}},\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scattermapbox\":[{\"type\":\"scattermapbox\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scatterternary\":[{\"type\":\"scatterternary\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"scattercarpet\":[{\"type\":\"scattercarpet\",\"marker\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}}}],\"carpet\":[{\"aaxis\":{\"endlinecolor\":\"#2a3f5f\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"minorgridcolor\":\"white\",\"startlinecolor\":\"#2a3f5f\"},\"baxis\":{\"endlinecolor\":\"#2a3f5f\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"minorgridcolor\":\"white\",\"startlinecolor\":\"#2a3f5f\"},\"type\":\"carpet\"}],\"table\":[{\"cells\":{\"fill\":{\"color\":\"#EBF0F8\"},\"line\":{\"color\":\"white\"}},\"header\":{\"fill\":{\"color\":\"#C8D4E3\"},\"line\":{\"color\":\"white\"}},\"type\":\"table\"}],\"barpolar\":[{\"marker\":{\"line\":{\"color\":\"#E5ECF6\",\"width\":0.5},\"pattern\":{\"fillmode\":\"overlay\",\"size\":10,\"solidity\":0.2}},\"type\":\"barpolar\"}],\"pie\":[{\"automargin\":true,\"type\":\"pie\"}]},\"layout\":{\"autotypenumbers\":\"strict\",\"colorway\":[\"#636efa\",\"#EF553B\",\"#00cc96\",\"#ab63fa\",\"#FFA15A\",\"#19d3f3\",\"#FF6692\",\"#B6E880\",\"#FF97FF\",\"#FECB52\"],\"font\":{\"color\":\"#2a3f5f\"},\"hovermode\":\"closest\",\"hoverlabel\":{\"align\":\"left\"},\"paper_bgcolor\":\"white\",\"plot_bgcolor\":\"#E5ECF6\",\"polar\":{\"bgcolor\":\"#E5ECF6\",\"angularaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"radialaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"}},\"ternary\":{\"bgcolor\":\"#E5ECF6\",\"aaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"baxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"},\"caxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\"}},\"coloraxis\":{\"colorbar\":{\"outlinewidth\":0,\"ticks\":\"\"}},\"colorscale\":{\"sequential\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]],\"sequentialminus\":[[0.0,\"#0d0887\"],[0.1111111111111111,\"#46039f\"],[0.2222222222222222,\"#7201a8\"],[0.3333333333333333,\"#9c179e\"],[0.4444444444444444,\"#bd3786\"],[0.5555555555555556,\"#d8576b\"],[0.6666666666666666,\"#ed7953\"],[0.7777777777777778,\"#fb9f3a\"],[0.8888888888888888,\"#fdca26\"],[1.0,\"#f0f921\"]],\"diverging\":[[0,\"#8e0152\"],[0.1,\"#c51b7d\"],[0.2,\"#de77ae\"],[0.3,\"#f1b6da\"],[0.4,\"#fde0ef\"],[0.5,\"#f7f7f7\"],[0.6,\"#e6f5d0\"],[0.7,\"#b8e186\"],[0.8,\"#7fbc41\"],[0.9,\"#4d9221\"],[1,\"#276419\"]]},\"xaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\",\"title\":{\"standoff\":15},\"zerolinecolor\":\"white\",\"automargin\":true,\"zerolinewidth\":2},\"yaxis\":{\"gridcolor\":\"white\",\"linecolor\":\"white\",\"ticks\":\"\",\"title\":{\"standoff\":15},\"zerolinecolor\":\"white\",\"automargin\":true,\"zerolinewidth\":2},\"scene\":{\"xaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2},\"yaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2},\"zaxis\":{\"backgroundcolor\":\"#E5ECF6\",\"gridcolor\":\"white\",\"linecolor\":\"white\",\"showbackground\":true,\"ticks\":\"\",\"zerolinecolor\":\"white\",\"gridwidth\":2}},\"shapedefaults\":{\"line\":{\"color\":\"#2a3f5f\"}},\"annotationdefaults\":{\"arrowcolor\":\"#2a3f5f\",\"arrowhead\":0,\"arrowwidth\":1},\"geo\":{\"bgcolor\":\"white\",\"landcolor\":\"#E5ECF6\",\"subunitcolor\":\"white\",\"showland\":true,\"showlakes\":true,\"lakecolor\":\"white\"},\"title\":{\"x\":0.05},\"mapbox\":{\"style\":\"light\"}}},\"xaxis\":{\"anchor\":\"y\",\"domain\":[0.0,1.0],\"title\":{\"text\":\"density\"}},\"yaxis\":{\"anchor\":\"x\",\"domain\":[0.0,1.0],\"title\":{\"text\":\"vehicle_id\"}},\"legend\":{\"tracegroupgap\":0},\"margin\":{\"t\":60}},                        {\"responsive\": true}                    ).then(function(){\n",
              "                            \n",
              "var gd = document.getElementById('41e92d7c-fbee-4053-ad32-28d63f20a84a');\n",
              "var x = new MutationObserver(function (mutations, observer) {{\n",
              "        var display = window.getComputedStyle(gd).display;\n",
              "        if (!display || display === 'none') {{\n",
              "            console.log([gd, 'removed!']);\n",
              "            Plotly.purge(gd);\n",
              "            observer.disconnect();\n",
              "        }}\n",
              "}});\n",
              "\n",
              "// Listen for the removal of the full notebook cells\n",
              "var notebookContainer = gd.closest('#notebook-container');\n",
              "if (notebookContainer) {{\n",
              "    x.observe(notebookContainer, {childList: true});\n",
              "}}\n",
              "\n",
              "// Listen for the clearing of the current output cell\n",
              "var outputEl = gd.closest('.output');\n",
              "if (outputEl) {{\n",
              "    x.observe(outputEl, {childList: true});\n",
              "}}\n",
              "\n",
              "                        })                };                            </script>        </div>\n",
              "</body>\n",
              "</html>"
            ]
          },
          "metadata": {}
        }
      ]
    }
  ]
}
