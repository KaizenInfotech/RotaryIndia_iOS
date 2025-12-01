//
//  NewDistrictCommitteeViewController.swift
//  TouchBase
//
//  Created by rajendra on 12/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class NewDistrictCommitteeViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate , UIPickerViewDataSource {

    
    
    
    
    @IBOutlet weak var viewForSettingPicker: UIView!
    
    
    @IBAction func buttonDoneClickEvent(_ sender: Any) {
        print("done button clicked by User !!!")
        buttonOpacity.isHidden=true
        viewForSettingPicker.isHidden=true
        view.endEditing(true)
        self.view.endEditing(true)
        
        var valuethisEmpo:String! = "\'This\'"
        
        
        textfieldYearDropDown.text=varGetPickerSelectValue
        ///----
        print("This is value !!!!!!!!!!!!!!")
        print(muarrayYearlist)
        print(varGetPickerSelectValue)
        
        lblNoResult.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            yesrFilter=textfieldYearDropDown.text
            //functionForCategoryMemberSearchOnline(varGetSearchText)
            functionForCategoryListData()
            //functionForCategoryMemberSearchOnline
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
        }
        
    }
    
  
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var pickerSelectSettingMyProfileAboutPicker: UIPickerView!
    
    @IBOutlet weak var buttonYearDropDown: UIButton!
    
    @IBOutlet weak var textfieldYearDropDown: UITextField!
    
    
    @IBAction func buttonYearDropDownClickEvent(_ sender: Any) {
        view.endEditing(true)
        self.view.endEditing(true)
        if(muarrayYearlist.count>0)
        {
        print("button clicked by Screen !!!!")
        buttonOpacity.isHidden=false
        viewForSettingPicker.isHidden=false
   pickerSelectSettingMyProfileAboutPicker.reloadAllComponents()
        }
        else
        {
            self.view.makeToast("No data available.", duration: 3, position: CSToastPositionCenter)
        }
    }
    
    
    @IBAction func buttonOpacityClickEvent(_ sender: Any) {
        print("this is opacitry buittton n !!!")
        buttonOpacity.isHidden=true
        viewForSettingPicker.isHidden=true
    }
    
    
    @IBOutlet weak var buttonOpacity: UIButton!
    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    
    var muarrayListData:NSArray=NSArray()
    var muarrayCategoryListDataMain:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    var muarrayCategoryListData:NSArray=NSArray()
    
    
    //-----
    var muarrayYearlist:NSArray=NSArray()
    var currentYEsrData:String!=""
    /*
     let arrarrYearlist = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Yearlist")) as! NSArray
     let arrarrCurrentYear = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as
     */
    //-----
    
    var checkSearchNewMemberCountForNoresultShowHide:NSArray=NSArray()
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableDistrictCommiteeList: UITableView!
    
    var getGroupID:String!=""
    var getModuleID:String!=""
    var getModuleName:String!=""
    
    var varGetSearchText:String!=""
    
    //MARK:- Viewdidload
        override func viewDidLoad()
        {
        super.viewDidLoad()
            
           // textfieldYearDropDown.delegate=self as! UITextFieldDelegate
           //searchBar.barStyle=
            
            /*
            self.searchBar.searchBarStyle = UISearchBarStyle.prominent
            self.searchBar.translucent = false
            let textFieldInsideSearchBar = self.searchBar.valueForKey("searchField") as? UITextField
            textFieldInsideSearchBar?.backgroundColor = UIColor.whiteColor()
            self.searchBar.barTintColor = UIColor.whiteColor()
            */
            buttonOpacity.isHidden=true
            viewForSettingPicker.isHidden=true
            
            buttonYearDropDown.backgroundColor = UIColor.clear
            buttonYearDropDown.layer.cornerRadius = 5
            buttonYearDropDown.layer.borderWidth = 1
            buttonYearDropDown.layer.borderColor = UIColor.lightGray.cgColor
            
            
            
            
            
//        self.edgesForExtendedLayout=[]
        createNavigationBar()
        lblNoResult.isHidden=true
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                functionForCategoryListData()
            }
            else
            {
                 SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
   
            }
        }
    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "District Committee"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewDistrictCommitteeViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        varGetSearchText = searchBar.text!
        print(varGetSearchText)
        if(searchText.characters.count>0)
        {
            //functionForCategoryMemberSearchOnline(varGetSearchText)
            
            /*
            let predicate =  NSPredicate(format: "name contains[c] %@ OR DistrictDesignation contains[c] %@", varGetSearchText,varGetSearchText)
           // let predicate =  NSPredicate(format: "name contains[c] %@ ", varGetSearchText)
            let searchDataSource = muarrayMainList.filteredArrayUsingPredicate(predicate)
            muarrayListData=searchDataSource
            
            //let predicates =  NSPredicate(format: "name contains[c] %@ OR Designation contains[c] %@", varGetSearchText,varGetSearchText)
            let predicates =  NSPredicate(format: "name contains[c] %@ ", varGetSearchText)
            let searchDataSources = muarrayCategoryListDataMain.filteredArrayUsingPredicate(predicates)
            muarrayCategoryListData=searchDataSources
            print(muarrayListData)
            self.tableDistrictCommiteeList.reloadData()
 
 */
        }
        else
        {
            muarrayListData=NSArray()
            self.muarrayListData = self.muarrayMainList
            self.muarrayCategoryListData = self.muarrayCategoryListDataMain
            functionForCategoryListData()
            self.tableDistrictCommiteeList.reloadData()
            searchBar.resignFirstResponder()
        }
        
        
