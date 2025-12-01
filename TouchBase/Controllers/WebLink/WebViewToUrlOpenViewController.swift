//
//  WebViewToUrlOpenViewController.swift
//  TouchBase
//
//  Created by rajendra on 23/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class WebViewToUrlOpenViewController: UIViewController,WKNavigationDelegate  {
    
    // let loaderClass  = WebserviceClass()
    var appDelegate = AppDelegate()
    var moduleName : String! = ""
    var URLstr : String! = ""
    var ContinueReadingLink : String! = ""
    var descriptionForRssField:String! = ""
    var isCallFrom:String! = ""
   // let customeWebView:WKWebView=WKWebView()
    var ticksnew:String!=""
    var outPutURL:NSURL=NSURL()
    var clickOnContinueButton:String!=""
    @IBOutlet weak var webViewInfo: WKWebView!
    @IBOutlet weak var buttonContinueReading: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        webViewInfo.backgroundColor = UIColor.white
        webViewInfo.navigationDelegate=self
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        buttonContinueReading.isHidden = true
        
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonContinueReading.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.gray
        buttonContinueReading.addSubview(lbel)
        buttonContinueReading.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        
//        self.customeWebView.frame=self.webViewInfo.frame
//        self.view.addSubview(self.customeWebView)
//        customeWebView.delegate=self
//
//        self.customeWebView.isHidden=true
//        self.customeWebView.backgroundColor=UIColor.white
        

        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(isCallFrom == "Dashboard")
            {
                //URLstr = descriptionForRssField
                //functionForOpenLinkInApp()
                
                if(moduleName=="Rotary Blogs")
                {
                    functionForOpenFullLinkInAppForBlog()
                    self.buttonContinueReading.isHidden = true
                }
                else
                {
                    functionForDescriptionForDesc()
                    self.buttonContinueReading.isHidden = false
                }
            }
            else
            {
                if(moduleName=="Rotary Blogs")
                {
                    functionForOpenFullLinkInAppForBlog()
                }
                else
                {
                  functionForOpenLinkInApp()
                }
                
                
                buttonContinueReading.isHidden = true
            }
            
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        
        createNavigationBar()
        
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
        buttonleft.addTarget(self, action: #selector(WebViewToUrlOpenViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
         shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        if(moduleName=="Rotary Blogs")
        {
           self.navigationItem.rightBarButtonItem = shareButtonAdd
        }
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- share methods
    @objc func shareButtonClickEvent()
    {
        sharePDFTo(url:exportHTMLContentToPDF())
    }
    
  /*ss*/  func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(webView: AnnounceDetailTableView)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("cancel clicked ")
                self.removePDFFiles()
                return
            }
            self.removePDFFiles()
            print("other  clicked ")
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func exportHTMLContentToPDF() -> NSURL{
        let printPageRenderer:CustomPrintPageRenderer = CustomPrintPageRenderer()
        printPageRenderer.getWebView(webView: self.webViewInfo)
        // Specify the frame of the A4 page.
        print("HEIGHT OF PRINT PAGE RENDER :: \(self.webViewInfo.frame.height+200.0)")
        let pageFrame = CGRect(x: 0.0, y: 25.0, width: 595.2, height: self.webViewInfo.frame.height+200.0)
        // Set the page frame.
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        // Set the horizontal and vertical insets (that's optional).
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
        printPageRenderer.addPrintFormatter(self.webViewInfo.viewPrintFormatter(), startingAtPageAt: 0)
        
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        self.ticksnew = getCurrentDate()
        let fileName:String!="Rotary_India_Blog_\(self.ticksnew!)"
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName!).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        pdfData.write(to: outputURL, atomically: true)
        return outputURL as NSURL
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer:CustomPrintPageRenderer) -> NSMutableData {
        let data = NSMutableData()
        let pdfPageBounds =  CGRect(x:0, y:0.0, width:595.2,height:self.webViewInfo.frame.height+250.0)
        UIGraphicsBeginPDFContextToData(data, pdfPageBounds, nil)
        
        if printPageRenderer.numberOfPages>0
        {
        for i in 0...printPageRenderer.numberOfPages-1 {
            UIGraphicsBeginPDFPage()
            if i==0
            {
               // printPageRenderer.drawHeaderForPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
            printPageRenderer.drawHeaderForPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        printPageRenderer.drawFooterForPage(at: printPageRenderer.numberOfPages-1, in: UIGraphicsGetPDFContextBounds())
        UIGraphicsEndPDFContext()
        }
        return data
    }
    
    
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
    }
    
    
    
    func removePDFFiles()
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                let filName:String=fileURL.lastPathComponent
                let extensionL:String=fileURL.pathExtension
                if extensionL == "pdf" && filName.contains("Rotary_India_Blog_") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    
    //MARK:-

    
    
    
    //descriptionForRssField
    
    func webViewDidFinishLoad(_ webView: WKWebView) {
        SVProgressHUD.dismiss()
        
    }
    
    func functionForDescriptionForDesc()
    {
        
        print("url str \(descriptionForRssField)")
        webViewInfo.loadHTMLString(descriptionForRssField, baseURL: nil)
        
        //self.myWebView.loadHTMLString(myHTMLString, baseURL: nil)
    }
    
    func functionForOpenFullLinkInAppForBlog()
    {
        print("URLstr::: \(URLstr)")
        print("_________________________________________________________________________________________________________")
        ContinueReadingLink=ContinueReadingLink.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "")
        print("ContinueReadingLink::: \(ContinueReadingLink!)")
        let trimmedString = ContinueReadingLink!.trimmingCharacters(in: CharacterSet.whitespaces)
        let url : NSString = trimmedString as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : URL = URL(string: urlStr as String)!
        print(searchURL)
        let requestObj = URLRequest(url: searchURL)
        webViewInfo.load(requestObj)
        //customeWebView.loadRequest(requestObj)

    }
    /*----------------------------------------Code by Deepak---------------------------------------*/
    func functionForOpenLinkInApp()
    {
        print(URLstr)
        if(URLstr.hasPrefix("https://"))
        {
            SVProgressHUD.show()
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            webViewInfo.load(requestObj)
        }
        else if(URLstr.hasPrefix("http://"))
        {
            SVProgressHUD.show()
            print(URLstr)
            let url = URL (string: URLstr)
            let requestObj = URLRequest(url: url!);
            print(requestObj)
            webViewInfo.load(requestObj)
        }
        else
        {
            if(URLstr.contains("www."))
            {
                URLstr = "http://"+URLstr
                SVProgressHUD.show()
                print(URLstr)
                let url = URL (string: URLstr)
                let requestObj = URLRequest(url: url!);
                print(requestObj)
                webViewInfo.load(requestObj)
            }
            else
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                     self.navigationController?.popViewController(animated: true)
                    // Put your code which should be executed with a delay here
                })
            }
         }
        SVProgressHUD.dismiss()
     }
    
    /*---------------------------------------------Code by Deepak----------------------------------*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonContinueReadingClickEvent(_ sender: AnyObject)
    {
        let objRassFeedWebViewContinueReadingViewController = self.storyboard?.instantiateViewController(withIdentifier: "RassFeedWebViewContinueReadingViewController") as! RassFeedWebViewContinueReadingViewController
        objRassFeedWebViewContinueReadingViewController.ContinueReadingLink = ContinueReadingLink
        objRassFeedWebViewContinueReadingViewController.moduleName = moduleName
      //  self.navigationController?.pushViewController(objRassFeedWebViewContinueReadingViewController, animated: true)
        functionForOpenLinkInSafari()
    }
    func functionForOpenLinkInSafari()
    {
        
        let trimmedString = ContinueReadingLink.trimmingCharacters(in: CharacterSet.whitespaces)
        let urls : NSString = trimmedString as NSString
        let urlStr : NSString = urls.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
       // let searchURL : URL = URL(string: urlStr as String)

        guard let url = URL(string: urlStr as String) else { return }
//        UIApplication.shared.openURL(url)
        
           if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    if success {
                        print("The URL was successfully opened.")
                    } else {
                        print("Failed to open the URL.")
                    }
                }
            }
        
        
    }
}
