//
//  ReceiptCardView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI
import PhotosUI

struct ReceiptCardView: View {
    let receipt: Receipt
    
    @State var photoItem: PhotosPickerItem?
    @State var image: Image?
    
    var body: some View {
        HStack {
            
            NavigationStack {
                Menu {
                    
                    NavigationLink {
                        PhotoPickerView(photoItem: $photoItem, image: $image, photoNetworkViewModel: PhotoNetworkViewModel(), isAlertShown: false)
                    } label: {
                        Text("Take a picture")
                    }
                    
                } label: {
                    userImage(receipt: receipt, width: 60, image: $image)
                }
                
            }
            
            VStack(alignment: .leading, spacing: 4) { // Reduced spacing
                Text(receipt.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                CategoryTagView(categoryTag: receipt.category, backgroundColor: .lightgreen, foreGroundColor: .black)
            }
            
            Spacer() // Push everything to the left and price to the right
            
            Text(dollarFormatter.string(from: NSNumber(value: receipt.totalPrice)) ?? "$0.00")
                .font(.body)
                .foregroundStyle(.primary)
                .padding(.trailing, 16) // Add padding to the trailing edge
        }
        .frame(height: 60) // Give a fixed height to each card
        .background(Color(UIColor.systemBackground)) // Use the system background color
        .cornerRadius(10) // Round the corners
        
    }
}
    
struct userImage: View {
    
    let receipt: Receipt
    let width: Double
    @Binding var image: Image?
    
    
    var body: some View {
        
        if let image = image {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .foregroundColor(.primary)
        } else {
            
            if let url = receipt.imageUrl {
                
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55)
                } placeholder: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55)
                        .foregroundColor(.primary) // Use the primary color for the icon
                }
            } else {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55)
                        .foregroundColor(.primary) // Use the primary color for the icon
            }
        }
    }
}

#Preview {
    ReceiptCardView(receipt: Receipt.receipt1)
}
