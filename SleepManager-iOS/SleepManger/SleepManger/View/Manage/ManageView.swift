//
//  ManageView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI
import PartialSheet

struct ManageView: View {
    
    let user: User
    @State private var showAddModal = false
    
    private let items = [GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 2
    
    var numberOfWaterAlarm : Int = 3
    let routineImage : [String] = ["water", "coffee", "sleeping"]
    let routineName : [String] = ["Drink Water", "Drink Coffee", "Enough Sleep"]
    @State private var showModalIdx : Int = 0
    @State private var showModal = [false, false, false]
    
    @ObservedObject var viewModel = ManageViewModel()
    
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
                
                Spacer()
                
                LazyVGrid(columns: items, content: {

                    // 각 루틴 세팅 모달 클릭시
                    ForEach(routineImage.indices, id: \.self) { idx in
                        HStack {
                            Button(action: {
                                showModal[idx] = true
                                self.showModalIdx = idx
                                
                                if idx == 2 {
                                    viewModel.getSleepGoal()
                                }
                            }, label: {
                                    RoutineCell(imageName: routineImage[idx], routineName: routineName[idx])
                                        .foregroundColor(.black)
                                        .frame(width: 130, height: 120)
                                        .padding()
                                        .background(Color("cellColor"))
                                        .shadow(radius: 10)
                                        .cornerRadius(20)
                                        .padding(.bottom, 20)
                                }
                            )
                        }
                }
                    
                    // 루틴 추가 버튼
                    Button(action: {
                        self.showAddModal = true
                    }, label: {
                        RoutineCell(imageName: "add", routineName: "Add")
                            .foregroundColor(.black)
                            .frame(width: 130, height: 120)
                            .padding()
                            .background(Color("cellColor"))
                            .shadow(radius: 10)
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .partialSheet(isPresented: self.$showAddModal) {
                                ModalAddRoutineView(isPresented: self.$showAddModal)
                            }
                        }
                    )

                })
            }
        }
        .background(Color("bgColor"))
        .attachPartialSheetToRoot()
        .popup(isPresented: self.$showModal[showModalIdx], animation: Animation.linear(duration: 0), closeOnTap: false) {
            ZStack {
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
            
                if routineImage[showModalIdx] == "water" {
                ModalManageWaterRoutine(isPresented: self.$showModal[showModalIdx], numberOfAlarm: numberOfWaterAlarm)
                } else if routineImage[showModalIdx] == "coffee" {
                    ModalManageCoffeeRoutine(isPresented: self.$showModal[showModalIdx])
                } else if routineImage[showModalIdx] == "sleeping" {
                    ModalManageSleepRoutine(isPresented: self.$showModal[showModalIdx], viewModel: viewModel)
                }
            }
        }
    }
}
