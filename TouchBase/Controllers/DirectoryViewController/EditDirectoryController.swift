//
//  EditDirectoryController.swift
//  TouchBase
//
//  Created by Kaizan on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SDWebImage
class EditDirectoryController: UIViewController,UITextFieldDelegate,webServiceDelegate , UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    
    let loaderClass  = WebserviceClass()
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    @IBOutlet var NoRecordLabel: UILabel!
    var groupIDX : String = ""
    var moduleName: String! = ""
    var profileIdsArray:NSMutableArray!
    var copymainArray : NSArray!
 //   var strProfileIDs : String = ""
   // var  cell:EditDirCell=EditDirCell()
    var appDelegate : AppDelegate = AppDelegate()
    
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet var directoryTableView: UITableView!
    
    @IBOutlet var searchBarObj:UISearchBar!  // It's for your search bar object
    
    var is_searching = false   // It's flag for searching
    //var dataArray:NSMutableArray!  // Its data array for UITableview
    var searchingDataArray:NSMutableArray! // Its data searching array that need for search result show
    var mainArray : NSArray!
    var isCalledFRom:NSString!
    var groupProfileID:String=""
    // var appDelegate : AppDelegate!
    
    
    override func viewDidLoad()
    {
       // print(profileIdsArray.count)
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonAdd.frame.size.height-46, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.lightGray
        buttonAdd.addSubview(lbel)
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        print(profileIdsArray)
        NoRecordLabel.isHidden=true
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
      //  print(isCalledFRom)
        
        if(isCalledFRom == "add")
        {
        profileIdsArray = NSMutableArray()
            
        }
        else if (isCalledFRom == "addEvent" || isCalledFRom == "addAnnounce")
        {
            profileIdsArray = NSMutableArray()
            profileIdsArray.add(self.groupProfileID)
            print("Intent id:: \(self.profileIdsArray)")
        }
        
        mainArray = NSArray()
        
        let tblView =  UIView(frame: CGRect.zero)
        directoryTableView.tableFooterView = tblView
        directoryTableView.tableFooterView!.isHidden = true
        searchingDataArray = []
       // directoryTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "dirCell")
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        //loaderClass.loaderViewMethod()
        wsm.getDirectoryListGroupsOFUSer(mainMemberID! as NSString, grpID: groupIDX as NSString, searchText: "", page: "")
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Add to Contacts"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EditDirectoryController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked(){
          UserDefaults.standard.set("Yes", forKey: "session_IsComingFromPop")
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDirectoryResultDelegate(_ dirList : TBMemberResult)
    {
//        if (dirList.status == "0")
//        {
//            let a = dirList.MemberListResults as NSArray
//            mainArray = NSMutableArray(array: a)
//            directoryTableView.reloadData()
//        }
//        else
//        {
//            mainArray = NSMutableArray()
//            directoryTableView.reloadData()
//        }
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if (dirList.status == "0")
            {
                self.loaderClass.window=nil
                NoRecordLabel.isHidden = true
                copymainArray = dirList.memberListResults as! NSArray
                mainArray=copymainArray .mutableCopy() as! NSArray
                directoryTableView.reloadData()
            }
            else
            {
                self.loaderClass.window=nil
                NoRecordLabel.isHidden = false
                copymainArray = NSArray()
                mainArray=copymainArray .mutableCopy() as! NSArray
                directoryTableView.reloadData()
            }
        }
        else
        {
            self.loaderClass.window=nil
            if (dirList.status == "0")
            {
                self.loaderClass.window=nil
                NoRecordLabel.isHidden = true
                copymainArray = dirList.memberListResults as! NSArray
                mainArray=copymainArray .mutableCopy() as! NSArray
                directoryTableView.reloadData()
            }
            else
            {
                self.loaderClass.window=nil
                NoRecordLabel.isHidden = false
                copymainArray = NSArray()
                mainArray=copymainArray .mutableCopy() as! NSArray
                directoryTableView.reloadData()
            }

            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
        }
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("@@@@ \(mainArray)")
        return mainArray.count //Currently Giving default Value
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width+5, height: 60)
        headerView.backgroundColor = UIColor.white
        
        
        let headerImageView = UIImageView()
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 60)
        headerImageView.image = UIImage(named: "heder2")
        headerView.addSubview(headerImageView)
        
        let textImageView = UIImageView()
        textImageView.frame = CGRect(x: 30, y: 10, width: self.view.frame.size.width-60, height: 35)
        textImageView.image = UIImage(named: "textfield")
        textImageView.isUserInteractionEnabled = true
        headerImageView.addSubview(textImageView)
        
        
        searchTextField.frame = CGRect(x: 35, y: 12, width: self.view.frame.size.width-60, height: 35)
        searchTextField.placeholder = "Search for Directory"
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.isUserInteractionEnabled = true
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.delegate=self
        searchTextField.addTarget(self, action: #selector(EditDirectoryController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        headerView.addSubview(searchTextField)
        searchTextField.returnKeyType = .search
        searchTextField.autocorrectionType = .no
        headerView.bringSubviewToFront( searchTextField)
        
        return headerView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
//        let wsm : WebserviceClass = WebserviceClass.sharedInstance
//        wsm.delegates=self
//        wsm.getDirectoryListGroupsOFUSer("1", grpID: "", searchText: textField.text!, page: "")
//        
//        searchTextField.resignFirstResponder()
       searchTextField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        if(textField.text!==""){
            mainArray = copymainArray .mutableCopy() as! NSArray
            if(mainArray.count == 0) {
                NoRecordLabel.isHidden = false
                directoryTableView.isHidden = true;
            }
            else {
                NoRecordLabel.isHidden = true
                directoryTableView.isHidden = false;
            }
           // searchTextField.text=""; //Comment By DEepak 28Feb2018
           // searchTextField.resignFirstResponder()  //Comment By DEepak 28Feb2018
            directoryTableView.reloadData()
        }else{
            mainArray=[]
            let predicate = NSPredicate(format: "memberName contains[c] %@", searchTextField.text!)
            mainArray = copymainArray.filtered(using: predicate) as NSArray
            print(mainArray)
            print(copymainArray)
            if (mainArray.count==0) {
                NoRecordLabel.isHidden = false
                directoryTableView.reloadData()
            }
            else{
                NoRecordLabel.isHidden = true
                directoryTableView.reloadData()
            }
          }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let  cell = directoryTableView.dequeueReusableCell(withIdentifier: "dirCell", for: indexPath) as! EditDirCell
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        print("The cell \(cell)")
        if ((isCalledFRom == "addEvent" || isCalledFRom == "addAnnounce") && self.groupProfileID==directoryList.profileID!)
        {
            print("group and profile ids ::\(self.groupProfileID) and \(directoryList.profileID!)")
            cell.chkBTn.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            cell.imageCheckUnCheck.image=UIImage(named: "CHECK_BLUE_ROW")!
            cell.chkBTn.isEnabled=false
            cell.chkBTn.isUserInteractionEnabled=false
            cell.imageCheckUnCheck.isUserInteractionEnabled=false
            //cell.isUserInteractionEnabled=false
            //cell.selectionStyle = .none
            //cell.backgroundColor=UIColor.gray
            print("Same profile ids of \(cell.nameLabel.text)")
        }

        cell.nameLabel.text   =  directoryList.memberName  //nameTitles[indexPath.row]
        cell.mobileLabel.text =  directoryList.membermobile
        var profilePic = directoryList.pic as! String
        cell.chkBTn.backgroundColor=UIColor.clear
        print("Is array has value:--->>")
        print(profileIdsArray)
        
        if(profileIdsArray.count>0){
            if   (profileIdsArray.contains(directoryList.profileID)){
                  print("yes it exists")
                  cell.chkBTn.setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                  cell.imageCheckUnCheck.image=UIImage(named: "CHECK_BLUE_ROW")!
              }else{
                cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                cell.imageCheckUnCheck.image=UIImage(named: "UN_CHECK_BLUE_ROW")!
                //imageCheckUnCheck
                print("no")
            }
        }
        
//        cell.chkBTn.addTarget(self, action: #selector(EditDirectoryController.buttonMainEventBirthAnnivClickEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        cell.chkBTn.tag=indexPath
        //cell.chkBTn.
 /*
        var directoryList = MemberListResult()
        
        if is_searching == true
        {
            directoryList = searchingDataArray.objectAtIndex(indexPath.row) as! MemberListResult
        }else
        {
            directoryList = mainArray.objectAtIndex(indexPath.row) as! MemberListResult
        }
        
        cell.chkBTn.backgroundColor=UIColor.clearColor()
        if(profileIds.count>0){
            if   (profileIds.containsObject(directoryList.profileID)){
                print("yes it exists")
                cell.chkxcBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UICoxcntrolState.Normal)
            }else{
                
                cell.chxzckBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
                print("no")
            }
        }
        
 */
        
        if(profilePic == "")
        {
         cell.profilePic.image = UIImage(named: "profile_pic")
        }
        else
        {
            if let checkedUrl = URL(string: profilePic) {
                cell.profilePic.sd_setImage(with: checkedUrl)
//                if let data = try? Data(contentsOf: checkedUrl)
//                {
//                    self.cell.profilePic.image = UIImage(data: data)
//                }
          }
        }
        
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor

        
        
//     if directoryList.pic == ""
//     {
//        cell.profilePic.image = UIImage(named: "noImg.png")
//     }
//     else
//     {
//        if let checkedUrl = NSURL(string: directoryList.pic)
//        {
//            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                    guard let data = data where error == nil else { return }
//                    print(response?.suggestedFilename ?? "")
//                    print("Download Finished")
//                    cell.profilePic.image = UIImage(data: data)
//                    
//                    //cell.activityLoader.stopAnimating()
//                }
//            }
//        }
//        else
//        {
//            cell.profilePic.image = UIImage(named: "profile_pic.png")
//        }
//        
//     }
        
        
       // cell.nameLabel.text   =  directoryList.memberName  //nameTitles[indexPath.row]
      //  cell.mobileLabel.text =  directoryList.membermobile
        

        return cell
    }
    
    /*
    func buttonMainEventBirthAnnivClickEvent(sender:UIButton)
    {
       print(sender.tag)
        
        var directoryList = MemberListResult()
        directoryList = mainArray.objectAtIndex(sender.tag) as! MemberListResult
        if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkxcBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            profileIdsArray.removeObject(directoryList.profileID)
            print(profixcvleIdsArray)
        }else{
            // print(proxcvfileIdsArray.count)
            profileIdsxcvArray.addObject(directoryList.profileID)
            //  print(profileIdxcvsArray.count)
            cell.chkxcBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
        }
    }
    
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        tableView.deselectRow(at: indexPath, animated: true)
        let cell : EditDirCell = directoryTableView.cellForRow(at: indexPath) as! EditDirCell
        
               if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                
                 cell.imageCheckUnCheck.image=UIImage(named: "UN_CHECK_BLUE_ROW")!
                
            profileIdsArray.remove(directoryList.profileID)
            print(profileIdsArray)
        }else{
                
               // print(profileIdsArray.count)
                
                cell.imageCheckUnCheck.image=UIImage(named: "CHECK_BLUE_ROW")!

            profileIdsArray.add(directoryList.profileID)
              //  print(profileIdsArray.count)
            cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
        }
        
        

//        func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//            cell.separatorInset = UIEdgeInsetsZero
//            cell.layoutMargins = UIEdgeInsetsZero
//        }
        
/*
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var directoryList = MemberListResult()
        
        if is_searching == true
        {
            directoryList = searchingDataArray.objectAtIndex(indexPath.row) as! MemberListResult
        }else
        {
            directoryList = mainArray.objectAtIndex(indexPath.row) as! MemberListResult
        }
        
        let cell : EditDirCell = tableView.cellForRowAtIndexPath(indexPath) as! EditDirCell
        
        if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkdsfBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            print("inside if")
            
            profileIdsArray.removeObject(directoryList.profileID)
            
            memberNameArray.removeObject(directoryList.memberName)
            
            print(profileIdsArray)
            
        }else{
            
            profileIdsArray.addObject(directoryList.profileID)
            
            memberNameArray.addObject(directoryList.memberName)
            
            print(profileIdsArray)
            print(memberNameArray)
            
            cell.chkBsdfTn .setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
            print("inside else")
        }
 */       
        
        
        
        
       // NSUserDefaults.standardUserDefaults().setObject("", forKey: "profID")
       // NSUserDefaults.standardUserDefaults().setObject(profileIdsArray, forKey: "profID")
    }
    
    
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
//    {
//        if searchBar.text!.isEmpty
//        {
//            is_searching = false
//            directoryTableView.reloadData()
//        }
//        else
//        {
//            print(" search text %@ %d",searchBar.text! as NSString , mainArray.count)
//            is_searching = true
//            searchingDataArray.removeAllObjects()
//            for var index = 0; index < mainArray.count; index++
//            {
//                
//                var directoryList = MemberListResult()
//                var currentString = String()
//                directoryList = mainArray.objectAtIndex(index) as! MemberListResult
//                
//                currentString = directoryList.memberName
//                
//                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil
//                {
//                    searchingDataArray.addObject(directoryList)
//                }
//            }
//            directoryTableView.reloadData()
//        }
//    }
    
    @IBAction func AddContactsAction(_ sender: AnyObject)
    {
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if profileIdsArray.count == 0
            {
                let alert = UIAlertController(title: "Rotary India", message: "Please Select atleast 1 Member", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
                
//                self.view.makeToast("Please Select atleast 1 Member", duration: 2, position: CSToastPositionCenter)

                
                
            }
            else
            {
                print(profileIdsArray.count)
                
                let alert = UIAlertController(title: "Rotary India", message: (profileIdsArray.count == 1) ? "Member Added Successfully" : "Members Added Successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    
                    UserDefaults.standard.set("no", forKey: "session_IsComingFromPop")
                    UserDefaults.standard.set(self.profileIdsArray, forKey: "profID")
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
        }
    }
}

