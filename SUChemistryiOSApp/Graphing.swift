//
//  GraphingViewController.swift
//  
//

import UIKit
import Charts
import TinyConstraints

class GraphingViewController: UIViewController, ChartViewDelegate {
 
    lazy var lineChartView: LineChartView = {
           let chartView = LineChartView()
           chartView.backgroundColor = .systemBlue
           
           chartView.rightAxis.enabled = false
           
           let yAxis = chartView.leftAxis
           yAxis.labelFont = .boldSystemFont(ofSize: 12)
           yAxis.setLabelCount(6, force: false)
           yAxis.labelTextColor = .white
           yAxis.axisLineColor = .white
           yAxis.labelPosition = .outsideChart
           
           chartView.xAxis.labelPosition = .bottom
           chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
           chartView.xAxis.setLabelCount(6, force: false)
           chartView.xAxis.labelTextColor = .white
           chartView.xAxis.axisLineColor = .systemBlue
           
           chartView.animate(xAxisDuration: 2.5)
           
           return chartView
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           view.addSubview(lineChartView)
           lineChartView.centerInSuperview()
           lineChartView.width(to: view)
           lineChartView.heightToWidth(of: view)
           
           setData()

       }
       
       func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
           print(entry)
       }
       
       func setData() {
           let set1 = LineChartDataSet(entries: yValues, label: "Concentration")
           
           set1.mode = .cubicBezier
           set1.drawCirclesEnabled = false
           set1.lineWidth = 3
           set1.setColor(.white)
           //set1.fill = Fill(color: .white)
           set1.fillAlpha = 0.0
           set1.drawFilledEnabled = true
           
           set1.drawHorizontalHighlightIndicatorEnabled = false
           set1.highlightColor = .systemRed
           
           let data = LineChartData(dataSet: set1)
           data.setDrawValues(false)
           lineChartView.data = data
           
       }
       
       let yValues: [ChartDataEntry] = [
           ChartDataEntry(x: 0.1, y: 155),
           ChartDataEntry(x: 0.3, y: 176),
           ChartDataEntry(x: 0.4, y: 166)
       
       ]
       

   }
    
    /*
    //Create a line chart view
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
      //  chartView.xAxis.setAxisMaximum(1f)
      //  chartView.xAxis.setAxisMinimum(0f)
        
        let yAxis = chartView.leftAxis
       // yAxis.setAxisMaximum(1f)
       // yAxis.setAxisMinimum(0f)
        yAxis.labelPosition = .outsideChart
        
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Place graph in center of screen
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        //Update the data
        setData()
    }
    
    //Updates the graph contents
    func setData() {
        let set1 = LineChartDataSet(entries: getData(), label: "Beer's Law")
        
        set1.drawCirclesEnabled = true
        set1.lineWidth = 3
        
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }
    
    //Load the data from storage
    func getData() -> Array<ChartDataEntry> {
   //     let ans = []
    //    let sampleData = LOAD_DATA()
        
     //   for sample in sampleData {
     //       ans.append(ChartDataEntry(sample.concentrationValue, sample.absorbanceValue)
        }
        
     //   return ans;
    }
    
    //Test values
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 20.0),
        ChartDataEntry(x: 2.0, y: 30.0),
        ChartDataEntry(x: 3.0, y: 40.0),
        ChartDataEntry(x: 4.0, y: 50.0)
    ]
    
    
}
 
*/
