//
//  AddNewShedding.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 16/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages

class AddNewSheddingVC: FormViewController {

    
    // MARK: Global variables
    var shedding: Shedding?
    var reptile: Reptile!
    
    var editExistingShedding: Bool = false
    
    
    //MARK: UI View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add shedding"
        
        // Eureka form builder
        buildAddNewReptileForm()
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if editExistingShedding == false {
            //Create shedding object (global variable)
            createGlobalSheddingObject()
            setValuesOfGlobalSheddingObject(form.values())
            saveGlobalSheddingObject()
            
            // Display a succes dialog
            showSuccessMessage("Success!", body: "The shedding has been added.")
        } else {
            setValuesOfGlobalSheddingObject(form.values())
            editGlobalSheddingObject()
            
            showSuccessMessage("Success!", body: "The shedding has been Edited.")

        }
        
        // Pop the view (and go back)
        navigationController!.popViewController(animated: true)
        
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalSheddingObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Shedding", in: context)!
        shedding = Shedding(entity: entity, insertInto: context)
    }
    
    func saveGlobalSheddingObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let shedding_ = shedding {
            context.insert(shedding_)
            
            do {
                try context.save()
            } catch {
                print("Could not save reptile")
            }
        }
    }
    
    func editGlobalSheddingObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext

        let fetchRequest: NSFetchRequest<Shedding> = Shedding.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", shedding!.uniqueID!)
        fetchRequest.predicate = predicate
    
 
        do {
            let fetchedEntities = try context.fetch(fetchRequest) 
            fetchedEntities.first?.date = shedding?.date
            fetchedEntities.first?.note = shedding?.note
            fetchedEntities.first?.exelentShedding = shedding?.exelentShedding
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
    
    func setValuesOfGlobalSheddingObject(_ values: Dictionary<String, Any?>) {
        
        // Note
        if let note = values["note"] as? String {
            shedding?.note = note
        } else {
            shedding?.note = ""
        }
        
        // Date
        if let date = values["date"] as? Date {
            shedding?.date = date as NSDate?
        } else {
            shedding?.date = Date() as NSDate?
        }
        
        // Excellent Shedding
        if let anyProblems = values["excellentShedding"] as? String{
            if anyProblems == "Yes" {
                shedding?.exelentShedding = false
            } else {
                shedding?.exelentShedding = true
            }
        } else {
            shedding?.exelentShedding = true
        }

        
        if editExistingShedding == false {
            // Add unique ID
            shedding?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
            
            // Add relationship to reptile
            shedding?.reptile = self.reptile
        }
        
    }
    
}


// MARK: - EUREKA Form Builder
extension AddNewSheddingVC {
    
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
            
            +++ Section("shedding information")
            <<< DateRow("date"){ row in
                row.title = "Date"
                if editExistingShedding == false {
                    row.value = Date()
                } else {
                    row.value = shedding?.date as Date?
                }
            }
            <<< ActionSheetRow<String>("excellentShedding"){ row in
                row.title = "Any problems?"
                row.selectorTitle = "Were there any problems?"
                row.options = ["Yes","No"]
                if editExistingShedding == false {
                    row.value = "No"    // initially selected
                } else {
                    if shedding?.exelentShedding == true {
                    row.value = "No"
                    } else {
                        row.value = "Yes"
                    }
                }
            }
            
            +++ Section("Notes")
            <<< TextAreaRow("note"){ row in
                row.placeholder = "(Optional)"
                if editExistingShedding == true && shedding!.note != "" {
                    row.value = shedding?.note
                }
            }
        
    }
    
}

// MARK: - SWIFT MESSAGES
extension AddNewSheddingVC {
    
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

