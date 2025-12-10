//
//  PlacesBottomSheet.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import SwiftUI
import CoreLocation

struct PlacesBottomSheet: View {
    
    let places: [PlaceAnnotation]
    let userLocation: CLLocation
    @ObservedObject var viewModel: PlacesViewModel
    
    var sortedPlaces: [PlaceAnnotation] {
        var sorted = places
        if let selectedIndex = sorted.firstIndex(where: { $0.isSelected }) {
            let selected = sorted.remove(at: selectedIndex)
            sorted.insert(selected, at: 0)
        }
        return sorted
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            // Header
            HStack {
                Text("Places")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(places.count) results")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            Divider()
            
            // Results List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(sortedPlaces, id: \.id) { place in
                        Button(action: {
                            viewModel.selectPlace(place)
                            viewModel.showPlaceDetail = true
                        }) {
                            HStack(alignment: .top, spacing: 12) {
                                // Pin Icon
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(place.isSelected ? .red : .blue)
                                
                                // Place Info
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(place.name)
                                        .font(.body)
                                        .fontWeight(place.isSelected ? .semibold : .regular)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                    
                                    Text(viewModel.formattedDistance(from: userLocation, to: place))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                // Chevron
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(place.isSelected ? Color.blue.opacity(0.1) : Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(16, corners: [.topLeft, .topRight])
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
}

// Extension to round specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

