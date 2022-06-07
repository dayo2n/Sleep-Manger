//
//  ModalManageSleepRoutine.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/19.
//

import SwiftUI

struct ModalManageSleepRoutine: View {
    
    @Binding var isPresented: Bool
    @State private var sleepGoalTime : Date = Date()
    @State private var wakeUpGoalTime : Date = Date()
    let index: Int = 1
    
    @ObservedObject var viewModel : ManageViewModel
    
    func fetchGoals() {
        sleepGoalTime = TimeString2Date(time: viewModel.sleepGoal.goalBedTime)
        wakeUpGoalTime = TimeString2Date(time: viewModel.sleepGoal.goalWakeUpTime)
        print(sleepGoalTime)
    }
    
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
            
            DatePicker("목표 취침 시간", selection: $sleepGoalTime, displayedComponents: .hourAndMinute)
                .padding([.leading, .trailing])
            
            HStack {
                Text("권장 취침 시간은 23시 입니다.")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                Spacer()
            }
            
            DatePicker("목표 기상 시간", selection: $wakeUpGoalTime, displayedComponents: .hourAndMinute)
                .padding([.leading, .trailing, .bottom])
            
            HStack {
                Text("예상 수면 시간 총")
                    .multilineTextAlignment(.center)
                
                Text("\(getTimeDiff(from:Date2TimeString(date: sleepGoalTime), to:Date2TimeString(date: wakeUpGoalTime)))")
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
                let newSleepGoalTime = Date2TimeString(date: sleepGoalTime)
                let newWakeUpGoalTime = Date2TimeString(date: wakeUpGoalTime)
                viewModel.setSleepGoal(newSleepGoal: SleepGoal(goalBedTime: newSleepGoalTime, goalWakeUpTime: newWakeUpGoalTime, weekendGoalBedTime: newSleepGoalTime, weekendGoalWakeUpTime: newWakeUpGoalTime))
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
        .onAppear() {
            fetchGoals()
        }
    }
}
