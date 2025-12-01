//
//  AllInformationTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 31/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class AllInformationTableViewCell: UITableViewCell {
    
    
    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 0
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 0
    @IBOutlet weak var labelKeyFirst: UILabel!
    
    @IBOutlet weak var buttonValueFirst: UIButton!
    
    
    @IBOutlet weak var textviewAddressorFamilyMember: UITextView!
    
    
    @IBOutlet weak var viewFamilyImage: UIView!
    
    @IBOutlet weak var imageFamilyImage: UIImageView!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        imageFamilyImage.contentMode = .scaleAspectFit
        imageFamilyImage.layer.cornerRadius = imageFamilyImage.frame.width / 2
        
        
        //textviewAddressorFamilyMember.
        self.setNeedsLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
