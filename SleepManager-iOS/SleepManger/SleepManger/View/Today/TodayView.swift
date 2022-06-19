//
//  TodayView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI
import PartialSheet

struct TodayView: View {
    
    @State private var setButton : Bool = false
    @State private var sleepTime: Date = Date()
    @State private var wakeUpTime: Date = Date()
    
    let user: User
    @State var timeDiff : String = ""
    @ObservedObject var viewModel : HistoryViewModel
    @ObservedObject var goalViewModel : ManageViewModel
    
    @State var pieSliceData = PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 0.0), color: Color("fontColor"))

    init(user: User, viewModel: HistoryViewModel, goalViewModel : ManageViewModel) {
        self.user = user
        self.viewModel = viewModel
        self.goalViewModel = goalViewModel
    }
    
    // 로그인 후 화면 첫 전환시 query가 되지않고 nil값이 들어옴 (추후 수정)
    func fetchTodayData() {
        viewModel.queryDaySleep(date: DateConverter().todayDate, isToday: true)
        if viewModel.todaySleepRecord != nil {
            sleepTime = TimeString2Date(time: viewModel.todaySleepRecord!.bedTime!)
            wakeUpTime = TimeString2Date(time: viewModel.todaySleepRecord!.wakeUpTime!)
            
            timeDiff = getTimeDiff(from:viewModel.todaySleepRecord!.bedTime!, to:viewModel.todaySleepRecord!.wakeUpTime!)

            pieSliceData.endAngle = Angle(degrees: getRatio(goalSleepTime: getTimeDiff(from: goalViewModel.sleepGoal.goalBedTime, to: goalViewModel.sleepGoal.goalWakeUpTime), realSleepTime: getTimeDiff(from: (viewModel.todaySleepRecord!.bedTime)!, to: (viewModel.todaySleepRecord?.wakeUpTime)!)))
        }
    }
    
    struct PieSliceData {
        var startAngle: Angle
        var endAngle: Angle
        var color: Color
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView(user: user)
                
                HStack {
                    Text("Today's Routine")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(Color("fontColor"))
                        .padding([.leading, .bottom])
                    
                    Spacer()
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
                            ZStack {
                                // put pie chart
                                GeometryReader { geometry in
                                    Path { path in
                                        let width: CGFloat = min(geometry.size.width, geometry.size.height)
                                        let height = width
                                        
                                        let center = CGPoint(x: width * 0.5, y: height * 0.5)
                                        
                                        path.move(to: center)
                                        
                                        path.addArc(
                                            center: center,
                                            radius: width * 0.5,
                                            startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                                            endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                                            clockwise: false)
                                        
                                    }
                                    .fill(pieSliceData.color)
                                }
                                .aspectRatio(1, contentMode: .fit)
                                
                                VStack {
                                    Text( (viewModel.todaySleepRecord == nil) ? "Records" : "\(timeDiff)")
                                        .foregroundColor(.black)
                                        .padding(.top, 10)
                                    
                                    if viewModel.todaySleepRecord?.bedTime == nil {
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
                            }
                            .padding()
                            .padding(.leading, 20)
                        })
                        
                        Button(action: {}, label: {
                            Text("Week's Sleep")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 120)
                                .background(.white)
                                .cornerRadius(300)
                                .padding()
                                .padding(.trailing, 20)
                        })
                    }
                }
                .background(Color("cellColor"))
                .cornerRadius(20)
                
                DrinkCell()
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
                        viewModel.todaySleepRecord == nil ? viewModel.initialRecordDaySleep(daySleep: Sleep(wakeUpTime: wakeUp, bedTime: sleep, date: DateConverter().todayDate)) : viewModel.recordDaySleep(daySleep: Sleep(wakeUpTime: wakeUp, bedTime: sleep, date: DateConverter().todayDate))
                        setButton = false
                        fetchTodayData()
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
            fetchTodayData()
        }
    }
}
