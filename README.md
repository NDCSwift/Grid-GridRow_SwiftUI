# 📐 SwiftUI Grid & GridRow
A reference project showing how to build aligned, multi-column layouts in SwiftUI using `Grid` and `GridRow`.

---

## 🤔 What this is
This project demonstrates SwiftUI's native `Grid` and `GridRow` layout system through three progressively complex examples — from a simple account table to a full portfolio dashboard. It covers every major modifier: `gridCellColumns`, `gridCellAnchor`, `gridCellUnsizedAxes`, and `gridColumnAlignment`. Built as a practical companion to the YouTube tutorial.

## ✅ Why you'd use it
- **`Grid` / `GridRow`** — build table-style layouts that automatically align columns across all rows without HStack math or GeometryReader
- **`gridCellColumns(n)`** — span a single cell across multiple columns (like HTML colspan) for headers, dividers, and hero cards
- **`gridCellUnsizedAxes` / `gridColumnAlignment`** — fine-tune per-cell sizing and per-column alignment without affecting the rest of the grid

## 📺 Watch on YouTube
[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/LHeXajNcG_g)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@noahdoescoding).

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/NDCSwift/Grid-GridRow_SwiftUI.git
```

### 2. Open the project
Double-click `Grids_SwiftUI.xcodeproj` or open it from Xcode via **File → Open**.

### 3. Set your Team
In the project navigator select **Grids_SwiftUI** → **Signing & Capabilities** → set your Apple Developer Team.

### 4. Update the Bundle ID
Change the Bundle Identifier to something unique, e.g. `com.yourname.GridsSwiftUI`.

---

## 🛠️ Notes
- **Three views included** — `ContentView` (basic account table), `DashboardView` (system stats cards), `PortfolioDashboardView` (full portfolio dashboard with nested grids)
- All examples are heavily commented to explain each Grid modifier inline
- No third-party dependencies — pure SwiftUI only

## 📦 Requirements

| | |
|---|---|
| Platform | iOS 16+ |
| Language | Swift 5.9+ |
| IDE | Xcode 15+ |

---

📺 [Watch the guide on YouTube](https://youtu.be/LHeXajNcG_g)
