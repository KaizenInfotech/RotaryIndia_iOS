


//
//  LinkViewController.swift
//  TouchBase
//
//  Created by Apple on 26/11/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import Alamofire
import SVProgressHUD
import WebKit
class LinkViewController: UIViewController,webServiceDelegate ,UINavigationControllerDelegate{
    
    
    let loaderClass  = WebserviceClass()
    
    
    @IBOutlet var buttonTitle: UIButton!
    
    
    @IBOutlet weak var textForDescription: UITextView!
    
    
    @IBOutlet weak var txtDiscription: UITextView!
    
    var window: UIWindow?
    var lableText : String = ""
    var link : String = ""
    var linkurl = String()
    var linkButton :String = ""
    var discription : String = ""
    var isAdmin:NSString!
    var copymainArray:NSArray!
    var mainArray :NSArray!
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    var grpID:NSString!
    //  var isAdmin:NSString!
    var moduleId:NSString!
    
    var moduleName:String!
    
    
    var mainDict : NSDictionary!
    let pageControl = UIPageControl.appearance()
    internal typealias ActionButtonItemAction = (ActionButtonItem) -> Void
    internal var action: ActionButtonItemAction?
  //  internal typealias ActionButtonAction = (DirectoryViewController) -> Void
    var actionButton: ActionButton!
    
    
    @IBOutlet var myWebView: WKWebView!
    
    
    
    
    //            let button = sender as UIButton
    //            var labelText = button.titleLabel!.text
    
    //
    
    
    @IBOutlet weak var label: UILabel!
    
    //link://
    
    @IBAction func linkButton(_ sender: AnyObject) {
        
        
        
        //        print(linkurl)
        //        let url = NSURL(string: "\(linkurl)")
        //        print(url)
        //        if UIApplication.sharedApplication().canOpenURL(url!) {
        //            UIApplication.sharedApplication().openURL(url!)
        //        }else{
        //            print("not able to open")
        //        }
        //
        
        
        let externalViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExternalLinkViewController") as! ExternalLinkViewController
        externalViewController.varGetUrl=linkurl
        externalViewController.varNavigationTitle=moduleName
        self.navigationController?.pushViewController(externalViewController, animated: true)
        
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createNavigationBar()
        
        
        
        
        
        var frame = self.view.frame
        frame.origin.y = 64
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
           // loaderClass.loaderViewMethod()
            
            
            pageControl.backgroundColor = UIColor.clear
            
            
            self.view.backgroundColor = UIColor.white
            self.navigationItem.setHidesBackButton(true, animated: false)
            //
            
            
            mainArray = NSArray()
            copymainArray = NSArray()
            
            
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            //wsm.getExternalLink("22", grpID: "529")
            
          
                    // let urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                    
                    
                    //
                    //                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                    
                    //-------
                    /*-------------------------------------------------------------*/
                    let url = URL(string: baseUrl+"Group/GetExternalLink")!
            var params: [String: String] = ["moduleId": moduleId as String,"grpId": grpID as String]
                    print(url)
                    print(params)
                    Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                        switch response.result {
                        case .success:
                            // var result = [String:String]()
                            if let value = response.result.value {
                                let dic = response.result.value!
                                let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                                let jsonString = String(data: jsonData!, encoding: .utf8)!
                                print(jsonString)
                                
                                ////uiiuoiuouiotururuur
                               // let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
                               // let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
                               // print("Response 8888 \(string!)")
                                let jsono = try! JSONSerialization.jsonObject(with: jsonData!, options:.mutableContainers)
                                print("jsono is \(jsono)")
                                
                                //my code
                                var dictTemporaryDictionary:NSDictionary=response.result.value as! NSDictionary
                                let response = dictTemporaryDictionary
                                
                                
                                let  message = response["message"] as! String
                                
                                if(message=="success")
                                {
                                    let  status = response["status"]
                                    let lableText = response["lableText"]
                                    let link = response["link"]
                                    /*my code*/
                                    /*
                                    self.linkurl = link!["link"] as! String
                                    self.label.text = link["lableText"] as! String
                                    print("link\(self.linkurl)")
                                    let myHTMLString:String! = link["description"] as! String
 */
                                    
                                    let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                                    paragraphStyle.lineHeightMultiple = 30.0
                                    paragraphStyle.maximumLineHeight = 30.0
                                    paragraphStyle.minimumLineHeight = 30.0
                                    let ats = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 19.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
                                  //my code  self.textForDescription.attributedText = NSAttributedString(string: myHTMLString as String, attributes: ats)
                                   
                                    self.textForDescription.attributedText = NSAttributedString(string: "myHTMLString" as String, attributes: ats)

                                    
                                    
                                    self.textForDescription.textAlignment = .justified
                                    self.buttonTitle.isHidden=false
                                    self.label.isHidden=false
                                    self.loaderClass.window = nil
                                    
                                    
                                }
                                else
                                {
                                    // self.buttonTitle.hidden=true
                                    // self.label.hidden=true
                                    self.loaderClass.window = nil
                                }
                                ///gujjuyhjutyurturyurrtunnrur
                                
                            }
                        case .failure(_): break
                        }
                    }
                    /*-------------------------------------------------------------*/
                    

                    //-------
                    
                    
                    
                //
        }
        
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            self.loaderClass.window = nil
            buttonTitle.isHidden=true
             SVProgressHUD.dismiss()
        }
    
    }
    // func viewWillAppear(animated: Bool) {
    

    func createNavigationBar()
    {
        
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LinkViewController.methodOfReceivedNotification(_:)), name:"NotificationIdentifier", object: nil)
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
        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //    let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        //    add.tintColor = UIColor.whiteColor()
        self.view.addSubview(buttonleft)
        //self.view.addSubview(leftButton)
        //self.view.addSubview(<#T##view: UIView##UIView#>)
        
    }
    func clicked(){
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    //                    func viewWillAppear(animated: Bool) {
    //                                }
    
    //    func getExternalLink(getLink: TBGetLinkResult) {
    //        if (getLink.status == "0")
    //        {
    //            dscDiscription = getLink.description as! UITextView
    //            //link = getLink.link as! UILabel
    //
    //
    
    func getExternalLinkDelegate(_ getLink : TBGetLinkResult){
        
        if (getLink.status == "0"){
            
            print("...getLink.details\(getLink.status)")  //0
            print("...getLink.details\(getLink.message)")  //sucess
            print("...getLink.details\(getLink.description)")
            print("...getLink.details\(getLink.lableText)")
            
        }
    }
   
}



