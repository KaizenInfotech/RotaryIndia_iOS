//
//  GroupSettingsController.swift
//  TouchBase
//
//  Created by Kaizan on 09/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD

class GroupSettingsController: UIViewController , UITableViewDataSource, UITableViewDelegate  , webServiceDelegate,grpsettingDelegate{
    
    let bounds = UIScreen.main.bounds
    @IBOutlet var grpSettingsTableView: UITableView!
    var cellArray : NSMutableArray!
     var sec2cellArray : NSMutableArray!
    var titleArray = NSArray()
    var selectedArray : NSMutableArray!
    var grpID : NSString!
    var grpProfileID : NSString!
     var menuTitles:NSArray!;
    var tbgrpSetng:TBGroupSettingResult!
    
    var boolean = Bool()
    
    var appDelegate : AppDelegate!
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
       
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("AllRSVPBActionA"), name: "AllRSVPann", object: nil)
        
        titleArray = ["E-bulletine","Announcement","Events","Meetings"]
        boolean = true
        selectedArray = NSMutableArray()
        menuTitles=[]
        selectedArray = titleArray.mutableCopy() as! NSMutableArray
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
       
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            wsm.getTouchBasegroupsSetting(grpProfileID as String, GroupId: grpID as String)
            cellArray=NSMutableArray()
            sec2cellArray=NSMutableArray()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
      
         SVProgressHUD.dismiss()
        }
        
        
     
        //createCEll()
        
    }
    func getTouchBaseGroupsSettigSucc(_ docListing : TBGroupSettingResult){
        if(docListing.status == "0"){
            
            tbgrpSetng=docListing
            menuTitles = docListing.gRpSettingResult as! NSArray
            createCEll()
            grpSettingsTableView.reloadData()
        }
    }
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Entity Settings"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GroupSettingsController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
      
        
    }
    
     @objc func backClicked()
    {
        if boolean == false
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            Alert.title = "Rotary India"
            Alert.message = "Settings UPDATED Successfully!"
            Alert.addButton(withTitle: "Ok")
            Alert.show()
        }

        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if(section == 0){
            let headerView = UIView()
            
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
          
            headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 10, y: 5, width: 300, height: 30)
            titleLabel.text = "Notification Settings"
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
            headerView.addSubview(titleLabel)
        
        return headerView
        }else{
            let headerView = UIView()
            
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
            
            headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
            let lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
            lbl.backgroundColor = UIColor.darkGray
            
            lbl.text = ""
            headerView.addSubview(lbl)
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 10, y: 5, width: 300, height: 30)
            titleLabel.text = "Personal details settings"
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 16)
            headerView.addSubview(titleLabel)
            
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        if(section == 0){
        let headerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
        
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 10, y: 1, width: 300, height: 40)
        titleLabel.text = "By turning it off, You will not receive any notification from that particular Module."
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 10)
        //titleLabel.font = titleLabel.font.fontWithSize(11)
        headerView.addSubview(titleLabel)
        
        return headerView
        }else{
            let headerView = UIView()
            
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
            let lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
            headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
            lbl.text = ""
            headerView.addSubview(lbl)
            
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 10, y: 0, width: 300, height: 30)
            titleLabel.text = "By turning it off, Others cant see your details."
            titleLabel.textColor = UIColor.darkGray
            titleLabel.numberOfLines = 3
            titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 10)
            //titleLabel.font = titleLabel.font.fontWithSize(11)
            headerView.addSubview(titleLabel)
            
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 40
        }
        else
        {
            return 30
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0){
        if menuTitles.count == 0
        {
            return 0
        }
        else
        {
            return menuTitles.count
        }
        }else if(section == 1){
        
            if cellArray.count == 0
            {
                return 0
            }
            else
            {
                return 3
            }
        
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func createCEll(){
        cellArray.removeAllObjects()
        sec2cellArray.removeAllObjects()
        for index in 0 ..< menuTitles.count
        {
            let cell = grpSettingsTableView.dequeueReusableCell(withIdentifier: "grpSettingsCell") as! grpSettingsCell
            var grp:GRpSettingDetails!
            grp=menuTitles[index] as! GRpSettingDetails
            cell.ModuleNameLabel.text = grp.modName
            cell.moduleID=grp.moduleId as! NSString
            cell.delegates = self
            cell.NotifyOnOffSwitch.tag = index
            if(grp.modVal == "1" ){
                cell.NotifyOnOffSwitch.isOn = true
            }else{
                cell.NotifyOnOffSwitch.isOn = false
            }
            
            cellArray.add(cell)
        }
        
//        let cell = grpSettingsTableView.dequeueReusableCellWithIdentifier("grpSettingsCell") as! grpSettingsCell
//        cell.ModuleNameLabel.text="Hide mobile number"
//        cell.moduleID="m"
//        cell.delegates = self
//        if(tbgrpSetng.isMob == "1" ){
//            cell.NotifyOnOffSwitch.on = true
//        }else{
//            cell.NotifyOnOffSwitch.on = false
//        }
//        cellArray.addObject(cell)
//        
//        let cell1 = grpSettingsTableView.dequeueReusableCellWithIdentifier("grpSettingsCell") as! grpSettingsCell
//        cell1.ModuleNameLabel.text="Hide Email"
//        cell1.moduleID="e"
//        cell1.delegates = self
//        if(tbgrpSetng.isEmail == "1" ){
//            cell1.NotifyOnOffSwitch.on = true
//        }else{
//            cell1.NotifyOnOffSwitch.on = false
//        }
//        cellArray.addObject(cell1)
        let cell2 = grpSettingsTableView.dequeueReusableCell(withIdentifier: "grpSettingsCell") as! grpSettingsCell
        cell2.ModuleNameLabel.text="Personal Details"
        cell2.moduleID="p"
        cell2.delegates = self
        if(tbgrpSetng.isPersonal == "1" ){
            cell2.NotifyOnOffSwitch.isOn = true
        }else{
            cell2.NotifyOnOffSwitch.isOn = false
        }
       // cell2.detailTextLabel?.text = "By turning it off,No one can see your personal details."
        sec2cellArray.add(cell2)
        
        let cell3 = grpSettingsTableView.dequeueReusableCell(withIdentifier: "grpSettingsCell") as! grpSettingsCell
        cell3.ModuleNameLabel.text="Business Details"
        cell3.moduleID="b"
        cell3.delegates = self
        if(tbgrpSetng.isBusiness == "1" ){
            cell3.NotifyOnOffSwitch.isOn = true
        }else{
            cell3.NotifyOnOffSwitch.isOn = false
        }
        sec2cellArray.add(cell3)
        
        let cell4 = grpSettingsTableView.dequeueReusableCell(withIdentifier: "grpSettingsCell") as! grpSettingsCell
        cell4.ModuleNameLabel.text="Family Details"
        cell4.moduleID="f"
        cell4.delegates = self
        if(tbgrpSetng.isFamily == "1" ){
            cell4.NotifyOnOffSwitch.isOn = true
        }else{
            cell4.NotifyOnOffSwitch.isOn = false
        }
        sec2cellArray.add(cell4)
        
    }
    func changeSWitchVal(_ switchVal:NSString,modulId:NSString){
        var mdlID:NSString!
        if(modulId == "m"){
            mdlID = " "
            tbgrpSetng.isMob = switchVal as String
        }else if(modulId == "e"){
            mdlID = " "
            tbgrpSetng.isEmail = switchVal as String
        }else if(modulId == "p"){
            mdlID = " "
            tbgrpSetng.isPersonal = switchVal as String
        }else if(modulId == "f"){
            mdlID = " "
            tbgrpSetng.isFamily = switchVal as String
        }else if(modulId == "b"){
            mdlID = " "
            tbgrpSetng.isBusiness = switchVal as String
        }else{
            mdlID = modulId
        }
        
        boolean = false
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.updategrpTouchBaseSetting(grpID as String, UpdatedValue: switchVal as String, GroupProfileId:grpProfileID as String , ModuleId: mdlID as String, isMob: "1", isEmail: "1", isPersonal: tbgrpSetng.isPersonal, isFamily: tbgrpSetng.isFamily, isBusiness: tbgrpSetng.isBusiness)
    }
    func updategrpTouchBaseSettigSucc(_ docListing : TBGroupSettingResult){
        if(docListing.status == "1"){/*
            let alert = UIAlertController(title: "Rotary India", message: "Failed to update setting.Try again later.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Failed to update setting, try again later.", duration: 2, position: CSToastPositionCenter)

            
            
        }
    }
    
//    func switchValueDidChange(sender:UISwitch!)
//    {
//        if (sender.on == true){
//            print("on")
//            
//           // print(String(format:"%@ is on",locale: titleArray[sender.tag]))
//            selectedArray.addObject(titleArray[sender.tag])
//            
//        }
//        else{
//            print("off")
//            
//            //print(String(format:"%@ is off",titleArray[sender.tag]))
//            
//            selectedArray.removeObject(titleArray[sender.tag])
//        }
//    }
//    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(indexPath.section == 0){
            
       
            return cellArray.object(at: indexPath.row) as! UITableViewCell
       
        }else{
            
        return sec2cellArray.object(at: indexPath.row) as! UITableViewCell

        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    
    @IBAction func SaveSettingsAction(_ sender: AnyObject)
    {
        print(selectedArray)
    }
    
    @IBAction func CancelSettingsAction(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


