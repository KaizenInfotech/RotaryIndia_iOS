//
//  CustomEventTableViewCell.swift
//  TouchBase
//
//  Created by Deepak on 27/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CustomEventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textfieldRepeatSelectDate: UITextField!
    @IBOutlet weak var textfieldRepeatSelectTime: UITextField!
    
    @IBOutlet weak var buttonRemoveRepeatedCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textfieldRepeatSelectTime.attributedPlaceholder = NSAttributedString(string:"Select Time",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        textfieldRepeatSelectDate.attributedPlaceholder = NSAttributedString(string:"Select Date",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
