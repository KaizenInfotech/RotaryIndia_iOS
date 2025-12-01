//
//  ProfileInfoController.swift
//  TouchBase
//
//  Created by Kaizan on 07/06/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MessageUI
import MapKit
class ProfileInfoController: UIViewController,UITextFieldDelegate,webServiceDelegate , UIAlertViewDelegate , MFMailComposeViewControllerDelegate  , UINavigationControllerDelegate ,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate{
    let locationManager = CLLocationManager()
    var locValue:CLLocationCoordinate2D!
    let bounds = UIScreen.main.bounds
    let searchTextField = UITextField()
 var isAdmin:NSString!
    var groupIDX : String = ""
    var moduleID:NSString!
    var phoneNumberStr : String = ""
    var mailIDStr : String = ""
    var AddressStr : String = ""
    var grpTitleStr : String = ""
    var grpImageStr : String = ""
    
    var copymainArray : NSArray!
    var adminArray : NSArray!
    var appDelegate : AppDelegate = AppDelegate()
    var userGroupID:NSString!
    var userProfileID:NSString!
    @IBOutlet var profInfoTableView: UITableView!
    var is_searching = false   // It's flag for searching
    //   var dataArray:NSMutableArray!  // Its data array for UITableview
    var searchingDataArray:NSMutableArray! // Its data searching array that need for search result show
    var mainArray : NSArray!
     var isCalled:NSString!
    var showadminProf:NSString!
    var moduleName:String! = ""
    var varNavigationTitle:String!=""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        mainArray = NSArray()
        
        let tblView =  UIView(frame: CGRect.zero)
        profInfoTableView.tableFooterView = tblView
        profInfoTableView.tableFooterView!.isHidden = true
        
