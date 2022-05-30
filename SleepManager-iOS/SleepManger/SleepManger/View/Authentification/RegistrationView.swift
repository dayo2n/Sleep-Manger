//
//  RegistrationView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/30.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var uid = ""
    @State private var username = ""
    
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("bgColor")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Sleep Manager")
                    .font(.system(size: 50, weight: .heavy, design: .serif))
                    .foregroundColor(Color("fontColor"))
                
                Text("Sleep Management for busy modern people")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color("fontColor"))
                    .padding(.top, 1)
                
                VStack {
                    CustomTextField(text: $username, placeholder: Text("ID"), imageName: "highlighter")
                        .padding()
                        .cornerRadius(15)
                        .border(.gray)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 32)
                    
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .cornerRadius(15)
                        .border(.gray)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 32)
                    
                    
                    // sign up
                    Button(action: {}, label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color(#colorLiteral(red: 0.2995094895, green: 0.252843529, blue: 0.9, alpha: 0.8)))
                        // frame 크기를 설정한 후에 배경 색을 지정해야 사이즈맞게 적용된다.
                            .clipShape(Capsule())
                        // 마찬가지로 클립쉐이프도 배경색이 지정된 후에 짤라주어야 한다.
                            .padding()
                    })
                    
                    
                    Spacer()
                    
                    Button(action: {mode.wrappedValue.dismiss()}, label: {
                        // go to sign in
                            HStack {
                                Text("Already have an account?")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                
                                Text("Sign In")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 16)
                    })
                }
                .padding(.top, 100)
            }
            .padding(.top, 110)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
