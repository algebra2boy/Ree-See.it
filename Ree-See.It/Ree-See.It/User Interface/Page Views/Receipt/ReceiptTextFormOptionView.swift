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
    @State private var address: String = ""
    @State private var price: Double = 0.0
    
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var isMapShown: Bool = false
    
    @FocusState private var focusedField: FocusedField?
    
    
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
                                .focused($focusedField, equals: .name)
                                .submitLabel(.done)
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
                            NavigationLink {
                                ReceiptMessageView(note: $note)
                            } label: {
                                Text("")
                            }
                            .navigationBarBackButtonHidden(true)
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
                                .focused($focusedField, equals: .address)
                                .onSubmit {
                                    self.convertAddressToCoordinates()
                                }
                            
                        } label: {
                            NavigationLink {
                                MapView(isMapShown: $isMapShown,
                                        address: $address,
                                        latitude: $latitude,
                                        longitude: $longitude)
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
                            // TODO: Send HTTP request
                        }) {
                            Spacer()
                            Text("Submit")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                            
                        }
                        .buttonStyle(.borderless)
                        .disabled(isMapShown == false)
                        
                    }
                    
                    
                }
                
            }
            .navigationTitle("New receipt")
            .navigationBarTitleDisplayMode(.inline)
            
            
            
        }
    }
}

struct ReceiptMessageView: View {
    
    @Binding var note: String
    var body: some View {
        
        NavigationStack {
            TextEditor(text: $note)
                .foregroundStyle(.secondary)
                .navigationTitle("Leave a note to you receipt")
                .submitLabel(.done)
        }
    }
}

struct MapView: View {
    
    @Binding var isMapShown: Bool
    @Binding var address: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    var body: some View {
        
        if isMapShown {
            Map {
                Marker(address, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
        } else {
            Text("Sorry, the address you provided is not avilable and please retry")
                .font(.system(size: 20, weight: .heavy))
                .multilineTextAlignment(.center)
                .frame(width: 200)
        }
    }
}

extension ReceiptTextFormOptionView {
    
    
    // convert address to coordinate
    func convertAddressToCoordinates() {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error != nil else { return }
            
            if let placemark = placemarks?.first {
                self.latitude = placemark.location?.coordinate.latitude ?? 0.0
                self.longitude = placemark.location?.coordinate.longitude ?? 0.0
                isMapShown = true
            }
            
        }
    }
}

extension ReceiptTextFormOptionView {
    enum FocusedField {
        case name, address
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
