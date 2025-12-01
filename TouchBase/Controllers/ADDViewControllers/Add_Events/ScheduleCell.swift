//
//  ScheduleCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    //@IBOutlet var LanguageLabel: UILabel!
    
    
    @IBOutlet weak var textfieldEventDateTemp: UITextField!
    
    
    
    @IBOutlet var dateTimeTitleLabel: UILabel!
    
    @IBOutlet var timeButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    var addedDate:Foundation.Date!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        
        //textfieldEventDateTemp!.layer.borderWidth = 1
       // textfieldEventDateTemp!.layer.borderColor = UIColor.lightGray.cgColor
        
        
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


