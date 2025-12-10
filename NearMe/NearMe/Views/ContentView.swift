//
//  ContentView.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = PlacesViewModel()
    @StateObject private var historyManager = SearchHistoryManager()
    @State private var searchText = ""
    @State private var hasSetInitialRegion = false
    @State private var isSearchFieldFocused = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top Half: Map with Search Bar
                ZStack(alignment: .top) {
                    // Map View (extends to edges)
                    MapView(
                        region: $viewModel.region,
                        places: viewModel.places,
                        onAnnotationTap: { place in
                            viewModel.selectPlace(place)
                        }
                    )
                    .edgesIgnoringSafeArea(.all)
                    .onChange(of: locationManager.location) { newLocation in
                        // Only update region once when we first get the location
                        if let location = newLocation, !hasSetInitialRegion {
                            viewModel.updateRegion(for: location)
                            hasSetInitialRegion = true
                        }
                    }
                    
                    // Search Bar Overlay - positioned at top with minimal spacing
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $searchText, onEditingChanged: { editing in
                                isSearchFieldFocused = editing
                            })
                            .textFieldStyle(PlainTextFieldStyle())
                            .onSubmit {
                                performSearch()
                            }
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    clearSearch()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 16)
                        .padding(.top, 5)
                        
                        // Search History
                        if isSearchFieldFocused && searchText.isEmpty && !historyManager.recentSearches.isEmpty {
                            SearchHistoryView(historyManager: historyManager) { selectedSearch in
                                searchText = selectedSearch
                                isSearchFieldFocused = false
                                performSearch()
                            }
                            .frame(maxHeight: 300)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, geometry.safeAreaInsets.top)
                }
                .frame(height: (viewModel.showPlacesList && !searchText.isEmpty) ? geometry.size.height / 2 : geometry.size.height)
                
                // Bottom Half: Search Results (only show if search text is not empty)
                if viewModel.showPlacesList && !searchText.isEmpty, let userLocation = locationManager.location {
                    PlacesBottomSheet(
                        places: viewModel.places,
                        userLocation: userLocation,
                        viewModel: viewModel
                    )
                    .frame(height: geometry.size.height / 2)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
        .statusBar(hidden: false)
        .onAppear {
            locationManager.requestPermission()
        }
        .sheet(isPresented: $viewModel.showPlaceDetail) {
            if let selectedPlace = viewModel.selectedPlace {
                PlaceDetailView(place: selectedPlace)
            }
        }
    }
    
    private func performSearch() {
        guard !searchText.isEmpty else {
            clearSearch()
            return
        }
        
        // Add to search history
        historyManager.addSearch(searchText)
        
        // Perform search
        viewModel.searchPlaces(query: searchText, in: viewModel.region)
        
        // Hide keyboard and search history
        isSearchFieldFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func clearSearch() {
        searchText = ""
        viewModel.places = [] // Clear places (also clears map pins)
        viewModel.showPlacesList = false
        viewModel.selectedPlace = nil
        isSearchFieldFocused = false
        // Hide keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

