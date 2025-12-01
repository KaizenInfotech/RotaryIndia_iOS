//
//  NewEventAttendanceViewController.swift
//  TouchBase
//
//  Created by rajendra on 08/06/18.
//  Copyright © 2018 Parag. All rights reserved.
///Volumes/B/RajendraJat from 30March2018/Development/Projects/ROW/08-June-18-ROW/TouchBase/Controllers/AttendanceViewController/NewEventAttendanceViewControllerTableViewCell.swift

import UIKit
import SVProgressHUD
//For Member
var muarrayMemberDelete:NSMutableArray=NSMutableArray()
var muarrayMemberServerIDDelete:NSMutableArray=NSMutableArray()
//For Anns
var muarrayAnnsDelete:NSMutableArray=NSMutableArray()
var muarrayAnnsServerIDDelete:NSMutableArray=NSMutableArray()
//For Anns
var muarrayAnnetsDelete:NSMutableArray=NSMutableArray()
var muarrayAnnetsServerIDDelete:NSMutableArray=NSMutableArray()
//For Visitors
var muarrayVisitorsDelete:NSMutableArray=NSMutableArray()
var muarrayVisitorsServerIDDelete:NSMutableArray=NSMutableArray()
//For Rotarian (Other Club)
var muarrayRotarianDelete:NSMutableArray=NSMutableArray()
var muarrayRotarianServerIDDelete:NSMutableArray=NSMutableArray()
//For District Delegates
var muarrayDistrictDelegatesDelete:NSMutableArray=NSMutableArray()
var muarrayDistrictDelegatesServerIDDelete:NSMutableArray=NSMutableArray()




class NewEventAttendanceViewController: UIViewController,protocolName,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate
{
    @IBOutlet weak var tableviewNewEventAttendance: UITableView!
    // Define Delegate Method
    //    func functionForSendingValue2(stringValue: String, index: Int) {
    //
    //    }
    /*
     self.objProtocol?.functionForSendingValue("Anns", index: 5, muarrayValue: muarrayListData)
     
     */
    //need to take five mutablearray for hodling value from member to .... district delegates
    var myarrayHoldMember:NSMutableArray=NSMutableArray()
    var myarrayHoldAnns:NSMutableArray=NSMutableArray()
    var myarrayHoldAnnets:NSMutableArray=NSMutableArray()
    var myarrayHoldVisitors:NSMutableArray=NSMutableArray()
    var myarrayHoldRotarian:NSMutableArray=NSMutableArray()
    var myarrayHoldDistrictDelegates:NSMutableArray=NSMutableArray()
    override func viewWillAppear(_ animated: Bool)
    {
        
        
        print(UserDefaults.standard.object(forKey: "session_arrayValue") as Any)
        
            print(myarrayHoldAnnets)
    }
    func functionForSendingValue(_ stringValue: String, index: Int, muarrayValueGlobal: NSMutableArray)
    {
        //print(stringValue)
        //print(index)
        //print(muarrayValueGlobal)
        //print(muarrayValue)
        var varGetValue:String!=muarrayValue.object(at: index-1)as! String
        
        
        if(muarrayValueGlobal.count<=0 )
        {
            //print("if")
            //print(stringValue)
            muarrayValue.replaceObject(at: index-1, with: "0 "+stringValue)
        }
        else
        {
            //print("else")
            //if you coming from Members screen then use this if case where no need to -1 or reduce members
            if(stringValue=="Members")
            {
                //let varGetCount:Int!=muarrayValueGlobal.count-1

                let varGetCount:Int!=muarrayValueGlobal.count
                print(varGetCount)
                print("<<<<<<<<<<<<<<<<<<..........>>>>>>>>>>>>>>>>>>>>>>")
                if(varGetCount==0)
                {
                    //muarrayValue.replaceObject(at: index-1, with: stringValue)
                    muarrayValue.replaceObject(at: index-1, with: "0 "+stringValue)

                }
                else
                {
                    muarrayValue.replaceObject(at: index-1, with: String(muarrayValueGlobal.count)+" "+stringValue)
                }
            }
                //for others case instaed of members
            else
            {
                let varGetCount:Int!=muarrayValueGlobal.count-1
                if(varGetCount==0)
                {
                    muarrayValue.replaceObject(at: index-1, with: "0 "+stringValue)

                   // muarrayValue.replaceObject(at: index-1, with: stringValue)
                }
                else
                {
                    muarrayValue.replaceObject(at: index-1, with: String(muarrayValueGlobal.count-1)+" "+stringValue)
                }
            }
            //print(String(muarrayValueGlobal.count))
            //print(muarrayValue)
        }
        /*-=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=---=--*/
        if(index==4)//members
        {
            myarrayHoldMember=NSMutableArray()
            myarrayHoldMember=muarrayValueGlobal
        }
        else if(index==5)//anns
        {
            //print(muarrayValueGlobal)
            myarrayHoldAnns=NSMutableArray()
            myarrayHoldAnns=muarrayValueGlobal
        }
        else if(index==6)//annets
        {
            myarrayHoldAnnets=NSMutableArray()
            myarrayHoldAnnets=muarrayValueGlobal
        }
        else if(index==7)//visitors
        {
            myarrayHoldVisitors=NSMutableArray()
            myarrayHoldVisitors=muarrayValueGlobal
        }
        else if(index==8)//rotarian
        {
            myarrayHoldRotarian=NSMutableArray()
            myarrayHoldRotarian=muarrayValueGlobal
        }
        else if(index==9)//district delagates
        {
            myarrayHoldDistrictDelegates=NSMutableArray()
            myarrayHoldDistrictDelegates=muarrayValueGlobal
        }
        
        tableviewNewEventAttendance.reloadData()
    }
    //func functionForSendingValue(stringValue: String, index: Int) {
    //  //print(stringValue)
    //  //print("Index:-",index)
    // }
    
