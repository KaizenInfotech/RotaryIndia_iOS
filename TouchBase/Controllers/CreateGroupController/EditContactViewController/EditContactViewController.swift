//
//  EditContactViewController.swift
//  TouchBase
//
//  Created by Umesh on 07/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var EditNameField: UITextField!
    @IBOutlet var EditPhoneNumberField: UITextField!
   let bounds = UIScreen.main.bounds
    
    @IBOutlet var codeLabel: UILabel!
    
    var tagIndex = Int()
    var ContactName : String = ""
    var ContactNumber : String = ""
    @IBOutlet var DoneButtonAction: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //   self.view.userInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryName")
        let code    =  defaults.object(forKey: "countryCode") as! String
       // countryID = (defaults.valueForKey("countryId") as! String?)!
        print(country)
        print(code)
        
        if (code == "")
        {
            if codeLabel.text == ""
            {
                codeLabel.text = "+91"
            }
            let defaults = UserDefaults.standard
            defaults.set("1", forKey: "countryId")
            defaults.synchronize()
            
           // countryID = "1"
        }
        else
        {
            
            codeLabel.text = code
            print(code)
            
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode")
            defaults.set("", forKey: "countryId")
            defaults.synchronize()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        
        EditNameField.text = ContactName
        
        let numberArr = ContactNumber.characters.split{$0 == " "}.map(String.init)
        
        print(numberArr.count)
        print(numberArr)
        
        if numberArr.count == 2
        {
            codeLabel.text = numberArr[0]
            EditPhoneNumberField.text = numberArr[1]
        }
        else
        {
            EditPhoneNumberField.text = numberArr[0]
        }

        
        
        self.addDoneButtonOnKeyboard()
        
    }

    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Edit Contact"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EditContactViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func SelectCountryAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
    }

    @IBAction func DoneButtonAction(_ sender: AnyObject)
    {
        let NaMe : NSArray = UserDefaults.standard.array(forKey: "EditcontactNameForGroup")! as NSArray
        let MobileNum : NSArray = UserDefaults.standard.array(forKey: "EditcontactNumberForGroup")! as NSArray
  //      print(NaMe)
 //       print(MobileNum)
        
        let NameArray = NaMe.mutableCopy()as! NSMutableArray
        let numberArray = MobileNum.mutableCopy()as! NSMutableArray
        
 //       print(NameArray)
  //      print(numberArray)
        
        
        
        
        NameArray.removeObject(at: tagIndex)
        numberArray.removeObject(at: tagIndex)
        
        if EditNameField.text == "" && EditPhoneNumberField.text == ""
        {
            
        }
        else
        {
            
            let cpmtNumber = String(format:"%@ %@",codeLabel.text!,EditPhoneNumberField.text!)
            
            NameArray.insert(EditNameField.text!, at: tagIndex)
            numberArray.insert(cpmtNumber, at: tagIndex)
        }
        
        
         UserDefaults.standard.set(NameArray, forKey: "EditcontactNameForGroup")
         UserDefaults.standard.set(numberArray, forKey: "EditcontactNumberForGroup")
        
        self.navigationController?.popViewController(animated: true)
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool
     {
        EditNameField.resignFirstResponder()
        EditPhoneNumberField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == EditPhoneNumberField
        {
            if (range.length + range.location > (textField.text?.characters.count)! )
            {
                return false;
            }
            
            let newLength = (textField.text?.characters.count)! + (string.characters.count) - range.length
            return newLength <= 10
        }
        else
        {
            return true
        }
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditContactViewController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        EditPhoneNumberField.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        let width = bounds.size.width
        if(width <= 320.0)
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
            
        }
        else
        {
        }
        
        EditNameField.resignFirstResponder()
        EditPhoneNumberField.resignFirstResponder()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
