//
//  RotaryNewsViewController.swift
//  TouchBase
//
//  Created by rajendra on 22/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
class RotaryNewsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableRotaryNews: UITableView!
    var menuTitles:NSMutableArray=NSMutableArray()
    var muarrauRotaryNews:NSMutableArray=NSMutableArray()
    
    var moduleName:String!=""
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationSetting()
        fetch()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- navigation
    func createNavigationSetting()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white // (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(RotaryNewsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
      
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- Get Data From Local Rotary News
    func fetch()
    {
        menuTitles=[]
        muarrauRotaryNews=NSMutableArray()
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        print(databasePath)
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
  
        
        for i in 00..<1
        {
            if (contactDB?.open())!
            {
                var querySQL = ""
                querySQL = "SELECT * FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'First' LIMIT 10"
                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                while results?.next() == true
                {
                    //createNavigationBar() // When Come RSS feed
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
                    dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
                    dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
                    dd.setValue((results?.string(forColumn: "link"))! as String, forKey:"link")
                    print(dd)
                   muarrauRotaryNews.add(dd) // = dd
                }
            }
         //   print("muarrauRotaryNews\n :: \(muarrauRotaryNews)")
        }


        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muarrauRotaryNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRotaryNews.dequeueReusableCell(withIdentifier: "RotaryNewsTableCell", for: indexPath) as! RotaryNewsTableCell
       
        cell.lblValue.text! = (muarrauRotaryNews.object(at: indexPath.row) as! NSDictionary ).object(forKey: "title") as! String
        //(muarrauRotaryNews.objectForKey("title") as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Index")
        
        
        let varLink =  (muarrauRotaryNews.object(at: indexPath.row) as! NSDictionary ).object(forKey: "link") as! String
        let description =  (muarrauRotaryNews.object(at: indexPath.row) as! NSDictionary ).object(forKey: "description") as! String
//        let varLink = (muarrauRotaryNews.objectForKey("link") as! String)
//        let description = (muarrauRotaryNews.objectForKey("description") as! String)
//        
        let objWebViewToUrlOpenViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewToUrlOpenViewController") as! WebViewToUrlOpenViewController
        objWebViewToUrlOpenViewController.descriptionForRssField = description
        objWebViewToUrlOpenViewController.isCallFrom = "Dashboard"
        objWebViewToUrlOpenViewController.moduleName = "Rotary News"
        objWebViewToUrlOpenViewController.ContinueReadingLink = varLink
        self.navigationController?.pushViewController(objWebViewToUrlOpenViewController, animated: true)

    }



}
