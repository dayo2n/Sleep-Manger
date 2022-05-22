//
//  MainTabView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                TodayView()
                    .tabItem {
                        Image(systemName: "flame")
                    }
                CalendarView()
                    .tabItem {
                        Image(systemName: "clock")
                }
                ManageView()
                    .tabItem {
                        Image(systemName: "slider.horizontal.3")
                }
            }
            .background(Color("bgColor"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
