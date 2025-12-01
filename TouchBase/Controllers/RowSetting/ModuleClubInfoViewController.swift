//
//  ModuleClubInfoViewController.swift
//  TouchBase
//
//  Created by rajendra on 25/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class ModuleClubInfoViewController: UIViewController {

    @IBOutlet weak var lblMeetingPlace: UILabel!
    @IBOutlet weak var lblRotaryClubName: UILabel!
    @IBOutlet weak var lblMeetingDay: UILabel!
    @IBOutlet weak var lblMeetingTime: UILabel!
    @IBOutlet weak var lblClubID: UILabel!
    @IBOutlet weak var lblRIDistrict: UILabel!
   
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var appDelegate : AppDelegate = AppDelegate()
    var grpID:String! = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
           getClubDetails(grpID as! NSString)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
       
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Function
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "My Club"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ModuleClubInfoViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
    self.navigationController?.popViewController(animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Server Calling
    func getClubDetails(_ GroupId:NSString)
    {
       // loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        let parameterst = ["grpID":GroupId]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
                let ClubName =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "ClubName") as! String
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let MeetingDay =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingDay") as! String
                var MeetingTime =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingTime") as! String
                var ClubID =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "ClubID") as! String
                let DistrictNumber =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "DistrictNumber") as! String
                self.lblRotaryClubName.text! = ClubName
                if MeetingPlace != nil
                {
                    if MeetingPlace != ""
                    {
                        let place = MeetingPlace.replacingOccurrences(of: "\n", with: " ")
                        self.lblMeetingPlace.text! = place
                    }
                }
                self.lblMeetingDay.text! = MeetingDay
                self.lblRIDistrict.text! = DistrictNumber
                
                if(MeetingTime == "")
                {
                    self.lblMeetingTime.text! = "NA"
                }
                else
                {
                    self.lblMeetingTime.text! = MeetingTime
                }
                if(ClubID == "")
                {
                    self.lblClubID.text! = "NA"
                }
                else
                {
                    self.lblClubID.text! = ClubID
                }
                
                self.window = nil
            }
            else
            {
                self.window = nil
            }
        SVProgressHUD.dismiss()
            }
        })
    }
    
    
    
    
    
    
    
    
    /*----------------------------------------------------------------------------DPK----------------------------*/
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        
//    }
}
