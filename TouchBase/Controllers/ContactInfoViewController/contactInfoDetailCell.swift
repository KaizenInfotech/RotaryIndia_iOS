//
//  contactInfoDetailCell.swift
//  TouchBase
//
//  Created by Umesh on 30/08/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class contactInfoDetailCell: UITableViewCell
{
    @IBOutlet var editContactView: UIView!
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var mobileNumberTxtField: UITextField!
    @IBOutlet var countryCodeTxtField: UITextField!
    @IBOutlet var countryBtn: UIButton!
    @IBOutlet var seperatorImgView: UIImageView!
    @IBAction func countryBtnAction(_ sender: AnyObject)
    {
        
    }
    
    
    @IBOutlet var confirmBtn: UIButton!
    @IBAction func confirmBtnAction(_ sender: AnyObject)
    {
        
    }
    @IBOutlet var personName: UILabel!

    @IBOutlet var personContact: UILabel!
    @IBOutlet var countryCode: UILabel!
    @IBOutlet var editBtn: UIButton!
    
    @IBAction func editBtnAction(_ sender: AnyObject)
    {
       layoutSubviews()
    }
   
    @IBOutlet var deleteBtn: UIButton!
    @IBAction func deleteBtnAction(_ sender: AnyObject)
    {
        
    }
}
