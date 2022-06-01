//
//  LoginView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/30.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color("bgColor")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Sleep Manager")
                        .font(.system(size: 50, weight: .heavy, design: .serif))
                        .foregroundColor(Color("fontColor"))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Sleep Management for busy modern people")
                        .font(.system(size: 15, weight: .semibold, design: .serif))
                        .foregroundColor(Color("fontColor"))
                        .padding(.top, 0.01)
                    
                    VStack {
                        CustomTextField(text: $email, placeholder: Text("E-mail"), imageName: "envelope")
                            .padding()
                            .cornerRadius(15)
                            .border(.gray)
                            .padding(.horizontal, 32)
                        
                        // sign in
                        Button(action: {
//                            viewModel.login(withEmail: email)
                        }, label: {
                            Text("Sign in")
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
                        
                        NavigationLink(destination: RegistrationView().navigationBarHidden(true), label: {
                            // go to sign in
                                HStack {
                                    Text("Don't have an account?")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    
                                    Text("Sign up")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                                .padding(.bottom, 16)
                        })
                    }
                    .padding(.top, 70)
                }
                .padding(.top)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
