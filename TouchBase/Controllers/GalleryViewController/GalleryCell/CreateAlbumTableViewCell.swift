//
//  CreateAlbumTableViewCell.swift
//  TouchBase
//
//  Created by Umesh on 10/01/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CreateAlbumTableViewCell: UITableViewCell {
    
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var buttonDelete: UIButton!
    
    //  @IBOutlet var labelDescription: UILabel!
    
    @IBOutlet var textviewDescription: UITextView!
    //@IBOutlet var buttonDescription: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // viewMain.layer.shadowColor = UIColor.blackColor().CGColor
        // viewMain.layer.shadowOpacity = 1
        //viewMain.layer.shadowOffset = CGSizeZero
        //// viewMain.layer.shadowRadius = 2
        // viewMain.backgroundColor=UIColor.whiteColor()
        textviewDescription.isScrollEnabled=false
        textviewDescription.isUserInteractionEnabled=false
        textviewDescription.isEditable=false
        //buttonDescription.titleLabel!.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        
        textviewDescription.contentInset = UIEdgeInsets(top: -7.0,left: -5.0,bottom: 0,right: 0.0);
        
        imageAlbum.contentMode = .scaleAspectFit
        
        
    }
    
    func configureCellServicesProviderList(_ dict:NSDictionary)
    {
        print(dict)
        let varAlbumId=(dict.value(forKey: "albumId")as! String)
        let varDescription=(dict.value(forKey: "description")as! String)
        let varGroupId=(dict.value(forKey: "groupId")as! String)
        var varImage=(dict.value(forKey: "image")as! String)
        let varIsAdmin=(dict.value(forKey: "isAdmin")as! String)
        let varTitle=(dict.value(forKey: "title")as! String)
        let varType=(dict.value(forKey: "type")as! String)
        //
        labelTitle.text=varTitle
        //labelDescription.text=varDescription
        // buttonDescription.setTitle(varDescription, forState: .Normal)
        textviewDescription.text=varDescription
        
        print(varImage)
        /*Asynchronously image loading in tableview start*/
        if(varImage=="")
        {
            imageAlbum.image = UIImage(named:"dashboardplaceholder.png")
        }
        else
        {
            ImageLoader.sharedLoader.imageForUrl(varImage, completionHandler:{(image: UIImage?, url: String) in
                self.imageAlbum.image = image
            })
        }
        
        /*
         dashboardplaceholder.png
         */
        // Album.image
    }
}
