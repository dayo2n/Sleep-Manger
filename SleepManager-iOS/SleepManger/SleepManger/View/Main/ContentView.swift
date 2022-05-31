//
//  ContentView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userSession: Bool = false
    
    var body: some View {
//
        if !userSession {
            LoginView()
//            MainTabView()
        } else {
            MainTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
