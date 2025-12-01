//
//  CountrySelectionController.swift
//  TouchBase
//
//  Created by Kaizan on 26/11/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class CountrySelectionController : UIViewController , UITableViewDelegate , UITableViewDataSource , webServiceDelegate
{
    var appDelegate : AppDelegate!

    @IBOutlet var CountryTableView: UITableView!
//    var countryNamesArray : NSMutableArray = NSMutableArray()
//    var countryCodesArray : NSMutableArray = NSMutableArray()
    var mainArray = NSArray()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

     

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
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            wsm.getCountryAndCategories()
            CountryTableView.isHidden=false
            
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            CountryTableView.isHidden=true
 SVProgressHUD.dismiss()
        }
        
     
        
        
        
        self.createNavigationBar()
        UserDefaults.standard.set("0", forKey: "sessionISValue")
    }
    
    func countryAndCatListDelegateFunction(_ countryCat : TBCountryResult)
    {
        print(countryCat.status)
        
        if countryCat.status == "0"
        {
            mainArray = countryCat.countryLists as NSArray
            
            print(mainArray)
            
            
            
            CountryTableView.reloadData()
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
        UserDefaults.standard.set("0", forKey: "sessionISValue")

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
        let cell = CountryTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let row = indexPath.row
        
        var countryList = GrpCountryList()
        countryList = mainArray.object(at: row) as! GrpCountryList
        
        cell.textLabel?.text = countryList.countryName
        cell.textLabel!.highlightedTextColor =  UIColor.blue
        cell.textLabel?.font = UIFont(name: "Roboto-Regular",size: 16)
        return cell
    }
    
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        CountryTableView.deselectRow(at: indexPath, animated: true)
        
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
        UserDefaults.standard.set("1", forKey: "sessionISValue")

        self.navigationController?.popViewController(animated: true)
        
    }

    
}
