from flask import Flask, request, jsonify
import osmnx as ox

app = Flask(__name__)

@app.route('/get-geocode')
def get_geocode():
    address = request.args.get('address')
    coordinate = ox.geocode(address)
    geoData = {"coordinate": {
        "lat": coordinate[0],
        "long": coordinate[1]
    }}
    
    return jsonify(geoData), 200

if __name__ == "__main__":
    app.run(debug=True, port=5000)