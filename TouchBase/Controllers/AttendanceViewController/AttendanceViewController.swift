//
//  AttendanceViewController.swift
//  TouchBase
//
//  Created by Umesh on 10/10/16.
//  Copyright © 2016 Parag. All rights reserved.
//

/*
 API for Attendance :-
 
 Get Attendance List
 
 Marvel url - https://marvelapp.com/2egh2f8/screen/39763112
 
 Input parameter –
 {
 “Master_id” : ”124”, ”module_id” : ” ”, ”grpId” : ” ”, ”profile_id” : ” ”
 }
 
 Output -
 {
 “status” :"0", “message” = "success" ,
 ”event_list”: [
 {“event_id”:”1”,”event_title”:””,”datetime”:”17 may 2018 11:54 AM”} ,
 {“event_id”:”2”,”event_title”:””,”datetime”:”17 may 2018 11:54 AM”}
 
 ]
 }
 
 */

import UIKit
import Alamofire
import SVProgressHUD
class AttendanceViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate
{
    
    @IBOutlet weak var labelMessgae: UILabel!
    
    var grpIDAttendance: String!=""
    var varModuleIdAttendance:String!=""
    var moduleNameAttendance:String!=""
    var isAdminAttendance:String! = ""
    var varGrpProfileID:String! = ""
    @IBOutlet var attendanceTblView: UITableView!
    @IBOutlet var pickerView:UIPickerView!
    
    
    
    
    var prototypeCells:MonthlyReportDetailTableViewCell=MonthlyReportDetailTableViewCell()
    let reuseIdentifier = "cell"
    var pickerDataSource = [ "Select Option","Select Event From List", "New Event"];
    
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        
         let myarrayHoldAnnets:NSMutableArray=NSMutableArray()
         UserDefaults.standard.set(myarrayHoldAnnets, forKey: "session_arrayValue")
        
        
        
