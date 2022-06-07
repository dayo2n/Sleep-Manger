//
//  Time.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/31.
//

import Foundation

struct Sleep: Codable {
    var wakeUpTime: String // HH:MM 형식
    var bedTime: String // HH:MM
    var date: String
}

struct SleepGoal: Decodable {
    var goalBedTime: String // HH:MM
    var goalWakeUpTime: String // HH:MM 형식
    var weekendGoalBedTime: String // HH:MM
    var weekendGoalWakeUpTime: String // HH:MM 형식
}
