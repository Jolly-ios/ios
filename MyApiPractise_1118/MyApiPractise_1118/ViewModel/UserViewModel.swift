//
//  UserViewModel.swift
//  MyApiPractise_1118
//
//  Created by Jolly Gupta on 11/21/25.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel : ObservableObject{
    
    @Published var isLoading : Bool = false
    @Published var users : [User] = []
    
    var apiService : ApiService!
    
    init(serviceName: ApiService){
        self.apiService = serviceName
    }
    
    func fetchData() async -> [User] {
        isLoading = true
        
        do {
            self.users = try await ApiService().fetchData()
            print(self.users)
        }catch{
            print(error.localizedDescription)
        }
        
        isLoading = false
        return self.users
    }
    
    
}

