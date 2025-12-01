//
//  WelcomeViewController.swift
//  TouchBase
//
//  Created by Kaizan on 15/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController , webServiceDelegate  {
    var alertController = UIAlertController()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        
        alertController = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
//        self.edgesForExtendedLayout=[]
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        //----code by Rajendra Ja fro session timeout start
        //commonClassFunction().functionForCheckIsSessionTimeoutOrNot()
        //----code by Rajendra Ja fro session timeout end
        
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Welcome"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    @IBAction func TermsConditionsAction(_ sender: AnyObject)
    {
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "terms_conditions") as UIViewController, animated: true)
        
        // splash_screens  contact_list add_event add_announce  mobile_login  otp_verify  group_detail  terms_conditions  profileView
        
              //  celebration
        
        //     directory   events eventDetail ebulletine  announcement announceDetail // Actual -> terms_conditions
    }
    
    
    @IBAction func proceedNextAction(_ sender: AnyObject)
    {
       // self.signinTapped()
//        let url = NSURL(string: "https://api.whitehouse.gov/v1/petitions.json?limit=100")!
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
//            print("Task completed")
//            if let data = data {
//                do {
//                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                        dispatch_async(dispatch_get_main_queue(), {
//                            
//                            if let results: NSArray = jsonResult["results"] as? NSArray {
//                                self.tableData = results
//                                self.Indextableview.reloadData()
//                            }
//                        })
//                        
//                    }
//                } catch let error as NSError {
//                    print(error.localizedDescription)
//                }
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
       // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("mobile_login") as UIViewController, animated: true)
        
                
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "mobile_login") as UIViewController, animated: true)
    }
             
    
}


