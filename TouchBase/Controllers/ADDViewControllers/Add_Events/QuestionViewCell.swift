//
//  QuestionViewCell.swift
//  TouchBase
//
//  Created by Kaizan on 26/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class QuestionViewCell: UITableViewCell {
    
    
    @IBOutlet var QuestionTitleLabel: UILabel!
    @IBOutlet var Option1Label: UILabel!
    @IBOutlet var Option2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
    }
    
}

