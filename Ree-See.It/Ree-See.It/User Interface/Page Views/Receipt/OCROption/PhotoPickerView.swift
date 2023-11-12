//
//  PhotoPickerView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import SwiftUI
import PhotosUI
import SwiftUI

struct PhotoPickerView: View {
    
    @State private var photoItem: PhotosPickerItem?
    @State private var image: Image?
    
    @StateObject private var photoNetworkViewModel = PhotoNetworkViewModel()
    
    @State private var isAlertShown: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                
                if let image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                }
                
                
                PhotosPicker("Select image",
                             selection: $photoItem,
                             matching: .images)
                
                
                if image != nil {
                    Button {
                        uploadImage()
                    } label: {
                        Text("Starting scanning using our OCR")
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                }
                
            
            }
            .onChange(of: photoItem) {
                Task {
                    
                    do {
                        guard let data = try await photoItem?.loadTransferable(type: Data.self) else {
                            return
                        }
                        
                        guard let uiImage = UIImage(data: data) else {
                            return
                        }
                        
                        image = Image(uiImage: uiImage)
                        
                    } catch {
                        print("something is wrong selecting an picture")
                    }
                    
                }
            }
            .navigationTitle("OCR Scanning")
        }

    }
    
    func uploadImage() {
        
        
        guard let url = URL(string: "http://localhost:3000/api") else {
            return
        }
        
        // specify a url request to send to Node.js server
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        // create boundary
        let boundary = photoNetworkViewModel.generateBoundary()
        
        // set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
    }
    
}

#Preview {
    PhotoPickerView()
}
