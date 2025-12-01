//
//  CreateSubgrpViewController.swift
//  TouchBase
//
//  Created by Umesh on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class CreateSubgrpViewController: UIViewController,webServiceDelegate,UITableViewDataSource,UITableViewDelegate{
    var appDelegate : AppDelegate!
    
    @IBOutlet var memberTableView: UITableView!
    let bounds = UIScreen.main.bounds
    @IBOutlet weak  var searchTextField : UITextField!
    @IBOutlet weak  var subgrpTitleField : UITextField!
    var mainArray : NSArray!
     var copymainArray : NSArray!
     @IBOutlet var headerVC:UIView!
    var profileIds:NSMutableArray!
    var grpId:NSString!
    override func viewDidLoad() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        createNavigationBar()
        super.viewDidLoad()
        mainArray = NSArray()
        profileIds=[]
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
       
        // Do any additional setup after loading the view.
        searchTextField.addTarget(self, action: #selector(CreateSubgrpViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
   
    
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            memberTableView.isHidden=false
            
            wsm.getDirectoryListGroupsOFUSer(mainMemberID! as NSString, grpID: grpId, searchText: "", page: "")
        }
        else
        {
            memberTableView.isHidden=true
 SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }

    
    
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Sub Groups"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateSubgrpViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked(){
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //your code
        if(textField.text!==""){
           mainArray=copymainArray .mutableCopy() as! NSArray
            if(mainArray.count == 0) {
               
                memberTableView.isHidden = true;
            }
            else {
               
                memberTableView.isHidden = false;
                
            }
           
            memberTableView.reloadData()
        }else{
            mainArray=[]
           
            let predicate = NSPredicate(format: "memberName contains[c] %@", searchTextField.text!)
            mainArray = copymainArray.filtered(using: predicate) as NSArray
            if (mainArray.count==0) {
                
               memberTableView.reloadData()
            }
            else{
                               
               memberTableView.reloadData()
            }
        }
    }

//    func createNavigationBar(){
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        
//        self.title="Create Sub Group"
//        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blackColor()]
//        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
//        self.navigationController?.navigationBar.barTintColor=UIColor.whiteColor()
//        
//         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
//        buttonleft.frame = CGRectMake(0, 0, 20, 20)
//        buttonleft.setImage(UIImage(named:"back_btn_blue"), forState: UIControl.State.Normal)
//        buttonleft.addTarget(self, action: #selector(CreateSubgrpViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
//        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
//        self.navigationItem.leftBarButtonItem = leftButton
//        
//        
//        
//    }
//    
//     @objc func backClicked(){
//        self.navigationController?.popViewControllerAnimated(true)
//    }
//    
    
    func getDirectoryResultDelegate(_ dirList : TBMemberResult)
    {
      
       
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            self.headerVC.translatesAutoresizingMaskIntoConstraints = true
            
            self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 145)
            self.memberTableView.tableHeaderView=self.headerVC
            if (dirList.status == "0")
            {
                copymainArray = dirList.memberListResults as! NSArray
                mainArray=copymainArray .mutableCopy() as! NSArray
                memberTableView.reloadData()
            }
            else
            {
                copymainArray = NSArray()
                mainArray=copymainArray .mutableCopy() as! NSArray
                
                memberTableView.reloadData()
            }
            
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            self.headerVC.translatesAutoresizingMaskIntoConstraints = true
            
            self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 145)
            self.memberTableView.tableHeaderView=self.headerVC
            if (dirList.status == "0")
            {
                copymainArray = dirList.memberListResults as! NSArray
                mainArray=copymainArray .mutableCopy() as! NSArray
                memberTableView.reloadData()
            }
            else
            {
                copymainArray = NSArray()
                mainArray=copymainArray .mutableCopy() as! NSArray
                
                memberTableView.reloadData()
            }
            
        }

        
        
        
        
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        searchTextField.resignFirstResponder()
        subgrpTitleField.resignFirstResponder()
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = memberTableView.dequeueReusableCell(withIdentifier: "submemCEll", for: indexPath) as! SubGrpMemberCell
        
        
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        
         cell.nameLabel.text   =  directoryList.memberName     //nameTitles[indexPath.row]
        cell.mobileLabel.text =  directoryList.membermobile
       
        cell.chkBTn.backgroundColor=UIColor.clear
        if(profileIds.count>0){
        if   (profileIds.contains(directoryList.profileID)){
            print("yes it exists")
             cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
        }else{
            
            cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("no")
        }
        }
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        tableView.deselectRow(at: indexPath, animated: true)
        let cell : SubGrpMemberCell = memberTableView.cellForRow(at: indexPath) as! SubGrpMemberCell
        
        if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside if")
            profileIds.remove(directoryList.profileID)
        }else{
            profileIds.add(directoryList.profileID)
            cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside else")
        }
       
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    
   @IBAction func creatSubGRpClick()
   {
  
    
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
        if(subgrpTitleField.text!=="")
        {
            if #available(iOS 8.0, *)
            {
                /*
                let alert = UIAlertController(title: "", message: "Please enter a Sub Group Name", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
          */
                self.view.makeToast("Please enter a Sub Group Name", duration: 2, position: CSToastPositionCenter)

            
            
            }
            
        }
        else
        {
            /* public string subGroupTitle { get; set; }
             public string memberProfileId { get; set; }
             public string subGroupID { get; set; }
             public string groupId { get; set; }
             public string subGroupType { get; set; }
             public string memberMainId { get; set; }
             public string parentID { get; set; }
             public string MemberIDs { get; set; }*/
            
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let strprofileIDs = profileIds.componentsJoined(by: ",")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.createSubGroup(subgrpTitleField.text! as NSString, memberProfileId:strprofileIDs as NSString , groupId: grpId, memberMainId: mainMemberID! as NSString,parentID:"0")
        }
    }
    else
    {
         SVProgressHUD.dismiss()
        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//        if(subgrpTitleField.text!=="")
//        {
//            if #available(iOS 8.0, *)
//            {
//                let alert = UIAlertController(title: "", message: "Please enter a Sub Group Name", preferredStyle: UIAlertController.Style.Alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//            
//        }
//        else
//        {
//            
//            let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
//            let strprofileIDs = profileIds.componentsJoinedByString(",")
//            let wsm : WebserviceClass = WebserviceClass.sharedInstance
//            wsm.delegates=self
//            wsm.createSubGroup(subgrpTitleField.text!, memberProfileId:strprofileIDs , groupId: grpId, memberMainId: mainMemberID!)
//        }
    }
    
    
    

    
    
    
    }
    
    func createSubGroupSucc(_ string:TBGetSubGroupListResult)
    {
        
        if(string.message == "success")
        {
            
                let alert: UIAlertView = UIAlertView()
                alert.delegate = self
                alert.title = "Rotary India"
                alert.message = String(format:"%@ created successfully!",subgrpTitleField.text!)
                alert.addButton(withTitle: "Ok")
                alert.show()
            
            
            self.navigationController?.popViewController(animated: true)
            
        }
        else
        {
         self.view.makeToast("Failed", duration: 2, position: CSToastPositionCenter)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
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
