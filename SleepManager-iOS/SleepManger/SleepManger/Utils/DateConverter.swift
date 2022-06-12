//
//  DateConverter.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/04.
//

import Foundation

struct DateConverter {
    let todayDate : String = Date2OnlyDate(date: Date())
}

// Date 타입의 값을 "00:00"으로 이루어진 String 타입으로 리턴
func Date2TimeString(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    let splitOnlyTime = dateFormatter.string(from: date).split(separator: " ")
    let splitNewTime = splitOnlyTime[1].split(separator: ":")
    
    return "\(splitNewTime[0]):\(splitNewTime[1])"
}

// "00:00" 형식의 문자열을 "2000년 1월 1일의 00:00:00"의 Date 타입으로 리턴
func TimeString2Date(time: String) -> Date {
    let splitTime = time.split(separator: ":")
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

// 두 시각의 차이를 리턴
// from 21:30, to 08:20 -> 10:50
// from 21:10, to 08:20 -> 11:10
func getTimeDiff(from: String, to: String) -> String {
    let splitFrom = from.split(separator: ":")
    let fromHour = Int(splitFrom[0])!
    let fromMin = Int(splitFrom[1])!
    
    let splitTo = to.split(separator: ":")
    let toHour = Int(splitTo[0])!
    let toMin = Int(splitTo[1])!
    
    var retHour : Int
    var retMin : Int
    if fromHour > toHour {
        retHour = 24 - fromHour + toHour
    } else {
        retHour = toHour - fromHour
    }
    
    if fromMin > toMin {
        retMin = 60 - fromMin + toMin
        retHour -= 1
    } else {
        retMin = toMin - fromMin
    }
    
    if retHour < 10 {
        if retMin < 10 {
            return "0\(retHour):0\(retMin)"
        } else {
            return "0\(retHour):\(retMin)"
        }
    }
    if retMin < 10 {
        return "\(retHour):0\(retMin)"
    }
    
    return "\(retHour):\(retMin)"
}

// 00:00 형식의 두시간의 대소비교를 부울형으로 리턴
// isLonger 파라미터가 더 긴 시간이면 true를 반환
func compareTimes(isLonger: String, isShorter: String) -> Bool {
    let longer = isLonger.split(separator: ":")
    let longerHour = Int(longer[0])!
    let longerMin = Int(longer[1])!
    
    let shorter = isShorter.split(separator: ":")
    let shorterHour = Int(shorter[0])!
    let shorterMin = Int(shorter[1])!
    
    if longerHour > shorterHour {
        return true
    } else if longerHour < shorterHour {
        return false
    } else { // longerHour == shorterHour
        if longerMin >= shorterMin {
            return true
        } else if longerMin < shorterMin {
            return false
        }
    }
    return true // default?
}
