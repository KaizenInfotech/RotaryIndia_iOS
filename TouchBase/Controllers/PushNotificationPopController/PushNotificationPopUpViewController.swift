//
//  PushNotificationPopUpViewController.swift
//  TouchBase
//
//  Created by rajendra on 17/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MessageUI
import SVProgressHUD

//struct Section3 {
//    
//    var TitleOFBdayOrAnni: String!
//    var des: [String]!
//    var MemberName: [String]!
//    
//    init(TitleOFBdayOrAnni: String,des: [String], MemberName: [String])
//    {
//        
//        self.TitleOFBdayOrAnni = TitleOFBdayOrAnni
//        self.des = des
//        self.MemberName = MemberName
//        }
//    
//}

class PushNotificationPopUpViewController: UIViewController,MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate {

    
    
    var eventID:NSString!
    var profileId:NSString!
    var grpId:NSString!
    var isCalled:NSString!
    var PhoneNumberSTR  : String = ""
    
    var varMatchAnniversary:String!=""
    
    @IBOutlet weak var tableBirthdayAnniversaryList: UITableView!
    var muarrayBirthdayAndAnniversary:NSMutableArray=NSMutableArray()
    var muarraykeys:NSMutableArray=NSMutableArray()
    var muarrayMobileNumber:NSMutableArray=NSMutableArray()
    var muarrayProfileIDs:NSMutableArray=NSMutableArray()
    var muarrayGroupIDs:NSMutableArray=NSMutableArray()
    var muarrayRelation:NSMutableArray=NSMutableArray()
    
    var muarrayForBdayCount:NSMutableArray=NSMutableArray()
    var muarrayForAnniversaryCount:NSMutableArray=NSMutableArray()
    var BdayCount:String!=""
    var AnniCount:String!=""
    
    
    
    var muarrayBirthdayAndAnniversary2:NSMutableArray=NSMutableArray()
    var muarraykeys2:NSMutableArray=NSMutableArray()
    @IBOutlet weak var lableNoResult: UILabel!
    
    
//    var sections = [Section3]()
//    var stringTitleBirthday=[String]()
//    var stringGroupMemberName=[String]()
//    var stringTitleAnniversary=[String]()
//    var stringGroupAnniversaryMemberName=[String]()
//    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        varMatchAnniversary = "0"
        lableNoResult.isHidden=true
        
