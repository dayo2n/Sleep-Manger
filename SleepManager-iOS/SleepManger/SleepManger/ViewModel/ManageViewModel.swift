//
//  ManageViewModel.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/03.
//

import SwiftUI
import Alamofire

class ManageViewModel: ObservableObject {
    
    let defaultTime : String = "00:00"
    @Published var waterGoal : WaterGoal
    @Published var sleepGoal : SleepGoal
    
    init() {
//        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        self.waterGoal = WaterGoal(uid: 1, drinkGoalTimes: [String]())
        self.sleepGoal = SleepGoal(goalBedTime: defaultTime, goalWakeUpTime: defaultTime, weekendGoalBedTime: defaultTime, weekendGoalWakeUpTime: defaultTime)
        getWaterGoal()
        getSleepGoal()
    }
    
    // 목표 취침, 기상 시간 조회
    func getSleepGoal() {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/sleeps/goals?id=\(uid)"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let info) :
                        let json = info.data(using: .utf8)!
                        do {
                            let goal = try JSONDecoder().decode(SleepGoal.self, from: json)
                            
                            print("✅ DEBUG on getSleepGoal(): \(response.result)")
                            self.sleepGoal = SleepGoal(goalBedTime: goal.goalBedTime, goalWakeUpTime: goal.goalWakeUpTime, weekendGoalBedTime: (goal.weekendGoalBedTime == self.defaultTime) ? goal.goalBedTime : goal.weekendGoalBedTime, weekendGoalWakeUpTime: (goal.weekendGoalWakeUpTime == self.defaultTime) ? goal.goalWakeUpTime : goal.weekendGoalWakeUpTime)
                        } catch (let error) {
                            print("⚠️ DEBUG on getSleepGoal(): Maybe this user has no data \(error.localizedDescription)")
                        }
                    case .failure :
                        print("🚫 DEBUG on getSleepGoal(): \(response)")
            }
        }
    }

    // 목표 취침, 기상 시간 설정 및 수정
    func setSleepGoal(newSleepGoal: SleepGoal) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/sleeps/goals"
        let params: Parameters = ["id": uid,
                                  "goalBedTime" : newSleepGoal.goalBedTime ,
                                  "goalWakeUpTime" : newSleepGoal.goalWakeUpTime,
                                  "weekendGoalBedTime" : newSleepGoal.weekendGoalBedTime,
                                  "weekendGoalWakeUpTime" : newSleepGoal.weekendGoalWakeUpTime] as Dictionary
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                switch response.result {
                case .success :
                    print("✅ DEBUG on setSleepGoal(): \(params)")
                case .failure :
                    print("🚫 DEBUG on setSleepGoal(): \(params)")
            }
        }
    }
    
    // 목표 수분 섭취 시간 조회
    func getWaterGoal() {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/drinks/times?id=\(uid)"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseString { (response) in
                    switch response.result {
                    case .success(let info) :
                        print(info)
                        let json = info.data(using: .utf8)!
                        do {
                            let goal = try JSONDecoder().decode(WaterGoal.self, from: json)
                            
                            print("✅ DEBUG on getWaterGoal(): \(response.result)")
                            self.waterGoal = WaterGoal(uid: uid, drinkGoalTimes: goal.drinkGoalTimes)
                        } catch (let error) {
                            print("⚠️ DEBUG on getWaterGoal(): Maybe this user has no data \(error.localizedDescription)")
                        }
                    case .failure :
                        print("🚫 DEBUG on getWaterGoal(): \(response)")
            }
        }
    }

    // (초기 설정) 목표 취침, 기상 시간 설정
    func setInitialWaterGoal(newWaterGoal : WaterGoal) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/drinks/times"
        let params: Parameters = ["id": uid,
                                  "drinkNotificationTimes" : newWaterGoal.drinkGoalTimes] as Dictionary
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                switch response.result {
                case .success(let info) :
                    let json = info.data(using: .utf8)!
                    do {
                        let goal = try JSONDecoder().decode(WaterGoal.self, from: json)
                        
                        print("✅ DEBUG on setWaterGoal(): \(response.result)")
                        self.waterGoal = WaterGoal(uid: uid, drinkGoalTimes: goal.drinkGoalTimes)
                    } catch (let error) {
                        print("⚠️ DEBUG on setWaterGoal(): Maybe this user has no data \(error.localizedDescription)")
                        
            }
                case .failure :
                print("🚫 DEBUG on setInitialWaterGoal(): \(params)")
            }
        }
    }

    // (이후 수정) 목표 취침, 기상 시간 수정
    func setWaterGoal(newWaterGoal : WaterGoal) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/drinks/times"
        let params: Parameters = ["id": uid,
                                  "drinkNotificationTimes" : newWaterGoal.drinkGoalTimes] as Dictionary
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                switch response.result {
                case .success(let info) :
                    let json = info.data(using: .utf8)!
                    do {
                        let goal = try JSONDecoder().decode(WaterGoal.self, from: json)
                        
                        print("✅ DEBUG on setWaterGoal(): \(response.result)")
                        self.waterGoal = WaterGoal(uid: uid, drinkGoalTimes: goal.drinkGoalTimes)
                    } catch (let error) {
                        print("⚠️ DEBUG on setWaterGoal(): Maybe this user has no data \(error.localizedDescription)")
                    }
                case .failure :
                    print("🚫 DEBUG on setWaterGoal(): \(params)")
            }
        }
    }
}
