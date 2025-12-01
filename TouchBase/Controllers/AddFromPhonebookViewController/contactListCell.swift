//
//  contactListCell.swift
//  TouchBase
//
//  Created by Umesh on 26/08/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class contactListCell: UITableViewCell
{
    
    @IBOutlet var contactLbl: UILabel!
    @IBOutlet var phoneNoLbl: UILabel!
    @IBOutlet var checkMarkBtn: UIButton!
    
    @IBOutlet var codeForCountryLbl: UILabel!
    
    override func awakeFromNib() {
        
        checkMarkBtn.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
        
    }
    @IBAction func checkMarkBtnAction(_ sender: AnyObject)
    {
        if checkMarkBtn.currentImage!.isEqual(UIImage(named: "UN_CHECK_BLUE_ROW"))
        {
            //do something here
            checkMarkBtn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside if")
            //            checkMarkBtn.tag = indexPath.row
            //            print("cell.checkMarkBtn.tag \(checkMarkBtn.tag)")
            
        }
        else
        {
            checkMarkBtn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("outside if")
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
