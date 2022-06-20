//
//  ModalNewDrinkView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/17.
//

import SwiftUI
import PartialSheet

struct ModalNewDrinkView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HistoryViewModel
    
    @State private var water200mlBtnTapped : Bool = true
    @State private var water500mlBtnTapped : Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Drink Water")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding()
            
            HStack {
                Image("water")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipped()
                
                Button (action: {
                    water200mlBtnTapped.toggle()
                }, label: {
                    Text("1잔 (200ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(water200mlBtnTapped ? Color("cellColor") : Color("Blue"))
                        .cornerRadius(10)
                })
            }
            .padding()
            
            HStack {
                Image("water-bottle")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipped()
                
                Button (action: {
                    water500mlBtnTapped.toggle()
                }, label: {
                    Text("1병 (500ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(water500mlBtnTapped ? Color("cellColor") : Color("Blue"))
                        .cornerRadius(10)
                })
            }
            .padding()
            
            HStack {
                Text("직접입력")
                    .font(.system(size: 14, weight: .semibold))
                
                Button (action: {
                }, label: {
                    Text("            |")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(Color("cellColor"))
                        .cornerRadius(10)
                })
                
                Text("ml")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding([.leading, .trailing, .bottom])
            
            Button(action: {
                self.isPresented = false
                if !water200mlBtnTapped {
                    viewModel.recordDayWater(dayWater: Water(amount: 200, date: DateConverter().todayDate))
                }
                if !water500mlBtnTapped {
                    viewModel.recordDayWater(dayWater: Water(amount: 500, date: DateConverter().todayDate))
                }
            }, label: {
                Text("Drink")
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
            })
        }
    }
}
