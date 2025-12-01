//
//  DirectoryCell.swift
//  TouchBase
//
//  Created by Kaizan on 16/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class DirectoryCell: UITableViewCell {
    
    @IBOutlet weak var buttonPicBigViewLater: UIButton!
    
    @IBOutlet weak var buttonPicBigView: UIButton!
    
    
    @IBOutlet weak var viewFamily: UIView!
    @IBOutlet weak var labelFamilyMemberName: UILabel!
    @IBOutlet weak var labelFamilyWithRelationShip: UILabel!
    
    
    @IBOutlet weak var buttonFamilyMain: UIButton!
    
    
    
    @IBOutlet weak var viewClassified: UIView!
    @IBOutlet weak var labelClassified: UILabel!
    @IBOutlet weak var buttonClassified: UIButton!
    
    @IBOutlet weak var classifiedArrow: UIImageView!
    
    @IBOutlet weak var familyArrow: UIImageView!
    
    
    let boundss = UIScreen.main.bounds
    @IBOutlet var nameLabel: UILabel!

    
    @IBOutlet weak var buttonRotarian: UIButton!
    
    
    @IBOutlet weak var familyPics: UIImageView!  //31-08-2017
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var groupsLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        profilePic.layer.borderWidth = 1.0
        profilePic.layer.masksToBounds = false
        profilePic.contentMode = .scaleAspectFit
        profilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

