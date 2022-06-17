//
//  AlarmCell.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/21.
//

import SwiftUI

struct AlarmCell: View {
    
    @State private var date: Date = Date()
    
    init(date: Date) {
        self.date = date
    }
    
    var body: some View {
        HStack {
            DatePicker("# ", selection: $date, displayedComponents: .hourAndMinute)
                .padding(5)
                .padding(.leading, 10)
            
            Button(action: {}, label: {
                Image(systemName: "minus")
                    .frame(width: 40, height: 30)
                    .background(Color("cellColor"))
                    .cornerRadius(10)
            })
                .padding(.trailing, 10)
        }
    }
}
