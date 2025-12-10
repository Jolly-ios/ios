# NearMe - SwiftUI MVVM Architecture

## Overview
This app has been converted from UIKit to SwiftUI using the MVVM (Model-View-ViewModel) architecture pattern. The search field tap issues have been completely resolved in this new implementation.

## Architecture Pattern: MVVM

### What is MVVM?
MVVM stands for **Model-View-ViewModel**. It's a design pattern that separates concerns:

- **Model**: Data and business logic
- **View**: UI presentation
- **ViewModel**: Connects Model and View, handles presentation logic

## Project Structure

```
NearMe/
├── Models/
│   └── PlaceAnnotation.swift           # Data model (unchanged)
├── ViewModels/
│   ├── LocationManager.swift           # Manages location services
│   └── PlacesViewModel.swift           # Main business logic
├── Views/
│   ├── ContentView.swift               # Main screen (replaces ViewController)
│   ├── MapView.swift                   # MapKit wrapper
│   ├── PlacesListView.swift           # Places list sheet
│   └── PlaceDetailView.swift          # Place detail sheet
├── Extensions/
│   ├── CLLocation+Extensions.swift     # Location utilities
│   └── String+Extensions.swift         # String utilities
└── NearMeApp.swift                     # App entry point
```

## Key Components Explained

### 1. **LocationManager.swift** (ObservableObject)
```swift
@Published var location: CLLocation?
@Published var authorizationStatus: CLAuthorizationStatus
```

**Purpose**: Manages CoreLocation functionality
- Handles location permissions
- Provides user's current location
- Uses `@Published` to notify views of changes

### 2. **PlacesViewModel.swift** (ObservableObject)
```swift
@Published var places: [PlaceAnnotation] = []
@Published var selectedPlace: PlaceAnnotation?
@Published var showPlacesList = false
@Published var region = MKCoordinateRegion(...)
```

**Purpose**: Contains all business logic
- Searches for nearby places using MapKit
- Manages selected place state
- Handles distance calculations
- Controls sheet presentations

**Key Methods**:
- `searchPlaces(query:in:)` - Searches for places
- `selectPlace(_:)` - Handles place selection
- `formattedDistance(from:to:)` - Formats distance display

### 3. **ContentView.swift** (Main View)

**Purpose**: Main screen that displays map and search bar

**Key Features**:
- **Search Bar**: Native SwiftUI TextField (no tap issues!)
  - Uses `onSubmit` to handle search
  - Includes clear button
  - Properly dismisses keyboard
  
- **Map Integration**: Uses `MapView` wrapper
  - Shows user location
  - Displays place annotations
  - Handles annotation taps

- **State Management**:
  - `@StateObject` for LocationManager and ViewModel
  - `@State` for search text
  - Automatically updates on location changes

### 4. **MapView.swift** (UIViewRepresentable)

**Purpose**: Bridges UIKit's MKMapView to SwiftUI

**How it works**:
```swift
struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var places: [PlaceAnnotation]
    var onAnnotationTap: (PlaceAnnotation) -> Void
    
    // Creates MKMapView
    func makeUIView(context: Context) -> MKMapView
    
    // Updates when SwiftUI state changes
    func updateUIView(_ mapView: MKMapView, context: Context)
    
    // Coordinator handles MKMapViewDelegate
    func makeCoordinator() -> Coordinator
}
```

### 5. **PlacesListView.swift**

**Purpose**: Displays list of nearby places in a sheet

**Features**:
- Shows selected place at the top
- Displays distance from user
- Tap to view details
- Sorted by selection status

### 6. **PlaceDetailView.swift**

**Purpose**: Shows detailed information about a place

**Features**:
- Place name and address
- "Directions" button (opens Apple Maps)
- "Call" button (initiates phone call)
- Clean, accessible layout

## Data Flow

```
User Interaction → View → ViewModel → Model
                     ↑                    ↓
                     ← @Published State ←
```

### Example: Searching for Places

1. **User types** in search field
2. **User taps** "Go" on keyboard
3. **View calls** `viewModel.searchPlaces()`
4. **ViewModel** makes MKLocalSearch request
5. **ViewModel updates** `@Published var places`
6. **View automatically updates** (thanks to SwiftUI)
7. **Sheet appears** with results

## SwiftUI Property Wrappers

### `@StateObject`
- Creates and owns an ObservableObject
- Survives view updates
- Used for: LocationManager, PlacesViewModel

### `@ObservedObject`
- Observes an ObservableObject passed from parent
- Used for: Passing ViewModel to child views

### `@Published`
- Marks properties that trigger view updates
- Used in: LocationManager, PlacesViewModel

### `@State`
- Private view state
- Used for: searchText, temporary UI state

### `@Binding`
- Two-way connection to parent's state
- Used for: MapView region binding

