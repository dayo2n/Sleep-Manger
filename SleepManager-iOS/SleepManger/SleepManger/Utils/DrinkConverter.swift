//
//  DrinkConverter.swift
//  RoutineManger
//
//  Created by 문다 on 2022/06/19.
//

import Foundation

func amountOfAchievedDrinkGoal(totalAmount: Int) -> Int {
    if (totalAmount / 200) > 8 {
        return 8
    }
    return totalAmount / 200
}
