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
    INSERT INTO customers (email, phone, password, age, preference_service) 
    VALUES (%s, %s, %s, %s, %s)
    """
    customers_data = [
        ('Tommy', 'tommy@gmail.com', '123456', 'password', 17, 'hair cutting'),
        ('Jane', 'jane@gmail.com', '123456', 'password', 30, 'hair painting'),
    ]
    for data in customers_data:
        execute_query(connection, customers_query, data)

    # Inserting data into SERVICES table
    services_query = """
    INSERT INTO services (name, price) 
    VALUES (%s, %s)
    """
    services_data = [
        ('hair cutting', 500),
        ('hair painting', 1000),
    ]
    for data in services_data:
        execute_query(connection, services_query, data)

    # Inserting data into ORDERS table
    orders_query = """
    INSERT INTO orders (customer_id, service_id, price, order_number) 
    VALUES (%s, %s, %s, %s)
    """
    orders_data = [
        (customers_data[0][0], services_data[0][0], services_data[0][1], '34RE3'),
        (customers_data[1][0], services_data[1][0], services_data[1][1], '35RE4'),
    ]
    for data in orders_data:
        execute_query(connection, orders_query, data)

    connection.close()


if __name__ == "__main__":
    insert_data()
