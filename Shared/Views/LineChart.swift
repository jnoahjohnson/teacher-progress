//
//  LineChart.swift
//  Progress
//
//  Created by Noah Johnson on 5/2/22.
//

import UIKit
import SwiftUI
import Charts

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?
    
    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
              let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }
    
}


struct LineChart: UIViewControllerRepresentable {
    var vals: [TestScore]
    
    func makeUIViewController(context: Context) -> LineChartViewController {
        
        // Define the reference time interval
        var referenceTimeInterval: TimeInterval = 0
        if let minTimeInterval = (vals.map { $0.wrappedDate.timeIntervalSince1970 }).min() {
            referenceTimeInterval = minTimeInterval
        }


        // Define chart xValues formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current


        // Define chart entries
        var entries = [ChartDataEntry]()
        for object in vals {
            let timeInterval = object.wrappedDate.timeIntervalSince1970
            
            let xValue = (timeInterval - referenceTimeInterval) / (3600 * 24)
            print(xValue)
            let yValue = Double(object.score)
            let entry = ChartDataEntry(x: xValue, y: yValue)
            entries.append(entry)
        }
        
//                let chartVals = self.vals.enumerated().map { (index, element) -> ChartDataEntry in
//
//                    let entry = ChartDataEntry(x: Double(index), y: Double(element.score))
//
//
//                    return entry
//                }
        
        let lineChart = LineChartViewController(withData: entries, referenceTimeInterval: referenceTimeInterval)
        
        return lineChart
    }
    
    func updateUIViewController(_ uiViewController: LineChartViewController, context: Context) {
        
    }
    
}
