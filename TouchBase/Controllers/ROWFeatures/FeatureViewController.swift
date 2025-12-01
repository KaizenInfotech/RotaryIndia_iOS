//
//  FeatureViewController.swift
//  TouchBase
//
//  Created by Harshada on 02/03/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class FeatureCell : UITableViewCell
{
@IBOutlet weak var lblTitle: UILabel!
}



class FeatureViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    let features:[String]=["Club Features","District Features","ROWEB","Direct link with Rotary India website"]
    @IBOutlet weak var featureTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForSetLeftNavigation()
        featureTableView.reloadData()
    }
    
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "ROW Features" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
      self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeatureCell=featureTableView.dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath) as! FeatureCell
        cell.lblTitle.text=features[indexPath.row]
        return cell
    }
    enum Module:Int {
        case Club=0
        case District=1
        case Roweb=2
        case DirectLink=3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "SubFeatureViewController") as! SubFeatureViewController
        switch indexPath.row
        {
        case Module.Club.rawValue:
            viewController.moduleName="Club"
        break
        case Module.District.rawValue:
            viewController.moduleName="District"
        break
        case Module.Roweb.rawValue:
            viewController.moduleName="Roweb"
        break
        case Module.DirectLink.rawValue:
            viewController.moduleName="DirectLink"
        break
        default:
            viewController.moduleName="None"
        break
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
