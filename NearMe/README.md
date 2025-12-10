# NearMe - SwiftUI MVVM App

> A location-based search app built with SwiftUI and MVVM architecture

## 🎯 Overview

NearMe allows users to search for nearby places using their current location. The app displays results on an interactive map and provides detailed information about each place, including directions and contact options.

## ✨ Features

- 🔍 **Place Search** - Search for nearby restaurants, cafes, stores, etc.
- 🗺️ **Interactive Map** - View search results on a map with annotations
- 📍 **Location Services** - Automatically centers map on user's location
- 📊 **Distance Calculation** - Shows distance from user to each place
- 🧭 **Directions** - Get directions in Apple Maps
- 📞 **Contact** - Call places directly from the app
- 🎨 **Modern UI** - Clean SwiftUI interface

## 🏗️ Architecture

Built using **MVVM (Model-View-ViewModel)** pattern with SwiftUI:

```
┌─────────────┐
│    Views    │ ← SwiftUI Views (ContentView, PlacesListView, etc.)
└──────┬──────┘
       │ @ObservedObject / @StateObject
       ↓
┌─────────────┐
│ ViewModels  │ ← Business Logic (PlacesViewModel, LocationManager)
└──────┬──────┘
       │ @Published
       ↓
┌─────────────┐
│   Models    │ ← Data (PlaceAnnotation)
└─────────────┘
```

## 📁 Project Structure

```
NearMe/
├── Models/
│   └── Annotations/
│       └── PlaceAnnotation.swift       # Place data model
├── ViewModels/
│   ├── LocationManager.swift           # Location services manager
│   └── PlacesViewModel.swift           # Main business logic
├── Views/
│   ├── ContentView.swift               # Main screen
│   ├── MapView.swift                   # Map wrapper
│   ├── PlacesListView.swift           # Search results list
│   └── PlaceDetailView.swift          # Place details
├── Extensions/
│   ├── CLLocation+Extensions.swift     # Location utilities
│   └── String+Extensions.swift         # String utilities
└── NearMeApp.swift                     # App entry point
```

## 🚀 Getting Started

### Requirements
- Xcode 14.0+
- iOS 15.0+
- Swift 5.5+

### Installation

1. Clone or open the project
```bash
cd /Users/jollygupta/androidApps/ios/NearMe
open NearMe.xcodeproj
```

2. Run in Xcode
- Select a simulator or device
- Press **Cmd + R** to build and run

3. Grant Permissions
- Allow location access when prompted

### First Use

1. **Launch the app** - Map appears centered on your location
2. **Tap the search field** at the top
3. **Type your search** (e.g., "coffee", "restaurants", "gas station")
4. **Press "Go"** on the keyboard
5. **View results** in the sheet that appears
6. **Tap any place** to see details

## 🎓 Key Technologies

### SwiftUI
- Declarative UI framework
- State-driven updates
- Built-in animations

### MapKit
- Interactive maps
- Place search (MKLocalSearch)
- Annotations and overlays

### CoreLocation
- GPS location services
- Location permissions
- Distance calculations

### Combine
- Reactive programming
- @Published property wrapper
- ObservableObject protocol

## 📖 Documentation

- **[SWIFTUI_MVVM_ARCHITECTURE.md](SWIFTUI_MVVM_ARCHITECTURE.md)** - Detailed architecture guide
- **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - UIKit to SwiftUI migration notes

## 🔑 Key SwiftUI Concepts

### ObservableObject
ViewModels that notify views of changes:
```swift
class PlacesViewModel: ObservableObject {
    @Published var places: [PlaceAnnotation] = []
}
```

### Property Wrappers
- `@StateObject` - Create and own observable objects
- `@ObservedObject` - Observe objects from parent
- `@Published` - Publish value changes
- `@State` - View-local state
- `@Binding` - Two-way binding

