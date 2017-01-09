//
//  DefecationsTableVC.swift
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

class DefecationsTableVC: UIViewController {

    // MARK: Global variables
    var reptile: Reptile!
    var accentColor: UIColor!
    var defecations = [Defecation]()
    
    
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
        self.title = "Defecations"
        
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
        
        // Get all the defecations
        defecations = reptile.defecations?.allObjects as! [Defecation]
        
        // Sort on date
        defecations.sort(by: { $0.date!.compare($1.date! as Date) == .orderedDescending })
        
        // Reload table
        tableView.reloadData()
    }
    
    
    
    // MARK: Core Data
    
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest: NSFetchRequest<Defecation> = Defecation.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            self.defecations = results
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func deleteDefecationWithUniqueID(_ id: NSNumber) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest<Defecation> = Defecation.fetchRequest()
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
        
        showErrorMessage("Delete successfull", body: "The defecation has been deleted.")
        
    }
    
}


// MARK: - Navigation
extension DefecationsTableVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewDefecationSegue" {
            if let nextVC = segue.destination as? AddNewDefecationVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                }
            }
        }
        
        if segue.identifier == "DisplayDetailsDefecationSegue" {
            if let nextVC = segue.destination as? DetailsDefecationVC {
                if let defecation_ = sender as? Defecation {
                    nextVC.defecation = defecation_
                    nextVC.backgroudImage = reptile.getImgHeader()
                    nextVC.accentColor = accentColor
                    nextVC.reptile = reptile
                }
            }
        }
    }
    
    @IBAction func addNewDefecationBtnClicked(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddNewDefecationSegue", sender: reptile)
    }
    
}


// MARK: - Table View Delegate and Data Source
extension DefecationsTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defecations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DisplayDetailsDefecationSegue", sender: defecations[(indexPath as NSIndexPath).row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as? OneLineCell {
            
            var content: String!
            if defecations[(indexPath as NSIndexPath).row].kindOfDefecation == DefecationKind.poop {
                content = "It was a doodoo."
            } else {
                content = "It was an urination."
            }
            
            var titleNote: String!
            if defecations[(indexPath as NSIndexPath).row].note == "" {
                titleNote = ""
            } else {
                titleNote = "✚"
            }
            
            cell.configureCell((defecations[(indexPath as NSIndexPath).row].date?.fullDate)!, boldTitle: false, TitleNote: titleNote, content: content, accentColor: accentColor.lighter(30)!)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}


// MARK: UI Gesture Recognizer Delegate
extension DefecationsTableVC : UIGestureRecognizerDelegate {
    
    func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.began {
            
            
            // Get the location of the clicked cell
            let p = gesture.location(in: self.tableView)
            let indexPath = self.tableView.indexPathForRow(at: p)
            
            
            // Create a alert controller - nshipster.com/uialertcontroller/
            
            let alertController = UIAlertController(title: "Delete defecation?", message: "Do you want to delete this defecation and all of its data?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            
            let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                
                // Delete here
                if let index = indexPath {
                    let defecation: Defecation = self.defecations[(index as NSIndexPath).row]
                    self.deleteDefecationWithUniqueID(defecation.uniqueID!)
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
extension DefecationsTableVC : DZNEmptyDataSetDelegate {
    
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
extension DefecationsTableVC : DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "snake_logo_gray")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title: String = "No defecations yet"
        let attributes: Dictionary = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18.0),
                                      NSForegroundColorAttributeName: UIColor.darkGray]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String = "All defecations will be shown here. Tapping an entry will give you more information. Long press an entry to delete it."
        
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
extension DefecationsTableVC {
    
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
