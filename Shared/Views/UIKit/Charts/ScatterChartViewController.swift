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

class ScatterChartViewController: ChartBaseViewController {
    
    var chartView: ScatterChartView!
    var initialData: ScatterChartData
    
    init(withData data: ScatterChartData) {
        self.initialData = data
        
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
        
        self.chartView = ScatterChartView()
        
        // Do any additional setup after loading the view.
        self.title = "Scatter Chart"
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        self.chartView.delegate = self
        
        self.chartView.chartDescription?.enabled = false
        
        self.chartView.dragEnabled = true
        self.chartView.setScaleEnabled(true)
        self.chartView.maxVisibleCount = 200
        self.chartView.pinchZoomEnabled = true
        
        let l = self.chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xOffset = 5
        
        let leftAxis = self.chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = 0
        
        self.chartView.rightAxis.enabled = false
        
        
        let xAxis = self.chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        
        self.chartView.data = initialData
        
        myView.addSubview(self.chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.chartView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            self.chartView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            self.chartView.widthAnchor.constraint(equalToConstant: 320),
            self.chartView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
}
