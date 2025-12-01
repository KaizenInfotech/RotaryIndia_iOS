//
//  ExternalLinkViewController.swift
//  TouchBase
//
//  Created by Umesh on 07/02/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import WebKit
class ExternalLinkViewController: UIViewController {
    let loaderClass  = WebserviceClass()
    @IBOutlet var webviewOpenUrl: WKWebView!
    var varGetUrl:String!=""
    var varNavigationTitle:String!=""
    override func viewDidLoad() {
        super.viewDidLoad()
        // loaderClass.loaderViewMethod()
        let url = URL (string: varGetUrl)
        let requestObj = URLRequest(url: url!);
        webviewOpenUrl.load(requestObj)
        createNavigationBar()
         self.loaderClass.window = nil
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = varNavigationTitle
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
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
