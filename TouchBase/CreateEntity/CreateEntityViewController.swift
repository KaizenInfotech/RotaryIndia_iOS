//
//  CreateEntityViewController.swift
//  TouchBase
//
//  Created by Umesh on 08/02/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class CreateEntityViewController: UIViewController {
    var appDelegate : AppDelegate!
    
    @IBOutlet var webviewOpenUrl: WKWebView!
    
    
    
    
    var varGetUrl:String!=""
    override func viewWillAppear(_ animated: Bool) {
        //----code by Rajendra Ja fro session timeout start
       // commonClassFunction().functionForCheckIsSessionTimeoutOrNot()
        //----code by Rajendra Ja fro session timeout end
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        let url = URL (string: "https://docs.google.com/a/kaizeninfotech.com/forms/d/e/1FAIpQLSeNC1TuKw7BvBqehWYeIfy2EoCvt4fLVSNzd2qJw-qOLo_cMg/viewform?c=0&w=1")
        let requestObj = URLRequest(url: url!);
        webviewOpenUrl.load(requestObj)
        createNavigationBar()
        
     
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func createNavigationBar()
    {
        
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LinkViewController.methodOfReceivedNotification(_:)), name:"NotificationIdentifier", object: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Create Entity"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //    let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        //    add.tintColor = UIColor.whiteColor()
        self.view.addSubview(buttonleft)
        //self.view.addSubview(leftButton)
        //self.view.addSubview(<#T##view: UIView##UIView#>)
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        
    }

}
