//
//  History.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/04.
//

import Foundation

struct History: Decodable {
    var date: String
    var achievedSleep: Bool
    var achievedDrinkWater: Bool
    var achievedCoffee: Bool
}
