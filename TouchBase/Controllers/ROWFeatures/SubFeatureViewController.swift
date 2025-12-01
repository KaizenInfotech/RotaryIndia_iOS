//
//  SubFeatureViewController.swift
//  TouchBase
//
//  Created by Harshada on 03/03/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import WebKit
class DistClubCell:UITableViewCell
{
    @IBOutlet weak var publicTextView: UITextView!
    @IBOutlet weak var commTextView: UITextView!
    @IBOutlet weak var governanceTextView: UITextView!
    
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var commButton: UIButton!
    @IBOutlet weak var governanceButton: UIButton!
}
class SubFeatureViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var directLinkView: UIView!
    @IBOutlet weak var rowebView: WKWebView!
    @IBOutlet weak var club_districtTableView: UITableView!
    @IBOutlet weak var districtFeatureView: UIView!
    
    var moduleName:String=""
    let clubDetails:[String]=["","",""]
    let districtDetails:[String]=["","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForSetLeftNavigation()
        setModule()
    }

    func setModule()
    {
        club_districtTableView.isHidden=true
        directLinkView.isHidden=true
        rowebView.isHidden=true
        districtFeatureView.isHidden=true
        switch moduleName {
        case "Club":
            club_districtTableView.reloadData()
            club_districtTableView.isHidden=false
            break
        case "District":
            districtFeatureView.isHidden=false
            break
        case "Roweb":
            rowebView.isHidden=false
            break
        case "DirectLink":
            directLinkView.isHidden=false
            break
        default:
            break
        }
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

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 759
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=club_districtTableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as! DistClubCell
        cell.publicButton.addTarget(self, action: #selector(publcbuttonClickEvent(_:)), for: .touchUpInside)
        cell.commButton.addTarget(self, action: #selector(commbuttonClickEvent(_:)), for: .touchUpInside)
        cell.governanceButton.addTarget(self, action: #selector(govbuttonClickEvent(_:)), for: .touchUpInside)
        return cell
    }

    @objc func publcbuttonClickEvent(_ sender:UIButton)
    {
        print("Public button clicked")
        gotoDetailPage(subModuleName: "Public")
    }

    @objc func commbuttonClickEvent(_ sender:UIButton)
    {
        print("Common button clicked")
        gotoDetailPage(subModuleName: "Comm")
    }

    @objc func govbuttonClickEvent(_ sender:UIButton)
    {
        print("Governance button clicked")
        gotoDetailPage(subModuleName: "Gov")
    }

    //MARK:- Click Action
    @IBAction func directLinkClickEvent(_ sender: Any) {
        gotoDetailPage(subModuleName:moduleName)
    }
    
    @IBAction func rowDistrictClickEvent(_ sender: Any) {
        gotoDetailPage(subModuleName: "Roweb_District")
    }

    @IBAction func rowClubClickEvent(_ sender: Any) {
        gotoDetailPage(subModuleName: "Roweb_Club")
    }

    @IBAction func districtPublisClickEvent(_ sender: Any) {
         gotoDetailPage(subModuleName: "Public")
    }

    @IBAction func districtCommClickEvent(_ sender: Any) {
         gotoDetailPage(subModuleName: "Comm")
    }

    @IBAction func districtGovClickEvent(_ sender: Any) {
         gotoDetailPage(subModuleName: "Gov")
    }

    func gotoDetailPage(subModuleName:String)
    {
        var moduleToSend:String=""
        if moduleName=="Club" || moduleName=="District"
        {
            moduleToSend=moduleName+"_"+subModuleName
        }
        else
        {
            moduleToSend=subModuleName
        }
        
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "FeatureDetailsViewController") as! FeatureDetailsViewController
        viewController.moduleName=moduleToSend
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
