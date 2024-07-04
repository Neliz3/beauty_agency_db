from mysql.connector import Error
from configs import create_connection


def execute_query(connection, query, data):
    """Execute a single query"""
    cursor = connection.cursor()
    try:
        cursor.execute(query, data)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"The error '{e}' occurred")


def insert_data():
    connection = create_connection()

    if connection is None:
        return

    # Inserting data into CITIES table
    cities_query = """
    INSERT INTO cities (city_name) 
    VALUES (%s)
    """
    cities_data = [
        ('Kyiv',),
        ('Kharkiv',),
        ('Dnipro',),
        ('Lviv',),
    ]
    for data in cities_data:
        execute_query(connection, cities_query, data)

    # Inserting data into BUSINESSES table
    business_query = """
    INSERT INTO businesses (name, service_name, password, field)
    VALUES (%s, %s, %s, %s)
    """
    business_data = [
        ('Lux salon', 'hair cutting', 'password', 'hair'),
        ('Mariya salon', 'hair painting', 'password', 'hair'),
    ]
    for data in business_data:
        execute_query(connection, business_query, data)

    # Inserting data into CUSTOMERS table
    customers_query = """
    INSERT INTO customers (email, phone, password, age, city)
    VALUES (%s, %s, %s, %s, %s)
    """
    customers_data = [
        ('tommy@gmail.com', '123456', 'password', 17, cities_data[0][0]),
        ('jane@gmail.com', '123456', 'password', 30, cities_data[1][0]),
    ]
    for data in customers_data:
        execute_query(connection, customers_query, data)

    # Inserting data into SERVICES table
    services_query = """
    INSERT INTO services (name, price, id_customer, city)
    VALUES (%s, %s, %s, %s)
    """
    services_data = [
        ('hair cutting', 500, 1, cities_data[0][0]),
        ('hair painting', 1000, 1, cities_data[1][0]),
    ]
    for data in services_data:
        execute_query(connection, services_query, data)

    # Inserting data into ORDERS table
    orders_query = """
    INSERT INTO orders (customer_id, service_id, price, order_number, order_date)
    VALUES (%s, %s, %s, %s, %s)
    """
    orders_data = [
        (1, 1, services_data[0][2], '34RE3', '2024-03-05'),
        (1, 1, services_data[1][2], '35RE4', '2024-03-07'),
    ]
    for data in orders_data:
        execute_query(connection, orders_query, data)


    # Inserting data into SPECIALIST table
    specialist_query = """
    INSERT INTO specialist (first_name, last_name, email, phone, specialization,
                            years_of_experience, city, services_id, business_id)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    specialist_data = [
        ('Alina', 'Kaero', 'alina@gmail.com', '0677659090', 'hairdresser', 5, cities_data[0][0], 1, 1),
        ('Roy', 'Kaero', 'roy@gmail.com', '0977659090', 'hairdresser', 3, cities_data[1][0], 2, 2),
    ]
    for data in specialist_data:
        execute_query(connection, specialist_query, data)

    connection.close()


if __name__ == "__main__":
    insert_data()


# TODO: table insert many
# TODO: check time execution
# TODO: create indexes
# TODO: check time execution
# TODO: create view
# TODO: create procedure with insert update drop and conditionals
