//
//  ScreenShotTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 11/01/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class ScreenShotTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewHeader: UIView!
    
    //1.
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageMain: UIImageView!
    //2.
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    //3.
    @IBOutlet weak var viewVenue: UIView!
    @IBOutlet weak var labelVenue: UILabel!
    //4.
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var labelDate: UILabel!
    //5.
    @IBOutlet weak var viewLink: UIView!
    @IBOutlet weak var labelLink: UILabel!
    //6.
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var labelTotalYesNoMayBe: UILabel!
    
    @IBOutlet weak var labelTextRed: UILabel!
    
    
    @IBOutlet weak var textviewDescription: UITextView!
    
    
    @IBOutlet weak var textviewVenue: UITextView!
    //--------
    
    @IBOutlet weak var imageUpper: UIImageView!
    
    
    @IBOutlet weak var imageLower: UIImageView!
    
    
  
    @IBOutlet weak var viewBottom: UIView!
    
    
    @IBOutlet weak var viewLower: UIView!
    
    
    @IBOutlet weak var labelHeadercluborDistrictName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textviewDescription.isScrollEnabled=false
        textviewVenue.isScrollEnabled=false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //-------
}
