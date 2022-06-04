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
        let splitSleepGoalTime = viewModel.sleepGoal.goalBedTime.split(separator: ":")
        let stringSleepGoalTime = "2000-01-01 \(splitSleepGoalTime[0]):\(splitSleepGoalTime[1]):00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        sleepGoalTime = dateFormatter.date(from: stringSleepGoalTime) ?? Date()
        
        
        let splitWakeUpGoalTime = viewModel.sleepGoal.goalWakeUpTime.split(separator: ":")
        let stringWakeUpGoalTime = "2000-01-01 \(splitWakeUpGoalTime[0]):\(splitWakeUpGoalTime[1]):00"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        wakeUpGoalTime = dateFormatter.date(from: stringWakeUpGoalTime) ?? Date()
    }
    
    func Date2String() -> [String] {
        
        var newGoals : [String] = [] // [new sleep goal time hour, min, new wake-up goal time hour, min]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let splitOnlySleepTime = dateFormatter.string(from: sleepGoalTime).split(separator: " ")
        let splitNewSleepGoalTime = splitOnlySleepTime[1].split(separator: ":")
        print(dateFormatter.string(from: sleepGoalTime))
        newGoals.append("\(splitNewSleepGoalTime[0])")
        newGoals.append("\(splitNewSleepGoalTime[1])")
        
        let splitOnlyWakeUpTime = dateFormatter.string(from: wakeUpGoalTime).split(separator: " ")
        let splitNewWakeUpGoalTime = splitOnlyWakeUpTime[1].split(separator: ":")
        newGoals.append("\(splitNewWakeUpGoalTime[0])")
        newGoals.append("\(splitNewWakeUpGoalTime[1])")
        return newGoals
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
                let newGoalTime = Date2String()
                viewModel.setSleepGoal(newSleepGoal: SleepGoal(goalBedTime: "\(newGoalTime[0]):\(newGoalTime[1])", goalWakeUpTime: "\(newGoalTime[2]):\(newGoalTime[3])", weekendGoalBedTime: "\(newGoalTime[0]):\(newGoalTime[1])", weekendGoalWakeUpTime: "\(newGoalTime[2]):\(newGoalTime[3])"))
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
