//
//  AfterSplashViewController.swift
//  TouchBase
//
//  Created by Kaizan on 07/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class AfterSplashViewController: UIViewController {
    
    @IBOutlet var afterSplashBottomLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController!.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func GetStartedAction(_ sender: AnyObject)
    {
         self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "welcome") as UIViewController, animated: true)
        
        let defaults1 = UserDefaults.standard
      //  defaults1.set("1", forKey: "splashOver")
        defaults1.synchronize()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // afterSplashBottomLabel.text = String(format:"By tapping on \"Get Started\" you agree to the terms and conditions.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


