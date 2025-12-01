//
//  EditProfileDynamicNewViewControllerViewControllerTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 01/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class EditProfileDynamicNewViewControllerViewControllerTableViewCell: UITableViewCell
{

    
    
    @IBOutlet weak var buttonSelectCountryID_FamilyAddress: UIButton!
    @IBOutlet weak var buttonRelationship_FamilyAddress: UIButton!
    @IBOutlet weak var buttonDOB_FamilyAddress: UIButton!
    @IBOutlet weak var buttonBloodGroup_FamilyAddress: UIButton!
    
    //buttonSelectCountryID_FamilyAddress,buttonRelationship_FamilyAddress,buttonDOB_FamilyAddress,buttonSelectCountryID_FamilyAddress
    
    
    @IBOutlet weak var viewFamilyMemberDetails: UIView!
    @IBOutlet weak var textFieldName_FamilyDetail: UITextField!
    @IBOutlet weak var textFieldEmailId_FamilyDetail: UITextField!
    @IBOutlet weak var textfieldCountryId_FamilyDetail: UITextField!
    @IBOutlet weak var textfieldMobileNumber_FamilyDetail: UITextField!
    @IBOutlet weak var textfieldRelationship_FamilyDetail: UITextField!
    @IBOutlet weak var textfieldDOB_FamilyDetail: UITextField!
    @IBOutlet weak var textFieldBloodGroup_FamilyDetail: UITextField!
    @IBOutlet weak var buttonAddNewFamilyMemebr_FamilyDetail: UIButton!
    //height 395
    
    
    
    @IBOutlet weak var textviewAddress: UITextView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    
    
    @IBOutlet weak var viewAddressDetail: UIView!
    
    @IBOutlet weak var textfieldCity: UITextField!
    @IBOutlet weak var textfieldPincode: UITextField!
    @IBOutlet weak var textfieldState: UITextField!
    @IBOutlet weak var textfieldCountry: UITextField!
    @IBOutlet weak var textfieldAddressCountryDownArrow: UITextField!
    @IBOutlet weak var buttonAddressCountry: UIButton!
    @IBOutlet weak var labelAddressType: UILabel!
    
    
    @IBOutlet weak var textfieldDownArrow: UITextField!
    @IBOutlet weak var buttonDisableNameEmailMobile: UIButton!
    @IBOutlet weak var buttonBloodGroup: UIButton!
    @IBOutlet weak var buttonSelectCountry: UIButton!
    @IBOutlet weak var buttonDOB: UIButton!
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var textFieldValue: UITextField!
    @IBOutlet weak var textFieldCountryCode: UITextField!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        viewFamilyMemberDetails.ThreeDView()
        
        
        textviewAddress!.layer.borderWidth = 1
        textviewAddress!.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
