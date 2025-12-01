//
//  PreferencesViewController.swift
//  TouchBase
//
//  Created by Kaizan on 02/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MessageUI

class PreferencesViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    
    
    var preferenceArray = ["Settings","Report","Help", "Terms & Conditions","Exit","Delete Entity"]
    
    var preferenceImageArray = ["setting_Pref","report_Pref","help_Pref", "tc_Pref","exit_Pref","delete_Pref"]
    
    let screenSize: CGRect = UIScreen.main.bounds
    let bounds = UIScreen.main.bounds
    var appDelegate : AppDelegate = AppDelegate()
    
    var grpNameStr : String!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var popupBackImage: UIImageView!
    @IBOutlet var popupView: UIView!
    @IBOutlet var popupImage: UIImageView!
    @IBOutlet var popupLableTItle: UILabel!
    
    @IBOutlet var popupCancelButton: UIButton!
    
    @IBOutlet var popupDoneButton: UIButton!
    
    
    
    @IBOutlet var PreferenceTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Preferences"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(PreferencesViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return 1
        }
        else
        {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 120.0
        }
        else
        {
            return 80.0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(indexPath.section == 0)
        {
            let cell = PreferenceTableView.dequeueReusableCell(withIdentifier: "prefHeaderCell", for: indexPath) as! profPreferenceCell
            
            cell.ProfilePic.translatesAutoresizingMaskIntoConstraints = true
            cell.ProfilePic.frame=CGRect(x: 10,y: 7, width: 100, height: 100)
            cell.ProfilePic.layer.cornerRadius = 50;
            cell.ProfilePic.layer.masksToBounds = true
            cell.ProfilePic.clipsToBounds = true;
            
            if let checkedUrl = URL(string: "http://servicestest.touchbase.in:8062//Documents/Group/21042016124611PM.png") {
                
                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                    DispatchQueue.main.async { () -> Void in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? "")
                        print("Download Finished")
                        cell.ProfilePic.image =  UIImage(data: data)
                        //  cell.activityLoader.stopAnimating()
                    }
                }
            }
            
            
            
            return cell
        }
        else
        {
            
            let cell = PreferenceTableView.dequeueReusableCell(withIdentifier: "preferenceCell", for: indexPath) as! preferenceCell
            cell.PreferenceNameLabel.text = preferenceArray[indexPath.row] as String
            cell.PreferenceImage.image = UIImage(named: preferenceImageArray[indexPath.row])
            
            cell.PreferenceImage.translatesAutoresizingMaskIntoConstraints = true
            cell.PreferenceImage.frame=CGRect(x: 10,y: 25, width: 30, height: 30)
            cell.PreferenceImage.layer.masksToBounds = true
            cell.PreferenceImage.clipsToBounds = true;
            
            return cell
                    
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0
        {
            
        }
        else
        {
            if indexPath.row == 1
            {
                let reportVC = self.storyboard!.instantiateViewController(withIdentifier: "report_view") as! ReportProblemController
                self.navigationController?.pushViewController(reportVC, animated: true)
                
            }
            else if indexPath.row == 4
            {
                popupView.isHidden = false
                popupDoneButton.setTitle("Exit",  for: UIControl.State.normal)
                popupImage.image = UIImage(named: preferenceImageArray[indexPath.row])
                popupLableTItle.text = String(format:"Exit %@",grpNameStr)
                
               // mainView.frame = CGRectMake((popupView.frame.size.width)/2-134, (popupView.frame.size.height)/2-70, 268, 140)
                //popupView.addSubview(mainView)
            }
            else if indexPath.row == 5
            {
                popupView.isHidden = false
                popupDoneButton.setTitle("Delete",  for: UIControl.State.normal)
                popupImage.image = UIImage(named: preferenceImageArray[indexPath.row])
                popupLableTItle.text = String(format:"Delete %@",grpNameStr)
                
                //mainView.frame = CGRectMake((popupView.frame.size.width)/2-134, (popupView.frame.size.height)/2-70, 268, 140)
                //popupView.addSubview(mainView)
            }
            else
            {
                
            }
            
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func PopupDOneAAction(_ sender: AnyObject)
    {
        popupView.isHidden = true
    }
    
    
    
    @IBAction func PopupCancelAction(_ sender: AnyObject)
    {
        popupView.isHidden = true
    }

    
}



