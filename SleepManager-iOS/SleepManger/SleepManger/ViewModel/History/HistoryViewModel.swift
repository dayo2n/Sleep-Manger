//
//  SleepViewModel.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/02.
//

import SwiftUI
import Alamofire

class HistoryViewModel: ObservableObject {
    // 오늘 수면기록 정보
    @Published var daySleepRecord : Sleep?
    // 한달 수면 기록 정보
    @Published var offsetSleepRecord = [Sleep]()
    let defaultTime : String = "00:00"
    
    // 특정일 수면 시간 기록
    func recordDaySleep(daySleep: Sleep) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        let url = "\(Storage().SERVER_URL)/sleeps/day"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let params = ["id" : uid,
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
                print("✅ DEBUG: success to record day sleep \(params)")
            case .failure(let error):
                print("🚫 DEBUG on recordDaySleep(): Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    // 특정일 수면 시간 조회
    // 해당일자에 기록이 nil인 경우 예외처리 필요 
    func queryDaySleep(date: String) { // date format: YYYY-MM-dd
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        let url = "\(Storage().SERVER_URL)/sleeps/day?id=\(uid)&date=\(date)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<600)
            .responseString { (response) in
                // {[23:00, 11:00]}
                switch response.result {
                case .success(let record) :
                    let json = record.data(using: .utf8)!
                    do {
                        let daySleep = try JSONDecoder().decode(Sleep.self, from: json)
                        
                        print("✅ DEBUG on queryDaySleep(): \(date)'s sleep \(daySleep.bedTime) | wake-up \(daySleep.wakeUpTime)")
                        self.daySleepRecord = Sleep(wakeUpTime: daySleep.wakeUpTime, bedTime: daySleep.bedTime, date: date)
                        
                    } catch (let error ) {
                        // 데이터가 없으면 default 00:00임
                        self.daySleepRecord = Sleep(wakeUpTime: nil, bedTime: nil, date: date)
                        print("⚠️ DEBUG on queryDaySleep(): \(error.localizedDescription)")
                    }
                case .failure :
                    print("🚫 DEBUG on queryDaySleep(): \(response)")
            }
        }
    }
    
    // 특정 기간 수면 시간 조회
    func queryWeekSleep(date: String, offset: Int) {
        guard let uid = AuthViewModel.shared.userSession?.id else { return }
        
        var queryResult = Sleep(wakeUpTime: defaultTime, bedTime: defaultTime, date: date)
        let url = "\(Storage().SERVER_URL)/sleeps/period?id=\(uid)&date=\(date)&offset=\(offset)"
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
                    print(record)
                    do {
                        // 배열로 받은 결과데이터 배열에 추가할 수 있도록
                        let bundleData = try JSONDecoder().decode([Sleep].self, from: json)
                        for singleData in bundleData {
                            self.offsetSleepRecord.append(Sleep(wakeUpTime: singleData.wakeUpTime, bedTime: singleData.bedTime, date: singleData.date))
                        }
                        print("✅ DEBUG on queryWeekSleep(): \(bundleData)")
                        
                    } catch (let error ) {
                        print("🚫 DEBUG on queryWeekSleep(): \(error.localizedDescription)")
                    }
                    
                case .failure :
                    print("🚫 DEBUG on queryWeekSleep(): \(response)")
            }
        }
    }
}
