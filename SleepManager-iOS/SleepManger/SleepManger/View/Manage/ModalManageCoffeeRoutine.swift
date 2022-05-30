//
//  ModalManageCoffeeRoutine.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/19.
//

import SwiftUI

struct ModalManageCoffeeRoutine: View {
    
    @Binding var isPresented: Bool
    
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text("Drink Coffee")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding()
            
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .frame(width: 100, height: 50)
                .padding()
            
            Text("이 시간 이후에는 커피를 마시지 않습니다.")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 10)
            Text("커피는 하루 두 잔 이하로, \n취침 최소 6시간 이전에 마시는 것이 권장됩니다.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Button(action: {
                isPresented = false
            }, label: {
                Text("Done")
                    .foregroundColor(Color("fontColor"))
                    .frame(width: 300, height: 50)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
            })
                .padding()
        }
        .frame(width: 350)
        .background(Color("bgColor"))
        .cornerRadius(20)
    }
}

struct ModalManageCoffeeRoutine_Previews: PreviewProvider {
    static var previews: some View {
        ModalManageCoffeeRoutine(isPresented: .constant(true))
    }
}
