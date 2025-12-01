//
//  CreateAlbumViewCell.swift
//  TouchBase
//
//  Created by Umesh on 20/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class CreateAlbumViewCell: UICollectionViewCell
{
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    // @IBOutlet var viewMain: UIView!
    
    @IBOutlet weak var viewMainView: UIView!
    @IBOutlet var buttonDetailClickEvent: UIButton!
    
    // @IBOutlet var buttonDelete: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
        
        
        labelTitle.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.45)

        //viewMain.layer.shadowColor = UIColor.blackColor().CGColor
        // viewMain.layer.shadowOpacity = 1
        // viewMain.layer.shadowOffset = CGSizeZero
        // viewMain.layer.shadowRadius = 2
        // viewMain.backgroundColor=UIColor.whiteColor()
        // labelTitle.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        //viewMain.layer.borderColor=UIColor.lightGrayColor()
        
        
        //  self.viewMain.layer.borderWidth = 1
        // self.viewMain.layer.borderColor.lightGrayColor().cgc
        //self.viewMain.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    }
    
//    func configureCellServicesProviderList(dict:NSDictionary)
//    {
//        print(dict)
//        let varAlbumId=(dict.valueForKey("albumId")as! String)
//        let varDescription=(dict.valueForKey("description")as! String)
//        let varGroupId=(dict.valueForKey("groupId")as! String)
//        let varImage=(dict.valueForKey("image")as! String)
//        let varIsAdmin=(dict.valueForKey("isAdmin")as! String)
//        let varTitle=(dict.valueForKey("title")as! String)
//        let varType=(dict.valueForKey("type")as! String)
//        //  imageAlbum.image = UIImage(named:"spain_lang@3x.png")
//        labelTitle.text=varTitle
//        labelTitle.hidden=false
//        print(varTitle)
//        /*Asynchronously image loading in tableview start*/
//        if(varImage=="")
//        {
//            imageAlbum.image = UIImage(named:"dashboardplaceholder.png")
//        }
//        else
//        {
//            ImageLoader.sharedLoader.imageForUrl(varImage, completionHandler:{(image: UIImage?, url: String) in
//                self.imageAlbum.image = image
//            })
//        }
//    }
    
    
}
