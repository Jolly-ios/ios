//
//  ContentView.swift
//  MyApiPractise_1118
//
//  Created by Jolly Gupta on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : UserViewModel
    var body: some View {
        Group {
            if (viewModel.isLoading){
                ProgressView("..Loading")
            } else {
                List(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text(user.email)
                    }
                }
            }
        }
      
        .padding()
        .onAppear {
            if viewModel.users.isEmpty {
                Task{
                    await viewModel.fetchData()
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
