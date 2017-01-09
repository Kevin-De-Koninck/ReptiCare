//
//  ReptileMenuVC.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 14/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit
import CoreData

class ReptileMenuVC: UIViewController {

    // MARK: Global variables
    var reptile: Reptile!

    // MARK: Interface outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var background: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        background.image = reptile.getImgHeader()
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = reptile.name
    
    }

    
}

// MARK: - Navigation
extension ReptileMenuVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Feedings
//        if segue.identifier == "FeedingsMenuItemSegue" {
//            if let nextVC = segue.destinationViewController as? cecdzcdcds {
//                if let reptile_ = sender as? Reptile {
//                    nextVC.reptile = reptile_
//                    nextVC.accentColor = FEEDING_ITEM_COLOR
//                }
//            }
//        }
        
        // Sheddings
        if segue.identifier == "SheddingsMenuItemSegue" {
            if let nextVC = segue.destination as? SheddingsTableVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = SHEDDING_ITEM_COLOR
                }
            }
        }
        
        // Defecations
        if segue.identifier == "DefecationsMenuItemSegue" {
            if let nextVC = segue.destination as? DefecationsTableVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = DEFECATION_ITEM_COLOR
                }
            }
        }
        
        // Weights
        if segue.identifier == "WeightsMenuItemSegue" {
            if let nextVC = segue.destination as? WeightsTableVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = WEIGHT_ITEM_COLOR
                }
            }
        }
        
        // Lengths
        if segue.identifier == "LengthsMenuItemSegue" {
            if let nextVC = segue.destination as? LengthsTableVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = LENGTH_ITEM_COLOR
                }
            }
        }

        // Notes
        if segue.identifier == "NotesMenuItemSegue" {
            if let nextVC = segue.destination as? NotesTableVC {
                if let reptile_ = sender as? Reptile {
                    nextVC.reptile = reptile_
                    nextVC.accentColor = NOTES_ITEM_COLOR
                }
            }
        }

        
        
    }

}

extension ReptileMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let menuItem = ReptileMenuItems(rawValue: (indexPath as NSIndexPath).row) {
            
            switch menuItem {
            case ReptileMenuItems.feedings: performSegue(withIdentifier: "FeedingsMenuItemSegue", sender: reptile)
            case ReptileMenuItems.sheddings: performSegue(withIdentifier: "SheddingsMenuItemSegue", sender: reptile)
            case ReptileMenuItems.defecations: performSegue(withIdentifier: "DefecationsMenuItemSegue", sender: reptile)
            case ReptileMenuItems.weight: performSegue(withIdentifier: "WeightsMenuItemSegue", sender: reptile)
            case ReptileMenuItems.length: performSegue(withIdentifier: "LengthsMenuItemSegue", sender: reptile)
            case ReptileMenuItems.notes: performSegue(withIdentifier: "NotesMenuItemSegue", sender: reptile)
            default: break
                
            }
        }

    
    }
    
}

extension ReptileMenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 8
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as? ReptileMenuCell {
            
            var label: String!
            var icon: UIImage!
            var color: UIColor!
            
            if let menuItem = ReptileMenuItems(rawValue: (indexPath as NSIndexPath).row) {
                switch menuItem {
                case ReptileMenuItems.profile:
                    label = "Profile"
                    icon = UIImage(named: "Profile")
                    color = PROFILE_ITEM_COLOR
                case ReptileMenuItems.feedings:
                    label = "Feedings"
                    icon = UIImage(named: "Feedings")
                    color = FEEDING_ITEM_COLOR
                case ReptileMenuItems.sheddings:
                    label = "Sheddings"
                    icon = UIImage(named: "Sheddings")
                    color = SHEDDING_ITEM_COLOR
                case ReptileMenuItems.defecations:
                    label = "Defecations"
                    icon = UIImage(named: "Defecations")
                    color = DEFECATION_ITEM_COLOR
                case ReptileMenuItems.length:
                    label = "Length"
                    icon = UIImage(named: "Measurements")
                    color = LENGTH_ITEM_COLOR
                case ReptileMenuItems.weight:
                    label = "Weight"
                    icon = UIImage(named: "Weights")
                    color = WEIGHT_ITEM_COLOR
                case ReptileMenuItems.notes:
                    label = "Notes"
                    icon = UIImage(named: "Notes")
                    color = NOTES_ITEM_COLOR
                case ReptileMenuItems.statistics:
                    label = "Statistics"
                    icon = UIImage(named: "Statistics")
                    color = STATISTICS_ITEM_COLOR
                case ReptileMenuItems.share:
                    label = "Share"
                    icon = UIImage(named: "Share")
                    color = SHARE_ITEM_COLOR
                }
            } else {
                label = "ERROR"
                icon = UIImage(named: "default_image")
                color = UIColor.flatRed()
            }
            
            
            cell.configureCell(label, itemIcon: icon, itemBackgroundColor: color)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    
    
//    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animate(withDuration: 0.3, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//            },completion: { finished in
//                UIView.animate(withDuration: 0.1, animations: {
//                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
//                })
//        })
//    }
    
    
    
    
    
}
