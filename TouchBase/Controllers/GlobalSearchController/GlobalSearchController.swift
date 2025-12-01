//
//  GlobalSearchController.swift
//  TouchBase
//
//  Created by Kaizan on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//


import UIKit
import SVProgressHUD
class GlobalSearchController: UIViewController,UITextFieldDelegate,webServiceDelegate,UITableViewDataSource,UITableViewDelegate {
    //var appDelegate : AppDelegate!

    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
    
    @IBOutlet var NoRecordLabel: UILabel!
    var appDelegate : AppDelegate = AppDelegate()
    
    @IBOutlet var directoryTableView: UITableView!
    
    var mainArray : NSArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
       // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        mainArray = NSArray()
        
        searchTextField.becomeFirstResponder()
        
        let tblView =  UIView(frame: CGRect.zero)
        directoryTableView.tableFooterView = tblView
        directoryTableView.tableFooterView!.isHidden = true
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        
        

        
        
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Search"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GlobalSearchController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getDirectoryResultDelegate(_ dirList : TBMemberResult)
    {
        if (dirList.status == "0")
        {
            NoRecordLabel.isHidden = true
            mainArray = dirList.memberListResults as NSArray
            directoryTableView.reloadData()
        }
        else
        {
            NoRecordLabel.isHidden = false
            mainArray = NSArray()
            directoryTableView.reloadData()
        }
        
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
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
        searchTextField.placeholder = "Search for Global Directory"
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.isUserInteractionEnabled = true
        searchTextField.borderStyle = UITextField.BorderStyle.none
        searchTextField.delegate=self
        searchTextField.autocorrectionType = .no
        searchTextField.returnKeyType = .search
        headerView.addSubview(searchTextField)
        headerView.bringSubviewToFront( searchTextField)
        
        
        
        return headerView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getDirectoryListGroupsOFUSer(mainMemberID! as NSString, grpID: "", searchText: textField.text! as NSString, page: "")
            
            searchTextField.resignFirstResponder()
            return true
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            searchTextField.resignFirstResponder()
            return false
        }

        
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = directoryTableView.dequeueReusableCell(withIdentifier: "dirCell", for: indexPath) as! DirectoryCell
        
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        
        
        if directoryList.pic == ""
        {
            cell.profilePic.image = UIImage(named: "profile_pic")
        }
        else
        {
            if let checkedUrl = URL(string: directoryList.pic) {
                
                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                    DispatchQueue.main.async { () -> Void in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? "")
                        print("Download Finished")
                        cell.profilePic.image = UIImage(data: data)
                        
                        
                    }
                }
            }
        }
        
        //if let checkedUrl = NSURL(string: directoryList.pic)
//        {
//            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                    guard let data = data where error == nil else { return }
//                    print(response?.suggestedFilename ?? "")
//                    print("Download Finished")
//                    cell.profilePic.image = UIImage(data: data)
//                    
//                }
//            }
//        }
        
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
        cell.nameLabel.text   =  directoryList.memberName  //nameTitles[indexPath.row]
        cell.mobileLabel.text =  directoryList.membermobile
        cell.groupsLabel.text = String(format: "Part of entities: %@",directoryList.grpCount)
        
        return cell
        //let indexPath = NSIndexPath(forRow: index, inSection: 0)
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        var directoryList = MemberListResult()
        directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
        if(directoryList.grpCount=="1"){
            var directoryList = MemberListResult()
            directoryList = mainArray.object(at: indexPath.row) as! MemberListResult
             UserDefaults.standard.set("no", forKey: "picadded")
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
            profVC.userGroupID =  directoryList.grpID as! NSString  //nameTitles[indexPath.row]
            profVC.userProfileID =  directoryList.profileID as! NSString   //mobileTitles[indexPath.row]
            profVC.isCalled = "list"
            profVC.isAdmin = "No"
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            profVC.mainUSerPRofileID = mainMemberID as! NSString
            self.navigationController?.pushViewController(profVC, animated: true)
        }else{
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "globalDEtail") as! GlobalSearchDetailViewController
            profVC.OtherMemberUID =  directoryList.masterUID
        self.navigationController?.pushViewController(profVC, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
}

