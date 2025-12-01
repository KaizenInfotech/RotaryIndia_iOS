//
//  AttendanceEditTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 19/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class AttendanceEditTableViewCell: UITableViewCell {

    //1.
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var labelAttendanceName: UILabel!
    @IBOutlet weak var labelDateTime: UILabel!
    //2.
    @IBOutlet weak var textviewDescription: UITextView!
    //3.
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var buttonMain: UIButton!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
