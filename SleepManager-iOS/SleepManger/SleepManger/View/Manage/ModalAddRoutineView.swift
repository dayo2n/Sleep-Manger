//
//  ModalAddRoutineView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/17.
//

import SwiftUI
import PartialSheet

struct ModalAddRoutineView: View {
    @Binding var isPresented: Bool
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    let categories : [String] = ["meal", "stretch", "massage",
                                 "meditation", "exercise", "brush teeth"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Routine")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding()
            
            LazyVGrid(columns: items, content: {
                ForEach(categories.indices, id: \.self) { idx in
                    Button(action: {}, label: {
                        VStack {
                            Image(categories[idx])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text(categories[idx])
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .light))
                                .padding(.bottom, 20)
                        }
                    })
                }
            })
            
            Button(action: {
                isPresented = false
                
            }, label: {
                Text("Done")
                    .foregroundColor(Color("fontColor"))
                    .frame(width: 300, height: 50)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
            })
        }
    }
}

struct ModalAddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        ModalAddRoutineView(isPresented: .constant(true))
    }
}
