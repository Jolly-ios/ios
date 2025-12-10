//
//  MyApiPractise_1118App.swift
//  MyApiPractise_1118
//
//  Created by Jolly Gupta on 11/18/25.
//

import SwiftUI

@main
struct MyApiPractise_1118App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: UserViewModel(serviceName: ApiService()))
        }
    }
}
