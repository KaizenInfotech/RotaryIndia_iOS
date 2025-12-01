//
//  AttendanceEditViewController.swift
//  TouchBase
//
//  Created by rajendra on 19/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class AttendanceEditViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var grpIDAttendanceEdit: String!=""
    var ModuleIdAttendanceEdit:String!=""
    var moduleNameAttendanceEdit:String!=""
    var isAdminAttendanceEdit:String! = ""
    var GrpProfileIDAttendanceEdit:String! = ""
    var EventIdAttendanceEdit:String!=""
    var varFrom:String! = ""
    var AttendanceID:String! = ""
    
    //
    
    var prototypeCells:AttendanceEditTableViewCell=AttendanceEditTableViewCell()
    let reuseIdentifier = "cell"
    
    
    
    
    @IBOutlet weak var tableviewEditAttendance: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        functionForFetchingAttendanceDetailData()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableviewEditAttendance.isHidden=true
        functionForCreaqteNavigation()
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    /*------------*/
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = moduleNameAttendanceEdit
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
        buttonleft.addTarget(self, action: #selector(AttendanceEditViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(AttendanceEditViewController.buttonEditClickEvent), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        let deleteB = UIButton(type: UIButton.ButtonType.custom)
        deleteB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        deleteB.setImage(UIImage(named:"delete20x20"),  for: UIControl.State.normal)
        deleteB.addTarget(self, action: #selector(AttendanceEditViewController.buttonDeleteClickEvent), for: UIControl.Event.touchUpInside)
        let delete: UIBarButtonItem = UIBarButtonItem(customView: deleteB)
        let buttons : NSArray = [delete,edit]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
    
   @objc func  buttonDeleteClickEvent()
    {
        //call web api for deleting attendance and back to main controller
        print("Are you sure you want to delete ?")
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Message", message: "Are you sure you want to delete ?", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Yes", style: .cancel) { _ in
            print("Yes")
            self.functionForDeletingAttendance()
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "No", style: .default)
        { _ in
            print("No")
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func  buttonEditClickEvent()
    {
        print("Edit button Clicked!!!!")
        let objSelectEventFromListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewEventAttendanceViewController") as! NewEventAttendanceViewController
        objSelectEventFromListViewController.grpIDNewEventAttendance=grpIDAttendanceEdit
        objSelectEventFromListViewController.varModuleIdNewEventAttendance=ModuleIdAttendanceEdit
        objSelectEventFromListViewController.moduleNameNewEventAttendance=moduleNameAttendanceEdit
        objSelectEventFromListViewController.isAdminNewEventAttendance=isAdminAttendanceEdit
        objSelectEventFromListViewController.varGrpProfileIDNewEventAttendance=GrpProfileIDAttendanceEdit
        objSelectEventFromListViewController.isfromEdit = true
        
        
       print(mudict.value(forKey: "AttendanceID"))
        
        objSelectEventFromListViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
        objSelectEventFromListViewController.varFrom="FromAttendanceEdit"
        self.navigationController?.pushViewController(objSelectEventFromListViewController, animated: true)
        
        //AttendanceID
        /*
         
         var grpIDAttendanceEdit: String!=""
         var ModuleIdAttendanceEdit:String!=""
         var moduleNameAttendanceEdit:String!=""
         var isAdminAttendanceEdit:String! = ""
         var GrpProfileIDAttendanceEdit:String! = ""
         var EventIdAttendanceEdit:String!=""
         var varFrom:String! = ""
         var AttendanceID:String! = ""
         */
        
    }
    /*----------*/
    var muarrayListData:NSMutableArray=NSMutableArray()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        
        if(indexPath.row==0)
        {
            return 90.0
        }
        else  if(indexPath.row==1)
        {
            return varRowHeight
        }
        else
        {
            return 60.0
        }
        return 74.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 8
    }
    var varRowHeight:CGFloat!=0.0
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! AttendanceEditTableViewCell
        if(mudict.count>0)
        {
            print(mudict)
            print(muarrayListData)
            /*
             self.muarrayListData
             var mudict=["AttendanceName":AttendanceName,"AttendanceDate":AttendanceDate,"Attendancetime":Attendancetime,"AttendanceDesc":AttendanceDesc,
             "MemberCount":MemberCount,"AnnsCount":AnnsCount,"AnnetsCount":AnnetsCount,"VisitorsCount":VisitorsCount,"RotarianCount":RotarianCount,"DistrictDelegatesCount":DistrictDelegatesCount,
             "AttendanceID":AttendanceID,]
             */
            // var mudict=muarrayListData.objectAtIndex(indexPath.row)
            prototypeCells.viewFirst.isHidden=true
            prototypeCells.textviewDescription.isHidden=true
            prototypeCells.viewThird.isHidden=true
            if(indexPath.row==0)
            {
                
                prototypeCells.viewFirst.isHidden=false
                
                print(mudict)
                prototypeCells.labelAttendanceName.text=mudict.value(forKey: "AttendanceName")as! String
                prototypeCells.labelDateTime.text=mudict.value(forKey: "AttendanceDate")as! String+" "+String(mudict.value(forKey: "Attendancetime")as! String)
            }
            else  if(indexPath.row==1)
            {
                prototypeCells.textviewDescription.isHidden=false
                prototypeCells.textviewDescription.text=mudict.value(forKey: "AttendanceDesc")as! String
                
                
                /*-----*/
                let fixedWidth = prototypeCells.textviewDescription.frame.size.width
                prototypeCells.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize = prototypeCells.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame = prototypeCells.textviewDescription.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height+20)
                prototypeCells.textviewDescription.frame = newFrame;
                varRowHeight=newSize.height
                /*------*/
                
            }
            else
            {
                tableviewEditAttendance.isHidden=false
                prototypeCells.viewThird.isHidden=false
                if(indexPath.row==2)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "MemberCount")as! Int)+" Members"
                }
                else if(indexPath.row==3)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "AnnsCount")as! Int)+" Anns"
                }
                else if(indexPath.row==4)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "AnnetsCount")as! Int)+" Annets"
                }
                else if(indexPath.row==5)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "VisitorsCount")as! Int)+" Visitors"
                }
                else if(indexPath.row==6)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "RotarianCount")as! Int)+" Rotarian (Other Club)"
                }
                else if(indexPath.row==7)
                {
                    prototypeCells.labelValue.text=String(mudict.value(forKey: "DistrictDelegatesCount")as! Int)+" District Delegates"
                }
                
            }
            prototypeCells.buttonMain.addTarget(self, action: #selector(AttendanceEditViewController.buttonAttendanceClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
        }
        return prototypeCells
    }
    
