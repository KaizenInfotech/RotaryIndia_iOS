//
//  DocumentsDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 28/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MediaPlayer
import SystemConfiguration
import SVProgressHUD
import SDDownloadManager
import WebKit
class DocumentsDetailController: UIViewController , webServiceDelegate , WKNavigationDelegate  {
    var objprotocolForDocumentListing:protocolForDocumentListing?=nil
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
//    var documentTitle : String = ""
//    var docURL : String = ""
//    var docType : String = ""
    var isCategory = ""
    var docListClass = DocumentList()
    var mainArray = NSArray()
    var docController:UIDocumentInteractionController!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var PDFWebView: WKWebView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    var grpProfileID : NSString!
    var docID : NSString!
    var isAdmin:String! = ""
    var sharePDFUrl:String=""
  //  var moviePlayer : MPMoviePlayerController = MPMoviePlayerController()
    @IBOutlet weak var BUTTONOPACITYDOWNLOADED: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    func functionForUpdateReadStatus()
    {
            //moduleId
            let completeURL = baseUrl+touchBase_UpdateDocumentIsRead
            let parameterst = [
                k_API_DocID : docID,
                k_API_memberProfileID : grpProfileID
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
    override func viewWillAppear(_ animated: Bool) {
      
      var varGetValue=docListClass.isRead
        
        if(varGetValue=="0")
        {
        CommonSqliteClass().functionForUpdateGroupMasterandModuleDataMasterTable("-")
        }
        
    }
     var documentURL:String!=""
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.stopAnimating()
        SDDownloadManager.shared.cancelAllDownloads()
        createNavigationBar()
        progressLabel.textColor=UIColor.white
        BUTTONOPACITYDOWNLOADED.isHidden=true
        progressLabel.isHidden=true
        progressView.isHidden=true
        var isExist:Int!=0
        var stringUrl:String!=""
        print("document URL is \(documentURL)")
        stringUrl=documentURL
        
        var cacehDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if cacehDirectoryPath != nil
        {
            let tempcacehDirectoryPath = cacehDirectoryPath
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: tempcacehDirectoryPath[0])
                print(fileList)
                  print(stringUrl)
                for i in 00 ..< fileList.count
                {
                    var varValue=fileList[i]
                    print(varValue)
                    print(stringUrl)
                    if(stringUrl.contains(varValue))
                    {
                        progressLabel.isHidden=true
                        progressView.isHidden=true
                        var varGetFilePAth:String=""
                        varGetFilePAth=fileList[i]
                        isExist=1
                        varValue=String(describing: tempcacehDirectoryPath[0])+"/"+varValue
                        print(varValue)
                        let url = URL (string:varValue);
                        let requestObj = URLRequest(url: url!);
                        
                        self.sharePDFUrl=varValue
//                       PDFWebView.navigationDelegate = self
                        PDFWebView.load(requestObj);
                        
                        
                        
                        
                        
                        
                        break
                    }
                    else
                    {
                    }
                }
            }
            catch
            {
            }
        }
        if(isExist==0)
        {
        
         UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        appDelegate = UIApplication.shared.delegate as! AppDelegate
       
            
            
            BUTTONOPACITYDOWNLOADED.isHidden=false
            progressView.isHidden=false
            progressLabel.isHidden=false
           
       
           //---This is -------------hdsuhfsakdjfhsdjfhsdkjhfsdkjhadsjkhdsakjfhsdkjfhsdjkfhdsjkfhsdjkfhsdjkfhsd gfds g
            self.progressView.setProgress(0, animated: false)
            self.progressLabel.text = "0.0 %"
           // self.finalUrlLabel.text = ""
            let request = URLRequest.init(url: URL.init(string: stringUrl)!)
            
            let downloadKey = SDDownloadManager.shared.dowloadFile(withRequest: request,
                                                                   inDirectory: nil,
                                                                   withName: nil,
                                                                   onProgress:  { [weak self] (progress) in
                                                                    let percentage = String(format: "%.1f %", (progress * 100))
                                                                    self?.progressView.setProgress(Float(progress), animated: true)
                                                                    self?.progressLabel.text = "\(percentage) %"
                                                                    /// sleep(1)
            }) {
                [weak self] (error, url) in
                if let error = error
                {
                    print("This from if condititon ")
                    print("Error is \(error as NSError)")
                    self?.BUTTONOPACITYDOWNLOADED.isHidden=true
                     self?.progressView.isHidden=true
                     self?.progressLabel.isHidden=true
                }
                else
                {
                    if let url = url
                    {
                        self?.BUTTONOPACITYDOWNLOADED.isHidden=true
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                         print("This from if-if condititon ")
                        print("Downloaded file's url is \(url.path)")
                        
                        let url = URL (string: (url.path));
                        print(url?.path)
                        print(url)
                        let requestObj = URLRequest(url: url!);
                        print(requestObj)
                        self?.sharePDFUrl = url!.path
//                        self?.PDFWebView.navigationDelegate = self
                        self?.PDFWebView.load(requestObj);
                        
                        
                    }
                    else
                    {
                        self?.BUTTONOPACITYDOWNLOADED.isHidden=true
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                        print("This from else-else condititon ")
                        
                        
                        
                        //-----
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let url = URL (string: (url?.path)!);
                        print(url?.path)
                        print(url)
                        let requestObj = URLRequest(url: url!);
                        print(requestObj)
                        self?.sharePDFUrl=url!.path
//                        self?.PDFWebView.navigationDelegate = self
                        self?.PDFWebView.load(requestObj);
                    }
                }
            }

            //This is -------------jhfjsdhfjsd hkj hfj kas hfsdhfkjsdh fjksad hk shfkjshf kjshfkjahfjashsdfgadsadsf
            
            
            
            
        indicator.stopAnimating()
        /*
        if docListClass.docType == ".pdf"
        {
            photoImageView.isHidden = true
            let url : URL! = URL(string: docListClass.docURL)
            PDFWebView.delegate = self
            PDFWebView.loadRequest(URLRequest(url: url))
        }
        else if docListClass.docType == ".jpg" || docListClass.docType == ".png" || docListClass.docType == ".JPG"
        {
            PDFWebView.isHidden = true
            
            if let checkedUrl = URL(string: docListClass.docURL ) {
                //Working in swift new version 03-08-2018
                self.photoImageView.sd_setImage(with: checkedUrl)
                self.indicator.stopAnimating()

            }
            
        }
        else if docListClass.docType == ".mov" || docListClass.docType == ".mp4"
        {
            photoImageView.isHidden = true
            PDFWebView.isHidden = true
            
            
            let url:URL = URL(string: docListClass.docURL)!
            
            moviePlayer = MPMoviePlayerController(contentURL: url)
            moviePlayer.view.frame = CGRect(x: 0, y: 65, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            self.view.addSubview(moviePlayer.view)
            moviePlayer.isFullscreen = true
            
            moviePlayer.play()
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(DocumentsDetailController.moviePlayDidFinish(_:)),
                name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish,
                object: moviePlayer)
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(DocumentsDetailController.moviePlayerDidExitFull(_:)),
                name: NSNotification.Name.MPMoviePlayerDidExitFullscreen,
                object: moviePlayer)

            
            moviePlayer.controlStyle = MPMovieControlStyle.default
            
            indicator.stopAnimating()
        }
        
        else{
            photoImageView.isHidden = true
            
            
            let url : URL! = URL(string: docListClass.docURL)
            PDFWebView.delegate = self
            PDFWebView.loadRequest(URLRequest(url: url))
        }
            */
        }
        functionForUpdateReadStatus()
    }
    
    
    class ViewController: UIViewController {
        
        // UIDocumentInteractionController instance is a class property
        var docController:UIDocumentInteractionController!
        // we're going to disable action button while controller is instantiated
        @IBOutlet weak var actionButton: UIBarButtonItem!
        
        // called when bar button item is pressed
        @IBAction func shareDoc(_ sender: AnyObject) {
            // present UIDocumentInteractionController
            docController.presentOptionsMenu(from: sender as! UIBarButtonItem, animated: true)
        }
       
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            
          
            
            
            
            // disable action button
            actionButton.isEnabled = false
            // Set priority for dispatch
            let priority = DispatchQueue.GlobalQueuePriority.default
            // take instantiation off the main thread
            DispatchQueue.global(priority: priority).async {
                [unowned self] in
                // retrieve URL to file in main bundle
                let fileURL = Bundle.main.url(forResource: "MyFile", withExtension: "txt")!
                // Instantiate the interaction controller
                self.docController = UIDocumentInteractionController(url: fileURL)
                DispatchQueue.main.async {
                    // re-enable action button
                    [unowned self] in self.actionButton.isEnabled = true
                }
            }
        
    }
        
    }
    
    

    
