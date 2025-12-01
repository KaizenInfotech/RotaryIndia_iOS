//
//  CreateGroupController.swift
//  TouchBase
//
//  Created by Kaizan on 19/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MapKit
class CreateGroupController: UIViewController , UITextFieldDelegate ,UIPickerViewDelegate,UIPickerViewDataSource , webServiceDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , uploadDocDelegate{
    
    let bounds = UIScreen.main.bounds
    var imagePicker = UIImagePickerController()
    @IBOutlet var newWordField: UITextField!
    
    @IBOutlet var groupNameField: UITextField!
    
    @IBOutlet var websiteField: UITextField!
    @IBOutlet var EmailIDField: UITextField!
    @IBOutlet var adress1Field: UITextField!
    @IBOutlet var address2Field: UITextField!
    @IBOutlet var cityField: NSString! = ""
    @IBOutlet var pincodeField: NSString! = ""
    @IBOutlet var stateField: NSString! = ""
    @IBOutlet var mobileField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    var groupIDEdit = String ()
    var mainArray = NSArray()
    var isClassFrom = String()
    var groupInfoClass = GetGroupInfo()
    var appDelegate : AppDelegate!
    //  var ImgId : String = ""
    var groupCatID : String = ""
    var countryID : String = ""
    var imageCondition = Bool()
    var chosenImage = UIImage()
    var pickerCountry : NSArray = NSArray()
    var pickerCategory : NSArray = NSArray()
    
    
    var userProfileID : String!
    var userGroupID : String!
    
    @IBOutlet var groupImageView: UIImageView!
    
    var picker: UIPickerView = UIPickerView()
    let toolBar = UIToolbar()
    
    @IBOutlet var countryCOdeLbl:UITextField!
    @IBOutlet var countryDD: UITextField!
    @IBOutlet var groupCategoryDD: UITextField!
    @IBOutlet var groupTypeDD: UITextField!
    
    var pickerDataSources = ["Open","Close"]//["White", "Red", "Green", "Blue"]
    //   var pickerCountry = ["India", "Australia","England","NewZeland","Nepal"]
    //   var pickerCategory = ["Personal"]//["Cat1", "cat2","cat3","Cat4","Cat5","cat5","Cat6"]
    var ImgId:NSString!
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    var indicator:UIActivityIndicatorView!
    
