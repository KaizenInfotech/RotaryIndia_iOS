//
//  DownloadedDocViewViewController.swift
//  TouchBase
//
//  Created by Umesh on 04/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class DownloadedDocViewViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet var webView:WKWebView!
    var filename = ""
    
   // var filename = ""
    var IsComingNewShowCase:String!=""
    var Navi : String?
    var sharePDFURL:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        print("This is listing screen by Rajendra jat !!! \(filename)")
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL (string: documentsPath+"/"+filename);
        if(IsComingNewShowCase=="yes")
        {
            let urls = URL (string: filename);
            let requestObj = URLRequest(url: urls!);
            self.sharePDFURL = filename//urls!.path
//            webView.navigationDelegate = self
            webView.load(requestObj);
        }
        else
        {
            let requestObj = URLRequest(url: url!);
            self.sharePDFURL = url!.path
//            webView.navigationDelegate = self
            webView.load(requestObj);
        }
        createNavigationBar()
        // Do any additional setup after loading the view.
    }

    func webViewDidFinishLoad(_ webView: WKWebView) {
        SVProgressHUD.dismiss()
        if !sharePDFURL.starts(with: "http"){
        self.createNavigationBarAfterDocLoad()
        }
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(Navi == "" || Navi == nil){
            self.title="Downloaded Document"
        }else{
            self.title = Navi
        }

        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(buttonBackClickEvent), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func createNavigationBarAfterDocLoad(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(Navi == "" || Navi == nil){
            self.title="Downloaded Document"
        }else{
            self.title = Navi
        }

        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white

        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(buttonBackClickEvent), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonRight.setImage(UIImage(named:"share"), for: UIControl.State.normal)
        buttonRight.addTarget(self, action: #selector(shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    
  @objc  func buttonBackClickEvent()
    {
        self.navigationController?.popViewController(animated: true)
    }
 
    
    @objc func shareButtonClickEvent()
    {
        print("Share PDF file path \(sharePDFURL)")
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

}
