import sqlite3
from flask import g
import datetime
from app import app

DATABASE = './location.db'

def rows_to_dict(rows):
    final_list = []
    for row in rows:
        keys = row.keys()
        new_dict = {}
        for key in keys:
            new_dict[key] = row[key]
        final_list.append(new_dict)
    return final_list

# It connects the database if it's not connected.
def get_conn():
    conn = getattr(g, '_database', None)
    if conn is None:
        conn = g._database = sqlite3.connect(DATABASE, isolation_level=None)
        conn.row_factory = sqlite3.Row
    return conn

# It disconnects automatically
@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()



def locationCreation(
    id, name, lat, lng
):
    with get_conn():
        get_conn().execute(
            "INSERT INTO id (id, name, lat, lng) VALUES (?, ?, ?, ?)",
            (
                id,
                name,
                lat,
                lng,
                
            )
        )



def returnLocations():
    with get_conn():
        id = get_conn().execute('SELECT * from id').fetchall()

    return rows_to_dict(id)


    