    @IBOutlet var addressTextView:UITextView!
    @IBOutlet var addrLbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "eventAddress") as! String
        if (country.characters.count != 0) {
            //eventAddress
          let  venueLat = UserDefaults.standard.value(forKey: "eventLat") as! NSString
           let venueLon = UserDefaults.standard.value(forKey: "eventLon") as! NSString
            addressTextView.text = country
            addrLbl.isHidden=true
            let latitude = (venueLat as NSString).doubleValue
            let longitude = (venueLon as NSString).doubleValue
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude:latitude , longitude:longitude )
            //let loc = CLLocation.ini
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // Address dictionary
                print(placeMark.addressDictionary)
                
                // Location name
                if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                    print(locationName)
                }
                
                // Street address
                if let street = placeMark.addressDictionary!["State"] as? NSString {
                    print(street)
                    self.stateField = street as String as String as NSString
                }
                
                // City
                if let city = placeMark.addressDictionary!["City"] as? NSString {
                    print(city)
                    self.cityField = city as String as String as NSString
                }
                
                // Zip code
                if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                    print(zip)
                    self.pincodeField = zip as String as String as NSString
                }
                
                // Country
                if let country = placeMark.addressDictionary!["Country"] as? NSString {
                    print(country)
                }
              
            })
            defaults.set("", forKey: "eventAddress")
            defaults.set("", forKey: "eventLat")
            defaults.set("", forKey: "eventLon")
            defaults.synchronize()
        }else{
         //   addrLbl.hidden=false
          //  addressTextView.text = ""
        }
    }
    
    func getGroupInfoDetailDelegate(_ grpInfoDetail : TBGetGroupResult)
    {
        
        
        if grpInfoDetail.status == "0"
        {
            
            mainArray = grpInfoDetail.getGroupDetailResult as NSArray
            
            groupInfoClass = mainArray.object(at: 0) as! GetGroupInfo
            
            groupNameField.text = groupInfoClass.grpName
            groupCategoryDD.text = groupInfoClass.grpCategoryName
            groupCatID = groupInfoClass.grpCategory
            
            groupTypeDD.text = groupInfoClass.grpType
            
            EmailIDField.text = groupInfoClass.emailid
          
            mobileField.text = groupInfoClass.mobile
            cityField = groupInfoClass.city as! NSString
            stateField = groupInfoClass.state as! NSString
            pincodeField = groupInfoClass.pincode as! NSString
            countryDD.text = groupInfoClass.countryName
            countryID = groupInfoClass.country
            
            var categoryList = GrpCountryList()
           // categoryList = pickerCategory.objectAtIndex(row) as! GrpCatList
            
            if(pickerCountry.count > 0){
            let bPredicate: NSPredicate = NSPredicate(format: "SELF.countryName == %@", groupInfoClass.countryName)
            var filteredArray = pickerCountry.filtered(using: bPredicate)
           // NSLog("HERE %@", self.filteredArray)
            categoryList = filteredArray[0] as! GrpCountryList
            countryCOdeLbl.text = categoryList.countryCode
            }
            if(groupInfoClass.addrss1 != ""){
               addressTextView.text = groupInfoClass.addrss1
                addrLbl.isHidden=true
            }else{
                addressTextView.text = ""
                addrLbl.isHidden=false
                
            }
            
            if groupInfoClass.grpImage == ""
            {
                
            }
            else
            {
                ImgId = "NO"
                
                if let checkedUrl = URL(string: groupInfoClass.grpImage) {
                    
                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                        DispatchQueue.main.async { () -> Void in
                            guard let data = data, error == nil else { return }
                            print(response?.suggestedFilename ?? "")
                            print("Download Finished")
                            self.groupImageView.image =  UIImage(data: data)
                            
                        }
                    }
                }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        imagePicker.delegate = self
        
        pickerCountry = NSArray()
        pickerCategory = NSArray()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.groupTypeDD.frame.height))
        groupTypeDD.rightView = paddingView
        groupTypeDD.rightViewMode = UITextField.ViewMode.always
        
        
        let paddingViewD = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.groupCategoryDD.frame.height))
        groupCategoryDD.rightView = paddingViewD
        groupCategoryDD.rightViewMode = UITextField.ViewMode.always
        
        
        let paddingViewC = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.countryDD.frame.height))
        countryDD.rightView = paddingViewC
        countryDD.rightViewMode = UITextField.ViewMode.always
        
        groupTypeDD.delegate = self
        groupCategoryDD.delegate = self
        countryDD.delegate = self
        
        groupTypeDD.tag = 0
        groupCategoryDD.tag = 1
        countryDD.tag = 2
        ImgId=""
        chosenImage = UIImage()
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.getCountryAndCategories()
        
        
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(CreateGroupController.OpenGallary))
        singleTap.numberOfTapsRequired = 1
        groupImageView.isUserInteractionEnabled = true
        groupImageView.addGestureRecognizer(singleTap)
        
        self.addDoneButtonOnKeyboard()
        
        imageCondition = false
        countryID = "1"
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if isClassFrom == "Edit"
        {
            
            nextButton.setTitle("Update Entity",  for: UIControl.State.normal)
            
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            print(groupIDEdit)
            wsm.getGroupInfoForEdit(groupIDEdit as NSString)
        }
        let toolBarmy = UIToolbar()
        toolBarmy .frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBarmy.barStyle = UIBarStyle.default
        toolBarmy.isTranslucent = true
        toolBarmy.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBarmy.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(SelectModulesController.DoneTextView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBarmy.setItems([spaceButton,doneButton], animated: false)
        toolBarmy.isUserInteractionEnabled = true
        addressTextView.inputAccessoryView = toolBarmy
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
        }
        else
        {
            
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }

    }
    func textViewDidBeginEditing(_ textView: UITextView){
        if(addressTextView.text == ""){
            
                addrLbl.isHidden=true
               // textView.resignFirstResponder()
                //let addEvent = self.storyboard?.instantiateViewControllerWithIdentifier("addrsdfsdfmap") as! GetAddresMasdfspViewController
                
               // self.navigationController?.pushViewController(addEvent, animated: true)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -190 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
        }else{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -190 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
        }
        
    }
    
    func DoneTextView()
    {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
            }, completion: { finished in
                
        })
        if(addressTextView.text.characters.count > 0){
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressTextView.text, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error)
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    let location = CLLocation(latitude:coordinates.latitude , longitude:coordinates.longitude )
                    //let loc = CLLocation.ini
                    geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                        
                        // Place details
                        var placeMark: CLPlacemark!
                        placeMark = placemarks?[0]
                        
                        // Address dictionary
                        print(placeMark.addressDictionary)
                        
                        // Location name
                        if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                            print(locationName)
                        }
                        
                        // Street address
                        if let street = placeMark.addressDictionary!["State"] as? NSString {
                            print(street)
                            self.stateField = street as String as String as NSString
                        }
                        
                        // City
                        if let city = placeMark.addressDictionary!["City"] as? NSString {
                            print(city)
                            self.cityField = city as String as String as NSString
                        }
                        
                        // Zip code
                        if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                            print(zip)
                            self.pincodeField = zip as String as String as NSString
                        }
                        
                        // Country
                        if let country = placeMark.addressDictionary!["Country"] as? NSString {
                            print(country)
                        }
                        
                    })
                }
            })
        }
        addressTextView.resignFirstResponder()
    }
    
    func countryAndCatListDelegateFunction(_ countryCat : TBCountryResult)
    {
        print(countryCat.status)
        
        pickerCountry = countryCat.countryLists as NSArray
        pickerCategory = countryCat.categoryLists as NSArray
        if(mainArray.count > 0){
             var categoryList = GrpCountryList()
            let bPredicate: NSPredicate = NSPredicate(format: "SELF.countryName == %@", groupInfoClass.countryName)
            var filteredArray = pickerCountry.filtered(using: bPredicate)
            // NSLog("HERE %@", self.filteredArray)
            categoryList = filteredArray[0] as! GrpCountryList
            countryCOdeLbl.text = categoryList.countryCode
        }
    }
    
    @objc func donePicker(_ sender: AnyObject)
    {
        print(sender.tag)
        groupTypeDD.endEditing(true)
        groupCategoryDD.endEditing(true)
        countryDD.endEditing(true)
        view.endEditing(true)
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
        if (sender.tag == 1)
        {
        if groupCatID == "5"
        {
            
             print(groupCatID)
            
            let newWordPrompt = UIAlertController(title: "Enter category", message: "", preferredStyle: UIAlertController.Style.alert)
            newWordPrompt.addTextField(configurationHandler: addTextField)
            newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: wordEntered))
            present(newWordPrompt, animated: true, completion: nil)
            
            
        }
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
               
            }, completion: { finished in
                
        })
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
       
        if(textField == EmailIDField || textField == mobileField)
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -170 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
           
        }
        
        if textField.tag == 0
        {
            picker = UIPickerView(frame: CGRect(x: 0, y: view.frame.width-300, width: view.frame.width, height: 300))
            picker.backgroundColor = .white
            picker.showsSelectionIndicator = true
            picker.delegate = self
            picker.dataSource = self
            
            
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateGroupController.donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            doneButton.tag = 0
            toolBar.setItems([spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            
            picker.tag = 0
            groupTypeDD.inputView = picker
            groupTypeDD.inputAccessoryView = toolBar
            
        }
            
        else if textField == groupCategoryDD
        {
            picker = UIPickerView(frame: CGRect(x: 0, y: view.frame.width-300, width: view.frame.width, height: 300))
            picker.backgroundColor = .white
            picker.showsSelectionIndicator = true
            picker.delegate = self
            picker.dataSource = self
            
            
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateGroupController.donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            // let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.Plain, target: self, action: "donePicker")
            doneButton.tag = 1
            toolBar.setItems([spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            
            picker.tag = 1
            groupCategoryDD.inputView = picker
            groupCategoryDD.inputAccessoryView = toolBar
            
        }
        else
        {
            picker = UIPickerView(frame: CGRect(x: 0, y: view.frame.width-300, width: view.frame.width, height: 300))
            picker.backgroundColor = .white
            picker.showsSelectionIndicator = true
            picker.delegate = self
            picker.dataSource = self
            
            
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CreateGroupController.donePicker(_:)))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            // let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.Plain, target: self, action: "donePicker")
            doneButton.tag = 2
            toolBar.setItems([spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            
            picker.tag = 2
            countryDD.inputView = picker
            countryDD.inputAccessoryView = toolBar
        }
        
        picker.isHidden = false
        
    }
    else
    {
         SVProgressHUD.dismiss()
    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        textField.resignFirstResponder()
    }
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 0
        {
            return pickerDataSources.count;
        }
        else if pickerView.tag == 1
        {
            return pickerCategory.count;
        }
        else
        {
            return pickerCountry.count;
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView.tag == 0
        {
            groupTypeDD.text = pickerDataSources[0]
            return pickerDataSources[row]
        }
        else if pickerView.tag == 1
        {
            var categoryList = GrpCatList()
            categoryList = pickerCategory.object(at: row) as! GrpCatList
            
            var category = GrpCatList()
            category = pickerCategory.object(at: 0) as! GrpCatList
            groupCategoryDD.text = category.catName as String
            groupCatID = category.catId
            
            return categoryList.catName
        }
        else
        {
            var countryList = GrpCountryList()
            countryList = pickerCountry.object(at: row) as! GrpCountryList
            if(countryDD.text == ""){
                var country = GrpCountryList()
                country = pickerCountry.object(at: 0) as! GrpCountryList
                countryDD.text = country.countryName as String
                countryID = country.countryId as String
                countryCOdeLbl.text = country.countryCode
                
            }else{
               
                
                // var country = GrpCountryList()
                // country = pickerCountry.objectAtIndex(0) as! GrpCountryList
                countryDD.text = countryList.countryName as String
                
                countryID = countryList.countryId as String
                countryCOdeLbl.text = countryList.countryCode
                return countryList.countryName
            }
            
            return countryList.countryName
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if pickerView.tag == 0
        {
            //            if pickerDataSources[row] == "Select Nature"
            //            {
            //                groupTypeDD.text = ""
            //            }
            //            else
            //            {
            groupTypeDD.text = pickerDataSources[row]
            //            }
            
        }
        else if pickerView.tag == 1
        {
            var categoryList = GrpCatList()
            categoryList = pickerCategory.object(at: row) as! GrpCatList
            
            if categoryList.catName == "Other"
            {
                
                groupCatID = "5"// categoryList.catId
//                print(groupCatID)
//                // display an alert
//                
//                let newWordPrompt = UIAlertController(title: "Enter category", message: "", preferredStyle: UIAlertController.Style.Alert)
//                newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
//                newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.Default, handler: nil))
//                newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.Default, handler: wordEntered))
//                presentViewController(newWordPrompt, animated: true, completion: nil)
                
                
                
            }
            else
            {
                groupCategoryDD.text = categoryList.catName as String
                groupCatID = categoryList.catId
                print(groupCatID)
            }
            
            
            
        }
        else
        {
            var countryList = GrpCountryList()
            countryList = pickerCountry.object(at: row) as! GrpCountryList
            countryDD.text = countryList.countryName as String
            
            countryID = countryList.countryId as String
            
            print(countryID)
            print(countryDD.text)
        }
        
    }
    
    func wordEntered(_ alert: UIAlertAction!){
        // store the new word
        
        groupCategoryDD.endEditing(true)
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { finished in
        })
        
        groupCatID = "5"
        groupCategoryDD.text = self.newWordField.text
    }
    func addTextField(_ textField: UITextField!){
        // add the text field and make the result global
        //textField.placeholder = "Definition"
        
        
        self.newWordField = textField
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        if isClassFrom == "Edit"
        {
             self.title="Edit Entity"
        }else{
        
        self.title="New Entity"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateGroupController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        if(groupNameField.text!.characters.count > 0){
            let alertController = UIAlertController(title: "", message:
                "Your changes are not saved, are you sure you want to go back?", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler:  {(alert :UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            //  print("YOU PRESSED OK \(sender.view!.tag)")
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {

        groupTypeDD.endEditing(true)
        groupCategoryDD.endEditing(true)
        countryDD.endEditing(true)
        picker.removeFromSuperview()
        toolBar.removeFromSuperview()
        
        
        let isValid = isValidEmail(EmailIDField.text!)
        
        
        if  groupNameField.text == ""
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please enter an Entity Name"
            alertView.delegate = self
            alertView.addButton(withTitle: "Ok")
            alertView.show()
        }
//        else if groupTypeDD.text == ""
//        {
//            let Alert: UIAlertView = UIAlertView()
//            Alert.delegate = self
//            Alert.title = "Rotary India"
//            Alert.message = "Please select nature of entity."
//            Alert.addButtonWithTitle("Ok")
//            Alert.show()
//        }
        else if groupCategoryDD.text == ""
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please select category of entity."
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }
        else if(EmailIDField.text == "")
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter an Email Address"
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }
            
        else if(isValid == false)
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter a valid Email Address."
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }
            
        else if(mobileField.text == "")
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please enter a Phone Number"
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }
            /*        else if(websiteField.text?.characters.count > 0)
             {
             if(verifyUrl(websiteField.text!) == false){
             
             let alert = UIAlertController(title: "Rotary India", message: "Please enter valid url", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
             self.presentViewController(alert, animated: true, completion: nil)
             
             }
             }
             */
            //        else if ImgId == "" || groupInfoClass.grpImage == ""
            //        {
            //            let Alert: UIAlertView = UIAlertView()
            //            Alert.delegate = self
            //            Alert.title = "Rotary India"
            //            Alert.message = "Please select image for group icon."
            //            Alert.addButtonWithTitle("okay")
            //            Alert.show()
            //
            //        }
        else if countryDD.text == ""
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Please select country."
            Alert.addButton(withTitle: "okay")
            Alert.show()
        }
            
        else
        {
            //  let imageData: NSData = UIImagePNGRepresentation(chosenImage)!
            if ImgId == "NO"
            {
                ImgId = "0"
            }
            if ImgId == ""
            {
                ImgId = "0"
            }
            
            print(groupCatID)
            
          
            
            
            let defaults = UserDefaults.standard
            let masterUUID = defaults.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            
            if isClassFrom == "Edit"
            {
                if groupCatID == "5"
                {
                    wsm.createGroup(groupIDEdit, grpName: groupNameField.text!, grpImageID: ImgId as String, grpType: "", grpCategory: groupCatID, addrss1: addressTextView.text, addrss2: "", city: cityField as String, state: stateField as String, pincode: pincodeField as String, country : countryID ,emailid: EmailIDField.text!, mobile: mobileField.text!, userId:masterUUID!, website: "" , other: groupCategoryDD.text!)
                }
                else
                {
                    wsm.createGroup(groupIDEdit, grpName: groupNameField.text!, grpImageID: ImgId as String, grpType:"", grpCategory: groupCatID, addrss1: addressTextView.text, addrss2: "", city: cityField as String, state: stateField as String, pincode: pincodeField as String, country : countryID ,emailid: EmailIDField.text!, mobile: mobileField.text!, userId:masterUUID!, website: "" , other: "")
                }
                
            }
            else
            {
                wsm.createGroup("0", grpName: groupNameField.text!, grpImageID: ImgId as String, grpType: "", grpCategory: groupCatID, addrss1: addressTextView.text, addrss2: "", city: cityField as String, state: stateField as String, pincode: pincodeField as String, country : countryID ,emailid: EmailIDField.text!, mobile: mobileField.text!, userId:masterUUID!, website: "" , other: groupCategoryDD.text!)
            }
            
         
        }
      
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }

    }
    
    func verifyUrl (_ urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //////////////////------- Image Upload Delegate function -----------///////////////////
    
    func getUploadImgSucceeded(_ response: LoadImageResult) {
        
        //indicator.stopAnimating()
        window=nil
        if response.status == "0"
        {
            ImgId=response.imageID as! NSString;
            
            print(response.imageID)
            
            
          //  var addr = String(format: "%@ %@",adress1Field.text!, address2Field.text!)
            let defaults = UserDefaults.standard
            let masterUUID = defaults.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            // wsm.createGroup("0", grpName: groupNameField.text!, grpImageID: ImgId as String, grpType: groupTypeDD.text!, grpCategory: groupCategoryDD.text!, addrss1: addr, addrss2: address2Field.text!, city: cityField.text!, state: stateField.text!, pincode: pincodeField.text!, country : countryID ,emailid: EmailIDField.text!, mobile: mobileField.text!, userId:masterUUID!, userpwd: "")
            
            
            /// self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("modules") as UIViewController, animated: true) //
        }
    }
    
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        
//        
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//        
//        
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        
//    }
    
    func CreateGroupDelegateFunction(_ createGRP : CreateGRpResult)
    {
        print(createGRP.status)
        print(createGRP.message)
        if(createGRP.status == "0")
        {
        
            if isClassFrom == "Edit"
            {
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                let profVC = self.storyboard!.instantiateViewController(withIdentifier: "modules") as! SelectModulesController
                profVC.strGroupIDs =  createGRP.grdId  //nameTitles[indexPath.row]
                print(profVC.strGroupIDs)
                self.navigationController?.pushViewController(profVC, animated: true)
            }
            
            
            // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("modules") as UIViewController, animated: true)
        }
        else
        {
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //       let width = bounds.size.width
        //        if(width <= 320.0)
        //        {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
        //        }
        //        else
        //        {
        //        }
//        textField.resignFirstResponder()
//        return true
//        let nextTage=textField.tag+1;
//        // Try to find next responder
//        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
//        
//        if (nextResponder != nil){
//            // Found nxt responder, so set it.
//            if (textField != countryDD){
//                nextResponder?.becomeFirstResponder()}
//        }
//        else
//        {
//            // Not found, so remove keyboard
//            textField.resignFirstResponder()
//        }
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @objc func OpenGallary()
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
       
        
        print("Opening Gallary")
        
        self.view.endEditing(true)
        if isClassFrom == "Edit"
        {
            if  groupInfoClass.grpImage == ""  //chosenImage.size.width == 0
            {
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
            }
            else
            {
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
                actionSheet.tag = 0
                actionSheet.show(in: self.view)
            }
            
        }
        else
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
            actionSheet.tag = 1
            actionSheet.show(in: self.view)
        }
        
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }

        
    }
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        
        
        if actionSheet.tag == 0
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                print(userProfileID)
                print(userGroupID)
                chosenImage = UIImage()
                
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.DeletePhotoEdit(userGroupID as String, grpID: userGroupID as String, type: "Group",moduleId: "")
                
            case 2:
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
                
            default:
                print("Default")
            }
        }
        else
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                //shows the photo library
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
               // if #available(iOS 8.0, *) {
                    self.imagePicker.modalPresentationStyle = .popover
                //} else {
                    // Fallback on earlier versions
               // }
                self.present(self.imagePicker, animated: true, completion: nil)
                
            case 2:
                
                //   /*
                //shows the photo library
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.imagePicker.delegate = self
                
               // if #available(iOS 8.0, *) {
                    self.imagePicker.modalPresentationStyle = .popover
               // } else {
                    // Fallback on earlier versions
               // }
                
                self.present(self.imagePicker, animated: true, completion: nil)
                //   */
                
                //           imagePicker =  UIImagePickerController()
                //            imagePicker.delegate = self
                //            imagePicker.sourceType = .Camera
                
                //  presentViewController(imagePicker, animated: true, completion: nil)
                
            default:
                print("Default")
                //Some code here..
                
            }
        }
        
    }
    
    
    
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        print(dltPhoto.status)
        
        groupImageView.image = UIImage(named: "addevent")
        
    }
    
    
    
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        // let scale = newWidth
        let newHeight = newWidth
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
    {
        self.view.endEditing(true)
        groupImageView.translatesAutoresizingMaskIntoConstraints = true
        groupImageView.layer.masksToBounds = true
        groupImageView.clipsToBounds = true;
        
        //var chosenImage:UIImage! //2
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            chosenImage = possibleImage
        }
        groupImageView.image = chosenImage//resizeImage(chosenImage!, newWidth: 100)
        
        imageCondition = true
       // loaderViewMethod()
        callthis()
        
        // cell.addProfilePic.contentMode = .ScaleAspectFit //3
        // cell.addProfilePic.image = chosenImage //4
        //  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "callthis", userInfo: nil, repeats: false)
        dismiss(animated: true, completion:nil);
        
    }
    func callthis(){
        //loaderViewMethod()
        
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        let imageData: Data = chosenImage.pngData()!
        wsm.uploadToServer(usingImage: imageData, andFileName: "createEntity", moduleName: "createEntity")//5
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    ///////////////////////// TexView Delegates ///////////////////////////
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == mobileField
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
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(CreateGroupController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        mobileField.inputAccessoryView=doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        //bb        let width = bounds.size.width
        //        if(width <= 320.0)
        //        {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
        //       }
        //        else
        //        {
        //        }
        
        //EditNameField.resignFirstResponder()
        mobileField.resignFirstResponder()
    }
    
    
    
}



