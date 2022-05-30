//
//  SleepCell.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct SleepCell: View {
    
    @State private var wakeUp : Bool = false
    
    var body: some View {
        Text("")
//        VStack(alignment: .leading) {
//            HStack {
//                Image("sleeping")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 36, height: 36)
//                    .clipped()
//                
//                Text("Sleep well")
//                    .font(.system(size: 14, weight: .semibold))
//            }
//            .padding()
//            
//            HStack {
//                SetSleepButton()
//                
//                Button(action: {}, label: {
//                    Text("Week's Sleep")
//                        .foregroundColor(.black)
//                        .frame(width: 120, height: 120)
//                        .background(.white)
//                        .cornerRadius(300)
//                        .padding()
//                        .padding(.trailing, 20)
//                })
//            }
//        }
//        .background(Color("cellColor"))
    }
}

struct SleepCell_Previews: PreviewProvider {
    static var previews: some View {
        SleepCell()
    }
}