### Views
Declarative UI components:
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
            MapView(region: $region)
        }
    }
}
```

## 🎨 UI Components

### ContentView
- Main screen with map and search bar
- Manages app state
- Coordinates between LocationManager and PlacesViewModel

### MapView
- UIViewRepresentable wrapper for MKMapView
- Displays user location and place annotations
- Handles annotation taps

### PlacesListView
- Sheet displaying search results
- Shows places sorted by selection
- Displays distance from user

### PlaceDetailView
- Detailed place information
- Action buttons (Directions, Call)
- Clean, accessible layout

## 🔄 Data Flow Example

### Searching for Places

```
User Types "coffee" in Search Field
         ↓
ContentView.performSearch()
         ↓
PlacesViewModel.searchPlaces()
         ↓
MKLocalSearch performs search
         ↓
ViewModel.places @Published updated
         ↓
SwiftUI automatically re-renders
         ↓
PlacesListView sheet appears
```

## 🛠️ Development

### Adding New Features

1. **Add to ViewModel** - Business logic goes in ViewModels
2. **Update View** - UI updates automatically via @Published
3. **Keep Models Simple** - Just data, no logic

### Testing

ViewModels can be easily unit tested:
```swift
func testSearchPlaces() {
    let viewModel = PlacesViewModel()
    viewModel.searchPlaces(query: "coffee", in: region)
    // Assert results
}
```

## ⚠️ Permissions Required

The app requires the following permissions (configured in Info.plist):

- `NSLocationWhenInUseUsageDescription` - To show your location on the map
- `NSLocationAlwaysAndWhenInUseUsageDescription` - For location services

## 🐛 Troubleshooting

### Search Not Working
- Check internet connection (required for MapKit search)
- Verify you granted location permissions

### Map Not Centering
- Make sure location permissions are granted
- Check that location services are enabled on device

### Build Errors
- Clean build folder: **Cmd + Shift + K**
- Restart Xcode
- Check minimum deployment target is iOS 15+

## 📱 Screenshots Flow

1. **Launch** → Map with your location
2. **Search** → Type query, press Go
3. **Results** → Sheet with nearby places
4. **Details** → Full place information
5. **Actions** → Get directions or call

## 🎯 Best Practices Used

### MVVM Pattern
✅ Clear separation of concerns  
✅ Testable business logic  
✅ Reusable ViewModels  

### SwiftUI
✅ Declarative syntax  
✅ State-driven updates  
✅ Composition over inheritance  

### Clean Code
✅ Single responsibility principle  
✅ Dependency injection  
✅ Meaningful naming  

## 🚀 Performance

- **Efficient Updates** - SwiftUI only re-renders changed views
- **Lazy Loading** - List items rendered as needed
- **Memory Management** - Automatic with ARC
- **Location Updates** - Only when needed

## 🎓 Learning Resources

### SwiftUI
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Hacking with Swift](https://www.hackingwithswift.com/quick-start/swiftui)

### MVVM
- [Ray Wenderlich MVVM](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm)

### MapKit
- [Apple MapKit Documentation](https://developer.apple.com/documentation/mapkit)

## 📝 License

This is a sample project for educational purposes.

## 👤 Author

Converted from UIKit to SwiftUI MVVM architecture.

## 🙏 Acknowledgments

- Original UIKit version by Mohammad Azam
- Converted to SwiftUI with MVVM pattern
- Built with ❤️ using SwiftUI

---

## Quick Commands

```bash
# Open in Xcode
open NearMe.xcodeproj

# Clean build
# In Xcode: Cmd + Shift + K

# Build and run
# In Xcode: Cmd + R
```

## 📊 Project Stats

- **Language**: Swift 5.5+
- **Framework**: SwiftUI
- **Architecture**: MVVM
- **Min iOS**: 15.0
- **Files**: ~15 Swift files
- **Lines of Code**: ~800

---

**Ready to explore nearby places!** 🗺️✨

