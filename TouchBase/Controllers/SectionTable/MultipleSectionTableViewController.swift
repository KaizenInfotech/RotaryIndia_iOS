//
//  MultipleSectionTableViewController.swift
//  TouchBase
//
//  Created by rajendra on 26/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

import Alamofire


struct Section {
    var name: String!
    var des: [String]!
    var items: [String]!
    var collapsed: Bool!
    var imagePic: [String]!
    
    
    init(name: String,des: [String], items: [String],imagePic: [String], collapsed: Bool = false) {
        self.name = name
        self.des = des
        self.items = items
        self.collapsed = collapsed
        self.imagePic = imagePic
    }
}


class MultipleSectionTableViewController: UIViewController ,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableMultiSection: UITableView!
    var stringArrayStore=[String]()
    var stringGroupImages=[String]()
    var stringArrayTitle=[String]()
    var stringArrayTitleSecond=[String]()
    var GroupName:[String]!
    /**/
    var anArray:NSArray=NSArray()
    var loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate!
    var personalmoduleCAtArry:NSArray!
    var socialmoduleCAtArry:NSArray!
    var businsmoduleCAtArry:NSArray!
    var arrarrNewGroupList :NSArray!
    var arrDeleteGroupList :NSArray!
    
    var mudict:NSMutableDictionary=NSMutableDictionary()
    var tbrootgrp:TBGroupResult!
    var muarrayEntityId:NSMutableArray=NSMutableArray()
    var muarrayEntityTotalCount:NSMutableArray=NSMutableArray()
    var varISPopVisisbleorNot:Int!=0
    var pushCounter = 0
    var refresher:UIRefreshControl!
    var refreshControl: UIRefreshControl!
   
    
    
    var FirstBeginParsing :String! = ""
    var SecondBeginParsingBlog :String! = ""
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var description11 = NSMutableString()
    var newsUpdateDict:NSMutableDictionary = NSMutableDictionary()
    var menuTitles:NSMutableArray!;
    var moduleName:String! = ""
    var muarrayFindARotarianList:NSMutableArray=NSMutableArray()
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    
    var isAdmin:String! = ""
    var varGroupId:String! = ""
    var varModuleId:String! = ""
    
    var sections = [Section]()
    
    
    
    
    
   // openssl pkcs12 -in Certificates.p12 -out pushcert.pem -nodes -clcerts

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DeleteDataInlocal ()
        beginParsing() // Call rss APi
        fetchData()    // fetch Data From "NewsUpdate_Table" table
        functionForSetLeftNavigation()
        
        tableMultiSection.reloadData()
    }
    //MARK:- First Section API  Calling For NewsUpdate
    /*---------------------------------------------XML Parsing Delegate------------Start------------------------------------------------*/
    func beginParsing()
    {
        FirstBeginParsing = "NewsUpdate"
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"https://my.rotary.org/en/rss.xml"))!)!
        parser.delegate = self
        parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            description11 = NSMutableString()
            description11 = ""
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                //print("TITLE-------------------------->",title1)
                elements.setObject(title1, forKey: "title" as NSCopying)
                stringArrayTitle = [title1 as String]
                //print("TITLE-------------------123123",stringArrayTitle)
            }
            if !date.isEqual(nil) {
                //print("DATE-------------------------->",date)
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !description11.isEqual(nil) {
                //print("DESC-------------------------->",description11)
                elements.setObject(description11, forKey: "description" as NSCopying)
            }
            /*------------------------------------Store Data local--------------Start------------------------------------*/
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            if (contactDB?.open())!
            {
                let insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate,isFeedFirstOrSecond) VALUES ( '\(title1)', '\(description11)', '\(date)','\("First")')"
                print("1.NewsUpdate Insert Query::\(insertSQL)")
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved")
                    print(databasePath);
                }
            }
            else
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            /*------------------------------------Store Data local--------------Start------------------------------------*/
            
            
            posts.add(elements)
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
        if element.isEqual(to: "title") {
            title1.append(string)
        }
        else if element.isEqual(to: "pubDate") {
            date.append(string)
        }
        else if element.isEqual(to: "description") {
            description11.append(string)
        }
        
    }
    /*---------------------------------------------XML Parsing Delegate------------End------------------------------------------------*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- navigation
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MultipleSectionTableViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- TABLE METHODS
    /*--------------------------------tableForAddRepeatDateAndTimeInAnnounce methods--------------Start-------------*/
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(sections.count == 1)
        {
         return sections[section].items.count
        }
        if(sections.count == 2)
        {
            return sections[section].items.count
        }
       else
        {
            return sections[section].items.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(sections.count == 1)
        {
           return sections[indexPath.section].collapsed! ? 0 : 120.0
        }
        else
        {
         return sections[indexPath.section].collapsed! ? 0 : 100.0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : customTableMultiSection! = tableMultiSection.dequeueReusableCell(withIdentifier: "customTableMultiSection") as! customTableMultiSection
        if indexPath.section == 0
        {
            
            if sections[1].items.count>0
            {
                cell.imageUser.isHidden = false
                cell.lblDescription.isHidden = true
                cell.lblHeading.isHidden = false
                cell.lblHeading.text! = sections[indexPath.section].items[indexPath.row]
                let imageGroupPicUrl = sections[indexPath.section].imagePic[indexPath.row] 
                let checkedUrl = "http://web.touchbase.in/Images/it-training_institutes.png" //NSURL(string: imageGroupPicUrl)
                let url = URL(string:checkedUrl)
                let data = try? Data(contentsOf: url!)
                if data != nil
                {
                    cell.imageUser.image = UIImage(data:data!)
                }
            }
        }
        if indexPath.section == 1
        {
            cell.lblDescription.isHidden = false
            cell.lblHeading.isHidden = true
            cell.lblDescription.text! = sections[indexPath.section].items[indexPath.row]
            cell.imageUser.isHidden = true
        }
        if indexPath.section == 2
        {
             cell.lblDescription.isHidden = false
             cell.lblHeading.isHidden = true
             cell.lblDescription.text! = sections[indexPath.section].items[indexPath.row]
             cell.imageUser.isHidden = true
        }
        return cell
    }
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        if(section==0)
        {
        }
        else
        {
            header.titleLabel.text = sections[section].name
            header.titleLabel.textAlignment = .center
            // header.arrowLabel.text = ">"
            header.setCollapsed(sections[section].collapsed)
            header.section = section
            //header.delegate = self
        }
        return header
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(section==0)
        {
            return 0.0
        }
        else
        {
            return 40.0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1.0
    }
    
    /*------------------------------------------------------------------------------------------------------*/
    //DeleteData
    func DeleteDataInlocal (){
        var databasePath : String
        //  print(arrdata);
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            //for i in 0 ..< arrdata.count {
            // let  dict = arrdata[i] as! NSDictionary
            let insertSQL = "DELETE FROM NewsUpdate_Table" // WHERE profileID = '\(dict.objectForKey("serviceDirId") as! String)'
            print(insertSQL)
            let result = contactDB?.executeStatements(insertSQL)
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success delete NewsUpdate_Table from MultipleSectionTablevViewController")
                print(databasePath);
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
    }
    
    //MARK:- RSS DATA  TABLE
    
    func SaveDataInlocalRssNewsUpddate (_ arrdata:NSMutableDictionary)
    {
        var databasePath : String
        print(arrdata);
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
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            for i in 0 ..< arrdata.count {
                //                let  dict = arrdata[i] as! NSDictionary
                //              print(dict)
                
                let insertSQL = "INSERT INTO NewsUpdate_Table (newsUpdateTitle , newsUpdateDescription,newsUpdateDate) VALUES ( '\(arrdata.object(forKey: "description") as! String)', '\(arrdata.object(forKey: "date") as! String)', '\(arrdata.object(forKey: "title") as! String)')"
         print("2.NewsUpdate Insert Query::\(insertSQL)")
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    print("success saved")
                    print(databasePath);
                }
            }
        }
        else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        //fetchData1()
    }
    
    
    
    func fetchData()
    {
        menuTitles=[]
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
        var muarraySecondSection:NSMutableArray=NSMutableArray()
        var muarrayThirdSection:NSMutableArray=NSMutableArray()
        var stringSecond=[String]()
        var stringThird=[String]()
        for i in 00..<1
        {
            //newsUpdateTitle , newsUpdateDescription,newsUpdateDate,isFeedFirstOrSecond
            if (contactDB?.open())!
            {
                var querySQL = ""
                querySQL = "SELECT * FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'First' LIMIT 5 "
                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                while results?.next() == true
                {
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
                    dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
                    dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
                    //stringArrayTitle = [(results?.stringForColumn("newsUpdateTitle")!)! as String]
                    stringArrayTitle.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
                    print(dd)
                    menuTitles.add(dd)
                }
                print("*********************************",stringArrayTitle.count)
                
            }
            //muarraySecondSection.addObject("Index Section 2:-"+String(i))
            stringSecond.append("Index Section 2:-"+String(i))
            // stringSecond = stringArrayTitle
        }
        for j in 00..<1
        {
            
            if (contactDB?.open())!
            {
                var querySQL = ""
                querySQL = "SELECT *  FROM NewsUpdate_Table Where isFeedFirstOrSecond = 'Second' LIMIT 10"
                let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
                while results?.next() == true
                {
                    let dd = NSMutableDictionary ()
                    dd.setValue((results?.string(forColumn: "newsUpdateTitle"))! as String, forKey:"title")
                    dd.setValue((results?.string(forColumn: "newsUpdateDescription"))! as String, forKey:"description")
                    dd.setValue((results?.string(forColumn: "newsUpdateDate"))! as String, forKey:"date")
                    //stringArrayTitle = [(results?.stringForColumn("newsUpdateTitle")!)! as String]
                        stringArrayTitleSecond.append((results?.string(forColumn: "newsUpdateTitle")!)! as String)
                    print(dd)
                    menuTitles.add(dd)
                }
                print("*********************************",stringArrayTitle.count)
                
            }
            stringThird.append("Index Section 3:-"+String(j))
        }
        
        for k in 00..<1
        {
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            var querySQL = ""
            querySQL = "SELECT *  FROM GROUPMASTER"
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            while results?.next() == true
            {
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "grpName"))! as String, forKey:"grpName")
                dd.setValue((results?.string(forColumn: "grpImg"))! as String, forKey:"grpImg")
                dd.setValue((results?.string(forColumn: "grpProfileid"))! as String, forKey:"grpProfileid")
                dd.setValue((results?.string(forColumn: "isGrpAdmin"))! as String, forKey:"isGrpAdmin")
                dd.setValue((results?.string(forColumn: "myCategory"))! as String, forKey:"myCategory")
                dd.setValue((results?.string(forColumn: "notificationCount"))! as String, forKey:"notificationCount")
                //stringArrayStore = [(results?.stringForColumn("grpName")!)! as String]
                stringArrayStore.append((results?.string(forColumn: "grpName")!)! as String)
                stringGroupImages.append((results?.string(forColumn: "grpImg"))! as String)
                print((results?.string(forColumn: "grpImg"))! as String)
                print(dd)
                print((results?.string(forColumn: "grpImg"))! as String)
                menuTitles.add(dd)
                
            }
        }
            
        }
        
        
        
        
        
        
        sections = [ Section(name: "Groups", des: stringSecond, items:  stringArrayStore , imagePic: stringGroupImages),
                     Section(name: "News And Updates", des:stringSecond , items: stringArrayTitle,imagePic: [""]),
                     Section(name: "Blogs", des:stringSecond , items: stringArrayTitleSecond ,imagePic: [""]),]
        
        tableMultiSection.reloadData()
    }
}
