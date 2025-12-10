//
//  PlacesListView.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import SwiftUI
import CoreLocation

struct PlacesListView: View {
    
    let places: [PlaceAnnotation]
    let userLocation: CLLocation
    @ObservedObject var viewModel: PlacesViewModel
    @Environment(\.dismiss) var dismiss
    
    var sortedPlaces: [PlaceAnnotation] {
        var sorted = places
        if let selectedIndex = sorted.firstIndex(where: { $0.isSelected }) {
            let selected = sorted.remove(at: selectedIndex)
            sorted.insert(selected, at: 0)
        }
        return sorted
    }
    
    var body: some View {
        NavigationView {
            List(sortedPlaces, id: \.id) { place in
                Button(action: {
                    viewModel.selectedPlace = place
                    viewModel.showPlaceDetail = true
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(place.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(viewModel.formattedDistance(from: userLocation, to: place))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                .listRowBackground(place.isSelected ? Color.gray.opacity(0.3) : Color.clear)
            }
            .navigationTitle("Places")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showPlaceDetail) {
                if let selectedPlace = viewModel.selectedPlace {
                    PlaceDetailView(place: selectedPlace)
                }
            }
        }
    }
}

