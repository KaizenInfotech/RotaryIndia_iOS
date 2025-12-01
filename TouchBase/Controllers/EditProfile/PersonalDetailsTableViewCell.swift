//
//  PersonalDetailsTableViewCell.swift
//  TouchBase
//
//  Created by IOS 2 on 05/10/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var mailTwoTF: UITextField!
    @IBOutlet weak var mailOneTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
