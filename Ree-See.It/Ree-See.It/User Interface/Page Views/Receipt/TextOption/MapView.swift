//
//  MapView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var isMapShown: Bool
    @Binding var address: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    @FocusState var focusedField: FocusedField?
    
    
    var body: some View {
        
        VStack {
            
            TextField("650 N Pleasant St, Amherst, MA", text: $address)
                .multilineTextAlignment(.leading)
                .focused($focusedField, equals: .address)
                .onSubmit {
                    convertAddressToCoordinates()
                }
                .submitLabel(.done)
            
            if isMapShown {
                Map {
                    Marker(address,
                           coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                }
            } else {
                Text("Please provide full address you and press enter when you done")
                    .font(.system(size: 20, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
            }
            
        }
    }
    
    // convert address to coordinate
    func convertAddressToCoordinates() {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                self.latitude = placemark.location?.coordinate.latitude ?? 0.0
                self.longitude = placemark.location?.coordinate.longitude ?? 0.0
                print(" iam shown")
                self.isMapShown = true
            }
            
        }
    }

}

#Preview {
    MapView()
}
