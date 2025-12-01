//
//  GroupInfoController.swift
//  TouchBase
//
//  Created by Kaizan on 26/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class GroupInfoController: UIViewController , UITableViewDataSource,UITableViewDelegate , webServiceDelegate ,grpInfocellDelegate{
    
    let bounds = UIScreen.main.bounds
    var userGroupID:NSString!
    var userProfileID:NSString!
    var mainArray : NSArray!
    var appDelegate : AppDelegate = AppDelegate()
    var dropDown_flag = Bool()
    @IBOutlet var NoRecordLabel: UILabel!
    var detailsArray = NSArray()
    var titlesArray = NSArray()
    var isGrpAdmin : NSString!
    let dropDownView = UIView()
    var PersonalButton = UIButton()
    var grpInfoClass = GetGroupInfo()
     var isCalled:NSString!

    
    @IBOutlet var GroupInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        mainArray = NSArray()
        
        titlesArray = ["Address","Email","Mobile","Created Date & Time","Entity Admin"]
        //detailsArray = ["Sanjay Ganpat Sagwekar","B-102,Kalpataru csh. , sector19, koparkhairane,Navi mumbai - 400709. ahahaha  ahahhahah htyuer ueyhg sdjkfgh uei ewtruewio jkghdskjgewgh ewkjghdsjkfg e geegsdegf ewgefgeg","info@kaizeninfotech.com","+91 9899778899","15 Nov. 2015 1:30 pm"]
        
        
        PersonalButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        //let masterUUID = defaults.stringForKey("masterUID")
        
        
        if ((self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer))) != nil)
        {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
        
        
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self    //masterUUID!
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        wsm.getGroupInfoDetail(mainMemberID! as NSString, grpID: userGroupID)

    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer : UIGestureRecognizer) -> Bool
    {
        return false
    }
    
  
    
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Info"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GroupInfoController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 50, y: 0, width: 30, height: 40)
        editB.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(GroupInfoController.DropDownAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
//        let addMemberB = UIButton(type: UIButton.ButtonType.custom)
//        addMemberB.frame = CGRectMake(0, 0, 30, 40)
//        addMemberB.setImage(UIImage(named:"groupsettings_btn"), forState: UIControl.State.Normal)
//        addMemberB.addTarget(self, action: #selector(GroupInfoController.grpSettingAction), forControlEvents: UIControl.Event.TouchUpInside)
//        let addMember: UIBarButtonItem = UIBarButtonItem(customView: addMemberB)
       
        
        let buttons : NSArray = [edit]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
     print(isGrpAdmin)
    if isGrpAdmin == "Yes"
    {
        dropDownView.frame = CGRect(x: self.view.frame.size.width-150, y: 64, width: 150, height: 160) // 160 , 215
        dropDownView.isHidden = true
        dropDownView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
        //  self.view.addSubview(dropDownView)
        UIApplication.shared.keyWindow?.addSubview(dropDownView)
        dropDown_flag = false
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button1.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button1.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button1.addTarget(self, action: #selector(GroupInfoController.AddMemberAction), for: .touchUpInside)
        button1.setTitle("Add Member",  for: UIControl.State.normal)
        button1.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button1)
        
        let border = UIImageView()
        border.frame = CGRect(x: 0, y: 52, width: 150, height: 1)
        border.backgroundColor = UIColor.lightGray
        dropDownView.addSubview(border)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: 55, width: 150, height: 50)
        button2.addTarget(self, action: #selector(GroupInfoController.GroupSettingAction), for: .touchUpInside)
        button2.setTitle("Settings",  for: UIControl.State.normal)
        button2.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button2.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button2.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button2)
        
        let border1 = UIImageView()
        border1.frame = CGRect(x: 0, y: 107, width: 150, height: 1)
        border1.backgroundColor = UIColor.lightGray
        dropDownView.addSubview(border1)
        
        let button3 = UIButton()
        button3.frame = CGRect(x: 0, y: 110, width: 150, height: 50)
        button3.addTarget(self, action: #selector(GroupInfoController.EditGroupAction), for: .touchUpInside)
        button3.setTitle("Edit Entity",  for: UIControl.State.normal)
        button3.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button3.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button3.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button3)
/*
        let border2 = UIImageView()
        border2.frame = CGRectMake(0, 162, 150, 1)
        border2.backgroundColor = UIColor.lightGrayColor()
        dropDownView.addSubview(border2)
        
        let button4 = UIButton()
        button4.frame = CGRectMake(0, 165, 150, 50)
        button4.addTarget(self, action: #selector(GroupInfoController.PreferencesAction), forControlEvents: .TouchUpInside)
        button4.setTitle("Preferences", forState: UIControl.State.Normal)
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button4.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        button4.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        button4.titleLabel?.font = UIFont(name: "Open-Sans Regular", size: 15)
        dropDownView.addSubview(button4)
*/
    }
    else
    {
        dropDownView.frame = CGRect(x: self.view.frame.size.width-150, y: 64, width: 150, height: 105 ) // 105 , 160
        dropDownView.isHidden = true
        dropDownView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
        //  self.view.addSubview(dropDownView)
        UIApplication.shared.keyWindow?.addSubview(dropDownView)
        dropDown_flag = false
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button1.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button1.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button1.addTarget(self, action: #selector(GroupInfoController.AddMemberAction), for: .touchUpInside)
        button1.setTitle("Add Member",  for: UIControl.State.normal)
        button1.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button1)
        
        let border = UIImageView()
        border.frame = CGRect(x: 0, y: 52, width: 150, height: 1)
        border.backgroundColor = UIColor.lightGray
        dropDownView.addSubview(border)
        
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: 55, width: 150, height: 50)
        button2.addTarget(self, action: #selector(GroupInfoController.GroupSettingAction), for: .touchUpInside)
        button2.setTitle("Group Setting",  for: UIControl.State.normal)
        button2.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button2.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button2.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button2)
