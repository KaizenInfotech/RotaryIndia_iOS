//
//  RotaryClubCVCell.swift
//  TouchBase
//
//  Created by IOS 2 on 22/09/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit

class RotaryClubCVCell: UICollectionViewCell {
    
    @IBOutlet weak var clubsNameLbl: UILabel!
    @IBOutlet weak var culbsImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 16
        self.culbsImgView.layer.cornerRadius = self.culbsImgView.bounds.size.width / 2.0
        
    }

}
