//
//  SelectEventFromListViewController.swift
//  TouchBase
//
//  Created by rajendra on 08/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Alamofire
class SelectEventFromListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    var grpIDSelectEventFromList: String!=""
    var varModuleIdSelectEventFromList:String!=""
    var moduleNameSelectEventFromList:String!=""
    var isAdminSelectEventFromList:String! = ""
    var varGrpProfileIDSelectEventFromList:String! = ""
    
    
    
    @IBOutlet var tableviewSelectEventFromList: UITableView!
    
    
    var prototypeCells:MonthlyReportDetailTableViewCell=MonthlyReportDetailTableViewCell()
    let reuseIdentifier = "cell"
    
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(grpIDSelectEventFromList)
        print(varModuleIdSelectEventFromList)
        print(moduleNameSelectEventFromList)
        print(isAdminSelectEventFromList)
        print(varGrpProfileIDSelectEventFromList)

        // print(monthYear)
//        self.edgesForExtendedLayout=[]
    
        functionForCreaqteNavigation()
        functionForFetchingMonthlyReportDetailListData()
    }
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = "Select Event"
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
       // buttonleft.setButtonFullBorder()
       // buttonleft.setTitleColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0)

        buttonleft.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        
       
        buttonleft.layer.cornerRadius = 5
        buttonleft.layer.borderWidth = 1
        buttonleft.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        
       // buttonleft.setImage(UIImage(named:"back_btn_blue"), forState: UIControl.State.Normal)
        buttonleft.addTarget(self, action: #selector(AttendanceViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
     
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
            
            
            /*
             "eventID": "1959",
             "eventTitle": "Event testing",
             "eventDesc": "Test",
             "eventDateTime": "18-Jul-2018 18:07:00"
             */
            
            
            print(((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventTitle"))
            prototypeCells.labelDetail.text=((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventTitle") as! String
            let varGetDateandTime:String!=((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventDateTime") as! String
            prototypeCells.labelDateTime.text=varGetDateandTime
            
            prototypeCells.buttonMain.addTarget(self, action: #selector(SelectEventFromListViewController.buttonEventDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
        }
        return prototypeCells
    }
    
    @objc func buttonEventDetailClickEvent(_ sender:UIButton)
    {
        /*
        print(sender.tag)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventDateTime"))
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventID") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventImg") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventTitle") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "filterType") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "goingCount") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "grpAdminId") as! String)

        
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "grpID"))
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "isRead") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "maybeCount") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "myResponse") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "notgoingCount") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "venue") as! String)
        
        
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "venueLat") as! String)
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "venueLon") as! String)
        */
        /*
         eventDateTime = "09 Jun 2018 06:10 PM";
         eventID = 1912;
         eventImg = "";
         eventTitle = Attendance;
         filterType = 1;
         goingCount = "";
         grpAdminId = 255671;
         grpID = 2765;
         isRead = Yes;
         maybeCount = "";
         myResponse = "";
         notgoingCount = "";
         venue = Thane;
         venueLat = "0.0";
         venueLon = "0.0";
         */
        
        
        let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewEventAttendanceViewController") as! NewEventAttendanceViewController
        objSelectEventFromListViewController.grpIDNewEventAttendance=grpIDSelectEventFromList
        objSelectEventFromListViewController.varModuleIdNewEventAttendance=varModuleIdSelectEventFromList
        objSelectEventFromListViewController.moduleNameNewEventAttendance=moduleNameSelectEventFromList
        objSelectEventFromListViewController.isAdminNewEventAttendance=isAdminSelectEventFromList
        objSelectEventFromListViewController.varGrpProfileIDNewEventAttendance=varGrpProfileIDSelectEventFromList
        
        print(((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventID") as! String)
        objSelectEventFromListViewController.EventId=((muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "AttendanceResult")! as AnyObject).value(forKey: "eventID") as! String

        
        //EventId
        objSelectEventFromListViewController.varFrom="FromSelectEvent"

        self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        

        
    }
    
    //calling web services
    func functionForFetchingMonthlyReportDetailListData()
    {
        print(grpIDSelectEventFromList)
        print(varModuleIdSelectEventFromList)
        print(moduleNameSelectEventFromList)
        print(isAdminSelectEventFromList)
        print(varGrpProfileIDSelectEventFromList)
        
       // loaderViewMethod()
        
      //  let completeURL = baseUrl+"Event/GetEventList"
        let completeURL = baseUrl+"Attendance/GetAttendanceEventsListNew"

        let parameterst = [
            //"groupProfileID":varGrpProfileIDSelectEventFromList,
            "groupID":grpIDSelectEventFromList,
            "Type":"0",
            //"Admin":"1",
            "searchText":""
        ]
        
        
      
        
        
        
        
        
        print(parameterst)
        print(completeURL)
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
            if((dd.object(forKey: "TBAttendanceEventsListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
               // let arrarrNewGroupList = (dd.objectForKey("EventListDetailResult")!.objectForKey("EventsListResult")!.objectForKey("EventList")) as! NSArray
                
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceEventsListResult")! as AnyObject).object(forKey: "AttendanceEventsListResult")!
                print(arrarrNewGroupList)
                
                let arrarrNewGroupLists = ((dd.object(forKey: "TBAttendanceEventsListResult")! as AnyObject).object(forKey: "AttendanceEventsListResult")! as AnyObject).object(at: 0)
                print(arrarrNewGroupLists)
                
              
                self.muarrayMainList = arrarrNewGroupList as! NSArray
                self.muarrayListData = arrarrNewGroupList as! NSArray
                print(self.muarrayMainList)
                self.tableviewSelectEventFromList.reloadData()
                self.window=nil
            }
            else
            {
                print("NO Result")
                self.window=nil
            }
            SVProgressHUD.dismiss()
        }
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
