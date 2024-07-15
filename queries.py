from mysql.connector import Error
import uuid
from configs import create_connection, timer


def execute_query(connection, query, **args):
    """Execute a single query"""
    cursor = connection.cursor()
    if args.get('data'):
        try:
            cursor.execute(query, args['data'])
            connection.commit()
            print("Query executed successfully")
        except Error as e:
            print(f"The error '{e}' occurred")
    else:
        try:
            cursor.execute(query)
            result = cursor.fetchall()
            print(result)
        except Error as e:
            print(f"The error '{e}' occurred")


def insert_data():
    connection = create_connection()

    if connection is None:
        return

    # Inserting data into CITIES table
    cities_query = """
    INSERT INTO cities (id, city_name)
    VALUES (%s, %s)
    """
    cities_data = [
        (str(uuid.uuid4()), 'Kyiv',),
        (str(uuid.uuid4()), 'Kharkiv',),
        (str(uuid.uuid4()), 'Dnipro',),
        (str(uuid.uuid4()), 'Lviv',),
    ]
    for data in cities_data:
        execute_query(connection, cities_query, data=data)

    # Inserting data into BUSINESSES table
    business_query = """
    INSERT INTO businesses (id, name, service_name, password, field)
    VALUES (%s, %s, %s, %s, %s)
    """
    business_data = [
        (str(uuid.uuid4()), 'Lux salon', 'hair cutting', 'password', 'hair'),
        (str(uuid.uuid4()), 'Mariya salon', 'hair painting', 'password', 'hair'),
    ]
    for data in business_data:
        execute_query(connection, business_query, data=data)

    # Inserting data into CUSTOMERS table
    customers_query = """
    INSERT INTO customers (id, email, phone, password, age, city)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    customers_data = [
        (str(uuid.uuid4()), 'tommy@gmail.com', '123456', 'password', 17, cities_data[0][1]),
        (str(uuid.uuid4()), 'jane@gmail.com', '123456', 'password', 30, cities_data[1][1]),
    ]
    for data in customers_data:
        execute_query(connection, customers_query, data=data)

    # Inserting data into SERVICES table
    services_query = """
    INSERT INTO services (id, name, price, id_customer, city)
    VALUES (%s, %s, %s, %s, %s)
    """
    services_data = [
        (str(uuid.uuid4()), 'hair cutting', 500, customers_data[0][0], cities_data[0][1]),
        (str(uuid.uuid4()), 'hair painting', 1000, customers_data[1][0], cities_data[1][1]),
    ]
    for data in services_data:
        execute_query(connection, services_query, data=data)

    # Inserting data into ORDERS table
    orders_query = """
    INSERT INTO orders (id, customer_id, service_id, price, order_number, order_date)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    orders_data = [
        (str(uuid.uuid4()), customers_data[0][0], services_data[0][0], 500, '34RE3', '2024-03-05'),
        (str(uuid.uuid4()), customers_data[1][0], services_data[1][0], 1000, '35RE4', '2024-03-07'),
    ]
    for data in orders_data:
        execute_query(connection, orders_query, data=data)

    # Inserting data into SPECIALIST table
    specialist_query = """
    INSERT INTO specialist (id, first_name, last_name, email, phone, specialization,
                            years_of_experience, city, services_id, business_id)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    specialist_data = [
        (str(uuid.uuid4()), 'Alina', 'Kaero', 'alina@gmail.com', '0677659090', 'hairdresser', 5,
         cities_data[0][1], services_data[0][0], business_data[0][0]),
        (str(uuid.uuid4()), 'Roy', 'Kaero', 'roy@gmail.com', '0977659090', 'hairdresser', 3,
         cities_data[1][1], services_data[0][1], business_data[0][1]),
    ]
    for data in specialist_data:
        execute_query(connection, specialist_query, data=data)

    connection.close()


@timer
def select_data():
    connection = create_connection()

    if connection is None:
        return

    # Filtering services data by a city and service_name
    select_query = """
    SELECT count(*) FROM services WHERE services.city like 'Kyiv'
    AND name in (SELECT businesses.service_name from businesses WHERE businesses.name like 'Lux salon')
    """

    execute_query(connection, select_query)
    connection.close()
