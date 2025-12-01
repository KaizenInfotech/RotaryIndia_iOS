//
//  ModuleCollectionViewCell.swift
//  TouchBase
//
//  Created by Umesh on 24/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit



class ModuleCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet var grpName: UILabel!
    
    @IBOutlet var labelNotificationCount: UILabel!
    
    
    @IBOutlet var buttonNotificationCount: UIButton!
   // var delegates : customCellDelegate?
    let boundss = UIScreen.main.bounds
    var grpData:GroupResult!
   @IBOutlet var chkBTn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.imgUser.translatesAutoresizingMaskIntoConstraints = true
//      
//        
//        self.imgUser.frame=CGRectMake(((((boundss.size.width/2)-10)-95)/2), 10, 95, 95)
//          self.grpName.translatesAutoresizingMaskIntoConstraints = true
//        self.grpName.frame=CGRectMake(5, ((boundss.size.width/2)-65), ((boundss.size.width/2)-10), 68)
//        self.chkBTn.translatesAutoresizingMaskIntoConstraints = true
//        self.chkBTn.frame=CGRectMake(((boundss.size.width/2)-44),2, 40, 40)
//        self.grpName.font = UIFont(name: self.grpName.font.fontName, size: 17)
       // self.layer.borderWidth = 1
        //self.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).CGColor
        
        
       // buttonNotificationCount.backgroundColor = UIColor.clearColor()
       // buttonNotificationCount.layer.cornerRadius = 12
      //  buttonNotificationCount.layer.borderWidth = 1
       // buttonNotificationCount.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      //  buttonNotificationCount.layer.borderColor = UIColor.blackColor().CGColor
        
        
        
       // self.grpName.textColor=UIColor.whiteColor()
        // imgUser.frame = CGRectMake(5, 5, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
        // Initialization code
        //        imgUser.layer.cornerRadius = 6.0
        //        imgUser.clipsToBounds = true
        //        imgUser.layer.borderWidth=2.0
        //        imgUser.layer.borderColor=UIColor.whiteColor().CGColor
    }
    @IBAction func AllButtonAction(_ sender: AnyObject){
       // self.delegates?.mygroupsDelegateFunction!(grpData)
    }
    
}
