//
//  ShowCaseAlbumPhtotosShowCollectionViewCell.swift
//  TouchBase
//
//  Created by tt on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class ShowCaseAlbumPhtotosShowCollectionViewCell: UICollectionViewCell {
    
    
    // @IBOutlet var viewMain: UIView!
    @IBOutlet var lableTitle: UILabel!
    @IBOutlet var imageAlbumPhoto: UIImageView!
    @IBOutlet var buttonMain: UIButton!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
        imageAlbumPhoto.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    
    
}
