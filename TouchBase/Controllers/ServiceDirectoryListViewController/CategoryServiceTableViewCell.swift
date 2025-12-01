//
//  CategoryServiceTableViewCell.swift
//  TouchBase
//
//  Created by Umesh on 20/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CategoryServiceTableViewCell: UITableViewCell {

    @IBOutlet var viewMain: UIView!
    @IBOutlet var labelCategoryName: UILabel!
    @IBOutlet var buttonMain: UIButton!
    
    
    @IBOutlet weak var labelMemberDesignation: UILabel!
    
    
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var buttonMainSecond: UIButton!
    @IBOutlet weak var imageUSerImages: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
//viewMain.ThreeDView()
        // Configure the view for the selected state
    }

}
