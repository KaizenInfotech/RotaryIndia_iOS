//
//  CreateAlbumViewController.swift
//  TouchBase
//
//  Created by Rajendra Jat on 20/09/16.
//  Copyright © 2016 Parag. All rights reserved.
import UIKit
import PhotosUI
import Photos
import Alamofire

import SVProgressHUD
//import SnapKit
//import LiquidFloatingActionButton
class CreateAlbumViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,webServiceDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate
{
    
    
    var appDelegate : AppDelegate!
    let loaderClass  = WebserviceClass()
    var isCategory:String!=""
    
    @IBOutlet var buttonMessage: UIButton!
    //floating button
    var actionButton: ActionButton!
    @IBOutlet weak var btnshowText: UIButton!
    @IBOutlet var expandView: UIView!
    @IBOutlet var expandTextView: UITextView!
    @IBOutlet var expandBtn: UIButton!
    //MARK:- Outlet
    @IBOutlet var viewPopup: UIView!
    @IBOutlet var buttonOpacity: UIButton!
    @IBOutlet var viewAsGridList: UIView!
    @IBOutlet var collectionviewAlbum: UICollectionView!
    @IBOutlet var tableviewAlbum: UITableView!
    //MARK:- Local Variable
    var editB = UIButton(type: UIButton.ButtonType.custom)
    
    var moduleName:String! = ""
    //MARK:- mutable array
    var mainArray : NSMutableArray!
    var moduleID:String!=""
    
    //MARK:- Public Variable
    var varGetAlbumID:String!=nil
    var varOpenPopUpGridList:Int=0
    var muarrayListData:NSArray=NSArray()
    var grpID:String! = nil
    
    var isAdmin:String! = ""
    
    var  userID:String! = nil
    var stringModuleId:String!=""
    let reuseIdentifier = "cell"
    var prototypeCell:CreateAlbumViewCell=CreateAlbumViewCell()
    var prototypeCells:CreateAlbumTableViewCell=CreateAlbumTableViewCell()
    var varGalleryOffline:GalleryOffline=GalleryOffline()
    //MARK:- Array,Dictionary Declaration
    var muarrayAlbumList:NSMutableArray=NSMutableArray()
    //MARK:- Class object
    
