from flask import redirect, request, jsonify, session, send_file
import os
import base64
from app import app
import database

global_state = {}
upload_folder = '/tmp/uploads'


@app.route('/get_locations')
def get_locations():
    locations = database.returnItems()
    return jsonify(locations)

@app.route("/", methods=["POST"])
def itemTaken():
    data = get_post_data()
    print(data)
    database.locationCreation(data["id"], data["name"], data["lat"], data["lng"])
    return jsonify("success")