/*
        let border2 = UIImageView()
        border2.frame = CGRectMake(0, 162, 150, 1)
        border2.backgroundColor = UIColor.lightGrayColor()
        dropDownView.addSubview(border2)
        
        let button4 = UIButton()
        button4.frame = CGRectMake(0, 165, 150, 50)
        button4.addTarget(self, action: #selector(GroupInfoController.PreferencesAction), forControlEvents: .TouchUpInside)
        button4.setTitle("Preferences", forState: UIControl.State.Normal)
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button4.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        button4.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        button4.titleLabel?.font = UIFont(name: "Open-Sans Regular", size: 15)
        dropDownView.addSubview(button4)
*/
        
    }
        
        
}
    
    
    func PreferencesAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
        }
        
        var grpInfo = GetGroupInfo()
        grpInfo = mainArray.object(at: 0) as! GetGroupInfo
        
        let preferences = self.storyboard!.instantiateViewController(withIdentifier: "preferences_view") as! PreferencesViewController
        preferences.grpNameStr = grpInfo.grpNAme
        self.navigationController?.pushViewController(preferences, animated: true)
    }
    
    
     @objc func backClicked()
    {
         dropDownView.isHidden = true
       
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else{
       
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func EditGroupAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
        }
        let editGrp = self.storyboard!.instantiateViewController(withIdentifier: "create_group") as! CreateGroupController
        //editGrp.groupInfoClass =  grpInfoClass
        editGrp.isClassFrom = "Edit"
        var grpInfo = GetGroupInfo()
        grpInfo = mainArray.object(at: 0) as! GetGroupInfo
        print(grpInfo.grpId)
        editGrp.groupIDEdit = grpInfo.grpId as String
        editGrp.userGroupID = userGroupID as String
        editGrp.userProfileID = userProfileID as String
        
        self.navigationController?.pushViewController(editGrp, animated: true)
    }
    
