//
//  HistoryView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI
import PartialSheet
import SunburstDiagram

struct HistoryView: View {
    
    var historyDate: DateValue
    
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d."
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                
                HStack {
                    NavigationLink(destination: CalendarView(), label: {
                        Text("\(historyDate.date, formatter: self.dateformat)'s Routine")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color("fontColor"))
                            .padding([.leading, .bottom])
                    })
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
                    }
                    .padding()
                    
                    HStack {
                        let configuration = SunburstConfiguration(nodes: [
                            Node(name: "Walking", value: 10.0, backgroundColor: .systemBlue),
                            Node(name: "Restaurant", value: 30.0, backgroundColor: .systemRed, children: [
                                Node(name: "Dessert", image: UIImage(named: "croissant"), value: 6.0),
                                Node(name: "Dinner", image: UIImage(named: "poultry"), value: 10.0),
                            ]),
                            Node(name: "Transport", value: 10.0, backgroundColor: .systemPurple),
                            Node(name: "Home", value: 50.0, backgroundColor: .systemTeal),
                        ])

//                        SetSleepButton()
                        Button(action: {
                        }, label: {
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
    }
}
