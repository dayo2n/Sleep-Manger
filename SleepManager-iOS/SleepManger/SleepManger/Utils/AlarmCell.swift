//
//  AlarmCell.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/21.
//

import SwiftUI

struct AlarmCell: View {
    
    let index: Int
    @State private var date: Date = Date()
    
    var body: some View {
        HStack {
            DatePicker("#\(index)", selection: $date, displayedComponents: .hourAndMinute)
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

struct AlarmCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCell(index: 0)
    }
}
