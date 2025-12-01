//
//  CelebreationCollectionViewCell.swift
//  TouchBase
//
//  Created by Umesh on 16/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CelebreationCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var buttonNotification: UIButton!
    @IBOutlet var buttonMain: UIButton!
    @IBOutlet var labelate: UILabel!
    @IBOutlet var viewMain: UIView!
    
    
    @IBOutlet weak var viewCurveCircle: UIView!
    
    
    override func awakeFromNib()
    {
        
        
        
        super.awakeFromNib()
        //viewMain.ThreeDView()
        // Initialization code
        
        /*
         buttonMain.layer.borderWidth = 1.0
         buttonMain.layer.masksToBounds = false
         buttonMain.layer.borderColor = UIColor.blueColor().CGColor
         buttonMain.layer.cornerRadius = buttonMain.frame.size.width/2
         buttonMain.clipsToBounds = true
         */
        
        //viewCurveCircle
        
        viewCurveCircle.layer.borderWidth = 1.0
        viewCurveCircle.layer.masksToBounds = false
        viewCurveCircle.layer.borderColor = UIColor.clear.cgColor
        viewCurveCircle.layer.cornerRadius = viewCurveCircle.frame.size.width/2
        viewCurveCircle.clipsToBounds = true
        
        buttonNotification.titleLabel?.textColor = UIColor.lightGray
        buttonNotification.setTitleColor(UIColor.lightGray,  for: UIControl.State.normal)
        buttonNotification.backgroundColor=UIColor.lightGray
        buttonNotification.layer.borderWidth = 1.0
        buttonNotification.layer.masksToBounds = false
        buttonNotification.layer.borderColor = UIColor.lightGray.cgColor
        buttonNotification.layer.cornerRadius = buttonNotification.frame.size.width/2
        buttonNotification.clipsToBounds = true
        
        
        
    }
    
}
