//
//  PersonalEditCell.swift
//  TouchBase
//
//  Created by Umesh on 22/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class PersonalEditCell: UITableViewCell {
     @IBOutlet var ProfileLabel: UILabel!
     @IBOutlet var profileInputText: UITextField!
     @IBOutlet var countryInputText: UITextField!
    
    var uniquekey:NSString!
    var colType:NSString!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
