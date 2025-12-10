//
//  SearchHistoryView.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import SwiftUI

struct SearchHistoryView: View {
    
    @ObservedObject var historyManager: SearchHistoryManager
    var onSelectSearch: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Recent Searches")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if !historyManager.recentSearches.isEmpty {
                    Button(action: {
                        historyManager.clearHistory()
                    }) {
                        Text("Clear")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            Divider()
            
            // History List
            if historyManager.recentSearches.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No recent searches")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(historyManager.recentSearches.enumerated()), id: \.offset) { index, search in
                            Button(action: {
                                onSelectSearch(search)
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "clock")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Text(search)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: {
                                        historyManager.removeSearch(at: index)
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .padding(8)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 52)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

