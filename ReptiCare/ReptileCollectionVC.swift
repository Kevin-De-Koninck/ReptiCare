//
//  ReptileCollectionVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 08/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework
import DZNEmptyDataSet
import SwiftMessages

class ReptileCollectionVC: UIViewController {

    // MARK: Global variables
    var reptiles = [Reptile]()
    var successfullyAddedNewReptile: Bool = false
    
    // MARK: Interface Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //MARK: UI View Controller functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //UIViewController
        self.automaticallyAdjustsScrollViewInsets = false

        // Navigationcontroller
        self.title = "Collection"
        
        //CollectionView
        collectionView.backgroundColor = BACKGROUND_COLOR
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        // Add long press gesture to collectionview
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ReptileCollectionVC.handleLongPressGesture(_:)))
        longPressGesture.delegate = self
        self.collectionView.addGestureRecognizer(longPressGesture)

        //PageControl
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.flatGray()
        
        //DZNEmptyDataset
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
  
        // Observer - if we added a new reptile, then scroll to that new reptile
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveResponseGloballyFromAddNewReptileVC), name: NSNotification.Name(rawValue: "successfullyAddedNewReptile"), object: nil)
        
        // Fetch data
        fetchAndSetResults()
        collectionView.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {

        if successfullyAddedNewReptile == true {
            fetchAndSetResults()
            collectionView.reloadData()
            successfullyAddedNewReptile = false
            CollectionViewScrollToLastReptile()
        }
    }
    
    
    // MARK: Observer functions
    
    func saveResponseGloballyFromAddNewReptileVC() {
        successfullyAddedNewReptile = true
    }
    
    
    // MARK: Core Data
    
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest : NSFetchRequest<Reptile> = Reptile.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            self.reptiles = results
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func deleteReptileWithUniqueID(_ id: NSNumber) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest : NSFetchRequest<Reptile> = Reptile.fetchRequest()
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
        fetchAndSetResults()
        collectionView.reloadData()
        
        showErrorMessage("Delete successfull", body: "The reptile has been deleted.")
        
    }
    
    
    func deleteAllReptiles() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest: NSFetchRequest<Reptile>  =  Reptile.fetchRequest()
        
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
        fetchAndSetResults()
        collectionView.reloadData()
        
    }
    
    
    // MARK: temporary stuff
    //-------------------------------------------------------------------------------------------------------------------
    func createReptile(_ name_: String) {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Reptile", in: context)!
        
        let reptile = Reptile(entity: entity, insertInto: context)
        
        reptile.name = name_
        reptile.setImg(UIImage(named: "TEST")!)
        
        context.insert(reptile)
        
        do {
            try context.save()
        } catch {
            print("Could not save reptile")
        }
    }
    // -------------------------------------------------------------------------------------------------------------------

    
    
    
    
    // TODO: Add support for landscape mode

}

// MARK: - Navigation
extension ReptileCollectionVC {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoadReptileMenuSegue" {
            if let nextVC = segue.destination as? ReptileMenuVC {
                if let reptile = sender as? Reptile {
                    nextVC.reptile = reptile
                }
            }
        }
        
    }
}


// MARK: - COLLECTION VIEW
// MARK: Collection View Delegate
extension ReptileCollectionVC : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LoadReptileMenuSegue", sender: reptiles[(indexPath as NSIndexPath).row])
    }
    
    func CollectionViewScrollToLastReptile(){
        let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
        let lastItemIndex = IndexPath(item: item, section: 0)
        self.collectionView?.scrollToItem(at: lastItemIndex, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }

}

// MARK: Collection View Data Source
extension ReptileCollectionVC : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = reptiles.count
        return reptiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReptileCell", for: indexPath) as? ReptileCollectionCell {
            let reptile = reptiles[(indexPath as NSIndexPath).row]
            cell.configureCell(reptile)
            
            pageControl.currentPage = (indexPath as NSIndexPath).row
            
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }

}

// MARK: UI Gesture Recognizer Delegate
extension ReptileCollectionVC : UIGestureRecognizerDelegate {
    
    func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.began {
            
            
            // Get the location of the clicked cell
            let p = gesture.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: p)
            
            
            
            // Create a alert controller - nshipster.com/uialertcontroller/
            
            let alertController = UIAlertController(title: "Delete reptile?", message: "Do you want to delete this reptile and all of its data?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            
            // Create a second alert controller when the user wants to delete te reptile (confirmation)
            let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                
                let alertController2 = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                }
                alertController2.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "Yes, delete it!", style: .destructive) { (action) in
                    
                    // Delete reptile here
                    if let index = indexPath {
                        let reptile: Reptile = self.reptiles[(index as NSIndexPath).row]
                        self.deleteReptileWithUniqueID(reptile.uniqueID!)
                    } else {
                        print("Could not find index path")
                    }
                }
                alertController2.addAction(OKAction)
                
                self.present(alertController2, animated: true) {
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
extension ReptileCollectionVC : DZNEmptyDataSetDelegate {
    
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
        performSegue(withIdentifier: "AddNewReptileSegue", sender: nil)
    }
    
}

// MARK: DZN Empty Dataset Source
extension ReptileCollectionVC : DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "snake_logo_gray")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title: String = "No reptiles yet"
        let attributes: Dictionary = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18.0),
                                      NSForegroundColorAttributeName: UIColor.darkGray]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String = "Your collection of reptiles will be shown here. Tapping a reptile will give you access to all its caretaking info. Long press a reptile to delete it."
        
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
        
        return NSAttributedString(string: "Tap here to add one now!", attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return BACKGROUND_COLOR
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20.0
    }
    
}


// MARK: - SWIFT MESSAGES
extension ReptileCollectionVC {
    
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
