//
//  ReptileMenuCelll.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 14/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit

class ReptileMenuCell: UITableViewCell {
   
    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuItemBackgroundView: UIView!
    @IBOutlet weak var menuItemIcon: UIImageView!
    @IBOutlet weak var menuItemIconBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()

        let cornerRadius = menuItemIcon.frame.width/2
        
        menuItemIcon.layer.cornerRadius = cornerRadius
        menuItemIcon.clipsToBounds = true
        
        menuItemIconBackgroundView.layer.cornerRadius = cornerRadius
        menuItemIconBackgroundView.clipsToBounds = true
    
        
        menuItemBackgroundView.layer.cornerRadius = 10
        menuItemBackgroundView.clipsToBounds = true
        menuItemBackgroundView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)


        // Add blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = menuItemBackgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.70
        menuItemBackgroundView.insertSubview(blurEffectView, at: 0)

    }

    
    func configureCell(_ itemLabel: String, itemIcon: UIImage, itemBackgroundColor: UIColor){
        menuItemIcon.image = itemIcon
        menuItemLabel.text = itemLabel
        menuItemIconBackgroundView.backgroundColor = itemBackgroundColor
    }

}
