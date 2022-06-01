//
//  TodayViewModel.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/01.
//

import SwiftUI


class HeaderViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
