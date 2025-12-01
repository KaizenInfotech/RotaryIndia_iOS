//
//  AnnouncementDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class AnnouncementDetailController: UIViewController , UITableViewDataSource , UITableViewDelegate ,webServiceDelegate,annImgDelegate,protocolForAnnouncementListingCallingApi{
    @IBOutlet weak var tableAnnouncementShare: UITableView!
    
    var objprotocolForAnnouncementListingCallingApi:protocolForAnnouncementListingCallingApi!=nil
    
    
    @IBAction func buttonAnnouncementDetailNotiClickEvent(_ sender: Any) {
        
        // print(varWebSite)
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "AnnouncementDetailNotiViewController") as! AnnouncementDetailNotiViewController
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
    }

    func functionForAnnouncementListingCallingApi(stringFromWhereITCalling: String) {
        print("this is coming from screen")
        print(stringFromWhereITCalling)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        wsm.getAnnouceDetail(annDetail.announID as! NSString, grpID:grpID , memberProfileID:profileId )
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("Back to View will appear")
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        if(isCalled == "notify")
        {
            wsm.getAnnouceDetail(annID, grpID:grpID , memberProfileID:profileId )
        }
        else if(isCalled == "notify1")
        {
            wsm.getAnnouceDetail(annID, grpID:grpID , memberProfileID:profileId )
        }
        else
        {
            //wsm.getAnnouceDetail(annDetail.announID as! NSString, grpID:grpID , memberProfileID:profileId )
        }
       
        tableAnnouncementShare.frame=CGRect(x: AnnounceDetailTableView.frame.origin.x, y: AnnounceDetailTableView.frame.origin.y, width: AnnounceDetailTableView.frame.width, height: AnnounceDetailTableView.frame.height)
        
        tableAnnouncementShare.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)

    }
    
    
    
    
    let bounds = UIScreen.main.bounds
    var annDetail:AnnounceList!
    var appDelegate : AppDelegate!
    
    var SMSCountStr : String!
    var moduleName:String! = ""
    var FileNameToDelete:String=""
    var ExpiredStr = String()
   // var currentDate:NSDate!
    
    @IBOutlet var AnnounceDetailTableView: UITableView!
    var grpID:NSString!
    var profileId:NSString!
    var isCalled:NSString!
    var annID:NSString!
    var moduleId:NSString!
    var alertController = UIAlertController()
    var ticksnew:String!=""
    var isCategory:String! = ""
    var grpName:String! = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.AnnounceDetailTableView.isHidden=true
        self.view.backgroundColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: false)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        print("**annDetail list \(annDetail)")
       wsm.getAnnouceDetail(annDetail.announID as! NSString, grpID:grpID , memberProfileID:profileId )
       // alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
       // self.present(alertController, animated: true, completion: nil)
    }
   
    override func viewDidAppear(_ animated: Bool) {
       
        
    }
    func getallAnnounOFUSerSuccss(string:TBAnnounceListResult){
   
     
        if(string.status == "0"){
        annDetail=string.announListResult[0] as! AnnounceList
        
        AnnounceDetailTableView.estimatedRowHeight = 55
            tableAnnouncementShare.estimatedRowHeight = 55
        AnnounceDetailTableView.rowHeight = UITableView.automaticDimension
        tableAnnouncementShare.rowHeight = UITableView.automaticDimension
        AnnounceDetailTableView.tableFooterView = UIView(frame: CGRect.zero)
            
        AnnounceDetailTableView.reloadData()
        tableAnnouncementShare.reloadData()
        tableAnnouncementShare.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
        assignHeadFootToTableView()
            if (annDetail != nil && annDetail.announTitle != nil)
            {
                FileNameToDelete=annDetail.announTitle
                 print("Is FileNAmeTo Delete is available \(FileNameToDelete)")
                removePDFFiles()
            }
            if annDetail.filterType == "3"
            {
                ExpiredStr = "Yes"
            }
            else
            {
                ExpiredStr = "No"
            }
            self.createNavigationBar()
            
            // self.AnnounceDetailTableView.isHidden=false //------if
            //   -----------Else
            alertController.dismiss(animated: true, completion: nil)
        }
        else
        {
             self.AnnounceDetailTableView.isHidden=true 
             alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func createNavigationBar(){
        self.title=moduleName

        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white

        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
    
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AnnouncementDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton

        let trashB = UIButton(type: UIButton.ButtonType.custom)
        trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
        trashB.addTarget(self, action: #selector(AnnouncementDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)

        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(AnnouncementDetailController.editEbullAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)

        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        var buttons : NSArray = NSArray()//[shareButtonAdd,trash]
        
        if mainMemberID == "Yes"
        {
            if ExpiredStr.count>0
            {
                if ExpiredStr == "Yes"
                {
                    buttons=[shareButtonAdd,trash]
                }
                else if ExpiredStr == "No"
                {
                    if(isCalled=="notify")
                    {
                    }
                    else
                    {
                        buttons=[shareButtonAdd,trash, edit]
                    }
                }
            }
            else
            {
                if(isCalled=="notify")
                {
                }
                else
                {
                    buttons=[shareButtonAdd,trash]
                }
            }
        }
        else
        {
            buttons=[shareButtonAdd]
        }
        if buttons.count>0
        {
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
    }
 
   /*
    func createNavigationBar(){
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)

        
        if(ExpiredStr.characters.count > 0)
        {
            self.title=moduleName
            let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
            self.navigationController!.navigationBar.titleTextAttributes = attributes
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
             let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(AnnouncementDetailController.backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            let trashB = UIButton(type: UIButton.ButtonType.custom)
            trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
            trashB.addTarget(self, action: #selector(AnnouncementDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
            let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            let buttons : NSArray = [shareButtonAdd,trash]
            if mainMemberID == "Yes"
            {
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
        }
        else
        {
            self.title=moduleName
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
             let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(AnnouncementDetailController.backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            
            let editB = UIButton(type: UIButton.ButtonType.custom)
            editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
            editB.addTarget(self, action: #selector(AnnouncementDetailController.editEbullAction), for: UIControl.Event.touchUpInside)
            let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
            
            let trashB = UIButton(type: UIButton.ButtonType.custom)
            trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
            trashB.addTarget(self, action: #selector(AnnouncementDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
            let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            if mainMemberID == "Yes"
            {
                let buttons : NSArray = [shareButtonAdd,trash, edit]
                if(isCalled=="notify")
                {
                    
                }
                else
                {
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                }
            }
        }
        
        
    }
    */
     @objc func backClicked()
    {
        if(isCalled == "notify"){
           // appDelegate.setRootView()
            self.navigationController?.popViewController(animated: true) //DPK
            //self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else {
            
            self.navigationController?.popViewController(animated: true)
        }
        
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }

    }
    
    @objc func editEbullAction()
    {
        let addAnnounce = self.storyboard?.instantiateViewController(withIdentifier: "add_announce") as! AddAnnounceController
        addAnnounce.isCalledFRom="list"
        addAnnounce.groupID = grpID as String
        addAnnounce.TypeIDEdit = annDetail.announID as String
        addAnnounce.groupProfileID = profileId as String
        addAnnounce.annDetail=annDetail
         addAnnounce.moduleId=moduleId
        addAnnounce.SMSCountStr = SMSCountStr
        addAnnounce.commonIDString=annDetail.profileIds
        addAnnounce.objprotocolForAnnouncementListingCallingApi=self
        addAnnounce.isCategory=self.isCategory
        
         //addAnnounce.varIsType=annDetail.type
        //code by rajendra  jat need to check condition if going for edit condition 
        
        self.navigationController?.pushViewController(addAnnounce, animated: true)
    }
    @objc func deleteEbullAction()
    {
        let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(self.annDetail.announID, type: "Announcement", profileID: self.profileId as String)

        }));
        self.present(alert, animated: true, completion: nil);
        
        
    }
    func deleteSucc(_ docListing : DeleteResult)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "functionForDeleteEventThenRefreshMainDashBoardSliderDetails"), object: nil)
        
        if docListing.status == "0"
        {
            if(isCalled == "notify"){
                // appDelegate.setRootView()
                self.navigationController?.dismiss(animated: true, completion: nil)
                
            }else if(isCalled == "notify1"){
                //appDelegate.setRootView()
                self.navigationController?.dismiss(animated: true, completion: nil)
                
            }
            else {
                
                 self.objprotocolForAnnouncementListingCallingApi.functionForAnnouncementListingCallingApi(stringFromWhereITCalling: "coming from add announcement screen !!!!!1")
                let alert = UIAlertController(title: "Announcements", message: "Announcement deleted Successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
                
                
            }
        }
        else
        {
           /* let alert = UIAlertController(title: "ROW", message: "Delete failed, Please try again!", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)*/
            
            self.view.makeToast("Delete failed, Please try again!", duration: 2, position: CSToastPositionCenter)

            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    @objc func buttonLinkClickEvent(_ sender:UIButton)
    {
        
        
        print(sender.titleLabel?.text)
        if(sender.titleLabel?.text == nil)
        {
            
        }
        else
        {
            print("clicxked !!!!")
            var getValue = sender.titleLabel?.text
            print(getValue)
            //EventAnnouncementwebViewViewController
            if(getValue?.contains("<null>"))!
            {
                print("if")
            }
            else
            {
                /*
                print("else")
                let objEventAnnouncementwebViewViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventAnnouncementwebViewViewController") as! EventAnnouncementwebViewViewController
                objEventAnnouncementwebViewViewController.webUrl=webUrl
                self.navigationController?.pushViewController(objEventAnnouncementwebViewViewController, animated: true)
                */
                
                var stringUrl:String!=""
                stringUrl=webUrl
                //--
                if(stringUrl.contains("http"))
                {
                    
                }
                else
                {
                    stringUrl="http://"+stringUrl
                }
                let url = URL (string: (stringUrl));
                print(url)
                
                let requestObj = URLRequest(url: url!);
                print("http://-----------------------")
                
                if let url = NSURL(string: stringUrl){
                    UIApplication.shared.openURL(url as URL)
                }
                
                
            }
        }
        
    }
      var webUrl:String!=""
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == AnnounceDetailTableView
        {
        if(indexPath.section == 0)
        {
            alertController.dismiss(animated: true, completion: nil)
            let cell = AnnounceDetailTableView.dequeueReusableCell(withIdentifier: "ancDetailCell", for: indexPath) as! AnnounceDetailCell

          if(annDetail != nil)
          {
            cell.indicator.stopAnimating()

            cell.buttonLink.setTitle(annDetail.link,  for: UIControl.State.normal)
            cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
            print(annDetail)
           // print(annDetail.announTitle)

           // var annDetailTitle = annDetail.announTitle
            
           // print(annDetailTitle)

            
            if(annDetail != nil )
            {
            cell.announceNameLabel.text = annDetail.announTitle
            
            var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValueAnnouncement") as! String
                if(getValue=="nothing")
                {
                    webUrl="nothing"
                    cell.labelLink.isHidden=true
                }
                else
                {
                    cell.buttonLink.setTitle(getValue,  for: UIControl.State.normal)
                    webUrl=getValue
                    cell.labelLink.isHidden=false
                }
                
                
                cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                
                
                
                
                
            cell.announceDateTimeLabel.text=annDetail.publishDateTime
            cell.delegates=self
            cell.imgUrl=annDetail.announImg as! NSString
            cell.indicator.stopAnimating()
            if(annDetail.announImg == ""){
                
                cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
                cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
                cell.imgClkBtn.isHidden=true
                cell.imgClkBtn.isUserInteractionEnabled=false
                cell.indicator.stopAnimating()
                
            }else{
                cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
                cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 170)
                cell.imgClkBtn.isHidden=false
                cell.imgClkBtn.isUserInteractionEnabled=true
                if let checkedUrl = URL(string: annDetail.announImg) {
                    
                    
                    if let data = try? Data(contentsOf: checkedUrl)
                    {
                        cell.announceImage.image = UIImage(data: data)
                    }
                }else{
                     cell.indicator.stopAnimating()
                }
            }
            
            }
            }
            return cell
           
        }
        else
        {
           
            let cell = AnnounceDetailTableView.dequeueReusableCell(withIdentifier: "ancDescriptCell", for: indexPath) as! AnnounceDescriptionCell
            if(annDetail != nil )
            {
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 30.0
            paragraphStyle.maximumLineHeight = 30.0
            paragraphStyle.minimumLineHeight = 30.0
                let ats = [NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 16.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

                cell.textDescriptionForAnnounceDetails.attributedText = NSAttributedString(string: annDetail.announceDEsc as! String, attributes: ats)
            // cell.announceDescriptionLabel.text = annDetail.announceDEsc
            //cell.textDescriptionForAnnounceDetails.textAlignment = .justified

            cell.textDescriptionForAnnounceDetails.text = annDetail.announceDEsc
            }
            return cell
        }
    }
    else if tableView == tableAnnouncementShare
    {
    if(indexPath.section == 0)
    {
    alertController.dismiss(animated: true, completion: nil)
    let cell = tableAnnouncementShare.dequeueReusableCell(withIdentifier: "ancDetailCellShare", for: indexPath) as! AnnounceDetailCell
    
    if(annDetail != nil)
    {
    cell.indicator.stopAnimating()
    
    cell.buttonLink.setTitle(annDetail.link,  for: UIControl.State.normal)
    cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
    print(annDetail)
    // print(annDetail.announTitle)
    
    // var annDetailTitle = annDetail.announTitle
    
    // print(annDetailTitle)
    
    
    if(annDetail != nil )
    {
    cell.announceNameLabel.text = annDetail.announTitle
    
    
    
    
    
    var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValueAnnouncement") as! String
    if(getValue=="nothing")
    {
    webUrl="nothing"
    cell.labelLink.isHidden=true
    }
    else
    {
    cell.buttonLink.setTitle(getValue,  for: UIControl.State.normal)
    webUrl=getValue
    cell.labelLink.isHidden=false
    }
    
    
    cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
    
    
    
    
    
    cell.announceDateTimeLabel.text=annDetail.publishDateTime
    cell.delegates=self
    cell.imgUrl=annDetail.announImg as! NSString
    cell.indicator.stopAnimating()
    if(annDetail.announImg == ""){
    
    cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
    cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
    cell.imgClkBtn.isHidden=true
    cell.imgClkBtn.isUserInteractionEnabled=false
    cell.indicator.stopAnimating()
    
    }else{
    cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
    cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 170)
    cell.imgClkBtn.isHidden=false
    cell.imgClkBtn.isUserInteractionEnabled=true
    if let checkedUrl = URL(string: annDetail.announImg) {
    
    
    if let data = try? Data(contentsOf: checkedUrl)
    {
    cell.announceImage.image = UIImage(data: data)
    }
    }else{
    cell.indicator.stopAnimating()
    }
    }
    
    }
    }
    return cell
    
    }
    else
    {
    
    let cell = tableAnnouncementShare.dequeueReusableCell(withIdentifier: "ancDescriptCellShare", for: indexPath) as! AnnounceDescriptionCell
    if(annDetail != nil )
    {
    let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 30.0
    paragraphStyle.maximumLineHeight = 30.0
    paragraphStyle.minimumLineHeight = 30.0
        let ats = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 16.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
    cell.textDescriptionForAnnounceDetails.attributedText = NSAttributedString(string: annDetail.announceDEsc as! String, attributes: ats)
    // cell.announceDescriptionLabel.text = annDetail.announceDEsc
    cell.textDescriptionForAnnounceDetails.textAlignment = .justified
    
    cell.textDescriptionForAnnounceDetails.text = annDetail.announceDEsc
    }
        cell.footerImageView.image=UIImage(named: "common_footer.jpg")
    return cell
    
     }
    }
        return UITableViewCell()
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        //Choose your custom row height
//        
//        
//        if(indexPath.section == 1)
//        {
//            
//        
//        var varGetCountVar:String!=annDetail.announceDEsc
//        
//        
//        //var varGetCountVar:String!=" hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf  hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf"
//        
//        
//        var varGetCount:Int!=varGetCountVar.characters.count
//        
//        //ahg g hg Hagaga DAhdg D Ghadg hDG alDD
//        
//        
//        var varGetValue:String!=annDetail.announceDEsc
//        print(varGetValue)
//        
//        print(varGetCount)
//        if(varGetValue != "")
//        {
//            
//            if(varGetCount<=40)
//            {
//                return 50.0;
//            }
//                
//            else
//            {
//                let screenSize: CGRect = UIScreen.mainScreen().bounds
//                let screenWidth = (screenSize.width)
//                
//                
//                
//                var varGetCountCalcu:Int!=0
//                varGetCountCalcu=varGetCount%40
//                print(varGetCountCalcu)
//                var varGetCountCalcuNew:Int!=0
//                varGetCountCalcuNew=varGetCount/40
//                print(varGetCountCalcuNew)
//                if(varGetCountCalcu==0)
//                {
//                    return CGFloat(varGetCountCalcuNew*40);
//                }
//                else
//                {
//                    if(screenWidth==320)
//                    {
//                        return CGFloat((varGetCountCalcuNew*40)+100);
//                    }
//                    else
//                    {
//                        return CGFloat(((varGetCountCalcuNew*40)+40)-300);
//                    }
//                }
//            }
//        }
//        }
//         return 300.0;
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        AnnounceDetailTableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    func EventImgBtnClk(_ imgUrl:NSString){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "fullImg") as! ImageFullViewController
        secondViewController.urlLink=imgUrl
        //secondViewController.eventDetail = grp
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //MARK:- Extra PDF methods by harshada
    
    func removePDFFiles()
    {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                
                let filName:String=fileURL.lastPathComponent
                let extensionL:String=fileURL.pathExtension
                if extensionL == "pdf" && filName.contains(FileNameToDelete) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
    }
    
    
    @objc func shareButtonClickEvent()
    {
       if let systemVersion = (UIDevice.current.systemVersion
        as? NSString)?.integerValue
       {
        //self.tableAnnouncementShare.reloadData()
        self.tableAnnouncementShare.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
        //self.tableAnnouncementShare.setContentOffset(.zero, animated: true)
        if systemVersion < 13
        {
            sharePDFTo(url:createPDFDataFromTableView(tableView: tableAnnouncementShare))
        }
        else
        {
            sharePDFTo(url: createPDFDataFromImage(image: tableAnnouncementShare.asFullImage()!))
        }
        }
    }
    
    // share image
    func shareImageButton(image:UIImage) {
        // image to share
        //let image = UIImage(named: "Image")
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    
    
    func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(tableView: AnnounceDetailTableView)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                self.tableAnnouncementShare.scrollToBottom()
                print("XXXX cancel clicked XXXX ")
                return
            }
            
               self.tableAnnouncementShare.scrollToBottom()
               print("other  clicked ")
        }
       
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func assignHeadFootToTableView()
    {
        var headerImage:UIImage=UIImage()
        var footerImage:UIImage=UIImage()
        if(isCategory=="1")
        {
            headerImage=UIImage(named:"ClubHeader")!
            //            footerImage=UIImage(named: "ClubFooter")!
        }
        else if(isCategory=="2")
        {
            headerImage=UIImage(named:"DistHeader")!
            //            footerImage=UIImage(named: "DistFooter")!
        }
        footerImage=UIImage(named: "common_footer.jpg")!
        
        let topView:UIView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: tableAnnouncementShare.contentSize.width, height: 95.0)
        topView.backgroundColor = UIColor.clear
        let headerImgView:UIImageView=UIImageView()
        headerImgView.frame = CGRect(x: 0, y: 0, width: tableAnnouncementShare.contentSize.width, height: 95.0)
        headerImgView.image=headerImage
        topView.addSubview(headerImgView)
        
        let headerLabel:UILabel=UILabel()
        headerLabel.frame=CGRect(x: 0, y: 60, width: tableAnnouncementShare.contentSize.width, height: 35.0)
        headerLabel.backgroundColor=UIColor.clear
        headerLabel.text=grpName
        headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
        headerLabel.textColor=UIColor.white
        headerLabel.textAlignment=NSTextAlignment.center
        topView.addSubview(headerLabel)
        topView.bringSubviewToFront( headerLabel)
        
        tableAnnouncementShare.tableHeaderView = topView
        
        
        
        
        let bottomView:UIView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: tableAnnouncementShare.contentSize.width, height: 45.0)
        bottomView.backgroundColor = UIColor.clear
        
        let footerImgView:UIImageView=UIImageView()
        footerImgView.frame = CGRect(x: 0, y: 0, width: tableAnnouncementShare.contentSize.width, height: 45.0)
        footerImgView.image=footerImage
        bottomView.addSubview(footerImgView)
        //tableAnnouncementShare.tableFooterView = bottomView
        
    }

    func createPDFDataFromTableView(tableView: UITableView) -> NSURL {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)

        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width,height:tableView.contentSize.height) //height:self.view.frame.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
         UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
         UIGraphicsGetCurrentContext()!.saveGState()
         UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
         tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
         UIGraphicsGetCurrentContext()!.restoreGState()
         pageOriginY += pdfPageBounds.size.height
         print(pageOriginY)
        }

        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds

        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        self.ticksnew = getCurrentDate()
        if annDetail.announTitle != nil
        {
            FileNameToDelete=annDetail.announTitle
        }
        let fileName:String!="\(FileNameToDelete).pdf"
        let path = dir?.appendingPathComponent(fileName!)
        
        do {
            try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            print("error catched")
        }
        return path! as NSURL
    }
    
    // for device version above 13
    func createPDFDataFromImage(image: UIImage) -> NSURL {
        let pdfData = NSMutableData()
        let imgView = UIImageView.init(image: image)
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imgView.layer.render(in: context!)
        UIGraphicsEndPDFContext()

        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        self.ticksnew = getCurrentDate()
        if annDetail.announTitle != nil
        {
            FileNameToDelete=annDetail.announTitle
        }
        let fileName:String!="\(FileNameToDelete).pdf"
        let path = dir?.appendingPathComponent(fileName!)
        
        do {
            try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            print("error catched")
        }
        return path! as NSURL

    }
}
//MARK:- TableView Extension
extension UITableView {
    

    func asFullImage() -> UIImage? {
        guard self.numberOfSections > 0, self.numberOfRows(inSection: 0) > 0 else {
            return nil
        }

        

        var height: CGFloat = 0.0
        for section in 0..<self.numberOfSections {
            var cellHeight: CGFloat = 0.0
            for row in 0..<self.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = self.cellForRow(at: indexPath) else { continue }
                cellHeight = cell.frame.size.height
            }
            height += cellHeight * CGFloat(self.numberOfRows(inSection: section))
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.contentSize.width, height: height+500), false, UIScreen.main.scale)
        //render header
        self.tableHeaderView?.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        for section in 0..<self.numberOfSections {
            for row in 0..<self.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = self.cellForRow(at: indexPath) else { continue }
                cell.contentView.drawHierarchy(in: cell.frame, afterScreenUpdates: true)
                if row < self.numberOfRows(inSection: section) - 1 {
                    self.scrollToRow(at: IndexPath(row: row+1, section: section), at: .bottom, animated: true)
                }
            }
        }
        
        //render footer
        //self.tableFooterView?.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func scrollToBottom()
    {
        let section = self.numberOfSections-1
        let indexPath = NSIndexPath(item: 0, section: section)
        self.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
    }
    
}


