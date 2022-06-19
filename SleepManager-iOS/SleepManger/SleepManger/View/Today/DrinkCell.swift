//
//  DrinkCell.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI
import PartialSheet

struct DrinkCell: View {
    
    @State private var showDrinkModal = false
    @ObservedObject var viewModel: HistoryViewModel
    @ObservedObject var goalViewModel : ManageViewModel
    
    @State private var drinkedWater : Int = 8
    
    init(viewModel: HistoryViewModel, goalViewModel: ManageViewModel) {
        self.viewModel = viewModel
        self.goalViewModel = goalViewModel
    }
    
    func fetchData() {
        drinkedWater = 8 - amountOfAchievedDrinkGoal(totalAmount: viewModel.todayWaterRecord?.amount ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("empty-water")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipped()
                
                Text("Drink well")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("You drinked water \(viewModel.todayWaterRecord?.amount ?? 0)ml")
            }
            .padding()
            
            HStack {
                ForEach(0..<drinkedWater) { _ in
                    Button (action: {}, label: {
                        Image("water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipped()
                    })
                }
                
                ForEach(0..<(8-drinkedWater)) { _ in
                    Button (action: {
                        self.showDrinkModal = true
                    }, label: {
                        Image("empty-water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .partialSheet(isPresented: $showDrinkModal) {
                                ModalNewDrinkView(isPresented: self.$showDrinkModal, viewModel: viewModel)
                            }
                    })
                }
            }
            .padding(.bottom, 30)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .background(Color("cellColor"))
        .onAppear() {
            fetchData()
        }
    }
}