### `@Environment`
- Access system-provided values
- Used for: `.dismiss` to close sheets

## Key SwiftUI Concepts Used

### 1. **Declarative Syntax**
SwiftUI describes "what" the UI should look like, not "how" to build it.

```swift
VStack {
    TextField("Search", text: $searchText)
    MapView(...)
}
```

### 2. **Automatic View Updates**
When `@Published` properties change, views automatically update.

### 3. **Sheets & Navigation**
```swift
.sheet(isPresented: $viewModel.showPlacesList) {
    PlacesListView(...)
}
```

### 4. **View Modifiers**
Chain modifiers to customize views:
```swift
.padding()
.background(Color.white)
.cornerRadius(10)
.shadow(...)
```

## Why This Fixes the Tap Issue

### UIKit Problems (Old):
❌ Complex view hierarchy with overlapping frames
❌ Manual constraint management
❌ UITextField covered by MKMapView
❌ `bringSubviewToFront` unreliable
❌ Touch events blocked

### SwiftUI Solution (New):
✅ Declarative layout - no overlapping issues
✅ ZStack properly layers views
✅ TextField automatically interactive
✅ Native keyboard handling
✅ No manual constraint debugging needed

## How to Use the App

### 1. **Launch**
- App requests location permission
- Map centers on your location

### 2. **Search**
- Tap search field (it works! 🎉)
- Type what you're looking for (e.g., "coffee")
- Press "Go" on keyboard

### 3. **View Results**
- Sheet appears with nearby places
- See distances from your location
- Selected place appears at top (gray background)

### 4. **View Details**
- Tap any place in the list
- See full details
- Get directions or call

### 5. **Interact with Map**
- Tap annotations on map
- Opens places list with selection

## Benefits of MVVM + SwiftUI

### Testability
✅ ViewModels can be tested independently
✅ No UI dependencies in business logic

### Maintainability
✅ Clear separation of concerns
✅ Easy to understand data flow
✅ Less boilerplate than UIKit

### Performance
✅ SwiftUI automatically optimizes updates
✅ Only re-renders changed views

### Developer Experience
✅ Live previews
✅ Less code to write
✅ Declarative syntax is easier to read
✅ No Auto Layout constraint debugging!

## Migration Notes

### Files to Keep Using
- `PlaceAnnotation.swift` - Still needed for MapKit
- `CLLocation+Extensions.swift` - Utility functions
- `String+Extensions.swift` - Phone formatting

### Files Now Unused (Can be deleted)
- `ViewController.swift` - Replaced by ContentView
- `PlacesTableViewController.swift` - Replaced by PlacesListView
- `PlaceDetailViewController.swift` - Replaced by PlaceDetailView

### Configuration Changes
- `AppDelegate.swift` - Removed `@main` (now in NearMeApp.swift)
- `SceneDelegate.swift` - Updated to use UIHostingController
- `Info.plist` - No changes needed

## Running the App

1. Open `NearMe.xcodeproj` in Xcode
2. Select a simulator or device
3. Press **Cmd + R** to run
4. Allow location access when prompted
5. **The search field now works perfectly!** 🎉

## Common SwiftUI Patterns Used

### Conditional Views
```swift
if !searchText.isEmpty {
    Button("Clear") { searchText = "" }
}
```

### List with Custom Cells
```swift
List(places, id: \.id) { place in
    VStack {
        Text(place.name)
        Text(distance)
    }
}
```

### Environment Object
```swift
@Environment(\.dismiss) var dismiss
Button("Done") { dismiss() }
```

### Binding
```swift
TextField("Search", text: $searchText)
MapView(region: $viewModel.region, ...)
```

## Debugging Tips

### View Updates Not Working?
- Check `@Published` on ViewModel properties
- Ensure ViewModel is `ObservableObject`
- Verify `@StateObject` or `@ObservedObject` on view

### Keyboard Not Dismissing?
```swift
UIApplication.shared.sendAction(
    #selector(UIResponder.resignFirstResponder),
    to: nil, from: nil, for: nil
)
```

### MapKit Integration Issues?
- Use `UIViewRepresentable` for UIKit views
- Implement `makeUIView` and `updateUIView`
- Use `Coordinator` for delegates

## Next Steps

### Potential Enhancements
1. Add search history
2. Implement favorites
3. Add filters (distance, rating)
4. Custom map annotations
5. Dark mode support
6. iPad optimization

### Learning Resources
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [MVVM Pattern](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm)
- [Combine Framework](https://developer.apple.com/documentation/combine)

## Summary

This SwiftUI + MVVM implementation provides:
- ✅ **Working search field** (main issue resolved!)
- ✅ Clean architecture
- ✅ Testable code
- ✅ Modern Swift features
- ✅ Better maintainability
- ✅ Improved performance

The app is now fully functional with proper separation of concerns and a much better developer experience!

