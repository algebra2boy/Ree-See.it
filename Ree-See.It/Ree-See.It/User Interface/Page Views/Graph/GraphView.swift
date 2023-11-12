//
//  GraphView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    private let previewImage = Image("ShareIcon")
    
    var chartView = PieChart()
    
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
                    ShareLink(item: Image(uiImage: generateSnapshot()),
                              preview:SharePreview("Track Report", image: previewImage))
                }
            }
        }
        
    }
    
    @MainActor
    private func generateSnapshot() -> UIImage {
        
        let renderer = ImageRenderer(content: chartView)
        renderer.scale = displayScale
        
        return renderer.uiImage ?? UIImage()
    }
    
    
}

struct PieChart: View {
    // data model for the pie chart
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
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(width: 350, height: 300)
            .padding(.horizontal)
        }
    }
    
}


#Preview {
    GraphView()
}
