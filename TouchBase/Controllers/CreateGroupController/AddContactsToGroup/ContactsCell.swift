//
//  ContactsCell.swift
//  TouchBase
//
//  Created by Kaizan on 03/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {
    
    //@IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var contactNameLabel: UILabel!
    
    @IBOutlet var contactNumberLabel: UILabel!
    
    let boundss = UIScreen.main.bounds
    @IBOutlet var chkBTn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.chkBTn.translatesAutoresizingMaskIntoConstraints = true
        self.chkBTn.frame=CGRect(x: ((boundss.size.width)-50), y: 5, width: 40, height: 40)
        self.chkBTn.backgroundColor = UIColor.clear
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
