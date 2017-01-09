//
//  ReptileCollectionCell.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 06/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit

class ReptileCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var reptileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(_ reptile: Reptile) {
        
        // Set name
        if let name_ = reptile.name {
            name.text = name_
        }

        // Set reptile image and make it round
        let constraintMargin: CGFloat = 2 * 30 //(left and right constraint)
        let magicValue = self.frame.size.width - constraintMargin // I needed this because the size of the image 
                                                                  // was not correct in the beginning (only correct after 3 swipes)
        let radius = (magicValue)/2
        reptileImage.image = reptile.getImg()
        reptileImage.layer.cornerRadius = radius
        reptileImage.layer.masksToBounds = true

        // Xcode can't round an imageView AND add shadow at the same time...
        // So we use a container view for the shadow creation
        let bounds = CGRect(x: 0.0, y: 0.0, width: magicValue, height: magicValue)
        container.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        container.backgroundColor = UIColor.clear
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset =  CGSize.zero
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 14.0
        
        reptileImage.layer.borderColor = UIColor.white.cgColor
        reptileImage.layer.borderWidth = 2.0

        
    //Background image
        let background = reptile.getImgHeader()
        
       // image = image!.applyBlurWithRadius(2, tintColor: UIColor(white: 0.0, alpha: 0.0), saturationDeltaFactor: 1.0)
        backgroundImage.image = background
        backgroundImage.clipsToBounds = true
        
    }
    


}
