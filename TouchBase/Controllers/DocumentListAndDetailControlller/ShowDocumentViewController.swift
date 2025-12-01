 //let url = URL (string:varValue);
 //let requestObj = URLRequest(url: url!);
 

 //
 //  ShowDocumentViewController.swift
 //  TouchBase
 //
 //  Created by rajendra on 22/11/18.
 //  Copyright © 2018 Parag. All rights reserved.
 //
 
 import UIKit
 import SVProgressHUD
 import WebKit
 class ShowDocumentViewController: UIViewController,WKNavigationDelegate {
    
    var objprotocolForDocumentListing:protocolForDocumentListing?=nil
    var grpProfileID : NSString!
    var docID : NSString!
    var filename = ""
    var isComingFromActivity:String!=""
    var isComingFromDocument:String!=""
    var sharePDFURL:String=""
    func functionForUpdateReadStatus()
    {
        //moduleId
        let completeURL = baseUrl+touchBase_UpdateDocumentIsRead
        let parameterst = [
            k_API_DocID : docID,
            k_API_memberProfileID : grpProfileID
        ]
        
        print("this is read syayus screen ------.>>>>>>>>>>>222222222")
        print(parameterst)
        print(completeURL)
        
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            
            print("this is response value----------->>>>>>>>>>>>>>>>>>>")
            print(response)
            
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                SVProgressHUD.dismiss()
            }
            //=> Handle server response
            //  print(response)
            //add data in local if first time coming on this screen after install app
            // self.varGalleryOffline.functionForSaveDataInlocalGalleryAlbum(self.muarrayListData)
        })
    }
    
    
    @IBOutlet weak var webviewOperUrl: WKWebView!
    override func viewDidLoad() {
        
        
      functionForUpdateReadStatus()
        /*---------------------------later code strt-----------------------------------*/
        if(isComingFromDocument=="yes")
        {
            let url = URL (string:filename);
            let requestObj = URLRequest(url: url!);
            print("this is coming from document list screen")
            print(requestObj)
            self.sharePDFURL = url!.path
//            webviewOperUrl.navigationDelegate = self
            webviewOperUrl.load(requestObj);
        }
        /*----------------------------later code end------------------------------------*/
        
        else
        {
        
        
        //workinggggggg....................................
        super.viewDidLoad()
        // SVProgressHUD.show()
        let url = URL (string:filename);
        print(filename)
        print(url)
        let requestObj = URLRequest(url: url!);
        self.sharePDFURL = url!.path
//        webviewOperUrl.navigationDelegate = self
            webviewOperUrl.load(requestObj);
        }
        createNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func shareButtonClickEvent()
    {
        if sharePDFURL != "" && sharePDFURL.hasPrefix("file://"){
        }
        else{
            sharePDFURL="file://"+sharePDFURL
        }
        if let url = NSURL(string: sharePDFURL)
        {
            sharePDFTo(url: url)
        }

    }
    
    func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(webView: AnnounceDetailTableView)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
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



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(isComingFromActivity.characters.count>0)
        {
            self.title=isComingFromActivity
        }
        else
        {
            self.title="Downloaded Document"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        // self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowDocumentViewController.buttonBackClickEvent), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    func createNavigationBarAfterDocLoad(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(isComingFromActivity.characters.count>0)
        {
            self.title=isComingFromActivity
        }
        else
        {
            self.title="Downloaded Document"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        // self.navigationController!.navigationBar.titleTextAttributes = attributes

        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white

        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowDocumentViewController.buttonBackClickEvent), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton

        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonRight.setImage(UIImage(named:"share"), for: UIControl.State.normal)
        buttonRight.addTarget(self, action: #selector(ShowDocumentViewController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func buttonBackClickEvent()
    {
        //dismiss(animated: true, completion: nil)
        self.objprotocolForDocumentListing?.functionForDocumentListing(StringValue: "calling from added document successfully")

        self.navigationController?.popViewController(animated: true)
    }

    func webViewDidFinishLoad(_ webView: WKWebView) {
        //loaderClass.window = nil
        // SVProgressHUD.dismiss()
        if isComingFromDocument=="yes"{
            self.createNavigationBarAfterDocLoad()}
    }
    
 }
