//
//  PlaceDetailView.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    
    let place: PlaceAnnotation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Place Name
                Text(place.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Address
                Text(place.address)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                // Action Buttons
                HStack(spacing: 16) {
                    // Directions Button
                    Button(action: openDirections) {
                        Label("Directions", systemImage: "map")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    // Call Button
                    if !place.phone.isEmpty {
                        Button(action: makeCall) {
                            Label("Call", systemImage: "phone")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Spacer()
            }
            .padding(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func openDirections() {
        let coordinate = place.location.coordinate
        if let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") {
            UIApplication.shared.open(url)
        }
    }
    
    private func makeCall() {
        let phoneNumber = place.phone.formatPhoneForCall
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
}

