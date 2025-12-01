//
//  EbulletinDetailViewController.swift
//  TouchBase
//
//  Created by Umesh on 24/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

import SVProgressHUD
import UIKit
import Alamofire
import SDWebImage
import SSZipArchive
import UIKit
import SDDownloadManager
import WebKit

class EbulletinDetailViewController: UIViewController,webServiceDelegate , WKNavigationDelegate {
    var objprotocolForUpdateListing:protocolForUpdateListing?=nil

    @IBOutlet weak var myWebView : WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var finalUrlLabel: UILabel!
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    var SMSCountStr : String!
    var urlLink:String!
    var isCalled:NSString!
    var appDelegate : AppDelegate!
    var bulletinID : NSString!
    var profileID : NSString!
    var moduleName:String! = ""
    var directoryName : String = "NewsLetterDirectory"
    var isExist:Int!=0
    var sharePDFURL:String=""
    func functionForDownloadingManager(stringUrl:String)
    {
        var isExist:Int=0
        var cacehDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
if cacehDirectoryPath != nil
{
 let tempcacehDirectoryPath = cacehDirectoryPath
 do {
 let fileList = try FileManager.default.contentsOfDirectory(atPath: tempcacehDirectoryPath[0])
 print(fileList)
 for i in 00 ..< fileList.count
 {
     var varValue=fileList[i]
     print(varValue)
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
         self.sharePDFURL=varValue
         print("Share URL is \(sharePDFURL)")
         let requestObj = URLRequest(url: url!);
//         myWebView.navigationDelegate = self
        myWebView.load(requestObj);
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
     let string = stringUrl
     if string.isValidURL {
         print("This is right url")
     }
     else
     {
         print("This is wrong url")
     }
     self.progressView.setProgress(0, animated: false)
     self.progressLabel.text = "0.0 %"
     self.finalUrlLabel.text = ""
     
     // let request = URLRequest.init(url: URL.init(string: "http://files.shareholder.com/downloads/AAPL/4907179320x0x952191/4B5199AE-34E7-47D7-8502-CF30488B3B05/10-Q_Q3_2017_As-Filed_.pdf")!)
     //http:\/\/www.rosteronwheels.com\/Documents\/documentsafe\/Group2765\/ROW_30112018060057PM.mov
     
     let request = URLRequest.init(url: URL.init(string: stringUrl)!)
     print("Thi sis newsletter url ")
     print(stringUrl)
     if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
     {
        SVProgressHUD.dismiss()
         let downloadKey = SDDownloadManager.shared.dowloadFile(withRequest: request,
 inDirectory: nil,
 withName: nil,
 onProgress:  { [weak self] (progress) in
  let percentage = String(format: "%.1f %", (progress * 100))
 
  if(percentage.contains("-"))
  {
  
  }
  else
  {
       self?.progressView.setProgress(Float(progress), animated: true)
  self?.progressLabel.text = "\(percentage) %"
  }
 }) { [weak self] (error, url) in
if let error = error
  {
      if(self?.urlLink.hasPrefix("https://"))!
      {
          let url = URL (string: (self?.urlLink)!)
          let requestObj = URLRequest(url: url!);
          
          print("https://-----------------------")
      }
      else if(self?.urlLink.hasPrefix("http://"))!
      {
          let url = URL (string: (self?.urlLink)!);
          print(url)
          let requestObj = URLRequest(url: url!);
          print("http://-----------------------")
      }
      else
      {
          let url = URL (string: "http://"+(self?.urlLink)!);
          print(url)
          let requestObj = URLRequest(url: url!);
          print("Without-------http://-----------------------")
      }
      print("Error is \(error as NSError)")
  }
  else
  {
      if let url = url {
          print("Downloaded file's url is \(url.path)")
          self?.finalUrlLabel.text = url.path
          
          //-----
          let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
          let url = URL (string: url.path);
          print(url?.path)
          print(url)
          if(url != nil)
          {
          let requestObj = URLRequest(url: url!);
          }
      }
  }

  let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
  print(documentsPath)
  if(url?.path != nil)
  {
      let url = URL (string: (url?.path)!);
    self?.sharePDFURL=url!.path
    print("Share1 URL is \(self?.sharePDFURL)")
      let requestObj = URLRequest(url: url!);
//      self?.myWebView.navigationDelegate = self
    self?.myWebView.load(requestObj);
      self?.progressView.isHidden=true
      self?.progressLabel.isHidden=true
  }
  else
  {
      // self?.view.makeToast("Something went wrong, File not available.", duration: 2, position: CSToastPositionCenter)
      self?.lblNoResult.text="Failed to load document."
      self?.lblNoResult.isHidden=false
      self?.progressView.isHidden=true
      self?.progressLabel.isHidden=true
      SVProgressHUD.dismiss()
      SVProgressHUD.dismiss()
       }
      }
     }
     else
     {
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
             
             // Put your code which should be executed with a delay here
             self.funcxtionForDealy()
         })
         
         if(urlLink.contains("http"))
         {
            
         }
         else
         {
              urlLink="http://"+urlLink
         }
         let url = URL (string: (urlLink)!);
         print(url)
        
         let requestObj = URLRequest(url: url!);
         print("http://-----------------------")
        
         if let url = NSURL(string: urlLink){
//             UIApplication.shared.openURL(url as URL)
             
             if UIApplication.shared.canOpenURL(url as URL) {
                 UIApplication.shared.open(url as URL, options: [:]) { success in
                         if success {
                             print("The URL was successfully opened.")
                         } else {
                             print("Failed to open the URL.")
                         }
                     }
                 }
             
         }
         
         
         /*
         
         myWebView.delegate = self
         myWebView.loadRequest(requestObj);
         SVProgressHUD.dismiss()
         let downloadKey = SDDownloadManager.shared.dowloadFile(withRequest: request,
                                                                inDirectory: directoryName,
                                                                withName: nil,
                                                                onProgress:  { [weak self] (progress) in
                                                                 let percentage = String(format: "%.1f %", (progress * 100))
                                                                 if(percentage.contains("-"))
                                                                 {
                                                                     
                                                                 }
                                                                 else
                                                                 {
                                                                     self?.progressView.setProgress(Float(progress), animated: true)
                                                                     self?.progressLabel.text = "\(percentage) %"
                                                                 }
                                                                 // self?.progressView.setProgress(Float(progress), animated: true)
                                                                // self?.progressLabel.text = "\(percentage) %"
                                                                 
                                                                 
         }) { [weak self] (error, url) in
             if let error = error
             {
                 self?.progressView.isHidden=true
                 self?.progressLabel.isHidden=true
                 SVProgressHUD.dismiss()
                 SVProgressHUD.dismiss()
                 
             }
             else
             {
                 self?.progressView.isHidden=true
                 self?.progressLabel.isHidden=true
                 SVProgressHUD.dismiss()
                 SVProgressHUD.dismiss()
                 
             }
         }
         */
     }
 }
    }
    