    var muarrayNewEventAtt:NSMutableArray=NSMutableArray()
    var muarrayValue:NSMutableArray=NSMutableArray()
    
    
    var grpIDNewEventAttendance: String!=""
    var varModuleIdNewEventAttendance:String!=""
    var moduleNameNewEventAttendance:String!=""
    var isAdminNewEventAttendance:String! = ""
    var varGrpProfileIDNewEventAttendance:String! = ""
    var EventId:String!=""
    var AttendanceID:String!=""
    var isfromEdit = false
    var varFrom:String! = ""
    var prototypeCells:NewEventAttendanceViewControllerTableViewCell=NewEventAttendanceViewControllerTableViewCell()
    let reuseIdentifier = "cell"
    
    
    //code for date 19 june 2018------------------
    func functionForFetchingAllDetailFromServer()
    {
        
        //print(varFrom)
        if(varFrom=="FromSelectEvent")
        {
            //call web api fo
            //print(varFrom)
            
            //after xcode 9 now by Rajendra Jat
            //get value from index number 3 Members
            self.muarrayValue.replaceObject(at: 3, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 3)))
            //get value from index number 4 Anns
            self.muarrayValue.replaceObject(at: 4, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 4)))
            //get value from index number 5 Annets
            self.muarrayValue.replaceObject(at: 5, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 5)))
            //get value from index number 6 Visitors
            self.muarrayValue.replaceObject(at: 6, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 6)))
            //get value from index number 7 Rotarian (Other Club)
            self.muarrayValue.replaceObject(at: 7, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 7)))
            //get value from index number 8 District Delegates
            self.muarrayValue.replaceObject(at: 8, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 8)))
            
            
            
            self.tableviewNewEventAttendance.reloadData()
            
            
            functionForFetchingEventDetailData()
        }
        else if(varFrom=="FromAttendanceEdit")
        {
            //print(varFrom)
            //call web api for getting data updating exist record
            /*
            //after xcode 9 now by Rajendra Jat
            //get value from index number 3 Members
            self.muarrayValue.replaceObject(at: 3, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 3)))
            //get value from index number 4 Anns
            self.muarrayValue.replaceObject(at: 4, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 4)))
            //get value from index number 5 Annets
            self.muarrayValue.replaceObject(at: 5, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 5)))
            //get value from index number 6 Visitors
            self.muarrayValue.replaceObject(at: 6, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 6)))
            //get value from index number 7 Rotarian (Other Club)
            self.muarrayValue.replaceObject(at: 7, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 7)))
            //get value from index number 8 District Delegates
            self.muarrayValue.replaceObject(at: 8, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 8)))
            
            
            
            self.tableviewNewEventAttendance.reloadData()
            */
            functionForFetchingDataAttendanceIDWise()
        }
        else if(varFrom=="fromAttendance")
        {
            //print(varFrom)
            //call web api for getting create new event
            
            //after xcode 9 now by Rajendra Jat
            //get value from index number 3 Members
            self.muarrayValue.replaceObject(at: 3, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 3)))
            //get value from index number 4 Anns
            self.muarrayValue.replaceObject(at: 4, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 4)))
            //get value from index number 5 Annets
            self.muarrayValue.replaceObject(at: 5, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 5)))
            //get value from index number 6 Visitors
            self.muarrayValue.replaceObject(at: 6, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 6)))
            //get value from index number 7 Rotarian (Other Club)
            self.muarrayValue.replaceObject(at: 7, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 7)))
            //get value from index number 8 District Delegates
            self.muarrayValue.replaceObject(at: 8, with: String(0)+" "+String(describing: self.muarrayValue.object(at: 8)))
            
            
            
            self.tableviewNewEventAttendance.reloadData()
            
        }
        //print(varFrom)
    }
    /*-code for editing exist record---*/
    func functionForFetchingDataAttendanceIDWise()
    {
        
        
        
        let completeURL = baseUrl+"Attendance/getAttendanceDetails"
        let parameterst = [
            "AttendanceID":AttendanceID!
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            //print(response)
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
            if((dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                // let arrarrNewGroupList = (dd.objectForKey("EventListDetailResult")!.objectForKey("EventsListResult")!.objectForKey("EventList")) as! NSArray
                
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "AttendanceDetailsResult")!
                //print(arrarrNewGroupList)
                
                
                let arrarrNewGroupListArray = (dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "AttendanceDetailsResult")! as! NSArray
                
                //this is array
                if(arrarrNewGroupListArray.count>0)
                {
                    var dictTemporaryDictionary:NSDictionary=((dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "AttendanceDetailsResult")! as AnyObject).object(at: 0)
                    
                    
                    
                    
                    
                    
                    let responseCode = dictTemporaryDictionary.object(forKey: "AttendanceResult")!
                    
                    
                    let AttendanceName=(responseCode as AnyObject).value(forKey: "AttendanceName")as! String
                    let AttendanceDate=(responseCode as AnyObject).value(forKey: "AttendanceDate")as! String
                    let Attendancetime=(responseCode as AnyObject).value(forKey: "Attendancetime")as! String
                    let AttendanceDesc=(responseCode as AnyObject).value(forKey: "AttendanceDesc")as! String
                    
                    let MemberCount=(responseCode as AnyObject).value(forKey: "MemberCount")as! Int
                    let AnnsCount=(responseCode as AnyObject).value(forKey: "AnnsCount")as! Int
                    let AnnetsCount=(responseCode as AnyObject).value(forKey: "AnnetsCount")as! Int
                    let VisitorsCount=(responseCode as AnyObject).value(forKey: "VisitorsCount")as! Int
                    let RotarianCount=(responseCode as AnyObject).value(forKey: "RotarianCount")as! Int
                    let DistrictDelegatesCount=(responseCode as AnyObject).value(forKey: "DistrictDelegatesCount")as! Int
                    
                    let AttendanceID=(responseCode as AnyObject).value(forKey: "AttendanceID")as! String
                    
                    
                    
                    
                    let EventTitle = AttendanceName
                    let EventDesc = AttendanceDesc
                    let EventDate = AttendanceDate
                    
                    //print(EventTitle)
                    //print(EventDesc)
                    //print(EventDate)
                    
                    
                    self.muarrayValue.replaceObject(at: 0, with: EventTitle)
                    self.muarrayValue.replaceObject(at: 1, with: EventDesc)
                    self.muarrayValue.replaceObject(at: 2, with: EventDate)
                    print("1@1@1 FetchingID wise date \(self.muarrayValue.object(at: 2)as! String)")
                    print(MemberCount)
                    print(AnnsCount)
                    print(AnnetsCount)
                    print(VisitorsCount)
                    print(RotarianCount)
                    
                 
                    
                    //after xcode 9 now by Rajendra Jat
                    //get value from index number 3 Members
                    self.muarrayValue.replaceObject(at: 3, with: String(MemberCount)+" "+String(describing: self.muarrayValue.object(at: 3)))
                    //get value from index number 4 Anns
                    self.muarrayValue.replaceObject(at: 4, with: String(AnnsCount)+" "+String(describing: self.muarrayValue.object(at: 4)))
                    //get value from index number 5 Annets
                    self.muarrayValue.replaceObject(at: 5, with: String(AnnetsCount)+" "+String(describing: self.muarrayValue.object(at: 5)))
                    //get value from index number 6 Visitors
                    self.muarrayValue.replaceObject(at: 6, with: String(VisitorsCount)+" "+String(describing: self.muarrayValue.object(at: 6)))
                    //get value from index number 7 Rotarian (Other Club)
                    self.muarrayValue.replaceObject(at: 7, with: String(RotarianCount)+" "+String(describing: self.muarrayValue.object(at: 7)))
                    //get value from index number 8 District Delegates
                    self.muarrayValue.replaceObject(at: 8, with: String(DistrictDelegatesCount)+" "+String(describing: self.muarrayValue.object(at: 8)))
                    
                    
                   
                    
                    
                    
                    self.tableviewNewEventAttendance.reloadData()
                    
                    
                    
                }
               
                
                //self.tableviewNewEventAttendance.reloadData()
            }
            else
            {
                //print("NO Result")
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        buttonOpacity.isHidden=true
        //Block-6,7 Notification For Select Date And Time Load Xib file------------------------------------
        NotificationCenter.default.addObserver(self, selector: #selector(NewEventAttendanceViewController.NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewEventAttendanceViewController.NotificationIdentifierForGettingValue(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValue"), object: nil)
        
        
        if(varFrom=="FromSelectEvent")
        {
            //print(varFrom)
        }
        else if(varFrom=="fromAttendance")
        {
            //print(varFrom)
        }
        //print(varFrom)
        functionForCreaqteNavigation()
        functionForViewDidload()
        
        /*--code for calling function--*/
        functionForFetchingAllDetailFromServer()
        
        
        //fetching ann list from server
        if(varFrom=="FromAttendanceEdit")
        {
           // alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
            //self.present(alertController, animated: true, completion: nil)
        functionForFetchingAnnsListingListData()
            
       // functionForFetchingAnnetsListingListData()
       // functionForFetchingVisitorsListingListData()
        //functionForFetchingRotarianListingListData()
        //functionForFetchingdistrictdelegatesListingListData()
       // functionForFetchingMemberListingListData()
        }
        
    }
    var alertController = UIAlertController()

    func functionForViewDidload()
    {
        varCustomViewReloadOrNot = "Not"
        muarrayNewEventAtt.add("eventname")
        muarrayNewEventAtt.add("description")
        muarrayNewEventAtt.add("eventdatetime")
        muarrayNewEventAtt.add("Members")
        muarrayNewEventAtt.add("Anns")
        muarrayNewEventAtt.add("Annets")
        muarrayNewEventAtt.add("Visitors")
        muarrayNewEventAtt.add("Rotarians (Other Club)")
        muarrayNewEventAtt.add("District Delegates")
        
        
        //muarrayValue
        
        muarrayValue.add("")
        muarrayValue.add("")
        muarrayValue.add("")
        muarrayValue.add("Members")
        muarrayValue.add("Anns")
        muarrayValue.add("Annets")
        muarrayValue.add("Visitors")
        muarrayValue.add("Rotarians (Other Club)")
        muarrayValue.add("District Delegates")
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func extractedFunc(_ buttonRight: UIButton) {
        //code by rajendra jat later for if edit thenm show update button on navi on right
        //print(varFrom)
        if(varFrom=="FromSelectEvent")
        {
            //call web api fo
            //print(varFrom)
        }
        else if(varFrom=="FromAttendanceEdit")
        {
            //print(varFrom)
            buttonRight.setTitle("Update",  for: UIControl.State.normal)
            
            //call web api for getting data updating exist record
        }
        else if(varFrom=="fromAttendance")
        {
            //print(varFrom)
            //call web api for getting create new event
        }
    }
    
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = moduleNameNewEventAttendance
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        // self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonleft.setTitle("Cancel",  for: UIControl.State.normal)
        buttonleft.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonleft.layer.cornerRadius = 5
        buttonleft.layer.borderWidth = 1
        buttonleft.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonleft.addTarget(self, action: #selector(NewEventAttendanceViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
        
        
        extractedFunc(buttonRight)
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
        
        
    }
    @objc func  buttonAddClickEvent()
    {
        
        ////print five array which holding data from members to .... district delegates
        //print("<<<<<<........This is value from member to district delegates.......>>>>")
        
        //print(myarrayHoldMember)
        //print(myarrayHoldAnns)
        //print(myarrayHoldghjAnnets)
        //print(myarrayHoldVisitors)
        //print(myarrayHoldRotarian)
        //print(myarrayHoldDistrictDelegates)
        
        //print("<<<<<.....This is main array value which contain Event name, Descripion,Event Date and Time......................>>>>>>")
        //print(muarrayValue)
        /*
         if(varFrom=="FromSelectEvent")
         {
         //print(varFrom)
         let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
         self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
         }
         else if(varFrom=="fromAttendance" || varFrom=="FromAttendanceEdit")
         {
         //print(varFrom)
         self.navigationController?.popViewControllerAnimated(true)
         }
         */
        /*<<-------Add  Attendance------------------------------------------------------->>*/
        functionForAddAttendance()
    }
//    func textViewDidChange(_ textView: UITextView) {
//        prototypeCells.placeholderLabel.isHidden = !textView.text.isEmpty
//
//        var gettext=
//    }
    
//    func textViewDidChange(_ descriptionField: UITextView) {
//        if  prototypeCells.textviewDescription.text?.isEmpty == false
//        {
//            print("if")
//            print(prototypeCells.textviewDescription.text)
//             //prototypeCells.textviewDescription.text = ""
//            prototypeCells.placeholderLabel.isHidden=true
//        }
//        else
//        {
//            print("else")
//            print(prototypeCells.textviewDescription.text)
//            // prototypeCells.textviewDescription.text = "Enter Description..."
//            prototypeCells.placeholderLabel.isHidden=false
//
//        }
//    }
//
    
    
    func functionForAddAttendance()
    {
        
        var AttendanceName:String!=muarrayValue.object(at: 0)as! String
        var AttendanceDesc:String!=muarrayValue.object(at: 1)as! String
        var AttendanceDate:String!=muarrayValue.object(at: 2)as! String
        print("1@1@1 Date while saving attendance \(muarrayValue.object(at: 2)as! String)")
        
        AttendanceName=AttendanceName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        AttendanceDesc=AttendanceDesc.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        AttendanceDate=AttendanceDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(AttendanceName.characters.count<=0)
        {
            self.view.makeToast("Event Name can not be blank", duration: 2, position: CSToastPositionCenter)
        }
        else
        {
            if(AttendanceDesc.characters.count<=0)
            {
                self.view.makeToast("Event description cannot be blank", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
                if(AttendanceDate.characters.count<=0)
                {
                    self.view.makeToast("Event date can not be blank", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    var alertController = UIAlertController()
                    
                    SVProgressHUD.show()
                    
                   // alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                  //  self.present(alertController, animated: true, completion: nil)
                    let Fk_group_id:String!=grpIDNewEventAttendance
                    let fk_module_id:String!=varModuleIdNewEventAttendance
                    let created_by:String!=varGrpProfileIDNewEventAttendance
                    let modification_by:String!=varGrpProfileIDNewEventAttendance
                    let deleted_by:String!=varGrpProfileIDNewEventAttendance
                    let FK_eventID:String!="0"
                    
                    
                    //print(myarrayHoldMember)
                    //print(myarrayHoldAnns)
                    //print(myarrayHolghjdAnnets)
                    //print(myarrayHoldVisitors)
                    //print(myarrayHoldRotarian)
                    //print(myarrayHoldDistrictDelegates)
                    
                    //1.
                    /*
                     var MemberCount:Int!=0
                     var muarrayMembersDictArray:NSMutableArray=NSMutableArray()
                     var dictMemberNew:NSMutableDictionary=NSMutableDictionary()
                     if(myarrayHoldMember.count>0)
                     {
                     MemberCount=myarrayHoldMember.count
                     let dictMemberLater:NSMutableDictionary=NSMutableDictionary()
                     for i in 00..<myarrayHoldMember.count
                     {
                     dictMemberLater.setValue(myarrayHoldMember.object(at: i), forKey: "FK_MemberID")
                     }
                     muarrayMembersDictArray.add(dictMemberLater)
                     
                     }
                     else
                     {
                     }
                     //deleted value or uncheck value if already checked
                     var dictMemberDelete:NSMutableDictionary=NSMutableDictionary()
                     var  muarrayMembersDictArrayDelete:NSMutableArray=NSMutableArray()
                     if(muarrayMemberDelete.count>0)
                     {
                     for i in 00..<muarrayMemberDelete.count
                     {
                     dictMemberDelete.setValue(myarrayHoldMember.object(at: i), forKey: "FK_MemberID")
                     }
                     dictMemberDelete=["deletedMembers":muarrayMembersDictArrayDelete]
                     }
                     else
                     {
                     dictMemberDelete=["deletedMembers":muarrayMembersDictArrayDelete]
                     }
                     let muarrayMemberSendServer:NSMutableArray=NSMutableArray()
                     dictMemberNew=["newMembers":muarrayMembersDictArray,"deletedMembers":muarrayMembersDictArrayDelete]
                     muarrayMemberSendServer.add(dictMemberNew)
                     //print(muarrayMemberSendServer)
                     //print(dictMemberNew)
                     //print(dictMemberDelete)
                     */
                    
                    
                    var MemberCount:Int!=0
                    var muarrayMembersDictArray:NSMutableArray=NSMutableArray()
                    var dictMemberNew:NSMutableDictionary=NSMutableDictionary()
                    if(myarrayHoldMember.count>0)
                    {
                        MemberCount=myarrayHoldMember.count
                        for i in 00..<myarrayHoldMember.count
                        {
                            let dictAttendanceMembers:NSMutableDictionary=["FK_MemberID":myarrayHoldMember.object(at: i)]
                            muarrayMembersDictArray.add(dictAttendanceMembers)
                        }
                        dictMemberNew=["newMembers":muarrayMembersDictArray]
                    }
                    else
                    {
                        dictMemberNew=["newMembers":muarrayMembersDictArray]
                    }
                    //deleted value or uncheck value if already checked
                    var dictMemberDelete:NSMutableDictionary=NSMutableDictionary()
                    var  muarrayMembersDictArrayDelete:NSMutableArray=NSMutableArray()
                    if(muarrayMemberDelete.count>0)
                    {
                        for i in 00..<muarrayMemberDelete.count
                        {
                            let dictAttendanceMembers:NSMutableDictionary=["FK_MemberID":muarrayMemberDelete.object(at: i)]
                            muarrayMembersDictArrayDelete.add(dictAttendanceMembers)
                        }
                        dictMemberDelete=["deletedMembers":muarrayMembersDictArrayDelete]
                    }
                    else
                    {
                        dictMemberDelete=["deletedMembers":muarrayMembersDictArrayDelete]
                    }
                    
                    
                    
                    let muarrayMemberSendServer:NSMutableArray=NSMutableArray()
                    dictMemberNew=["newMembers":muarrayMembersDictArray,"deletedMembers":muarrayMembersDictArrayDelete]
                    muarrayMemberSendServer.add(dictMemberNew)
                    
                    
                    
                    
                    
                    
                    
                    //2.
                    var AnnsCount:Int!=0
                    var muarrayAnnsDictArray:NSMutableArray=NSMutableArray()
                    var muarrayAnnsUpdateDictArray:NSMutableArray=NSMutableArray()
                    var dictAnnNew:NSMutableDictionary=NSMutableDictionary()
                    var dictAnnUpdate:NSMutableDictionary=NSMutableDictionary()
                    var dictAnnDelete:NSMutableDictionary=NSMutableDictionary()
                    
                    let muarrayAnnSendServer:NSMutableArray=NSMutableArray()
                    
                    if(myarrayHoldAnns.count>1)
                    {
                        AnnsCount=myarrayHoldAnns.count-1
                        for i in 00..<myarrayHoldAnns.count
                        {
                            if(i==0)
                            {
                                
                            }
                            else
                            {
                                //print(myarrayHoldAnns)
                                var muDictData:NSMutableDictionary=NSMutableDictionary()
                                muDictData=myarrayHoldAnns.object(at: i) as! NSMutableDictionary
                                let PK_AttendanceAnnsID:String!=muDictData.value(forKey: "PK_AttendanceAnnsID")as! String
                                let AnnsName:String!=muDictData.value(forKey: "AnnsName")as! String
                                
                                if(PK_AttendanceAnnsID.characters.count<=0)//new
                                {
                                    let dictAttendanceAnns:NSMutableDictionary=["AnnsName":AnnsName,"PK_AttendanceAnnsID":"0"]
                                    muarrayAnnsDictArray.add(dictAttendanceAnns)
                                }
                                else //update
                                {
                                    let dictAttendanceAnns:NSMutableDictionary=["AnnsName":AnnsName,"PK_AttendanceAnnsID":PK_AttendanceAnnsID]
                                    muarrayAnnsUpdateDictArray.add(dictAttendanceAnns)
                                }
                            }
                        }
                        
                        dictAnnNew=["newAnns":muarrayAnnsDictArray]
                        dictAnnUpdate=["UpdateAnns":muarrayAnnsUpdateDictArray]
                        
                    }
                    //Delete if any Aan deleted from existing
                    var dictAanDelete:NSMutableDictionary=NSMutableDictionary()
                    let muarrayAanDictArray:NSMutableArray=NSMutableArray()
                    if(muarrayAnnsDelete.count>0)
                    {
                        for i in 00..<muarrayAnnsDelete.count
                        {
                            let dictAttendanceMembers:NSMutableDictionary=["PK_AttendanceAnnsID":muarrayAnnsDelete.object(at: i)]
                            muarrayAanDictArray.add(dictAttendanceMembers)
                        }
                        dictAanDelete=["deletedAnns":muarrayAanDictArray]
                    }
                    else
                    {
                        dictAanDelete=["deletedAnns":muarrayAanDictArray]
                    }
                    
                    
                    var dictAnnsNew:NSMutableDictionary=NSMutableDictionary()
                    dictAnnsNew=["newAnns":muarrayAnnsDictArray,"UpdateAnns":muarrayAnnsUpdateDictArray,"deletedAnns":muarrayAanDictArray]
                    
                    
                    
                    muarrayAnnSendServer.add(dictAnnsNew)
                    
                    //3.
                    var AnnetsCount:Int!=0
                    var muarrayAnnetsDictArray:NSMutableArray=NSMutableArray()
                    var muarrayAnnetsUpdateDictArray:NSMutableArray=NSMutableArray()
                    var dictAnnestNew:NSMutableDictionary=NSMutableDictionary()
                    var dictAnnestUpdate:NSMutableDictionary=NSMutableDictionary()
                    let muarrayAnnetsSendServer:NSMutableArray=NSMutableArray()
                    
                    
                    print("This is count from annets !!!!!!!")
                    print(myarrayHoldAnnets)
                    
                    
                    if(myarrayHoldAnnets.count>1)
                    {
                        //print(myarrayHoldAnnets)
                        AnnetsCount=myarrayHoldAnnets.count-1
                        for i in 00..<myarrayHoldAnnets.count
                        {
                            if(i==0)
                            {
                                
                            }
                            else
                            {
                                var muDictData:NSMutableDictionary=NSMutableDictionary()
                                muDictData=myarrayHoldAnnets.object(at: i) as! NSMutableDictionary
                                let PK_AttendanceAnnetsID:String!=muDictData.value(forKey: "PK_AttendanceAnnetsID")as! String
                                let AnnetsName:String!=muDictData.value(forKey: "AnnetsName")as! String
                                //print(PK_AttendanceAnnetsID)
                                //print(AnnetsName)
                                
                                if(PK_AttendanceAnnetsID.characters.count<=0)//new
                                {
                                    let dictAttendanceAnnets:NSMutableDictionary=["AnnetsName":AnnetsName,"PK_AttendanceAnnetsID":"0"]
                                    muarrayAnnetsDictArray.add(dictAttendanceAnnets)
                                }
                                else //update
                                {
                                    let dictAttendanceAnnets:NSMutableDictionary=["AnnetsName":AnnetsName,"PK_AttendanceAnnetsID":PK_AttendanceAnnetsID]
                                    muarrayAnnetsUpdateDictArray.add(dictAttendanceAnnets)
                                }
                            }
                        }
                        dictAnnestNew=["newAnnets":muarrayAnnetsDictArray]
                        dictAnnestUpdate=["UpdateAnnets":muarrayAnnetsUpdateDictArray]
                    }
                    
                    //Delete if any Aan deleted from existing
                    var dictAanetsDelete:NSMutableDictionary=NSMutableDictionary()
                    let muarrayAanestDictArray:NSMutableArray=NSMutableArray()
                    //print(muarrayAnnetsDelete)
                    if(muarrayAnnetsDelete.count>0)
                    {
                        for i in 00..<muarrayAnnetsDelete.count
                        {
                            let dictAttendanceMembers:NSMutableDictionary=["PK_AttendanceAnnetsID":muarrayAnnetsDelete.object(at: i)]
                            muarrayAanestDictArray.add(dictAttendanceMembers)
                        }
                        dictAanetsDelete=["deletedAnnets":muarrayAanestDictArray]
                    }
                    else
                    {
                        dictAanetsDelete=["deletedAnnets":muarrayAanestDictArray]
                    }
                    //------
                    //print(dictAanetsDelete)
                    // muarrayAnnetsSendServer.add(dictAnnestNew)
                    //  muarrayAnnetsSendServer.add(dictAnnestUpdate)
                    //  muarrayAnnetsSendServer.add(dictAanetsDelete)
                    //print(muarrayAnnetsSendServer)
                    
                    
                    
                    
                    
                    var dictAnnetssNew:NSMutableDictionary=NSMutableDictionary()
                    dictAnnetssNew=["newAnnets":muarrayAnnetsDictArray,"UpdateAnnets":muarrayAnnetsUpdateDictArray,"deletedAnnets":muarrayAanestDictArray]
                    
                    muarrayAnnetsSendServer.add(dictAnnetssNew)
                    //print(muarrayAnnetsSendServer)

                    //4.
                    var VisitorsCount:Int!=0
                    
                    let muarrayVisitorsDictArray:NSMutableArray=NSMutableArray()
                    let muarrayVisitorsUpdateDictArray:NSMutableArray=NSMutableArray()
                    var dictVisitorsNew:NSMutableDictionary=NSMutableDictionary()
                    var dictVisitorsUpdate:NSMutableDictionary=NSMutableDictionary()
                    let muarrayVisitorsSendServer:NSMutableArray=NSMutableArray()
                    
                    if(myarrayHoldVisitors.count>1)
                    {
                        //print(myarrayHoldVisitors)
                        VisitorsCount=myarrayHoldVisitors.count-1
                        for i in 00..<myarrayHoldVisitors.count
                        {
                            if(i==0)
                            {
                                
                            }
                            else
                            {
                                //Visitors
                                var muDictData:NSMutableDictionary=NSMutableDictionary()
                                muDictData=myarrayHoldVisitors.object(at: i) as! NSMutableDictionary
                                
                                let PK_AttendanceVisitorID:String!=muDictData.value(forKey: "PK_AttendanceVisitorID")as! String
                                let VisitorsName:String!=muDictData.value(forKey: "VisitorsName")as! String
                                let Rotarian_whohas_Brought:String!=muDictData.value(forKey: "Rotarian_whohas_Brought")as! String
                                
                                if(PK_AttendanceVisitorID.characters.count<=0)//new
                                {
                                    let dictAttendanceVisitors:NSMutableDictionary=["VisitorsName":VisitorsName,"Rotarian_whohas_Brought":Rotarian_whohas_Brought,"PK_AttendanceVisitorID":"0"]
                                    muarrayVisitorsDictArray.add(dictAttendanceVisitors)
                                }
                                else //update
                                {
                                    let dictAttendanceVisitors:NSMutableDictionary=["VisitorsName":VisitorsName,"Rotarian_whohas_Brought":Rotarian_whohas_Brought,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                                    muarrayVisitorsUpdateDictArray.add(dictAttendanceVisitors)
                                }
                            }
                        }
                        dictVisitorsNew=["newVisitors":muarrayVisitorsDictArray]
                        dictVisitorsUpdate=["UpdateVisitors":muarrayVisitorsUpdateDictArray]
                    }
                    //Delete if any Aan deleted from existing
                    var dictVisitorsDelete:NSMutableDictionary=NSMutableDictionary()
                    let muarrayVisitorsSDictArray:NSMutableArray=NSMutableArray()
                    //print(muarrayVisitorsDelete)
                    if(muarrayVisitorsDelete.count>0)
                    {
                        for i in 00..<muarrayVisitorsDelete.count
                        {
                            let dictAttendanceVisitors:NSMutableDictionary=["PK_AttendanceVisitorID":muarrayVisitorsDelete.object(at: i)]
                            muarrayVisitorsSDictArray.add(dictAttendanceVisitors)
                        }
                        dictVisitorsDelete=["deletedVisitors":muarrayVisitorsSDictArray]
                    }
                    else
                    {
                        dictVisitorsDelete=["deletedVisitors":muarrayVisitorsSDictArray]
                    }
                    //------
                    
                    // muarrayVisitorsSendServer.add(dictVisitorsNew)
                    // muarrayVisitorsSendServer.add(dictVisitorsUpdate)
                    //  muarrayVisitorsSendServer.add(dictVisitorsDelete)
                    
                    
                    
                    
                    
                    var dictVisitorsSNew:NSMutableDictionary=NSMutableDictionary()
                    dictVisitorsSNew=["newVisitors":muarrayVisitorsDictArray,"UpdateVisitors":muarrayVisitorsUpdateDictArray,"deletedVisitors":muarrayVisitorsSDictArray]
                    
                    muarrayVisitorsSendServer.add(dictVisitorsSNew)
                    
                    
                    
                    
                    //print(muarrayVisitorsSendServer)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    /*
                     var muarrayRotarianDelete:NSMutableArray=NSMutableArray()
                     var muarrayRotarianServerIDDelete:NSMutableArray=NSMutableArray()
                     */
                    //5.
                    
                    //Rotarian
                    var RotarianCount:Int!=0
                    let muarrayRotarianDictArray:NSMutableArray=NSMutableArray()
                    let muarrayRotarianUpdateDictArray:NSMutableArray=NSMutableArray()
                    var dictRotarianNew:NSMutableDictionary=NSMutableDictionary()
                    var dictRotarianUpdate:NSMutableDictionary=NSMutableDictionary()
                    let muarrayRotarianSendServer:NSMutableArray=NSMutableArray()
                    if(myarrayHoldRotarian.count>1)
                    {
                        //print(myarrayHoldRotarian)
                        RotarianCount=myarrayHoldRotarian.count-1
                        for i in 00..<myarrayHoldRotarian.count
                        {
                            if(i==0)
                            {
                                
                            }
                            else
                            {
                                //Visitors
                                var muDictData:NSMutableDictionary=NSMutableDictionary()
                                muDictData=myarrayHoldRotarian.object(at: i) as! NSMutableDictionary
                                
                                let PK_AttendanceRotarianID:String!=muDictData.value(forKey: "PK_AttendanceRotarianID")as! String
                                let RotarianID:String!=muDictData.value(forKey: "RotarianID")as! String
                                let RotarianName:String!=muDictData.value(forKey: "RotarianName")as! String
                                let ClubName:String!=muDictData.value(forKey: "ClubName")as! String
                                /*
                                 "PK_AttendanceRotarianID": "0",
                                 "RotarianID": "R102New",
                                 "RotarianName": "RotName2New",
                                 "ClubName": "Club2New"
                                 */
                                if(PK_AttendanceRotarianID.characters.count<=0)//new
                                {
                                    let dictAttendanceRotarian:NSMutableDictionary=["PK_AttendanceRotarianID":"0","RotarianID":RotarianID,"RotarianName":RotarianName,"ClubName":ClubName]
                                    muarrayRotarianDictArray.add(dictAttendanceRotarian)
                                }
                                else //update
                                {
                                    let dictAttendanceRotarian:NSMutableDictionary=["PK_AttendanceRotarianID":PK_AttendanceRotarianID,"RotarianID":RotarianID,"RotarianName":RotarianName,"ClubName":ClubName]
                                    muarrayRotarianUpdateDictArray.add(dictAttendanceRotarian)
                                }
                            }
                        }
                        dictRotarianNew=["newRotarians":muarrayRotarianDictArray]
                        dictRotarianUpdate=["UpdateRotarians":muarrayRotarianUpdateDictArray]
                    }
                    //Delete if any Rotarian deleted from existing
                    var dictRotarianDelete:NSMutableDictionary=NSMutableDictionary()
                    let muarrayRotarianSDictArray:NSMutableArray=NSMutableArray()
                    //print(muarrayRotarianDelete)
                    if(muarrayRotarianDelete.count>0)
                    {
                        for i in 00..<muarrayRotarianDelete.count
                        {
                            let dictAttendanceRotarian:NSMutableDictionary=["PK_AttendanceRotarianID":muarrayRotarianDelete.object(at: i)]
                            muarrayRotarianSDictArray.add(dictAttendanceRotarian)
                        }
                        dictRotarianDelete=["deletedRotarians":muarrayRotarianSDictArray]
                    }
                    else
                    {
                        dictRotarianDelete=["deletedRotarians":muarrayRotarianSDictArray]
                    }
                    /*PK_AttendanceRotarianID
                     var muarrayRotarianDelete:NSMutableArray=NSMutableArray()
                     var muarrayRotarianServerIDDelete:NSMutableArray=NSMutableArray()
                     */
                    //5.
                    //Rotarian
                    //------
                    // muarrayRotarianSendServer.add(dictRotarianNew)
                    // muarrayRotarianSendServer.add(dictRotarianUpdate)
                    // muarrayRotarianSendServer.add(dictRotarianDelete)
                    // //print(muarrayRotarianSendServer)
                    
                    
                    
                    
                    var dictRotarianSNew:NSMutableDictionary=NSMutableDictionary()
                    dictRotarianSNew=["newRotarians":muarrayRotarianDictArray,"UpdateRotarians":muarrayRotarianUpdateDictArray,"deletedRotarians":muarrayRotarianSDictArray]
                    
                    muarrayRotarianSendServer.add(dictRotarianSNew)
                    
                    
                    
                    
                    
                    
                    //6.
                    
                    //District Delegates
                    var DistrictDelegatesCount:Int!=0
                    let muarrayDistrictDelegatesDictArray:NSMutableArray=NSMutableArray()
                    let muarrayDistrictDelegatesUpdateDictArray:NSMutableArray=NSMutableArray()
                    var dictDistrictDelegatesNew:NSMutableDictionary=NSMutableDictionary()
                    var dictDistrictDelegatesUpdate:NSMutableDictionary=NSMutableDictionary()
                    let muarrayDistrictDelegatesSendServer:NSMutableArray=NSMutableArray()
                    if(myarrayHoldDistrictDelegates.count>1)
                    {
                        //print(myarrayHoldDistrictDelegates)
                        DistrictDelegatesCount=myarrayHoldDistrictDelegates.count-1
                        for i in 00..<myarrayHoldDistrictDelegates.count
                        {
                            if(i==0)
                            {
                                
                            }
                            else
                            {
                                /*
                                 muDictData = ["RotarianID": "0", "RotarianName": "", "ClubName": "","FK_AttendanceID":"","PK_AttendanceRotarianID":""]
                                 
                                 */
                                //Visitors
                                var muDictData:NSMutableDictionary=NSMutableDictionary()
                                muDictData=myarrayHoldDistrictDelegates.object(at: i) as! NSMutableDictionary
                                
                                //print(muDictData)
                                
                                let PK_AttendanceDelegateID:String!=muDictData.value(forKey: "PK_AttendanceDelegateID")as! String
                                let DistrictDesignation:String!=muDictData.value(forKey: "DistrictDesignation")as! String
                                let RotarianName:String!=muDictData.value(forKey: "RotarianName")as! String
                                let ClubName:String!=muDictData.value(forKey: "ClubName")as! String
                                /*
                                 "PK_AttendanceRotarianID": "0",
                                 "RotarianID": "R102New",
                                 "RotarianName": "RotName2New",
                                 "ClubName": "Club2New"
                                 */
                                if(PK_AttendanceDelegateID.characters.count<=0)//new
                                {
                                    let dictAttendanceDistrictDelegates:NSMutableDictionary=["PK_AttendanceDelegateID":"0","RotarianName":RotarianName,"DistrictDesignation":DistrictDesignation,"ClubName":ClubName]
                                    muarrayDistrictDelegatesDictArray.add(dictAttendanceDistrictDelegates)
                                }
                                else //update
                                {
                                    let dictAttendanceDistrictDelegates:NSMutableDictionary=["PK_AttendanceDelegateID":PK_AttendanceDelegateID,"RotarianName":RotarianName,"DistrictDesignation":DistrictDesignation,"ClubName":ClubName]
                                    muarrayDistrictDelegatesUpdateDictArray.add(dictAttendanceDistrictDelegates)
                                }
                            }
                        }
                        dictDistrictDelegatesNew=["newDistrictDelegate":muarrayDistrictDelegatesDictArray]
                        dictDistrictDelegatesUpdate=["UpdateDistrictDelegate":muarrayDistrictDelegatesUpdateDictArray]
                    }
                    //Delete if any Rotarian deleted from existing
                    var dictDistrictDelegatesDelete:NSMutableDictionary=NSMutableDictionary()
                    let muarrayDistrictDelegatesSDictArray:NSMutableArray=NSMutableArray()
                    //print(muarrayDistrictDelegatesDelete)
                    if(muarrayDistrictDelegatesDelete.count>0)
                    {
                        for i in 00..<muarrayDistrictDelegatesDelete.count
                        {
                            let dictAttendanceRotarian:NSMutableDictionary=["PK_AttendanceDelegateID":muarrayDistrictDelegatesDelete.object(at: i)]
                            muarrayDistrictDelegatesSDictArray.add(dictAttendanceRotarian)
                        }
                        dictDistrictDelegatesDelete=["deletedDistrictDelegate":muarrayDistrictDelegatesSDictArray]
                    }
                    else
                    {
                        dictDistrictDelegatesDelete=["deletedDistrictDelegate":muarrayDistrictDelegatesSDictArray]
                    }
                    
                    
                    
                    
                    var dictDidDelegatesSNew:NSMutableDictionary=NSMutableDictionary()
                    dictDidDelegatesSNew=["newDistrictDelegate":muarrayDistrictDelegatesDictArray,"UpdateDistrictDelegate":muarrayDistrictDelegatesUpdateDictArray,"deletedDistrictDelegate":muarrayDistrictDelegatesSDictArray]
                    
                    muarrayDistrictDelegatesSendServer.add(dictDidDelegatesSNew)
                    //print(muarrayDistrictDelegatesSendServer)
                    //2.
                    //myy code
                    //                    let parametersteee = [
                    //                        "AttendanceMembers": muarrayDistrictDelegatesSendServer
                    //                        ] as [String : Any]
                    //                    let bytess = try! JSONSerialization.data(withJSONObject: parametersteee, options: JSONSerialization.WritingOptions.pretty//printed)
                    //                    if let strs = String(data: bytess, encoding: String.Encoding.utf8)
                    //                    {
                    //                        //print(strs)
                    //                    }
                    //                    else
                    //                    {
                    //                        //print("not a valid UTF-8 sequence")
                    //                    }
                    //
                    
                    
                    
                    
                    
                    
                    //print(DistrictDelegatesCount)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    //code for create main dictionary here
                    var mainParamDict:NSMutableDictionary=NSMutableDictionary()
                    
                    let completeURL = baseUrl+"Attendance/AttendanceAddEdit"
                    //1.
                    
                    //print(AttendanceID)
                    if(AttendanceID.characters.count>0)
                    {
                        //print("if")
                        //print(AttendanceID)
                    }
                    else
                    {
                        //print("else")
                        AttendanceID="0"
                        
                        
                    }
                    //print(AttendanceID)
                    
                    
                    mainParamDict=[
                        "AttendanceID": AttendanceID,
                        "AttendanceName": AttendanceName,
                        "AttendanceDate": AttendanceDate,
                        "AttendanceDesc": AttendanceDesc,
                        "Fk_group_id": Fk_group_id,
                        "fk_module_id": fk_module_id,
                        "created_by": created_by,
                        "modification_by": modification_by,
                        "deleted_by": deleted_by,
                        "FK_eventID": FK_eventID,
                        "MemberCount": MemberCount,
                        "AnnsCount": AnnsCount,
                        "AnnetsCount": AnnetsCount,
                        "VisitorsCount": VisitorsCount,
                        "RotarianCount": RotarianCount,
                        "DistrictDelegatesCount": DistrictDelegatesCount
                    ]
                    //2.
                    //myy code
                    let parameterst = [
                        "AttendanceAddEdit_Input": mainParamDict,
                        "AttendanceMembers": muarrayMemberSendServer,
                        "AttendanceAnns": muarrayAnnSendServer,
                        "AttendanceAnnets": muarrayAnnetsSendServer,
                        "AttendanceVisitors": muarrayVisitorsSendServer,
                        "AttendanceRotarians": muarrayRotarianSendServer,
                        "AttendanceDistrictDelegate": muarrayDistrictDelegatesSendServer
                        ] as [String : Any]
                    
                    
                    
                    //print(parameterst)
                    
                    /*
                     //print(muarrayMemberSendServer) //print(muarrayAnnSendServer)muarrayAnnetsSendServer
                     
                     */
                    
                    
                    
                    let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
                    var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
                    if let str = String(data: bytes, encoding: String.Encoding.utf8)
                    {
                        print("<<-----------------------------json start----------------------------->>")
                        print(str)
                        print("<<-----------------------------json end------------------------------->>")
                        
                    }
                    else
                    {
                        print("not a valid UTF-8 sequence")
                    }
                    //-code for proper JSON format ------™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™--------------------
                    //print(completeURL)
                    
                    ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                        //=> Handle server response
                        //print(response)
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
                        var messgae:String!=(dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "message") as! String
                        var status:String!=(dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "status") as! String
                        
                        
                        SVProgressHUD.dismiss()
                        if(status == "0" && messgae == "success")
                        {
                            let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "message")!
                            //print(arrarrNewGroupList)
                            
                            // Create the alert controller
                            
                            var alertController = UIAlertController()
                            
                            if(self.AttendanceID.characters.count>0 && self.AttendanceID != "0")
                            {
                                alertController = UIAlertController(title: "Rotary India", message: "Attendance updated successfully", preferredStyle: .alert)
                                
                            }
                            else
                            {
                                alertController = UIAlertController(title: "Rotary India", message: "Attendance added successfully", preferredStyle: .alert)
                            }
                            //print(self.varFrom)
                            // Create the actions
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                            {
                                UIAlertAction in
                                NSLog("OK Pressed")
                                if(self.varFrom=="FromSelectEvent")
                                {
                                    //print(self.varFrom)
                                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                                }
                                else if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
                                {
                                    //print(self.varFrom)
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else   if(status == "1" && messgae == "failed")
                        {
                            self.view.makeToast("1.Oops! Something went wrong. This request failed, please try again.", duration: 2, position: CSToastPositionCenter)
                            print("toast 1")
                      SVProgressHUD.dismiss()
                        
                        }
                        SVProgressHUD.dismiss()
                    }
                    })
                    
                }
            }
        }
    }
     @objc func backClicked()
    {
        if(varCustomViewReloadOrNot == "Not")
        {
        }
        else
        {
            self.customView.removeFromSuperview()
        }
        //print("call web api for adding this form value !!!!!")
        self.navigationController?.popViewController(animated: true)
    }
    var varWhichClicked:String!="0"
    
    /*-------------------------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row==1)
        {
            return 143.0
        }
        else
        {
            return 72.0
        }
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayNewEventAtt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NewEventAttendanceViewControllerTableViewCell
        if(muarrayNewEventAtt.count>0)
        {
            prototypeCells.viewFirst.isHidden=true
            prototypeCells.viewSecond.isHidden=true
            prototypeCells.viewThird.isHidden=true
            prototypeCells.viewFour.isHidden=true
            if(indexPath.row==0)
            {
                prototypeCells.viewFirst.isHidden=false
                prototypeCells.textfieldEventName.text=muarrayValue.object(at: 0)as! String
            }
            else  if(indexPath.row==1)
            {
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.textviewDescription.text=muarrayValue.object(at: 1)as! String
                
                var getValue:String!=muarrayValue.object(at: 1)as! String
                if isfromEdit
                {
                    prototypeCells.placeholderLabel.isHidden=true
                }
                else{
                    if (prototypeCells.textviewDescription.text.count > 0) {
                        prototypeCells.placeholderLabel.isHidden=true
                    } else {
                        prototypeCells.placeholderLabel.isHidden=false
                    }
                }
                
                
            }
            else  if(indexPath.row==2)
            {
                prototypeCells.viewThird.isHidden=false
                print("1@1@1 Cell for row date \(muarrayValue.object(at: 2)as! String)")
                prototypeCells.textfieldEventDate.text=muarrayValue.object(at: 2)as! String
            }
            else  if(indexPath.row==3)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            else  if(indexPath.row==4)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            else  if(indexPath.row==5)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            else  if(indexPath.row==6)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            else  if(indexPath.row==7)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            else  if(indexPath.row==8)
            {
                prototypeCells.viewFour.isHidden=false
                prototypeCells.labelTitle.text=muarrayNewEventAtt.object(at: indexPath.row) as! String
                prototypeCells.labelValue.text=muarrayValue.object(at: indexPath.row) as! String
            }
            prototypeCells.buttonMain.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonMainNewAttClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
            
            
            
            prototypeCells.buttonEventDate.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonEventDateClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonEventDate.tag = indexPath.row
            
            prototypeCells.buttonEventTime.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonEventTimeClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonEventTime.tag = indexPath.row
            
            
            prototypeCells.buttonRemoveDateAndTime.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonRemoveDateTimeClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonRemoveDateAndTime.tag = indexPath.row
            
            
            
            //
            /*
             @IBOutlet weak var buttonEventDate: UIButton!
             @IBOutlet weak var buttonEventTime: UIButton!
             */
        }
        return prototypeCells
    }
    
    @objc func buttonRemoveDateTimeClickEvent(_ sender:UIButton)
    {
        muarrayValue.replaceObject(at: 2, with: "")
        //print("rajendvbcvbcvbr jat code here")
        prototypeCells.textfieldEventDate.text=""
        tableviewNewEventAttendance.reloadData()
    }
    var varCustomViewReloadOrNot:String! = ""
    @objc func buttonEventDateClickEvent(_ sender:UIButton)
    {
        //print("Event Date clicked")
        
        tableviewNewEventAttendance.keyboardDismissMode = .interactive
        
        
        
        varCustomViewReloadOrNot = "Yes"
        //self.view.alpha=1
        buttonOpacity.isHidden=false
        textFieldSelectPublishDateAndTime()
    }
    var customView:SimpleCustomView!
    
    @IBOutlet weak var buttonOpacity: UIButton!
    func textFieldSelectPublishDateAndTime()
    {
        varCustomViewReloadOrNot = "Yes"
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "DateAndTime";
        varWhichClicked="PSD"
    }
    @objc func NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_ notification: Notification)
    {
        self.customView.removeFromSuperview()
        // buttonOpticity.hidden=true
    }
    @objc func NotificationIdentifierForGettingValue(_ notification: Notification)
    {
        
        self.customView.removeFromSuperview()
        let userInfo = notification.userInfo!
        let index = userInfo.index(userInfo.startIndex, offsetBy: 0) // index 1
        //print(userInfo.keys[index])
        var dictValue:NSDictionary = NSDictionary()
        dictValue = userInfo as NSDictionary
        //print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        if(varWhichClicked=="PSD")
        {
            var varGetPublishSelectDate=dictValue.value(forKey: "varUserFullNameFB") as! String
            var  varGetPSD=dictValue.value(forKey: "varUserFullNameFB") as! String//+":00"+" +0000"
            //print(varGetPSD)
            
            functionForCurrentDate()
            var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(currentdateForPSDMatch, stringSecondDate: varGetPSD)
        }
        buttonOpacity.isHidden=true
        muarrayValue.replaceObject(at: 2, with: dictValue.value(forKey: "varUserFullNameFB") as! String)
        print(" 1@1@1 Notification method date \(muarrayValue.object(at: 2)as! String)")
        
        //print("rajendr jat code here")
        //print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        //print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        
        //print(muarrayValue)
        
        prototypeCells.textfieldEventDate.text=dictValue.value(forKey: "varUserFullNameFB") as! String
        tableviewNewEventAttendance.reloadData()
    }
    func functionForCurrentDate()
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let currentdate = formatter.string(from: date)
        let varGetCellDateSelected = currentdate //+":00"+" +0000"
        currentdateForPSDMatch = varGetCellDateSelected
        //print(varGetCellDateSelected)
    }
    @objc func buttonEventTimeClickEvent(_ sender:UIButton)
    {
        //print("Event Time clicked")
    }
    
    /*---------------------------------------------------------------------------------*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        //print("111111")
        //print(muarrayValue.object(at: 0))
        //print(textField.text)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        var cursorPosition:Int!=0
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        //print(muarrayValue.object(at: 0))
        //print(textField.text)
        //print(string)
        
        if let selectedRange = textField.selectedTextRange
        {
            cursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
            //print("\(cursorPosition)")
        }
        if (isBackSpace == -92)
        {
            var varGetValue:String! =  muarrayValue.object(at: 0)as! String
            let index = varGetValue.index(varGetValue.startIndex, offsetBy: cursorPosition-1)
            varGetValue.remove(at: index)
            //print("This is real value after remove one character from string !!!!!")
            muarrayValue.replaceObject(at: 0, with: varGetValue)
            //print(muarrayValue)
            return true
        }
        else
        {
            let  varGetSearchBoxValue = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
            let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
            //print("rajendra")
            //print(strValues)
            muarrayValue.replaceObject(at: 0, with: strValues)
            //print(muarrayValue)
            return true
        }
        return true
    }
    func textFieldDidChange(_ textField: UITextField)
    {
        //print("33333")
        //print(muarrayValue.object(at: 0))
        //print(textField.text)
        if(textField.text!=="")
        {
            
        }
        else
        {
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
        tableviewNewEventAttendance.keyboardDismissMode = .onDrag
    }
    var currentdateForPSDMatch :String = ""
    
    var varSelectedTableRowIndexGet_Text:String!=""
    //--textview
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Run code here for when user ends editing text view
        prototypeCells.textviewDescription.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let  varGetSearchBoxValue = (textView.text! as NSString).replacingCharacters(in: range, with: text) as NSString as String
        let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        //print("rajendra")
        //print(strValues)
        if(strValues.length<=0)
          {
              print("if")
              print(prototypeCells.textviewDescription.text)
              //prototypeCells.textviewDescription.text = ""
              prototypeCells.placeholderLabel.isHidden=false
                tableviewNewEventAttendance.reloadData()
          }
          else
          {
              print("else")
              print(prototypeCells.textviewDescription.text)
              // prototypeCells.textviewDescription.text = "Enter Description..."
              prototypeCells.placeholderLabel.isHidden=true
              if(strValues.length==1) {
                  tableviewNewEventAttendance.reloadData()
              }
              
          }
        
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        
        if(text == "\n")
        {
            //textView.resignFirstResponder()
            prototypeCells.textviewDescription.resignFirstResponder()
            muarrayValue.replaceObject(at: 1, with: strValues)
            return true
        }
            
        else  if (isBackSpace == -92)
        {
            // //print(varSelectedTableRowIndexGet_Text)
            // //print(varSelectedTableRowIndexGet_Text.characters.count)
            // var varGetStringAfterRemove = strValues.substringToIndex(strValues.endIndex.predecessor())
            //print(strValues)
          
            muarrayValue.replaceObject(at: 1, with: strValues)
            return true
        }
        else
        {
            let pointInTable = textView.convert(textView.bounds.origin, to: tableviewNewEventAttendance)
            let indexPath = tableviewNewEventAttendance.indexPathForRow(at: pointInTable)?.row
            //print(indexPath)
            //print(indexPath)
            //print(indexPath)
            muarrayValue.replaceObject(at: 1, with: strValues)
            return true
        }
        
        print(strValues)
        print(strValues.length)

        print(prototypeCells.textviewDescription.text)

      if(strValues.length<=0)
        {
            print("if")
            print(prototypeCells.textviewDescription.text)
            //prototypeCells.textviewDescription.text = ""
            prototypeCells.placeholderLabel.isHidden=false
        }
        else
        {
            print("else")
            print(prototypeCells.textviewDescription.text)
            // prototypeCells.textviewDescription.text = "Enter Description..."
            prototypeCells.placeholderLabel.isHidden=true
            
        }
        
        
        
        
        tableviewNewEventAttendance.reloadData()
        
        return true
    }
    /*calling web api for getting event detail */
    //calling web services
    func functionForFetchingEventDetailData()
    {
        
        
        
        let completeURL = baseUrl+"Event/GetEventDetails"
        let parameterst = [
            "groupProfileID":varGrpProfileIDNewEventAttendance,
            "eventID":EventId,
            "grpId":grpIDNewEventAttendance
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            //print(response)
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
            if((dd.object(forKey: "EventsListDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                // let arrarrNewGroupList = (dd.objectForKey("EventListDetailResult")!.objectForKey("EventsListResult")!.objectForKey("EventList")) as! NSArray
                
                let arrarrNewGroupList = (dd.object(forKey: "EventsListDetailResult")! as AnyObject).object(forKey: "EventsDetailResult")!
                //print(arrarrNewGroupList)
                
                var dictTemporaryDictionary:NSDictionary=((dd.object(forKey: "EventsListDetailResult")! as AnyObject).object(forKey: "EventsDetailResult")! as AnyObject).object(at: 0)
                
                
                let EventTitle = (dictTemporaryDictionary.object(forKey: "EventsDetail")! as AnyObject).object(forKey: "eventTitle")!
                let EventDesc = (dictTemporaryDictionary.object(forKey: "EventsDetail")! as AnyObject).object(forKey: "eventDesc")!
                let EventDate = (dictTemporaryDictionary.object(forKey: "EventsDetail")! as AnyObject).object(forKey: "eventDate")!
                
                //print(EventTitle)
                //print(EventDesc)
                //print(EventDate)
                
                
                self.muarrayValue.replaceObject(at: 0, with: EventTitle)
                self.muarrayValue.replaceObject(at: 1, with: EventDesc)
                self.muarrayValue.replaceObject(at: 2, with: EventDate)
                print("1@1@1 Fetching Event details date \(self.muarrayValue.object(at: 2)as! String)")
                self.tableviewNewEventAttendance.reloadData()
            }
            else
            {
                //print("NO Result")
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    
    //----------------------------------------------------------------------------------------------------------------------
    @objc func buttonMainNewAttClickEvent(_ sender:UIButton)
    {
        //print(sender.tag)
        if(sender.tag==3)
        {
            //print("Members")
            
            //go to member screen
            //grpIDNewEventAttendance
            let objMemberListingNewViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListingNewViewController") as! MemberListingNewViewController
            objMemberListingNewViewController.grpIDMemberList=grpIDNewEventAttendance
            
            
            //print(myarrayHoldMember)
            //print(grpIDNewEventAttendance)
            
            objMemberListingNewViewController.objProtocol=self
            objMemberListingNewViewController.muarrayCheckUncheck=myarrayHoldMember
            self.navigationController?.pushViewController(objMemberListingNewViewController, animated: true)
        }
        else if(sender.tag==4)
        {
            //print("Anns")
            //print(myarrayHoldAnns)
            //print(AttendanceID)
            let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AnnsTableViewController") as! AnnsTableViewController
            objSelectEventFromListViewController.varWhichRowClicked="Anns"
            objSelectEventFromListViewController.muarrayListData=myarrayHoldAnns
            
            //print(myarrayHoldAnns)
            
            //print("working here by rajendra jat 27 june........")
            objSelectEventFromListViewController.objProtocol=self
            self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        }
        else if(sender.tag==5)
        {
            //print("Annsets")
            
            print(UserDefaults.standard.set(myarrayHoldAnnets, forKey: "session_arrayValue"))

            
            print(myarrayHoldAnnets)
            let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "AnnetsTableViewController") as! AnnetsTableViewController
            objSelectEventFromListViewController.varWhichRowClicked="Annets"
            objSelectEventFromListViewController.muarrayListDataassentsTemp=myarrayHoldAnnets
            
            
            print(UserDefaults.standard.set(myarrayHoldAnnets, forKey: "session_arrayValue"))
            
            
            
            
            objSelectEventFromListViewController.objProtocol=self
            self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        }
        else if(sender.tag==6)
        {
            //print("Visitors")
            
            let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "VisitorsTableViewController") as! VisitorsTableViewController
            objSelectEventFromListViewController.varWhichRowClicked="Visitors"
            //print(myarrayHoldVisitors)
            
            objSelectEventFromListViewController.muarrayListData=myarrayHoldVisitors
            objSelectEventFromListViewController.objProtocol=self
            self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        }
        else if(sender.tag==7)
        {
            //print("Rotarians (Other Club)")
            let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotariansOtherClubsTableViewController") as! RotariansOtherClubsTableViewController
            objSelectEventFromListViewController.varWhichRowClicked="Rotarian"
            
            //print(myarrayHoldRotarian)
            
            objSelectEventFromListViewController.muarrayListData=myarrayHoldRotarian
            objSelectEventFromListViewController.objProtocol=self
            
            self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        }
        else if(sender.tag==8)
        {
            //print("District Delegates")
            let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDelegatesTableViewController") as! DistrictDelegatesTableViewController
            objSelectEventFromListViewController.varWhichRowClicked="District Delegates"
            
            //print(myarrayHoldDistrictDelegates)
            
            objSelectEventFromListViewController.muarrayListData=myarrayHoldDistrictDelegates
            objSelectEventFromListViewController.objProtocol=self
            
            self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        }
    }
    //------------------------------------------------------------------------------------------------------------------------
    //---code for getting Anns list from server ....in update case
    //11111111111111111111111111 Members 11111111111111111111111111111
    func functionForFetchingMemberListingListData()
    {
        
        let completeURL = baseUrl+"Attendance/getAttendanceMemberDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"1"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
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
            if((dd.object(forKey: "TBAttendanceMemberDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceMemberDetailsResult")! as AnyObject).object(forKey: "AttendanceMemberResult")
                //print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldMember=NSMutableArray()
                    //  var muDictData:NSMutableDictionary=NSMutableDictionary()
                    //self.myarrayHoldAnns.add(muDictData)
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        let FK_MemberID:Int!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "FK_MemberID")as! Int
                        let getMemberId:String!=String(FK_MemberID)
                        self.myarrayHoldMember.add(getMemberId)
                        muarrayMemberServerIDDelete.add(getMemberId)
                    }
                    
                    //print(self.myarrayHoldMember)
                    /*
                     Designation = "";
                     "FK_MemberID" = 232120;
                     MemberName = AMOL;
                     image = "";
                     
                     
                     
                     myarrayHoldMember
                     */
                    
                }
                else
                {
                    
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHoldMember=NSMutableArray()
//                    self.myarrayHoldMember.add("0")
                    
                }
            }
            else if((dd.object(forKey: "TBAttendanceMemberDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
            {
                self.view.makeToast("Members", duration: 2, position: CSToastPositionTop)

                //self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                // the alert view
                 SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "2. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                print("toast 2")
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                   // self.navigationController?.popViewController(animated: true)

                    alert.dismiss(animated: true, completion: nil)
                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
               // {
                    //print(self.varFrom)
              //  }
                //print(self.varFrom)
                
            }
            
            self.alertController.dismiss(animated: true, completion: nil)
            SVProgressHUD.dismiss()
        }
        })
    }
    
    //22222222222222222222   Anns  2222222222222222222222222
    func functionForFetchingAnnsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceAnnsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"2"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as Any as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
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
            if((dd.object(forKey: "TBAttendanceAnnsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceAnnsDetailsResult")! as AnyObject).object(forKey: "AttendanceAnnsResult")
                //print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    //print(self.myarrayHoldAnns)
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldAnns=NSMutableArray()
                    var muDictData:NSMutableDictionary=NSMutableDictionary()
                    muDictData = ["AnnsName": "0", "Fk_AttendanceID": "","PK_AttendanceAnnsID":""]
                    self.myarrayHoldAnns.add(muDictData)
                    
                    
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        // let AnnsName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "AnnsName")as! String
                        // self.myarrayHoldAnns.add(AnnsName)
                        
                        let AnnsName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "AnnsName")as! String
                        let Fk_AttendanceID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "Fk_AttendanceID")as! String
                        let PK_AttendanceAnnsID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "PK_AttendanceAnnsID")as! String
                        /*
                         
                         
                         */
                        muDictData=["AnnsName":AnnsName,"Fk_AttendanceID":Fk_AttendanceID,"PK_AttendanceAnnsID":PK_AttendanceAnnsID]
                        self.myarrayHoldAnns.add(muDictData)
                        
                        muarrayAnnsServerIDDelete.add(PK_AttendanceAnnsID)
                        
                    }
                    //print(self.myarrayHoldAnns)
                    //print(muarrayAnnsServerIDDelete)
                }
                else
                {
                    
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHoldAnns=NSMutableArray()
//                    var muDictData:NSMutableDictionary=NSMutableDictionary()
//                    muDictData = ["AnnsName": "0", "Fk_AttendanceID": "","PK_AttendanceAnnsID":""]
//                    self.myarrayHoldAnns.add(muDictData)
                    // self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                }
            }
            else if((dd.object(forKey: "TBAttendanceAnnsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
                
            {
                self.view.makeToast("Ann", duration: 2, position: CSToastPositionCenter)

                //self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                // the alert view
                 SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "3. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                print("toast 3")
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                   // self.navigationController?.popViewController(animated: true)

                    alert.dismiss(animated: true, completion: nil)
                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
               // {
                    //print(self.varFrom)
               // }
                //print(self.varFrom)
            }
            self.functionForFetchingAnnetsListingListData()
            SVProgressHUD.dismiss()
         }
        })
    }
    
    //333333333333333333333333 Annets  333333333333333333333333333333333333
    func functionForFetchingAnnetsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceAnnetsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"3"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
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
            if((dd.object(forKey: "TBAttendanceAnnetsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceAnnetsDetailsResult")! as AnyObject).object(forKey: "AttendanceAnnetsResult")
                //print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    //print(self.myarrayHoldAnns)
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldAnnets=NSMutableArray()
                    // self.myarraybnmbnmHoldAnnets.add("0")
                    var muDictData:NSMutableDictionary=NSMutableDictionary()
                    muDictData = ["AnnetsName": "0", "Fk_AttendanceID": "","PK_AttendanceAnnetsID":""]
                    self.myarrayHoldAnnets.add(muDictData)
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        // let AnnetsName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "AnnetsName")as! String
                        
                        /*
                         AnnetsName = Reema;
                         "Fk_AttendanceID" = 11;
                         "PK_AttendanceAnnetsID" = 20;
                         // muDictData = ["AnnetsName": "0", "FK_AttendanceID": "","PK_AttendanceVisitorID":""]
                         */
                        
                        //-------------
                        let AnnetsName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "AnnetsName")as! String
                        let Fk_AttendanceID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "Fk_AttendanceID")as! String
                        let PK_AttendanceAnnetsID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "PK_AttendanceAnnetsID")as! String
                        /*
                         
                         
                         */
                        
                        muarrayAnnetsServerIDDelete.add(PK_AttendanceAnnetsID)
                        muDictData=["AnnetsName":AnnetsName,"Fk_AttendanceID":Fk_AttendanceID,"PK_AttendanceAnnetsID":PK_AttendanceAnnetsID]
                        self.myarrayHoldAnnets.add(muDictData)
                        
                    }
                    //print(self.myarrayHbnmoldAnnets)
                }
                else
                {
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHonm,ldAnnets=NSMutableArray()
//                    // self.myarrayHvbnvbnoldAnnets.add("0")
//                    var muDictData:NSMutableDictionary=NSMutableDictionary()
//                    muDictData = ["AnnetsName": "0", "Fk_AttendanceID": "","PK_AttendanceAnnetsID":""]
//                    self.myarrayHbnmnboldAnnets.add(muDictData)
                    //  self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                }
            }
            else if((dd.object(forKey: "TBAttendanceAnnetsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
                
            {
                self.view.makeToast("Annets", duration: 2, position: CSToastPositionBottom)

                //self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                // the alert view
                 SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "4. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                print("toast 4")
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                 //   self.navigationController?.popViewController(animated: true)

                    alert.dismiss(animated: true, completion: nil)
                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
              //  {
                    //print(self.varFrom)
               // }
                //print(self.varFrom)
            }
            self.functionForFetchingVisitorsListingListData()
            SVProgressHUD.dismiss()
        }
        })
    }
    
    //444444444444444444444444 visitore  444444444444444444444444
    func functionForFetchingVisitorsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceVisitorsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"4"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
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
            if((dd.object(forKey: "TBAttendanceVisitorsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceVisitorsDetailsResult")! as AnyObject).object(forKey: "AttendanceVisitorsResult")
                //print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldVisitors=NSMutableArray()
                    var muDictData:NSMutableDictionary=NSMutableDictionary()
                    muDictData=["VisitorsName":"","Rotarian_whohas_Brought":"","FK_AttendanceID":"","PK_AttendanceVisitorID":""]
                    self.myarrayHoldVisitors.add(muDictData)
                    
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        let VisitorsName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "VisitorsName")as! String
                        let Rotarian_whohas_Brought:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "Rotarian_whohas_Brought")as! String
                        let FK_AttendanceID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "FK_AttendanceID")as! String
                        let PK_AttendanceVisitorID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "PK_AttendanceVisitorID")as! String
                        /*
                         "FK_AttendanceID" = 11;
                         "PK_AttendanceVisitorID" = 15;
                         */
                        muarrayVisitorsServerIDDelete.add(PK_AttendanceVisitorID)
                        muDictData=["VisitorsName":VisitorsName,"Rotarian_whohas_Brought":Rotarian_whohas_Brought,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                        self.myarrayHoldVisitors.add(muDictData)
                    }
                    //print(muarrayVisitorsServerIDDelete)
                }
                else
                {
                    //here need to work if empty then leave it
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHoldVisitors=NSMutableArray()
//                    var muDictData:NSMutableDictionary=NSMutableDictionary()
//                    muDictData=["VisitorsName":"","Rotarian_whohas_Brought":"","FK_AttendanceID":"","PK_AttendanceVisitorID":""]
//                    self.myarrayHoldVisitors.add(muDictData)
                    // self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                }
            }
            else if((dd.object(forKey: "TBAttendanceVisitorsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
                
            {
                self.view.makeToast("Visitors", duration: 2, position: CSToastPositionBottom)
 SVProgressHUD.dismiss()
                //self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                // the alert view
                let alert = UIAlertController(title: "", message: "5. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                print("toast 5")
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                  //  self.navigationController?.popViewController(animated: true)

                    alert.dismiss(animated: true, completion: nil)
                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
              //  {
                    //print(self.varFrom)
               // }
                //print(self.varFrom)
            }
            self.functionForFetchingRotarianListingListData()
            SVProgressHUD.dismiss()
        }
        })
    }
    //5555555555555  Rotarian other club 5555555555555555555555555555555555555
    func functionForFetchingRotarianListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceRotariansDetails"
        let parameterst = [
            "AttendanceID":AttendanceID!,
            "type":"5"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as Any as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
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
            if((dd.object(forKey: "TBAttendanceRotariansDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceRotariansDetailsResult")! as AnyObject).object(forKey: "AttendanceRotariansResult")
                //print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldRotarian=NSMutableArray()
                    self.myarrayHoldRotarian.add("0")
                    var muDictData:NSMutableDictionary=NSMutableDictionary()
                    // muDictData=["RotarianName":"","ClubName":"","RotarianID":""]
                    
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        let RotarianName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "RotarianName")as! String
                        let ClubName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "ClubName")as! String
                        let RotarianID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "RotarianID")as! String
                        let FK_AttendanceID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "FK_AttendanceID")as! String
                        let PK_AttendanceRotarianID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "PK_AttendanceRotarianID")as! String
                        
                        ///"FK_AttendanceID" = 11;
                        //"PK_AttendanceRotarianID" = 17;
                        muDictData=["RotarianName":RotarianName,"ClubName":ClubName,"RotarianID":RotarianID,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID]
                        self.myarrayHoldRotarian.add(muDictData)
                        muarrayRotarianServerIDDelete.add(PK_AttendanceRotarianID)
                    }
                    //print(self.myarrayHoldRotarian)
                    //print(muarrayRotarianServerIDDelete)
                    
                }
                else
                {
                    //here need to work if empty then leave it
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHoldRotarian=NSMutableArray()
//                    self.myarrayHoldRotarian.add("0")
//                    var muDictData:NSMutableDictionary=NSMutableDictionary()
//                    // muDictData=["RotarianName":"","ClubName":"","RotarianID":""]
                    // self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                }
            }
            else if((dd.object(forKey: "TBAttendanceRotariansDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
            {
                self.view.makeToast("Rotarians", duration: 2, position: CSToastPositionCenter)

                //  message = "Record not found";
                // status = 0;
                //self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                // the alert view
                 SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "6. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                print("toast 6")
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                   // self.navigationController?.popViewController(animated: true)

                    alert.dismiss(animated: true, completion: nil)

                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
               // {
                    //print(self.varFrom)
               // }
                //print(self.varFrom)
            }
            self.functionForFetchingdistrictdelegatesListingListData()
            SVProgressHUD.dismiss()
        }
        })
    }
    //66666666666666666666666666666666666666666 District Delegates 666666666666666666666666666666666666
    func functionForFetchingdistrictdelegatesListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceDistrictDeleagateDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"6"
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            let dd = response as! NSDictionary
            //print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBAttendanceDistrictDeleagateDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceDistrictDeleagateDetailsResult")! as AnyObject).object(forKey: "AttendanceDistrictDeleagateResult")
                //print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    
                    //here need to work if empty then leave it
                    var muarrayTemp:NSArray=NSArray()
                    muarrayTemp=arrarrNewGroupList as! NSArray
                    self.myarrayHoldDistrictDelegates=NSMutableArray()
                    self.myarrayHoldDistrictDelegates.add("0")
                    var muDictData:NSMutableDictionary=NSMutableDictionary()
                    // muDictData=["RotarianName":"","ClubName":"","RotarianID":""]
                    
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        let RotarianName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "RotarianName")as! String
                        let DistrictDesignation:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "DistrictDesignation")as! String
                        let ClubName:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "ClubName")as! String
                        let FK_AttendanceID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "FK_AttendanceID")as! String
                        let PK_AttendanceDelegateID:String!=(muarrayTemp.object(at: i) as AnyObject).value(forKey: "PK_AttendanceDelegateID")as! String
                        
                        
                        // "FK_AttendanceID" = 11;
                        //"PK_AttendanceDelegateID" = 14;
                        muDictData=["RotarianName":RotarianName,"DistrictDesignation":DistrictDesignation,"ClubName":ClubName,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceDelegateID":PK_AttendanceDelegateID]
                        self.myarrayHoldDistrictDelegates.add(muDictData)
                        
                        muarrayDistrictDelegatesServerIDDelete.add(PK_AttendanceDelegateID)
                        
                    }
                    //print(self.myarrayHoldDistrictDelegates)
                    //print(muarrayDistrictDelegatesServerIDDelete)
                }
                else
                {
//                    here need to work if empty then leave it
//                    var muarrayTemp:NSArray=NSArray()
//                    muarrayTemp=arrarrNewGroupList as! NSArray
//                    self.myarrayHoldDistrictDelegates=NSMutableArray()
//                    self.myarrayHoldDistrictDelegates.add("0")
//                    var muDictData:NSMutableDictionary=NSMutableDictionary()
//                    // muDictData=["RotarianName":"","ClubName":"","RotarianID":""]
                    // self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
                }
            }
            else if((dd.object(forKey: "TBAttendanceDistrictDeleagateDetailsResult")! as AnyObject).object(forKey: "status") as! String == "1")
                
            {
                 SVProgressHUD.dismiss()
                self.view.makeToast("District delegates", duration: 2, position: CSToastPositionTop)
                // the alert view
                let alert = UIAlertController(title: "", message: "7. Oops! Something went wrong. This request failed, please try again.", preferredStyle: .alert)
                print("toast 7")
                self.present(alert, animated: true, completion: nil)
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    // your code with delay
                   // self.navigationController?.popViewController(animated: true)
                    alert.dismiss(animated: true, completion: nil)
                     SVProgressHUD.dismiss()
                }
               // if(self.varFrom=="fromAttendance" || self.varFrom=="FromAttendanceEdit")
               // {
                    //print(self.varFrom)
                
               // }
                //print(self.varFrom)
            }
            self.functionForFetchingMemberListingListData()
            SVProgressHUD.dismiss()
        }
        })
    }
}
