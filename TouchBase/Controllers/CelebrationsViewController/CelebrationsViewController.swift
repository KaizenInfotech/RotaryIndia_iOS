//
//  CelebrationsViewController.swift
//  TouchBase
//
//  Created by Kaizan on 23/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class CelebrationsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let bounds = UIScreen.main.bounds
var moduleName:String! = ""
    @IBOutlet var celebrationsTableView: UITableView!
    var nameTitles  = ["Sanjay Sagwekar","Nitish Gaikwad","John Smith","Kate","Albert Smith","Salil Deshpande"];
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CelebrationsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        buttonlog.setImage(UIImage(named: "search_btn"), for: UIControl.State.normal)
        buttonlog.addTarget(self, action: #selector(CelebrationsViewController.searchClicked), for: UIControl.Event.touchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
        
    }
    
     @objc func backClicked(){
        self.navigationController!.popViewController(animated: true)
    }
    
    @objc func searchClicked(){
        //calVC
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "calVC") as UIViewController, animated: true)
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nameTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = celebrationsTableView.dequeueReusableCell(withIdentifier: "celebCell", for: indexPath) as! CelebrityCell
        
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
        cell.nameLabel.text=nameTitles[indexPath.row]
        return cell
        
        //let indexPath = NSIndexPath(forRow: index, inSection: 0)
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        celebrationsTableView.deselectRow(at: indexPath, animated: true)
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "calVC") as UIViewController, animated: true)
        // let row = indexPath.row
        //print(languagesArray[row])
        // print(row)
        
        // let cell = LanguageTableView.cellForRowAtIndexPath(indexPath) as! LanguagesCell
        // cell.LanguageLabel.textColor = UIColor.blueColor()
    }
    
    
    
}


