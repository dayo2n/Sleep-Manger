//
//  HeaderView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/16.
//

import SwiftUI

struct HeaderView: View {
    
    let user: User
    @ObservedObject var viewModel: HeaderViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = HeaderViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("astronaut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .padding()
                
                Text("Hi, [\(viewModel.user.email)]")
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
                
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}
