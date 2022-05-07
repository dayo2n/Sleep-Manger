//
//  SetSleepButton.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/22.
//

import SwiftUI

struct SetSleepButton: View {
    var body: some View {
        Button(action: {}, label: {
            VStack {
                Text("Wake up")
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    
                Image("hand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .clipped()
            }
                .frame(width: 120, height: 120)
                .background(.white)
                .cornerRadius(300)
                .padding()
                .padding(.leading, 20)
        })
    }
}

struct SetSleepButton_Previews: PreviewProvider {
    static var previews: some View {
        SetSleepButton()
    }
}
