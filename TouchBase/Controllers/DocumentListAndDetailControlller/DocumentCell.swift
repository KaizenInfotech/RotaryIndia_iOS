//
//  DocumentCell.swift
//  TouchBase
//
//  Created by Umesh on 05/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
    @IBOutlet var docNameLabel: UILabel!
    @IBOutlet var docDateTimeLabel: UILabel!
    
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    
    @IBOutlet var buttonMain: UIButton!
    
   
    
    
    @IBOutlet var buttonView: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
