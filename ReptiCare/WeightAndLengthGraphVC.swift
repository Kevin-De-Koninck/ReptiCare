//
//  WeightGraphVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 19/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Charts
import CoreData
import SwiftMessages

class WeightAndLengthGraphVC: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chartLbl: UILabel!
    @IBOutlet weak var chartTitleView: UIView!
    @IBOutlet weak var thinLine1: UIView!
    
    @IBOutlet weak var dataPointLblView: UIView!
    @IBOutlet weak var dataPointLbl: UILabel!
    @IBOutlet weak var thinLine2: UIView!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var selectedDataPointLbl: UILabel!
    
    var accentColor: UIColor!
    var reptile: Reptile!
    
    var toDisplay: String!
    
    var weights = [Weight]()
    var lengths = [Length]()
    
    var dates = [String]()
    var weightValues = [Double]()
    var lengthValues = [Double]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        chartView.delegate = self
        
        // Handle gui
        setGui()
        setChartViewOptions()
        if toDisplay == "weight" {
            self.title = "Weight"
        } else {
            self.title = "Length"
        }
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 4.0)

        // CoreData
        fetchAndSetResults()
        
        // Sort data
        if toDisplay == "weight" {
            weights.sort(by: { $0.date!.compare($1.date! as Date) == .orderedAscending })
        } else {
            lengths.sort(by: { $0.date!.compare($1.date! as Date) == .orderedAscending })
        }
        
        // Save array of dates and array of Values
        if toDisplay == "weight" {
            for weight in weights {
                dates.append("\(weight.date!.mediumDate)")
                weightValues.append(Double(weight.weight!))
            }
        } else {
            for length in lengths {
                dates.append("\(length.date!.mediumDate)")
                lengthValues.append(Double(length.length!))
            }
        }
        
        // Graph
        if toDisplay == "weight" {
            if weights.count > 0 {
                displayDataInChart()
            }
        } else {
            if lengths.count > 0 {
                displayDataInChart()
            }
        }
        
        print(lengthValues.debugDescription)
        
    }
    
    func setGui(){
        // Background
        background.image = reptile.getImgHeader()
        background.clipsToBounds = true
        
        // First container
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = containerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.70
        containerView.insertSubview(blurEffectView, at: 0)
        
        // Chartview
        chartView.backgroundColor = UIColor.clear

        // Thin lines
        thinLine1.backgroundColor = accentColor.lighter(30)!
        thinLine2.backgroundColor = thinLine1.backgroundColor
        
        // labels
        if toDisplay == "weight" {
            chartLbl.text = "Weights graph"
        } else {
            chartLbl.text = "Lengths graph"
        }
        dataPointLbl.text = "Selected data point"
        
        // 2nd container
        containerView2.layer.cornerRadius = 10
        containerView2.layer.masksToBounds = true
        containerView2.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        let blurEffect2 = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.frame = containerView2.bounds
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView2.alpha = 0.70

        containerView2.insertSubview(blurEffectView2, at: 0)
        
        // Title view
        chartTitleView.backgroundColor = UIColor.white
        dataPointLblView.backgroundColor = UIColor.white
        
        

    }
    
    func setChartViewOptions() {
        chartView.chartDescription?.text = "";
        if toDisplay == "weight" {
            chartView.noDataText = "Add weight entries to display a graph."
        } else {
            chartView.noDataText = "Add length entries to display a graph."
        }
        
        chartView.drawMarkers = true
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        
        chartView.leftAxis.drawLabelsEnabled = true
        chartView.leftAxis.labelPosition = .outsideChart
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.axisMinimum = 0
        
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        
        setChartXAxisGUIForSaving(false)
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelRotationAngle = 90*3
        
        chartView.gridBackgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
     }
    
    
    func setChartXAxisGUIForSaving(_ saving: Bool) {
        if saving == false {
            chartView.xAxis.drawLabelsEnabled = false
            chartView.xAxis.drawGridLinesEnabled = false
            chartView.xAxis.labelPosition = .bottom
            chartView.xAxis.labelRotationAngle = 90*3
        } else {
            chartView.xAxis.drawLabelsEnabled = true
            chartView.xAxis.drawGridLinesEnabled = true
            chartView.xAxis.labelPosition = .bottom
            chartView.xAxis.labelRotationAngle = 90*3
        }
        
        chartView.animate(xAxisDuration: 0, yAxisDuration: 0)
        //displayDataInChart()
    }
    
    // MARK: Core Data
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if toDisplay == "weight" {
            let fetchRequest: NSFetchRequest<Weight> = Weight.fetchRequest()
            
            do {
                let results = try context.fetch(fetchRequest)
                let temp = results
                self.weights = temp.filter() {$0.reptile == reptile}
            } catch let err as NSError {
                print(err.debugDescription)
            }
        } else {
            let fetchRequest: NSFetchRequest<Length> = Length.fetchRequest()
            
            do {
                let results = try context.fetch(fetchRequest)
                let temp = results
                self.lengths = temp.filter() {$0.reptile == reptile}
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        
    }


    // MARK: Graph
    func displayDataInChart() {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dates.count {
            let dataEntry: ChartDataEntry!
            if toDisplay == "weight" {
                dataEntry = ChartDataEntry(x: weightValues[i], y: Double(i))
            } else {
                dataEntry = ChartDataEntry(x: lengthValues[i], y: Double(i))
            }
            dataEntries.append(dataEntry)
        }
        
        var colors = [UIColor]()
        colors.append(accentColor)
        
        let lineChartDataSet: LineChartDataSet!
        if toDisplay == "weight" {
            lineChartDataSet = LineChartDataSet(values: dataEntries, label: "kg")
        } else {
            lineChartDataSet = LineChartDataSet(values: dataEntries, label: "cm")
        }
        lineChartDataSet.colors = colors
        lineChartDataSet.circleColors = colors
        lineChartDataSet.circleHoleColor = UIColor.clear
        lineChartDataSet.circleHoleRadius = 0
        lineChartDataSet.circleRadius = 5
        lineChartDataSet.lineWidth = 3
        lineChartDataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 0)!
  //      lineChartDataSet.entriesForXValue(dates)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        chartView.data = lineChartData
        
        
        chartView.reloadInputViews()
    }
    
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        if toDisplay == "weight" {
            selectedDataPointLbl.text = "\(entry.description) kg @ \(dates[dataSetIndex])"
        } else {
            selectedDataPointLbl.text = "\(entry.description ) cm @ \(dates[dataSetIndex])"

        }
    }
    
    
    @IBAction func saveChart(_ sender: UIBarButtonItem) {
        setChartXAxisGUIForSaving(true)
        displayDataInChart()
        
        UIImageWriteToSavedPhotosAlbum(chartView.getChartImage(transparent: true)! as UIImage, nil, nil, nil)
        
        setChartXAxisGUIForSaving(false)
        displayDataInChart()
        
        showSuccessMessage("Success!", body: "The graph has been saved to your camera roll.")

    }


}

// MARK: - SWIFT MESSAGES
extension WeightAndLengthGraphVC {
    
    func showSuccessMessage(_ title: String, body: String) {
        
        let view = MessageView.viewFromNib(layout: .CardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: title, body: body)
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        config.duration = .seconds(seconds: 3)
        
        SwiftMessages.show(config: config, view: view)
    }
    
}