        searchingDataArray = []
//        self.locationManager.requestAlwaysAuthorization()
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            wsm.getEntityInfoList(groupIDX as NSString,moduleID: moduleID)//(groupIDX)
        }
        else
        {
            self.profInfoTableView.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             SVProgressHUD.dismiss()
        }
        

      
    }
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locValue = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        locationManager.stopUpdatingLocation()
    }
    */
    func createNavigationBar()
    {
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
        buttonleft.addTarget(self, action: #selector(ProfileInfoController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(ProfileInfoController.EditGroupAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        
       
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        
        if mainMemberID == "Yes"
        {
            let buttons : NSArray = [edit]
            if(isCalled=="notify")
            {
                
            }
            else
            {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
        }
    }
    @objc func EditGroupAction()
    {
        UserDefaults.standard.set("", forKey: "eventAddress")
        let editGrp = self.storyboard!.instantiateViewController(withIdentifier: "create_group") as! CreateGroupController
        //editGrp.groupInfoClass =  grpInfoClass
        editGrp.isClassFrom = "Edit"
//        var grpInfo = GetGroupInfo()
//        grpInfo = mainArray.objectAtIndex(0) as! GetGroupInfo
//        print(grpInfo.grpId)
        editGrp.groupIDEdit = groupIDX
        editGrp.userGroupID = userGroupID as String
        editGrp.userProfileID = userProfileID as String
        
        self.navigationController?.pushViewController(editGrp, animated: true)
    }
     @objc func backClicked(){
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
        
        
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
    }
    
    func getEntityInfoDelegate(_ entityInfo : TBEntityInfoResult)
    {
        
        if (entityInfo.status == "0")
        {
            grpTitleStr = entityInfo.groupName as String!
            grpImageStr = entityInfo.groupImg as String!
            phoneNumberStr = entityInfo.contactNo as String!
            AddressStr = entityInfo.address as String!
            mailIDStr = entityInfo.email as String!
            copymainArray = entityInfo.entityInfoResult as! NSArray
            mainArray=copymainArray .mutableCopy() as! NSArray
            
            
            adminArray = entityInfo.adminInfoResult as NSArray
            
            
            profInfoTableView.reloadData()
        }
        else if (entityInfo.status == "1")
        {
            self.profInfoTableView.makeToast("Failed", duration: 2, position: CSToastPositionCenter)
   
        }
        else
        {
            
            grpTitleStr = entityInfo.groupName as String!
            grpImageStr = entityInfo.groupImg as String!
            phoneNumberStr = entityInfo.contactNo as String!
            AddressStr = entityInfo.address as String!
            mailIDStr = entityInfo.email as String!

            copymainArray = NSArray()
            mainArray=copymainArray .mutableCopy() as! NSArray
            adminArray = entityInfo.adminInfoResult as NSArray
            
            profInfoTableView.reloadData()
        }
        
    }

    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count //Currently Giving default Value
    }
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView()
//        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 260)
//        headerView.backgroundColor = UIColor.whiteColor()
//        let profImageView = UIImageView()
//        profImageView.frame = CGRectMake((self.view.frame.size.width)/2-50, 10, 100,100)
//        
//        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
//        myActivityIndicator.frame = CGRectMake((profImageView.frame.size.width)/2-15, (profImageView.frame.size.height)/2-15, 30, 30)
//       // myActivityIndicator.center = profImageView.center
//        myActivityIndicator.startAnimating()
//        myActivityIndicator.hidesWhenStopped = true;
//        profImageView.addSubview(myActivityIndicator)
//        
//        profImageView.image = UIImage(named: "imageplaceholder")
//        profImageView.layer.cornerRadius = 50;
//        profImageView.layer.masksToBounds = true
//        profImageView.clipsToBounds = true;
//        if grpImageStr != ""
//        {
//            if let checkedUrl = NSURL(string: grpImageStr) {
//                
//                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                        guard let data = data where error == nil else { return }
//                        print(response?.suggestedFilename ?? "")
//                        print("Download Finished")
//                        profImageView.image = UIImage(data: data)
//                        
//                        myActivityIndicator.stopAnimating()
//                    }
//                }
//            }
//            else
//            {
//                 myActivityIndicator.stopAnimating()
//                profImageView.image = UIImage(named: "imageplaceholder")
//            }
//        }
//        else
//        {
//             myActivityIndicator.stopAnimating()
//            profImageView.image = UIImage(named: "imageplaceholder")
//        }
//        
//        
//        profImageView.layer.cornerRadius = 50.0
//        headerView.addSubview(profImageView)
//        
//        let titleLabel = UILabel()
//        titleLabel.frame = CGRectMake(0, 120, self.view.frame.size.width, 50)
//        titleLabel.text = grpTitleStr
//        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 18)
//        titleLabel.textColor = UIColor.blackColor()
//        titleLabel.textAlignment = NSTextAlignment.Center
//        headerView.addSubview(titleLabel)
//        
//        
//        let borderImageView = UIImageView()
//        borderImageView.frame = CGRectMake(0, 175, self.view.frame.size.width, 1)
//        borderImageView.backgroundColor = UIColor.lightGrayColor()
//        borderImageView.userInteractionEnabled = true
//        headerView.addSubview(borderImageView)
//        
//        
////        searchTextField.frame = CGRectMake(35, 182, self.view.frame.size.width-70, 40)
////        searchTextField.placeholder = "search"
////        searchTextField.textColor = UIColor.blackColor()
////        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
////        searchTextField.backgroundColor = UIColor.clearColor()
////        searchTextField.userInteractionEnabled = true
////        searchTextField.borderStyle = UITextField.BorderStyle.Bezel
////        searchTextField.delegate=self
////        searchTextField.addTarget(self, action: #selector(ProfileInfoController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
////        //headerView.addSubview(searchTextField)
////        //headerView.bringSubviewToFront(searchTextField)
//        
//        return headerView
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        let height = bounds.size.height
        if(height <= 600.0)
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
        }
        else
        {
        }
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.becomeFirstResponder()
        
        let height = bounds.size.height
        if(height <= 600.0)
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -150 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
        }
        else
        {
        }
    }

    func textFieldDidChange(_ textField: UITextField) {
        
        if(textField.text!==""){
            mainArray = copymainArray .mutableCopy() as! NSArray
            if(mainArray.count == 0) {
                
             //   NoRecordLabel.hidden = false
                profInfoTableView.isHidden = true;
            }
            else {
                
             //   NoRecordLabel.hidden = true
                profInfoTableView.isHidden = false;
                
            }
            searchTextField.text="";
            let height = bounds.size.height
            if(height <= 600.0)
            {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                    {
                        
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                        
                        
                    }, completion: { finished in
                        
                })
            }
            else
            {
            }
            searchTextField.resignFirstResponder()
            profInfoTableView.reloadData()
        }else{
            mainArray=[]
            
            let predicate = NSPredicate(format: "enname contains[c] %@", searchTextField.text!)
            mainArray = copymainArray.filtered(using: predicate) as NSArray
            if (mainArray.count==0) {
                
             //   NoRecordLabel.hidden = false
                profInfoTableView.reloadData()
            }
            else{
                
             //   NoRecordLabel.hidden = true
                profInfoTableView.reloadData()
            }
        }
        
        
    }

