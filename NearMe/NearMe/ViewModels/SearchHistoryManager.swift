//
//  SearchHistoryManager.swift
//  NearMe
//
//  Created by SwiftUI Conversion
//

import Foundation
import Combine

class SearchHistoryManager: ObservableObject {
    
    @Published var recentSearches: [String] = []
    
    private let maxHistoryItems = 7
    private let userDefaultsKey = "recentSearches"
    
    init() {
        loadHistory()
    }
    
    func addSearch(_ query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)
        guard !trimmedQuery.isEmpty else { return }
        
        // Remove if already exists
        recentSearches.removeAll { $0.lowercased() == trimmedQuery.lowercased() }
        
        // Add to beginning
        recentSearches.insert(trimmedQuery, at: 0)
        
        // Keep only last 7
        if recentSearches.count > maxHistoryItems {
            recentSearches = Array(recentSearches.prefix(maxHistoryItems))
        }
        
        saveHistory()
    }
    
    func clearHistory() {
        recentSearches.removeAll()
        saveHistory()
    }
    
    func removeSearch(at index: Int) {
        guard index < recentSearches.count else { return }
        recentSearches.remove(at: index)
        saveHistory()
    }
    
    private func saveHistory() {
        UserDefaults.standard.set(recentSearches, forKey: userDefaultsKey)
    }
    
    private func loadHistory() {
        if let saved = UserDefaults.standard.stringArray(forKey: userDefaultsKey) {
            recentSearches = Array(saved.prefix(maxHistoryItems))
        }
    }
}

