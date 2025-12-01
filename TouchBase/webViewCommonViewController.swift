//
//  webViewCommonViewController.swift
//  TouchBase
//
//  Created by rajendra on 09/04/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit
import MBProgressHUD
import WebKit
class webViewCommonViewController: UIViewController{
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    var docID : String = ""
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    var moduleName : String! = ""
    var URLstr:String = ""
    var varWebViewDescription:String! = ""

    
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
       loadingNotification.color = .clear
       loadingNotification.activityIndicatorColor = .darkGray
        //loadingNotification.labelText=str

        loadingNotification.show(true)
    }
    func hideProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    func webViewDidFinishLoad(_ webView : WKWebView)
    {
        hideProgress()
        if moduleName == "Document" || moduleName == "Newsletter"
        {
            removePDFFiles()
            createNavigationBarAfterLoad()
        }
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        hideProgress()
    }

    

    @IBOutlet weak var webViewInfo: WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        webViewInfo.backgroundColor = UIColor.white
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        createNavigationBar()
//        webViewInfo.navigationDelegate = self
        
        if moduleName == "Document"
        {
            if let mainMemberIDs = UserDefaults.standard.string(forKey: "masterUID")
            {
                functionForUpdateReadStatus(mainMemberID: mainMemberIDs)
            }
        }
        
        
        if(URLstr.hasPrefix("Optional("))
        {
            let temp = String(URLstr.dropFirst(10))
            print(temp)
            URLstr = String(temp.dropLast(2))
            print(URLstr)
        }
        if !URLstr.contains("http")
        {
            URLstr = "http://"+URLstr
        }
        
        if let url = URL (string: URLstr){
        let requestObj = URLRequest(url: url)
        showMBProgress(str: "")
            webViewInfo.load(requestObj)
        }
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
    
    func createNavigationBarAfterLoad()
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
        
        let shareB = UIButton(type: UIButton.ButtonType.custom)
        shareB.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        shareB.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareB.addTarget(self, action: #selector(shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let share: UIBarButtonItem = UIBarButtonItem(customView: shareB)
        self.navigationItem.rightBarButtonItem = share

    }
    
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)        
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            print("done")
        }
    }
    
    
    func functionForUpdateReadStatus(mainMemberID:String)
    {
            //moduleId
            let completeURL = baseUrl+touchBase_UpdateDocumentIsRead
            let parameterst = [
                k_API_DocID : docID,
                k_API_memberProfileID : mainMemberID
            ]
        print("this is read syayus screen ------.>>>>>>>>>>>")
        print(parameterst)
        print(completeURL)

        
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                var varGetValueServerError = response.object(forKey: "serverError")as? String
               
                print("varGetValueServerError screen --------------->")
                print(response)
                
                
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                }
            })
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
            hideProgress()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Extra PDF Method
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
                if extensionL == "pdf" && filName.contains("Rotary_India_\(moduleName!)_") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    func exportHTMLContentToPDF() -> NSURL{
        let printPageRenderer:UIPrintPageRenderer = UIPrintPageRenderer()
    
        // Specify the frame of the A4 page.
        print("HEIGHT OF PRINT PAGE RENDER :: \(self.webViewInfo.frame.height+65.0)")
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: 595.2, height: self.view.frame.height)
        // Set the page frame.
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        // Set the horizontal and vertical insets (that's optional).
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
        printPageRenderer.addPrintFormatter(self.webViewInfo.viewPrintFormatter(), startingAtPageAt: 0)
        
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)

        let ticksnew = getCurrentDate()
        let fileName:String!="Rotary_India_\(moduleName!)_\(ticksnew)"
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName!).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        pdfData.write(to: outputURL, atomically: true)
        return outputURL as NSURL
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer:UIPrintPageRenderer) -> NSMutableData {
        let data = NSMutableData()
        //let pdfPageBounds =  CGRect(x:0, y:0.0, width:595.2,height:self.view.frame.height)
        let pdfPageBounds =  CGRect(x:0, y:0.0, width:self.view.frame.width,height:self.view.frame.height)
        UIGraphicsBeginPDFContextToData(data, pdfPageBounds, nil)
        if printPageRenderer.numberOfPages>0
        {
        for i in 0...printPageRenderer.numberOfPages-1 {
            UIGraphicsBeginPDFPage()
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        }
        return data
    }

    
    @objc func shareButtonClickEvent()
    {
        if let url = URL (string: URLstr){
            if URLstr.contains("file://")
            {
                sharePDFTo(url: url as NSURL)
            }
            else{
            sharePDFTo(url:exportHTMLContentToPDF())
            }
        }
    }

    func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(webView: AnnounceDetailTableView)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if self.URLstr.contains("file://")
            {
                
            }
            else{
                self.removePDFFiles()
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }

}