    func funcxtionForDealy()
    {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    // print("The key is \(downloadKey!)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        SDDownloadManager.shared.cancelAllDownloads()
        self.progressView.setProgress(0, animated: false)
        finalUrlLabel.isHidden=true
        
        print("this is downloading ")
        loader.stopAnimating()
        loader.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        SVProgressHUD.show()
        // loader.startAnimating()
        lblNoResult.isHidden=true
        myWebView.backgroundColor = UIColor.white
    
        print("URL Link is \(urlLink)")
        if(urlLink.hasPrefix("https://"))
        {
            functionForDownloadingManager(stringUrl: urlLink)
        }
        else if(urlLink.hasPrefix("http://"))
        {
            functionForDownloadingManager(stringUrl: urlLink)
        }
        else
        {
            functionForDownloadingManager(stringUrl: "http://"+urlLink)
        }
        if(urlLink=="")
        {
            loader.stopAnimating()
            
            SVProgressHUD.dismiss()
            self.lblNoResult.isHidden=false
        }
        else
        {
            self.lblNoResult.isHidden=true
        }
        // Do any additional setup after loading the view.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if(isCalled == "notify")
        {
            self.title = "Newsletters"
        }
        else
        {
            self.title=moduleName
        }
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EbulletinDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        if(isCalled=="Clubs")
        {
            
        }
        else
        {
            let trashB = UIButton(type: UIButton.ButtonType.custom)
            trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
            trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
            let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            if mainMemberID == "Yes"
            {
                let buttons : NSArray = [trash]
                if(isCalled=="notify")
                {
                    
                }
                else
                {
                   // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                }
            }
        }
    }
    
    func createNavigationBarAfterDocLoad()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if(isCalled == "notify")
        {
            self.title = "Newsletters"
        }
        else
        {
            self.title=moduleName
        }
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EbulletinDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        if(isCalled=="Clubs")
        {
        }
        else
        {
            let trashB = UIButton(type: UIButton.ButtonType.custom)
            trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            trashB.setImage(UIImage(named:"DeleteDDoc"),  for: UIControl.State.normal)
            trashB.addTarget(self, action: #selector(EventsDetailController.deleteEbullAction), for: UIControl.Event.touchUpInside)
            let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            if mainMemberID == "Yes"
            {
                let buttons : NSArray = [trash]
                if(isCalled=="notify")
                {
                    
                }
                else
                {
                   // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                }
            }
        }
         let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonRight.setImage(UIImage(named:"share"), for: UIControl.State.normal)
        buttonRight.addTarget(self, action: #selector(EbulletinDetailViewController.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
     @objc func backClicked()
    {
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
        
        
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            self.navigationController?.popViewController(animated: true)
            //self.navigationController?.dismissViewControllerAnimated(true, completion: nil) //DPK
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else{
            
            self.navigationController?.popViewController(animated: true)
        }
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
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

    
    func deleteEbullAction()
    {
        let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
        //event handler with closure
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(self.bulletinID as String, type: "Ebulletin", profileID:  self.profileID as String)
        }));
        self.present(alert, animated: true, completion: nil);
        
    }
    func deleteSucc(_ docListing : DeleteResult){
        
        self.objprotocolForUpdateListing?.functionForUpdateListing(stringValue: "heelo from newsletter deleted !!!")
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else {
            
            let alert = UIAlertController(title: "Newsletter", message: "Newsletter Deleted Successfully.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }));
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(_ webView : WKWebView)
    {
        self.createNavigationBarAfterDocLoad()
        SVProgressHUD.dismiss()
    }
    func webViewDidFinishLoad(webView: WKWebView) {
        print("webview did finish load!")
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        print("webview did fail load with error: \(error)")
        print(error.localizedDescription)
        print(error.localizedDescription.characters)
        print(error.localizedDescription.debugDescription)
        lblNoResult.isHidden=false
        progressView.isHidden=true
        progressLabel.isHidden=true
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
        
        var getvalue:String!=String(describing: error)
        if(getvalue.contains("A server with the specified hostname could not be found"))
        {
            
        }
    }
}








