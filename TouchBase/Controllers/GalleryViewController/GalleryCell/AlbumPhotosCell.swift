//
//  AlbumPhotosCell.swift
//  TouchBase
//
//  Created by Umesh on 22/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumPhotosCell: UICollectionViewCell
{
   // @IBOutlet var viewMain: UIView!
    @IBOutlet var lableTitle: UILabel!
    @IBOutlet var imageAlbumPhoto: UIImageView!
    @IBOutlet var buttonMain: UIButton!
   
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
        imageAlbumPhoto.contentMode = UIView.ContentMode.scaleAspectFit
//        viewMain.layer.shadowColor = UIColor.blackColor().CGColor
//        viewMain.layer.shadowOpacity = 1
//        viewMain.layer.shadowOffset = CGSizeZero
//        viewMain.layer.shadowRadius = 1
//        viewMain.backgroundColor=UIColor.whiteColor()
    }
    
    func configureCellServicesProviderList(_ dict:NSDictionary)
    {
        lableTitle.isHidden=true
        
        print(dict)
        let varDescription=(dict.value(forKey: "description")as! String)
        let varPhotoId=(dict.value(forKey: "photoId")as! String)
        let varUrl=(dict.value(forKey: "url")as! String)
        print("image url is:--",varUrl)
        
        
        
        let ImageProfilePic:String = varUrl.replacingOccurrences(of: " ", with: "%20")
        let checkedUrl = URL(string: ImageProfilePic)
        self.imageAlbumPhoto.sd_setImage(with: checkedUrl)
        
        
        //imageAlbumPhoto.image = UIImage(named:"spain_lang@3x.png")
        print(varDescription)
        /*Asynchronously image loading in tableview start*/
       // ImageLoader.sharedLoader.imageForUrl(varUrl, completionHandler:{(image: UIImage?, url: String) in
           // self.imageAlbumPhoto.image = image
        //})
    }
}
