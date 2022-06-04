//
//  SleepViewModel.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/02.
//

import SwiftUI
import Alamofire

class SleepViewModel: ObservableObject {
    @Published var daySleepRecord : Sleep?
    @Published var offsetSleepRecord = [Sleep]()
    let defaultTime : String = "00:00"
    
    // 특정일 수면 시간 기록
    func recordDaySleep(daySleep: Sleep) {
        let url = "http://3.39.141.189:8080/sleeps/day"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let params = ["id" : daySleep.id,
                      "bedTime" : daySleep.bedTime,
                      "wakeUpTime" : daySleep.wakeUpTime,
                      "date" : daySleep.date] as Dictionary

        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("✅ DEBUG: success to record day sleep")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    // 특정일 수면 시간 조회
    func queryDaySleep(date: String) { // date format: YYYY-MM-dd
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        var queryResult = Sleep(id: uid, wakeUpTime: defaultTime, bedTime: defaultTime, date: date)
        let url = "http://3.39.141.189:8080/sleeps/day?id=\(uid)&date=\(date)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                // {[23:00, 11:00]}
                switch response.result {
                case .success(let record) :
                    let json = record.data(using: .utf8)!
                    do {
                        let daySleep = try JSONDecoder().decode(Sleep.self, from: json)
                        
                        print("✅ DEBUG: \(daySleep.wakeUpTime) \(daySleep.bedTime)")
                        queryResult.bedTime = daySleep.bedTime
                        queryResult.wakeUpTime = daySleep.wakeUpTime
                        self.daySleepRecord = queryResult
                        
                    } catch (let error ) {
                        print("🚫 DEBUG: \(error.localizedDescription)")
                    }
                case .failure :
                    print("🚫 DEBUG: \(response)")
            }
        }
    }
    
    // 특정 기간 수면 시간 조회
    func getSleepHistory(date: String, offset: Int) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        var queryResult = Sleep(id: uid, wakeUpTime: defaultTime, bedTime: defaultTime, date: date)
        let url = "http://3.39.141.189:8080/sleeps/day?id=\(uid)&date=\(date)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseString { (response) in
                switch response.result {
                case .success(let record) :
                    let json = record.data(using: .utf8)!
                    for data in json {
                        do {
                            
                            // 배열로 받은 결과데이터 배열에 추가할 수 있도록
//                            let daySleep = try JSONDecoder().decode(Sleep.self, from: data)
                            
//                            print("✅ DEBUG: \(daySleep.wakeUpTime) \(daySleep.bedTime)")
                            
                        } catch (let error ) {
                            print("🚫 DEBUG: \(error.localizedDescription)")
                        }
                    }
                    
                case .failure :
                    print("🚫 DEBUG: \(response)")
            }
        }
    }
}
