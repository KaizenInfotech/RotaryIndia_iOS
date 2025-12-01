//
//  SErviceDetCell.swift
//  TouchBase
//
//  Created by Umesh on 21/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class SErviceDetCell: UITableViewCell {
  @IBOutlet var keyLabel: UILabel!
      @IBOutlet var valLabel: UILabel!
    
    
    @IBOutlet var textviewDescriptionOrAddress: UITextView!
    
    
    @IBOutlet var buttonLongPress: UIButton!
    
     @IBOutlet var fun1btn: UIButton!
    @IBOutlet var fun2btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
