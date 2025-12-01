//
//  DeletePhotoCell.swift
//  TouchBase
//
//  Created by rajendra on 01/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SDWebImage

class DeletePhotoCell: UICollectionViewCell
{
    
    @IBOutlet var lableTitle: UILabel!
    @IBOutlet var imageAlbumPhoto: UIImageView!
    @IBOutlet var buttonMain: UIButton!
    @IBOutlet weak var buttonDeletePhoto: UIButton!
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
//        buttonDeletePhoto.layer.borderWidth = 1.0
//        buttonDeletePhoto.layer.masksToBounds = false
//        buttonDeletePhoto.layer.borderColor = UIColor.whiteColor().CGColor
//        buttonDeletePhoto.layer.cornerRadius = buttonDeletePhoto.frame.size.width/2
//        buttonDeletePhoto.clipsToBounds = true
    }
    
    
    
    func configureCellServicesProviderList(_ dict:NSDictionary)
    {
        print(dict)
        let varDescription=(dict.value(forKey: "description")as! String)
        let varPhotoId=(dict.value(forKey: "photoId")as! String)
        let varUrl=(dict.value(forKey: "url")as! String)
        print("image url is:--",varUrl)
        //imageAlbumPhoto.image = UIImage(named:"spain_lang@3x.png")
        print(varDescription)
        
        let ImageProfilePic:String = varUrl.replacingOccurrences(of: " ", with: "%20")
        let checkedUrl = URL(string: ImageProfilePic)
        self.imageAlbumPhoto.sd_setImage(with: checkedUrl)
        
        
        
        /*Asynchronously image loading in tableview start*/
        //ImageLoader.sharedLoader.imageForUrl(varUrl, completionHandler:{(image: UIImage?, url: String) in
         //   self.imageAlbumPhoto.image = image
       // })
    }
    
}
