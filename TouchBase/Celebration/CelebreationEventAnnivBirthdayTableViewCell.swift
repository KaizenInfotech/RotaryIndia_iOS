//
//  CelebreationEventAnnivBirthdayTableViewCell.swift
//  TouchBase
//
//  Created by Umesh on 18/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CelebreationEventAnnivBirthdayTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var buttonEventNewEventss: UIButton!
    
    
    @IBOutlet weak var buttonImageBAE: UIButton!
    
    
    @IBOutlet weak var imageBAE: UIImageView!
    
    
    @IBOutlet weak var buttonMainClickEvent: UIButton!
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelType: UILabel!
    @IBOutlet var lableTime: UILabel!
    
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var labelLine: UILabel!
    
    @IBOutlet weak var buttonCall: UIButton!
    
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    
    
    
    
    
    
    @IBOutlet weak var buttonSMS: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var buttonEventNext: UIButton!
    
    
    @IBOutlet weak var viewAlls: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