        pickerDataSource = [ "Select Option","Select Event From List", "New Event"];
        pickerView.reloadAllComponents()
        pickerView.reloadComponent(0)
        
        
        functionForCreaqteNavigation()
        functionForFetchingMonthlyReportDetailListData()
        
        
        print("this is picker reload or refresh !!!!!!")
        self.view.endEditing(false)
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.reloadAllComponents();
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // loaderViewMethod()
        print(grpIDAttendance)
        print(varModuleIdAttendance)
        print(moduleNameAttendance)
        print(isAdminAttendance)
        // print(monthYear)
//        self.edgesForExtendedLayout=[]
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
      self.labelMessgae.isHidden=true
        
    }
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = moduleNameAttendance
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
        buttonleft.addTarget(self, action: #selector(AttendanceViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        if isAdminAttendance == "Yes"{
            let editB = UIButton(type: UIButton.ButtonType.custom)
            editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            editB.setImage(UIImage(named:"add_blue"),  for: UIControl.State.normal)
            //        editB.addTarget(self, action: #selector(AttendanceViewController.buttonOpenPicker), for: UIControl.Event.touchUpInside)
            editB.addTarget(self, action: #selector(AttendanceViewController.functionForGoToNewEvent), for: UIControl.Event.touchUpInside)
            let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
            let buttons : NSArray = [edit]
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func buttonOpenPicker()
    {
        pickerView.isHidden=false
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDataSource.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //did select
        if(row==1)
        {
            print("Select Event From List")
            pickerView.isHidden=true
            functionForGoToSelectEventList()
        }
        else if(row==2)
        {
            print("New Event")
            pickerView.isHidden=true
            functionForGoToNewEvent()
        }
        
    }
    func functionForGoToSelectEventList()
    {
        
        let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectEventFromListViewController") as! SelectEventFromListViewController
        objSelectEventFromListViewController.grpIDSelectEventFromList=grpIDAttendance
        objSelectEventFromListViewController.varModuleIdSelectEventFromList=varModuleIdAttendance
        objSelectEventFromListViewController.moduleNameSelectEventFromList=moduleNameAttendance
        objSelectEventFromListViewController.isAdminSelectEventFromList=isAdminAttendance
        objSelectEventFromListViewController.varGrpProfileIDSelectEventFromList=varGrpProfileID
        
        self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
    }
    
    @objc func functionForGoToNewEvent()
    {
        
        let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewEventAttendanceViewController") as! NewEventAttendanceViewController
        objSelectEventFromListViewController.grpIDNewEventAttendance=grpIDAttendance
        objSelectEventFromListViewController.varModuleIdNewEventAttendance=varModuleIdAttendance
        objSelectEventFromListViewController.moduleNameNewEventAttendance=moduleNameAttendance
        objSelectEventFromListViewController.isAdminNewEventAttendance=isAdminAttendance
        objSelectEventFromListViewController.varGrpProfileIDNewEventAttendance=varGrpProfileID
        objSelectEventFromListViewController.varFrom="fromAttendance"
        self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 74.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MonthlyReportDetailTableViewCell
        if(muarrayListData.count>0)
        {
            print(((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "AttendanceName"))
            prototypeCells.labelDetail.text=((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "AttendanceName") as! String
            print(muarrayListData)
            let varGetDate:String!=((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "AttendanceDate") as! String
            let varGetTime:String!=((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "Attendancetime") as! String
            let varGetDateandTime:String!=varGetDate+" "+varGetTime
            prototypeCells.labelDateTime.text=varGetDateandTime
            prototypeCells.buttonMain.addTarget(self, action: #selector(AttendanceViewController.buttonAttendanceClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
        }
        return prototypeCells
    }

    @objc func buttonAttendanceClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "AttendanceName"))
        let objAttendanceEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceEditViewController") as! AttendanceEditViewController
        objAttendanceEditViewController.grpIDAttendanceEdit=grpIDAttendance
        objAttendanceEditViewController.ModuleIdAttendanceEdit=varModuleIdAttendance
        objAttendanceEditViewController.moduleNameAttendanceEdit=moduleNameAttendance
        objAttendanceEditViewController.isAdminAttendanceEdit=isAdminAttendance
        objAttendanceEditViewController.GrpProfileIDAttendanceEdit=varGrpProfileID
        objAttendanceEditViewController.AttendanceID=((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "AttendanceID") as! String
        self.navigationController?.pushViewController(objAttendanceEditViewController, animated: true)

        /*
        let objSelectEventFromListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewEventAttendanceViewController") as! NewEventAttendanceViewController
        objSelectEventFromListViewController.grpIDNewEventAttendance=grpIDAttendance
        objSelectEventFromListViewController.varModuleIdNewEventAttendance=varModuleIdAttendance
        objSelectEventFromListViewController.moduleNameNewEventAttendance=moduleNameAttendance
        objSelectEventFromListViewController.isAdminNewEventAttendance=isAdminAttendance
        objSelectEventFromListViewController.varGrpProfileIDNewEventAttendance=varGrpProfileID
        objSelectEventFromListViewController.varFrom="FrofghmAttendanceEditbbbbbbbbbbbbbbbbbbbbbbbbb"
        self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        */
    }
    
    //calling web services
    func functionForFetchingMonthlyReportDetailListData()
    {
        
        let getProfileID:String!=varGrpProfileID as! String
        
        let completeURL = baseUrl+"Attendance/GetAttendanceListNew"
        let parameterst = [
            
             "groupProfileID":getProfileID,
             "groupID":grpIDAttendance!
            /*
            "groupProfileID":"1",
            "groupID":"11111"
 */
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            let dd = response as! NSDictionary
            //  print("dd \(dd)")
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
             self.window=nil
                
                 SVProgressHUD.dismiss()
            }
            else
            {
                if((response.value(forKey: "TBAttendanceListResult")! as AnyObject).value(forKey: "status") as! String == "1")
                {
                      self.window=nil
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
 SVProgressHUD.dismiss()
                }
                else
                {
                    if((dd.object(forKey: "TBAttendanceListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                    {
                        // let arrarrNewGroupList = (dd.objectForKey("EventListDetailResult")!.objectForKey("EventsListResult")!.objectForKey("EventList")) as! NSArray
                        self.labelMessgae.text=""
                        let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceListResult")! as AnyObject).object(forKey: "AttendanceListResult")!
                        print(arrarrNewGroupList)
                        if((arrarrNewGroupList as AnyObject).count>0)
                        {
                            let arrarrNewGroupLists = ((dd.object(forKey: "TBAttendanceListResult")! as AnyObject).object(forKey: "AttendanceListResult")! as AnyObject).object(at: 0)
                        print(arrarrNewGroupLists)
                        
                        
                        self.muarrayMainList = arrarrNewGroupList as! NSArray
                        self.muarrayListData = arrarrNewGroupList as! NSArray
                        print(self.muarrayMainList)
                        self.attendanceTblView.reloadData()
                             self.window=nil
                        }
                        else
                        {
                            self.labelMessgae.isHidden=false
                            //give message for No Record Found
                            self.labelMessgae.text="No Record Found"
                          //  self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                             self.window=nil
                            
                            //muarrayListData
                            self.muarrayMainList = NSMutableArray()
                            self.muarrayListData = NSMutableArray()
                            print(self.muarrayMainList)
                            self.attendanceTblView.reloadData()
                            self.window=nil
                            SVProgressHUD.dismiss()
                            
                        }
                    }
                    else
                    {
                        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                        self.window=nil
                        
                         SVProgressHUD.dismiss()
                    }
                }
            }
            SVProgressHUD.dismiss()
        })
        
    }
    //MARK:- Loader Method
     var window: UIWindow?
    /*
    func loaderViewMethod()
    {
        let screenSize: CGRect = UIScreen.main.bounds

        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        //                gifView.contentMode = .Center
        Loadingview.addSubview(gifView)
        window?.addSubview(Loadingview)
        
    }
    */
}
