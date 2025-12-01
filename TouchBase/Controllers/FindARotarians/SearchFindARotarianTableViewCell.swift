//
//  SearchFindARotarianTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 20/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class SearchFindARotarianTableViewCell: UITableViewCell
{
    @IBOutlet weak var buttonUnderLine: UIButton!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonMain: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code

        imageUser.layer.borderWidth = 1.0
        imageUser.layer.masksToBounds = false
        imageUser.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imageUser.layer.cornerRadius = imageUser.frame.size.width/2
        imageUser.clipsToBounds = true 
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
