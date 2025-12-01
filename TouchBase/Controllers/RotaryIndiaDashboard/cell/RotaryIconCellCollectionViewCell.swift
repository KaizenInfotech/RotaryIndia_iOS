//
//  RotaryIconCellCollectionViewCell.swift
//  TouchBase
//
//  Created by IOS 2 on 09/10/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit

class RotaryIconCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 8
    }

}
