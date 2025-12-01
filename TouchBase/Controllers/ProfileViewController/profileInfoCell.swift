//
//  profileInfoCell.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
@objc protocol addrscellDelegate
{
    @objc optional func addrsBtnClk(_ addrDetail:Address)
    @objc optional func withoutAddrsBtnClk()
}

class profileInfoCell: UITableViewCell {
    
    @IBOutlet var ProfileLabel: UILabel!
    @IBOutlet var ProfileDetailLabel: UILabel!
    @IBOutlet var addrEditBtn : UIButton!
    var addrDetail : Address?
    var memberDetail : MemberListDetail!
    var delegates : addrscellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addCellButtonAction(_ sender: AnyObject)
    {
        
        if addrDetail == nil
        {
            self.delegates?.withoutAddrsBtnClk!()
        }
        else
        {
            self.delegates?.addrsBtnClk!(addrDetail!)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

