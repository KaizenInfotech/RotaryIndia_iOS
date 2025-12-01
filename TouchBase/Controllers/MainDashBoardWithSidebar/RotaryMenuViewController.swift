//
//  RotaryMenuViewController.swift
//  TouchBase
//
//  Created by Harshada on 09/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class RotaryMenuTableViewCell:UITableViewCell
{
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var lblMenu: UILabel!
}


class RotaryMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var btnEditProfile: UIButton!
    
    @IBOutlet weak var menuTableView: UITableView!
    let menuArray:[String]=["My Club","Settings","Features","FAQ","Rotary India Helpline","About Developer"]
    let menuImageArray:[String]=["rt_home","rt_settings","rt_feature","rt_faq","rt_helpline","rt_about"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        menuTableView.reloadData()
    }
    
    func createNavigationBar()
       {
//           self.edgesForExtendedLayout=[]
           let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
           self.navigationController!.navigationBar.titleTextAttributes = attributes
           
           let logo = UIImage(named: "rt_nav_logo")
           let imageView = UIImageView(image:logo)
           self.navigationItem.titleView = imageView
           
           let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
           self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
           self.navigationController?.navigationBar.barTintColor=UIColor.white
           self.navigationItem.setHidesBackButton(true, animated:true);
            let buttonleft = UIButton(type: UIButton.ButtonType.custom)
           buttonleft.frame = CGRect(x:0,y: 0,width: 20,height: 20)
           buttonleft.setImage(UIImage(named:"Sm"),  for: UIControl.State.normal)
           buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
           let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
           self.navigationItem.rightBarButtonItem = leftButton
       }
    
        @objc func backClicked()
       {
        self.navigationController?.popViewController(animated: true)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RotaryMenuTableViewCell=(menuTableView.dequeueReusableCell(withIdentifier: "RotaryMenuCell", for: indexPath) as? RotaryMenuTableViewCell)!
        
        cell.lblMenu.text=menuArray[indexPath.row] as String
        
        
        return cell
    }
    

}