//    func moviePlayDidFinish(_ notification: Notification)
//    {
//        moviePlayer.view.removeFromSuperview()
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func moviePlayerDidExitFull(_ notification: Notification)
//    {
//        moviePlayer.view.removeFromSuperview()
//        self.navigationController?.popViewController(animated: true)
//    }

    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = docListClass.docTitle
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DocumentsDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        

        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        
        shareButton.addTarget(self, action: #selector(DocumentsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
//        let trashB = UIButton(type: UIButton.ButtonType.custom)
//        trashB.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
//        trashB.addTarget(self, action: #selector(DocumentsDetailController.deleteDOCAction), for: UIControl.Event.touchUpInside)
//        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes" || mainMemberID == "yes" || isAdmin == "Yes"
        {
            let buttons : NSArray = [shareButtonAdd]
          
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }
    
    func createNavigationBarAfterDocLoad(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = docListClass.docTitle
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DocumentsDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        

        let trashB = UIButton(type: UIButton.ButtonType.custom)
        trashB.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
        trashB.addTarget(self, action: #selector(DocumentsDetailController.deleteDOCAction), for: UIControl.Event.touchUpInside)
        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
        
        let shareB = UIButton(type: UIButton.ButtonType.custom)
        shareB.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        shareB.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareB.addTarget(self, action: #selector(DocumentsDetailController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let share: UIBarButtonItem = UIBarButtonItem(customView: shareB)

        
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes" || mainMemberID == "yes" || isAdmin == "Yes"
        {
            let buttons : NSArray = [trash,share]
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        else
        {
            self.navigationItem.rightBarButtonItem = share
        }
    }
     @objc func backClicked()
    {
        self.objprotocolForDocumentListing?.functionForDocumentListing(StringValue: "calling from added document successfully")

        self.navigationController?.popViewController(animated: true)
    }
    
    func downloadDOCAction(){
        
        //self.navigationController?.popViewControllerAnimated(true)
        //uploadVC
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("uploadVC") as UIViewController, animated: true)
        
        print("downloadDOCAction")
    }
    
    @objc func deleteDOCAction()
    {
        
        let alert=UIAlertController(title: "", message: "Are you sure you want to delete this document?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            print("grpProfileID \(self.grpProfileID)")
            wsm.deleteDataWebservice(self.docListClass.docID, type: "Document", profileID: self.grpProfileID as String)
            print("deleteDOCAction")
        }));
       
        self.present(alert, animated: true, completion: nil);
        
        
    }
    
    func deleteSucc(_ docListing : DeleteResult){
//        if(isCalled == "notify"){
//            // appDelegate.setRootView()
//            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
//            
//        }else if(isCalled == "notify1"){
//            //appDelegate.setRootView()
//            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
//            
//        }
//        else {
        
        
        if docListing.status == "0"
        {
            
            
            
            let alert = UIAlertController(title: "Documents", message: "Document Deleted Successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }));
            self.present(alert, animated: true, completion: nil)

        }
        else
        {
            /*
            let alert = UIAlertController(title: "Rotary India", message: "Failed to DELETE, please Try Again!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Failed to DELETE, please Try again!", duration: 2, position: CSToastPositionCenter)

            
        }
        
       // }
    }

    
    func webViewDidFinishLoad(_ webView : WKWebView)
    {
        indicator.stopAnimating()
        self.createNavigationBarAfterDocLoad()
    }
    
    
    @objc func shareButtonClickEvent()
    {
        if sharePDFUrl != "" && sharePDFUrl.hasPrefix("file://"){
        }
        else{
            sharePDFUrl="file://"+sharePDFUrl
        }
        if let url = NSURL(string: sharePDFUrl)
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
    

    
    func fileExistance() -> Bool
    {
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("textFile1.txt")
        let filePath:String = fileURL.path
        
        do
        {
            
            if  fileManager.fileExists(atPath: filePath)
            {
                print("FILE AVAILABLE");
                
            }
            else
            {
                print("FILE NOT AVAILABLE");
            }
        }
        catch
        {
        }
        
        return true
    }

}

