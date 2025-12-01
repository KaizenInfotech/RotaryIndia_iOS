//
//  EditUpdateProfileTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 27/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class EditUpdateProfileTableViewCell: UITableViewCell , UITextFieldDelegate {
    
    
    
    @IBOutlet weak var viewFirstKeyValue: UIView!
    @IBOutlet weak var viewSecondBusinessPersonalAddress: UIView!
    @IBOutlet weak var viewThreeFamilyDetails: UIView!
    // @IBOutlet weak var viewFour: UIView!
    @IBOutlet var seondmobileTX: UITextField!
    
    
    //view first
    @IBOutlet weak var labelKeyFirst: UILabel!
    @IBOutlet weak var textfieldValueFirst: UITextField!
    @IBOutlet weak var textfieldCountryCodeFirst: UITextField!
    @IBOutlet weak var buttonSelectCountry: UIButton!
    
    @IBOutlet weak var buttonBirthAnnivBG: UIButton!
    
    
    @IBOutlet weak var labelHeadingFirst: UILabel!
    
    //view second
    @IBOutlet weak var labelAddressSecond: UILabel!
    @IBOutlet weak var textviewAddressSecond: UITextView!
    @IBOutlet weak var textfieldCitySecond: UITextField!
    @IBOutlet weak var textfieldPostalCodeSecond: UITextField!
    @IBOutlet weak var textfieldStateSecond: UITextField!
    @IBOutlet weak var textfieldCountrySecond: UITextField!
    @IBOutlet weak var buttonCountrySecond: UIButton!
    
    
    @IBOutlet weak var labelBusinessorResiScond: UILabel!
    @IBOutlet weak var textfieldBusinessorResSecond: UITextField!
    @IBOutlet weak var textfieldBusinessorResContactNoSecond: UITextField!
    
    @IBOutlet weak var buttonBusinessorResiContactNoSecond: UIButton!
    
    
    //view three
    @IBOutlet weak var labelNameThree: UILabel!
    @IBOutlet weak var textfieldNameThree: UITextField!
    @IBOutlet weak var textfieldRelationshipThree: UITextField!
    @IBOutlet weak var buttonRelationThree: UIButton!
    @IBOutlet weak var textfieldCountryCodeThree: UITextField!
    @IBOutlet weak var buttonCountryCodeThree: UIButton!
    @IBOutlet weak var textfieldMobileNumberThree: UITextField!
    @IBOutlet weak var textfieldEmailIdThree: UITextField!
    @IBOutlet weak var textfieldBloodGroup: UITextField!
    @IBOutlet weak var buttonBloodGroupThree: UIButton!
    @IBOutlet weak var textfieldBirthdayThree: UITextField!
    @IBOutlet weak var buttonBirthdayThree: UIButton!
    @IBOutlet weak var textfieldAnniversaryThree: UITextField!
    @IBOutlet weak var buttonAnniversaryThree: UIButton!
    @IBOutlet weak var buttonAddAnotherFamilyMemberThree: UIButton!
    
    //view four
    //  @IBOutlet weak var buttonAddNewFamilyMemberNew: UIButton!
    
    
    
    @IBOutlet weak var viewTempForThree: UIView!
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var labelPlaceHolder: UILabel!
    
    
    @IBOutlet weak var buttonDeleteFamilyMember: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // textfieldBusinessorResContactNoSecond.delegate=self
        //addDoneButtonOnKeyboard()
        
        let imageView = UIImageView(image: UIImage(named: "downArrowCalendar"))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        textfieldCountrySecond.rightViewMode = UITextField.ViewMode.always
        textfieldCountrySecond.rightView = imageView
        
        
        
        
        labelPlaceHolder.isHidden=true
        viewFirstKeyValue.ThreeDView()
        viewSecondBusinessPersonalAddress.ThreeDView()
        
        viewThreeFamilyDetails.ThreeDView()
        
        textviewAddressSecond!.layer.borderWidth = 1
        textviewAddressSecond!.layer.borderColor = UIColor.lightGray.cgColor
        
        
        textviewAddressSecond.clipsToBounds = true;
        textviewAddressSecond.layer.cornerRadius = 5.0;
        
        // Initialization code
        
        
        
        //d/fs/f/sdf/s/sf/sdf/sd/fsd/s/d
        textfieldValueFirst.returnKeyType = .done
        textfieldCountryCodeFirst.returnKeyType = .done
        textviewAddressSecond.returnKeyType = .next
        textfieldCitySecond.returnKeyType = .done
        textfieldPostalCodeSecond.returnKeyType = .done
        textfieldStateSecond.returnKeyType = .done
        textfieldCountrySecond.returnKeyType = .done
        textfieldBusinessorResSecond.returnKeyType = .done
        textfieldBusinessorResContactNoSecond.returnKeyType = .done
        textfieldNameThree.returnKeyType = .done
        textfieldRelationshipThree.returnKeyType = .done
        textfieldCountryCodeThree.returnKeyType = .done
        textfieldMobileNumberThree.returnKeyType = .done
        textfieldEmailIdThree.returnKeyType = .done
        textfieldBloodGroup.returnKeyType = .done
        textfieldBirthdayThree.returnKeyType = .done
        textfieldAnniversaryThree.returnKeyType = .done
        
        //sdf/ds/fsd/fs/df/sd/fs
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
  //////////////////////////////////////Code by DPK///////////////////////////////////////////////////////////
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.textfieldPostalCodeSecond.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditUpdateProfileTableViewCell.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        textfieldPostalCodeSecond.inputAccessoryView=doneToolbar
        textfieldBusinessorResContactNoSecond.inputAccessoryView=doneToolbar
        textfieldMobileNumberThree.inputAccessoryView=doneToolbar
        textfieldValueFirst.inputAccessoryView=doneToolbar
    }
    @objc func doneButtonAction()
    {
        textfieldPostalCodeSecond.resignFirstResponder()
        textfieldBusinessorResContactNoSecond.resignFirstResponder()
        textfieldMobileNumberThree.resignFirstResponder()
        textfieldValueFirst.resignFirstResponder()
    }

    

    
    //MARK:- keyboard
