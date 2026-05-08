//
//  DashboardView.swift
//  Grids_SwiftUI
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding97

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // Grid() — layout container that arranges children into rows and columns.
                // horizontalSpacing: gap between columns
                // verticalSpacing:   gap between rows
                Grid(horizontalSpacing: 16, verticalSpacing: 16) {

                    Text("System Stats")
                        .font(.largeTitle.bold())
                        // .gridCellColumns(n) — span this cell across n columns.
                        // Here 2 makes the title stretch the full width of the grid.
                        .gridCellColumns(2)
                        // .gridCellAnchor() — overrides alignment for this single cell.
                        // .leading pins the text to the left edge of its spanned area.
                        .gridCellAnchor(.leading)

                    // GridRow — groups its children into a single row.
                    // Each direct child occupies one column, left to right.
                    GridRow {
                        MetricCard(title: "CPU", value: "45%")       // column 0
                        MetricCard(title: "Memory", value: "8 GB")   // column 1
                    }

                    // Column widths are shared across ALL GridRows in the same Grid,
                    // so both rows below produce evenly-sized, aligned cards.
                    GridRow {
                        MetricCard(title: "Storage", value: "256 GB")  // column 0
                        MetricCard(title: "Network", value: "120mbps") // column 1
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DashboardView()
}
