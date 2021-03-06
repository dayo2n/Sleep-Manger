//
//  HistoryView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI
import PartialSheet

struct HistoryView: View {
    
    var historyDate : DateValue
    @ObservedObject var viewModel : HistoryViewModel
    @ObservedObject var goalViewModel : ManageViewModel
    @State private var setButton : Bool = false
    @State private var sleepTime: Date = Date()
    @State private var wakeUpTime: Date = Date()
    
    @State var timeDiff : String = ""
    
    struct PieSliceData {
        var startAngle: Angle
        var endAngle: Angle
        var color: Color
    }
    @State var pieSliceData = PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 0.0), color: Color("fontColor"))
    
    init(historyDate: DateValue, viewModel: HistoryViewModel, goalViewModel: ManageViewModel) {
        self.historyDate = historyDate
        self.viewModel = viewModel
        self.goalViewModel = goalViewModel
    }
    
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d."
        return formatter
    }()
    
    func fetchHistoryData() {
        viewModel.queryDaySleep(date: Date2OnlyDate(date: historyDate.date), isToday: false)
        
        if viewModel.daySleepRecord != nil {
            sleepTime = TimeString2Date(time: viewModel.daySleepRecord!.bedTime!)
            wakeUpTime = TimeString2Date(time: viewModel.daySleepRecord!.wakeUpTime!)
            
            timeDiff = getTimeDiff(from:viewModel.daySleepRecord!.bedTime!, to:viewModel.daySleepRecord!.wakeUpTime!)

            pieSliceData.endAngle = Angle(degrees: getRatio(goalSleepTime: getTimeDiff(from: goalViewModel.sleepGoal.goalBedTime, to: goalViewModel.sleepGoal.goalWakeUpTime), realSleepTime: getTimeDiff(from: (viewModel.daySleepRecord!.bedTime)!, to: (viewModel.daySleepRecord?.wakeUpTime)!)))
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("\(historyDate.date, formatter: self.dateformat)'s Routine")
                        .font(.system(size: 30, weight: .semibold))
                        .padding([.leading, .bottom])
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image("sleeping")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipped()
                        
                        Text("Sleep well")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    HStack {
                        Button(action: {
                            setButton = true
                        }, label: {
                            VStack {
                                Text( (viewModel.daySleepRecord == nil) ? "Records" : "\(timeDiff)")
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                
                                if viewModel.daySleepRecord?.bedTime == nil {
                                    Image("hand")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .clipped()
                                }
                            }
                                .frame(width: 120, height: 120)
                                .background(.white)
                                .cornerRadius(300)
                                .padding()
                                .padding(.leading, 20)
                        })
                        
//                        Button(action: {
//
//                        }, label: {
//                            Text("Week's Sleep")
//                                .foregroundColor(.black)
//                                .frame(width: 120, height: 120)
//                                .background(.white)
//                                .cornerRadius(300)
//                                .padding()
//                                .padding(.trailing, 20)
//                        })
                    }
                }
                .background(Color("cellColor"))
                .cornerRadius(20)
                
                DrinkCell(viewModel: self.viewModel, goalViewModel: self.goalViewModel)
                    .cornerRadius(20)
            }
        }
        .background(Color("bgColor"))
        .attachPartialSheetToRoot()
        .popup(isPresented: $setButton,animation: Animation.linear(duration: 0), closeOnTap: false) {
            ZStack {
                
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Text("취침, 기상시간 기록")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    HStack {
                        VStack {
                            Text("취침 시간")
                                .padding(.top)
                            
                            DatePicker("", selection: $sleepTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .frame(width: 100, height: 50)
                                .padding([.leading, .trailing, .bottom])
                        }

                        VStack {
                            Text("기상 시간")
                                .padding(.top)
                            
                            DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .frame(width: 100, height: 50)
                                .padding([.leading, .trailing, .bottom])
                        }
                    }
                    
                    Button(action: {
                        guard let uid = AuthViewModel.shared.userSession?.id else { return }
                        let wakeUp = Date2TimeString(date: wakeUpTime)
                        let sleep = Date2TimeString(date: sleepTime)
                        let recordDate = Date2OnlyDate(date: historyDate.date)
                        viewModel.daySleepRecord == nil ? viewModel.initialRecordDaySleep(daySleep: Sleep(wakeUpTime: wakeUp, bedTime: sleep, date: DateConverter().todayDate)) : viewModel.recordDaySleep(daySleep: Sleep(wakeUpTime: wakeUp, bedTime: sleep, date: DateConverter().todayDate))
                        setButton = false
                        fetchHistoryData()
                    }, label: {
                        Text("Done")
                            .foregroundColor(Color("fontColor"))
                            .frame(width: 300, height: 50)
                            .background(Color("btnColor"))
                            .cornerRadius(10)
                    })
                }
                .frame(width: 350, height: 250)
                .background(Color("bgColor"))
                .cornerRadius(10)
            }
        }
        .onAppear() {
            fetchHistoryData()
        }
    }
}
