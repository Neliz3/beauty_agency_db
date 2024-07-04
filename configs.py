import mysql.connector
from mysql.connector import Error
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Connection settings
HOST = os.getenv('host')
USER = os.getenv('user')
PASSWORD = os.getenv('password')
DATABASE = os.getenv('database')


def create_connection():
    """Create a database connection"""
    try:
        connection = mysql.connector.connect(
            host=HOST,  # Update with your database host
            user=USER,  # Update with your database username
            password=PASSWORD,  # Update with your database password
            database=DATABASE
        )
        if connection.is_connected():
            print("Connection to MySQL DB successful")
        return connection
    except Error as e:
        print(f"The error '{e}' occurred")
        return None
