//
//  LineChartViewController.swift
//  Progress
//
//  Created by Noah Johnson on 5/2/22.
//

//
//  ScatterChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif
import Charts
import SwiftUI

class LineChartViewController: ChartBaseViewController {
    
    var chartView: LineChartView!
    var chartData: [ChartDataEntry]
    var referenceTimeInterval: TimeInterval = 0
    
    init(withData data: [ChartDataEntry], referenceTimeInterval: TimeInterval) {
        self.chartData = data
        self.referenceTimeInterval = referenceTimeInterval
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: myView.bottomAnchor, multiplier: 1.0)
        ])
        
        self.chartView = LineChartView()
        
        // Do any additional setup after loading the view.
        chartView.drawGridBackgroundEnabled = false
    
        
        chartView.drawBordersEnabled = false
        
        chartView.chartDescription?.enabled = false
        
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.legend.enabled = false
        
        let leftAxis = self.chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = 0
        
        self.chartView.rightAxis.enabled = false
        
        
        let xAxis = self.chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        
        xAxis.labelPosition = .bottom
        
        let xValuesFormatter = DateFormatter()
            xValuesFormatter.dateFormat = "MM/dd"
        
        let minTimeInterval = (chartData.map { $0.x }).min() ?? 0
        print(minTimeInterval)
        
        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: 1651979683.7949, dateFormatter: xValuesFormatter)
            xAxis.valueFormatter = xValuesNumberFormatter
        
        self.chartView.leftAxis.drawGridLinesEnabled = false
        
        self.setData()
        
        myView.addSubview(self.chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.chartView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            self.chartView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            self.chartView.widthAnchor.constraint(equalTo: myView.widthAnchor),
            self.chartView.heightAnchor.constraint(equalTo: myView.heightAnchor)
        ])
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: self.chartData, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(Color.primary))
        set1.drawCirclesEnabled = true
        set1.circleHoleColor = UIColor(Color.primary)
        set1.circleRadius = 8.0
        set1.circleColors = [UIColor(Color.primary)]
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 1
        set1.drawValuesEnabled = true
        set1.drawFilledEnabled = true
        set1.drawCircleHoleEnabled = false
        
        set1.fillColor = UIColor(Color.secondary)
        
//        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
//            return CGFloat(self.chartView.leftAxis.axisMinimum)
//        }
        
        set1.valueFont = NSUIFont.systemFont(ofSize: 14.0)
        set1.valueColors = [UIColor(Color.primary)]
       
        
        let data = LineChartData(dataSets: [set1])
        let customVF = CustomVF()
        customVF.maxValue = 200.0
        data.setValueFormatter(customVF)
        data.setDrawValues(true)
        
        self.chartView.data = data
    }
}


class CustomVF : IValueFormatter {
    var maxValue : Double = 1
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(Int(value))"
    }
}

