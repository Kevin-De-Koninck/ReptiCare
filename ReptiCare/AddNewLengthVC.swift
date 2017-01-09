//
//  AddNewLengthVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 20/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages

class AddNewLengthVC:  FormViewController{

    // MARK: Global variables
    var length: Length?
    var reptile: Reptile!
    
    // MARK: Interface Outlets
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var editExistingLength: Bool = false
    
    
    //MARK: UI View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add length entry"
        
        // Eureka form builder
        buildAddNewForm()
        
        // Disable save button (untill length has benn given)
        if editExistingLength == true {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if editExistingLength == false {
            //Create length object (global variable)
            createGlobalLengthObject()
            setValuesOfGlobalLengthObject(form.values())
            saveGlobalLengthObject()
            
            // Display a succes dialog
            showSuccessMessage("Success!", body: "The length entry has been added.")
        } else {
            setValuesOfGlobalLengthObject(form.values())
            editGlobalLengthObject()
            
            showSuccessMessage("Success!", body: "The length entry has been edited.")
            
        }
        
        // Pop the view (and go back)
        navigationController!.popViewController(animated: true)
        
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalLengthObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Length", in: context)!
        length = Length(entity: entity, insertInto: context)
    }
    
    func saveGlobalLengthObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let length_ = length {
            context.insert(length_)
            
            do {
                try context.save()
            } catch {
                print("Could not save length")
            }
        }
    }
    
    func editGlobalLengthObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest<Length> = Length.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", length!.uniqueID!)
        fetchRequest.predicate = predicate
        
        
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            fetchedEntities.first?.date = length?.date
            fetchedEntities.first?.length = length?.length
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
    
    func setValuesOfGlobalLengthObject(_ values: Dictionary<String, Any?>) {
        
        // Note
        if let length_ = values["length"] as? Double {
            length?.length = length_ as NSNumber?
        } else {
            length?.length = 0
        }
        
        // Date
        if let date = values["date"] as? Date {
            length?.date = date as NSDate?
        } else {
            length?.date = NSDate()
        }
        
        
        
        if editExistingLength == false {
            // Add unique ID
            length?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
            
            // Add relationship to reptile
            length?.reptile = self.reptile
        }
        
    }
    
}


// MARK: - EUREKA Form Builder
extension AddNewLengthVC {
    
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
            
            +++ Section("Length information")
            <<< DateRow("date"){ row in
                row.title = "Date"
                if editExistingLength == false {
                    row.value = Date()
                } else {
                    row.value = length?.date as Date?
                }
            }
            <<< DecimalRow("length"){ row in
                row.title = "Length"
                if editExistingLength == false {
                    row.placeholder = "cm"
                } else {
                    row.value = length?.length as? Double
                    
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
extension AddNewLengthVC {
    
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

