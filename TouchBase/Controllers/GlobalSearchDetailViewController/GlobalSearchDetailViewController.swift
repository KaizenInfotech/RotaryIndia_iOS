//
//  GlobalSearchDetailViewController.swift
//  TouchBase
//
//  Created by Umesh on 16/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class GlobalSearchDetailViewController: UIViewController , webServiceDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var groupsTableView: UITableView!
    @IBOutlet var headerVC:UIView!
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    @IBOutlet var memberMobileLabel: UILabel!
    @IBOutlet var memberNameLabel: UILabel!
    @IBOutlet var MemberProfileImage: UIImageView!
  
    @IBOutlet var NoRecordLabel: UILabel!
    var OtherMemberUID : String = ""
    
    var mainArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        createNavigationBar()
        
        // Do any additional setup after loading the view.
        self.headerVC.translatesAutoresizingMaskIntoConstraints = true
        self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 294)
        self.groupsTableView.tableHeaderView=self.headerVC
        groupsTableView.reloadData()
        
        mainArray = NSArray()
        let masterUID = UserDefaults.standard.string(forKey: "masterUID")
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self        //
        wsm.getGlobalSearchDetail(masterUID! as NSString, otherMemId: OtherMemberUID as NSString) // OtherMemberUID  ,   "8"
        
        //120 // 117
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Profile Result"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GlobalSearchDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
       // let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("AddAnnouncementAction"))
        //add.tintColor = UIColor.whiteColor()
        //self.navigationItem.rightBarButtonItem = add
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getGLobalSearchDetailDelegate(_ globalDetail : TBGlobalSearchGroupResult)
    {
        print(globalDetail.message)
        
        if globalDetail.status == "0"
        {
            groupsTableView.isHidden = false
            NoRecordLabel.isHidden = true
            
            mainArray = globalDetail.allGlobalGroupListResults as NSArray
            
            memberNameLabel.text = globalDetail.membername
            memberMobileLabel.text = globalDetail.membermobile
            
            if let checkedUrl = URL(string: globalDetail.profilepicpath) {
                
                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                    DispatchQueue.main.async { () -> Void in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? "")
                        print("Download Finished")
                        self.MemberProfileImage.image =  UIImage(data: data)
                        
                        //  cell.activityLoader.stopAnimating()
                    }
                }
            }else
            {
                self.MemberProfileImage.image = UIImage(named: "profile_pic.png")
            }
            groupsTableView.reloadData()
        }
        else
        {
            groupsTableView.isHidden = true
            NoRecordLabel.isHidden = false
        }
    }
    
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "grpCell", for: indexPath) as! GlobalGrpCell
        
        
        var groupClass = GlobalGroupResult()
        groupClass = mainArray.object(at: indexPath.row) as! GlobalGroupResult
        
        
        cell.grpNameLabel.text = groupClass.grpName
        
        if let checkedUrl = URL(string: groupClass.grpImg) {
            
            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                DispatchQueue.main.async { () -> Void in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    cell.grpImage.image =  UIImage(data: data)
                    
                    //  cell.activityLoader.stopAnimating()
                }
            }
        }else
        {

             cell.grpImage.image = UIImage(named: "profile_pic.png")
        }
        
        
        if groupClass.isMygrp == "N"
        {
            cell.isUserInteractionEnabled = false;
            cell.grpNameLabel.isEnabled = false;
            cell.grpImage.highlightedImage = nil
            cell.ArrowImage.highlightedImage = nil
            cell.ArrowImage.isUserInteractionEnabled = false
        }
        
        
        //var grp:AnnounceList!
//        grp=allAnnouncemArry[indexPath.row] as! AnnounceList
//        cell.announceNameLabel.text=grp.announTitle
//        cell.announceDateTimeLabel.text = grp.publishDateTime
//        if(grp.isRead == "No"){
//            cell.announceNameLabel.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
//            //  cell.contentView.backgroundColor = UIColor.lightGrayColor()
//        }else{
//            cell.announceNameLabel.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
//            //  cell.contentView.backgroundColor = UIColor.whiteColor()
//        }
//        if(grp.filterType=="1"){
//            cell.announceStatus.text=String(format: "Status: Published")
//        }else if(grp.filterType=="2"){
//            cell.announceStatus.text=String(format: "Status: Unpublished")
//        }else if(grp.filterType=="3"){
//            cell.announceStatus.text=String(format: "Status: Expired")
//        }
        return cell
        
        //let indexPath = NSIndexPath(forRow: index, inSection: 0)
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        groupsTableView.deselectRow(at: indexPath, animated: true)
        
        var groupClass = GlobalGroupResult()
        groupClass = mainArray.object(at: indexPath.row) as! GlobalGroupResult
        
        if groupClass.isMygrp == "Y"
        {
//            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("group_info") as! GroupInfoController
//            secondViewController.userGroupID = groupClass.grpId
//            self.navigationController?.pushViewController(secondViewController, animated: true)
             UserDefaults.standard.set("no", forKey: "picadded")
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
            profVC.userGroupID =  groupClass.grpId as! NSString  //nameTitles[indexPath.row]
            profVC.userProfileID =  groupClass.grpProfileId as! NSString   //mobileTitles[indexPath.row]
            profVC.isCalled = "list"
            profVC.isAdmin = "No"
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            profVC.mainUSerPRofileID = mainMemberID as! NSString
            self.navigationController?.pushViewController(profVC, animated: true)
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
