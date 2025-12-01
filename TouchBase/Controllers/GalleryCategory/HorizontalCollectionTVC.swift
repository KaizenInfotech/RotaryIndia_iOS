//
//  HorizontalCollectionTVC.swift
//  TouchBase
//
//  Created by tt on 17/10/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class HorizontalCollectionTVC: UITableViewCell {

    var muarrayForFiveDetailsKey:NSMutableArray=NSMutableArray()
  
    @IBOutlet weak var collectionhorizontal: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillInfo(selectArray:NSMutableArray?){
        muarrayForFiveDetailsKey = selectArray!
        print(muarrayForFiveDetailsKey)
        collectionhorizontal.reloadData()
        
    }
    
    //MARK:- collection delegate AS Grid
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayForFiveDetailsKey.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let  ccell = collectionhorizontal.dequeueReusableCell(withReuseIdentifier: "HorizontalCVC", for: indexPath) as! HorizontalCVC
        ccell.viewHori.layer.cornerRadius = 10
        
        if(muarrayForFiveDetailsKey.count>0)
        {
            ccell.lbl1.text = (muarrayForFiveDetailsKey.object(at: indexPath.row) as! String)
          
            
        }
       
        if(indexPath.row == 0)
        {
            ccell.viewHori.backgroundColor = UIColor(red:1.00, green:0.58, blue:0.22, alpha:1.0)
            
        }
        else if(indexPath.row == 1)
        {
            ccell.viewHori.backgroundColor = UIColor(red:0.54, green:0.75, blue:0.30, alpha:1.0)
        }
        else if(indexPath.row == 2)
        {
            ccell.viewHori.backgroundColor = UIColor(red:0.98, green:0.35, blue:0.32, alpha:1.0)
        }
        else if(indexPath.row == 3)
        {
            ccell.viewHori.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
        }
        else if(indexPath.row == 4)
        {
            ccell.viewHori.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.68, alpha:1.0)
        }
        else
        {
            
        }
       
        return ccell
    }
    

}
