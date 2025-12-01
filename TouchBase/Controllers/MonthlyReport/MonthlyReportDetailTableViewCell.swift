//
//  MonthlyReportDetailTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class MonthlyReportDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUnderLineForNotSubmited: UIImageView!
    @IBOutlet weak var labelDateTime: UILabel!
    
    @IBOutlet weak var lblAG: UILabel!
    
    @IBOutlet weak var labelDetail: UILabel!
    
    
    @IBOutlet weak var buttonDownloadPdfDetails: UIButton!
    @IBOutlet weak var buttonEyeShowPdfDeatils: UIButton!
    @IBOutlet weak var buttonMain: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
