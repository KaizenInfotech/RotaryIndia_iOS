//
//  EntityInfoDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 08/06/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import WebKit
class EntityInfoDetailController: UIViewController  , WKNavigationDelegate
{
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    var titleStr : String! = ""
    var URLstr : String!
    @IBOutlet var InfoWebView: WKWebView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        createNavigationBar()
        indicator.startAnimating()
        print("url str \(URLstr)")
           // let url : NSURL! = NSURL(string:URLstr)   // URLstr
//            InfoWebView.navigationDelegate = self
         //   InfoWebView.loadRequest(NSURLRequest(URL: url))
        InfoWebView.loadHTMLString(URLstr, baseURL: nil)
        
    }
    
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = titleStr
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(EntityInfoDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    func webViewDidFinishLoad(_ webView : WKWebView)
    {
        indicator.stopAnimating()
    }
    
    
}

