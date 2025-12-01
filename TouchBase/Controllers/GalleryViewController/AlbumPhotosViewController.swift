//
//  AlbumPhotosViewController.swift
//  TouchBase
//
//  Created by Umesh on 22/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Photos
import MWPhotoBrowser
//import LiquidFloatingActionButton
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class AlbumPhotosViewController: UIViewController , webServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    let loaderClass  = WebserviceClass()
    var actionButton: ActionButton!
    var isCategory:String!=""
    var varLastUpdateDateForAddPhoto:String! = ""
    
    //------From Album info------DPK
    var recipientType:String! = ""
    var varModuleId:String! = ""
    var imageUrlForAlbumImage:String! = ""
    var createdByORUserIdOrProfileId:String! = ""
    var isAdmin:String! = ""
    var selectedAssetsArray : NSMutableArray = NSMutableArray()
    
    //Public Variable
    var str:String! = ""
    var userID:String! = ""
    var varGroupId:String!=nil
    var varAlbumId:String!=nil
    var varNavigationTitle:String!=nil
    var varDescription:String!=nil
    var muarrayListData:NSArray=NSArray()
    var mainArray : NSMutableArray!
    @IBOutlet var buttonMessage: UIButton!
    var arrayGetAlbumPhotoListData:NSArray=NSArray()
    var varExpandCollepse:Int=0
    var prototypeCell:AlbumPhotosCell=AlbumPhotosCell()
    let reuseIdentifier = "cell"
    //var arrayAlbumPhotoListData:NSArray=NSArray()
    var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
    var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
    var muarrayHoldingPhotoId:NSMutableArray=NSMutableArray()
    
    //IB Outlet
    @IBOutlet var textviewDescription: UITextView!
    @IBOutlet var buttonExpandCollapse: UIButton!
    @IBOutlet var colectionviewAlbumPhoto: UICollectionView!
    var appDelegate : AppDelegate!
    
    var varChangesInPhotos:String = ""
    override func viewDidLoad()
    {
        
        UserDefaults.standard.setValue("No", forKey: "session_IsComingFromImageSave")
        varChangesInPhotos = "Changes"
        UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
        functionForSetLeftNavigation()
        self.mainArray = NSMutableArray()
        self.fetchData()
        
        if(isAdmin == "Yes")
        {
            functiuonFloatingButton()
        }
        else
        {
        }
        buttonMessage.isHidden=true
        
    }
    
    //--Floating button
    func functiuonFloatingButton()
    {
        let addAlbum = UIImage(named: "Album_add_blue.png")!
        let deleteAlbum = UIImage(named: "Album_delete_blue.png")!
        let phonebook = ActionButtonItem(title: "Add Photo", image: addAlbum)
        let editAlbum = UIImage(named: "Album_edit_blue.png")
        let editAlbums = ActionButtonItem(title: "Edit Album", image: editAlbum)
        
        phonebook.action =
            {
                item in print("Twitter...")
                
                print(self.varDescription)
                UserDefaults.standard.setValue(self.userID, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.varAlbumId, forKey: "session_AlbumID")
                UserDefaults.standard.setValue(self.varDescription, forKey: "session_Description")
                
                // let albumControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("AddPhotoViewController") as! AddPhotoViewController
                //albumControllerObject.grpID = self.grpID
                // albumControllerObject.createdByORUserIdOrProfileId = self.userID
                //albumControllerObject.stringModuleId=self.stringModuleId
                //
                //       [[NSUserDefaults standardUserDefaults]setValue:@"No" forKey:@"session_IsComingFromImageSave"];
                
                //var varGetValue =  NSUserDefaults.standardUserDefaults().setValue("No", forKey: "session_IsComingFromImageSave")
                
                var varGetValue:String =  UserDefaults.standard.value(forKey: "session_IsComingFromImageSave")as! String
                if(varGetValue=="No")
                {
                    let imagePicker = BRImagePicker(presenting: self)
                    imagePicker?.show(dataBlock: { (data) in
                        if(data==nil)
                        {
                            
                        }
                        else
                        {
                            self.selectedAssetsArray = ((NSMutableArray(array: data!) as AnyObject)) as! NSMutableArray
                            print(self.selectedAssetsArray)
                        }
                    })
                }
                else
                {
                    UserDefaults.standard.setValue("No", forKey: "session_IsComingFromImageSave")
                    
                }
                //self.arrayGetAlbumPhotoListData.a
                // self.navigationController?.pushViewController(albumControllerObject, animated: true)
        }
        editAlbums.action =
            {
                item in print("Album...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
                
                albumControllerObject.titleForText = self.varNavigationTitle
                albumControllerObject.descriptionForAlbum = self.varDescription
                albumControllerObject.imageUrlForAlbumImage = self.imageUrlForAlbumImage
                albumControllerObject.annTypeStr = self.recipientType as! NSString
                albumControllerObject.stringModuleId = self.varModuleId
                albumControllerObject.isCalledFRom = "edit"
                albumControllerObject.grpID = self.varGroupId
                albumControllerObject.varAlbumID = self.varAlbumId
                albumControllerObject.createdByORUserIdOrProfileId = self.createdByORUserIdOrProfileId
                albumControllerObject.isAdmin = self.isAdmin
                albumControllerObject.isCategory=self.isCategory
                
                // albumControllerObject.grpID = self.varGroupId
                // albumControllerObject.createdByORUserIdOrProfileId = self.userID
                //albumControllerObject.stringModuleId=self.stringModuleId
                
                self.navigationController?.pushViewController(albumControllerObject, animated: true)
                
        }
        let invitation = ActionButtonItem(title: "Delete Photo", image: deleteAlbum)
        invitation.action =
            {
                item in print("Google Plus...")
                let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "DeletePhotoViewController") as! DeletePhotoViewController
                albumControllerObject.userID = self.userID
                albumControllerObject.varGroupId = self.varGroupId
                albumControllerObject.varAlbumId = self.varAlbumId //(dict.valueForKey("albumId")as! String)
                albumControllerObject.varNavigationTitle = self.varNavigationTitle//(dict.valueForKey("title")as! String)
                albumControllerObject.varDescription =  self.varDescription//(dict.valueForKey("description")as! String)
                self.navigationController?.pushViewController(albumControllerObject, animated: true)
        }
        actionButton = ActionButton(attachedToView: self.view, items: [invitation,editAlbums,phonebook])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State.normal)
        actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            // let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("session_NewImageAddedSuccess")
            if(varChangesInPhotos == UserDefaults.standard.string(forKey: "session_NewImageAddedSuccess"))
            {
                functionForFetchingAlbumList()
                UserDefaults.standard.setValue("NoChanges", forKey: "session_NewImageAddedSuccess")
                //varChangesInPhotos = "NoChanges"   // comment by DPK
            }
            else
            {
                
            }
        }
        else
        {
            
            //  self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       
         SVProgressHUD.dismiss()
        }
        
    
        self.colectionviewAlbumPhoto.reloadData()
        
        functionForViewDidLoad()
        self.navigationController?.isNavigationBarHidden=false
        //for getting album latest description
        functionForGetAlbumDerscription()
        
        
    }
    func functionForViewDidLoad()
    {
        colectionviewAlbumPhoto.showsVerticalScrollIndicator=false
//        self.edgesForExtendedLayout = []
        buttonExpandCollapse.setBackgroundImage(UIImage(named: "g_down_l"),  for: UIControl.State.normal)
        textviewDescription.isEditable=false
        textviewDescription.isScrollEnabled=true
        textviewDescription.text=varDescription
        textviewDescription.isSelectable=false
        
        
        var frame = textviewDescription.frame
        frame.size.height = 78
        textviewDescription.frame = frame
        textviewDescription.isScrollEnabled=false
        //collectin view setting
        //  Converted with Swiftify v1.0.6218 - https://objectivec2swift.com/
        /*
         let flow = UICollectionViewFlowLayout()
         flow.itemSize = CGSize(width: CGFloat(106), height: CGFloat(90))
         flow.scrollDirection = .Vertical
         flow.minimumInteritemSpacing = 0
         flow.minimumLineSpacing = 0
         colectionviewAlbumPhoto.collectionViewLayout = flow
         */
        
    }
    
    
    func functionForGetLastUpdateDate()->String
    {
        var varGetLastUpdateDate:String!=""
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT IsLastUpdateDate FROM Gallary_Album_Photo_Data where groupId='\(varGroupId!)' and albumId='\(varAlbumId!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true
            {
                
                varGetLastUpdateDate = results?.string(forColumn: "IsLastUpdateDate")
                print("Last Update Time--------------------->",varGetLastUpdateDate)
                
            }
            
            
        }
        return varGetLastUpdateDate
        
    }
    
    
    //MARK:- Server api calling
    func functionForFetchingAlbumList()
    {
        
       // loaderClass.loaderViewMethod()
        //        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        //        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        //        dispatch_async(backgroundQueue, {
        //            print("This is run on the background queue")
        //
        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
        //updatedOn = "1970-01-01 00:00:00"
        self.str = (defaults.value(forKey: Updatedefault) as! String?)!
        
        var varGetLastUpdateDate = self.functionForGetLastUpdateDate()
        if(varGetLastUpdateDate.characters.count>0 && varGetLastUpdateDate != "")
        {
            updatedOn = varGetLastUpdateDate
        }
        else
        {
            updatedOn = "1970-1-1 0:0:0"
        }
        
        print(varGetLastUpdateDate)
        print(updatedOn)
        
        //"1970/01/01 00:00:00"
        
        
        //code for by Rajendra Jat---
        let completeURL = baseUrl+k_API_GalleryGetAlbumPhotoList
        let parameterst = [
            k_API_GalleryPhotoListAlbumId : self.varAlbumId,
            k_API_GalleryPhotoListGroupId : self.varGroupId,
            k_API_GalleryPhotoListUpdatedOn : updatedOn
        ]
        print(completeURL)
        print(parameterst)
        DispatchQueue.main.async(execute: { () -> Void in
            print("This is run on the main queue, after the previous code in outer block")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print(response)
                print(response)
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                if((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    if (((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "updatedOn")) != nil)
                    {
                        UserDefaults.standard.set((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "updatedOn"), forKey: Updatedefault)
                        print(UserDefaults.standard.set((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "updatedOn"), forKey: Updatedefault))
                        
                    }
                    
                    print("•••••••••••••••••••••••••••••••")
                    print((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "updatedOn"))
                    
                    self.varLastUpdateDateForAddPhoto = ((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "updatedOn")) as! String
                    
                    self.arrayGetAlbumPhotoListData=CreateAlbumModel().saveServiceProviderListInfo(((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as! NSArray)))
                    print(self.arrayGetAlbumPhotoListData)
                    let arrDeleteGroupList = (((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "deletedPhotos")! as! String)
                    print(arrDeleteGroupList)
                    let arrUpdateGroupList = (((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "updatedPhotos")! as! NSArray)
                    print(arrUpdateGroupList)
                    
                    
                    if(arrDeleteGroupList.characters.count > 0)
                    {
                        // print("arrDeleteGroupList \(arrDeleteGroupList)")
                        self.DeleteDataInlocal((arrDeleteGroupList))
                        self.varChangesInPhotos = "Changes"
                    }
                    if(arrUpdateGroupList.count > 0)
                    {
                        print("arrDeleteGroupList \(arrUpdateGroupList)")
                        self.UpdateDataInlocal(arrUpdateGroupList)
                        self.varChangesInPhotos = "Changes"
                    }
                    
                    if(self.arrayGetAlbumPhotoListData.count > 0)
                    {
                        print("arrNewGroupList \(self.arrayGetAlbumPhotoListData)")
                        //save group data from local database
                        self.SaveDataInlocal(self.arrayGetAlbumPhotoListData)
                        print(self.arrayGetAlbumPhotoListData)
                        self.varChangesInPhotos = "Changes"
                        self.mainArray = NSMutableArray()
                        self.fetchData()
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
                }
                //self.colectionviewAlbumPhoto.reloadData()
                
                /*«««««««««««««««--code by rajendra jat temp code----»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
                
                /*
                 let fsdf =  (((response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")! as! NSArray)))
                 print(fsdf)
                 
                 for i in 0..<response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")!.count
                 {
                 self.muarrayHoldingImageUrl.addObject(response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")!.valueForKey("url")!.objectAtIndex(i))
                 self.muarrayHoldingImageDescription.addObject(response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")!.valueForKey("description")!.objectAtIndex(i))
                 
                 }
                 */
                
//                var varGetCount=response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")!.count
//                if(varGetCount>0)
//                {
//                    self.buttonMessage.hidden=true
//                }
//                else
//                {
//                    //self.buttonMessage.hidden=false
//                    
//                }
                /*«««««««««««««««------»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
                // muarrayHoldingImageUrl
                // muarrayHoldingImageDescription
                /*«««««««««««««««------»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
                
                SVProgressHUD.dismiss()
            }
            })
            
            
        })
        //})
    }
    
    func fetchData()
    {
        mainArray = NSMutableArray()
       // loaderClass.loaderViewMethod()
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
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT * FROM Gallary_Album_Photo_Data where groupId='\(varGroupId!)' and albumId='\(varAlbumId!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            muarrayHoldingImageUrl=NSMutableArray()
            muarrayHoldingImageDescription=NSMutableArray()
            muarrayHoldingPhotoId=NSMutableArray()
            
            
            while results?.next() == true
            {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "url"))! as String, forKey:"url")
                dd.setValue((results?.string(forColumn: "description"))! as String, forKey:"description")
                dd.setValue((results?.string(forColumn: "albumId"))! as String, forKey:"albumId")
                dd.setValue((results?.string(forColumn: "photoId"))! as String, forKey:"photoId")
                
                
                muarrayHoldingImageUrl.add((results?.string(forColumn: "url"))!)
                
                var varGetDescription = (results?.string(forColumn: "description"))
                if(varGetDescription?.characters.count>0 && varGetDescription != "(null)")
                {
                    muarrayHoldingImageDescription.add((results?.string(forColumn: "description"))!)
                }
                else
                {
                    
                    muarrayHoldingImageDescription.add("")
                    
                }
                muarrayHoldingPhotoId.add((results?.string(forColumn: "photoId"))!)
                
                
                
                
                //website
                // NoRecordLabel.hidden=true
                
                print(dd)
                mainArray.add(dd)
                arrayGetAlbumPhotoListData = mainArray
                
            }
            
            self.colectionviewAlbumPhoto.reloadData()
            self.loaderClass.window = nil
            
            if mainArray.count > 0
            {
                //checkRow = ""
                buttonMessage.isHidden = true
                //copymainArray=mainArray
            }
            else
            {
                //  checkRow = "1"
                buttonMessage.isHidden = false
               // self.view.makeToast("No Results", duration: 2, position: CSToastPositionCenter)
                mainArray = NSMutableArray()
                // copymainArray=NSArray()
            }
            
        }
        
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
                var varGetValue = (dict.object(forKey: "description"))
                var replacedDescription:String=""
                if(varGetValue==nil)
                {
                    varGetValue=""
                }
                else
                {
                    varGetValue = (dict.object(forKey: "description"))as! String
                    replacedDescription  = (varGetValue as! NSString).replacingOccurrences(of: "'", with: "`")
                    
                }
                print("------------->Description ",replacedDescription)
                
                let insertSQL = "INSERT INTO Gallary_Album_Photo_Data (masterUID ,description, groupId, albumId, photoId, url ,IsLastUpdateDate) VALUES ('\(mainMemberID!)','"+replacedDescription+"', '\(varGroupId!)','\(varAlbumId!)','\(dict.object(forKey: "photoId") as! String)','\(dict.object(forKey: "url") as! String)','"+varLastUpdateDateForAddPhoto+"')"
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
                
                print(dict.object(forKey: "description"))
                
                let varGetValue = (dict.object(forKey: "description") as! String)
                let replacedDescription  = (varGetValue as NSString).replacingOccurrences(of: "'", with: "`")
                
                
                print("------------->Description ",replacedDescription)
                
                var insertSQL = ""
                insertSQL = "UPDATE Gallary_Album_Photo_Data SET  masterUID ='\(mainMemberID!)',description ='\(replacedDescription)' , groupId ='\(varGroupId!)' , albumId ='\(varAlbumId!)', photoId ='\(dict.object(forKey: "photoId") as! String )' , url = '\(dict.object(forKey: "url") as! String)' where photoId ='\(dict.object(forKey: "photoId") as! String )'"
                print(insertSQL)
                let result = contactDB?.executeStatements(insertSQL)
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("Update Success saved")
                    print(databasePath);
                    
                }
            }
        } else {
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
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            for i in 0 ..< varGetValueAlbumId.count {
                //let  dict = arrdata[i] as! NSDictionary
                let insertSQL = "DELETE FROM Gallary_Album_Photo_Data WHERE photoId = '\(varGetValueAlbumId[i])' and albumId = '\(varAlbumId)' and groupId = '\(varGroupId)' "
                print(insertSQL)
                
                let result = contactDB?.executeStatements(insertSQL)
                
                if (result == nil) {
                    print("ErrorAi: \(contactDB?.lastErrorMessage())")
                } else {
                    print("Deleted success")
                    print(databasePath);
                }
            }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        
    }
    
    
    //--set navigation  button left and right
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = varNavigationTitle as String
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
        
        //        let editB = UIButton(type: UIButton.ButtonType.custom)
        //        editB.frame = CGRectMake(50, 0, 30, 40)
        //        editB.setImage(UIImage(named:"overflow_btn"), forState: UIControl.State.Normal)
        //        editB.addTarget(self, action: #selector(CreateAlbumViewController.RightDropDownAction), forControlEvents: UIControl.Event.TouchUpInside)
        //let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        //// let buttons : NSArray = [edit]
        //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func RightDropDownAction()
    {
        
    }
    @IBAction func buttonbuttonExpandCollapseClickEvent(_ sender: AnyObject)
    {
        
        if(varExpandCollepse==0)
        {
            //  buttonExpandCollapse.setImage(UIImage(named: "g_up_l"), forState: UIControl.State.Normal)
            buttonExpandCollapse.setBackgroundImage(UIImage(named: "g_up_l"),  for: UIControl.State.normal)
            varExpandCollepse=1
            textviewDescription.text=textviewDescription.text
            
            var frame = textviewDescription.frame
            frame.size.height = 155
            textviewDescription.frame = frame
            buttonExpandCollapse.frame.origin = CGPoint(x: 0, y: 126)
            colectionviewAlbumPhoto.frame.origin = CGPoint(x: 0, y: 177)
            textviewDescription.isScrollEnabled=true
            
        }
        else
        {
            buttonExpandCollapse.setBackgroundImage(UIImage(named: "g_down_l"),  for: UIControl.State.normal)
            varExpandCollepse=0
            textviewDescription.text=textviewDescription.text
            var frame = textviewDescription.frame
            frame.size.height = 78
            textviewDescription.frame = frame
            buttonExpandCollapse.frame.origin = CGPoint(x: 0, y: 81)
            colectionviewAlbumPhoto.frame.origin = CGPoint(x: 0, y: 132)
            textviewDescription.isScrollEnabled=false
            
        }
    }
    
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrayGetAlbumPhotoListData.count
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumPhotosCell
        if(arrayGetAlbumPhotoListData.count>0)
        {
            prototypeCell.configureCellServicesProviderList(arrayGetAlbumPhotoListData.object(at: indexPath.row) as! NSDictionary)
            prototypeCell.buttonMain.addTarget(self, action: #selector(AlbumPhotosViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonMain.tag=indexPath.row
        }
        return prototypeCell
    }
    //    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    //    {
    //        return CGSize(width: self.view.frame.size.width/3, height: 110)
    //    }
    
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        
        
        /*//DPK
        NSUserDefaults.standardUserDefaults().setValue(self.varAlbumId, forKey: "session_AlbumID")

        var objPhotoShowWithDescriptionViewController:PhotoShowWithDescriptionViewController = PhotoShowWithDescriptionViewController()
        objPhotoShowWithDescriptionViewController.varGroupId=varGroupId
        self.navigationController?.pushViewController(objPhotoShowWithDescriptionViewController, animated: true)
        //DPK*/
        
        
        let objMenu:Menu=Menu()
        // mainArray.addObject(dd)
        
        
        if(self.isAdmin=="No")
        {
            objMenu.strFromDistrictGallery="strFromDistrictGallerys"
        }
        else
        {
            
        }
        objMenu.muarrayHoldingImageUrl=muarrayHoldingImageUrl
        objMenu.muarrayHoldingImageDescription=muarrayHoldingImageDescription
        objMenu.muarrayHoldingPhotoId=muarrayHoldingPhotoId
        objMenu.strSelectedPhotoIndex=String(sender.tag)
        print(muarrayHoldingImageUrl.count)
        UserDefaults.standard.setValue(self.userID, forKey: "session_createdByORUserIdOrProfileId")
        UserDefaults.standard.setValue(self.varAlbumId, forKey: "session_AlbumID")
        self.navigationController?.pushViewController(objMenu, animated: true)
        
        /*
         var objMWPhotoBrowser:MWPhotoBrowser=MWPhotoBrowser()
         objMWPhotoBrowser.muarrayHoldingImageUrl=muarrayHoldingImageUrl
         objMWPhotoBrowser.muarrayHoldingImageDescription=muarrayHoldingImageDescription
         objMWPhotoBrowser.strSelectedPhotoIndex=String(sender.tag)
         self.navigationController?.pushViewController(objMWPhotoBrowser, animated: true)
         
         */
        
        
        
    }
    func functionForGetAlbumDerscription()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID =  UserDefaults.standard.string(forKey: "session_GetModuleId")
        let grpIDs =  UserDefaults.standard.string(forKey: "session_GetGroupId")
        
        if (contactDB?.open())!
        {
            let querySQL = "SELECT * FROM GALLERY_MASTER where groupId = '\(grpIDs!)' and moduleId='\(mainMemberID!)' and albumId ='\(varAlbumId)'"
            
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL, withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "description"))! as String, forKey:"description")
                //website
                // NoRecordLabel.hidden=true
                print(dd)
                textviewDescription.text=dd.value(forKey: "description")as! String
                break
                // mainArray.addObject(dd)
            }
            
        }
    }
    
    
   
    
}
