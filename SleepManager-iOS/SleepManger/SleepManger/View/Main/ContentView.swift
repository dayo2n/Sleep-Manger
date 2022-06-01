//
//  ContentView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
//
        if viewModel.userSession == nil {
            LoginView()
        } else {
            if let user = viewModel.userSession { // viewModel.currentUser ????
                MainTabView(user: user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
