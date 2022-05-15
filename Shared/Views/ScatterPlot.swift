//
//  ScatterPlot.swift
//  Progress
//
//  Created by Noah Johnson on 4/16/22.
//

import UIKit
import SwiftUI
import Charts


struct ScatterPlot: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ScatterChartViewController {
        let values1 = (0..<3).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(4) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let values2 = (0..<3).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(4) + 3)
            return ChartDataEntry(x: Double(i) + 0.33, y: val)
        }
        let values3 = (0..<3).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(4) + 3)
            return ChartDataEntry(x: Double(i) + 0.66, y: val)
        }
        
        
        let set1 = ScatterChartDataSet(entries: values1, label: "DS 1")
        set1.setScatterShape(.square)
        set1.setColor(ChartColorTemplates.colorful()[0])
        set1.scatterShapeSize = 8
        
        let set2 = ScatterChartDataSet(entries: values2, label: "DS 2")
        set2.setScatterShape(.circle)
        set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
        set2.scatterShapeHoleRadius = 3.5
        set2.setColor(ChartColorTemplates.colorful()[1])
        set2.scatterShapeSize = 8
        
        let set3 = ScatterChartDataSet(entries: values3, label: "DS 3")
        set3.setScatterShape(.cross)
        set3.setColor(ChartColorTemplates.colorful()[2])
        set3.scatterShapeSize = 8
        
        let data = ScatterChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        
        let scatterChart = ScatterChartViewController(withData: data)
        
        return scatterChart
    }
    
    func updateUIViewController(_ uiViewController: ScatterChartViewController, context: Context) {

    }
    
}
