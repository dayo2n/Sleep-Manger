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
                    print("drink half of a glass")
                }, label: {
                    Text("1/2잔 (100ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(Color("cellColor"))
                        .cornerRadius(10)
                })
                
                Button (action: {
                    print("drink a glass of water")
                }, label: {
                    Text("1잔 (200ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(Color("cellColor"))
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
                    print("drink half of a bottle")
                }, label: {
                    Text("1/2병 (250ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(Color("cellColor"))
                        .cornerRadius(10)
                })
                
                Button (action: {
                    print("drink a bottle of water")
                }, label: {
                    Text("1병 (500ml)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(height: 50)
                        .background(Color("cellColor"))
                        .cornerRadius(10)
                })
            }
            .padding([.leading, .trailing, .bottom])
            
            Button(action: {
                self.isPresented = false
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

struct ModalNewDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        ModalNewDrinkView(isPresented: .constant(true))
    }
}
