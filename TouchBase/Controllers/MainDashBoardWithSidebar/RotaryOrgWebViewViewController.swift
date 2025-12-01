//
//  RotaryOrgWebViewViewController.swift
//  TouchBase
//
//  Created by rajendra on 27/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class RotaryOrgWebViewViewController: UIViewController , WKNavigationDelegate, WKUIDelegate{

    @IBOutlet weak var webViewInfo: WKWebView!

    let loaderClass  = WebserviceClass()
    var appDelegate = AppDelegate()
    var URLstr : String! = ""
    var varFromCalling:String!=""
    var moduleName:String!=""
    var url = ""
    var hideFloatButtonDelegate: HideFloatButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
         self.title = moduleName
        print("URL------\(self.url)")
        if(varFromCalling == "Global Rewards")
        {
         URLstr = "https://my.rotary.org/en/member-center/rotary-global-rewards/offers#/offers"
        }
        else
        {
            switch varFromCalling {
            case "Rotary India":
                URLstr = "https://rotary-india.org/"
                break
            case "Humidity Awards":
                URLstr = "http://rotaryindiahumanityheroawards.org/"
                break
            case "ROW":
                URLstr = "https://rosteronwheels.com/"
                break
            case "COVID":
                self.title = "Fight Against COVID-19"
            //URLstr = "https://rotaryindia.org/Covid19/Covid19Registration.aspx"
            URLstr="https://rotaryindia.org/Fight_Against_Covid_19.html"
                break
            case "Cashback":
                URLstr = "https://rotarycashback.in/"
            break
            case "RotaryWeb":
                self.title = "Rotary India Website"
                URLstr = "https://rotaryindia.org/"
            break
            case "Leaders":
                self.title = "Rotary India Leaders"
                URLstr = "https://rotaryindia.org/shekhar_mehta.html"
            break
            case "WebCommitee":
                self.title = "Rotary India Web-Committee"
                URLstr = "https://rotaryindia.org/community.html"
            break
            case "Showcase":
                    self.title = "Projects"
                    URLstr = "http://showcase.rotaryindia.org/"
                    //"https://rotaryindia.org/showcase.aspx"
                    //http://showcase.rotaryindia.org/
            break
            case "Rotary News":
                URLstr = "https://www.rotary.org/en/news-features"
                break
            case "Edit Profile":
                print(self.url)
                URLstr = self.url
                break
            case "Avenue Service":
                print(self.url)
                URLstr = self.url
                break
            default:
                URLstr = "https://my.rotary.org/en"
                break
            }
        }
        
        
        
        createNavigationBar()
        webViewInfo.backgroundColor = UIColor.white
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            //loaderClass.loaderViewMethod()
             functionForOpenLinkInApp()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
         SVProgressHUD.dismiss()
        
        }
       
        // Do any additional setup after loading the view.
    }

    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(false, animated: false)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(RotaryOrgWebViewViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
          if navigationAction.navigationType == .linkActivated {
              // A link was tapped
              if let url = navigationAction.request.url {
                  print("Link tapped: \(url.absoluteString)")
                  // You can perform custom actions here, like opening the URL in Safari
                  // or handling it within your app.
              }
              decisionHandler(.cancel) // Prevent the webView from navigating to the link
              return
          }
          decisionHandler(.allow) // Allow other navigation actions
      }
    
     @objc func backClicked()
    {
        self.hideFloatButtonDelegate?.hideFloatAction()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    /*----------------------------------------Code by Deepak---------------------------------------*/
    func functionForOpenLinkInApp()
    {
       
        SVProgressHUD.show()
        
        if(URLstr.hasPrefix("https://"))
        {
           
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            webViewInfo.load(requestObj)
        }
        else if(URLstr.hasPrefix("http://"))
        {
            
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            webViewInfo.load(requestObj)
        }
        else
        {
            URLstr = "http://"+URLstr
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            webViewInfo.load(requestObj)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            SVProgressHUD.dismiss()
        })
        
    }
    /*---------------------------------------------Code by Deepak----------------------------------*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: WKWebView) {
        SVProgressHUD.dismiss()
        loaderClass.window=nil
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
