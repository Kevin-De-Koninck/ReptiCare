//
//  AddNewReptileVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 06/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import SwiftMessages



class AddNewReptileVC: FormViewController {
    
    // MARK: Global variables
    var reptile: Reptile?

    
    
    //MARK: UI View Controller functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigationcontroller
        self.view.backgroundColor = BACKGROUND_COLOR
        self.title = "Add reptile"
        
        // Eureka form builder
        buildAddNewReptileForm()
        
    }
    
    
    
    // MARK: Interface Actions
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        //Create reptile object (global variable)
        createGlobalReptileObject()
        setValuesOfGlobalReptileObject(form.values())
        saveGlobalReptileObject()
        
        // Display a succes dialog
        showSuccessMessage("Success!", body: "Your reptile has been added.")
        
        // Post a notification
        NotificationCenter.default.post(name: Notification.Name(rawValue: "successfullyAddedNewReptile"), object: nil)
    
        // Pop the view (and go back)
        navigationController!.popViewController(animated: true)
        
    }
    
    
    
    // MARK: Core Data
    
    func createGlobalReptileObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Reptile", in: context)!
        reptile = Reptile(entity: entity, insertInto: context)
    }
    
    func saveGlobalReptileObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext

        if let reptile_ = reptile {
            context.insert(reptile_)
            
            do {
                try context.save()
            } catch {
                print("Could not save reptile")
            }
        }
    }
    
    
    
    // MARK: Form Data to Core Data
    
    func setValuesOfGlobalReptileObject(_ values: Dictionary<String, Any?>) {
        
        // Gender
        var gender: Gender!
        switch values["gender"] as! String {
        case "Male" : gender = Gender.male
        case "Female" : gender = Gender.male
        default : gender = Gender.unknown
        }
        reptile?.gender = gender
        
        // Morph
        if let morph = values["morph"] as? String{
            reptile?.morph = morph
        } else {
            reptile?.morph = ""
        }
        
        // Ideal day temperature
        if let tempDay = values["idealTemperatureAtDay"] as? String{
            reptile?.idealTemperatureAtDay = tempDay
        } else {
            reptile?.idealTemperatureAtDay = ""
        }
        
        //ideal night temperature
        if let tempNight = values["idealTemperatureAtNight"] as? String{
            reptile?.idealTemperatureAtNight = tempNight
        } else {
            reptile?.idealTemperatureAtNight = ""
        }
        
        // Feeding period in days
        if let feedingPeriod = values["feedingPeriodInDays"] as? Int{
            reptile?.feedingPeriodInDays = feedingPeriod as NSNumber?
        } else {
            reptile?.feedingPeriodInDays = nil
        }
        
        // Date Of Birth
        if let dob = values["dateOfBirth"] as? Date{
            reptile?.dateOfBirth = dob as NSDate?
        } else {
            reptile?.dateOfBirth = nil
        }
        
        // image
        if let image = values["image"] as? UIImage{
            reptile?.setImg(image)
        } else {
            reptile?.setImg(UIImage(named: "TEST")!)
        }
        
        // Header image
        if let header = values["imageHeader"] as? UIImage{
            reptile?.setImgHeader(header)
        } else {
            reptile?.setImgHeader(UIImage(named: "default_background")!)
        }
        
        // Breed
        if let breed = values["breed"] as? String{
            reptile?.breed = breed
        } else {
            reptile?.breed = ""
        }
        
        // Name
        if let name = values["name"] as? String{
            reptile?.name = name
        } else {
            reptile?.name = ""
        }
        
        // Add unique ID
        reptile?.uniqueID = Double(Date().timeIntervalSince1970) as NSNumber?
        
    }



    
}


// MARK: - EUREKA Form Builder
extension AddNewReptileVC {
    
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
                    
                    let values = self.form.values()
                    let image = values["image"] as? UIImage
                    let imageHeader = values["imageHeader"] as? UIImage
                    
                    view.image = image
                    view.imageHeader = imageHeader
                    view.backgroundColor = BACKGROUND_COLOR
                    
                    view.update()
                }
                section.header = header
            }
            
            +++ Section("Reptile information")
            
            <<< NameRow("name"){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
            }
            <<< NameRow("breed"){ row in
                row.title = "Breed"
                row.placeholder = "Enter breed here"
            }
            <<< NameRow("morph"){ row in
                row.title = "Morph"
                row.placeholder = "Enter Morph here"
            }
            <<< DateRow("dateOfBirth"){ row in
                row.title = "Date of Birth"
                row.value = Date()
            }
            <<< PushRow<String>() { row in
                row.tag = "gender"
                row.title = "Gender"
                row.selectorTitle = "Pick a gender"
                row.options = ["Male","Female","Unknown"]
                row.value = "Unknown"    // initially selected
            }
            
            +++ Section("Pictures")
            <<< ImageRow("image"){ row in
                row.title = "Picture"
                }.cellSetup({ (cell, row) -> () in
                    row.cell.height = {
                        return 80
                    }
                })
                .onChange({ (row) -> () in
                    let section: Section?  = self.form.sectionBy(tag: "header")
                    section?.reload()
                })
            <<< ImageRow("imageHeader"){ row in
                row.title = "Background"
                }.cellSetup({ (cell, row) -> () in
                    row.cell.height = {
                        return 80
                    }
                })
                .onChange({ (row) -> () in
                    let section: Section?  = self.form.sectionBy(tag: "header")
                    section?.reload()
                })
            
            +++ Section("Enclosure")
            <<< TextRow("idealTemperatureAtDay"){ row in
                row.title = "Ideal temperature (day)"
                row.placeholder = "Enter temperature here"
            }
            <<< TextRow("idealTemperatureAtNight"){ row in
                row.title = "Ideal temperature (night)"
                row.placeholder = "Enter temperature here"
            }
            
            +++ Section("Settings")
            <<< IntRow("feedingPeriodInDays"){ row in
                row.title = "Feeding period (days)"
                row.placeholder = "Every x days"
            }
            <<< SwitchRow("receiveNotifications"){ row in
                row.title = "Receive notifications"
            }
            <<< TimeRow("reminderTime"){ row in //only if above = yes
                row.hidden = Condition.function(["receiveNotifications"], { form in
                    return !((form.rowBy(tag: "receiveNotifications") as? SwitchRow)?.value ?? false)
                })
                row.title = "Reminder time"
        }
    }
    
}

// MARK: - SWIFT MESSAGES
extension AddNewReptileVC {
    
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

