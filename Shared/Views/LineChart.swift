//
//  LineChart.swift
//  Progress
//
//  Created by Noah Johnson on 5/2/22.
//

import UIKit
import SwiftUI
import Charts


struct LineChart: UIViewControllerRepresentable {
    var vals: [TestScore]
    
    func makeUIViewController(context: Context) -> LineChartViewController {
        
        let chartVals = self.vals.enumerated().map { (index, element) -> ChartDataEntry in
            
            let entry = ChartDataEntry(x: Double(index), y: Double(element.score))
            
        
            return entry
        }
        
        let lineChart = LineChartViewController(withData: chartVals)
        
        return lineChart
    }
    
    func updateUIViewController(_ uiViewController: LineChartViewController, context: Context) {
        
    }
    
}
