//
//  subGroupCell.swift
//  TouchBase
//
//  Created by Kaizan on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class subGroupCell: UITableViewCell {
    
    @IBOutlet var groupName: UILabel!
    @IBOutlet var noOfMembersLabel: UILabel!
    @IBOutlet var noResult: UILabel!
    let boundss = UIScreen.main.bounds
    
    @IBOutlet var chkBTn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.chkBTn.translatesAutoresizingMaskIntoConstraints = true
        self.chkBTn.frame=CGRect(x: ((boundss.size.width)-50), y: 5, width: 40, height: 40)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

