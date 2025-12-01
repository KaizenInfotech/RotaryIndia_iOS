//
//  CustomCollectionViewCell.swift
//  TouchBase
//
//  Created by Umesh on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var moduleIcon: UIImageView!
    @IBOutlet var grpName: UILabel!
    
    
    
    @IBOutlet var buttonNotificationCount: UIButton!
    
    let boundss = UIScreen.main.bounds
    var moduleStaticRef:NSString!
    var moduleId:NSString!
    @IBOutlet var selectBtn:UIButton!
    var grpDetail:GroupList!
    override func awakeFromNib() {
        super.awakeFromNib()
       // self.imgUser.translatesAutoresizingMaskIntoConstraints = true
        self.grpName.translatesAutoresizingMaskIntoConstraints = true
        self.moduleIcon.translatesAutoresizingMaskIntoConstraints = true
       // self.imgUser.frame=CGRectMake(0, 0, ((boundss.size.width/3)-0), ((boundss.size.width/3)-5))
        //self.grpName.frame=CGRectMake(5, ((boundss.size.width/3)-45), ((boundss.size.width/3)-20), 42)
        //self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/3)-35)/2, 30, 35, 35)
    
        
       // buttonNotificationCount.layer.cornerRadius = 12
        //  buttonNotificationCount.layer.borderWidth = 1
        //buttonNotificationCount.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
       // imgUser.frame = CGRectMake(5, 5, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
        // Initialization code
//        imgUser.layer.cornerRadius = 6.0
//        imgUser.clipsToBounds = true
//        imgUser.layer.borderWidth=2.0
//        imgUser.layer.borderColor=UIColor.whiteColor().CGColor
    }
}
