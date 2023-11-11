//
//  GraphView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @State private var renderedImage = Image(systemName: "photo")
    
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        NavigationStack {
            VStack {
                PieChart()
            }
            .navigationTitle("Graph")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink("Export",
                              item: renderedImage,
                              preview: SharePreview(Text("Shared image"),
                                                    image: Image(systemName: "apple.logo")))
                }
            }
            .onAppear {
                render()
            }
        }
        
    }
    
    // render the image
    @MainActor func render() {
        
        let image = Image("Ree-See.it_Logo").resizable().frame(width: 20)
        
        let renderer = ImageRenderer(content: image)
        
        // make sure and use the correct display scale for this device
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

struct PieChart: View {
    // datamodel for the pie chart
    var expenses = [
        (name: "Food", price: 120),
        (name: "Education", price: 234.3),
        (name: "Technology", price: 62.12),
        (name: "Gas", price: 625.3),
        (name: "Grocery", price: 320.20),
        (name: "Clothes", price: 50.0)
    ]
    var body: some View {
        
        VStack {
            Chart {
                ForEach(expenses, id: \.name) { expense in
                    // customize the pie chart
                    SectorMark(
                        angle: .value("price", expense.price),
                        angularInset: 2.0
                    )
                    
                    // add marker at the bottom
                    .foregroundStyle(by: .value("Type", expense.name))
                    
                    // add count to middle of the pie slice
                    .annotation(position: .overlay) {
                        Text(String(format: "%.0f", expense.price))
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(height: 400)
        }
        .padding()
    }
    
}


#Preview {
    GraphView()
}
