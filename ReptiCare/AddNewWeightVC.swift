//
//  AddNewWeightVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 19/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages

class AddNewWeightVC: FormViewController {

    // MARK: Global variables
    var weight: Weight?
    var reptile: Reptile!

    // MARK: Interface Outlets
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var editExistingWeight: Bool = false
    
    
    //MARK: UI View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add weight entry"
        
        // Eureka form builder
        buildAddNewForm()
        
        // Disable save button (untill weight has benn given)
        if editExistingWeight == true {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if editExistingWeight == false {
            //Create weight object (global variable)
            createGlobalWeightObject()
            setValuesOfGlobalWeightObject(form.values())
            saveGlobalWeightObject()
            
            // Display a succes dialog
            showSuccessMessage("Success!", body: "The weight entry has been added.")
        } else {
            setValuesOfGlobalWeightObject(form.values())
            editGlobalWeightObject()
            
            showSuccessMessage("Success!", body: "The weight entry has been edited.")
            
        }
        
        // Pop the view (and go back)
        navigationController!.popViewController(animated: true)
        
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalWeightObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Weight", in: context)!
        weight = Weight(entity: entity, insertInto: context)
    }
    
    func saveGlobalWeightObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let weight_ = weight {
            context.insert(weight_)
            
            do {
                try context.save()
            } catch {
                print("Could not save weight")
            }
        }
    }
    
    func editGlobalWeightObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest<Weight>  = Weight.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", weight!.uniqueID!)
        fetchRequest.predicate = predicate
        
        
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            fetchedEntities.first?.date = weight?.date
            fetchedEntities.first?.weight = weight?.weight
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        do {
            try context.save()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    
    
    // MARK: Form Data to Core Data
    
    func setValuesOfGlobalWeightObject(_ values: Dictionary<String, Any?>) {
        
        // Note
        if let weght_ = values["weight"] as? Double {
            weight?.weight = weght_ as NSNumber?
        } else {
            weight?.weight = 0
        }
        
        // Date
        if let date = values["date"] as? Date {
            weight?.date = date as NSDate?
        } else {
            weight?.date = Date() as NSDate?
        }
        
        
        
        if editExistingWeight == false {
            // Add unique ID
            weight?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
            
            // Add relationship to reptile
            weight?.reptile = self.reptile
        }
        
    }
    
}


// MARK: - EUREKA Form Builder
extension AddNewWeightVC {
    
    func buildAddNewForm(){
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 35
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        }
        
        form =
            Section("header"){ section in
                section.tag = "header"
                
                var header = HeaderFooterView<EurekaHeaderViewWithImages>(.class)
                header.height = {170}
                header.onSetupView = { view, _ in
                    
                    view.image = self.reptile.getImg()
                    view.imageHeader = self.reptile.getImgHeader()
                    view.backgroundColor = BACKGROUND_COLOR
                    view.update()
                }
                section.header = header
            }
            
            +++ Section("Weight information")
            <<< DateRow("date"){ row in
                row.title = "Date"
                if editExistingWeight == false {
                    row.value = Date()
                } else {
                    row.value = weight?.date as Date?
                }
                }
            <<< DecimalRow("weight"){ row in
                row.title = "Weight"
                if editExistingWeight == false {
                    row.placeholder = "kg"
                } else {
                    row.value = weight?.weight as? Double
                    
                }
                }.onChange{ row in
                    if row.value == nil {
                        self.saveBtn.isEnabled = false
                    } else {
                        self.saveBtn.isEnabled = true
                    }
                    
                }

        
    }
    
}

// MARK: - SWIFT MESSAGES
extension AddNewWeightVC {
    
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

