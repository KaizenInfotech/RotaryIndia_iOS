//
//  ModulesListCell.swift
//  TouchBase
//
//  Created by Kaizan on 20/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol moduleInfocellDelegate
{
    @objc optional func moduleInfoclk(_ moduleInfo:NSString,modNAme:NSString)
}

class ModulesListCell: UITableViewCell {
    let boundss = UIScreen.main.bounds
    @IBOutlet var modulesLabel: UILabel!
    @IBOutlet var chkBTn:UIButton!
    var moduleInfo:NSString!
    var delegates : moduleInfocellDelegate?
    @IBOutlet var modulesInfoButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.chkBTn.translatesAutoresizingMaskIntoConstraints = true
        self.chkBTn.frame=CGRect(x: ((boundss.size.width)-50), y: 5, width: 40, height: 40)
    }
    
    @IBAction func moduleInfoClik(){
        self.delegates?.moduleInfoclk!(self.moduleInfo,modNAme: modulesLabel.text! as NSString)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


