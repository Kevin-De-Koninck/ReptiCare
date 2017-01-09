//
//  OneLineCell.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 18/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit

// https://medium.com/@musawiralishah/creating-custom-uitableviewcell-using-nib-xib-files-in-xcode-9bee5824e722#.3xpatm8si

class OneLineCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var extraTitleField: UILabel!
    
    @IBOutlet weak var thinLine: UIView!
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var background: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.cornerRadius = 10
        background.layer.masksToBounds = true
        
        background.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        
        // Add blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = background.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.70
        background.insertSubview(blurEffectView, at: 0)
     
    }
    
    func configureCell(_ title: String, boldTitle: Bool, content: String, accentColor: UIColor){
        
        topView.backgroundColor = UIColor.white
        thinLine.backgroundColor = accentColor.lighter(30)!
        
        titleLbl.text = title
        if boldTitle == false {
            titleLbl.font = UIFont (name: "HelveticaNeue-Light", size: 14)
        } else {
            titleLbl.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        }
        extraTitleField.text = ""
        contentLbl.text = content
       
        thinLine.backgroundColor = accentColor
        
    }
    
    
    func configureCell(_ title: String, boldTitle: Bool, TitleNote: String, content: String, accentColor: UIColor){
        
        topView.backgroundColor = UIColor.white
        thinLine.backgroundColor = accentColor.lighter(30)!
        
        titleLbl.text = title
        if boldTitle == false {
            titleLbl.font = UIFont (name: "HelveticaNeue-Light", size: 14)
        } else {
            titleLbl.font = UIFont (name: "HelveticaNeue-Bold", size: 14)
        }
        extraTitleField.text = TitleNote

        contentLbl.text = content
        
        thinLine.backgroundColor = accentColor
        
    }




}
