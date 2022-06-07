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
            }
            .padding()
            
            HStack {
                ForEach(0 ..< 5) { _ in
                    Button (action: {}, label: {
                        Image("water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .shadow(radius: 5)
                            .clipped()
                    })
                }
                
                ForEach(0 ..< 2) { _ in
                    Button (action: {
                        self.showDrinkModal = true
                    }, label: {
                        Image("empty-water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .shadow(radius: 5)
                            .clipped()
                            .partialSheet(isPresented: $showDrinkModal) {
                                ModalNewDrinkView(isPresented: self.$showDrinkModal)
                            }
                    })
                }
            }
            .padding(.bottom, 30)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .background(Color("cellColor"))
    }
}

struct DrinkCell_Previews: PreviewProvider {
    static var previews: some View {
        DrinkCell()
    }
}
