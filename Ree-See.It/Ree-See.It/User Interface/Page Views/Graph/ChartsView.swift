//
//  ChartsView.swift
//  Ree-See.It
//
//  Created by CHENGTAO on 11/11/23.
//

import SwiftUI
import Charts

struct ChartsView: View {
    let receipts: [Receipt] = [.receipt1, .receipt2, .receipt3, .receipt4, .receipt5]
    var body: some View {
        Chart(receipts, id: \.id) { receipt in
            SectorMark(angle: .value("Category", receipt.category),
                       innerRadius: .ratio(0.618),
                       angularInset: 1.5)
            .cornerRadius(5)
            .opacity(receipts.mostExpensiveCategory()?.category == receipt.category ? 1: 0.3)
            .foregroundStyle(by: .value("Category", receipt.category.))
            )
        }
    }
}

#Preview {
    ChartsView()
}
