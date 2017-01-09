//
//  DetailsSheddingVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 18/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import CoreData

class DetailsSheddingVC: UIViewController {
    
    var reptile: Reptile!
    var shedding: Shedding!
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
        let fetchRequest: NSFetchRequest<Shedding> = Shedding.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", shedding!.uniqueID!)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            self.shedding = results.first!
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

}

// MARK: - Navigation
extension DetailsSheddingVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSheddingSegue" {
            if let nextVC = segue.destination as? AddNewSheddingVC {
                nextVC.shedding = shedding
                nextVC.reptile = reptile
                nextVC.editExistingShedding = true
            }
        }
    }
    

    
}




// MARK: - TableView Delegate and Data Source
extension DetailsSheddingVC: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shedding.note == "" {
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
            
            cell.configureCell("Note", boldTitle: true, content: shedding.note!, accentColor: accentColor.lighter(30)!)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as! OneLineCell
        
            if (indexPath as NSIndexPath).row == 0 {
                cell.configureCell("Date", boldTitle: true, content: (shedding.date?.fullDate)!, accentColor: accentColor.lighter(30)!)
            }
            if (indexPath as NSIndexPath).row == 1 {
                var content: String!
                if shedding.exelentShedding as? Bool == true {
                    content = "✔︎ - There were no problems."
                } else {
                    content = "✖︎ - There were some problems."
                }

                cell.configureCell("Shedding", boldTitle: true, content: content, accentColor: accentColor.lighter(30)!)
            }
            
            return cell
        }
        
        
    }
    
    
}
