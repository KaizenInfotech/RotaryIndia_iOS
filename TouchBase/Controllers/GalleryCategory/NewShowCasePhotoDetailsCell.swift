//
//  NewShowCasePhotoDetailsCell.swift
//  TouchBase
//
//  Created by tt on 12/07/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewShowCasePhotoDetailsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblDesc.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