//        
//        if(self.muarrayListData.count+muarrayCategoryListData.count > 0)
//        {
//            self.lblNoResult.hidden=true
//        }
//        else
//        {
//            self.lblNoResult.hidden=false
//        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton=true
        print("use predicate 3 here")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        print("searchText \(searchBar.text!)")
        varGetSearchText = searchBar.text!
        print("use predicate 2 here")
        searchBar.resignFirstResponder()
        if(varGetSearchText.characters.count>0)
        {
            
            /*
            let predicate =  NSPredicate(format: "name contains[c] %@ OR DistrictDesignation contains[c] %@", varGetSearchText,varGetSearchText)
           // let predicate =  NSPredicate(format: "name contains[c] %@ ", varGetSearchText)
            let searchDataSource = muarrayMainList.filtered(using: predicate)
            muarrayListData=searchDataSource as NSArray
            
            //let predicates =  NSPredicate(format: "name contains[c] %@ OR Designation contains[c] %@", varGetSearchText,varGetSearchText)
            let predicates =  NSPredicate(format: "name contains[c] %@ ", varGetSearchText)
            let searchDataSources = muarrayCategoryListDataMain.filtered(using: predicates)
            muarrayCategoryListData=searchDataSources as NSArray
            */
            
            
            yesrFilter=textfieldYearDropDown.text
            functionForCategoryMemberSearchOnline(varGetSearchText)
            print(muarrayListData)
            print(muarrayCategoryListData)
            print(checkSearchNewMemberCountForNoresultShowHide)
//            if(self.muarrayListData.count+muarrayCategoryListData.count+checkSearchNewMemberCountForNoresultShowHide.count > 0)
//            {
//                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                self.lblNoResult.isHidden=true
//            }9784484468
//            else
//            {
//                    print("1111111111111111111111111111111111")
//                    self.lblNoResult.isHidden=false
//            }
            self.tableDistrictCommiteeList.reloadData()
        }
        else
        {
            muarrayListData=NSArray()
            self.muarrayListData = self.muarrayMainList
            self.muarrayCategoryListData = self.muarrayCategoryListDataMain
            
            print(self.muarrayListData)
            print(self.muarrayMainList)
            print(self.muarrayCategoryListDataMain)
            print(self.checkSearchNewMemberCountForNoresultShowHide)
//            if(self.muarrayListData.count+muarrayCategoryListData.count+checkSearchNewMemberCountForNoresultShowHide.count > 0)
//            {
//                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                self.lblNoResult.isHidden=true
//            }
//            else
//            {
//                print("1111111111111111111111111111111111")
//                self.lblNoResult.isHidden=false
//            }
            self.tableDistrictCommiteeList.reloadData()
        }
        
       
       
        
        
        
        
        
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text=""
            muarrayListData=NSArray()
        self.muarrayListData = self.muarrayMainList
        self.muarrayCategoryListData = self.muarrayCategoryListDataMain
        functionForCategoryListData()
        self.tableDistrictCommiteeList.reloadData()
        searchBar.resignFirstResponder()
    }
    //MARK:- Tableview Delegate As List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let count = muarrayListData.count + muarrayCategoryListData.count
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableDistrictCommiteeList.dequeueReusableCell(withIdentifier: "NewDistrictCommiteeCell", for: indexPath) as! NewDistrictCommiteeCell
        
        print("This is value :----")
        print(muarrayListData)
        print(muarrayCategoryListData)
        
        
        if indexPath.row < muarrayListData.count
        {
            // load from customerDetails array
            cell.viewSecond.isHidden=true
            cell.viewOne.isHidden=false
            cell.lblName.text = (muarrayListData.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! String
            cell.lblDesignation.text = (muarrayListData.value(forKey: "DistrictDesignation") as AnyObject).object(at: indexPath.row) as! String
            let varImage = (muarrayListData.value(forKey: "img") as AnyObject).object(at: indexPath.row) as! String
            
            if varImage == ""
            {
                cell.profileImage.image = UIImage(named: "profile_pic.png")
            }
            else
            {
                let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.profileImage.sd_setImage(with: checkedUrl)
            }
        }
        else
        {
            // load from customerDetails2 array
           // let customer = customerDetails2[indexPath.row - customerDetails.count]
            cell.viewOne.isHidden=true
            cell.viewSecond.isHidden=false
            cell.lblSecond.text = (muarrayCategoryListData.value(forKey: "name") as AnyObject).object(at: indexPath.row-muarrayListData.count) as! String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row<muarrayListData.count)
        {
           
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictProfileDetailsViewController") as! NewDistrictProfileDetailsViewController
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                obj.muarrayListData=self.muarrayListData
                obj.selectedIndex = indexPath.row
                
            self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    SVProgressHUD.dismiss()
            }
        }
        else
        {
           let catename = (muarrayCategoryListData.value(forKey: "name") as AnyObject).object(at: indexPath.row-muarrayListData.count) as! String
            print(catename)
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictMemberListViewController") as! NewDistrictMemberListViewController
            
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
            obj.District_ID = (muarrayCategoryListData.value(forKey: "Fk_DistrictCommitteeID") as AnyObject).object(at: indexPath.row-muarrayListData.count) as! String
                obj.GetModuleName = catename
                obj.GetGroupID=self.getGroupID
            self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    SVProgressHUD.dismiss()
            }
        }
        
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row < muarrayListData.count
        {
           return 60.0
        }
        else
        {
         return 45.0
        }
    }
    //MARK:- Server api calling
    var yesrFilter:String!=""
    func functionForCategoryListData()
    {
        view.endEditing(true)
        self.view.endEditing(true)
        searchBar.text=""
        //loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"DistrictCommittee/districtCommitteeList"
        let parameterst = [
            "groupId": getGroupID,
            "searchText":"",
            "Yearfilter":yesrFilter
        ]
        
        print("working here with district comitte !!!")
        print(parameterst)
        
        print(completeURL)
        SVProgressHUD.show()
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("This is print data :------------")
            print(dd)
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            //print("dd \(dd)")
            if((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                let arrarrNewDirectoryData = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithoutCatList")) as! NSArray
                print(arrarrNewDirectoryData)
                let arrarrNewCategory = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithCatList")) as! NSArray
                print(arrarrNewCategory)
                self.muarrayMainList = arrarrNewDirectoryData
                self.muarrayListData = arrarrNewDirectoryData
                self.muarrayCategoryListDataMain = arrarrNewCategory
                self.muarrayCategoryListData=arrarrNewCategory
                //---new adding by Rajendra jat 24 may 2019 fro dropdown list
                 let arrarrYearlist = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Yearlist")) as! NSArray
                 let CurrentYear = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "CurrentYear")) as! String
                
                //working here with district comitte !!!
                
                 self.muarrayYearlist=arrarrYearlist
                 self.currentYEsrData=CurrentYear

                print(self.varGetPickerSelectValue)
                print(self.currentYEsrData)
                
                var getvalue:String!=""
                getvalue=self.textfieldYearDropDown.text
                
                if(getvalue.count>0)
                {
                    //self.textfieldYearDropDown.text=self.varGetPickerSelectValue
                }
                else
                {
                self.textfieldYearDropDown.text=self.currentYEsrData
                }
                
                
                
                
                print("This is continue !!!!!")
            //    print((muarrayYearlist.value(forKey: "Yearvalue")as AnyObject).object(0) as! String)
                if(self.muarrayYearlist.count>0)
                {
                    self.varGetPickerSelectValue=(self.muarrayYearlist.value(forKey: "Yearvalue")as AnyObject).object(at: 0)as! String
                }
                
                
                
                
                print("this is data for year dropdown list !!!!!!!!!!!!!")
                print( self.muarrayYearlist)
                print(self.currentYEsrData)
                
                if(self.muarrayListData.count+self.muarrayCategoryListData.count > 0)
                {
                    self.lblNoResult.isHidden=true
                }
                else
                {
                    self.lblNoResult.isHidden=false
                    
                    print("3333333333333333333333333333333")
                }
                self.tableDistrictCommiteeList.reloadData()
                
                self.loaderClass.window = nil
            }
            else
            {
                self.loaderClass.window = nil
            }
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
        }
        })
    }

    
    
    
    
    
    //MARK:- Server api calling
    func functionForCategoryMemberSearchOnline(_ searchText:String)
    {
        print("need to write code here for filter yesar")
        muarrayMainList=NSArray()
        muarrayListData=NSArray()
        
      
        
        print("This is value :----")
        print(muarrayListData)
        print(muarrayCategoryListData)
        
         muarrayCategoryListData=NSArray()

        
        
        checkSearchNewMemberCountForNoresultShowHide=NSArray()
       // loaderClass.loaderViewMethod()
         
        let completeURL = baseUrl+"DistrictCommittee/districtCommitteeSearchList"
        let parameterst = [
            "groupId": getGroupID,
            "searchText":searchText,
            "Yearfilter":yesrFilter
        ]
       
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("Thios is response :0-0-0-------")
            print(dd)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            //print("dd \(dd)")
            if((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                let arrarrNewDirectoryData = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithoutCatList")) as! NSArray
                print(arrarrNewDirectoryData)
                self.muarrayMainList = arrarrNewDirectoryData
                self.muarrayListData = arrarrNewDirectoryData
                self.checkSearchNewMemberCountForNoresultShowHide =  arrarrNewDirectoryData
                
                
                print(self.muarrayMainList)
                 print(self.muarrayListData)
                print(self.checkSearchNewMemberCountForNoresultShowHide)
                
                
                if(self.muarrayListData.count+self.muarrayCategoryListData.count > 0)
                {
                    self.lblNoResult.isHidden=true
                }
                else
                {
                    self.lblNoResult.isHidden=false
                    print("22222222222222222222222222222222")
                }
                self.tableDistrictCommiteeList.reloadData()
                
                self.loaderClass.window = nil
            }
            else
            {
                self.loaderClass.window = nil
            }
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
        }
        })
 
       //..... ......xdfdsfds dsf sdfasdf af adsf dfdsf saddsfdsfs fadsfadsdfgfdsg sdfg sdfg sdfg sgsdfgsdfgsd f
        //loaderClass.loaderViewMethod()
        /*
        print("thios is districtCommitteeSearchList")
        let completeURL2 = baseUrl+"DistrictCommittee/districtCommitteeSearchList"
        let parameterst2 = [
            "groupId": getGroupID,
           "searchText":searchText,
            "Yearfilter":yesrFilter
        ]
        
        print("working here with district comitte !!!")
        print(parameterst2)
        print(completeURL2)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL2, parameters: parameterst2 as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("This is print data :------------")
            print(dd)
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                //print("dd \(dd)")
                if((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    
                    let arrarrNewDirectoryData = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithoutCatList")) as! NSArray
                    print(arrarrNewDirectoryData)
                    let arrarrNewCategory = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithCatList")) as! NSArray
                    print(arrarrNewCategory)
                    self.muarrayMainList = arrarrNewDirectoryData
                    self.muarrayListData = arrarrNewDirectoryData
                    self.muarrayCategoryListDataMain = arrarrNewCategory
                    self.muarrayCategoryListData=arrarrNewCategory
                    //---new adding by Rajendra jat 24 may 2019 fro dropdown list
                    let arrarrYearlist = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "Yearlist")) as! NSArray
                    let CurrentYear = (((dd.object(forKey: "TBDistrictCommitteeResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "CurrentYear")) as! String
                    
                    
                    
                    self.muarrayYearlist=arrarrYearlist
                    self.currentYEsrData=CurrentYear
                    
                  //  self.textfasdieldYearDropDown.text=self.currentYEsrData
                    
                    print("this is data for year dropdown list !!!!!!!!!!!!!")
                    print( self.muarrayYearlist)
                    print(self.currentYEsrData)
                    
                    if(self.muarrayListData.count+self.muarrayCategoryListData.count > 0)
                    {
                        self.lblNoResult.isHidden=true
                    }
                    else
                    {
                        self.lblNoResult.isHidden=false
                        
                        print("3333333333333333333333333333333")
                    }
                    self.tableDistrictCommiteeList.reloadData()
                    
                    self.loaderClass.window = nil
                }
                else
                {
                    self.loaderClass.window = nil
                }
                self.loaderClass.window = nil
                SVProgressHUD.dismiss()
            }
        })
        */
        //...........dfgfd d gfdg fdsgdfs gdfsg sdfg fsdgsfdg dfsgfsdgsdfgsdfgsdf dfg sdfg dsfgsdfgsdfgsdf dfg
    }
    //-----------------------------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muarrayYearlist.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //let countryList = GrpCountryList()
        print(muarrayYearlist)
        
        /*
         (muarrayYearlist(forKey: "name") as AnyObject).object(at: row) as! String
         */
        
        let varGetCountry:String = (muarrayYearlist.value(forKey: "Yearvalue")as AnyObject).object(at: row) as! String
        print("picker value !!!")
        print(varGetCountry)
        print(varGetPickerSelectValue)

        return varGetCountry
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let varGetCountry:String = (muarrayYearlist.value(forKey: "Yearvalue")as AnyObject).object(at: row) as! String
        varGetPickerSelectValue =   varGetCountry
        print("picker value 2222!!!")
        print(varGetPickerSelectValue)
        // print(varGetPickerSelectValue)
    }
    var varGetPickerSelectValue:String! = ""

    /*------------Search picker-------------Code by Deepak ---------------------------------------End-------------------------*/
    //Yearvalue
    //----------------------------------------------------------------------
}
/*code by rajendra jat on 05 June */
