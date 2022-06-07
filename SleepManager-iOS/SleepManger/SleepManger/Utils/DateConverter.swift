//
//  DateConverter.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/04.
//

import Foundation

// Date 타입의 값을 "00:00"으로 이루어진 String 타입으로 리턴
func Date2String(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    let splitOnlyTime = dateFormatter.string(from: date).split(separator: " ")
    let splitNewTime = splitOnlyTime[1].split(separator: ":")
    
    return "\(splitNewTime[0]):\(splitNewTime[1])"
}

// "00:00" 형식의 문자열을 "2000년 1월 1일의 00:00:00"의 Date 타입으로 리턴
func TimeString2Date(date: String) -> Date {
    let splitTime = date.split(separator: ":")
    let stringTime = "2000-01-01 \(splitTime[0]):\(splitTime[1]):00"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    return dateFormatter.date(from: stringTime) ?? Date()
}

// Date 타입에서 "2000-01-01" 형식의 문자열로 리턴
func Date2OnlyDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    let splitOnlyDate = dateFormatter.string(from: date).split(separator: " ")
    
    return "\(splitOnlyDate[0])"
}
