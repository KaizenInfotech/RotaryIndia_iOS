//
//  SubGroupListController.swift
//  TouchBase
//
//  Created by Kaizan on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SVProgressHUD
class SubGroupListController: UIViewController,webServiceDelegate , UITableViewDataSource, UITableViewDelegate {
   // v//ar appDelegate : AppDelegate!
    let bounds = UIScreen.main.bounds
    
    var groupIDX : String = ""
     var isAdmin:NSString!
    var appDelegate : AppDelegate = AppDelegate()
    var moduleName:String! = ""
    var groupIdsArray:NSMutableArray!
    var isCalledFrom:NSString!

    @IBOutlet var subGroupTableView: UITableView!
    @IBOutlet var noResultLbl: UILabel!
    var mainArray : NSArray!
     @IBOutlet var addButton: UIButton!
    
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
    
    //--pull to refresh data on collection view
    @objc func refresh(_ sender:AnyObject) {
        // Code to refresh table view
        // refreshControl.endRefreshing()
        self.refreshControl?.endRefreshing()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            subGroupTableView.isHidden=false
            
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getSubGroupsList(groupIDX as NSString)
        }
        else
        {
            subGroupTableView.isHidden=true
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
      
         SVProgressHUD.dismiss()
        }
        

        //self.view.makeToast("", duration: <#T##NSTimeInterval#>, position: <#T##AnyObject!#>)
        self.subGroupTableView.reloadData()
        self.refreshControl?.endRefreshing()
        self.refreshControl?.isHidden=true
    }
    
    override func viewDidLoad()
    {
        

        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //---pulll to refresh
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(SubGroupListController.refresh(_:)), for: UIControl.Event.valueChanged)
        subGroupTableView.addSubview(refreshControl)
        
        
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.addButton.frame.size.height-51, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.lightGray
        addButton.addSubview(lbel)
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
       // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
       
        mainArray = NSArray()
        
        let tblView =  UIView(frame: CGRect.zero)
        subGroupTableView.tableFooterView = tblView
        subGroupTableView.tableFooterView!.isHidden = true
        if(isCalledFrom=="list"){
            addButton.isHidden=true
        }else{
             //groupIdsArray = NSMutableArray()
            addButton.isHidden=false
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            subGroupTableView.isHidden=false

            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getSubGroupsList(groupIDX as NSString)
        }
        else
        {
            subGroupTableView.isHidden=true
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       SVProgressHUD.dismiss()
        
        }
        

        
    
    }
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //self.title=moduleName
        self.title="Sub Groups"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SubGroupListController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SubGroupListController.AddSubGroupAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        if(isCalledFrom != "add"){
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes"
        {
        self.navigationItem.rightBarButtonItem = add
        }
        }
    }
    
    @objc func AddSubGroupAction()
    {
        
       // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("createsubgrpp") as UIViewController, animated: true)
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("add_event") as UIViewController, animated: true)
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "createsubgrpp") as! CreateSubgrpViewController
        SubGroupController.grpId = groupIDX as NSString
        
        self.navigationController?.pushViewController(SubGroupController, animated: true)
    }
    
     @objc func backClicked(){
        
        UserDefaults.standard.set("Yes", forKey: "session_IsComingFromPop")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getSubGroupsResultDelegate(_ subGroupList : TBGetSubGroupListResult)
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if (subGroupList.status == "0")
            {
                if(subGroupList.subGroupResult.count == 0){
                    noResultLbl.isHidden=false
                    addButton.isHidden=true
                    mainArray = NSArray()
                    subGroupTableView.reloadData()
                }else{
                    noResultLbl.isHidden=true
                    mainArray = subGroupList.subGroupResult as NSArray
                    subGroupTableView.reloadData()
                }
            }
            else
            {
                //noResultLbl.text="No event is there to attend"
                noResultLbl.isHidden=false
                addButton.isHidden=true
                mainArray = NSArray()
                subGroupTableView.reloadData()
            }
        }
        else
        {
            if (subGroupList.status == "0")
            {
                if(subGroupList.subGroupResult.count == 0){
                    noResultLbl.isHidden=false
                    addButton.isHidden=true
                    mainArray = NSArray()
                    subGroupTableView.reloadData()
                }else{
                    noResultLbl.isHidden=true
                    mainArray = subGroupList.subGroupResult as NSArray
                    subGroupTableView.reloadData()
                }
            }
            else
            {
                //noResultLbl.text="No event is there to attend"
                noResultLbl.isHidden=false
                addButton.isHidden=true
                mainArray = NSArray()
                subGroupTableView.reloadData()
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
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = subGroupTableView.dequeueReusableCell(withIdentifier: "subGroup", for: indexPath) as! subGroupCell
        
        
        var subGroupList = Subgroup()
        subGroupList = mainArray.object(at: indexPath.row) as! Subgroup
        
        cell.groupName.text   =  subGroupList.subgrpTitle  //nameTitles[indexPath.row]
        cell.noOfMembersLabel.text =  String(format:"No of members: %@",subGroupList.noOfmem)

        if(isCalledFrom=="list"){
            addButton.isHidden=true
            cell.chkBTn.isHidden=true
        }else{
            addButton.isHidden=false
            cell.chkBTn.isHidden=false
            if(groupIdsArray.count>0){
                if   (groupIdsArray.contains(subGroupList.subgrpId)){
                    print("yes it exists")
                    cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }else{
                    
                    cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    print("no")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var subGroupList = Subgroup()
        subGroupList = mainArray.object(at: indexPath.row) as! Subgroup
        tableView.deselectRow(at: indexPath, animated: true)
        if(isCalledFrom=="list"){
            let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "subDetail") as! SubGroupDetailViewController
            SubGroupController.grpId = groupIDX as NSString
            SubGroupController.subgrpId=subGroupList.subgrpId as! NSString
            SubGroupController.subTitleTxt=subGroupList.subgrpTitle
            self.navigationController?.pushViewController(SubGroupController, animated: true)
        }
        else
        {
        let cell : subGroupCell = tableView.cellForRow(at: indexPath) as! subGroupCell
            
        
        if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside if")
            
            groupIdsArray.remove(subGroupList.subgrpId)
            
            print(groupIdsArray)
            
        }else{
            
            groupIdsArray.add(subGroupList.subgrpId)
            
            print(groupIdsArray)
            
            cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside else")
        }
            //NSUserDefaults.standardUserDefaults().setObject("", forKey: "groupsID")
            //NSUserDefaults.standardUserDefaults().setObject(groupIdsArray, forKey: "groupsID")

        }
     
    }
    
    
    @IBAction func AddGroupsAction(_ sender: AnyObject)
    {
        
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
      

        
        
        if groupIdsArray.count == 0
        {
            let alert = UIAlertController(title: "Rotary India", message: "Please Select atleast 1 Group", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
            
//            self.view.makeToast("Please Select atleast 1 Group", duration: 2, position: CSToastPositionCenter)

            
        }
        else
        {
            let alert = UIAlertController(title: "Rotary India", message: (groupIdsArray.count == 1) ? "Group Added Successfully" : "Groups Added Successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                
                print(self.groupIdsArray.count)
                  UserDefaults.standard.set("no", forKey: "session_IsComingFromPop")
                UserDefaults.standard.set(self.groupIdsArray, forKey: "groupsID")
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

