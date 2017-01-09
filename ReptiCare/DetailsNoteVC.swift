//
//  DetailsNoteVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 26/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import CoreData

class DetailsNoteVC: UIViewController {

    var reptile: Reptile!
    var note: Other!
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
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "imageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCoreDataObject()
        tableView.reloadData()
    }
    
    // MARK: Core Data
    
    func reloadCoreDataObject() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest: NSFetchRequest<Other> = Other.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID == %@", note!.uniqueID!)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            self.note = results.first!
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
}

// MARK: - Navigation
extension DetailsNoteVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNoteSegue" {
            if let nextVC = segue.destination as? AddNewNoteVC {
                nextVC.note = note
                nextVC.reptile = reptile
                nextVC.editExistingNote = true
            }
        }
    }
    
    
    
}




// MARK: - TableView Delegate and Data Source
extension DetailsNoteVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if note.note == "" && note.image == nil {
            return 2
        } else if note.note == "" || note.image == nil {
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).row {
        case 0: return 81
        case 1: return 81
        case 2: if note.note != "" { return 175 } else { return 350 }
        case 3: return 350
        default: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath as NSIndexPath).row == 2 && note.note != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "multiLineCell", for: indexPath) as! MultiLineCell

            cell.configureCell("Note", boldTitle: true, content: note.note!, accentColor: accentColor.lighter(30)!)
            
            return cell
        }
        if (indexPath as NSIndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as! OneLineCell
            
            cell.configureCell("Date", boldTitle: true, content: (note.date?.fullDate)!, accentColor: accentColor.lighter(30)!)
            
            return cell
        }
        if (indexPath as NSIndexPath).row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "oneLineCell", for: indexPath) as! OneLineCell
            
            cell.configureCell("Title", boldTitle: true, content: note.title!, accentColor: accentColor.lighter(30)!)
            
            return cell
        }
        if (indexPath as NSIndexPath).row == 3 ||  ( (indexPath as NSIndexPath).row == 2 && note.note == "" ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
            
            cell.configureCell("Image", boldTitle: true, image: note.getImg(), accentColor: accentColor.lighter(30)!)
            
            return cell
        }

        return UITableViewCell()
        
    }
    
    
}
