//
//  AnnsAnnestVisitorsTableViewCell.swift
//  TouchBase
//
//  Created by tt on 11/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class AnnsAnnestVisitorsTableViewCell: UITableViewCell,UITextFieldDelegate {

    
    //1....
    @IBOutlet weak var labelAnnsAnnestVisitors: UILabel!
    @IBOutlet weak var buttonDecrease: UIButton!
    @IBOutlet weak var textfieldValue: UITextField!
    @IBOutlet weak var buttonIncrease: UIButton!
    //2....
    
    @IBOutlet weak var labelSecondAnnsAnnestVisitors: UILabel!
    @IBOutlet weak var textfieldSecondValue: UITextField!
    @IBOutlet weak var buttonMinus: UIButton!
    
    //3.
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewSecond: UIView!
    
    
    //4.later addon textfield for visitors
    @IBOutlet weak var textfieldThirdValue: UITextField!
    
    
    
    @IBOutlet weak var textfieldFour: UITextField!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfieldValue.isUserInteractionEnabled=false
       // textfieldSecondValue.delegate=self
        textfieldSecondValue.autocorrectionType = .no
        
        
        //textfieldThirdValue.delegate=self
        //textfieldThirdValue.autocorrectionType = .No
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
