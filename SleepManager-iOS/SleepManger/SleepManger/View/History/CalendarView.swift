//
//  CalendarView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate: Date = Date()
    @ObservedObject var viewModel : HistoryViewModel
    @ObservedObject var goalViewModel : ManageViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                // Custom Date Picker
                CustomDatePicker(currentDate: $currentDate, viewModel: viewModel, goalViewModel: goalViewModel)
            }
            .padding(.vertical)
        }
    }
}
