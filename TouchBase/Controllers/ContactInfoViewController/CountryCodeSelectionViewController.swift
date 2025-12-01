//
//  CountryCodeSelectionViewController.swift
//  TouchBase
//
//  Created by Umesh on 07/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class CountryCodeSelectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,webServiceDelegate
{

    @IBOutlet var countryCodeSlectTblView: UITableView!
    var mainArray = NSArray()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        //        var myDict: NSDictionary?
        //        if let path = NSBundle.mainBundle().pathForResource("CountyCodes", ofType: "plist"){
        //            myDict = NSDictionary(contentsOfFile: path)
        //        }
        //        if let dict = myDict
        //        {
        //            // Use your dict here
        //            countryNamesArray = dict.objectForKey("CountryName") as! NSMutableArray
        //            countryCodesArray = dict.objectForKey("CountryCode") as! NSMutableArray
        //            print(countryNamesArray)
        //            print(countryCodesArray)
        //
        //        }
        
        
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.getCountryCodeSelection()
        
        
        
        self.createNavigationBar()
        
    }
    
    
    func countryCodeSelectDelegateFunction(_ countryCat : TBCountryResult)
    {
        print(countryCat.status)
        
        if countryCat.status == "0"
        {
            mainArray = countryCat.countryLists as NSArray
            
            countryCodeSlectTblView.reloadData()
        }
        else
        {
            
        }
    }
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Select Country Code"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CountrySelectionController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainArray.count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       // let cell = countryCodeSlectTblView.dequeueReusableCellWithIdentifier("CountryCodeSelectionCell", forIndexPath: indexPath)
        let cell = countryCodeSlectTblView.dequeueReusableCell(withIdentifier: "CountryCodeSelectionCell", for: indexPath) as! CountryCodeSelectionCell
        let row = indexPath.row
        
        var countryList = GrpCountryList()
        countryList = mainArray.object(at: row) as! GrpCountryList
        
        cell.countryNameLbl.text = countryList.countryName
      //  cell.textLabel?.text = countryList.countryName
        cell.textLabel!.highlightedTextColor =  UIColor.red
        cell.textLabel?.font = UIFont(name: "Roboto-Regular",size: 16)
        return cell
    }
    
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        countryCodeSlectTblView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        //  print(countryNamesArray)
        
        var countryList = GrpCountryList()
        countryList = mainArray.object(at: row) as! GrpCountryList
        
        
        let defaults = UserDefaults.standard
        defaults.set(countryList.countryName, forKey: "countryName")
        defaults.set(countryList.countryCode, forKey: "countryCode")
        defaults.set(countryList.countryCode, forKey: "countryCode1")
        defaults.set(countryList.countryId, forKey: "countryId")
        defaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
    }

}
