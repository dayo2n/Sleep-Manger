//
//  MainTabView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @ObservedObject var viewModel = HistoryViewModel()
    @ObservedObject var goalViewModel = ManageViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                TodayView(user: user, viewModel: viewModel, goalViewModel: goalViewModel)
                    .tabItem {
                        Image(systemName: "flame")
                    }
                CalendarView(viewModel: viewModel, goalViewModel: goalViewModel)
                    .tabItem {
                        Image(systemName: "clock")
                }
                ManageView(user: user, viewModel: goalViewModel)
                    .tabItem {
                        Image(systemName: "slider.horizontal.3")
                }
            }
            .background(Color("bgColor"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signout()
        } label : {
            Text("Logout").foregroundColor(.black)
        }
    }
}
