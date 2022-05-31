//
//  CustomTextField.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/30.
//
import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 40)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $text)
                    .disableAutocorrection(true)
            }
        }
    }
}
