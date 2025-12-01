//
//  MemberListAttendanceViewController.swift
//  TouchBase
//
//  Created by rajendra on 19/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class MemberListAttendanceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var labelCounting: UILabel!
    @IBOutlet weak var tableviewMemberList: UITableView!
    @IBOutlet weak var textfieldSearch: UITextField!
    var prototypeCells:MemberListingNewTableViewCell=MemberListingNewTableViewCell()
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForCreaqteNavigation()
        
//        self.edgesForExtendedLayout=[]
        
        
        //1.for members
        if(FromWhichScreen=="members")
        {
            functionForFetchingMemberListingListData()
        }
        else if(FromWhichScreen=="anns")
        {
            functionForFetchingAnnsListingListData()
        }
        else if(FromWhichScreen=="annets")
        {
            functionForFetchingAnnetsListingListData()
        }
        else if(FromWhichScreen=="visitors")
        {
            functionForFetchingVisitorsListingListData()
        }
        else if(FromWhichScreen=="rotarian")
        {
            functionForFetchingRotarianListingListData()
        }
        else if(FromWhichScreen=="districtdelegates")
        {
            functionForFetchingdistrictdelegatesListingListData()
        }
        //districtdelegates
        //
    }
    
    
    /*----55555555-------------for Rotarians------------*/
    func functionForFetchingdistrictdelegatesListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceDistrictDeleagateDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"6"
        ]
        print(parameterst)
        print(completeURL)
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
            if((dd.object(forKey: "TBAttendanceDistrictDeleagateDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                /*
                 "TBAttendanceAnnetsDetailsResult": {
                 "status": "0",
                 "message": "success",
                 "AttendanceAnnetsResult": [
                 {
                 "AnnetsName": "11annet14545"
                 },
                 
                 */
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceDistrictDeleagateDetailsResult")! as AnyObject).object(forKey: "AttendanceDistrictDeleagateResult")
                print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    print((arrarrNewGroupList as! NSArray).count)
                    
                    
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    
                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var RotarianName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "RotarianName")as! String
                        RotarianName = RotarianName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(RotarianName.count>0)
                        {
                            let DistrictDesignation:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "DistrictDesignation")as! String
                            let ClubName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "ClubName")as! String
                            
                            mudictTemp=["RotarianName":RotarianName,"DistrictDesignation":DistrictDesignation,"ClubName":ClubName]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                    print(self.muarrayMainList)
                    self.tableviewMemberList.reloadData()
                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
    
    
    /*----55555555-------------for Rotarians------------*/
    func functionForFetchingRotarianListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceRotariansDetails"
        let parameterst = [
            "AttendanceID":AttendanceID!,
            "type":"5"
        ]
        print(parameterst)
        print(completeURL)
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
                print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    print((arrarrNewGroupList as! NSArray).count)
                    
                    
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    
                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var RotarianName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "RotarianName")as! String
                        RotarianName = RotarianName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(RotarianName.count>0)
                        {
                            let ClubName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "ClubName")as! String
                            
                            mudictTemp=["RotarianName":RotarianName,"ClubName":ClubName]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                    print(self.muarrayMainList)
                    self.tableviewMemberList.reloadData()

                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
    /*----4444444-------------for Visitors------------*/
    func functionForFetchingVisitorsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceVisitorsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"4"
        ]
        print(parameterst)
        print(completeURL)
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
                
                /*
                 "TBAttendanceAnnetsDetailsResult": {
                 "status": "0",
                 "message": "success",
                 "AttendanceAnnetsResult": [
                 {
                 "AnnetsName": "11annet14545"
                 },
                 
                 */
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceVisitorsDetailsResult")! as AnyObject).object(forKey: "AttendanceVisitorsResult")
                print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    print((arrarrNewGroupList as! NSArray).count)
                    
                    
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    
                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var VisitorsName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "VisitorsName")as! String
                        VisitorsName = VisitorsName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(VisitorsName.count>0)
                        {
                            let Rotarian_whohas_Brought:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "Rotarian_whohas_Brought")as! String
                            
                            mudictTemp=["VisitorsName":VisitorsName,"Rotarian_whohas_Brought":Rotarian_whohas_Brought]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                    print(self.muarrayMainList)
                    self.tableviewMemberList.reloadData()
                    
                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
    
    /*----33333333-------------for Annest------------*/
    func functionForFetchingAnnetsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceAnnetsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"3"
        ]
        print(parameterst)
        print(completeURL)
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
                
                /*
                 "TBAttendanceAnnetsDetailsResult": {
                 "status": "0",
                 "message": "success",
                 "AttendanceAnnetsResult": [
                 {
                 "AnnetsName": "11annet14545"
                 },
                 
                 */
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceAnnetsDetailsResult")! as AnyObject).object(forKey: "AttendanceAnnetsResult")
                print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    print((arrarrNewGroupList as! NSArray).count)
                    
                    
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var AnnetsName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "AnnetsName")as! String
                        AnnetsName = AnnetsName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(AnnetsName.count>0)
                        {
                            
                            mudictTemp=["AnnetsName":AnnetsName]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                    print(self.muarrayMainList)
                    self.tableviewMemberList.reloadData()
                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
    
    /*--222222222--------------for anns------------*/
    func functionForFetchingAnnsListingListData()
    {
        let completeURL = baseUrl+"Attendance/getAttendanceAnnsDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"2"
        ]
        print(parameterst)
        print(completeURL)
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
            if((dd.object(forKey: "TBAttendanceAnnsDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceAnnsDetailsResult")! as AnyObject).object(forKey: "AttendanceAnnsResult")
                print(arrarrNewGroupList)
                
                if(arrarrNewGroupList != nil)
                {
                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    
                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    
                    
                    print(arrarrNewGroupList)
                    print((arrarrNewGroupList as! NSArray).count)
                    
                    
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var AnnsName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "AnnsName")as! String
                       // AnnsName = AnnsName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(AnnsName.count>0)
                        {
                            
                            mudictTemp=["AnnsName":AnnsName]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                  
                    
                    
                    
                    self.tableviewMemberList.reloadData()
                    
                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
    /*-----------------------------*/
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    var muarrayCheckUncheck:NSMutableArray=NSMutableArray()
   var str : String!
    func functionForCreaqteNavigation()
    {
        
        str = "Members"
        
        
        if(FromWhichScreen=="members")
        {
            str = "Members"
        }
        else if(FromWhichScreen=="anns")
        {
            str = "Anns"
        }
        else if(FromWhichScreen=="annets")
        {
            str = "Annets"
        }
        else if(FromWhichScreen=="visitors")
        {
            str = "Visitors"
        }
        else if(FromWhichScreen=="rotarian")
        {
            str = "Rotarian (Other Club)"
        }
        else if(FromWhichScreen=="districtdelegates")
        {
            str = "District Delegates"
        }
        labelCounting.text=str
        labelCounting.isHidden=false
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
        buttonleft.addTarget(self, action: #selector(MemberListAttendanceViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        
    }
    var buttonleft = UIButton()
    
    
    
    func buttonCancelClicked()
    {
        print("Back button clikced")
        self.navigationController?.popViewController(animated: true)
    }
    var objProtocol:protocolName?=nil
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        print("Edit button clikced")
        
    }
    //MemberListingNewTableViewCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if(FromWhichScreen=="members")
        {
            return 74.0
        }
        else  if(FromWhichScreen=="anns")
        {
            return 74.0
        }
        
        return 74.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MemberListingNewTableViewCell
        if(muarrayListData.count>0)
        {
            print(muarrayListData)
            
            //get value from label
            // let getValuesofNavi=labelCounting.text
            if(indexPath.row==0)
            {
               // labelCounting.text=String(muarrayListData.count)+" "+labelCounting.text!
                //labelCounting.isHidden=false
                
            }
            
            
            
            
            prototypeCells.viewMembers.isHidden=true
            prototypeCells.viewAnns.isHidden=true
            prototypeCells.viewVisiRotaDisThreeinOne.isHidden=true
            if(FromWhichScreen=="members")
            {
                prototypeCells.viewMembers.isHidden=false
                prototypeCells.labelMemberName.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "MemberName")as! String
                // prototypeCells.labelDesig.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "Designation")as! String
                prototypeCells.labelDesig.isHidden=true
                let varImage = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "image")as! String
                if varImage == ""
                {
                    prototypeCells.imageUser.image = UIImage(named: "profile_pic.png")
                }
                else
                {
                    let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                 // prototypeCells.imageUser.sd_setImage(with: checkedUrl)
                }
                prototypeCells.imageUser.image = UIImage(named: "profile_pic.png")
            }
            else if(FromWhichScreen=="anns")
            {
                prototypeCells.viewAnns.isHidden=false
                prototypeCells.labelAnns.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AnnsName")as! String
            }
            else if(FromWhichScreen=="annets")
            {
                //this is annets conditon but using anns but no problem :)
                prototypeCells.viewAnns.isHidden=false
                prototypeCells.labelAnns.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "AnnetsName")as! String
            }
            else if(FromWhichScreen=="visitors")
            {
                //this is annets conditon but using anns but no problem :)
                prototypeCells.viewVisiRotaDisThreeinOne.isHidden=false
                prototypeCells.labelField.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "VisitorsName")as! String
                prototypeCells.labelValue.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "Rotarian_whohas_Brought")as! String
                
            }
            else if(FromWhichScreen=="rotarian")
            {
                //this is annets conditon but using anns but no problem :)
                prototypeCells.viewVisiRotaDisThreeinOne.isHidden=false
                print(muarrayListData)
                /*
                 var getValue:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "RotarianName")as! String
                 getValue = getValue.trimmingCharacters(in: CharacterSet.whitespaces)
                 if(getValue.count>0)
                 {
                 }
                 */
                
                // prototypeCells.labelField.text=String((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "RotarianName")as! String)+" ("+String((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "RotarianID")as! String)+" )"
                prototypeCells.labelField.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "RotarianName")as! String
                prototypeCells.labelValue.text=String((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "ClubName")as! String)
                
            }
                
            else if(FromWhichScreen=="districtdelegates")
            {
                
                
                prototypeCells.viewVisiRotaDisThreeinOne.isHidden=false
                
                
                
                
                
                var first:String! = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "RotarianName") as! String
                var second:String! = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "DistrictDesignation") as! String
                if(second.characters.count>1)
                {
                    prototypeCells.labelField.text=first! + "("+second+")"
                }
                else
                {
                    prototypeCells.labelField.text=first
                }
                    
                prototypeCells.labelValue.text=String((muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "ClubName")as! String)
                
            }
            
            
            //rotarian
            
        }
        return prototypeCells
    }
    //calling web services
    var grpIDMemberList:String!=""
    var AttendanceID:String! = ""
    var FromWhichScreen:String!=""
    /*--11111111111--------------for members------------*/
    func functionForFetchingMemberListingListData()
    {
        
        let completeURL = baseUrl+"Attendance/getAttendanceMemberDetails"
        let parameterst = [
            "AttendanceID":AttendanceID,
            "type":"1"
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
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
            if((dd.object(forKey: "TBAttendanceMemberDetailsResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBAttendanceMemberDetailsResult")! as AnyObject).object(forKey: "AttendanceMemberResult")
                print(arrarrNewGroupList)
                if(arrarrNewGroupList != nil)
                {
                    self.labelCounting.text=String((arrarrNewGroupList as! NSArray).count)+" "+self.str

                    //here need to work if empty then leave it
                    var mudictTemp:NSMutableDictionary=NSMutableDictionary()
                    let muarrayTemp:NSMutableArray=NSMutableArray()
                    
                    self.muarrayListData = arrarrNewGroupList as! NSArray
                    for i in 00..<(arrarrNewGroupList as! NSArray).count
                    {
                        var MemberName:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "MemberName")as! String
                        MemberName = MemberName.trimmingCharacters(in: CharacterSet.whitespaces)
                        if(MemberName.count>0)
                        {
                            var image:String!=(self.muarrayListData.object(at: i) as AnyObject).value(forKey: "image")as! String
                            mudictTemp=["MemberName":MemberName,"image":image]
                            muarrayTemp.add(mudictTemp)
                        }
                    }
                    print(mudictTemp)
                    
                    self.muarrayMainList = muarrayTemp as NSArray
                    self.muarrayListData = muarrayTemp as NSArray
                    
                    print(self.muarrayMainList)
                    
                    print(self.muarrayMainList.count)

                    
                    self.tableviewMemberList.reloadData()
                    
                }
                else
                {
                    self.view.makeToast("No record found.", duration: 2, position: CSToastPositionCenter)
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
}
