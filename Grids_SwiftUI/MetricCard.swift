//
//  MetricCard.swift
//  Grids_SwiftUI
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding97
//
//  GitHub Reference: SwiftUI Grid & GridRow
//  This card is used as a cell inside a GridRow.
//  Each GridRow child becomes one column — so two MetricCards
//  side-by-side automatically create a two-column layout.
//
//  Example usage inside a Grid:
//
//    GridRow {
//        MetricCard(title: "CPU", value: "45%")      // column 0
//        MetricCard(title: "Memory", value: "8 GB")  // column 1
//    }

import SwiftUI

struct MetricCard: View {
    let title: String  // label shown above the value
    let value: String  // primary metric to display

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title2.bold())
        }
        // maxWidth: .infinity ensures the card fills its column width,
        // so both columns stay equal regardless of content length.
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MetricCard(title: "CPU", value: "45%")
}
