//
//  GalleryCatyegoryNewViewController.swift
//  TouchBase
//
//  Created by rajendra on 21/05/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
//import SVProgressHUD
import MBProgressHUD
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class GalleryCatyegoryNewViewController: UIViewController,UIScrollViewDelegate,UIPickerViewDelegate , UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource , UITextFieldDelegate
{
    @IBOutlet weak var textfieldSearchByProject: UITextField!
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    var appDelegate : AppDelegate = AppDelegate()
   // let loaderClass  = WebserviceClass()
    
    var yearFrom:String! = ""
    var year : Int! = 0
    var grpID:String! = ""
    var moduleID:String!=""
    var isAdmin:String! = ""
    var  userID:String! = ""
    var stringModuleId:String!=""
    var moduleName:String! = ""
    var isCategory:String!=""
    var editB = UIButton(type: UIButton.ButtonType.custom)
    //MARK:- Array
    var mainArrayYearPicker:NSMutableArray=NSMutableArray()
    var muarrayCheckUncheck:NSMutableArray=NSMutableArray()
    var muarrayCategoryListArray:NSArray=NSArray()
    var muarrayClubListArray:NSArray=NSArray()
    var muarrayDistrictListArray:NSArray=NSArray()
    
    
    var muarraYClubSearchArray:NSArray=NSArray()
    
    
    
    @IBOutlet weak var viewClubListShow: UIView!
    @IBOutlet weak var tableViewClubList: UITableView!
    
    
    @IBOutlet weak var textyfieldYear: UITextField!
    @IBOutlet weak var textfieldDistrict: UITextField!
    @IBOutlet weak var textfieldClub: UITextField!
    @IBOutlet weak var myScollview: UIScrollView!
    @IBOutlet weak var buttonSelectAllCategory: UIButton!
    //-------------------Picker Setting----------------
    @IBOutlet weak var viewClubPickr: UIView!
    @IBOutlet weak var viewDistrictPicker: UIView!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var view3Picker: UIView!
    @IBOutlet weak var pickerViewYear: UIPickerView!
    @IBOutlet weak var pickerViewDistrictList: UIPickerView!
    @IBOutlet weak var pickerViewClubList: UIPickerView!
    @IBOutlet weak var buttonOpticity: UIButton!
    //-------------------Picker Setting----------------
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    var isAllCategorySelected:Bool=false
    @IBOutlet weak var buttonCancelClubPicker: UIButton!
    @IBOutlet weak var buttonDoneClubPicker: UIButton!
    @IBOutlet weak var buttonCancelDistrictPicker: UIButton!
    @IBOutlet weak var buttonDoneDistrictPicker: UIButton!
    
    @IBOutlet weak var tableViewCategoryListing: UITableView!
    
    @IBOutlet weak var lblNoCategoryDistrictClub: UILabel!
    var setDistrictID:String!=""
    var setClubID:String!=""
    var setYear:String!=""
    var setCategoryIDs:String!=""
    
    var selectAllOrNot:String!=""
    var selectZeroIndexAllORNot:String!=""
    
    @IBOutlet weak var buttonYear: UIButton!
    @IBOutlet weak var buttonDistrict: UIButton!
    @IBOutlet weak var buttonClub: UIButton!
    
    
    
    //MARK:- Button Action
    //District----------------------------
    @IBAction func buttonDoneDistrictPickerCE(_ sender: AnyObject)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
        fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList(setDistrictID)
        }
        else
        {
          self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        viewDistrictPicker.isHidden=true
        buttonOpticity.isHidden=true
    }
    
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.color = .clear
        loadingNotification.activityIndicatorColor = .gray
        //loadingNotification.labelText=str
        loadingNotification.show(true)
    }
    
    func hideMBProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    @IBAction func buttonCancelDistrictPickerCE(_ sender: AnyObject)
    {
        viewDistrictPicker.isHidden=true
        buttonOpticity.isHidden=true
        textfieldDistrict.text = nil
    }
    //Club--------------------------------
    @IBAction func buttonDoneClubPickerCE(_ sender: AnyObject)
    {
        viewClubPickr.isHidden=true
        buttonOpticity.isHidden=true
    }
    @IBAction func buttonCancelClubPickerCE(_ sender: AnyObject)
    {
        viewClubPickr.isHidden=true
        buttonOpticity.isHidden=true
        textfieldClub.text = nil
    }
    //Year--------------------------------
    @IBAction func buttonDoneClickEvent(_ sender: AnyObject)
    {
        view3Picker.isHidden=true
        buttonOpticity.isHidden=true
    }
    @IBAction func buttonCancelClickEvent(_ sender: AnyObject)
    {
        view3Picker.isHidden=true
        buttonOpticity.isHidden=true
        //textyfieldYear.text! = "All"
    }
    @IBAction func buttonopticityClickEvent(_ sender: AnyObject)
    {
    }
    @IBAction func buttonYearClickEvent(_ sender: AnyObject)
    {
        view3Picker.isHidden=false
        buttonOpticity.isHidden=false
        pickerViewYear.isHidden=false
       print("Year click event")
        
        
        //buttonOpticity.hidden=true
        viewClubListShow.isHidden=true
        tableViewClubList.isHidden=true
        textfieldClub.resignFirstResponder()
        textyfieldYear.resignFirstResponder()
        
        
    }
    @IBAction func buttonDistrictClickEvent(_ sender: AnyObject)
    {
        print("District click event")
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
        viewDistrictPicker.isHidden=false
        buttonOpticity.isHidden=false
        pickerViewDistrictList.isHidden=false
        if(muarrayDistrictListArray.count>0)
        {
         pickerViewDistrictList.reloadAllComponents()
        }
        else
        {
            //self.fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList("0")
        }
        viewClubPickr.isHidden=true
        view3Picker.isHidden=true
        }
        
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
           //SVProgressHUD.dismiss()
        }
        
        
        
        //buttonOpticity.hidden=true
        viewClubListShow.isHidden=true
        tableViewClubList.isHidden=true
        textfieldClub.resignFirstResponder()
        textyfieldYear.resignFirstResponder()
    }
    @IBAction func buttonClubClickEvent(_ sender: AnyObject)
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
        print("Club click event")
          viewClubListShow.isHidden=false
        tableViewClubList.isHidden=false
        //viewClubPickr.hidden=false
        //buttonOpticity.hidden=false
        //pickerViewClubList.hidden=false
        if(muarrayClubListArray.count>0)
        {
            tableViewClubList.reloadData()
            //pickerViewClubList.reloadAllComponents()
        }
        viewDistrictPicker.isHidden=true
        view3Picker.isHidden=true
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    //SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func buttonSearchClickEvent(_ sender: AnyObject) {
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
        var setMultipleCategoryID:String!=""
        
        print("Search clicked !!!1")
        //1.Year Vaue Get For Send API
        self.setYear = textyfieldYear.text!
        print("Year Vaue Get For Send API---------------",self.setYear)
        //2.District Id Get For Send API
        print("District Id Get For Send API---------------",self.setDistrictID)
        //3.Club ID Get For Send API
        print("Club ID Get For Send API---------------",self.setClubID)
        //4.Category ID Get For Send API
        if(selectAllOrNot=="Yes")
        {
        }
        else
        {
        }
            
            if(selectZeroIndexAllORNot=="YES")
            {
            }
            else
            {
                if(muarrayCheckUncheck.count>0)
                {
                    for i in 0..<self.muarrayCheckUncheck.count
                    {
                        if(muarrayCheckUncheck.object(at: i) as! String == "0")
                        {
                        }
                        else if (muarrayCheckUncheck.object(at: i) as! String == "1")
                        {
                            let ID =  (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: i) as! String
                            setMultipleCategoryID = setMultipleCategoryID+","+ID
                        }
                    }
                }
            }
        //Remove First character "," replace by ""
            if(setMultipleCategoryID != "")
            {
                setCategoryIDs = setMultipleCategoryID.replacingCharacters(in: setMultipleCategoryID.startIndex..<setMultipleCategoryID.index(after: setMultipleCategoryID.startIndex), with: "")
                print("Category ID Get For Send API---------------",setCategoryIDs)
            }
            else
            {
                //setCategoryIDs=""
            }

        if(setCategoryIDs=="")
        {
            self.view.makeToast("Please select at least one category", duration: 2, position: CSToastPositionCenter)
        }
