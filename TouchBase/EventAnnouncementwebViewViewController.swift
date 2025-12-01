//
//  EventAnnouncementwebViewViewController.swift
//  TouchBase
//
//  Created by rajendra on 30/08/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import WebKit
class EventAnnouncementwebViewViewController: UIViewController {
    
    
    var webUrl:String!=""
    
    @IBOutlet weak var webviewEventAnnouncement: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavigationBar()
        //  let url = URL (string: webUrl)
        //  let requestObj = URLRequest(url: url!);
        //  webviewEventAnnouncement.loadRequest(requestObj)
        
        
        /*
         let url = URL (string: "https://www.linkedin.com/feed/")
         let requestObj = URLRequest(url: url!)
         webviewEventAnnouncement.loadRequest(requestObj)
         */
        
        print(webUrl)
        
        if(webUrl.contains("http") || webUrl.contains("https"))
        {
            
        }
        else
        {
            webUrl="http://"+webUrl
        }
        print("this is link :------")
        print(webUrl)
       webUrl = webUrl.trimmingCharacters(in: .whitespacesAndNewlines)

        let url = URL (string: webUrl)
        let requestObj = URLRequest(url: url!)
        webviewEventAnnouncement.load(requestObj)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = ""
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        // let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //  self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        //self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
    }
     @objc func backClicked()
    {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

