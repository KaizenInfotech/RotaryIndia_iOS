//
//  MainDashboardWithSideBarViewController.swift
//  TouchBase
//
//  Created by rajendra on 20/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class MainDashboardWithSideBarViewController: UIViewController {

    
    @IBOutlet weak var viewForSidebar: UIView!
//    @IBOutlet weak var btnPrivacySetting: UIButton!
    @IBOutlet weak var btnAboutDeveloper: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnFaQ: UIButton!
    @IBOutlet weak var btnHelpDesk: UIButton!
    var grpDetailPrevious = NSDictionary()
    var listSyncOnline: Resultus?
    
    var headTitle = ""
    
    @IBOutlet weak var lblVersion: UILabel!

    
    func getInfoModuleForAboutDevFaqHelpDesk()
{
    SVProgressHUD.show()
  let completeURL:String! = baseUrl+"Group/GetEntityInfo"
  //baseUrl+row_GetRotaryLibraryDetails
  let parameterst = ["moduleID":"101", "SearchText" : "", "grpID":"11111"]
  print(parameterst)
  print(completeURL)
  ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
 print(response)
 let dd = response as! NSDictionary
 print("dd \(dd)")
 var varGetValueServerError = response.object(forKey: "serverError")as? String
 if(varGetValueServerError == "Error")
 {
    SVProgressHUD.dismiss()
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
 }
 else
 {
 if((dd.object(forKey: "TBEntityInfoResult")! as AnyObject).object(forKey: "status") as! String == "0")
 {
    var titleString:String=""
    var descString:String=""
     for i in 0..<(((response.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).count
      {
       print((((response.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).object(at: i))
       let varRotaryLibTitle=(((dd.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "enname")! as AnyObject).object(at: i)
       let varRotaryLibDescription=((((dd.value(forKey: "TBEntityInfoResult")! as AnyObject).value(forKey: "EntityInfoResult")! as AnyObject).value(forKey: "descptn")! as AnyObject).object(at: i))
       if let titles = varRotaryLibTitle as? String
       {
        if titles == "Developer Info"
        {
            titleString=titles
            descString=varRotaryLibDescription as! String
            break
        }
       }
    }
    SVProgressHUD.dismiss()
    if titleString != ""
    {
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "RotaryLibraryWevViewViewController") as! RotaryLibraryWevViewViewController
        profVC.varTitle = titleString
        profVC.varRotaryLibraryDescription = descString
        profVC.moduleName = "About Developer"
        self.navigationController?.pushViewController(profVC, animated: true)
    }
  }
    else
 {
    SVProgressHUD.dismiss()
    }
 }
})
}
    
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    @IBAction func buttonAboutDeveloperClickEvent(_ sender: AnyObject)
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        getInfoModuleForAboutDevFaqHelpDesk()
        }
        else
        {
     self.view.makeToast("No internet access.", duration: 2, position: CSToastPositionCenter)
        }
    }
    @IBAction func buttonPrivacyClickEvent(_ sender: AnyObject)
    {
        
    }
    @IBAction func buttonNotificationClickEvent(_ sender: AnyObject)
    {
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "SideBarGroupDistrictListViewController") as! SideBarGroupDistrictListViewController
        profVC.mainArray = self.getGroupDistrictList
        profVC.listSyncOnline = self.listSyncOnline
       
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    @IBAction func buttonFAQClickEvent(_ sender: AnyObject)
    {
        //RotaryLibraryViewController
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "RotaryLibraryViewController") as! RotaryLibraryViewController
        profVC.varModuleId = "102"
        profVC.moduleName = "FAQ's"
        profVC.varGroupId = "11111"
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    
    @IBAction func buttonHelpDeskClickEvent(_ sender: AnyObject)
    {
        //RotaryLibraryViewController
        let profVC = self.storyboard!.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        profVC.headTitle = self.headTitle
        self.navigationController?.pushViewController(profVC, animated: true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String
        {
            print(text)
            lblVersion.text = "Version " + text
            
        }
        
        btnHelpDesk.setTitle("\(headTitle) Helpline", for: .normal)
        print(getGroupDistrictList)
        createNavigationBar()
        viewForSidebar.backgroundColor=UIColor.white
        btnAboutDeveloper.addBottomBorder()
//        btnPrivacySetting.addBottomBorder()
        btnFaQ.addBottomBorder()
        btnNotification.addBottomBorder()
        btnHelpDesk.addBottomBorder()
        // Do any additional setup after loading the view.
    }
    func createNavigationBar()
    {
//        self.edgesForExtendedLayout=[]
        self.navigationController?.isNavigationBarHidden = false
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let logo = UIImage(named: "rt_nav_logo")
        let imageView = UIImageView(image:logo)
        //self.navigationItem.titleView = imageView
        self.title = headTitle
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        self.navigationItem.setHidesBackButton(true, animated:true);
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x:0,y: 0,width: 5,height: 5)
        buttonleft.setImage(UIImage(named:"Sm"),  for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MainDashboardWithSideBarViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.rightBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
     self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
