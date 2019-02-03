import sqlite3

conn = sqlite3.connect('./locations.db')

with conn:
    conn.execute(
        """CREATE TABLE IF NOT EXISTS id (
        id INTEGAR NOT NULL,
        name TEXT NOT NULL,
        lat DOUBLE NOT NULL,
        lng DOUBLE NOT NULL
    )"""
    )