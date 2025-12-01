//
//  ViewController.swift
//  TouchBase
//
//  Created by Umesh on 24/11/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    let languageCellIdentifier = "Cell"
    
    var languagesArray=["English",
        "French",
        "Deutch",
        "Italiano",
        "Japanies",
        "Spain",
        "Portugues",
        "Chinies",
        ]
    
    var languageImagesArray=["eng_lang",
        "france_lang",
        "deutsch_lang",
        "italiano_lang",
        "japan_lang",
        "spain_lang",
        "portu_lang",
        "china_lang",
    ]
    
    @IBOutlet var LanguageTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
      
        
      
        //----code by Rajendra Ja fro session timeout start
        //commonClassFunction().functionForCheckIsSessionTimeoutOrNot()
        //----code by Rajendra Ja fro session timeout end
        
        
        
    
    }
    
  
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
       // self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
    }
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Preferred Language"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return languagesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = LanguageTableView.dequeueReusableCell(withIdentifier: languageCellIdentifier, for: indexPath) as! LanguagesCell
        
        let row = indexPath.row
        cell.LanguageLabel.text = languagesArray[row]
        cell.LanguageLabel.highlightedTextColor =  UIColor.blue
        
        cell.CountryImage.image = UIImage(named: languageImagesArray[row])
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LanguageTableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(languagesArray[row])
        print(row)
        
        let cell = LanguageTableView.cellForRow(at: indexPath) as! LanguagesCell
        cell.LanguageLabel.textColor = UIColor.blue
    
        
    }
    
    
    @IBAction func ProceedNextAtion(_ sender: AnyObject)
    {
        print("Proceed Next")
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "events") as UIViewController, animated: true) //     mobile_login  otp_verify  group_detail  terms_conditions  profileView
                                              //     directory   events   // Actual -> welcome
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

