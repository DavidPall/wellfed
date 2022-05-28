//
//  Date+Extensions.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import Foundation

extension Date {
    var reservedUntil: Date {
        let time = self.addingTimeInterval(60 * 30)
        return time
    }
}
