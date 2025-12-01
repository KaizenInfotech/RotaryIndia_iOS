//
//  AnnouncementListController.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol protocolForAnnouncementListingCallingApi {
    func functionForAnnouncementListingCallingApi(stringFromWhereITCalling:String)
}
class AnnouncementListController: UIViewController , UITableViewDataSource , UITableViewDelegate ,UITextFieldDelegate,webServiceDelegate,UIPickerViewDataSource, UIPickerViewDelegate,protocolForAnnouncementListingCallingApi{
    func functionForAnnouncementListingCallingApi(stringFromWhereITCalling: String) {
        print("being called from :------")
        print(stringFromWhereITCalling)
        allAnnouncemArry=[]
        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "masterUID")
        {
            // self.loaderClass.loaderViewMethod()
            print(grpDetailPrevious)
            wsm.getAllAnnouncementOFUSer(varGetID as NSString, memberProfileId: memberProfileId as NSString , searchText: "",type: annType,isAdmin: isAdmin,moduleId:moduleId)
        }
    }
    
    
    //----------------------------------------------------
    
    //-------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
//        allAnnouncemArry=[]
        self.annType="1"
        self.listTypeTextField.text="Published"
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "masterUID")
        {
//             self.loaderClass.loaderViewMethod()
            print(grpDetailPrevious)
            wsm.getAllAnnouncementOFUSer(varGetID as NSString, memberProfileId: memberProfileId as NSString , searchText: "",type: annType,isAdmin: isAdmin,moduleId:moduleId)
        }
       
    }
    
    
    var varGetID = ""
    var pickerDataSource = [ "Published", "All", "Scheduled", "Expired"];
    var pickerDataSourceNonAdmin = [ "Published", "All", "Expired"];
    var annType:NSString!
    var isAdmin:NSString!
    var moduleName:String! = ""
    var moduleId:NSString!
    var SMSCountStr : String!
    var isCategory:String!=""
    var grpName:String!=""
    var memberProfileId:String=""
    // @IBOutlet weak var viewFoSearchrUnderLine: UILabel!
    @IBOutlet weak var viewFoSearchrUnderLine: UITextField!
    
    // var loaderClass  = WebserviceClass()
    var varGetSearchBoxValue:String!=""
    @IBOutlet var pickerView:UIPickerView!
    let bounds = UIScreen.main.bounds
    @IBOutlet weak  var searchTextField : UITextField!
    @IBOutlet weak  var listTypeTextField : UITextField!
    @IBOutlet var AnnouncementTableView: UITableView!
    @IBOutlet var headerVC:UIView!
    var grpDetail:GroupList!
    var grpDetailPrevious:NSDictionary!
    var allAnnouncemArry:NSArray!
    @IBOutlet var noResultLbl: UILabel!
    var appDelegate : AppDelegate!
    override func viewDidLoad()
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        super.viewDidLoad()
        print(isAdmin)
        print("VARGETID-----\(varGetID)")
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.annType="1"
        self.listTypeTextField.text="Published"
        
        searchTextField.borderStyle = .roundedRect
        listTypeTextField.borderStyle = .roundedRect
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        if isAdmin == "Yes"
        {
            searchTextField.delegate = self
            listTypeTextField.delegate = self
            
            viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
            searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.listTypeTextField.frame.size.width+50), height: self.searchTextField.frame.size.height)
            
            listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+18, y: self.listTypeTextField.frame.origin.y, width: self.listTypeTextField.frame.size.width+28, height: self.listTypeTextField.frame.size.height)
            listTypeTextField.isHidden = false
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
        }
        else
        {
            searchTextField.delegate = self
            viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
            searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-30, height: self.searchTextField.frame.size.height)
            
            listTypeTextField.isHidden = true
            self.pickerView.isHidden=true
        }
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
        /*
         if isAdmin == "Yes"
         {
         searchTextField.delegate = self
         listTypeTextField.delegate = self
         
         viewFoSearchrUnderLine.frame = CGRectMake(self.viewFoSearchrUnderLine.frame.origin.x, self.viewFoSearchrUnderLine.frame.origin.y, self.view.frame.size.width, self.viewFoSearchrUnderLine.frame.size.height)
         searchTextField.frame = CGRectMake(self.searchTextField.frame.origin.x, self.searchTextField.frame.origin.y, self.view.frame.size.width-(self.listTypeTextField.frame.size.width+20), self.searchTextField.frame.size.height)
         
         listTypeTextField.frame = CGRectMake(self.searchTextField.frame.size.width+20, self.listTypeTextField.frame.origin.y, self.listTypeTextField.frame.size.width, self.listTypeTextField.frame.size.height)
         listTypeTextField.hidden = false
         self.pickerView.hidden=true
         self.searchAnnouncemt()
         }
         else
         {
         searchTextField.delegate = self
         viewFoSearchrUnderLine.frame = CGRectMake(self.viewFoSearchrUnderLine.frame.origin.x, self.viewFoSearchrUnderLine.frame.origin.y, self.view.frame.size.width, self.viewFoSearchrUnderLine.frame.size.height)
         searchTextField.frame = CGRectMake(self.searchTextField.frame.origin.x, self.searchTextField.frame.origin.y, self.view.frame.size.width-30, self.searchTextField.frame.size.height)
         
         listTypeTextField.hidden = true
         self.pickerView.hidden=true
         }
         */
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
       
        //view will appear code
        allAnnouncemArry=[]
        SMSCountStr = ""
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "masterUID")
        {
            // self.loaderClass.loaderViewMethod()
            print(grpDetailPrevious)
            wsm.getAllAnnouncementOFUSer(varGetID as NSString, memberProfileId: memberProfileId as NSString , searchText: "",type: annType,isAdmin: isAdmin,moduleId:moduleId)
        }
        
        
        
    }
   
    
    
    
    
    
    func getallAnnounOFUSerSuccss(string:TBAnnounceListResult){
        
        if isAdmin == "Yes" {
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AnnouncementListController.AddAnnouncementAction))
            add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)//UIColor.blueColor()
            self.navigationItem.rightBarButtonItem = add
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        SMSCountStr = string.smscount
        
        
        print(SMSCountStr)
        print( string.smscount)
        
        
        if string.status == "1"
        {
            //  self.loaderClass.window = nil
            allAnnouncemArry=[]
            AnnouncementTableView.reloadData()
            noResultLbl.text="No results"
            noResultLbl.isHidden=false
            view.bringSubviewToFront( noResultLbl)
        }
        else{
            // self.loaderClass.window = nil
            noResultLbl.isHidden=true
            allAnnouncemArry=string.announListResult as? NSArray
            print(allAnnouncemArry.count)
            
            AnnouncementTableView.reloadData()
        }
        // self.loaderClass.window = nil
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
        }
        
        //SVProgressHUD.dismiss()
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        self.headerVC.translatesAutoresizingMaskIntoConstraints = true
        self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 60)
        return self.headerVC;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func searchAnnouncemt(){
        allAnnouncemArry=[]
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "masterUID")
        {
            // self.loaderClass.loaderViewMethod()
            noResultLbl.isHidden=true
            wsm.getAllAnnouncementOFUSer(varGetID as NSString, memberProfileId: memberProfileId as NSString , searchText: varGetSearchBoxValue as! NSString,type:annType,isAdmin: isAdmin,moduleId:moduleId)
        }
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AnnouncementListController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AnnouncementListController.AddAnnouncementAction))
//        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)//UIColor.blueColor()
//        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
//        if mainMemberID == "Yes"
//        {
//            self.navigationItem.rightBarButtonItem = add //14 mar
//        }
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func AddAnnouncementAction(){ //add_announce
        UserDefaults.standard.set("", forKey: "groupsID")
        let addAnnounce = self.storyboard?.instantiateViewController(withIdentifier: "add_announce") as! AddAnnounceController
        addAnnounce.isCalledFRom="add"
        self.pickerView.isHidden=true
        addAnnounce.groupID = varGetID
        addAnnounce.moduleId = moduleId
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        addAnnounce.groupProfileID = memberProfileId
        addAnnounce.commonIDString=""
        addAnnounce.SMSCountStr = SMSCountStr
        addAnnounce.isCategory=self.isCategory
        addAnnounce.objprotocolForAnnouncementListingCallingApi=self
        // addAnnounce.varIsType=""
        self.navigationController?.pushViewController(addAnnounce, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("allAnnouncemArry.count--------\(allAnnouncemArry.count)")
        return allAnnouncemArry.count
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            if(textField.tag==22)
            {
                
                listTypeTextField.resignFirstResponder()
                self.view .bringSubviewToFront( self.pickerView)
                self.pickerView.isHidden=true
                
            }
            else
            {
                self.pickerView.isHidden=true
                searchTextField.resignFirstResponder()
                self.searchAnnouncemt()
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
            
            return false
            
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            
            if(textField.tag==22){
                searchTextField.resignFirstResponder()
                self.view .bringSubviewToFront( self.pickerView)
                self.pickerView.isHidden=false
                
                return false
            }else{
                
                return true
            }
        }
        else
        {
            self.view.makeToast("Please check your internet connection, Please try again later", duration: 2, position: CSToastPositionCenter)
            return false
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = AnnouncementTableView.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! AnnouncementCell
        var grp:AnnounceList!
        grp=allAnnouncemArry[indexPath.row] as? AnnounceList
        cell.announceNameLabel.text=grp.announTitle
        cell.announceDateTimeLabel.text = grp.publishDateTime
        if(grp.isRead == "No"){
            cell.announceNameLabel.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
            //  cell.contentView.backgroundColor = UIColor.lightGrayColor()
        }else{
            cell.announceNameLabel.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            //  cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        if(grp.filterType=="1"){
            cell.announceStatus.text=String(format: "Status: Published")
        }else if(grp.filterType=="2"){
            cell.announceStatus.text=String(format: "Status: Scheduled")
        }else if(grp.filterType=="3"){
            cell.announceStatus.text=String(format: "Status: Expired")
        }
        return cell
        
        //let indexPath = NSIndexPath(forRow: index, inSection: 0)
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        UserDefaults.standard.setValue("nothing", forKey: "session_LinkValueAnnouncement")

        AnnouncementTableView.deselectRow(at: indexPath, animated: true)
        var grp:AnnounceList!
        grp=allAnnouncemArry[indexPath.row] as! AnnounceList
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "announceDetail") as! AnnouncementDetailController
        secondViewController.annDetail=grp
        
        print(grp)
        
        self.pickerView.isHidden=true
        
        
//        let varGetNotifCount = grpDetailPrevious.object(forKey: "notificationCount") as! String
//        print(varGetNotifCount)
        
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        
        secondViewController.grpID = varGetID as NSString
        secondViewController.isCalled = "list"
        secondViewController.SMSCountStr = SMSCountStr
        secondViewController.profileId = memberProfileId as NSString
        secondViewController.moduleId = moduleId
        secondViewController.moduleName = moduleName
        secondViewController.isCategory=self.isCategory
        secondViewController.grpName=self.grpName

        UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
        secondViewController.objprotocolForAnnouncementListingCallingApi=self
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isAdmin == "Yes"
        {
            return pickerDataSource.count;
        }
        else
        {
            return pickerDataSourceNonAdmin.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isAdmin == "Yes"
        {
            return pickerDataSource[row]
        }
        else
        {
            return pickerDataSourceNonAdmin[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(pickerDataSource[row])
        //var pickerDataSource = ["All", "Published", "Scheduled", "Expired"];
        
        
        if isAdmin == "Yes"
        {
            if(pickerDataSource[row]=="All")
            {
                self.listTypeTextField.text="All"
                self.annType="0"
            }
            else if(pickerDataSource[row]=="Published")
            {
                self.listTypeTextField.text="Published"
                
                self.annType="1"
            }
            else if(pickerDataSource[row]=="Scheduled")
            {
                self.listTypeTextField.text="Scheduled"
                self.annType="2"
            }
            else if(pickerDataSource[row]=="Expired"){
                self.listTypeTextField.text="Expired"
                self.annType="3"
            }
            else{
                self.annType="1"
            }
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
            
            
        }
        else
        {
            if(pickerDataSourceNonAdmin[row]=="All"){
                self.listTypeTextField.text="All"
                self.annType="0"
            }else if(pickerDataSourceNonAdmin[row]=="Published"){
                self.listTypeTextField.text="Published"
                self.annType="1"
            }else if(pickerDataSourceNonAdmin[row]=="Expired"){
                self.listTypeTextField.text="Expired"
                
                self.annType="3"
            }else{
                self.annType="1"
            }
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        */
    }
    /*--------------------------------------*/
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        varGetSearchBoxValue = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        
        // print(strValue)
        print(strValues)
        print(searchTextField.text)
        
        //        if(strValues.length != 0)
        //        {
        //            if(textField.tag==22)
        //            {
        //                listTypeTextField.resignFirstResponder()
        //                self.view .bringSubviewToFront(self.pickerView)
        //                self.pickerView.hidden=true
        //                //return false
        //            }
        //            else
        //            {
        //                //searchTextField.resignFirstResponder()
        //                self.searchAnnouncemt()
        //            }
        //        }
        return true
    }
}



