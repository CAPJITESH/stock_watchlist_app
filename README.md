# Stock Watchlist App 📈

A modern Flutter application for managing your stock watchlist with clean architecture and smooth user experience.

## ✨ Features

- **📊 Stock Management**: View available stocks with real-time pricing
- **⭐ Watchlist**: Add/remove stocks from your personal watchlist
- **🔄 Reorderable List**: Drag and drop to reorder watchlist items
- **💾 Persistent Storage**: Your watchlist is saved using Hive local storage
- **🎨 Theme Support**: Switch between light and dark themes
- **🏗️ Clean Architecture**: Built with BLoC pattern for scalable state management

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/CAPJITESH/stock_watchlist_app.git
   cd stock_watchlist_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Architecture

This app follows **Clean Architecture** principles with **BLoC Pattern**:

```
lib/
├── features/
│   └── stock_watch_list/
│       ├── bloc/           # Business Logic Components
│       ├── components/     # Reusable UI Components
│       ├── models/         # Data Models
│       ├── screens/        # App Screens
│       └── services/       # Data Services
├── themes/                 # App Theming
└── main.dart              # App Entry Point
```

### Key Components

- **BLoC Pattern**: For predictable state management
- **Hive**: For local data persistence
- **Component-based UI**: Modular and reusable widgets
- **Service Layer**: Clean data handling

## 📱 Screenshots

| Light Theme | Dark Theme |
|-------------|------------|
| <img src="https://github.com/user-attachments/assets/70120de2-2786-4993-baf6-c29431f539a8" width="300" alt="Light Theme Screenshot" /> | <img src="https://github.com/user-attachments/assets/a714c21f-d27e-4414-be70-680136a2c8eb" width="300" alt="Dark Theme Screenshot" /> |

## 🛠️ Tech Stack

- **Flutter**: Cross-platform mobile development
- **BLoC**: State management pattern
- **Hive**: Local storage solution

## 🎯 Core Functionality

### Stock Management
- Load stock data from local JSON
- Display stock symbol, name, and LTP (Last Traded Price)
- Add stocks to watchlist with single tap

### Watchlist Features
- **Add**: Tap any stock to add to watchlist
- **Remove**: Use delete button to remove from watchlist
- **Reorder**: Drag and drop to rearrange watchlist items
- **Persist**: Watchlist automatically saved locally

### Theme System
- Light and dark theme support
- Consistent design across all screens
- Smooth theme transitions

## 🔧 Configuration

### Adding New Stocks

Edit `assets/data/stocks.json`:

```json
[
  {
    "symbol": "AAPL",
    "name": "Apple Inc.",
    "ltp": 189.54,
    "icon_url": "https://example.com/icons/aapl.png"
  }
]
```

### Customizing Themes

Modify `lib/themes/app_theme.dart` to customize colors and styling.

