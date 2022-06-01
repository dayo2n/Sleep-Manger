//
//  RoutineMangerApp.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

@main
struct RoutineMangerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared) // 애플리케이션을 통틀어 한 객체만 공유하여 사용
        }
    }
}
