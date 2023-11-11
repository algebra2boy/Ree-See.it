//
//  MenuTabView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct MenuTabView: View {
    
    @StateObject var menuViewModel: MenuTabViewModel = MenuTabViewModel()
    
    var body: some View {
        ForEach(menuViewModel.tabs) { tab in
            tab.destination
                .tabItem {
                    tab.label
                }
        }
    }
}

/// a view model that stores the information about the menu tabs
final class MenuTabViewModel: ObservableObject {
    @Published var tabs: [MenuTab] = MenuTab.allCases
}

/// A enum that represents the menu tab at the bottom of the screen
enum MenuTab: CaseIterable, Identifiable, Codable, Hashable {
    case receipt
    case graph
    
    var id: MenuTab { return self }
}

extension MenuTab {
    @ViewBuilder
    var label: some View {
        switch self {
        case .receipt:
            Label("Receipt", systemImage: "printer.filled.and.paper")
        case .graph:
            Label("Graph", systemImage: "chart.pie.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .receipt:
            ReceiptView()
        case .graph:
            GraphView()
        }
    }
}
