//
//  WeightsTableVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 19/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import ChameleonFramework
import CoreData
import SwiftMessages
import DZNEmptyDataSet

class WeightsTableVC: UIViewController {

    // MARK: Global variables
    var reptile: Reptile!
    var accentColor: UIColor!
    var weights = [Weight]()
    
    
    // MARK: Interface outlets
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    // MARK: View functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tableview
        tableView.dataSource = self
        tableView.delegate = self
        
        //DZNEmptyDataset
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        // Navigationcontroller
        self.title = "Weights"
        
        // Background
        background.image = reptile.getImgHeader()
        background.clipsToBounds = true
        
        // Add long press gesture to collectionview
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ReptileCollectionVC.handleLongPressGesture(_:)))
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
        // Register reusable cells
        tableView.register(UINib(nibName: "OneLineCell", bundle: nil), forCellReuseIdentifier: "oneLineCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Core Data
        fetchAndSetResults()
        
        // Get all the weights
        weights = reptile.weights?.allObjects as! [Weight]
        
        // Sort on date
        weights.sort(by: { $0.date!.compare($1.date! as Date) == .orderedDescending })
        
        // Reload table
        tableView.reloadData()
    }
    
    
    
    // MARK: Core Data
    
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest: NSFetchRequest<Weight>  = Weight.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            self.weights = results
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func deleteWeightWithUniqueID(_ id: NSNumber) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest<Weight> = Weight.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for object in results {
                context.delete(object)
                try context.save()
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // Clean reload
        viewWillAppear(true)
        
        showErrorMessage("Delete successfull", body: "The weight entry has been deleted.")
        
    }
    
}


// MARK: - Navigation
extension WeightsTableVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewWeightSegue" {
            if let nextVC = segue.destination as? AddNewWeightVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.editExistingWeight = false
                }
            }
        }
        
        if segue.identifier == "EditWeightSegue" {
            if let nextVC = segue.destination as? AddNewWeightVC {
                if let weight_ = sender as? Weight {
                    nextVC.reptile = reptile
                    nextVC.weight = weight_
                    nextVC.editExistingWeight = true
                }
            }
        }
        
        if segue.identifier == "showGraphSegue" {
            if let nextVC = segue.destination as? WeightAndLengthGraphVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = accentColor
                    nextVC.toDisplay = "weight"
                }
            }
        }
}
    
    @IBAction func addNewWeightBtnClicked(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddNewWeightSegue", sender: reptile)
    }
    
    @IBAction func graphBtnClicked(_ sender: AnyObject) {
        performSegue(withIdentifier: "showGraphSegue", sender: reptile)
    }
    
    
}


// MARK: - Table View Delegate and Data Source
extension WeightsTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weights.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegueWithIdentifier("DisplayDetailsWeightSegue", sender: weights[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as? OneLineCell {
            
            let content = "\(weights[(indexPath as NSIndexPath).row].weight!) kg"
            cell.configureCell((weights[(indexPath as NSIndexPath).row].date?.fullDate)!, boldTitle: false, TitleNote: "", content: content, accentColor: accentColor.lighter(30)!)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}


// MARK: UI Gesture Recognizer Delegate
extension WeightsTableVC : UIGestureRecognizerDelegate {
    
    func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.began {
            
            
            // Get the location of the clicked cell
            let p = gesture.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: p)
            
            
            // Create a alert controller - nshipster.com/uialertcontroller/
            
            let alertController = UIAlertController(title: "Delete weight entry?", message: "Do you want to delete this weight entry and all of its data?", preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
                
                // Delete here
                if let index = indexPath {
                    let weight: Weight = self.weights[(index as NSIndexPath).row]
                    self.performSegue(withIdentifier: "EditWeightSegue", sender: weight)
                    
                } else {
                    print("Could not find index path")
                }
            }
            alertController.addAction(editAction)

            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            
            
            let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                
                // Delete here
                if let index = indexPath {
                    let weight: Weight = self.weights[(index as NSIndexPath).row]
                    self.deleteWeightWithUniqueID(weight.uniqueID!)
                } else {
                    print("Could not find index path")
                }
            }
            alertController.addAction(destroyAction)
            
            self.present(alertController, animated: true) {
            }
            
        }
    }
    
}


// MARK: - DZN EMPTY DATASET
// MARK: DZN Empty Dataset Delegate
extension WeightsTableVC : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
    }
    
}

// MARK: DZN Empty Dataset Source
extension WeightsTableVC : DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "snake_logo_gray")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title: String = "No weight entries yet"
        let attributes: Dictionary = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18.0),
                                      NSForegroundColorAttributeName: UIColor.darkGray]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String = "All weight entries will be shown here. Tapping an entry will give you more information. Long press an entry to delete it."
        
        let parargraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        parargraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        parargraph.alignment = NSTextAlignment.center
        
        let attributes: Dictionary = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0),
                                      NSForegroundColorAttributeName: UIColor.lightGray,
                                      NSParagraphStyleAttributeName: parargraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let attributes: Dictionary = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                                      NSForegroundColorAttributeName: UIColor.gray]
        
        return NSAttributedString(string: "", attributes: attributes)
    }
    
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return BACKGROUND_COLOR
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20.0
    }
    
}


// MARK: - SWIFT MESSAGES
extension WeightsTableVC {
    
    func showErrorMessage(_ title: String, body: String) {
        
        let view = MessageView.viewFromNib(layout: .CardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        let iconStyle: IconStyle = .default
        let iconImage = iconStyle.image(theme: .success)
        view.configureContent(title: title, body: body, iconImage:  iconImage)
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        config.duration = .seconds(seconds: 3)
        
        SwiftMessages.show(config: config, view: view)
    }
    
}
