from flask import Flask, request, jsonify
import osmnx as ox

app = Flask(__name__)

@app.route('/get-geocode')
def get_geocode():
    address = request.args.get('address')
    
    if address is None:
        return "address not found", 400
    
    try:
        coordinate = ox.geocode(address)
    except ValueError:
        return "invalid address", 400
    
    geoData = {"coordinate": {
        "lat": coordinate[0],
        "long": coordinate[1]
    }}
    
    return jsonify(geoData), 200

if __name__ == "__main__":
    app.run(debug=True, port=3000, host="0.0.0.0")