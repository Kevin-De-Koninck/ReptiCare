//
//  AddNewNotesVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 26/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages

class AddNewNoteVC: FormViewController {
    
    // MARK: Global variables
    var note: Other?
    var reptile: Reptile!
    
    var editExistingNote: Bool = false
    var imageChanged: Bool = false
    
    
    //MARK: UI View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add note"
        
        // Eureka form builder
        buildAddNewReptileForm()
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
       let values = form.values()
    
        if values["title"] as? String == "" || values["title"] as? String == nil {
            showWarningMessage("Warning", body: "A title must be entered. Please try again.")
        } else {
            if editExistingNote == false {
                //Create note object (global variable)
                createGlobalNoteObject()
                setValuesOfGlobalNoteObject(form.values())
                saveGlobalNoteObject()
                
                // Display a succes dialog
                showSuccessMessage("Success!", body: "The note has been added.")
            } else {
                setValuesOfGlobalNoteObject(form.values())
                editGlobalNoteObject()
                
                showSuccessMessage("Success!", body: "The note has been Edited.")
                
            }
            
            // Pop the view (and go back)
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalNoteObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Other", in: context)!
        note = Other(entity: entity, insertInto: context)
    }
    
    func saveGlobalNoteObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        if let note_ = note {
            context.insert(note_)
            
            do {
                try context.save()
            } catch {
                print("Could not save note")
            }
        }
    }
    
    func editGlobalNoteObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest : NSFetchRequest<Other> = Other.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", note!.uniqueID!)
        fetchRequest.predicate = predicate
        
        
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            fetchedEntities.first?.date = note?.date
            fetchedEntities.first?.note = note?.note
            fetchedEntities.first?.title = note?.title
            if imageChanged == true {
                fetchedEntities.first?.setImg(note?.getImg())
            }
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
    
    func setValuesOfGlobalNoteObject(_ values: Dictionary<String, Any?>) {
        
        // Note
        if let note_ = values["note"] as? String {
            note?.note = note_
        } else {
            note?.note = ""
        }
        
        // Date
        if let date = values["date"] as? Date {
            note?.date = date as NSDate?
        } else {
            note?.date = Date() as NSDate?
        }
        
        // Title
        if let title = values["title"] as? String {
            note?.title = title
        } else {
            note?.title = ""
        }
        
        // image
        if imageChanged == true {
            if let image = values["image"] as? UIImage {
                note?.setImg(image)
            } else {
                note?.setImg(nil)
            }
        }
        
        
        
        if editExistingNote == false {
            // Add unique ID
            note?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
            
            // Add relationship to reptile
            note?.reptile = self.reptile
        }
        
    }
    
}


// MARK: - EUREKA Form Builder
extension AddNewNoteVC {
    
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
            
            +++ Section("Information")
            <<< DateRow("date"){ row in
                row.title = "Date"
                if editExistingNote == false {
                    row.value = Date()
                } else {
                    row.value = note?.date as Date?
                }
            }
            
            
            +++ Section("Content")
            <<< TextRow("title"){ row in
                row.title = "Title"
                if editExistingNote == false {
                    row.placeholder = "Title"
                } else {
                    row.value = note?.title
                }
            }
            <<< TextAreaRow("note"){ row in
                row.placeholder = "(Optional)"
                if editExistingNote == true && note!.note != "" {
                    row.value = note?.note
                }
            }
            <<< ImageRow("image"){ row in
                row.title = "Picture"
                }.onChange({ row in
                    self.imageChanged = true
                })
                .cellSetup({ (cell, row) -> () in
                    row.cell.height = {
                        return 80
                    }
                })

        
    }
    
}

// MARK: - SWIFT MESSAGES
extension AddNewNoteVC {
    
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
    
    func showWarningMessage(_ title: String, body: String) {
        
        let view = MessageView.viewFromNib(layout: .CardView)
        view.configureTheme(.warning)
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

