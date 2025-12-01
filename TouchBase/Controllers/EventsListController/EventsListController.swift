//
//  EventsListController.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import EventKit
import SVProgressHUD

protocol protocolForEventsListingCallingApi {
    func functionForEventsListingCallingApi(stringFromWhereITCalling:String)
}
class EventsListController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,webServiceDelegate,eventcellDelegate , UITableViewDelegate, UITableViewDataSource,protocolForEventsListingCallingApi {
    func functionForEventsListingCallingApi(stringFromWhereITCalling:String)
    {
        print("being call from :---")
        print(stringFromWhereITCalling)
        
        /*-----*/
        /// alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        // self.present(alertController, animated: true, completion: nil)
        SMSCountStr = ""
        allEventsArry=[]
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self       //grpDetail.masterProfileID
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        
        SVProgressHUD.show()
        
        wsm.getEventListofUserGrp(memberProfileId  as NSString, grpId: moduleGRPID as? NSString ?? "", Type: annType, Admin: isAdmin, searchText: searchTextField.text! as NSString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getClubDetails()
     }

    
    @IBOutlet weak var viewFoSearchrUnderLine: UIView!
    var eventFilterCheck:String!=""
    var memberProfileId:String=""
    var varGetSearchBoxValue:String!=""
    // var eventStore: EKEventStore?
    
    var moduleGRPID: String = ""
    var SMSCountStr : String!
    var Date : String!
    var Time : String!
    @IBOutlet var reminderView: UIView!
    @IBOutlet var eventNameReminderLabel: UILabel!
    @IBOutlet var ReminderPickerView: UIDatePicker!
    
    var pickerDataSource = ["Published", "All", "Scheduled", "Expired"];
    var pickerDataSourceNonAdmin = ["Published", "All", "Expired"];
    var annType:NSString!
    var isAdmin:NSString!
    var moduleName:String! = ""
    var isCategory:String! = ""
    
    var grpName:String! = ""
    
    var venueM = [String]()
        var latM = [String]()
        var lngM = [String]()
        var eventTitleM = [String]()
        var eventDateTimeM = [String]()
        var isReadM = [String]()
        var filterTypeM = [String]()
        var myResponseM = [String]()
        var eventIDM = [String]()
        var filterindex = 0
        var isfilter = false
        
        var eventDateTimeFilter = [String]()
        var venueFilter = [String]()
        var latFilter = [String]()
        var lngFilter = [String]()
        var eventTitleFilter = [String]()
        var isReadFilter = [String]()
        var filterTypeFilter = [String]()
        var myResponseFilter = [String]()
    var eventIDFilter = [String]()
    
    var titleRIZone = ""

    
    @IBOutlet var pickerView:UIPickerView!
    let bounds = UIScreen.main.bounds
    @IBOutlet weak  var searchTextField : UITextField!
    @IBOutlet weak  var listTypeTextField : UITextField!
    @IBOutlet var headerVC:UIView!
    @IBOutlet var EventsTableView: UITableView!
    @IBOutlet var noResultLbl: UILabel!
    var grpDetail:GroupList!
    var grpDetailPrevious:NewModuleList?
    var allEventsArry:NSArray!
    var appDelegate : AppDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        getClubDetails()
        eventFilterCheck = "Published"
        ReminderPickerView.setStyle()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.annType="1"
        self.listTypeTextField.text="Published"
        /*-----------------------------------AdminOrNot------------------DPK--------------------------*/
        if isAdmin == "Yes"
        {
            searchTextField.delegate = self
            listTypeTextField.delegate = self
            
            viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
            searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-(self.listTypeTextField.frame.size.width+20), height: 35)
            
            listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+20, y: self.listTypeTextField.frame.origin.y, width: self.listTypeTextField.frame.size.width, height: 35)
            listTypeTextField.isHidden = false
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
        }
        else
        {
            searchTextField.delegate = self
            viewFoSearchrUnderLine.frame = CGRect(x: self.viewFoSearchrUnderLine.frame.origin.x, y: self.viewFoSearchrUnderLine.frame.origin.y, width: self.view.frame.size.width, height: self.viewFoSearchrUnderLine.frame.size.height)
            searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: self.searchTextField.frame.origin.y, width: self.view.frame.size.width-30,height: 35)
            
            listTypeTextField.isHidden = true
            self.pickerView.isHidden=true
        }
        /*-----------------------------------AdminOrNot----------DPK----------------------------------*/
        
        
        
        
        
        
        
    
        
        /*-----*/
        /// alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        // self.present(alertController, animated: true, completion: nil)
        SMSCountStr = ""
        allEventsArry=[]
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self       //grpDetail.masterProfileID
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        
        SVProgressHUD.show()
        
        wsm.getEventListofUserGrp(memberProfileId  as NSString, grpId: moduleGRPID as? NSString ?? "", Type: annType, Admin: isAdmin, searchText: searchTextField.text! as NSString)
    }
    
    
    
    var alertController = UIAlertController()
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EventsListController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        if isAdmin == "Yes" {
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(EventsListController.AddEventAction))
            add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes"
        {
            listTypeTextField.isHidden=false
           // self.navigationItem.rightBarButtonItem = add
        }
        else
        {
            listTypeTextField.isHidden=true
        }
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if(textField.tag==22){
            searchTextField.resignFirstResponder()
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=false
            
            return false
        }else{
            
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        varGetSearchBoxValue = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        
        // print(strValue)
        print(strValues)
        print(searchTextField.text)
        
        //        if(strValues.length != 0)
        //        {
        //            if(textField.tag==22)
        //            {
        //                listTypeTextField.resignFirstResponder()
        //                self.view .bringSubviewToFront(self.pickerView)
        //                self.pickerView.hidden=true
        //                //return false
        //            }
        //            else
        //            {
        //                //searchTextField.resignFirstResponder()
        //                self.searchAnnouncemt()
        //            }
        //        }
        return true
    }
    //for whatsapp count
    func getClubDetails()
    {
        //loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        var parameterst:NSDictionary=NSDictionary()
        parameterst = ["grpID":grpDetailPrevious?.groupID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            print(response)
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
            if((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
                self.SMSCountStr = smsCount
//                if self.isCalledFRom=="add"
//                {
////                self.MeetingPlace = MeetingPlace
////                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll
//
////                cell.eventVenueTextView.text! = self.MeetingPlace
//                self.SMSCountStr = smsCount
////                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
////                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                self.addEventTableView.reloadData()
//               // self.window = nil
//              }
//                if self.isCalledFRom=="Edit"
//                {
////                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
//                    self.SMSCountStr = smsCount
//                    print(self.SMSCountStr)
////                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
////                    self.addEventTableView.reloadData()
//                }
            }
            else
            {
                //self.window = nil
            }
            SVProgressHUD.dismiss()
            }
        })
    }

    //GALBUM
    @objc func AddEventAction()
    {
        UserDefaults.standard.set("", forKey: "groupsID")
        UserDefaults.standard.set("", forKey: "eventAddress")
        let addEvent = self.storyboard?.instantiateViewController(withIdentifier: "add_event") as! AddEventsController
        addEvent.titleRIZone = self.titleRIZone
        addEvent.groupID = grpDetailPrevious?.groupID
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        
        addEvent.groupProfileID = memberProfileId
        //addEvent.isCalledFRom = "add"
        addEvent.isCalledFrom="add"
        print(self.SMSCountStr)
        addEvent.SMSCountStr = self.SMSCountStr
        addEvent.moduleName = moduleName
        addEvent.isCategory=isCategory
        
        addEvent.objprotocolForEventsListingCallingApi=self
        
        UserDefaults.standard.set("nothing", forKey: "session_LinkValue")
        
//        self.navigationController?.pushViewController(secondViewController, animated: true)
        self.navigationController?.pushViewController(addEvent, animated: true)
    }
    
    func getEventListSucc(_ string:EventListDetailResult){
        //----------
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(EventsListController.AddEventAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes"
        {
            listTypeTextField.isHidden=false
            self.navigationItem.rightBarButtonItem = add
        }
        else
        {
            listTypeTextField.isHidden=true
        }
        //-------
        
        
        
        
        
        SVProgressHUD.dismiss()
        alertController.dismiss(animated: true, completion: nil)
//        SMSCountStr = string.smsCount
        print("--------------------------------------------------------------Hello----------------------",SMSCountStr)
        print(string.status)
        if string.status == "1"
        {
            allEventsArry=[]
            EventsTableView.reloadData()
            noResultLbl.text="No results"
            noResultLbl.isHidden=false
            pickerView.isHidden=true
        }
        else
        {
            allEventsArry=string.eventsListResult as! NSArray
            self.venueM.removeAll()
                       self.eventTitleM.removeAll()
                       self.latM.removeAll()
                       self.lngM.removeAll()
                       self.eventDateTimeM.removeAll()
                       self.isReadM.removeAll()
                       self.filterTypeM.removeAll()
                       self.myResponseM.removeAll()
            self.eventIDM.removeAll()
                       
                       for i in 0 ..< allEventsArry.count {
                           self.venueM.append((allEventsArry[i] as AnyObject).venue)
                           self.eventTitleM.append((allEventsArry[i] as AnyObject).eventTitle)
                           self.latM.append((allEventsArry[i] as AnyObject).venueLat)
                           self.lngM.append((allEventsArry[i] as AnyObject).venueLon)
                           self.eventDateTimeM.append((allEventsArry[i] as AnyObject).eventDateTime)
                           self.isReadM.append((allEventsArry[i] as AnyObject).isRead)
                           self.filterTypeM.append((allEventsArry[i] as AnyObject).filterType)
                           self.myResponseM.append((allEventsArry[i] as AnyObject).myResponse)
                           self.eventIDM.append((allEventsArry[i] as AnyObject).eventID)
                           print("self.venueM---\(self.venueM)")
                           print("self.eventDateTimeM---\(self.eventDateTimeM)")
                       }
            print(string.eventsListResult)
            print(allEventsArry)
            EventsTableView.isHidden=false
            noResultLbl.isHidden=true
            EventsTableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        self.headerVC.translatesAutoresizingMaskIntoConstraints = true
        self.headerVC.frame=CGRect(x: 0, y: 0, width: bounds.width, height: 60)
        return self.headerVC;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    func searchAnnouncemt(){
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        let uid = defaults.string(forKey: "masterUID")
        wsm.getEventListofUserGrp(memberProfileId  as NSString, grpId: moduleGRPID as? NSString ?? "", Type: annType, Admin: isAdmin, searchText: varGetSearchBoxValue as! NSString)
        
        let searchString = varGetSearchBoxValue.lowercased()
              if varGetSearchBoxValue.characters.count > 0 {
                  venueFilter.removeAll()
                  latFilter.removeAll()
                  lngFilter.removeAll()
                  eventDateTimeFilter.removeAll()
                  isReadFilter.removeAll()
                  filterTypeFilter.removeAll()
                  myResponseFilter.removeAll()
                  eventTitleFilter.removeAll()
                  eventIDFilter.removeAll()
                  
                  isfilter = true
                  
                  let filteredMember = self.eventTitleM.filter { $0.lowercased().contains(searchString) }
                  eventTitleFilter.append(contentsOf:filteredMember)
                  print("eventTitleFilter-----\(eventTitleFilter)")
                  
                  for memberfilter in eventTitleFilter {
                      if let index = self.eventTitleM.firstIndex(where: { $0 == memberfilter }) {
                          venueFilter.append(self.venueM[index])
                          latFilter.append(self.latM[index])
                          lngFilter.append(self.latM[index])
                          eventDateTimeFilter.append(self.eventDateTimeM[index])
                          isReadFilter.append(self.isReadM[index])
                          filterTypeFilter.append(self.filterTypeM[index])
                          myResponseFilter.append(self.myResponseM[index])
                          eventIDFilter.append(self.eventIDM[index])
                          filterindex = index
                      }
                  }
                  
              } else {
                  isfilter = false
                  noResultLbl.isHidden = true
              }
//              EventsTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("allEventsArry.count---\(allEventsArry.count)")
        if isfilter {
                   return eventTitleFilter.count
               } else {
                   if allEventsArry.count > 0 {
                       return allEventsArry.count
                   } else {
                       return 0
                   }
               }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // self.searchAnnouncemt()
        if(textField.tag==22){
            
            listTypeTextField.resignFirstResponder()
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=true
            //return false
        }else{
            searchTextField.resignFirstResponder()
            self.searchAnnouncemt()
            self.pickerView.isHidden=true
        }
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = EventsTableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as! EventsCell
        if isfilter {
                   let i = indexPath.row
                   alertController.dismiss(animated: true, completion: nil)
            
            if self.eventTitleFilter.count == 0 {
                self.noResultLbl.isHidden = false
            }
                   
                   var myStringArr = eventDateTimeFilter[i].components(separatedBy: " ")
                   print(myStringArr)
                   if(myStringArr.count > 0){
                       cell.datedayLabel.text = myStringArr[0]
                       cell.monthLabel.text = myStringArr[1].uppercased()
                       cell.timeLabel.text = String(format: "%@ %@",myStringArr[3],myStringArr[4])
                       print(myStringArr[3])
                       print(myStringArr[4])
                   }
                   if(isReadFilter[i] == "No"){
                       
                       cell.EventNameLabel.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
                       
                   }else{
                       
                       cell.EventNameLabel.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
                       
                   }
                   if(filterTypeFilter[i]=="1"){
                       cell.eventStatus.text=String(format: "Published")
                   }else if(filterTypeFilter[i]=="2"){
                       cell.eventStatus.text=String(format: "Scheduled")
                   }else if(filterTypeFilter[i]=="3"){
                       cell.eventStatus.text=String(format: "Expired")
                   }
                   
                   if(myResponseFilter[i] == "1")
                   {
                       
                       cell.EventFlagImage.image = UIImage(named: "corner-img")
                   }
                   else if(myResponseFilter[i] == "2")
                   {
                       cell.EventFlagImage.image = UIImage(named: "corner-img-red")
                   }
                   else if(myResponseFilter[i] == "3")
                   {
                       cell.EventFlagImage.image = UIImage(named: "corner-img-gray")
                   }else{
                       cell.EventFlagImage.image = nil
                   }
                   cell.EventPic.layer.borderWidth = 1
                   cell.EventPic.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
                   //cell.EventDateTimeLabel.text=grp.eventDateTime
                   cell.EventPlaceLabel.text=venueFilter[i]
                   cell.EventNameLabel.text=eventTitleFilter[i]
                   cell.delegates=self
                   cell.venueLat=latFilter[i] as? NSString
                   cell.venueLon=lngFilter[i] as? NSString
        } else {
            var grp:EventList!
            alertController.dismiss(animated: true, completion: nil)
            
            
            print(allEventsArry[indexPath.row] as! EventList)
            
            
            
            grp=allEventsArry[indexPath.row] as! EventList
            var myStringArr = grp.eventDateTime.components(separatedBy: " ")
            print(myStringArr)
            if(myStringArr.count > 0){
                cell.datedayLabel.text = myStringArr[0]
                cell.monthLabel.text = myStringArr[1].uppercased()
                cell.timeLabel.text = String(format: "%@ %@",myStringArr[3],myStringArr[4])
                print(myStringArr[3])
                print(myStringArr[4])
            }
            if(grp.isRead == "No"){
                
                cell.EventNameLabel.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
                
            }else{
                
                cell.EventNameLabel.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
                
            }
            if(grp.filterType=="1"){
                cell.eventStatus.text=String(format: "Published")
            }else if(grp.filterType=="2"){
                cell.eventStatus.text=String(format: "Scheduled")
            }else if(grp.filterType=="3"){
                cell.eventStatus.text=String(format: "Expired")
            }
            
            if(grp.myResponse == "1")
            {
                
                cell.EventFlagImage.image = UIImage(named: "corner-img")
            }
            else if(grp.myResponse == "2")
            {
                cell.EventFlagImage.image = UIImage(named: "corner-img-red")
            }
            else if(grp.myResponse == "3")
            {
                cell.EventFlagImage.image = UIImage(named: "corner-img-gray")
            }else{
                cell.EventFlagImage.image = nil
            }
            //        if let checkedUrl = NSURL(string: grp.eventImg) {
            //
            //            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
            //                dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //                    guard let data = data where error == nil else { return }
            //                    print(response?.suggestedFilename ?? "")
            //                    print("Download Finished")
            //                    cell.EventPic.image = UIImage(data: data)
            //
            //                    //  cell.activityLoader.stopAnimating()
            //                }
            //            }
            //        }
            //cell.EventPic.layer.borderColor = UIColor.clearColor().CGColor
            cell.EventPic.layer.borderWidth = 1
            cell.EventPic.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
            //cell.EventDateTimeLabel.text=grp.eventDateTime
            cell.EventPlaceLabel.text=grp.venue
            cell.EventNameLabel.text=grp.eventTitle
            cell.delegates=self
            cell.venueLat=grp.venueLat as! NSString
            cell.venueLon=grp.venueLon as! NSString
        }
        
        cell.EventRemindButton.addTarget(self, action: #selector(EventsListController.setReminderAction(_:)), for: UIControl.Event.touchUpInside)
        cell.EventRemindButton.tag = indexPath.row
                   
        
        return cell
        
        
    }
    
    /////////////////--->>>>> Set Reminder <<<<<<<--------\\\\\\\\
    
    @objc func setReminderAction(_ sender:UIButton)
    {
        reminderView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        self.view .addSubview(reminderView)
        
        
        ReminderPickerView.addTarget(self, action: #selector(EventsListController.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        var grp:EventList!
        grp=allEventsArry[sender.tag] as! EventList
        eventNameReminderLabel.text = grp.eventTitle
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:00"
        let strDate = dateFormatter.string(from: ReminderPickerView.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        
        appDelegate = UIApplication.shared.delegate
            as? AppDelegate
        
        print(appDelegate)
        appDelegate!.eventStore = EKEventStore()   // changes by DPK  inner to outer
        if appDelegate!.eventStore == nil {
            
            appDelegate!.eventStore!.requestAccess(to: EKEntityType.reminder, completion:
                {(granted, error) in
                    if !granted
                    {
                        print("Access to store not granted")
                        print(error!.localizedDescription)
                    }
                    else
                    {
                        print("Access granted")
                    }
            })
        }
        
        
    }
    
    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        
        //   let cell = cellArray.objectAtIndex(sender.tag) as! ScheduleCell
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:00"
        let strDate = dateFormatter.string(from: sender.date)
        
        
        let strSplit = strDate.characters.split(separator: " ")
        Date = String(strSplit.first!)
        Time = String(strSplit.last!)
        
        print(Date)
        print(Time)
        
        
        
    }
    
    
    @IBAction func closeReminderView(_ sender: AnyObject)
    {
        reminderView.removeFromSuperview()
    }
    
    
    @IBAction func SaveReminder(_ sender: AnyObject)
    {
        if (appDelegate!.eventStore != nil)
        {
            self.createReminder()
            
        }
        else
        {
            self.createReminder()
        } // changes by DPK
    }
    
    func createReminder() {
        
        let reminder = EKReminder(eventStore: appDelegate!.eventStore!)
        reminder.title = String(format:"Reminder for %@",eventNameReminderLabel.text!)
        reminder.calendar = appDelegate!.eventStore!.defaultCalendarForNewReminders()
        let date = ReminderPickerView.date
        let alarm = EKAlarm(absoluteDate: date)
        
        self.view.makeToast("Reminder added successfully!", duration: 2, position: CSToastPositionCenter)
        
        
        
        
        
        //        let alertView:UIAlertView = UIAlertView()
        //        alertView.title = "Event"
        //        alertView.message = String(format:"reminder set for %@ on %@ at %@",eventNameReminderLabel.text!,Date,Time)
        //        alertView.delegate = self
        //        alertView.addButtonWithTitle("OK")
        //        alertView.show()
        
        reminder.addAlarm(alarm)
        
        do {
            try appDelegate!.eventStore!.save(reminder, commit: true)
            
        } catch
        {
            print(error)
        }
        
        
        
        
        
        
        
        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted { return }
            let event = EKEvent(eventStore: store)
            event.title = String(format:"Reminder for %@",self.eventNameReminderLabel.text!)
            let date1 = self.ReminderPickerView.date
            event.startDate = date1 //today
            event.endDate = event.startDate.addingTimeInterval(60*60*24) //1 hour long meeting
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(event, span: .thisEvent, commit: true)
                //self.savedEventId = event.eventIdentifier //save event id to access this particular event later
            } catch {
                // Display error to user
            }
        }
        reminderView.removeFromSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        UserDefaults.standard.setValue("nothing", forKey: "session_LinkValue")
        EventsTableView.deselectRow(at: indexPath, animated: true)
        self.pickerView.isHidden=true
        
        UserDefaults.standard.set(isAdmin, forKey: "isAdmin")
        
        if isfilter {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
            secondViewController.grpDetailPrevious = grpDetailPrevious
            secondViewController.memberProfileId = memberProfileId
            secondViewController.eventDetail = eventIDFilter[indexPath.row]
            secondViewController.isCalled = "list"
            secondViewController.varIsRSVPEnableorDisable=0
            secondViewController.SMSCountStr = SMSCountStr
            secondViewController.moduleName = moduleName
            secondViewController.isCategory = isCategory
            secondViewController.eventFilterCheck=self.listTypeTextField.text
            secondViewController.grpName=grpName
            secondViewController.objprotocolForEventsListingCallingApi=self
            secondViewController.titleRIZone = self.titleRIZone
            self.navigationController?.pushViewController(secondViewController, animated: true)
        } else {
            var grp:EventList!
            grp=allEventsArry[indexPath.row] as! EventList
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventDetail") as! EventsDetailController
            secondViewController.grpDetailPrevious = grpDetailPrevious
            secondViewController.memberProfileId = memberProfileId
            secondViewController.eventDetail = grp.eventID
            secondViewController.isCalled = "list"
            secondViewController.varIsRSVPEnableorDisable=0
            secondViewController.SMSCountStr = SMSCountStr
            secondViewController.moduleName = moduleName
            secondViewController.isCategory = isCategory
            secondViewController.eventFilterCheck=self.listTypeTextField.text
            secondViewController.grpName=grpName
            secondViewController.objprotocolForEventsListingCallingApi=self
            secondViewController.titleRIZone = self.titleRIZone
            
            //print("Event Details list")
            //print("grpDetailPrevious = \( grpDetailPrevious) \n memberProfileId = \(memberProfileId) \n eventDetail = \(grp)\n isCalled = list \n varIsRSVPEnableorDisable=0 \n SMSCountStr = \(SMSCountStr) \n moduleName = \(moduleName) \n isCategory = \(isCategory) \n eventFilterCheck= \(self.listTypeTextField.text) \n  grpName= \(grpName)")
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func mapBtnClk(_ vnlt:NSString,vnlon:NSString,vname:NSString){
        print("111112222223333334444444555555666666")
        let address = vname as String
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("This is Error:------>")
                self.view.makeToast("Address is not valid", duration: 3, position: CSToastPositionCenter)
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                {
//                    UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!)
                    
                    if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!) {
                        UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!, options: [:]) { success in
                                if success {
                                    print("The URL was successfully opened.")
                                } else {
                                    print("Failed to open the URL.")
                                }
                            }
                        }
                    
                }
                else
                {}
            }
            else
            {
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                    {
                        // UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)&directionsmode=driving")!)
                        //Working in Swift new versions.
//                        UIApplication.shared.openURL(NSURL(string:
//                            "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                        
                        if UIApplication.shared.canOpenURL(NSURL(string:
                                                                    "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL) {
                            UIApplication.shared.open(NSURL(string:
                                                                "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL, options: [:]) { success in
                                    if success {
                                        print("The URL was successfully opened.")
                                    } else {
                                        print("Failed to open the URL.")
                                    }
                                }
                            }
                        
                        
                    }
                    else
                    {
                        let directionsURL = "http://maps.apple.com/?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))"
                        guard let url = URL(string: directionsURL) else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
//                            UIApplication.shared.openURL(url)
                            
                            if UIApplication.shared.canOpenURL(url as URL) {
                                UIApplication.shared.open(url as URL, options: [:]) { success in
                                        if success {
                                            print("The URL was successfully opened.")
                                        } else {
                                            print("Failed to open the URL.")
                                        }
                                    }
                                }
                            
                        }
                        NSLog("Can't use comgooglemaps://");
                    }
                    
                }
            }
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isAdmin == "Yes"
        {
            return pickerDataSource.count;
        }
        else
        {
            return pickerDataSourceNonAdmin.count;
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if isAdmin == "Yes"
        {
            return pickerDataSource[row]
        }
        else
        {
            return pickerDataSourceNonAdmin[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(pickerDataSource[row])
        //var pickerDataSource = ["All", "Published", "Scheduled", "Expired"];
        SVProgressHUD.show()
        noResultLbl.isHidden=true
        if isAdmin == "Yes"
        {
            if(pickerDataSource[row]=="All"){
                self.listTypeTextField.text="All"
                self.annType="0"
            }else if(pickerDataSource[row]=="Published"){
                self.listTypeTextField.text="Published"
                self.annType="1"
            }else if(pickerDataSource[row]=="Scheduled"){
                self.listTypeTextField.text="Scheduled"
                self.annType="2"
            }else if(pickerDataSource[row]=="Expired"){
                self.listTypeTextField.text="Expired"
                
                self.annType="3"
            }else{
                self.annType="1"
            }
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
        }
        else
        {
            if(pickerDataSourceNonAdmin[row]=="All"){
                self.listTypeTextField.text="All"
                self.annType="0"
            }else if(pickerDataSourceNonAdmin[row]=="Published"){
                self.listTypeTextField.text="Published"
                self.annType="1"
            }else if(pickerDataSourceNonAdmin[row]=="Expired"){
                self.listTypeTextField.text="Expired"
                
                self.annType="3"
            }else{
                self.annType="1"
            }
            self.pickerView.isHidden=true
            self.searchAnnouncemt()
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        /*
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        */
    }
   
}

