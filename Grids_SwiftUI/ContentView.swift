//
//  ContentView.swift
//  Grids_SwiftUI
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding97
//
//  GitHub Reference: SwiftUI Grid & GridRow

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Grid(alignment:) — sets the default alignment for ALL cells.
        // Children not inside a GridRow span the full width automatically.
        Grid(alignment: .leading) {

            Text("Account")
                .font(.headline)
                // .gridCellColumns(n) — span this cell across n columns.
                // Makes the title stretch full width across both columns.
                .gridCellColumns(2)

            // GridRow — each direct child fills one column, left to right.
            GridRow {
                Text("Name")   // column 0
                Text("Noah")   // column 1
            }

            // Divider outside a GridRow spans the full grid width.
            // .gridCellUnsizedAxes(.horizontal) — prevents the cell from
            // contributing its intrinsic size to column width calculations,
            // so the Divider stretches to fill without inflating the columns.
            Divider()
                .gridCellUnsizedAxes(.horizontal)

            GridRow {
                Text("Plan")     // column 0
                Text("Premium")  // column 1
            }

            Text("Total")
                // .gridCellAnchor() — overrides alignment for this one cell only.
                // .trailing right-aligns it regardless of the Grid's default .leading.
                .gridCellAnchor(.trailing)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
