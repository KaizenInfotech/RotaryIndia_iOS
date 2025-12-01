//
//  AllNotificationViewController.swift
//  TouchBase
//
//  Created by IOS on 29/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class NotificationCell:UITableViewCell
{
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClubDistType: UILabel!
    @IBOutlet weak var lblNotifyDate: UILabel!
    @IBOutlet weak var mainViewwww: UIView!
    
    @IBOutlet weak var imgMainVieww: UIView!
}
class AllNotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate, protocolForEventsListingCallingApi {
    func functionForEventsListingCallingApi(stringFromWhereITCalling: String) {
        
    }
    
//    func functionForEventsListingCallingApi(stringFromWhereITCalling: String) {
//        <#code#>
//    } 
    
    @IBOutlet weak var tblNotificaiton: UITableView!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    let nModel:NotificaioModel=NotificaioModel()
    var muarrayNotification:NSMutableArray=NSMutableArray()
    let classes:CommonRIClass=CommonRIClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        createNavigationBar()
    }
    
    func createNavigationBar()
    {
        let str : String!
        str = "Notification"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AllNotificationViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backClicked()
   {
       self.navigationController?.popViewController(animated: true)
   }
    
    @objc func checkToDeleteNotification()
    {
        self.muarrayNotification=NSMutableArray()
//        nModel.deleteNotification(byMsgID: "", state: .Defaults)
        self.muarrayNotification=nModel.getAllNotificationDetail()
        print(self.muarrayNotification)
        if muarrayNotification.count>0
        {
            lblNoRecord.isHidden=true
            tblNotificaiton.isHidden=false
            tblNotificaiton.reloadData()
        }
        else
        {
            lblNoRecord.isHidden=false
            tblNotificaiton.isHidden=true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    classes.setNavigationBar(moduleName: "Notification", uiVC: self)
    checkToDeleteNotification()
     //MARK:- Uncomment this
    NotificationCenter.default.addObserver(self, selector: #selector(checkToDeleteNotification), name: NSNotification.Name(rawValue: "NotifyList"), object: nil)
    
    }

    override func viewWillDisappear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden=false
        //MARK:- Uncomment this
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NotifyList"), object: nil)
 
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muarrayNotification.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    //183,240,254
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var entityName = ""
        var message = ""
        var type = ""
        var CelebrationType = ""
        var title = ""
        
        let cell:NotificationCell = tblNotificaiton.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationCell
        cell.selectionStyle = .none
        
//        layer.masksToBounds = false
//               layer.shadowColor = UIColor.black.cgColor
//               layer.shadowOpacity = 0.2
//               layer.shadowOffset = .zero
//               layer.shadowRadius = 1
        cell.imgMainVieww.layer.borderColor = UIColor .lightGray.cgColor
        cell.imgMainVieww.layer.borderWidth = 1.0
        cell.imgMainVieww.layer.cornerRadius = cell.imgMainVieww.frame.size.height/2
        cell.mainViewwww.clipsToBounds = true
        cell.mainViewwww.layer.masksToBounds = false
        cell.mainViewwww.layer.shadowColor = UIColor.lightGray.cgColor
        cell.mainViewwww.layer.shadowOpacity = 0.3
        cell.mainViewwww.layer.shadowOffset = .zero
        cell.mainViewwww.layer.shadowRadius = 10
//    tblNotificaiton.separatorStyle = UITableViewCellSeparatorStyle.None

        tblNotificaiton.separatorStyle = UITableViewCell.SeparatorStyle.none
        if let dict = muarrayNotification.object(at: indexPath.row) as? NSDictionary
        {
            if let detailsString = dict.object(forKey: "details") as? String {
//                if let data = detailsString.data(using: .utf8) {
//                         do {
//                             if let detailsDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//                                 // Now you can access the keys inside the "details" value
//                                 entityName = detailsDict.object(forKey: "entityName") as? String ?? ""
//                                 message = detailsDict.object(forKey: "Message") as? String ?? ""
//                                 type = detailsDict.object(forKey: "type") as? String ?? ""
//                                 CelebrationType = detailsDict.object(forKey: "CelebrationType") as? String ?? ""
//                                 
//                                 cell.lblTitle.text = message
//                                 cell.lblClubDistType.text = entityName
//                             }
//                         } catch {
//                             print("Error parsing details JSON: \(error.localizedDescription)")
//                         }
//                     }
                
                if let data = detailsString.data(using: .utf8) {
                    do {
                        // Check if the string is a valid JSON object
                        if let detailsDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            // Access keys inside the "details" value
                            entityName = detailsDict.object(forKey: "entityName") as? String ?? ""
                            message = detailsDict.object(forKey: "Message") as? String ?? ""
                            type = dict.object(forKey: "type") as? String ?? ""
                            CelebrationType = detailsDict.object(forKey: "CelebrationType") as? String ?? ""
                            title = dict.object(forKey: "title") as? String ?? ""
                            print("TITLE TEST PRINT 1: \(title)")

                            if title == "" {
                                cell.lblTitle.text = message
                            } else {
                                cell.lblTitle.text = title
                            }
                            
                            cell.lblClubDistType.text = entityName
                        } else {
                            // If the details is not a JSON object, handle it as a plain string
                            title = dict.object(forKey: "title") as? String ?? ""
                            print("TITLE TEST PRINT 2: \(title)")
                            message = detailsString
                            type = dict.object(forKey: "type") as? String ?? ""
                            cell.lblClubDistType.text = "" // Adjust this if needed
                            if title == "" {
                                cell.lblTitle.text = message
                            } else {
                                cell.lblTitle.text = title
                            }
                        }
                    } catch {
                        print("Error parsing details JSON: \(error.localizedDescription)")
                        // Fallback for plain string
                        title = dict.object(forKey: "title") as? String ?? ""
                        print("TITLE TEST PRINT 3: \(title)")
                        message = detailsString
                        type = dict.object(forKey: "type") as? String ?? ""
                        cell.lblClubDistType.text = "" // Adjust this if needed
                        if title == "" {
                            cell.lblTitle.text = message
                        } else {
                            cell.lblTitle.text = title
                        }
                    }
                }

            cell.lblNotifyDate.text = dict.object(forKey: "notifyDate") as? String
            let ReadStatus = dict.object(forKey: "ReadStatus") as? String
            if ReadStatus == "UnRead"
            {
                cell.lblTitle.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
                cell.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
            }
            else
            {
                cell.lblTitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
                cell.backgroundColor=UIColor.white
            }
            
//            let nType = dict.object(forKey: "type") as? String
                let nType = type
            switch nType {
            case "Event":
                cell.typeImageView.image = UIImage(named: "eventssss")
                break
            case "Calender":
//                if let strings = dict.object(forKey: "details") as? String
//                {
//                    let dictionary = convertStringToDictionary(text: strings)
//                    if let notifyDict = dictionary as NSDictionary?
//                    {
//                        let CelebrationType = notifyDict.object(forKey: "CelebrationType") as? String
                        if CelebrationType == "A"
                        {
                            cell.typeImageView.image = UIImage(named: "ann")
                        }
                        else if CelebrationType == "B"
                        {
                            cell.typeImageView.image = UIImage(named: "calEE")
                        }
                        else if CelebrationType == "E"
                        {
                            cell.typeImageView.image = UIImage(named: "eventssss")
                        }
//                    }
//                }
                break
            case "ann":
                cell.typeImageView.image = UIImage(named: "announcement.png")
                break
            case "Ebulletin":
                cell.typeImageView.image = UIImage(named: "newsletter")
                break
            case "Doc":
                cell.typeImageView.image = UIImage(named: "doc")
                break
            case "Activity","Gallery":
//                if let title=dict.object(forKey: "title") as? String
//                {
                    if message.contains("A new club meeting") || message.contains("A new district event")
                    {
                        cell.typeImageView.image = UIImage(named: "club_meeting")
                    }
                    else{
                        cell.typeImageView.image = UIImage(named: "service_prj")
                    }
//                }
                break
            case "PopupNoti":
//                if let strings = dict.object(forKey: "details") as? String
//                {
                
                if message.contains("Happy birthday") || message.contains("birthday")
                {
                    cell.typeImageView.image = UIImage(named: "calEE")
                }
                else if message.contains("anniversary") || message.contains("perfect couple") {
                    cell.typeImageView.image = UIImage(named: "ann")
                }
                
//                    cell.typeImageView.image = UIImage(named: "greeting")
//                }
                break
            default:
                break
            }
        }
        }
    return cell
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
       let text1=text.replacingOccurrences(of: "\\", with: "")
       if let data = text1.data(using: String.Encoding.utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               print("TEXT 1 String is valid jSon \(json)")
               return json
           } catch {
               print("Something went wrong")
           }
       }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var message = ""
        var title = ""
        var type = ""
        var CelebrationType = ""
        var BAType = ""
        var memID = ""
        var grpID = ""
        var typeID = ""
        var groupType = ""
        var ann_img = ""
        var ann_title = ""
        var Ann_date = ""
        var ann_lnk = ""
        var ann_desc = ""
        var link = ""
        var finaYear = ""
        
        
    if let dict = muarrayNotification.object(at: indexPath.row) as? NSDictionary
        {
        print("DID SELECT ROW AT------DICT---\(indexPath.row)\(dict)")
        if let detailsString = dict.object(forKey: "details") as? String {
            if let data = detailsString.data(using: .utf8) {
                     do {
                         if let detailsDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                             // Now you can access the keys inside the "details" value
                             message = detailsDict.object(forKey: "Message") as? String ?? ""
                             title = dict.object(forKey: "title") as? String ?? ""
                             type = dict.object(forKey: "type") as? String ?? ""
                             CelebrationType = detailsDict.object(forKey: "CelebrationType") as? String ?? ""
                             BAType = detailsDict.object(forKey:"BAType") as? String ?? ""
                             memID = detailsDict.object(forKey:"memID") as? String ?? ""
                             grpID = detailsDict.object(forKey:"grpID") as? String ?? ""
                             typeID = detailsDict.object(forKey:"typeID") as? String ?? ""
                             groupType = detailsDict.object(forKey:"GroupType") as? String ?? ""
                             ann_img = detailsDict.object(forKey:"ann_img") as? String ?? ""
                             ann_title = detailsDict.object(forKey:"ann_title") as? String ?? ""
                             Ann_date = detailsDict.object(forKey:"Ann_date") as? String ?? ""
                             ann_lnk = detailsDict.object(forKey:"ann_lnk") as? String ?? ""
                             ann_desc = detailsDict.object(forKey:"ann_desc") as? String ?? ""
                             link = detailsDict.object(forKey:"link") as? String ?? ""
                             finaYear = detailsDict.object(forKey:"Financial_Year") as? String ?? ""
                         }
                     } catch {
                         print("Error parsing details JSON: \(error.localizedDescription)")
                         
                         message = dict.object(forKey: "details") as? String ?? ""
                         title = dict.object(forKey: "title") as? String ?? ""
                         type = dict.object(forKey: "type") as? String ?? ""
                     }
                 }
        
        if let msgID = dict.object(forKey: "MsgID") as? String
           {
            print("Notification Identifier \(msgID)")
            nModel.changeReadStatus(ofMsgID: msgID, completion: {
                result in
                print(result)
            })
        }
            
    let nType = type
    if(nType == "PopupNoti") {
   checkToDeleteNotification()
     let varGetTypeTitle:String!=title
     let msg:String=message
     let alertView:UIAlertView = UIAlertView()
     alertView.title = varGetTypeTitle
     alertView.message = msg
     alertView.delegate = self
     alertView.addButton(withTitle: "OK")
     alertView.show()
    }
    else 
//            if let strings = dict.object(forKey: "details") as? String
    {
//    let dictionary = convertStringToDictionary(text: strings)
//    if let notifyDict = dictionary as NSDictionary?
//    {
//     if let BAType=notifyDict["BAType"] as? String
//     {
      checkToDeleteNotification()
//         if let aps = notifyDict["aps"] as? NSDictionary{
         let varGetTypeTitle:String!=title
         let msg:String=message
         let alertView:UIAlertView = UIAlertView()
         alertView.title = varGetTypeTitle
         alertView.message = msg
         alertView.delegate = self
         alertView.addButton(withTitle: "OK")
//         alertView.show()
//        }
//     }
      if(type == "Event")
     {
             
             UserDefaults.standard.setValue("nothing", forKey: "session_LinkValue")
             
//             EventsTableView.deselectRow(at: indexPath, animated: true)
             var grp:EventList!
//             self.pickerView.isHidden=true
             
//             grp=allEventsArry[indexPath.row] as! EventList
//             UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
             let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
//             secondViewController.grpDetailPrevious = notifyDict
         secondViewController.memberProfileId = memID
//         secondViewController.eventDetail = grp.eventID
             secondViewController.isCalled = "list"
             secondViewController.varIsRSVPEnableorDisable=0
//             secondViewController.SMSCountStr = SMSCountStr
             secondViewController.moduleName =  type
//             secondViewController.isCategory = isCategory
        secondViewController.isfromNotificationList = "yes"
//        if  let category:String=notifyDict["group_category"] as? String
//                      {
//            secondViewController.isCategory=category
//                      }
//                     else
//                      {
//                        secondViewController.isCategory="1"
//                      }
        
        
//             secondViewController.eventFilterCheck=self.listTypeTextField.text
//             secondViewController.grpName=grpName
          secondViewController.eventID = typeID as NSString
          secondViewController.grpId = grpID as NSString
//        if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
//                        {
//            secondViewController.grpName = body
//                        }
//                        else
//                        {
//                            secondViewController.grpName = ""
//                        }
        
        
             secondViewController.objprotocolForEventsListingCallingApi=self
             
             //print("Event Details list")
             //print("grpDetailPrevious = \( grpDetailPrevious) \n memberProfileId = \(memberProfileId) \n eventDetail = \(grp)\n isCalled = list \n varIsRSVPEnableorDisable=0 \n SMSCountStr = \(SMSCountStr) \n moduleName = \(moduleName) \n isCategory = \(isCategory) \n eventFilterCheck= \(self.listTypeTextField.text) \n  grpName= \(grpName)")
             
             self.navigationController?.pushViewController(secondViewController, animated: true)
         }
//     {
//        let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailNotiViewController") as! EventDetailNotiViewController
//        print(notifyDict)
//
//        let profID =  notifyDict["memID"] as? NSString
//                    dashBoardController.eventDate = notifyDict["eventDate"]  as! String
//                    dashBoardController.eventDesc = notifyDict["eventDesc"] as! String
//                    dashBoardController.eventImg = notifyDict["eventImg"] as! String
//                    dashBoardController.eventTitle = notifyDict["eventTitle"] as! String
//                    dashBoardController.goingCount = notifyDict["goingCount"] as! String
//                    dashBoardController.grpID = notifyDict["grpID"] as! String
//                    dashBoardController.maybeCount = notifyDict["maybeCount"] as! String
//                    dashBoardController.memID = notifyDict["memID"] as! String
//                    dashBoardController.notgoingCount = notifyDict["notgoingCount"] as! String
//                    dashBoardController.reglink = notifyDict["reglink"] as! String
//                    dashBoardController.rsvpEnable = notifyDict["rsvpEnable"] as! String
//                    dashBoardController.tyID = notifyDict["tyID"] as! String
//                    dashBoardController.type = notifyDict["type"] as! String
//                    dashBoardController.venue = notifyDict["venue"] as! String
//                    dashBoardController.questionID = notifyDict["questionID"] as! String
//                    dashBoardController.questionText = notifyDict["questionText"] as! String
//                    dashBoardController.questionType = notifyDict["questionType"] as! String
//                    dashBoardController.myResponse = notifyDict["myResponse"] as! String
//                    dashBoardController.totalCountServerResponse = notifyDict["totalCount"] as! String
//                    dashBoardController.isQuesEnable = notifyDict["isQuesEnable"] as! String
//                    dashBoardController.option1 = notifyDict["option1"] as! String
//                    dashBoardController.option2 = notifyDict["option2"] as! String
//                    if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
//                    {
//                        dashBoardController.grpName = body
//                    }
//                    else
//                    {
//                      dashBoardController.grpName = ""
//                    }
//                  if  let category:String=notifyDict["group_category"] as? String
//                  {
//                    dashBoardController.isCategory=category
//                  }
//                 else
//                  {
//                    dashBoardController.isCategory="1"
//                  }
//                    self.navigationController?.pushViewController(dashBoardController, animated: false)
//                }
                if(type as? NSString == "Calender"){
                    UserDefaults.standard.setValue(memID, forKey: "user_auth_token_profileId")
                    UserDefaults.standard.setValue(grpID, forKey: "user_auth_token_groupId")
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if #available(iOS 13.0, *) {
                        let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                        objCelebrationViewController.stringProfileId = memID
                        objCelebrationViewController.stringGroupID = grpID
                        objCelebrationViewController.isCategory=groupType
                        let varType:String!=CelebrationType
                        if(varType=="A")
                        {
                            objCelebrationViewController.varType="A"
                            objCelebrationViewController.isBirthdayorAnniv="anniv"
                        }
                        else  if(varType=="B")
                        {
                            objCelebrationViewController.varType="B"
                            objCelebrationViewController.isBirthdayorAnniv="birthday"
                        }
                        else  if(varType=="E")
                        {
                            objCelebrationViewController.varType="E"
                            objCelebrationViewController.isBirthdayorAnniv=""
                        }
                        objCelebrationViewController.moduleName="Calendar"
                        self.navigationController?.pushViewController(objCelebrationViewController, animated: false)
                    } else {
                        // Fallback on earlier versions
                    }
                  
                }
                
                if(type as? NSString == "ann"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "AnnouncementDetailNotiViewController") as! AnnouncementDetailNotiViewController

                    dashBoardController.ann_img =  ann_img
                    dashBoardController.ann_title =  ann_title
                    dashBoardController.Ann_date =  Ann_date
                    dashBoardController.ann_lnk =  ann_lnk
                    dashBoardController.ann_desc =  ann_desc
//                    if let body=((notifyDict["aps"] as! NSDictionary).value(forKey: "alert") as AnyObject).value(forKey: "body") as? String
//                    {
//                        dashBoardController.grpName = body
//                    }
//                    else
//                    {
//                      dashBoardController.grpName = ""
//                    }
            
//                    if  let category:String=notifyDict["group_category"] as? String
//                {
//                    dashBoardController.isCategory=category
//                }
//                else
//                {
//                    dashBoardController.isCategory="1"
//                }
                    self.navigationController?.pushViewController(dashBoardController, animated: false)
                }
                if(type == "Ebulletin"){
                    var stringUrl:String=""
//                    stringUrl = notifyDict["link"] as! String
//                    if let link = links
//                    {
                        stringUrl = link
                        if(link.contains(".pdf") || link.contains(".docx") || link.contains(".doc") || link.contains(".html") || link.contains(".gif") || link.contains(".jpg") || link.contains(".jpeg") || link.contains(".png"))
                        {
                            let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
                            dashBoardController.urlLink = link
                            dashBoardController.isCalled = "notify"
                            dashBoardController.profileID = memID as NSString
                            dashBoardController.bulletinID = typeID as NSString
                            self.navigationController?.pushViewController(dashBoardController, animated: false)
                        }
                        else
                    {
                            //                            guard let url = URL(string: "https://stackoverflow.com") else { return } UIApplication.shared.open(url)
                            
                            //                            else{
                            ////                                self.view makeToast("")
                            //                                self.view .makeToast("Please enter url ")
                            //                            }
                            ////                            if let url = NSURL(string: "https://stackoverflow.com"){
                            ////                                UIApplication.shared.openURL(url as URL)
                            ////                            }
                            //                            {
                            if(stringUrl.contains("http"))
                            {
                            }
                            else
                            {
                                stringUrl = "http://"+stringUrl
                            }
                            if let urls = NSURL(string:stringUrl){
//                                UIApplication.shared.openURL(urls as URL)
                                
                                if UIApplication.shared.canOpenURL(urls as URL) {
                                    UIApplication.shared.open(urls as URL, options: [:]) { success in
                                            if success {
                                                print("The URL was successfully opened.")
                                            } else {
                                                print("Failed to open the URL.")
                                            }
                                        }
                                    }
                                
                            }
                            //                            }
                            
                            
                            
                            
                            
                            
                        }
                        }
//                    }
                 }
                if(type == "Doc"){
                    if grpID as! String == "-1"
                    {
                        //Call RI Document here
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIDocumentListVC") as! RIDocumentListVC
                        self.navigationController?.pushViewController(secondViewController, animated: false)
                    }
                    else{
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "docmVC") as! DocumentListViewControlller
                    dashBoardController.groupIDX = grpID
                        dashBoardController.grpPRofileID = memID as NSString
                    dashBoardController.isCalled = "notify"
                    dashBoardController.moduleName="Documents"
                    self.navigationController?.pushViewController(dashBoardController, animated: false)
                 }
                }
                if(type  == "AddMember"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
                    UserDefaults.standard.set("no", forKey: "picadded")
                    dashBoardController.userGroupID =  grpID as NSString
                    dashBoardController.userProfileID =  typeID as NSString //mobileTitles[indexPath.row]
                    dashBoardController.isAdmin = "No"
                    dashBoardController.mainUSerPRofileID = memID as NSString
                    dashBoardController.isCalled = "notify"
                    self.navigationController?.pushViewController(dashBoardController, animated: false)
                }
                if(type  == "EditGroup"){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "profNewInfo_view") as! ProfileInfoController
                    
                    dashBoardController.groupIDX =  grpID
                    dashBoardController.userGroupID =  grpID as NSString
                    dashBoardController.userProfileID =  memID as NSString //mobileTitles[indexPath.row]
                    dashBoardController.isCalled = "notify"
                    self.navigationController?.pushViewController(dashBoardController, animated: false)
                }
                if(type == "club")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let dashBoardController = self.storyboard?.instantiateViewController(withIdentifier: "ClubEventDetailsShowViewController") as! ClubEventDetailsShowViewController
                    dashBoardController.grpId = grpID
                    dashBoardController.profileId = memID
                    dashBoardController.isCalled = "notify"
                    self.navigationController?.pushViewController(dashBoardController, animated: false)
                }
                if(type as? NSString == "Activity")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificaton") as! NewShowCasePhotoDetailsVCGooglePushNotificaton
                    objShowCaseAlbumListViewController.GetAlbumID = typeID
                    objShowCaseAlbumListViewController.GetGroupID=grpID
                    objShowCaseAlbumListViewController.getFinanceYear = finaYear
                    print("FINANCE YEAR-----\(objShowCaseAlbumListViewController.getFinanceYear)")
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: false)
                }
                if(type == "Gallery")  // 11-09-2017
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let objShowCaseAlbumListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict") as! NewShowCasePhotoDetailsVCGooglePushNotificatonDistrict
                    objShowCaseAlbumListViewController.GetAlbumID = typeID
                    objShowCaseAlbumListViewController.GetGroupID=grpID
                    objShowCaseAlbumListViewController.getFinanceYear = finaYear
                    self.navigationController?.pushViewController(objShowCaseAlbumListViewController, animated: false)
                }
//            }
          }
        }
    }
    
}
