//
//  Extensions.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 7/9/22.
//

import Foundation

extension Date {
    func monthName() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
}
