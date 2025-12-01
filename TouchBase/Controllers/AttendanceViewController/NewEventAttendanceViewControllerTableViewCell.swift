//
//  NewEventAttendanceViewControllerTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 08/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewEventAttendanceViewControllerTableViewCell: UITableViewCell {
    //1
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var textfieldEventName: UITextField!
    
    //2.
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var textviewDescription: UITextView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    //3.
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var textfieldEventDate: UITextField!
    @IBOutlet weak var textfieldEventTime: UITextField!
    @IBOutlet weak var buttonEventDate: UIButton!
    @IBOutlet weak var buttonEventTime: UIButton!

    @IBOutlet weak var buttonRemoveDateAndTime: UIButton!
    //4.
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var buttonMain: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        textviewDescription.layer.cornerRadius = 5
        textviewDescription.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textviewDescription.layer.borderWidth = 0.5
        textviewDescription.clipsToBounds = true
        
        
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
