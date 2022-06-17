//
//  ModalManageWaterRoutine.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/19.
//

import SwiftUI
import PartialSheet

struct ModalManageWaterRoutine: View {
    
    @Binding var isPresented: Bool
    @State var numberOfAlarm : Int
    
    @State private var drinkNotificationTimes = [String]()
    @ObservedObject var viewModel : ManageViewModel
    
    func fetchGoals() {
        drinkNotificationTimes = viewModel.waterGoal.drinkGoalTimes
        print(drinkNotificationTimes)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Drink Water")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)

                    Text("물 한 컵 (200ml) 기준")
                        .padding(.leading, 40)
                        .padding(.top, 10)
                }
                Spacer()
                
                Button(action: {
                    numberOfAlarm += 1
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 40)
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                })
            }
            .padding()
            
            ScrollView {
                VStack {
                    ForEach (drinkNotificationTimes, id:\.self) { time in
                        AlarmCell(date: TimeString2Date(time: time))
                    }
                }
            }
            .padding(10)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .padding()
            
            Button(action: {
                isPresented = false
//                viewModel.setWaterGoal(newWaterGoal: <#T##WaterGoal#>)
            }, label: {
                Text("Done")
                    .foregroundColor(Color("fontColor"))
                    .frame(width: 300, height: 50)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
            })
                .padding()
        }
        .frame(width: 350, height: 500)
        .background(Color("bgColor"))
        .cornerRadius(20)
    }
}
