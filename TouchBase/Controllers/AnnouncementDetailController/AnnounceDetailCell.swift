//
//  AnnounceDetailCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
@objc protocol annImgDelegate
{
    @objc optional func EventImgBtnClk(_ imgUrl:NSString)
}

class AnnounceDetailCell: UITableViewCell {
    
    @IBOutlet weak var buttonLink: UIButton!
    
    @IBOutlet weak var labelLink: UILabel!
    
    var imgUrl:NSString!
    @IBOutlet var announceNameLabel: UILabel!
    @IBOutlet var announceDateTimeLabel: UILabel!
    let boundss = UIScreen.main.bounds
    @IBOutlet var announceImage: UIImageView!
    var delegates : annImgDelegate?
    @IBOutlet var imgClkBtn : UIButton!
    @IBOutlet var indicator:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
  self.announceImage.translatesAutoresizingMaskIntoConstraints = true
        self.announceImage.frame=CGRect(x: 0, y: 0, width: boundss.size.width, height: 183)
        indicator.isHidden=true
        // Initialization code
        //contentView.addSubview(imgUser)
    }

    @IBAction func imgClicked(){
        self.delegates?.EventImgBtnClk!(imgUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


