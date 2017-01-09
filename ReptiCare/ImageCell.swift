//
//  ImageCell.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 26/09/2016.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var extraTitleField: UILabel!
    
    @IBOutlet weak var thinLine: UIView!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        background.layer.cornerRadius = 10
        background.layer.masksToBounds = true
        
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        
        background.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        
        // Add blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = background.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.70
        background.insertSubview(blurEffectView, at: 0)
    }
    
    
    func configureCell(_ title: String, boldTitle: Bool, image: UIImage?, accentColor: UIColor){
        
        topView.backgroundColor = UIColor.white
        thinLine.backgroundColor = accentColor.lighter(30)!
        
        titleLbl.text = title
        if boldTitle == false {
            titleLbl.font = UIFont (name: "HelveticaNeue-Light", size: 14)
        } else {
            titleLbl.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        }
        extraTitleField.text = ""
        
        if let img_ = image {
            img.image = img_
        } else {
            img.image = UIImage(named: "default_image")
        }
        
        thinLine.backgroundColor = accentColor
    }
    
    
    func configureCell(_ title: String, boldTitle: Bool, TitleNote: String, image: UIImage?, accentColor: UIColor){
        
        topView.backgroundColor = UIColor.white
        thinLine.backgroundColor = accentColor.lighter(30)!
        
        titleLbl.text = title
        if boldTitle == false {
            titleLbl.font = UIFont (name: "HelveticaNeue-Light", size: 14)
        } else {
            titleLbl.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        }
        extraTitleField.text = TitleNote
        
        
        if let img_ = image {
            img.image = img_
        } else {
            img.image = UIImage(named: "default_image")
        }
        
        thinLine.backgroundColor = accentColor
    }
    
    
    
    
    
}