// func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    {
//        return 190
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = profInfoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfInfoNewCell
        
        var infoList = EntityInfo()
        infoList = mainArray.object(at: indexPath.row) as! EntityInfo
        
        cell.ProfileTitleLabel.text  =  infoList.enname  //nameTitles[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       var infoList = EntityInfo()
        infoList = mainArray.object(at: indexPath.row) as! EntityInfo
        tableView.deselectRow(at: indexPath, animated: true)
        

        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "info_detail") as! EntityInfoDetailController
        secondViewController.titleStr = infoList.enname
        secondViewController.URLstr = infoList.descptn
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
 
        }
        
    @IBAction func PhoneCallAction(_ sender: AnyObject)
    {
        
        phoneNumberStr = phoneNumberStr.replacingOccurrences(of: " ", with: "")
        print("calling\(phoneNumberStr)")
//        let url = URL(string: "tel://\(phoneNumberStr)")
//        UIApplication.shared.openURL(url!)
        if let url = URL(string: "tel://\(phoneNumberStr)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        /*
        if phoneNumberStr.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",phoneNumberStr)
            alertView.delegate = self
            alertView.tag = 1
            alertView.addButtonWithTitle("No")
            alertView.addButtonWithTitle("Yes")
            alertView.show()
            
        }
        */
    }
    
    
    func alertView(_ View: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
//                let url = URL(string: "tel://\(phoneNumberStr)")
//                UIApplication.shared.openURL(url!)
                
                if let url = URL(string: "tel://\(phoneNumberStr)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
                
                break;
            case 0:
                
                
                break;
            default:
                NSLog("Default");
                break;
                
            }
        }
        else
        {
            
        }
    }
   
    @IBAction func MSGMailAction(_ sender: AnyObject)
    {
        
        if mailIDStr == ""
        {
            
        }
        else
        {
            print("Email Sent")
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([mailIDStr])      // gg@hing.co.in
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
            } else {
                // show failure alert
            }
        }
       
    }
        
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
        {
            /*
            switch result.rawValue {
            case MessageComposeResultCancelled.rawValue :
                print("message canceled")
                
            case MessageComposeResultFailed.rawValue :
                print("message failed")
                
            case MessageComposeResultSent.rawValue :0
            print("message sent")
                
            default:
                break
            }
            */
            controller.dismiss(animated: true, completion: nil)
        }
        

    
    @IBAction func ShowAddressAction(_ sender: AnyObject)
    {
        if AddressStr == ""
        {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = ""
                        alertView.message = String(format:"Address details not entered")
                        alertView.delegate = self
                        alertView.addButton(withTitle: "Ok")
                        alertView.show()
 
        }
        else
        {

            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                //AddressStr = AddressStr.addingPercentEscapes(using: String.Encoding.utf8)!
                
                AddressStr = AddressStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed )!
                
//                UIApplication.shared.openURL(URL(string:
//                    "comgooglemaps://?daddr=\(AddressStr)&directionsmode=driving")!)
                
                if UIApplication.shared.canOpenURL(URL(string:
                                                        "comgooglemaps://?daddr=\(AddressStr)&directionsmode=driving")!) {
                    UIApplication.shared.open(URL(string:
                                                    "comgooglemaps://?daddr=\(AddressStr)&directionsmode=driving")!, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }
                
            } else {
               //AddressStr = AddressStr.addingPercentEscapes(using: String.Encoding.utf8)!
                
                AddressStr = AddressStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed )!
                
//                UIApplication.shared.openURL(URL(string:
//                    "http://maps.apple.com/?daddr=\(AddressStr)&dirflg=d&t=h")!);
                
                if UIApplication.shared.canOpenURL(URL(string:
                                                        "http://maps.apple.com/?daddr=\(AddressStr)&dirflg=d&t=h")!) {
                    UIApplication.shared.open(URL(string:
                                                    "http://maps.apple.com/?daddr=\(AddressStr)&dirflg=d&t=h")!, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }
                
                NSLog("http://maps.google.com/maps?");
            }
        

        }
    }
    
    @IBAction func ShowMultipleAdmins(_ sender: AnyObject)
    {
        print("Admins")
        
        
        if adminArray.count > 0
        {
            for i in 0  ..< adminArray.count 
            {
                var adminLists = AdminInfo()
                adminLists = adminArray.object(at: i) as! AdminInfo
                
                print(adminLists.memberName)
                print(adminLists.memberMobile)
                print(adminLists.email)
                 UserDefaults.standard.set("no", forKey: "picadded")
                let profVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
                profVC.userGroupID =  groupIDX as NSString  //nameTitles[indexPath.row]
                profVC.userProfileID =  adminLists.adminId as! NSString   //mobileTitles[indexPath.row]
                profVC.isAdmin = "No"
                profVC.isCalled = "list"
                let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                profVC.mainUSerPRofileID = mainMemberID as! NSString
                profVC.showadminProf = "admin"
                self.navigationController?.pushViewController(profVC, animated: true)
            }
        }
        
        
        
        
    }
    
    
    
    
}