//    func textFieldDidBeginEditing(textField: UITextField)
//    {
//       if (textField==textfieldBusinessorResContactNoSecond)
//        {
//            animateViewMoving(true, moveValue: 100)
//        }
//        else
//        {
//            animateViewMoving(true, moveValue: 100)
//        }
//        
//        
//                /*
//         if(textField==textField)
//         {
//         animateViewMoving(true, moveValue: 0)
//         }
//         else
//         {
//         animateViewMoving(true, moveValue: 100)
//         }
//         */
//    }
//    func textFieldDidEndEditing(textField: UITextField)
//    {
//        
//       if (textField==textfieldBusinessorResContactNoSecond)
//        {
//            animateViewMoving(true, moveValue: -100)
//        }
//        else
//        {
//            animateViewMoving(true, moveValue: 100)
//        }
//        
////        if(textfieldValueFirst.placeholder=="Email")
////        {
////            let isValid = isValidEmail(textfieldValueFirst.text!)
////            if isValid==false
////            {
////                
////                textfieldValueFirst.attributedPlaceholder = NSAttributedString(string: "Please Enter Valid EmailID.", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
////                
////            }
////        }
//        /*
//         if(textField==textField)
//         {
//         animateViewMoving(false, moveValue: 0)
//         }
//         else
//         {
//         animateViewMoving(false, moveValue: 100)
//         }
//         
//         */
//    }
//    func animateViewMoving (up:Bool, moveValue :CGFloat)
//    {
//        var movementDuration:NSTimeInterval = 0.3
//        var movement:CGFloat = ( up ? -moveValue : moveValue)
//        UIView.beginAnimations( "animateView", context: nil)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        UIView.setAnimationDuration(movementDuration )
//        viewSecondBusinessPersonalAddress.frame = CGRectOffset(viewSecondBusinessPersonalAddress.frame, 0,  movement)
//        UIView.commitAnimations()
//    }
//    

    /////////////////////////////////////////////////////////////////////////////////////////////////
 
}
