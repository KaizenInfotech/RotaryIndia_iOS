//
//  AnnounceDescriptionCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class AnnounceDescriptionCell: UITableViewCell {
    
    @IBOutlet var announceDescriptionLabel: UILabel!
    
    @IBOutlet weak var footerImageView: UIImageView!
    
    
    @IBOutlet weak var textDescriptionForAnnounceDetails: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 30.0
        paragraphStyle.maximumLineHeight = 30.0
        paragraphStyle.minimumLineHeight = 30.0
        let ats = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 19.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        //cell.textDescriptionForAnnounceDetails.attributedText = NSAttributedString(string: valmainArray.objectAtIndex(index) as! String, attributes: ats)
        

        
        
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


