//
//  DocumentDownloadableTableViewCell.swift
//  TouchBase
//
//  Created by Umesh on 04/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class DocumentDownloadableTableViewCell: UITableViewCell {

    
    @IBOutlet var labelDocsName: UILabel!
    
    
    @IBOutlet var buttonMain: UIButton!
    @IBOutlet var viewMain: UIView!
    
    @IBOutlet var imageDocs: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // viewMain.ThreeDView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
