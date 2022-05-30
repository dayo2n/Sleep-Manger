//
//  RoutineCell.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct RoutineCell: View {
    
    let imageName : String
    let routineName : String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.top, 10)
            Text(routineName)
                .padding(.top, 10)
        }
    }
}

struct RoutineCell_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCell(imageName: "water-bottle", routineName: "Drink Water")
    }
}
