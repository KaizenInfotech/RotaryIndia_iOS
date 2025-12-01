//
//  EventDetailNotiiTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 05/04/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class EventDetailNotiiTableViewCell: UITableViewCell {

    
    
    //1.
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageMain: UIImageView!
    
  
    @IBOutlet weak var buttonImageFullView: UIButton!
    
    //2.
    @IBOutlet weak var viewTitleLinkDate: UIView!
    @IBOutlet weak var labelLink: UILabel!
    @IBOutlet weak var buttonLink: UIButton!
    @IBOutlet weak var labelTitleDate: UILabel!
    //3.
    @IBOutlet weak var viewVenue: UIView!
    @IBOutlet weak var buttonLocation: UIButton!
    @IBOutlet weak var textviewVenue: UITextView!
    //4.
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var textviewDescription: UITextView!
    //5.
    @IBOutlet weak var viewBottomBar: UIView!
    
    @IBOutlet weak var labelYesNoMaybe: UILabel!
    @IBOutlet weak var labelResponse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
