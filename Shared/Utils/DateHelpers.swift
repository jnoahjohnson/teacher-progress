//
//  DateHelpers.swift
//  Progress (iOS)
//
//  Created by Noah Johnson on 7/29/22.
//
import Foundation

func getMonth(from inputDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    let monthString = dateFormatter.string(from: inputDate)
    return monthString
}
