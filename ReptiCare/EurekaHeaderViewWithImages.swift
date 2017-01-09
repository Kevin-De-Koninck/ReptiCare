//
//  EurekaHeaderViewWithImages.swift
//  ReptiCare
//
//  Created by Kevin De Koninck on 12/09/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import UIKit

class EurekaHeaderViewWithImages: UIView {
    
    
    var imageHeader: UIImage?
    var image: UIImage?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        
        // See if a correct image has been set
        var backgroundImg: UIImage!
        if let bg = imageHeader {
            backgroundImg = bg
        } else {
            backgroundImg = UIImage(named: "default_background")
        }
        var img: UIImage!
        if let bg = image {
            img = bg
        } else {
            img = UIImage(named: "TEST")
        }
        
        // Set frame
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 170)
        
        // Set Header image
        let BackgroundImageView = UIImageView(image: backgroundImg)
        BackgroundImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 170)
        BackgroundImageView.autoresizingMask = .flexibleWidth
        BackgroundImageView.layer.masksToBounds = true
        BackgroundImageView.contentMode = .scaleAspectFill
        
        // Set normal image and round it
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.autoresizingMask = UIViewAutoresizing()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.contentMode = .scaleAspectFill
        
        // Normal image is subview of background image
        BackgroundImageView.addSubview(imageView)
        
        // Center the normal image
        let centerX = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: BackgroundImageView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: BackgroundImageView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 150)
        let width = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 150)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        BackgroundImageView.addConstraints([centerX, centerY, height, width])
        
        // Add everything
        self.addSubview(BackgroundImageView)
    }
}





