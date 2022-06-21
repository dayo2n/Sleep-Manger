//
//  AuthViewModel.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/01.
//

import SwiftUI
import Alamofire

class AuthViewModel: ObservableObject {
    
    @Published var userSession: User?
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = self.currentUser
        // makes a API call to the firebase server
        // If there is no login information, userSession would be 'nil'
        fetchUser()
    }
    
    
    func login(withEmail email: String) {
        let url = "\(Storage().SERVER_URL)/members/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["email": email] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success (let userInfo):
                let json = userInfo.data(using: .utf8)!
                do {
                    let user = try JSONDecoder().decode(User.self, from: json)
                    
                    print("✅ DEBUG: \(user.id) \(user.email)")
                    self.userSession = User(id: user.id, email: user.email)
                    self.fetchUser()
                } catch (let error ) {
                    print("🚫 DEBUG: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func register(withEmail email: String) {
        let url = "\(Storage().SERVER_URL)/members"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["email": email] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success (let userInfo):
                let json = userInfo.data(using: .utf8)!
                do {
                    let user = try JSONDecoder().decode(User.self, from: json)
                    
                    print("✅ DEBUG: \(user.id) \(user.email)")
                    self.userSession = User(id: user.id, email: user.email)
                    self.fetchUser()
                } catch (let error ) {
                    print("🚫 DEBUG: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func signout() {
        self.userSession = nil
    }

    func fetchUser() {
        guard let uid = userSession?.id else { return }
        print("DEBUG: uid \(uid)")
    }
}
