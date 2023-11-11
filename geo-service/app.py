from flask import Flask, request, jsonify
import osmnx as ox

app = Flask(__name__)

@app.route('/get-geocode')
def get_geocode():
    address = request.args.get('address')
    
    # if address is not provided with status 400
    if address is None:
        return "address not found", 400
    
    # getcode the address, if invalid return an invalid message with status 400
    try:
        coordinate = ox.geocode(address)
    except ValueError:
        return "invalid address", 400
    
    geoData = {"coordinate": {
        "lat": coordinate[0],
        "long": coordinate[1]
    }}
    
    # success return json with status 200
    return jsonify(geoData), 200

# set to port 3000 for now since mac uses port 5000
if __name__ == "__main__":
    app.run(debug=True, port=3000, host="0.0.0.0")