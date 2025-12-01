//
//  ProfileMemberIntroViewController.swift
//  TouchBase
//
//  Created by IOS 2 on 03/05/24.
//  Copyright © 2024 Parag. All rights reserved.
//

import UIKit

class ProfileMemberIntroViewController: UIViewController {
    
    @IBOutlet weak var memIntroLbl: UILabel!
    @IBOutlet weak var memIntroScrollView: UIScrollView!
    
    var desc = ""
    var navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        memIntroLbl.text = desc
    }
    
    func createNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        //self.title = moduleName
        self.title = navTitle
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ProfileMemberIntroViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