    var ifanyChanges:String! = ""
    
    
    override func viewDidLoad()
    {
        print("Creating Album")
        buttonMessage.isHidden=true
        UserDefaults.standard.setValue("Changes", forKey: "IfAnyChanges")
       // grpID = NSUserDefaults.standardUserDefaults().valueForKey("GrpID") as! String
        //userID = NSUserDefaults.standardUserDefaults().valueForKey("UserIdGrpProfileID") as! String
        //isAdmin = NSUserDefaults.standardUserDefaults().valueForKey("Session_isGrpAdmin") as! String

        //self.navigationController?.setNavigationBarHidden(true, animated: false)

        
        //1.success
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        //         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        //        {
        //        self.functionForFetchingAlbumListData()
        //        }
        //        else
        //        {
        //        self.mainArray = NSMutableArray()
        //           fetchData()
        //        }
        //
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //        //2.
        //        var localPath: NSURL?
        //        Alamofire.download(.GET,
        //            "http://web.touchbase.in/Documents/documentsafe/Group457/ESIC_Limit_Notification13012017050358PM_(1)23012017044928PM.pdf",
        //            destination: { (temporaryURL, response) in
        //                let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        //                let pathComponent = response.suggestedFilename
        //
        //                localPath = directoryURL.URLByAppendingPathComponent(pathComponent!)
        //                return localPath!
        //        })
        //            .response { (request, response, _, error) in
        //                print(response)
        //                print("Downloaded file to \(localPath!)")
        //        }
        //
        //        //3.
        //        let destinationn = Alamofire.Request.suggestedDownloadDestination(
        //            directory: .CachesDirectory,
        //            domain: .UserDomainMask
        //        )
        //
        //        Alamofire.download(.GET, "http://web.touchbase.in/Documents/documentsafe/Group457/10022017022456PM.pdf", destination: destinationn)
        //            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
        //                print(totalBytesRead)
        //            }
        //            .response { request, response, _, error in
        //                print(response)
        //                print("fileURL: \(destinationn(NSURL(string: "")!, response!))")
        //        }
        //
        
        
        //read document from document directory
        
        
        
        // collectionviewAlbum.backgroundColor=UIColor.whiteColor()
        view.backgroundColor=UIColor.white
        
        
        //code by Rajendra Jat temporary comment
        
        print(isAdmin)
        if(isAdmin=="No")
        {
            
        }
        else
        {
            functiuonFloatingButton()
        }
        
        /*
         
         */
        viewPopup.isHidden=true
        functionForSetLeftNavigation()
        //functionForSetLeftNavigation()
        functionForViewDidLoad()
//        self.edgesForExtendedLayout = []
        
        
        
        
        /*----------------------------------Comment by Dpk---------------------------*/
        
        /*
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
         {
         let qualityOfServiceClass = QOS_CLASS_BACKGROUND
         let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
         dispatch_async(backgroundQueue, {
         print("This is run on the background queue")
         
         dispatch_async(dispatch_get_main_queue(), { () -> Void in
         self.functionForFetchingAlbumListData()
         })
         })
         }
         else
         {
         self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        
          SVProgressHUD.dismiss()
         }
         */
        /*------------------------------------------------------------------------------------*/
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        
        
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            ifanyChanges = "Changes" //NSUserDefaults.standardUserDefaults().stringForKey("IfAnyChanges") //forKey: "IfAnyChanges")
            
            if(ifanyChanges == UserDefaults.standard.string(forKey: "IfAnyChanges") )
            {
                functionForFetchingAlbumListData()
                
                UserDefaults.standard.setValue("NoChanges", forKey: "IfAnyChanges")
                ifanyChanges = "NoChanges"
            }
            
        }
        else
        {
            self.mainArray = NSMutableArray()
            fetchData()
        }
        
        
        
        
        
    }
    
    func functionForViewDidLoad()
    {
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
        viewAsGridList.isHidden=true
        
        
        editB.setImage(UIImage(named:"gridGallery"),  for: UIControl.State.normal)
        varOpenPopUpGridList=1
        viewAsGridList.isHidden=false
        self.tableviewAlbum.isHidden=false
        self.collectionviewAlbum.isHidden=true
        //delete on long press
        /*
         let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CreateAlbumViewController.handleLongPress(_:)))
         longPressGesture.minimumPressDuration = 1.0 // 1 second press
         tableviewAlbum.addGestureRecognizer(longPressGesture)
         viewAsGridList.superview?.bringSubviewToFront(viewAsGridList)
         */
        
    }
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateAlbumViewCell
        if(muarrayListData.count>0)
        {
            //prototypeCell.configureCellServicesProviderList(muarrayListData.objectAtIndex(indexPath.row) as! NSDictionary)
            prototypeCell.buttonDetailClickEvent.isHidden=false
            //code for long press
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(CreateAlbumViewController.LongClickforDeleteTeam(_:)))
            prototypeCell.buttonDetailClickEvent.addGestureRecognizer(longGesture)
            prototypeCell.buttonDetailClickEvent.addTarget(self, action: #selector(CreateAlbumViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonDetailClickEvent.tag=indexPath.row
        }
        return prototypeCell
    }
    //long press
    @objc func LongClickforDeleteTeam(_ sender : UIGestureRecognizer)
    {
        let row = sender.view?.tag
        if sender.state == .began
        {
            let dict:NSDictionary = (muarrayListData.object(at: row!) as! NSDictionary)
            varGetAlbumID=(dict.value(forKey: "albumId")as! String)
            print(varGetAlbumID)
            viewPopup.isHidden=false
            buttonOpacity.isHidden=false
        }
        else if sender.state == .ended
        {
            print("UIGestureRecognizerStateEnded")
        }
    }
    func handleLongPress(_ longPressGesture:UILongPressGestureRecognizer)
    {
        let p = longPressGesture.location(in: tableviewAlbum)
        let indexPath = tableviewAlbum.indexPathForRow(at: p)
        if indexPath == nil
        {
            print("Long press on table view, not row.")
        }
        else if (longPressGesture.state == UIGestureRecognizer.State.began)
        {
            print("Long press on row, at \(indexPath!.row)")
            let dict:NSDictionary = (muarrayListData.object(at: (indexPath?.row)!) as! NSDictionary)
            varGetAlbumID=(dict.value(forKey: "albumId")as! String)
            print(varGetAlbumID)
            viewPopup.isHidden=false
            buttonOpacity.isHidden=false
        }
    }
    //MARK:- Tableview Delegate As List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CreateAlbumTableViewCell
        if(muarrayListData.count>0)
        {
           // prototypeCells.configureCellServicesProviderList(muarrayListData.objectAtIndex(indexPath.row) as! NSDictionary)
           // prototypeCells.buttonDelete.hidden=false
            //prototypeCells.buttonDelete.addTarget(self, action: #selector(CreateAlbumViewController.buttonDetailClickEvent(_:)), forControlEvents: UIControl.Event.TouchUpInside)
            //prototypeCells.buttonDelete.tag = indexPath.row
        }
        return prototypeCells
    }
    //details album
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        let dict:NSDictionary = (muarrayListData.object(at: sender.tag) as! NSDictionary)
        print(dict)
        let objAlbumPhotosViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlbumPhotosViewController") as! AlbumPhotosViewController
        objAlbumPhotosViewController.varGroupId = grpID
        objAlbumPhotosViewController.varAlbumId = (dict.value(forKey: "albumId")as! String)
        objAlbumPhotosViewController.varNavigationTitle=(dict.value(forKey: "title")as! String)
        objAlbumPhotosViewController.varDescription = (dict.value(forKey: "description")as! String)
        objAlbumPhotosViewController.userID = self.userID
        objAlbumPhotosViewController.imageUrlForAlbumImage = (dict.value(forKey: "image")as! String)
        objAlbumPhotosViewController.recipientType = (dict.value(forKey: "type")as! String)
        objAlbumPhotosViewController.varModuleId = (dict.value(forKey: "moduleId")as! String)
        objAlbumPhotosViewController.createdByORUserIdOrProfileId = self.userID
        objAlbumPhotosViewController.isAdmin = isAdmin
        objAlbumPhotosViewController.isCategory=self.isCategory
        self.navigationController?.pushViewController(objAlbumPhotosViewController, animated: true)
    }
    //MARK:- Server api calling
    func functionForFetchingAlbumListData()
    {
        // loaderClass.loaderViewMethod()
        print(stringModuleId)
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let Updatedefault = String(format: "updatedOnServiceDirectory%@",grpID)
        print(Updatedefault)
        if let str = defaults.value(forKey: Updatedefault) as! String?
        {
            print(str)
            updatedOn = str
        }else
        {
            updatedOn = "1970-1-1 0:0:0"
        }
        print(updatedOn)
        
        //moduleId
        let completeURL = baseUrl+k_API_Gallery
        let parameterst = [
            k_API_profileIdD : self.userID,
            k_API_groupId : self.grpID,
            k_API_updatedOn : updatedOn,
            k_API_ModuleIDAlbum:stringModuleId
        ]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                if (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "updatedOn")) != nil)
                {
                    UserDefaults.standard.set((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "updatedOn"), forKey: Updatedefault)
                }
                let arrarrNewGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newAlbums")) as! NSArray
                print(arrarrNewGroupList)
                let arrDeleteGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "deletedAlbums")) as! String
                print(arrDeleteGroupList)
                
                
                let arrUpdateGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "updatedAlbums")) as! NSArray
                print(arrUpdateGroupList)
                
                //self.DeleteDataInlocal(arrDeleteGroupList)
                //delete group data from local database
                if(arrDeleteGroupList.characters.count > 0)
                {
                    print("arrDeleteGroupList \(arrDeleteGroupList)")
                    self.DeleteDataInlocal(arrDeleteGroupList)

                    self.ifanyChanges = "Changes"
                }
                if(arrUpdateGroupList.count > 0){
                    //self.fetchData()
                    print("arrDeleteGroupList \(arrUpdateGroupList)")
                    self.UpdateDataInlocal(arrUpdateGroupList)
                    self.mainArray = NSMutableArray()
                    self.fetchData() // dpk
                    self.ifanyChanges = "Changes"
                }
                if(arrarrNewGroupList.count > 0){
                    print("arrNewGroupList \(arrarrNewGroupList)")
                    //save group data from local database
                    self.SaveDataInlocal(arrarrNewGroupList)
                    print(arrarrNewGroupList)
                    self.mainArray = NSMutableArray()
                    self.fetchData() // dpk
                    self.ifanyChanges = "Changes"
                }
                else
                {
                    let defaults = UserDefaults.standard
                    if let str = defaults.value(forKey: Updatedefault) as! String?
                    {
                        print(str)
                        self.mainArray = NSMutableArray()
                        self.fetchData()
                    }
                    else
                    {
                      self.loaderClass.window = nil
                    }
                }
                self.loaderClass.window = nil
            }
            else
            {
            self.loaderClass.window = nil
            print("NO Result")   //DPK
            }
            
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
        }
        })
    }
    /*------------------------------------------Save Data Local---------------------------------------------------------------*/
    
    
    func fetchData(){
        //loaderClass.loaderViewMethod()
        //checkRow = ""
        var databasePath : String
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
        // let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
        let mainMemberID =  UserDefaults.standard.string(forKey: "session_GetModuleId")
        let grpIDs =  UserDefaults.standard.string(forKey: "session_GetGroupId")
        //NSUserDefaults.standardUserDefaults().setValue(dict["moduleId"] as! String, forKey: "session_GetModuleId")
        
        
        if (contactDB?.open())!
        {
            let querySQL = "SELECT * FROM GALLERY_MASTER where groupId = '\(grpIDs!)' and moduleId='\(mainMemberID!)'"
            // let querySQL = "SELECT * FROM GALLERY_MASTER"
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true
            {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "type"))! as String, forKey:"type")
                dd.setValue((results?.string(forColumn: "image"))! as String, forKey:"image")
                dd.setValue((results?.string(forColumn: "isAdmin"))! as String, forKey:"isAdmin")
                dd.setValue((results?.string(forColumn: "title"))! as String, forKey:"title")
                dd.setValue((results?.string(forColumn: "description"))! as String, forKey:"description")
                dd.setValue((results?.string(forColumn: "moduleId"))! as String, forKey:"moduleId")
                dd.setValue((results?.string(forColumn: "albumId"))! as String, forKey:"albumId")
                
                //website
                // NoRecordLabel.hidden=true
                print(dd)
                mainArray.add(dd)
                muarrayListData = mainArray
            }
            
            self.loaderClass.window = nil
            self.collectionviewAlbum.reloadData()
            self.tableviewAlbum.reloadData()
            
            
                        if mainArray.count > 0 {
                           // checkRow = ""
                            buttonMessage.isHidden = true
                            //copymainArray=mainArray
                           // directoryTableView.reloadData()
                        }else{
                           // checkRow = "1"
                            buttonMessage.isHidden = false
                            //mainArray = NSMutableArray()
                            //copymainArray=NSArray()
                            //directoryTableView.reloadData()
                        }
        }
        //        else
        //        {
        //            NoRecordLabel.hidden=false
        //        }
    }
    //Save Data
    func SaveDataInlocal (_ arrdata:NSArray){
        var databasePath : String
        print(arrdata);
        
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
            for i in 0 ..< arrdata.count {
                let  dict = arrdata[i] as! NSDictionary
                //masterUID INTEGER, albumId INTEGER, title TEXT ,description TEXT,image TEXT,groupId INTEGER,isAdmin TEXT,moduleId TEXT
                //   @"INSERT INTO EMPLOYEES (name, department, age) VALUES (\"%@\", \"%@\", \"%@\")",
                //\(dict.objectForKey("descriptn") as! String)
                //\(dict.objectForKey("address") as! String)
                let insertSQL = "INSERT INTO GALLERY_MASTER (masterUID , groupId, albumId, image ,description, moduleId,type,title,isAdmin) VALUES ('\(mainMemberID!)', '\(grpID!)', '\(dict.object(forKey: "albumId") as! String)', '\(dict.object(forKey: "image") as! String )','\(dict.object(forKey: "description") as! String)','\(dict.object(forKey: "moduleId") as! String)','\(dict.object(forKey: "type") as! String)','\(dict.object(forKey: "title") as! String)','\(dict.object(forKey: "isAdmin") as! String)')"
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil)
                {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else
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
        
    }
    
    //Update Data
    func UpdateDataInlocal (_ arrdata:NSArray){
        var databasePath : String
        print(arrdata);
        
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
            for i in 0 ..< arrdata.count {
                let  dict = arrdata[i] as! NSDictionary
                var insertSQL = ""
                //GALLERY_MASTER (masterUID , groupId, albumId, image ,description, moduleId,type,title,isAdmin)
                insertSQL = "UPDATE GALLERY_MASTER SET  masterUID ='\(mainMemberID!)' , groupId ='\(grpID!)' , albumId ='\(dict.object(forKey: "albumId") as! String)' , image ='\(dict.object(forKey: "image") as! String )' , description ='\(dict.object(forKey: "description") as! String)',moduleId ='\(dict.object(forKey: "moduleId") as! String)' , type ='\(dict.object(forKey: "type") as! String)' , title ='\(dict.object(forKey: "title") as! String)' , isAdmin ='\(dict.object(forKey: "isAdmin") as! String)' WHERE moduleId = '\(dict.object(forKey: "moduleId") as! String)' and groupId ='\(self.grpID!)' and  albumId ='\(dict.object(forKey: "albumId") as! String)'"
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("--------------Update success")
                    print(databasePath);
                }
            }
        } else
        {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    
    //DeleteData
    func DeleteDataInlocal (_ arrdata:String){
        var databasePath : String
        print(arrdata);
        var varGetValueAlbumId=arrdata.components(separatedBy: ",")
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
        let varGetModuleID:String =  UserDefaults.standard.string(forKey: "session_GetModuleId")!
        let grpIDs:String =  UserDefaults.standard.string(forKey: "session_GetGroupId")!
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            for i in 0 ..< varGetValueAlbumId.count {
                // let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM GALLERY_MASTER WHERE moduleId = '\(varGetModuleID)' and  groupId ='\(grpIDs)' and albumId ='\(varGetValueAlbumId[i])' "
                //'\(dict.objectForKey("description") as! String)'
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("success saved")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
     collectionviewAlbum.reloadData()
        
    }
    
    /*----------------------------------------------------------------------------------------------------------------*/
    //--set navigation  button left and right
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white//(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateAlbumViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 50, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"listGallary"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(CreateAlbumViewController.RightDropDownAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        let buttons : NSArray = [edit]
      //  self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func RightDropDownAction()
    {
        viewAsGridList.isHidden=true
        
        if(varOpenPopUpGridList==0)
        {
            editB.setImage(UIImage(named:"gridGallery"),  for: UIControl.State.normal)
            varOpenPopUpGridList=1
            viewAsGridList.isHidden=false
            self.tableviewAlbum.isHidden=false
            self.collectionviewAlbum.isHidden=true
        }
        else
        {
            varOpenPopUpGridList=0
            viewAsGridList.isHidden=true
            self.collectionviewAlbum.isHidden=false
            self.tableviewAlbum.isHidden=true
            //self.tableviewAlbum.reloadData()
            editB.setImage(UIImage(named:"listGallary"),  for: UIControl.State.normal)
        }
    }
    //--Floating button isAdmin
    func functiuonFloatingButton()
    {
        let addAlbum = UIImage(named: "Album_add_blue.png")!
        let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
        let phonebook = ActionButtonItem(title: "Add album", image: addAlbum)
        phonebook.action =
            {
                item in print("Twitter...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
                albumControllerObject.grpID = self.grpID
                albumControllerObject.createdByORUserIdOrProfileId = self.userID
                albumControllerObject.stringModuleId=self.stringModuleId
                albumControllerObject.isCalledFRom = "add"
                albumControllerObject.isCategory=self.isCategory
                
                
                self.navigationController?.pushViewController(albumControllerObject, animated: true)
                
                
                
                
        }
        let invitation = ActionButtonItem(title: "Delete album", image: deleteAlbum)
        invitation.action =
            {
               
                item in print("Google Plus...")
                
                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DeleteCreatedAlbumViewController") as! DeleteCreatedAlbumViewController
                   // albumControllerObject.grpID = self.grpID
                   // albumControllerObject.userID = self.userID
                   // albumControllerObject.stringModuleId = self.stringModuleId
                
                if(self.mainArray.count>0)
                {
                    self.navigationController?.pushViewController(albumControllerObject, animated: true)
                }
                else
                {
                    self.view.makeToast("Please first add album.", duration: 2, position: CSToastPositionCenter)

                    print("First Add Album")
                }
        
               
        }
        actionButton = ActionButton(attachedToView: self.view, items: [invitation,phonebook])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State.normal)
        actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
    }
    //view as a grid or listview
    @IBAction func buttonViewAsGridClickEvent(_ sender: AnyObject)
    {
        self.collectionviewAlbum.isHidden=false
        self.tableviewAlbum.isHidden=true
        viewAsGridList.isHidden=true
        varOpenPopUpGridList=0
    }
    @IBAction func buttonViewAsListClickEvent(_ sender: AnyObject)
    {
        self.tableviewAlbum.isHidden=false
        self.collectionviewAlbum.isHidden=true
        viewAsGridList.isHidden=true
        varOpenPopUpGridList=0
    }
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
    }
    @IBAction func buttonNoClickEvent(_ sender: AnyObject)
    {
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
    }
    
    @IBAction func buttonYesClickEvent(_ sender: AnyObject)
    {
        
    }
    
}
