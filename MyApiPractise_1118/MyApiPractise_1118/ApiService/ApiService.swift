//
//  ApiService.swift
//  MyApiPractise_1118
//
//  Created by Jolly Gupta on 11/18/25.
//

import Foundation

class ApiService {
    
    func fetchData() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from:url)
        
        do{
            let users = try JSONDecoder().decode([User].self ,from: data)
            return users
        } catch{
            throw error
        }
    }
}