//    func grpSettingAction()
//    {
//        print("Settings")
//        if dropDown_flag == false
//        {
//            if dropDownView.hidden == false
//            {
//                dropDown_flag = true
//            }
//            else
//            {
//                dropDown_flag = false
//            }
//            dropDownView.hidden = true
//        }
//        else
//        {
//            if dropDownView.hidden == false
//            {
//                dropDown_flag = false
//            }
//            else
//            {
//                dropDown_flag = true
//            }
//            dropDownView.hidden = true
//        }
//        
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("grp_settings") as UIViewController, animated: true)
//        
//    }
    
    @objc func AddMemberAction()
    {
        print("Add Member")
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
        }
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "add_member_group") as! AddMemberToGroupController
        profVC.GroupID =  userGroupID as String
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    @objc func GroupSettingAction()
    {
        print("Edit group")
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "grp_settings") as! GroupSettingsController
        secondViewController.grpID=userGroupID
        secondViewController.grpProfileID=userProfileID
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    @objc func DropDownAction()
    {
        if dropDown_flag == false
        {
            dropDown_flag = true
            dropDownView.isHidden = false
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GroupInfoController.dismissView))
            view.addGestureRecognizer(tap)
        }
        else
        {
            dropDown_flag = false
            dropDownView.isHidden = true
        }
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true)
    }
    
    @objc func dismissView()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
        }
    }
    
