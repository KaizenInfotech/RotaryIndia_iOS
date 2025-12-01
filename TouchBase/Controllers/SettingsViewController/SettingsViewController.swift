
//
//  SettingsViewController.swift
//  TouchBase
//
//  Created by Kaizan on 09/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class SettingsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  , webServiceDelegate, settingDelegate          {
    
    let bounds = UIScreen.main.bounds
    @IBOutlet var grpSettingsTableView: UITableView!
    var cellArray : NSMutableArray!
    var titleArray = NSArray()
    var selectedArray : NSMutableArray!
    var menuTitles:NSArray!
    var appDelegate : AppDelegate!
    
    var boolean = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AllRSVPBActionA", name: "AllRSVPann", object: nil)
       boolean = true
        titleArray = ["Kaizen Infotech","THane HillView","Indian Overseas"]
        //       let tblView =  UIView(frame: CGRectZero)
        //       grpSettingsTableView.tableFooterView = tblView
        
        selectedArray = NSMutableArray()
        menuTitles = NSArray()
        selectedArray = titleArray.mutableCopy() as! NSMutableArray
        
        cellArray=[]
       
       
    
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            grpSettingsTableView.isHidden=false

            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            wsm.getTouchBaseSetting(mainMemberID!)
        }
        else
        {
            grpSettingsTableView.isHidden=true
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       
         SVProgressHUD.dismiss()
        
        
        }

        
        
        
        //createCEll()
    }
    func getTouchBaseSettigSucc(_ docListing : TBSettingResult){
        
        if(docListing.status == "0"){
             menuTitles=docListing.allTBSettingResults as! NSArray
            createCEll()
            grpSettingsTableView.reloadData()
        }
       
        
    }
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Settings"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SettingsViewController.backClicked), for: UIControl.Event.touchUpInside)
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
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        let headerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        let lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        lbl.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
        lbl.text = ""
        headerView.addSubview(lbl)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 10, y: 0, width: 300, height: 40)
        titleLabel.text = "By turning it off, You will not receive any notification from that particular Entity."
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 10)
        //titleLabel.font = titleLabel.font.fontWithSize(11)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if cellArray.count == 0
        {
            return 0
        }
        else
        {
            return cellArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func createCEll(){
        
        for index in 0 ..< menuTitles.count
        {
            let cell = grpSettingsTableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            var grp:SettingResult!
            grp=menuTitles[index] as! SettingResult
            cell.grpName.text = grp.grpName
            cell.grpID=grp.grpId as! NSString
            cell.delegates = self
            cell.NotifyOnOffSwitch.tag = index
            if(grp.grpVal == "1" ){
                cell.NotifyOnOffSwitch.isOn = true
            }else{
                cell.NotifyOnOffSwitch.isOn = false
            }
           
            cellArray.add(cell)
        }
    }
    
    func changeSWitchVal(_ switchVal:NSString,grpId:NSString){
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        print(" switchval \(switchVal) grp id \(grpId)")
        
        
        boolean = false
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.updateTouchBaseSetting(grpId as String, UpdatedValue: switchVal as String, mainMasterId: mainMemberID!)
        
    }
    func updateTouchBaseSettigSucc(_ docListing : TBSettingResult){
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return cellArray.object(at: indexPath.row) as! UITableViewCell
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

