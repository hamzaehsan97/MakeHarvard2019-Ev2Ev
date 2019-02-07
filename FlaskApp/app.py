from flask import Flask
from flask import render_template
from data import  Locations
from flask import request


app = Flask(__name__)

Locations = Locations()


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/dataTest', methods = ['POST','GET'])
def dataTest():
    if request.method == 'POST':
        dataTest = request.form
        return render_template('dataTest.html', dataTest=dataTest)


@app.route('/locations')
def locations():
    return render_template('locations.html', Locations = Locations)

if __name__ == '__main__':
    app.run(debug=True)

