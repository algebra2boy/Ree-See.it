//
//  ReceiptTextFormOptionView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct ReceiptTextFormOptionView: View {
    
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var category: String = "Food"
    @State private var note: String = ""
    @State private var address: String = ""
    @State private var price: Double = 0.0
    
    
    var categorySelection = ["Food", "Grocery", "Education", "Gas", "Technology", "Clothes"]
    
    
    var body: some View {
        NavigationStack {
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
                        TextField("Leave a note", text: $note)
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
                        FormItemLogoView(imageName: "paperplane.fill", rowLabel: "Address", rowTintColor: .blue)
                    }
                }
                
                
                // MARK: Price
                Section {
                    LabeledContent {
                        TextField("0.00", value: $price, format: .currency(code: "USD"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        
                        
                    } label: {
                        FormItemLogoView(imageName: "dollarsign.circle.fill", rowLabel: "Price", rowTintColor: .indigo)
                    }
                }
                
                
                Button {
                    
                } label: {
                    Text("Submit")
                        
                }
                    
            }
            .navigationTitle("New receipt")
            .navigationBarTitleDisplayMode(.inline)
            
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
