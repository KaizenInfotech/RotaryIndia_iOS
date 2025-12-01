//
//  NewDistrictMemberListViewController.swift
//  TouchBase
//
//  Created by tt on 16/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
class NewDistrictMemberListViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource  {
    
    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    
    @IBOutlet weak var tableMemberListShow: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var varGetSearchText:String!=""
    var District_ID:String!=""
    var GetGroupID:String!=""
    var GetModuleName:String!=""
    var muarrayMemberListingMain:NSArray=NSArray()
    var distSubCommittee:NSArray=NSArray()
    var distSubCommitteeSearch:NSArray=NSArray()
    var distSubCommitteeDetail:NSArray=NSArray()
    var distSubCommitteeDetailSearch:NSArray=NSArray()
    var muarraMemberSearch:NSArray=NSArray()
    var distSubCommBool = false
    var distSubCommDetailBool = false
    var muarrayMemberBool = false
    var superSubCommitteeDetailBool = false
    var distSubCommitteeDetailID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMemberListShow.separatorStyle = .singleLine
        
//        self.edgesForExtendedLayout=[]
        //tableMemberListShow.separatorStyle = .none
        createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            getDistrictCommiteeMemberList()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
           SVProgressHUD.dismiss()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = GetModuleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewDistrictMemberListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Server Calling
    func getDistrictCommiteeMemberList()
    {
        
        let completeURL:String! = baseUrl+"DistrictCommittee/districtCommitteeDetails"
        let parameterst = [
            "DistrictCommitteID" : District_ID , "groupID":GetGroupID,
            ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            let dd = response as! NSDictionary
            print("dd \(dd)")
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.loaderClass.window=nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
           
             SVProgressHUD.dismiss()
            }
            else
            {
                
                if((dd.object(forKey: "TBDistrictCommitteeDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    
                    
                    let arrarrNewDirectoryData = (((dd.object(forKey: "TBDistrictCommitteeDetailsResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "districtCommitteeWithoutCatList") as! NSArray)
                    print(arrarrNewDirectoryData)
                    self.muarrayMemberListingMain = arrarrNewDirectoryData
                    self.muarraMemberSearch = arrarrNewDirectoryData
                    if(self.muarrayMemberListingMain.count>0)
                    {
                        self.muarrayMemberBool = true
                        //self.lblNoResult.hidden=true
                    }
                    else
                    {
                        self.muarrayMemberBool = false
                        // self.lblNoResult.hidden=false
                    }
                    
                    let distSubComResponse = (((dd.object(forKey: "TBDistrictCommitteeDetailsResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "district_sub_Committee") as! NSArray)
                    print(distSubComResponse)
                    self.distSubCommittee = distSubComResponse
                    self.distSubCommitteeSearch = distSubComResponse
                    
                    if(self.distSubCommittee.count > 0) {
                        if self.superSubCommitteeDetailBool {
                            self.distSubCommBool = false
                        } else {
                            self.distSubCommBool = true
                        }
                    } else {
                        self.distSubCommBool = false
                    }
                    
                    if let distSubComDetailResponse = (((dd.object(forKey: "TBDistrictCommitteeDetailsResult")! as AnyObject)
                                        .object(forKey: "Result")! as AnyObject)
                                        .object(forKey: "district_sub_Committee_Details_list")) as? [[String: Any]] {
                        
                        let filtered = distSubComDetailResponse.filter { dict in
                            if let id = dict["fk_District_sub_Committee_id"] as? String {
                                return id == self.distSubCommitteeDetailID
                            }
                            return false
                        }
                        
                        print("Filtered data: \(filtered)")
                        
                        print(distSubComDetailResponse)
                        self.distSubCommitteeDetail = filtered as NSArray
                        self.distSubCommitteeDetailSearch = filtered as NSArray
                    }
                    
                    self.tableMemberListShow.reloadData()
                    
                    self.loaderClass.window = nil
                    
                    
                }
                
            }
            SVProgressHUD.dismiss()
        })
        /*----------------------------------------------------------------------------------------------------------------------------*/
    }
    
    
    //MARK:- Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        varGetSearchText = searchBar.text!
        print(varGetSearchText)
        if(searchText.characters.count>0)
        {
            let predicate =  NSPredicate(format: "name contains[c] %@ OR Designation contains[c] %@ OR DistrictDesignation contains[c] %@", varGetSearchText,varGetSearchText,varGetSearchText)
            // let predicate =  NSPredicate(format: "memberName contains[c] %@ ", varGetSearchText)
            let searchDataSource = muarrayMemberListingMain.filtered(using: predicate)
            muarraMemberSearch = searchDataSource as NSArray
            print(muarraMemberSearch)
            
            if(self.distSubCommBool) {
                let searchSubCommDataSource = distSubCommittee.filtered(using: predicate)
                distSubCommitteeSearch = searchSubCommDataSource as NSArray
                print(searchSubCommDataSource)
            }
            
            if(self.distSubCommDetailBool) {
                let searchSubCommDetailDataSource = distSubCommitteeDetail.filtered(using: predicate)
                distSubCommitteeDetailSearch = searchSubCommDetailDataSource as NSArray
                print(searchSubCommDetailDataSource)
            }
            
            self.tableMemberListShow.reloadData()
        }
        else
        {
            muarraMemberSearch=NSArray()
            self.muarraMemberSearch = self.muarrayMemberListingMain
            self.distSubCommitteeSearch = self.distSubCommittee
            self.distSubCommitteeDetailSearch = self.distSubCommitteeDetail
            self.tableMemberListShow.reloadData()
            searchBar.resignFirstResponder()
        }
        
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
            let predicate =  NSPredicate(format: "name contains[c] %@ OR Designation contains[c] %@ OR DistrictDesignation contains[c] %@", varGetSearchText,varGetSearchText,varGetSearchText)
            // let predicate =  NSPredicate(format: "memberName contains[c] %@ ", varGetSearchText)
            let searchDataSource = muarrayMemberListingMain.filtered(using: predicate)
            muarraMemberSearch=searchDataSource as NSArray
            print(muarraMemberSearch)
            
            if(self.distSubCommBool) {
                let searchSubCommDataSource = distSubCommittee.filtered(using: predicate)
                distSubCommitteeSearch = searchSubCommDataSource as NSArray
                print(searchSubCommDataSource)
            }
            
            if(self.distSubCommDetailBool) {
                let searchSubCommDetailDataSource = distSubCommitteeDetail.filtered(using: predicate)
                distSubCommitteeDetailSearch = searchSubCommDetailDataSource as NSArray
                print(searchSubCommDetailDataSource)
            }
            
            self.tableMemberListShow.reloadData()
        }
        else
        {
            muarraMemberSearch=NSArray()
            self.muarraMemberSearch = self.muarrayMemberListingMain
            self.distSubCommitteeSearch = self.distSubCommittee
            self.distSubCommitteeDetailSearch = self.distSubCommitteeDetail
            self.tableMemberListShow.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        muarraMemberSearch=NSArray()
        self.muarraMemberSearch = self.muarrayMemberListingMain
        self.distSubCommitteeSearch = self.distSubCommittee
        self.distSubCommitteeDetailSearch = self.distSubCommitteeDetail
        self.tableMemberListShow.reloadData()
        searchBar.resignFirstResponder()
    }
    
    
    /*----------------------------------------------------------------------------DPK----------------------------*/
    
    
    
    //MARK:- Table Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.distSubCommBool) {
            return distSubCommitteeSearch.count
        } else if(self.distSubCommDetailBool) {
            return distSubCommitteeDetailSearch.count
        } else {
            return muarraMemberSearch.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableMemberListShow.dequeueReusableCell(withIdentifier: "NewDistictMemberCell", for: indexPath) as! NewDistictMemberCell
        if (self.distSubCommBool) {
            cell.imgProfile.isHidden = true
            cell.lblDesignation.isHidden = true
            cell.lblMemberName.text = (distSubCommitteeSearch.value(forKey: "name") as AnyObject).object(at: indexPath.row) as? String
        } else if(self.distSubCommDetailBool) {
            cell.imgProfile.isHidden = false
            cell.lblDesignation.isHidden = false
            cell.lblMemberName.text = (distSubCommitteeDetailSearch.value(forKey: "name") as AnyObject).object(at: indexPath.row) as? String
            cell.lblDesignation.text = (distSubCommitteeDetailSearch.value(forKey: "DistrictDesignation") as AnyObject).object(at: indexPath.row) as? String
            let varDetailImage = (distSubCommitteeDetailSearch.value(forKey: "img") as AnyObject).object(at: indexPath.row) as! String
            cell.imgProfile.ImageCircle()
            if varDetailImage == ""
            {
                cell.imgProfile.image = UIImage(named: "profile_pic.png")
            }
            else
            {
                let ImageProfilePic:String = varDetailImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imgProfile.sd_setImage(with: checkedUrl)
            }
        } else {
            cell.lblMemberName.text = (muarraMemberSearch.value(forKey: "name") as AnyObject).object(at: indexPath.row) as? String
            cell.lblDesignation.text = (muarraMemberSearch.value(forKey: "DistrictDesignation") as AnyObject).object(at: indexPath.row) as? String
            let varImage = (muarraMemberSearch.value(forKey: "img") as AnyObject).object(at: indexPath.row) as! String
            cell.imgProfile.ImageCircle()
            if varImage == ""
            {
                cell.imgProfile.image = UIImage(named: "profile_pic.png")
            }
            else
            {
                let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imgProfile.sd_setImage(with: checkedUrl)
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (self.distSubCommBool) {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictMemberListViewController") as! NewDistrictMemberListViewController
            
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
            obj.District_ID = District_ID
                obj.GetModuleName = (distSubCommitteeSearch.value(forKey: "name") as AnyObject).object(at: indexPath.row) as? String
                obj.GetGroupID = GetGroupID
                obj.distSubCommBool = false
                obj.distSubCommDetailBool = true
                obj.superSubCommitteeDetailBool = true
                obj.distSubCommitteeDetailID = (distSubCommitteeSearch.value(forKey: "pk_District_sub_Committee_id") as AnyObject).object(at: indexPath.row) as? String ?? ""
            self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    SVProgressHUD.dismiss()
            }
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "NewDistrictProfileDetailsViewController") as! NewDistrictProfileDetailsViewController
            appDelegate = UIApplication.shared.delegate as! AppDelegate
             if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                 if (self.distSubCommDetailBool) {
                     obj.muarrayListData=self.distSubCommitteeDetailSearch
                     obj.selectedIndex = indexPath.row
                 } else {
                     obj.muarrayListData=self.muarraMemberSearch
                     obj.selectedIndex = indexPath.row
                 }
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
               SVProgressHUD.dismiss()
            }
        }
        
      
        
        
        
        
        //muarrayListData
        
    }
    /*------------------------Local Data Fetch / Save / Update / Delete ---------------Start------------------------*/
    
}

