//
//  TermsConditionsController.swift
//  TouchBase
//
//  Created by Kaizan on 15/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import WebKit
class TermsConditionsController: UIViewController,WKNavigationDelegate   {
    @IBOutlet var termsWEb: WKWebView!
    var isCalledFrom:NSString!
    var urlStr:NSString!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        if (isCalledFrom == "splash"){
        let url = URL (string: baseUrlTermsnCondition);
        let requestObj = URLRequest(url: url!);
//        termsWEb.navigationDelegate = self
            termsWEb.load(requestObj);
        }else{
            let url = URL (string: baseUrlSubscribes);
            let requestObj = URLRequest(url: url!);
//            termsWEb.navigationDelegate = self
            termsWEb.load(requestObj);
        }
        let defaults1 = UserDefaults.standard
        defaults1.set("1", forKey: "terms&condi")
        defaults1.synchronize()
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        if (isCalledFrom == "splash"){
        self.title="Terms & Conditions"
        }else{
            self.title="Payment"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(TermsConditionsController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }

}

