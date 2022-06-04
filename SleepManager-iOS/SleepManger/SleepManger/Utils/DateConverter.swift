//
//  DateConverter.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/04.
//

import Foundation

func Date2String(date: Date) -> [String] {
    var newGoals : [String] = [] // [new sleep goal time hour, min, new wake-up goal time hour, min]
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let splitOnlyTime = dateFormatter.string(from: date).split(separator: " ")
    let splitNewTime = splitOnlyTime[1].split(separator: ":")
    newGoals.append("\(splitNewTime[0])")
    newGoals.append("\(splitNewTime[1])")
    
    return newGoals
}

func TimeString2Date(date: String) -> Date {
    let splitTime = date.split(separator: ":")
    let stringTime = "2000-01-01 \(splitTime[0]):\(splitTime[1]):00"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    return dateFormatter.date(from: stringTime) ?? Date()
}