        //grpId = NSUserDefaults.standardUserDefaults().valueForKey("GrpID") as! String
        getBoardOfDirectorList(grpId)
        //muarraykeys=["Birthday" ,""]
        //muarrayBirthdayAndAnniversary = ["Deepak Patidar" , "Rajendra jat"]
        
//
//        tableBirthdayAnniversaryList.reloadData()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "B'days & Anniversary"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(PushNotificationPopUpViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
  self.navigationController?.popViewController(animated: true)
      //  dashBoardController.isCalled = "notify"
        
        
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
    }
    
    
    
    //Celebrations/GetTodaysBirthday
    //{ "groupID": "1" }
    
    //MARK:- Server Calling
    func getBoardOfDirectorList(_ groupId:NSString)
    {
        let completeURL:String! = baseUrl+row_GetBirthDayAnniversaryNotification
        let parameterst = ["groupID" : grpId]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //print(response)
           // print(response)
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBMemberListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((response.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "groupID")! as AnyObject).count
                {
                    print((((response.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "groupID")! as AnyObject).object(at: i))
                    
                    
                    let vargroupID=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "groupID")! as AnyObject).object(at: i)) as! String
                    let varMemberName=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberName")! as AnyObject).object(at: i)) as! String
                    let varMessageBDayOrAnni=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "msg")! as AnyObject).object(at: i)) as! String
                    let varMobileNumber=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "memberMobile")! as AnyObject).object(at: i)) as! String
                    let varProfileId=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "profileId")! as AnyObject).object(at: i)) as! String
                    var varRelation=((((dd.value(forKey: "TBMemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "relation")! as AnyObject).object(at: i)) as! String     //Need to uncomment this line

                    
                    if(varMessageBDayOrAnni=="BirthDay")
                    {
                        self.muarrayForBdayCount.add(varMessageBDayOrAnni)
                        self.BdayCount = String(self.muarrayForBdayCount.count)
                        //self.stringTitleBirthday.append(varMessageBDayOrAnni)
                        //self.stringGroupMemberName.append(varMemberName)
                    }
                    if(varMessageBDayOrAnni=="Anniversary")
                    {
                        self.muarrayForAnniversaryCount.add(varMessageBDayOrAnni)
                        self.AnniCount = String(self.muarrayForAnniversaryCount.count)
                        //self.stringTitleAnniversary.append(varMessageBDayOrAnni)
                        //self.stringGroupAnniversaryMemberName.append(varMemberName)
                    }
                    
                    
                   
                    print("BirthDayBirthDayBirthDayBirthDayBirthDay",self.muarrayForBdayCount.count)
                    print("AnniversaryAnniversaryAnniversaryAnniversary",self.muarrayForAnniversaryCount.count)
                     self.muarraykeys.add(varMessageBDayOrAnni)
                     self.muarrayBirthdayAndAnniversary.add(varMemberName)
                     self.muarrayProfileIDs.add(varProfileId)
                     self.muarrayGroupIDs.add(vargroupID)
                       //Need to uncomment this line
                    if(varRelation=="")
                    {
                      self.muarrayRelation.add("")
                    }
                    else
                    {
                      self.muarrayRelation.add(varRelation)
                    }
                    
                    
                    if(varMobileNumber.characters.count>2)
                    {
                     self.muarrayMobileNumber.add(varMobileNumber)
                    }
                    else
                    {
                     self.muarrayMobileNumber.add("")
                    }
                    
                 }
                if(self.muarrayBirthdayAndAnniversary.count<=0)
                {
                    self.lableNoResult.isHidden=false
                    //self.view.makeToast("No Result", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    self.lableNoResult.isHidden=true
                }
              //  self.sections = [Section3(TitleOFBdayOrAnni: "Birthday",des: self.stringTitleBirthday, MemberName: self.stringGroupMemberName) ,Section3(TitleOFBdayOrAnni: "Anniversary",des: self.stringTitleAnniversary, MemberName: self.stringGroupAnniversaryMemberName)]
                self.tableBirthdayAnniversaryList.reloadData()
             
            }
        SVProgressHUD.dismiss()
            }
        
        })
    }
    
    
    //MARK:- TABLE MATHED
     func numberOfSections(in tableView: UITableView) -> Int
        
    {
        
        return 1;
        
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        
//    
//            return 100.0;
//     
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if(sections.count == 0)
//        {
//            return sections[section].MemberName.count
//        }
//        if(sections.count == 1)
//        {
//            return sections[section].MemberName.count
//        }
//        else
//        {
//            return 0
//        }
        return muarrayBirthdayAndAnniversary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : NotificationPopUpTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NotificationPopUpTableViewCell") as! NotificationPopUpTableViewCell
   
        
        cell.buttonCall.isHidden=true
        cell.buttonMessage.isHidden=true
//
//        if indexPath.section == 0
//        {
//            if sections[1].MemberName.count>0
//            {
//                cell.labelValue.text! = sections[indexPath.section].MemberName[indexPath.row]
//            }
//        }
//        else
//        {
//        }
//        if indexPath.section == 1
//        {
//            cell.labelValue.text! = sections[indexPath.section].MemberName[indexPath.row]
//        }
//        if(indexPath.row==0)
//        {
//            cell.labelKey.hidden = false
//            cell.labelKey.text = muarraykeys.objectAtIndex(indexPath.row) as! String
//        }
//        else
//        {
//         cell.labelKey.hidden = false
//        }
        
        
        if(muarraykeys.count>0)
        {
            if indexPath.row == 0
            {
                cell.labelKey.isHidden = false
                cell.buttonCount.isHidden=false
                cell.buttonAnniVersaryCount.isHidden=true
                cell.buttonCount.setTitle(self.BdayCount,  for: UIControl.State.normal)
                cell.labelKey.text! = "Today's Birthday"
                
            }
            else
            {
                //cell.labelKey.hidden = true
                //cell.buttonAnniVersaryCount.hidden=true
            }
            
            let abc = muarraykeys.object(at: indexPath.row) as! String
            var AnniIndexValueFirst:Int=0
            if(abc=="Anniversary")
            {
                if(varMatchAnniversary=="0")
                {
                   AnniIndexValueFirst = indexPath.row
                    varMatchAnniversary = "1"
                }
                else
                {
                }
                if(indexPath.row == AnniIndexValueFirst)
                {
                    cell.labelKey.isHidden = false
                    cell.buttonCount.isHidden=true
                    cell.buttonAnniVersaryCount.isHidden=false
                    cell.labelKey.text! = "Today's Anniversary"
                    cell.buttonAnniVersaryCount.setTitle(self.AnniCount,  for: UIControl.State.normal)
                }
                else
                {
                    //cell.labelKey.hidden = true
                    //cell.buttonCount.hidden=true
                }
            }
            else
            {
                 //cell.labelKey.hidden = true
                // cell.buttonCount.hidden=true
                 //cell.buttonAnniVersaryCount.hidden=true
            }
            
            let keyValuesName = muarrayBirthdayAndAnniversary.object(at: indexPath.row) as! String
            print(keyValuesName)
            let varRelation = self.muarrayRelation.object(at: indexPath.row) as! String //Need to uncomment this line and replace ""Spouse of "+String(myStringArraySeond[0])" by varRelation
            var indexCheck:Int=0
            if keyValuesName.lowercased().characters.contains("(")
            {
                
                
                print("44545454554545555555555555555",keyValuesName)
                let  myStringArr=keyValuesName.components(separatedBy: "(")
                print(myStringArr[0])
                let myStringArraySeond = myStringArr[1].components(separatedBy: ")")
                print("11111111111111111111111111111111",myStringArraySeond[0])
                var ralationattributedStrings:NSAttributedString=NSAttributedString()
               ralationattributedStrings = functionForSetColorrelationship(String(myStringArr[0]), stringName: varRelation)
                
                cell.labelValue.attributedText = ralationattributedStrings
                indexCheck = indexPath.row
                
                
//                
//                if(self.muarrayMobileNumber.objectAtIndex(indexPath.row) as! String == "")
//                {
//                    cell.buttonCall.hidden=true
//                    cell.buttonMessage.hidden=true
//                }

            }
            
            if(indexPath.row>0 && indexCheck==indexPath.row)
            {
                
            }
            else
            {
              cell.labelValue.text = muarrayBirthdayAndAnniversary.object(at: indexPath.row) as! String
            }
           // let  myStringArr=keyValuesName.componentsSeparatedByString("(")
            
        }
        
        cell.buttonCall.addTarget(self, action: #selector(PushNotificationPopUpViewController.buttonCall(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonCall.tag=indexPath.row;
        cell.buttonMessage.addTarget(self, action: #selector(PushNotificationPopUpViewController.buttonMessage(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonMessage.tag=indexPath.row;
        return cell as NotificationPopUpTableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let grpID = self.muarrayGroupIDs.object(at: indexPath.row) as! String
        let profileId = self.muarrayProfileIDs.object(at: indexPath.row) as! String
    
        let objProfileDynamicNewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileDynamicNewViewController") as! ProfileDynamicNewViewController
        objProfileDynamicNewViewController.grpID=grpID
        objProfileDynamicNewViewController.profileId=profileId
        self.navigationController?.pushViewController(objProfileDynamicNewViewController, animated: true)
     
    }
    func functionForSetColorrelationship(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#000000\">"+stringKey+"</font> <font color=\"#808080\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
           let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            print("Cannot create attributed String")
        }
        print(attributedStringss)
        return attributedStringss
    }
    
    //MARK:- Call Action
    @objc func buttonCall(_ sender:UIButton)
    {
        
        PhoneNumberSTR =  muarrayMobileNumber.object(at: sender.tag) as! String
        
        print("calling\(PhoneNumberSTR)")
        
//        let url = URL(string: "tel://\(PhoneNumberSTR)")
//        UIApplication.shared.openURL(url!)
        
        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        
        /*
        if PhoneNumberSTR.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
            alertView.delegate = self
            alertView.tag = 1
            alertView.addButtonWithTitle("No")
            alertView.addButtonWithTitle("Yes")
            alertView.show()
        }
        */
 
        
    }
    func alertView(_ View: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
                if let url = URL(string: "tel://\(PhoneNumberSTR)") {
                    //                UIApplication.shared.openURL(url!)
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }
                }
                
                
                break;
            case 0:
                
                //mobileNumberField.becomeFirstResponder()
                
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

    @objc func buttonMessage(_ sender:UIButton)
    {
        PhoneNumberSTR =  muarrayMobileNumber.object(at: sender.tag) as! String

        print("SMS sent")
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true, completion: nil)
    }

    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
//        
//        if(section==0)
//            
//        {
//            
//        }
//            
//        else
//            
//        {
//            
//            header.titleLabel.text = sections[section].TitleOFBdayOrAnni
//            
//            header.titleLabel.textAlignment = .Center
//            
//            // header.arrowLabel.text = ">"
//            
//            header.section = section
//            
//            //header.delegate = self
//            
//        }
//        
//        return header
//        
//    }
//    
//    
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//        
//    {
//        
//        if(section==0)
//            
//        {
//            
//            return 0.0
//            
//        }
//            
//        else
//            
//        {
//            
//            return 30.0
//            
//        }
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//        
//    {
//        
//        return 1.0
//        
//    }
    


}
