//
//  MemberListingNewTableViewCell.swift
//  TouchBase
//
//  Created by tt on 12/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class MemberListingNewTableViewCell: UITableViewCell {

    
    
    //1.
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelMemberName: UILabel!
    @IBOutlet weak var labelDesig: UILabel!
    @IBOutlet weak var imageCheckUncheck: UIImageView!
    @IBOutlet weak var buttonMainMember: UIButton!
    @IBOutlet weak var viewMembers: UIView!
    //2.
    @IBOutlet weak var viewAnns: UIView!
    @IBOutlet weak var labelAnns: UILabel!
    //3.
    
    @IBOutlet weak var viewVisiRotaDisThreeinOne: UIView!
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
      //  imageUser.layer.borderWidth = 1
        imageUser.layer.masksToBounds = false
       // imageUser.layer.borderColor = UIColor.blackColor().CGColor
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        imageUser.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