//        else if(self.setYear=="All")
//        {
//            self.view.makeToast("Please select Year", duration: 2, position: CSToastPositionCenter)
//        }
        else
        {
            if(self.setCategoryIDs=="0")
            {
            }
            else
            {
              setCategoryIDs = self.setCategoryIDs+","
            }
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListViewController") as! ShowCaseAlbumListViewController
            obj.getYear=self.setYear
            obj.getClubId=self.setClubID
            obj.getDistrctId=self.setDistrictID
            obj.getCategoryIds=self.setCategoryIDs
            obj.getGroupId=self.grpID
            obj.getGroupDistrictList=self.getGroupDistrictList
            obj.varIsCallFrom="ShowCaseFromDashBoard"
            obj.GetModuleName="Showcase"
            obj.txtsearchByProject=textfieldSearchByProject.text!
           
                
            self.navigationController?.pushViewController(obj, animated: true)
                
           
            // setCategoryIDs,setYear,setClubID,setDistrictID ///-----------Send Next Page then Output
        }
            
        }
        else
        
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            //SVProgressHUD.dismiss()
        }
        
    }
    
    @IBOutlet weak var buttonSearch: UIButton!
    @IBAction func buttonSelectAllCategoryClickEvent(_ sender: AnyObject)
    {
        print("button click !!! 19 MArch 2019 ")
       if(isAllCategorySelected==false)
       {
        /*
          isAllCategorySelected=true
        buttonSelectAllCategory.setImage(UIImage(named: "radio_btn_Check"), for: .normal)
        functionForSetAllCategoryCheckUnCheck()
        */
        // isAllCategorySelected=true
        //buttonSelectAllCategory.setImage(UIImage(named: "radio_btn_Check"), for: .normal)
        //functionForSetAllCategoryCheckUnCheck()
        
        isAllCategorySelected=true
        buttonSelectAllCategory.setImage(UIImage(named: "RoundCheck"), for: .normal)
        setCategoryIDs = "0"
        
        print(setCategoryIDs)
        selectAllOrNot = "Yes"
        selectZeroIndexAllORNot="YES"
        for i in 0..<self.muarrayCheckUncheck.count
        {
            muarrayCheckUncheck.replaceObject(at: i, with: "1")
        }
        buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        //buttonSearch.enabled=true
        tableViewCategoryListing.reloadData()
        
       }
       else  if(isAllCategorySelected==true)
       {
        /*
        isAllCategorySelected=false
        buttonSelectAllCategory.setImage(UIImage(named: "radio_btn_Uncheck"), for: .normal)
        functionForSetAllCategoryCheckUnCheck()
        */
        isAllCategorySelected=false
        buttonSelectAllCategory.setImage(UIImage(named: "RoundUncheck"), for: .normal)
        setCategoryIDs = ""
        print(setCategoryIDs)
        selectAllOrNot = "No"
        buttonSearch.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        //buttonSearch.enabled=false
        for i in 0..<self.muarrayCheckUncheck.count
        {
            muarrayCheckUncheck.replaceObject(at: i, with: "0")
        }
        selectZeroIndexAllORNot="NO"
        tableViewCategoryListing.reloadData()
        
        
        
        }
    }
    func functionForSetAllCategoryCheckUnCheck()
    {
        if(isAllCategorySelected==true)
        {
           print("Select all category :)")
            
            
            for i in 0..<self.muarrayCheckUncheck.count
            {
              muarrayCheckUncheck.replaceObject(at: i, with: "1")
            }
            tableViewCategoryListing.reloadData()
            
            
        }
        else  if(isAllCategorySelected==false)
        {
            for i in 0..<self.muarrayCheckUncheck.count
            {
                muarrayCheckUncheck.replaceObject(at: i, with: "0")
            }
            tableViewCategoryListing.reloadData()
          print("De Select all category :(")
        }
    }
    
    //MARK:- Viewdidload
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        buttonSearch.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        //buttonSearch.enabled=false
        
       // let drpIDs = NSUserDefaults.standardUserDefaults().valueForKey("session_GetGroupId") as! String
       // print(drpIDs)
        setDistrictID="0"
        lblNoCategoryDistrictClub.isHidden=true
        textfieldDistrict.delegate=self
        textfieldClub.delegate=self
        textfieldDistrict.placeholder = "All"
        textfieldClub.placeholder = "All"
        textfieldDistrict.attributedPlaceholder = NSAttributedString(string: "All",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfieldClub.attributedPlaceholder = NSAttributedString(string: "All",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        

        pickerViewYear.delegate=self
        pickerViewYear.dataSource=self
        pickerViewDistrictList.delegate=self
        pickerViewDistrictList.dataSource=self
        pickerViewClubList.delegate=self
        pickerViewClubList.dataSource=self
    
        
        
       // let viewShadow = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //viewClubListShow.center = self.view.center
        //viewClubListShow.backgroundColor = UIColor.whiteColor()
        viewClubListShow.layer.shadowColor = UIColor.gray.cgColor
        viewClubListShow.layer.shadowOpacity = 1
        viewClubListShow.layer.shadowOffset = CGSize.zero
        viewClubListShow.layer.shadowRadius = 5
        self.view.addSubview(viewClubListShow)
        

        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        let day = components.day
        print(year , month ,day )
        if(month!>=7)
        {
          year = year+1
        }
        else
        {
        }
        yearFrom = String(year)
        print(yearFrom)
        textyfieldYear.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
        

        
//        self.edgesForExtendedLayout=[]
        view3Picker.isHidden=true
        viewDistrictPicker.isHidden=true
        viewClubPickr.isHidden=true
        buttonOpticity.isHidden=true
        
        
        viewClubListShow.isHidden=true
        tableViewClubList.isHidden=true
        
        
        //view3Picker
        //buttonOpticity
        textyfieldYear.rightViewMode = UITextField.ViewMode.always
        textyfieldYear.rightViewMode = .always
        myScollview.delegate=self
        myScollview.contentSize=CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+20)
        textyfieldYear.textFieldFullBorder()
        textfieldDistrict.textFieldFullBorder()
        //textfieldClub.textFieldFullBorder()
        functionForSetLeftNavigation()
        buttonSearch.setButtonTopBorder()
        functionForYears()
        //Default API call for Category and District List Get and Fix alway
        
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
         fucntionForGetShowCaseCategoryClubDistrictListFirstTimeOnly()
        }
        else
        {
         self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        //SVProgressHUD.dismiss()
        
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Navigation Setting
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
       // self.title = moduleName
         self.title = "Showcase"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white//(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GalleryCatyegoryNewViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Textfield Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*
        if(textField==textfieldClub)
        {
            appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
         {
                
                
                
            muarraYClubSearchArray = muarrayClubListArray
             textyfieldYear.resignFirstResponder()
            //buttonOpticity.hidden=false
            viewClubListShow.hidden=false
            tableViewClubList.hidden=false
            tableViewClubList.reloadData()
                
            }
            else
            {
          SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
              textyfieldYear.resignFirstResponder()
                textfieldClub.resignFirstResponder()
            }
        }
        else
        {
            view3Picker.hidden=false
            buttonOpticity.hidden=false
            textyfieldYear.resignFirstResponder()
            textfieldClub.resignFirstResponder()
        }
        */
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textyfieldYear.resignFirstResponder()
        textfieldClub.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
       
        let userEnteredString = textField.text
        
        
       //var newString = userEnteredString!.stringByReplacingCharactersInRange(range, withString:string)
        
        var newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)

        
        //var newString = (userEnteredString! as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString
        print(newString)

        if(textField==textfieldClub )
        {
            
            print(newString?.characters.count)
            if(newString?.characters.count>0 || newString != nil || newString != "")
            {
                
                viewClubListShow.isHidden=false
                tableViewClubList.isHidden=false
                
                let predicate =  NSPredicate(format: "Name contains[c] %@", newString!)
                let searchDataSource = muarrayClubListArray.filtered(using: predicate)
                muarraYClubSearchArray=searchDataSource as NSArray
                print(muarraYClubSearchArray)
                
                
                print(newString?.characters.count)
                if(muarraYClubSearchArray.count<=0 )
                {
                    print(newString?.characters.count)
                    print("aaaaaaaaaaaaaaaaaaa")
                    buttonOpticity.isHidden=true
                    viewClubListShow.isHidden=true
                    tableViewClubList.isHidden=true
                    textfieldClub.text = nil
                    textfieldClub.resignFirstResponder()
                }
                else
                {
                    print(newString?.characters.count)
                    print("bbbbbbbbbbbbbbbbb")
                }
                self.tableViewClubList.reloadData()
            }
           else
            {
                
                print("cccccccccccccc")
                muarraYClubSearchArray = muarrayClubListArray
                self.tableViewClubList.reloadData()
                viewClubListShow.isHidden=true
                tableViewClubList.isHidden=true
                textfieldClub.resignFirstResponder()
            }
 
            
        }
        
        
        
       // let newString = String(string: textField.text!).replacingCharacters(in: range, with: string)
        return true
    }
    
  
    //MARK:- Function Year
    func functionForYears()
    {
        mainArrayYearPicker=NSMutableArray()
        //Code by Deepak
       // year = year+1 // for one year next
        //year = year
//        for var i in ((year-3)..<year)
//        {
        
        // start from 2015 to current year and start from july and end with june // Code by DPK 25-06-2018
            for  i in (2015..<year)
            {
            print(i)
            let letSetYear = String(i)+"-"+String(Int(i+1))
            print(letSetYear)
            mainArrayYearPicker.add(letSetYear)
        }
        pickerViewYear.selectRow(mainArrayYearPicker.count-1, inComponent: 0, animated: false)
        pickerViewYear.reloadAllComponents()
    }
    //MARK:- Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if(pickerView.tag==0)
        {
            return mainArrayYearPicker.count;
        }
       else if(pickerView.tag==1)
        {
          return muarrayDistrictListArray.count
        }
