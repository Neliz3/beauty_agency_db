import mysql.connector
import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Connection settings
HOST = os.getenv('HOST')
USER = os.getenv('USER')
PASSWORD = os.getenv('PASSWORD')
DATABASE = os.getenv('DATABASE')


def create_connection():
    try:
        connection = mysql.connector.connect(
            host=HOST,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        if connection.is_connected():
            print("Connection to MySQL DB successful")
            return connection
    except Error as e:
        print(f"Error: {e}")
    return None
