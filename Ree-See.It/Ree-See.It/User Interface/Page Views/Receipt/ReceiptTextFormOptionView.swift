//
//  ReceiptTextFormOptionView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI
import MapKit

struct ReceiptTextFormOptionView: View {
    
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var category: String = "Food"
    @State private var note: String = ""
    @State private var address: String = "650 N Pleasant St, Amherst, MA"
    @State private var price: Double = 0.0
    
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var isMapShown: Bool = false
    
    
    var categorySelection = ["Food", "Grocery", "Education", "Gas", "Technology", "Clothes"]
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form {
                    
                    // MARK: Name
                    Section {
                        HStack {
                            Text("Name")
                            Spacer()
                            TextField("Name", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                        
                    }
                    
                    // MARK: DatePicker
                    LabeledContent {
                        DatePicker("",
                                   selection: $date,
                                   displayedComponents: [.date])
                        .datePickerStyle(.compact)
                    } label: {
                        FormItemLogoView(imageName: "calendar", rowLabel: "Date", rowTintColor: .green)
                    }
                    
                    
                    Section {
                        // MARK: Category
                        LabeledContent {
                            Picker("", selection: $category) {
                                ForEach(categorySelection, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            
                        } label: {
                            FormItemLogoView(imageName: "tag", rowLabel: "Category", rowTintColor: .red)
                        }
                        
                        // MARK: Note
                        LabeledContent {
                            TextField("Leave a note to your receipt", text: $note)
                                .multilineTextAlignment(.trailing)
                        } label: {
                            FormItemLogoView(imageName: "message", rowLabel: "Note", rowTintColor: .orange)
                        }
                        
                    }
                    
                    
                    // MARK: Address
                    Section {
                        LabeledContent {
                            TextField("650 N Pleasant St, Amherst, MA", text: $address, axis: .vertical)
                                .lineLimit(2, reservesSpace: true)
                                .multilineTextAlignment(.trailing)
                            
                        } label: {
                            NavigationLink {
                                MapView(address: $address, latitude: $latitude, longitude: $longitude)
                            } label: {
                                FormItemLogoView(imageName: "paperplane.fill", rowLabel: "Address", rowTintColor: .blue)
                            }
                            
                        }
                        
                        // MARK: Price
                        LabeledContent {
                            TextField("0.00", value: $price, format: .currency(code: "USD"))
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                            
                            
                        } label: {
                            FormItemLogoView(imageName: "dollarsign.circle.fill", rowLabel: "Price", rowTintColor: .indigo)
                        }
                    }
                    
                    VStack {
                        
                        Button(action: {
                            convertAddressToCoordinates()
                        }) {
                            Spacer()
                            Text("Submit")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                                
                        }
                        .buttonStyle(.borderless)
                        
                    }
                    
                    
                }
                
            }
            .navigationTitle("New receipt")
            .navigationBarTitleDisplayMode(.inline)
            
            
            
        }
    }
}

struct MapView: View {
    
    @Binding var address: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    var body: some View {
        Map {
            Marker(address, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
}

extension ReceiptTextFormOptionView {
    
    
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
                isMapShown = true
            }
            
        }
    }
}

struct FormItemLogoView: View {
    
    let imageName: String
    let rowLabel: String
    let rowTintColor: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 30, height: 30)
                .foregroundStyle(rowTintColor)
                .overlay {
                    Image(systemName: imageName)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
            Text(rowLabel)
        }
    }
}

#Preview {
    ReceiptTextFormOptionView()
}
