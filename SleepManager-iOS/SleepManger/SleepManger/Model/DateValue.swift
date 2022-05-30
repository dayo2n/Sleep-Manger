//
//  DateValue.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

// Date Value Model

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
