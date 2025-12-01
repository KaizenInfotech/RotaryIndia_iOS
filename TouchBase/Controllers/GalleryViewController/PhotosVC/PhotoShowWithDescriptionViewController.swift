//
//  PhotoShowWithDescriptionViewController.swift
//  TouchBase
//
//  Created by rajendra on 19/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit


class PhotoShowWithDescriptionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    var varGroupId:String!=""
    var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
    var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
    var muarrayHoldingPhotoId:NSMutableArray=NSMutableArray()
    
    var muarrayImage:NSArray=NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        muarrayImage = ["","",""]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoWithDescriptionCollectionViewCell", for: indexPath) as! PhotoWithDescriptionCollectionViewCell
        if(muarrayImage.count>0)
        {
           let abc = muarrayImage.object(at: indexPath.row) as! String
            print(abc)
            
            print("************************************",abc)
            
            if abc == ""
            {
                cell.imageForAlbums.image = UIImage(named: "profile_pic")
            }
            else
            {
                //                let varGetImageUrl:String=directoryList.objectForKey("pic") as! String
                //                print(varGetImageUrl)
                let url = URL(string: abc)
                /*
                KingfisherManager.sharedManager.retrieveImageWithURL(url!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    print(image)
                    cell.imageForAlbums.image = image
                })
                */
                
                
                var varGetImage:String!=abc
                let ImageProfilePic:String = varGetImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imageForAlbums.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                
                
                
                
                
            }
        }
        return cell
    }


}