/*
    func getDirectoryDetailDelegate(memberDetail : MemberListDetailResult)
    {
        mainArray = memberDetail.MemberDetails as NSArray
        
        
        var memberDet = MemberListDetail()
        memberDet = mainArray.objectAtIndex(0) as! MemberListDetail
        
        isShowBusiness = memberDet.isBusinDetVisible
        isShowFamily   = memberDet.isFamilDetailVisible
        
        /// ----- Family Array ////----
        
        
        //   var arrayAFamilyArray = NSArray()
        FamArray = memberDet.familyMemberDetails as NSArray
        // var familyClass = FamilyMemberDetil()
        // for var i=0 ; i > arrayAFamilyArray.count ; i++
        //  {
        //     familyClass = arrayAFamilyArray.objectAtIndex(i) as! FamilyMemberDetil
        //
        // FamArray.addObject(arrayAFamilyArray.objectAtIndex(i))
        
        // }
        
        
        print(FamArray)
        print(FamArray.count)
        
        
        ProfileTableView.reloadData()
        
    }
*/
//    @IBAction func NextButtonAction(sender: AnyObject)
//    {
//        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true) // group_detail  , directory , events
//    }
    
    func adminBtnClk(_ adminprofileID:NSString){
        var grpInfo = GetGroupInfo()
        grpInfo = mainArray.object(at: 0) as! GetGroupInfo
         UserDefaults.standard.set("no", forKey: "picadded")
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        profVC.userGroupID =  grpInfo.grpId as! NSString  //nameTitles[indexPath.row]
        profVC.userProfileID =  grpInfo.grpAdminProfileId as! NSString   //mobileTitles[indexPath.row]
        profVC.isAdmin = "No"
        profVC.isCalled = "list"
         let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        profVC.mainUSerPRofileID = mainMemberID as! NSString
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    
    func getGroupInfoDetailDelegate(_ grpInfoDetail : TBGetGroupResult)
    {
        GroupInfoTableView.estimatedRowHeight = 70.0
        GroupInfoTableView.rowHeight = UITableView.automaticDimension
        print(grpInfoDetail.status)
       
        if grpInfoDetail.status == "0"
        {
            NoRecordLabel.isHidden = true
          
            mainArray = grpInfoDetail.getGroupDetailResult as NSArray
            
            print(mainArray)
            
            GroupInfoTableView.reloadData()
        }
        else
        {
            NoRecordLabel.isHidden = false
            GroupInfoTableView.reloadData()
         
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return 1
        }
        else
        {
            return titlesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        if(section == 1)
        {
            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
            headerView.backgroundColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0)
                        
            var PersonalButton : UILabel;
            PersonalButton = UILabel.init(frame: CGRect(x: 5, y: 0, width: self.view.frame.size.width-10, height: 40))
            if(mainArray.count > 0){
            var grpInfo = GetGroupInfo()
            grpInfo = mainArray.object(at: 0) as! GetGroupInfo
            
            PersonalButton.text=grpInfo.grpNAme
            }
            PersonalButton.textColor = UIColor.black
         
            PersonalButton.font = UIFont(name: "Open Sans-semibold", size: 18)
            headerView.addSubview(PersonalButton)
            
            return headerView
        }
        else
        {
            return nil
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1)
        {
            return 40
        }
        else
        {
            return 0
        }
    }
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //
    //        if(indexPath.section == 0)
    //        {
    //            return 225
    //        }
    //        else
    //        {
    //          //  return 70
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        //////// ----------Profile Main Section /////-----------
        
        if(indexPath.section == 0)
        {
            let cell = GroupInfoTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupDPCell
            
            if mainArray.count > 0
            {
                var grpInfo = GetGroupInfo()
                grpInfo = mainArray.object(at: 0) as! GetGroupInfo
                
                grpInfoClass  =  grpInfo
                
                // cell.ProfilePic.layer.cornerRadius = 20;
                cell.indicator.startAnimating()
              //  let checkedUrl = NSURL(string: grpInfo.grpImg)
                if let checkedUrl = URL(string: grpInfo.grpImg) {
                    
                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                        DispatchQueue.main.async { () -> Void in
                            guard let data = data, error == nil else { return }
                            print(response?.suggestedFilename ?? "")
                            print("Download Finished")
                            cell.GroupPic.image =  UIImage(data: data)//self.imageWithGradient(UIImage(data: data))
                            cell.indicator.stopAnimating()
                            //  cell.activityLoader.stopAnimating()
                        }
                    }
                }
                else{
                     cell.GroupPic.image =  UIImage(named: "imageplaceholder")//self.imageWithGradient(UIImage(named: "profile_pic"))
                    cell.indicator.stopAnimating()
                }
                
                cell.GroupNameLabel.text = grpInfo.grpNAme
                cell.GroupAddressLabel.text = grpInfo.grpAddress
                
                
            }
            else
            {
                cell.GroupNameLabel.text = ""
                cell.GroupAddressLabel.text = ""
                cell.GroupPic.image = UIImage(named: "imageplaceholder")
                    //self.imageWithGradient(UIImage(named: "profile_pic"))
                
            }
            
            return cell
        }
        else
        {
                let cell = GroupInfoTableView.dequeueReusableCell(withIdentifier: "groupInfoCell", for: indexPath) as! GroupInfoCell
            
                if mainArray.count > 0
                {
                    var grpInfo = GetGroupInfo()
                    grpInfo = mainArray.object(at: 0) as! GetGroupInfo
                
                    detailsArray = [grpInfo.grpAddress,grpInfo.grpEmail,grpInfo.grpMobile,grpInfo.createdDateTime,grpInfo.grpAdmin]
                    if(indexPath.row == titlesArray.count-1){
                        cell.grpAdminPRf.isHidden=false
                        cell.adminprofileID = grpInfo.grpAdminProfileId as! NSString
                        cell.GroupDetailLabel.translatesAutoresizingMaskIntoConstraints = true
                        cell.GroupDetailLabel.frame = CGRect(x: 35,y: 33,width: 300, height: 21)
                    }else{
                        cell.grpAdminPRf.isHidden=true
                    }
                   cell.delegates=self
                    cell.GroupLabel.text = titlesArray[indexPath.row] as? String
                    cell.GroupDetailLabel.text = detailsArray.object(at: indexPath.row) as? String
                        
                }
                else
                {
                            
                }
            
            return cell
        }
    
    }
   
    func editProfile()
    {
        print("Edit Profile")
    }
  
    func imageWithGradient(_ img:UIImage!) -> UIImage{
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.65, 1.0]
        //1 = opaque
        //0 = transparent
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        //myy code
        // let gradient = CGGradient(colorsSpace: colorSpace,
        //    colors: [top, bottom], locations: locations)
        
        
        //let startPoint = CGPoint(x: img.size.width/2, y: 0)
        // let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
        
        
        // context!.drawLinearGradient(gradient!,start: startPoint,end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}



