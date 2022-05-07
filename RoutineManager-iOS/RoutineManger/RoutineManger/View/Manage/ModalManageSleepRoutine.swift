//
//  ModalManageSleepRoutine.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/19.
//

import SwiftUI

struct ModalManageSleepRoutine: View {
    
    @Binding var isPresented: Bool
    
    @State private var date: Date = Date()
    let index: Int = 1
    
    var body: some View {
        VStack {
            HStack {
                Text("Enough Sleep")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding()
            
            DatePicker("목표 취침 시간", selection: $date, displayedComponents: .hourAndMinute)
                .padding([.leading, .trailing])
            
            HStack {
                Text("권장 취침 시간은 23시 입니다.")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                Spacer()
            }
            
            DatePicker("목표 기상 시간", selection: $date, displayedComponents: .hourAndMinute)
                .padding([.leading, .trailing, .bottom])
            
            HStack {
                Text("예상 수면 시간 총")
                    .multilineTextAlignment(.center)
                
                Text("8H 00M")
                    .font(.system(size: 20, weight: .bold))
                    .underline()
                    .padding(.bottom, 5)
            }
            .padding(.top, 30)
            
            Text("일반 성인의 권장 수면 시간은 8시간입니다.")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .semibold))
                .padding(.bottom, 10)
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

struct ModalManageSleepRoutine_Previews: PreviewProvider {
    static var previews: some View {
        ModalManageSleepRoutine(isPresented: .constant(true))
    }
}
