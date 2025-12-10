//
//  PlacesViewModel.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import Foundation
import MapKit
import Combine

class PlacesViewModel: ObservableObject {
    
    @Published var places: [PlaceAnnotation] = []
    @Published var selectedPlace: PlaceAnnotation?
    @Published var showPlacesList = false
    @Published var showPlaceDetail = false
    @Published var searchQuery = ""
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateRegion(for location: CLLocation) {
        region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    }
    
    func searchPlaces(query: String, in region: MKCoordinateRegion) {
        guard !query.isEmpty else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self,
                  let response = response,
                  error == nil else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.places = response.mapItems.map { PlaceAnnotation(mapItem: $0) }
                if !self.places.isEmpty {
                    self.showPlacesList = true
                    // Zoom map to show all search results
                    self.zoomToFitAllPlaces()
                }
            }
        }
    }
    
    func zoomToFitAllPlaces() {
        guard !places.isEmpty else { return }
        
        // Calculate the region that fits all places
        var minLat = places[0].coordinate.latitude
        var maxLat = places[0].coordinate.latitude
        var minLon = places[0].coordinate.longitude
        var maxLon = places[0].coordinate.longitude
        
        for place in places {
            minLat = min(minLat, place.coordinate.latitude)
            maxLat = max(maxLat, place.coordinate.latitude)
            minLon = min(minLon, place.coordinate.longitude)
            maxLon = max(maxLon, place.coordinate.longitude)
        }
        
        // Calculate center and span with some padding
        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2
        let spanLat = (maxLat - minLat) * 1.5 // 1.5x for padding
        let spanLon = (maxLon - minLon) * 1.5
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
            span: MKCoordinateSpan(latitudeDelta: max(spanLat, 0.01), longitudeDelta: max(spanLon, 0.01))
        )
    }
    
    func selectPlace(_ place: PlaceAnnotation) {
        // Deselect all
        places.indices.forEach { places[$0].isSelected = false }
        
        // Select the chosen place
        if let index = places.firstIndex(where: { $0.id == place.id }) {
            places[index].isSelected = true
            selectedPlace = places[index]
            showPlaceDetail = true
        }
    }
    
    func clearSelection() {
        places.indices.forEach { places[$0].isSelected = false }
        selectedPlace = nil
    }
    
    func distance(from userLocation: CLLocation, to place: PlaceAnnotation) -> CLLocationDistance {
        return userLocation.distance(from: place.location)
    }
    
    func formattedDistance(from userLocation: CLLocation, to place: PlaceAnnotation) -> String {
        let distance = self.distance(from: userLocation, to: place)
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        return meters.converted(to: .miles).formatted()
    }
}

