
//
//  MonthlyPDFViewWebViewController.swift
//  TouchBase
//
//  Created by tt on 11/07/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class MonthlyPDFViewWebViewController: UIViewController {
    
    @IBOutlet weak var mywebView: WKWebView!
    
    let loaderClass  = WebserviceClass()
    var appDelegate = AppDelegate()
    var moduleName : String! = ""
    var URLstr : String! = ""
    var iscallFrom:String!=""
    var shareURL:NSURL=NSURL()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout=[]

        createNavigationBar()
        mywebView.backgroundColor = UIColor.white
        URLstr = (URLstr as AnyObject).replacingOccurrences(of: " ", with: "%20")
        print("ViewDidLoad URL String:: \(URLstr)")
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(URLstr=="")
            {
                
            }
            else
            {
                if (self.iscallFrom=="DownloadList" || self.iscallFrom=="FirstDownloadList")
                {
                }
                else
                {
                    functionForOpenLinkInApp()
                }
                
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
        
        
        if (self.iscallFrom=="DownloadList")
        {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let url = URL (string: documentsPath+"/"+URLstr);
            print("DownloadList URL String:: \(URLstr)")
            print(url)
            shareURL=getURL(url: url)
            print("shareurl1: \(shareURL)")
            let requestObj = URLRequest(url: url!);
//            mywebView.navigationDelegate = self
            mywebView.load(requestObj);
            
        }
        else if (self.iscallFrom=="FirstDownloadList")
        {
            print("FirstDownloadList URL String:: \(URLstr)")
           let url = URL (string: URLstr);
           shareURL=getURL(url: url)
           print("shareurl2: \(shareURL)")
            let requestObj = URLRequest(url: url!);
//            mywebView.navigationDelegate = self
            mywebView.load(requestObj);
        }
        
        
        
        
        
        
        /*
         
         
         
         */
        // Do any additional setup after loading the view.
    }
    
    func getURL(url:URL!) -> NSURL
    {
        var urlString:String=""
        if let str:String=url?.absoluteString
        {
            urlString="file://"+str
        }
        print("URL in string is : \(urlString)")
        
        if let nsURL:NSURL=NSURL(string: urlString)
        {
            return nsURL
        }
        return NSURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //self.title = moduleName
         self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MonthlyPDFViewWebViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(sharePDFTo), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        if self.iscallFrom=="DownloadList" || self.iscallFrom=="FirstDownloadList"
        {
        self.navigationItem.rightBarButtonItem=sharing
        }
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sharePDFTo()
    {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("cancel clicked ")
                return
            }
            print("other  clicked ")
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func functionForOpenLinkInApp()
    {
        
        
        
        if(URLstr.hasPrefix("https://"))
        {
            //loaderClass.loaderViewMethod()
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            mywebView.load(requestObj)
        }
        else if(URLstr.hasPrefix("http://"))
        {
           // loaderClass.loaderViewMethod()
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            mywebView.load(requestObj)
        }
        else
        {
            URLstr = "http://"+URLstr
           // loaderClass.loaderViewMethod()
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            mywebView.load(requestObj)
            
        }
        
        
    }
    
    func webViewDidFinishLoad(_ webView: WKWebView) {
        loaderClass.window = nil
    }
    
}
