//
//  DetailsDefecationVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 19/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import CoreData

class DetailsDefecationVC: UIViewController {

    var reptile: Reptile!
    var defecation: Defecation!
    var backgroudImage: UIImage!
    var accentColor: UIColor!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = backgroudImage
        background.clipsToBounds = true
        tableView.backgroundColor = UIColor.clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: Register reusable cells
        tableView.register(UINib(nibName: "OneLineCell", bundle: nil), forCellReuseIdentifier: "oneLineCell")
        tableView.register(UINib(nibName: "MultiLineCell", bundle: nil), forCellReuseIdentifier: "multiLineCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadCoreDataObject()
        tableView.reloadData()
    }
    
    // MARK: Core Data
    
    func reloadCoreDataObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest: NSFetchRequest<Defecation> = Defecation.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", defecation!.uniqueID!)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            self.defecation = results.first!
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
}

// MARK: - Navigation
extension DetailsDefecationVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDefecationSegue" {
            if let nextVC = segue.destination as? AddNewDefecationVC {
                nextVC.defecation = defecation
                nextVC.reptile = reptile
                nextVC.editExistingDefecation = true
            }
        }
    }
    
    
    
}




// MARK: - TableView Delegate and Data Source
extension DetailsDefecationVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if defecation.note == "" {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).row {
        case 0: return 81
        case 1: return 81
        case 2: return 175
        default: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath as NSIndexPath).row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "multiLineCell", for: indexPath) as! MultiLineCell
            
            cell.configureCell("Note", boldTitle: true, content: defecation.note!, accentColor: accentColor.lighter(30)!)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as! OneLineCell
            
            if (indexPath as NSIndexPath).row == 0 {
                cell.configureCell("Date", boldTitle: true, content: (defecation.date?.fullDate)!, accentColor: accentColor.lighter(30)!)
            }
            if (indexPath as NSIndexPath).row == 1 {
                var content: String!
                if defecation.kindOfDefecation == DefecationKind.poop {
                    content = "It was a doodoo."
                } else {
                    content = "It was a urination."
                }
                
                cell.configureCell("Defecation", boldTitle: true, content: content, accentColor: accentColor.lighter(30)!)
            }
            
            return cell
        }
        
        
    }
    
    
}
