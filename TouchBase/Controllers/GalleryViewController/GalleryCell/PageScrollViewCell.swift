//
//  PageScrollViewCell.swift
//  TouchBase
//
//  Created by Umesh on 27/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class PageScrollViewCell: UITableViewCell
{

    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var knowMoreBtn: UIButton!
    @IBAction func knowMoreBtnAction(_ sender: AnyObject)
    {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
