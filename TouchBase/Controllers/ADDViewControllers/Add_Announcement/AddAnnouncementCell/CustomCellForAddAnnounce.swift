//
//  CustomCellForAddAnnounce.swift
//  DemoDataBase
//
//  Created by kaizen on 15/03/2017.
//  Copyright © 2017 Goora. All rights reserved.
//

import UIKit

class CustomCellForAddAnnounce: UITableViewCell {

    @IBOutlet weak var textfieldRepeatSelectTime: UITextField!
    @IBOutlet weak var textfieldRepeatSelectDate: UITextField!
    @IBOutlet weak var buttonRemoveSelectDateAndTimeFromTable: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textfieldRepeatSelectTime.attributedPlaceholder = NSAttributedString(string:"Select Time",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        textfieldRepeatSelectDate.attributedPlaceholder = NSAttributedString(string:"Select Date",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