//        else if(pickerView.tag==2)
//        {
//        return  muarrayClubListArray.count;
//        }
        else
        {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView.tag==0)
        {
            let varSelectedYear:String = mainArrayYearPicker.object(at: row) as! String
            return varSelectedYear
        }
        else if(pickerView.tag==1)
        {
            let varSelectedYear:String = (muarrayDistrictListArray.value(forKey: "Name") as AnyObject).object(at: row) as! String
            return varSelectedYear
        }
//        else if(pickerView.tag==2)
//        {
//            let varSelectedYear:String = muarrayClubListArray.valueForKey("Name").objectAtIndex(row) as! String
//            return varSelectedYear
//        }
      
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if(pickerView.tag==0)
        {
            let varSelectedYear:String = mainArrayYearPicker.object(at: row) as! String
            self.textyfieldYear.text! = varSelectedYear
            self.setYear=varSelectedYear
            /* // if first value put on api then uncomment code
            let  year = varSelectedYear.componentsSeparatedByString("-")
            print(year[0])
            print(year[1])
            self.yearFrom =  year[0]
             */
        }
         else if(pickerView.tag==1)
        {
            let varSelectedYear:String = (muarrayDistrictListArray.value(forKey: "Name") as AnyObject).object(at: row) as! String
            let ID:String = (muarrayDistrictListArray.value(forKey: "ID") as AnyObject).object(at: row) as! String
            self.textfieldDistrict.text! = varSelectedYear
            self.setDistrictID=ID
        }
