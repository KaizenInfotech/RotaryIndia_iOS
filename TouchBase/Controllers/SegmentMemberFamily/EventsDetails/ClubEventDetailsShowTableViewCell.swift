//
//  ClubEventDetailsShowTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class ClubEventDetailsShowTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var textviewDescription: UITextView!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var buttonAddress: UIButton!
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var buttonTimeMain: UIButton!
    @IBOutlet weak var buttonAddressMain: UIButton!
    @IBOutlet weak var buttonTime: UIButton!
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    
    override func awakeFromNib() {
        
        
        
        
       // profilePic.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
       /// profilePic.contentMode = .scaleAspectFit // OR .scaleAspectFill
       // profilePic.clipsToBounds = true
        
      ///
       // profilePic.translatesAutoresizingMaskIntoConstraints = true
      //  profilePic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
        
        
        
        /*
         cell.EventPic.translatesAutoresizingMaskIntoConstraints = true
         cell.EventPic.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 171)
         */
        
        super.awakeFromNib()
        
        
     //   profilePic.contentMode = .scaleAspectFit
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