@objc    func buttonAttendanceClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        if(sender.tag==2)
        {
            print("members")
            //AttendanceID
            
            print(mudict)
            
            let membercount:Int! = mudict.value(forKey: "MemberCount")as! Int
            if(membercount != 0)
            {
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="members"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No Members added", duration: 2, position: CSToastPositionCenter)
            }
            
        }
        else if(sender.tag==3)
        {
            print("anns")
            let AnnsCount:Int! = mudict.value(forKey: "AnnsCount")as! Int
            if(AnnsCount != 0)
            {
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="anns"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No Anns added", duration: 2, position: CSToastPositionCenter)
            }
        }
        else if(sender.tag==4)
        {
            print("annets")
            let AnnetsCount:Int! = mudict.value(forKey: "AnnetsCount")as! Int
            if(AnnetsCount != 0)
            {
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="annets"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No Annets added", duration: 2, position: CSToastPositionCenter)
            }
        }
        else if(sender.tag==5)
        {
            print("visitors")
            
            let VisitorsCount:Int! = mudict.value(forKey: "VisitorsCount")as! Int
            if(VisitorsCount != 0)
            {
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="visitors"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No Visitors added", duration: 2, position: CSToastPositionCenter)
            }
        }
        else if(sender.tag==6)
        {
            print("rotarian")
            let RotarianCount:Int! = mudict.value(forKey: "RotarianCount")as! Int
            if(RotarianCount != 0)
            {
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="rotarian"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No Rotarian added", duration: 2, position: CSToastPositionCenter)
            }
        }
        else if(sender.tag==7)
        {
            print("districtdelegates")
            
            let DistrictDelegatesCount:Int! = mudict.value(forKey: "DistrictDelegatesCount")as! Int
            if(DistrictDelegatesCount != 0)
            {
                
                
                let objMemberListAttendanceViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberListAttendanceViewController") as! MemberListAttendanceViewController
                objMemberListAttendanceViewController.AttendanceID=mudict.value(forKey: "AttendanceID")as! String
                objMemberListAttendanceViewController.FromWhichScreen="districtdelegates"
                self.navigationController?.pushViewController(objMemberListAttendanceViewController, animated: true)
            }
            else
            {
                self.view.makeToast("No District Delegates added", duration: 2, position: CSToastPositionCenter)
            }
        }
    }
    /*--------------------*/
    func functionForFetchingAttendanceDetailData()
    {
      // loaderViewMethod()
        
        let completeURL = baseUrl+"Attendance/getAttendanceDetails"
        let parameterst = [
            "AttendanceID":AttendanceID
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
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                // let arrarrNewGroupList = (dd.objectForKey("EventListDetailResult")!.objectForKey("EventsListResult")!.objectForKey("EventList")) as! NSArray
                
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "AttendanceDetailsResult")!
                print(arrarrNewGroupList)
                print((arrarrNewGroupList as AnyObject).count)

                
                 var dictTemporaryDictionary:NSDictionary=((dd.object(forKey: "TBAttendanceDetailsResult")! as AnyObject).object(forKey: "AttendanceDetailsResult")! as AnyObject).object(at: 0)
                let responseCode = dictTemporaryDictionary.object(forKey: "AttendanceResult")!
                //let EventDesc = dd.objectForKey("TBAttendanceDetailsResult")!.objectForKey("AttendanceDetailsResult")!.objectAtIndex(0).objectForKey("AttendanceResult")!.objectForKey("eventDesc")!
                //let EventDate = dd.objectForKey("TBAttendanceDetailsResult")!.objectForKey("AttendanceDetailsResult")!.objectAtIndex(0).objectForKey("AttendanceResult")!.objectForKey("eventDate")!
                
                var AttendanceName=(responseCode as AnyObject).value(forKey: "AttendanceName")as! String
                var AttendanceDate=(responseCode as AnyObject).value(forKey: "AttendanceDate")as! String
                var Attendancetime=(responseCode as AnyObject).value(forKey: "Attendancetime")as! String
                var AttendanceDesc=(responseCode as AnyObject).value(forKey: "AttendanceDesc")as! String
                
                var MemberCount=(responseCode as AnyObject).value(forKey: "MemberCount")as! Int
                var AnnsCount=(responseCode as AnyObject).value(forKey: "AnnsCount")as! Int
                var AnnetsCount=(responseCode as AnyObject).value(forKey: "AnnetsCount")as! Int
                var VisitorsCount=(responseCode as AnyObject).value(forKey: "VisitorsCount")as! Int
                var RotarianCount=(responseCode as AnyObject).value(forKey: "RotarianCount")as! Int
                var DistrictDelegatesCount=(responseCode as AnyObject).value(forKey: "DistrictDelegatesCount")as! Int
                
                var AttendanceID=(responseCode as AnyObject).value(forKey: "AttendanceID")as! String
                
                // self.muarrayValue.replaceObjectAtIndex(0, withObject: EventTitle)
                // self.muarrayValue.replaceObjectAtIndex(1, withObject: EventDesc)
                //  self.muarrayValue.replaceObjectAtIndex(2, withObject: EventDate)
                
                
                self.mudict=["AttendanceName":AttendanceName,"AttendanceDate":AttendanceDate,"Attendancetime":Attendancetime,"AttendanceDesc":AttendanceDesc,
                    "MemberCount":MemberCount,"AnnsCount":AnnsCount,"AnnetsCount":AnnetsCount,"VisitorsCount":VisitorsCount,"RotarianCount":RotarianCount,"DistrictDelegatesCount":DistrictDelegatesCount,
                    "AttendanceID":AttendanceID,]
                
                //self.muarrayListData.addObject(mudict)
                print(self.mudict)
                self.window=nil
                self.tableviewEditAttendance.reloadData()
                
                ///
                
                ////
                
                
                
            }
            else
            {
                 self.window=nil
                print("NO Result")
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    var mudict:NSMutableDictionary=NSMutableDictionary()
    func functionForDeletingAttendance()
    {
        //{"AttendanceID":"59","createdBy":"255671"}
            
            
            let completeURL = baseUrl+"Attendance/AttendanceDelete"
            let parameterst = [
                "AttendanceID":AttendanceID,
                "createdBy":GrpProfileIDAttendanceEdit
            ]
            print(parameterst)
            print(completeURL)
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print(response)
                let dd = response as! NSDictionary
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                //  print("dd \(dd)")
                if(dd.object(forKey: "status") as! String == "0" && dd.object(forKey: "message") as! String == "success")
                {
                    
                    // the alert view
                    let alert = UIAlertController(title: "", message: "Attendance Deleted successfully", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    // change to desired number of seconds (in this case 5 seconds)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        // your code with delay
                        alert.dismiss(animated: true, completion: nil)
                         self.navigationController?.popViewController(animated: true)
                    }
                    
                   
                }
                else
                {
                    print("NO Result")
                }
                
                SVProgressHUD.dismiss()
        }
            })
        }
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