//        else if(pickerView.tag==2)
//        {
//            let varSelectedYear:String = muarrayClubListArray.valueForKey("Name").objectAtIndex(row) as! String
//            let ID:String = muarrayClubListArray.valueForKey("ID").objectAtIndex(row) as! String
//            self.textfieldClub.text! = varSelectedYear
//            self.setClubID=ID
//        }
        else
        {
            
        }
        
    }

    
    //MARK:- Table view methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView==tableViewCategoryListing)
        {
         return muarrayCategoryListArray.count
        }
        else if(tableView==tableViewClubList)
        {
         return muarraYClubSearchArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(tableView==tableViewCategoryListing)
        {
        let cell = tableViewCategoryListing.dequeueReusableCell(withIdentifier: "CustomGalleryNewCateCell", for: indexPath) as! CustomGalleryNewCateCell
        if(self.muarrayCategoryListArray.count>0)
        {
            let name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: indexPath.row) as! String
            cell.lblCategory.text = name
                if(muarrayCheckUncheck.object(at: indexPath.row) as! String == "0")
                {
                  cell.buttonCheckUncheck.setImage(UIImage(named: "RoundUncheck"),  for: UIControl.State.normal)
                }
                else if (muarrayCheckUncheck.object(at: indexPath.row) as! String == "1")
                {
                 cell.buttonCheckUncheck.setImage(UIImage(named: "RoundCheck"),  for: UIControl.State.normal)
                }
            cell.buttonCheckUncheck.addTarget(self, action: #selector(GalleryCatyegoryNewViewController.buttonButtonCheckUncheckClickEvent(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCheckUncheck.tag=indexPath.row
        }
        return cell
            
        }
        else
        {
            let cell = tableViewClubList.dequeueReusableCell(withIdentifier: "ClubListTableViewCell", for: indexPath) as! ClubListTableViewCell
            if(self.muarraYClubSearchArray.count>0)
            {
                let varSelectedYear:String = (muarraYClubSearchArray.value(forKey: "Name") as AnyObject).object(at: indexPath.row) as! String
                cell.lblClubName.text = varSelectedYear
   
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       print("did select Table")
        
        if(tableView==tableViewCategoryListing)
        {
            
         
            
            
        }
        else
        {
            if(self.muarraYClubSearchArray.count>0)
            {
                let varSelectedYear:String = (muarraYClubSearchArray.value(forKey: "Name") as AnyObject).object(at: indexPath.row) as! String
                textfieldClub.text = varSelectedYear
                let ID:String = (muarraYClubSearchArray.value(forKey: "ID") as AnyObject).object(at: indexPath.row) as! String
               self.textfieldClub.text! = varSelectedYear
               self.setClubID=ID
                
                
                buttonOpticity.isHidden=true
                viewClubListShow.isHidden=true
                tableViewClubList.isHidden=true
                textfieldClub.resignFirstResponder()
                
            }
        }
    }
    //Button Check Uncheck Action
    @objc func buttonButtonCheckUncheckClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        
        let name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: sender.tag) as! String
        if(name == "All")
        {
            if(muarrayCheckUncheck.object(at: sender.tag) as! String == "0")
            {
                let ID = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: sender.tag) as! String
                print(buttonButtonCheckUncheckClickEvent)
                setCategoryIDs = ID
                
                print(setCategoryIDs)
                selectAllOrNot = "Yes"
                selectZeroIndexAllORNot="YES"
                for i in 0..<self.muarrayCheckUncheck.count
                {
                    muarrayCheckUncheck.replaceObject(at: i, with: "1")
                }
                buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
                //buttonSearch.enabled=true
                tableViewCategoryListing.reloadData()
            }
            else if(muarrayCheckUncheck.object(at: sender.tag) as! String == "1")
            {
                setCategoryIDs = ""
                print(setCategoryIDs)
                selectAllOrNot = "No"
                buttonSearch.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
                //buttonSearch.enabled=false
                for i in 0..<self.muarrayCheckUncheck.count
                {
                    muarrayCheckUncheck.replaceObject(at: i, with: "0")
                }
                selectZeroIndexAllORNot="NO"
                tableViewCategoryListing.reloadData()
            }
        }
        else
        {
            if(muarrayCheckUncheck.object(at: sender.tag) as! String == "0")
            {
                let ID = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: sender.tag) as! String
                setCategoryIDs = ID
                muarrayCheckUncheck.replaceObject(at: sender.tag, with: "1")
             //selectAllOrNot = "Yes"
               // isAllCategorySelected=true
              //  buttonSelectAllCategory.setImage(UIImage(named: "RoundCheck"), for: .normal)
            }
            else if(muarrayCheckUncheck.object(at: sender.tag) as! String == "1")
            {
                setCategoryIDs = ""
                muarrayCheckUncheck.replaceObject(at: 0, with: "0")
                muarrayCheckUncheck.replaceObject(at: sender.tag, with: "0")
                selectAllOrNot = "No"
                
                isAllCategorySelected=false
                buttonSelectAllCategory.setImage(UIImage(named: "RoundUncheck"), for: .normal)
            }
   
        }
        
        /*
         
         
         isAllCategorySelected=true
         buttonSelectAllCategory.setImage(UIImage(named: "RoundCheck"), for: .normal)
         setCategoryIDs = "0"
         
         print(setCategoryIDs)
         selectAllOrNot = "Yes"
         selectZeroIndexAllORNot="YES"
         for i in 0..<self.muarrayCheckUncheck.count
         {
         muarrayCheckUncheck.replaceObject(at: i, with: "1")
         }
         buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
         //buttonSearch.enabled=true
         tableViewCategoryListing.reloadData()
         
         }
         else  if(isAllCategorySelected==true)
         {
         /*
         isAllCategorySelected=false
         buttonSelectAllCategory.setImage(UIImage(named: "radio_btn_Uncheck"), for: .normal)
         functionForSetAllCategoryCheckUnCheck()
         */
         isAllCategorySelected=false
         buttonSelectAllCategory.setImage(UIImage(named: "RoundUncheck"), for: .normal)
         
         */
        
        
        
        for i in 0..<self.muarrayCheckUncheck.count
        {
            if(muarrayCheckUncheck.object(at: i) as! String == "1")
            {
                buttonSearch.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
                //buttonSearch.enabled=true
                break;
            }
            else
            {
                buttonSearch.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
               // buttonSearch.enabled=false
            }
        }
        
        
        
        
        
        tableViewCategoryListing.reloadData()
    }
    
    //MARK:- WEB API First Time ONly
    func fucntionForGetShowCaseCategoryClubDistrictListFirstTimeOnly()
    {
    //loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
        let parameterst =  [ "DistrictID":"0"]
        print(parameterst)
        print(completeURL)
        self.showMBProgress(str: "Loading...")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
               // self.loaderClass.window=nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.hideMBProgress()
            
            }
            else
            {
                let responseDict = response.value(forKey: "ShowcaseDetails")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                print(letGetMessage)
                print(letGetStatus)

                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.muarrayCheckUncheck=NSMutableArray()
                    self.muarrayCategoryListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Categories") as! NSArray
                    print("Check categories: \(self.muarrayCategoryListArray)")
                    self.muarrayClubListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Club") as! NSArray
                    self.muarrayDistrictListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "District") as! NSArray
                    if(self.muarrayDistrictListArray.count>0)
                    {
                        self.lblNoCategoryDistrictClub.isHidden=true
                        self.textfieldDistrict.text! = (self.muarrayDistrictListArray.value(forKey: "Name") as AnyObject).object(at: 0) as! String
                        self.setDistrictID = (self.muarrayDistrictListArray.value(forKey: "ID") as AnyObject).object(at: 0) as! String
                    }
                    else
                    {
                        self.textfieldDistrict.text = nil
                        self.lblNoCategoryDistrictClub.isHidden=false
                        self.lblNoCategoryDistrictClub.text! = "No Category"
                    }
                    
                    if(self.muarrayClubListArray.count>0)
                    {
                        self.muarraYClubSearchArray=self.muarrayClubListArray
                        self.textfieldClub.text! = (self.muarrayClubListArray.value(forKey: "Name") as AnyObject).object(at: 0) as! String
                        self.setClubID = (self.muarrayClubListArray.value(forKey: "ID") as AnyObject).object(at: 0) as! String
                    }
                    else
                    {
                        self.textfieldClub.text = nil
                    }
                    if(self.muarrayCategoryListArray.count>0)
                    {
                        print((self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).count)
                        for i in 0..<(self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).count
                        {
                            self.muarrayCheckUncheck.add("0")
                        }
                    }
                    self.pickerViewDistrictList.reloadAllComponents()
                    //self.pickerViewClubList.reloadAllComponents()
                    self.pickerViewYear.reloadAllComponents()
                    if(self.muarrayCheckUncheck.count==(self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).count)
                    {
                     self.tableViewCategoryListing.reloadData()
                    }
                    //self.loaderClass.window=nil
                }
                else
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                }
                self.hideMBProgress()
                //SVProgressHUD.dismiss()
               // self.loaderClass.window=nil
            }
            
        })
    }
    //MARK:- WEB API Selected District
    func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList(_ DistrictID:String)
    {
       // loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
        let parameterst =  [ "DistrictID":DistrictID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
               // self.loaderClass.window=nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
          
                self.hideMBProgress()
             //SVProgressHUD.dismiss()
            }
            else
            {
                let responseDict = response.value(forKey: "ShowcaseDetails")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                print(letGetMessage)
                print(letGetStatus)
                
                if(letGetStatus == "0" && letGetMessage == "success")
                {
                    self.muarrayClubListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Club") as! NSArray
                    if(self.muarrayClubListArray.count>0)
                    {
                       // self.textfieldClub.textFieldFullBorder()
                        self.textfieldClub.isUserInteractionEnabled=true
                        self.buttonClub.isUserInteractionEnabled=true
                        self.textfieldClub.backgroundColor=UIColor.white
                        self.textfieldClub.text! = (self.muarrayClubListArray.value(forKey: "Name") as AnyObject).object(at: 0) as! String
                        self.setClubID = (self.muarrayClubListArray.value(forKey: "ID") as AnyObject).object(at: 0) as! String
                    }
                    else
                    {
                        
                       // self.textfieldClub.textFieldRemoveImage()
                        self.textfieldClub.text = nil
                        self.view.makeToast("No Clubs", duration: 2, position: CSToastPositionCenter)
                        self.buttonClub.isUserInteractionEnabled=false
                        self.textfieldClub.isUserInteractionEnabled=false
                        self.textfieldClub.backgroundColor=UIColor(red:206.0/255.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1.0)
                    }
                    self.pickerViewClubList.reloadAllComponents()
                  //  self.loaderClass.window=nil
                }
                else
                {
                  //  self.loaderClass.window=nil
                     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                //SVProgressHUD.dismiss()
                    self.hideMBProgress()
                }
                self.hideMBProgress()
               // self.loaderClass.window=nil
            }
        })
    }
}


