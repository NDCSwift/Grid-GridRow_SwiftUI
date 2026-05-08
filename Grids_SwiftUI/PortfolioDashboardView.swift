//
//  PortfolioDashboardView.swift
//  Grids_SwiftUI
//
//  GitHub Reference: SwiftUI Grid & GridRow
//  📺 YouTube: Noah Does Coding — https://www.youtube.com/@NoahDoesCoding97
//

//  Scroll down to see each Grid concept demonstrated with comments.

import SwiftUI

// ─────────────────────────────────────────────────────────────
// MARK: - Models
// ─────────────────────────────────────────────────────────────

private struct Holding: Identifiable {
    let id = UUID()
    let symbol: String
    let shares: Int
    let price: Double
    let changePercent: Double
    let color: Color

    var value: Double    { Double(shares) * price }
    var isPositive: Bool { changePercent >= 0 }
    var formattedChange: String {
        (changePercent >= 0 ? "+" : "") + String(format: "%.2f", changePercent) + "%"
    }
}

private struct MarketIndex: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
    let changePercent: Double
    var isPositive: Bool { changePercent >= 0 }
    var formattedChange: String {
        (changePercent >= 0 ? "+" : "") + String(format: "%.2f", changePercent) + "%"
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Mock Data
// ─────────────────────────────────────────────────────────────

private let holdings: [Holding] = [
    Holding(symbol: "AAPL", shares: 25, price: 189.30, changePercent:  2.09, color: .blue),
    Holding(symbol: "TSLA", shares: 10, price: 242.15, changePercent: -0.80, color: .red),
    Holding(symbol: "MSFT", shares: 15, price: 415.20, changePercent:  1.40, color: .purple)
]

private let indices: [MarketIndex] = [
    MarketIndex(name: "S&P 500", value:  5_234, changePercent: 0.62),
    MarketIndex(name: "NASDAQ",  value: 16_421, changePercent: 0.91)
]

// ─────────────────────────────────────────────────────────────
// MARK: - Dashboard View
//
// Grid() — the outer layout container.
//
//   GridRow { A  B }
//     Each child occupies one column in order: A → col 0, B → col 1.
//     Column count is determined by the widest GridRow in the Grid.
//
//   .gridCellColumns(n)
//     Stretch a single cell across n columns (like HTML colspan).
//
//   .gridColumnAlignment(.leading / .trailing)
//     Set once on a cell in the first GridRow; locks that column's
//     alignment for every row below it.
//
//   .gridCellUnsizedAxes(.horizontal)
//     Stops a cell from contributing to column width — essential
//     for Divider() so it fills space without inflating columns.
// ─────────────────────────────────────────────────────────────

struct PortfolioDashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {

                    // .gridCellColumns(2) → spans both columns (full width)
                    HeroCard()
                        .gridCellColumns(2)

                    // GridRow → each child fills one column
                    GridRow {
                        SummaryCard(title: "Day Gain",     value: "+$1,234",  badge: "+1.00%")
                        SummaryCard(title: "Total Return", value: "+$24,850", badge: "+24.8%")
                    }

                    HoldingsGrid()
                        .gridCellColumns(2)

                    // ForEach inside GridRow → each element = one column
                    GridRow {
                        ForEach(indices) { IndexCard(index: $0) }
                    }

                    HStack {
                        Text("Watchlist").font(.title3.bold())
                        Spacer()
                    }
                    .gridCellColumns(2)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Portfolio")
        }
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Hero Card
// ─────────────────────────────────────────────────────────────

private struct HeroCard: View {
    private let points: [Double] = [0.4, 0.3, 0.5, 0.45, 0.6, 0.55, 0.7, 0.65, 0.75, 0.72, 0.85]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Portfolio Value")
                        .font(.caption).foregroundStyle(.white.opacity(0.8))
                    Text("$124,850.42")
                        .font(.title.bold()).foregroundStyle(.white)
                }
                Spacer()
                Label("+1.00% today", systemImage: "arrow.up.right")
                    .font(.caption.bold())
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(.white.opacity(0.2))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            // Sparkline drawn with Path — normalised points in 0...1 range
            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height
                let step = w / Double(points.count - 1)
                Path { path in
                    path.move(to: CGPoint(x: 0, y: h - points[0] * h))
                    for (i, pt) in points.enumerated().dropFirst() {
                        path.addLine(to: CGPoint(x: Double(i) * step, y: h - pt * h))
                    }
                }
                .stroke(.white.opacity(0.85), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
            .frame(height: 55)
        }
        .padding()
        .background(LinearGradient(colors: [.blue, Color(red: 0.2, green: 0.4, blue: 0.9)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Summary Card
// ─────────────────────────────────────────────────────────────

private struct SummaryCard: View {
    let title: String
    let value: String
    let badge: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: "arrow.up.circle.fill").foregroundStyle(.green).imageScale(.small)
                Text(title).font(.caption).foregroundStyle(.secondary)
            }
            Text(value).font(.title3.bold())
            Text(badge).font(.caption.bold()).foregroundStyle(.green)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Holdings Grid  (nested Grid as a 4-column table)
// ─────────────────────────────────────────────────────────────

private struct HoldingsGrid: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Holdings").font(.headline)
                Spacer()
                Text("\(holdings.count) positions").font(.caption).foregroundStyle(.secondary)
            }

            Grid(horizontalSpacing: 8, verticalSpacing: 10) {

                // .gridColumnAlignment() set in the first row applies
                // to that column for every subsequent row automatically.
                GridRow {
                    Text("Asset")  .gridColumnAlignment(.leading)
                    Text("Price")  .gridColumnAlignment(.trailing)
                    Text("Change") .gridColumnAlignment(.trailing)
                    Text("Value")  .gridColumnAlignment(.trailing)
                }
                .font(.caption).foregroundStyle(.secondary)

                // .gridCellUnsizedAxes(.horizontal) lets Divider stretch
                // across all columns without sizing any single column.
                Divider().gridCellUnsizedAxes(.horizontal)

                ForEach(holdings) { h in
                    GridRow {
                        // Col 0 — icon + name
                        HStack(spacing: 8) {
                            Circle()
                                .fill(h.color.opacity(0.15))
                                .frame(width: 32, height: 32)
                                .overlay {
                                    Text(String(h.symbol.prefix(1)))
                                        .font(.caption.bold()).foregroundStyle(h.color)
                                }
                            VStack(alignment: .leading, spacing: 1) {
                                Text(h.symbol).font(.subheadline.bold())
                                Text("\(h.shares) shares").font(.caption2).foregroundStyle(.secondary)
                            }
                        }
                        // Col 1 — price
                        Text(String(format: "$%.2f", h.price)).font(.subheadline)
                        // Col 2 — change badge
                        Text(h.formattedChange)
                            .font(.caption.bold())
                            .padding(.horizontal, 6).padding(.vertical, 3)
                            .background(h.isPositive ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                            .foregroundStyle(h.isPositive ? .green : .red)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        // Col 3 — total value
                        Text(String(format: "$%.2f", h.value)).font(.subheadline)
                    }
                    if h.id != holdings.last?.id {
                        Divider().gridCellUnsizedAxes(.horizontal)
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Index Card
// ─────────────────────────────────────────────────────────────

private struct IndexCard: View {
    let index: MarketIndex

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(index.name).font(.caption).foregroundStyle(.secondary)
                Spacer()
                Image(systemName: index.isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption.bold()).foregroundStyle(index.isPositive ? .green : .red)
            }
            Text("\(index.value)").font(.title2.bold())
            Text(index.formattedChange).font(.caption.bold()).foregroundStyle(index.isPositive ? .green : .red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// ─────────────────────────────────────────────────────────────
// MARK: - Preview
// ─────────────────────────────────────────────────────────────

#Preview {
    PortfolioDashboardView()
}
