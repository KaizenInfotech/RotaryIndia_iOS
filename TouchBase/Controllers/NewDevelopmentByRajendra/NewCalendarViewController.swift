//
//  NewCalendarViewController.swift
//  TouchBase
//
//  Created by deepak on 08/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//
// var  stringProfileId:String!=""
// var isAdmin:String!=""
//var  stringGroupID:String!=""
//var isCategory:String!=""
import UIKit
import SVProgressHUD
class NewCalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //MARK:- IB
    @IBOutlet weak var viewYearFormat: UIView!
    @IBOutlet weak var viewCalendarFormat: UIView!
    @IBOutlet weak var tableviewYearFormat: UITableView!
    //MARK:- variable
    var  stringProfileId:String!=""
    var isAdmin:String!=""
    var  stringGroupID:String!=""
    var isCategory:String!=""
    var moduleName:String!=""
    var isYearorCalendarView:Bool=true
    var arrayResponse=NSArray()
    //MARK:- view didload and view will appear and navigation setting
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createNavigationBar()
        functionForViewLoadSettings()
    }
    func functionForViewLoadSettings()
    {
//        self.edgesForExtendedLayout = []
        viewYearFormat.isHidden=false
        viewCalendarFormat.isHidden=true
        //call web api
        functionForGettingCalendarMonthWiseData()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Roster On Wheels"
        
        //navigation left button
        let buttonleftFirst = UIButton(type: UIButton.ButtonType.custom)
        buttonleftFirst.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonleftFirst.setImage(UIImage(named:"back_btn_blue"),  for: UIControl.State.normal)
        buttonleftFirst.addTarget(self, action: #selector(NewCalendarViewController.buttonGoToBackClicked), for: UIControl.Event.touchUpInside)
        let leftButtonFirst: UIBarButtonItem = UIBarButtonItem(customView: buttonleftFirst)
        self.navigationItem.leftBarButtonItem = leftButtonFirst
        //navigation right button
        //1
        let buttonRightFirst = UIButton(type: UIButton.ButtonType.custom)
        buttonRightFirst.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        buttonRightFirst.setImage(UIImage(named:"search_blue"),  for: UIControl.State.normal)
        buttonRightFirst.addTarget(self, action: #selector(NewCalendarViewController.buttonRightFirst), for: UIControl.Event.touchUpInside)
        let buttonFirstRight: UIBarButtonItem = UIBarButtonItem(customView: buttonRightFirst)
        //2
        let buttonRightSecond = UIButton(type: UIButton.ButtonType.custom)
        buttonRightSecond.frame = CGRect(x: 0, y: 0, width: 30, height: 45)
        buttonRightSecond.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
        buttonRightSecond.addTarget(self, action: #selector(NewCalendarViewController.buttonRightSecond), for: UIControl.Event.touchUpInside)
        let buttonSecondRight: UIBarButtonItem = UIBarButtonItem(customView: buttonRightSecond)
        let buttons : NSArray = [buttonFirstRight, buttonSecondRight] //14 mar
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
    //pop view controller
    @objc func buttonGoToBackClicked()
    {
        print("®®®®®®®®®®®®®®®®®®®®Pop view controller clicked®®®®®®®®®®®®®®®®®®®®®®®®®")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func buttonRightFirst()
    {
        print("®®®®®®®®®®®®®®®®®®®®Right First clicked®®®®®®®®®®®®®®®®®®®®®®®®®")
        viewYearFormat.isHidden=true
        viewCalendarFormat.isHidden=false
        
        if(isYearorCalendarView==true)
        {
            viewYearFormat.isHidden=true
            viewCalendarFormat.isHidden=false
            isYearorCalendarView=false
        }
        else
        {
            viewYearFormat.isHidden=false
            viewCalendarFormat.isHidden=true
            isYearorCalendarView=true
        }
    }
    @objc func buttonRightSecond()
    {
        print("®®®®®®®®®®®®®®®®®®®®Right Second clicked filter ®®®®®®®®®®®®®®®®®®®®®®®®®")
        
    }
    //MARK:- Button click event
    //MARK:- Segue
    //MARK:- extension
    //MARK:- functions
    //MARK:- textfield delegate
    //MARK:- tableview delegate
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130.0
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayResponse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let prototypeCell : NewCalendarTableViewCell! = tableviewYearFormat.dequeueReusableCell(withIdentifier: "tableCell") as! NewCalendarTableViewCell
        if(arrayResponse.count>0)
        {
           // prototypeCell.configureCellServicesProviderList(arrayResponse.objectAtIndex(indexPath.row) as! NSDictionary)
            prototypeCell.configureCellServicesProviderList((arrayResponse.object(at: indexPath.row) as! NSDictionary), indexpath: indexPath.row)

            //getting value for dynamic row height
             let getValue=(arrayResponse.object(at: indexPath.row) as! NSDictionary).value(forKey: "eventDate")as? String
            print(getValue)
            
            ///////-------------------
            //////-------------------------
            
            
            
            prototypeCell.buttonCall.addTarget(self, action: #selector(NewCalendarViewController.buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonCall.tag=indexPath.row;
            
            prototypeCell.buttonSMS.addTarget(self, action: #selector(NewCalendarViewController.buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonSMS.tag=indexPath.row;
            
            prototypeCell.buttoEmail.addTarget(self, action: #selector(NewCalendarViewController.buttonCallClickedEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttoEmail.tag=indexPath.row;
            
        }
        return prototypeCell as NewCalendarTableViewCell
    }
    @objc func buttonCallClickedEvent(_ sender:UIButton)
    {
        
    }
    //MARK:-Call web api
    func functionForGettingCalendarMonthWiseData()
    {
        
        let completeURL = baseUrl+touchBase_GetMonthEventList
        var parameterst:NSDictionary=NSDictionary()
        if(isCategory=="1")
        {
            //print("Club----------------------------Category",isCategory)
            parameterst =
                [
                    k_API_profileId : stringProfileId as String,
                    k_API_groupIds : stringGroupID as String,
                    k_API_selectedDate : "2018-2-01",
                    k_API_updatedOns:"1970/01/01 00:00:00",
                    "groupCategory":isCategory
            ]
        }
        else if(isCategory=="2")
        {
            parameterst =
                [
                    k_API_profileId : stringProfileId as String,
                    k_API_groupIds : stringGroupID as String,
                    k_API_selectedDate : "2018-2-01",
                    k_API_updatedOns:"1970/01/01 00:00:00",
                    "groupCategory":isCategory
            ]
        }
        print(parameterst)
        print(completeURL)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let responseDict = response.value(forKey: "TBEventListResult")as! NSDictionary
            let letGetMessage = (responseDict.value(forKey: "message"))as! String
            let letGetStatus = (responseDict.value(forKey: "status"))as! String
            
            if(letGetStatus == "0" && letGetMessage == "success")
            {
                let arrayNew=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "newEvents")as! NSArray
                let arrayUpdateEvents=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "updatedEvents")as! NSArray
                let arraydeletedEvents=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "deletedEvents")as! NSArray
                print(arrayNew)
                print(arrayUpdateEvents)
                print(arraydeletedEvents)
                self.arrayResponse = arrayNew
                print(self.arrayResponse)
                self.tableviewYearFormat.reloadData()
            }
            else
            {
                
            }
            SVProgressHUD.dismiss()
            }
        })
    }
}
