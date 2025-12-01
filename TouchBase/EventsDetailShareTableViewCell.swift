//
//  EventsDetailShareTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 09/05/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class EventsDetailShareTableViewCell: UITableViewCell {

    
    //1.
   // @IBOutlet weak var viewHeader: UIView!
  //  @IBOutlet weak var imageHeader: UIImageView!
//    @IBOutlet weak var labelHeaderOne: UILabel!
//    @IBOutlet weak var labelHeaderTwo: UILabel!
    //2.
    @IBOutlet weak var viewMainImage: UIView!
    @IBOutlet weak var imageMain: UIImageView!
    //3.
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    //4.
    @IBOutlet weak var viewLink: UIView!
    @IBOutlet weak var buttonLink: UIButton!
    //5.
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var labelDate: UILabel!
    //6.
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var textviewDescription: UITextView!
    //7.
    @IBOutlet weak var viewVenue: UIView!
    @IBOutlet weak var textviewVeune: UITextView!
    //8.
//    @IBOutlet weak var viewResponse: UIView!
//    @IBOutlet weak var labelResponse: UILabel!
//    @IBOutlet weak var labelYesNoMaybe: UILabel!
//    //9.
//    @IBOutlet weak var viewFooter: UIView!
//    @IBOutlet weak var imageFooter: UIImageView!
//    @IBOutlet weak var labelFooterOne: UILabel!
//    @IBOutlet weak var labelFooterTwo: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
