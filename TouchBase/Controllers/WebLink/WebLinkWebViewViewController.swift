//
//  WebLinkWebViewViewController.swift
//  TouchBase
//
//  Created by rajendra on 23/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class WebLinkWebViewViewController: UIViewController , WKNavigationDelegate{

    
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    var moduleName : String! = ""
    var URLstr : String! = ""
    var varTitle:String! = ""
    var varWebViewDescription:String! = ""
    
    @IBOutlet weak var buttonLink: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var webViewInfo: WKWebView!
    
    
    @IBOutlet weak var NoResultLabelShow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text! = varTitle
        buttonLink.setTitle(URLstr,  for: UIControl.State.normal)
        buttonLink.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        webViewInfo.backgroundColor = UIColor.white
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        createNavigationBar()
        print("url str \(varWebViewDescription!)")
//        webViewInfo.navigationDelegate = self
        webViewInfo.loadHTMLString(varWebViewDescription, baseURL: nil)
        print(URLstr)
        
//        if(URLstr.contains("http") || URLstr.contains("www"))
//        {
//        let url = URL (string: URLstr)
//
//        let requestObj = URLRequest(url: url!)
//        webViewInfo.loadRequest(requestObj)
//        }
        
        
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(WebLinkWebViewViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func buttonLinkOpenClickEvent(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        let objWebViewToUrlOpenViewControllr = self.storyboard?.instantiateViewController(withIdentifier: "WebViewToUrlOpenViewController") as! WebViewToUrlOpenViewController
            objWebViewToUrlOpenViewControllr.isCallFrom = "weblink"
        objWebViewToUrlOpenViewControllr.URLstr = URLstr
        objWebViewToUrlOpenViewControllr.moduleName = moduleName
        self.navigationController?.pushViewController(objWebViewToUrlOpenViewControllr, animated: true)
        }
        else
        {
             SVProgressHUD.dismiss()
        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
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

}
