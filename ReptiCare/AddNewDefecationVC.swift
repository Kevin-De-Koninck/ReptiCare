//
//  AddNewDefecationVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 19/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages

class AddNewDefecationVC: FormViewController {

    // MARK: Global variables
    var defecation: Defecation?
    var reptile: Reptile!
    
    var editExistingDefecation: Bool = false
    
    
    //MARK: UI View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add defecation"
        
        // Eureka form builder
        buildAddNewReptileForm()
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if editExistingDefecation == false {
            //Create defecation object (global variable)
            createGlobalDefecationObject()
            setValuesOfGlobalDefecationObject(form.values())
            saveGlobalDefecationObject()
            
            // Display a succes dialog
            showSuccessMessage("Success!", body: "The defecation has been added.")
        } else {
            setValuesOfGlobalDefecationObject(form.values())
            editGlobalDefecationObject()
            
            showSuccessMessage("Success!", body: "The defecation has been Edited.")
            
        }
        
        // Pop the view (and go back)
        navigationController!.popViewController(animated: true)
        
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalDefecationObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Defecation", in: context)!
        defecation = Defecation(entity: entity, insertInto: context)
    }
    
    func saveGlobalDefecationObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let defecation_ = defecation {
            context.insert(defecation_)
            
            do {
                try context.save()
            } catch {
                print("Could not save reptile")
            }
        }
    }
    
    func editGlobalDefecationObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest : NSFetchRequest<Defecation> = Defecation.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", defecation!.uniqueID!)
        fetchRequest.predicate = predicate
        
        
        do {
            let fetchedEntities = try context.fetch(fetchRequest) 
            fetchedEntities.first?.date = defecation?.date
            fetchedEntities.first?.note = defecation?.note
            fetchedEntities.first?.kindOfDefecation = (defecation?.kindOfDefecation)!
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
    
    func setValuesOfGlobalDefecationObject(_ values: Dictionary<String, Any?>) {
        
        // Note
        if let note = values["note"] as? String {
            defecation?.note = note
        } else {
            defecation?.note = ""
        }
        
        // Date
        if let date = values["date"] as? Date {
            defecation?.date = date as NSDate?
        } else {
            defecation?.date = Date() as NSDate?
        }
        
        // Excellent defecation
        if let kind = values["kindOfDefecation"] as? String{
            if kind == "Poop" {
                defecation?.kindOfDefecation = DefecationKind.poop
            } else {
                defecation?.kindOfDefecation = DefecationKind.urine
            }
        } else {
        }
        
        
        if editExistingDefecation == false {
            // Add unique ID
            defecation?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
            
            // Add relationship to reptile
            defecation?.reptile = self.reptile
        }
        
    }
    
}


// MARK: - EUREKA Form Builder
extension AddNewDefecationVC {
    
    func buildAddNewReptileForm(){
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
            
            +++ Section("Defecation information")
            <<< DateRow("date"){ row in
                row.title = "Date"
                if editExistingDefecation == false {
                    row.value = Date()
                } else {
                    row.value = defecation?.date as Date?
                }
            }
            <<< ActionSheetRow<String>("kindOfDefecation"){ row in
                row.title = "Kind of defecation?"
                row.selectorTitle = "What kind of defecation was it?"
                row.options = ["Poop","Urine"]
                if editExistingDefecation == false {
                    row.value = "Poop"    // initially selected
                } else {
                    if defecation?.kindOfDefecation == DefecationKind.poop {
                        row.value = "Poop"
                    } else {
                        row.value = "Urine"
                    }
                }
            }
            
            +++ Section("Notes")
            <<< TextAreaRow("note"){ row in
                row.placeholder = "(Optional)"
                if editExistingDefecation == true && defecation!.note != "" {
                    row.value = defecation?.note
                }
        }
        
    }
    
}

// MARK: - SWIFT MESSAGES
extension AddNewDefecationVC {
    
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

