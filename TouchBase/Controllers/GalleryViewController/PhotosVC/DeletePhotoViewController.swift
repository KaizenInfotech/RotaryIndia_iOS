//
//  DeletePhotoViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Photos
import MWPhotoBrowser
import Alamofire

class DeletePhotoViewController: UIViewController , webServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    let loaderClass  = WebserviceClass()
    //MARK:- Outlet
    
    var actionButton: ActionButton!
    //Public Variable
    var userID:String!=""
    var varGroupId:String!=nil
    var varAlbumId:String!=nil
    var varNavigationTitle:String!=nil
    var varDescription:String!=nil
    var varGetAlbumPhotoID:String! = ""
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var mainArray : NSMutableArray!
    
    var indexForSelectedLocalDataDelete:Int=0
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet var buttonMessage: UIButton!
    var arrayGetAlbumPhotoListData:NSMutableArray=NSMutableArray()
    var varExpandCollepse:Int=0
    var prototypeCell:DeletePhotoCell=DeletePhotoCell()
    let reuseIdentifier = "cell"
    //var arrayAlbumPhotoListData:NSArray=NSArray()
    var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
    var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
    //IB Outlet
    @IBOutlet var textviewDescription: UITextView!
    @IBOutlet var buttonExpandCollapse: UIButton!
    
    @IBOutlet var colectionviewAlbumPhoto: UICollectionView!
    
    
    var appDelegate : AppDelegate!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        functionForSetLeftNavigation()
        buttonMessage.isHidden=true
        viewPopup.isHidden = true
        buttonOpticity.isHidden = true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.mainArray = NSMutableArray()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        functionForViewDidLoad()
        self.navigationController?.isNavigationBarHidden=false
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
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewPopup.isHidden=true
        buttonOpticity.isHidden=true
        //varGetAlbumID="0"
    }
    
    @IBAction func buttonYesClickEvent(_ sender: AnyObject)
    {
        viewPopup.isHidden = true
        buttonOpticity.isHidden = true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            functionForDeleteAlbum()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            viewPopup.isHidden = true
            buttonOpticity.isHidden = true
            
             SVProgressHUD.dismiss()
        }
        print("yes")
    }
    @IBAction func buttonNoClickEvent(_ sender: AnyObject)
    {
        print("no")
        viewPopup.isHidden=true
        buttonOpticity.isHidden=true
        //varGetAlbumID="0"
        //albumDeleteConfirmOrNot = "confirmNot"
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
        self.navigationController?.navigationBar.barTintColor = UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateAlbumViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Loader Method
    /*
    func loaderViewMethod()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        //let url = NSBundle.mainBundle().URLForResource("tb_preloader8", withExtension: "gif")
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")

        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        //                gifView.contentMode = .Center
        Loadingview.addSubview(gifView)
        window?.addSubview(Loadingview)
        
    }
    */
    //Get Data Local
    func fetchData(){
       // loaderClass.loaderViewMethod()
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
            let querySQL = "SELECT * FROM Gallary_Album_Photo_Data where groupId = '\(varGroupId!)' and albumId='\(varAlbumId!)'"
            print(querySQL)
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            while results?.next() == true
            {
                print((results?.string(forColumn: "groupId"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "groupId"))! as String, forKey:"groupId")
                dd.setValue((results?.string(forColumn: "url"))! as String, forKey:"url")
                dd.setValue((results?.string(forColumn: "description"))! as String, forKey:"description")
                dd.setValue((results?.string(forColumn: "albumId"))! as String, forKey:"albumId")
                dd.setValue((results?.string(forColumn: "photoId"))! as String, forKey:"photoId")
                print(dd)
                mainArray.add(dd)
                arrayGetAlbumPhotoListData = mainArray
            }
            self.colectionviewAlbumPhoto.reloadData()
            self.loaderClass.window = nil
            if mainArray.count > 0
            {
                buttonMessage.isHidden = true
            }
            else
            {
                buttonMessage.isHidden = false
                mainArray = NSMutableArray()
            }
        }
    }
    //Delete From Local
    func DeleteDataInlocal()
    {
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
        if (contactDB?.open())! {
            let insertSQL = "DELETE FROM Gallary_Album_Photo_Data WHERE photoId = '\(varGetAlbumPhotoID)'"
            print(insertSQL)
            
            let result = contactDB?.executeStatements(insertSQL)
            
            if (result == nil) {
                print("ErrorAi: \(contactDB?.lastErrorMessage())")
            } else {
                print("success deleted")
                print(databasePath);
                // self.fetchData()
                UserDefaults.standard.setValue("Changes", forKey: "IfAnyChanges")
            }
            // }
            
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
    }
    //MARK:Delete Photo Server Caling Function
    func functionForDeleteAlbum()
    {
       // loaderViewMethod()
        print(varGetAlbumPhotoID)
        print(varAlbumId)
        print(userID)
        let varMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var urlStr = baseUrl+touchBase_DeleteAlbumPhoto
        // define parameters
        let parameters = ["photoId": self.varGetAlbumPhotoID , "albumId": self.varAlbumId , "deletedBy": self.userID]
        // Begin upload
        print(parameters)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: urlStr, parameters: parameters, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            let dictResponseData = response as! NSDictionary
            print("dd \(dictResponseData)")
            print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let message = (dictResponseData.value(forKey: "TBDelteAlbumPhoto")! as AnyObject).value(forKey: "message") as! String
            if(message=="failed")
            {
                print("Hello Filed")
                self.window=nil;
            }
            else
            {
                // self.functionForFetchingAlbumList()
                print("Hello Success")
                self.DeleteDataInlocal()
                
                UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
                self.arrayGetAlbumPhotoListData.removeObject(at: self.indexForSelectedLocalDataDelete)
                self.colectionviewAlbumPhoto.reloadData()
                

                let alert = UIAlertController(title: "Album", message: "Deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                if(self.arrayGetAlbumPhotoListData.count==0)
                {
                    self.present(alert, animated: true, completion: nil)
                }
                               //self.presentViewController(alert, animated: true, completion: nil)
                self.window=nil;
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    //MARK:- Server api calling
    func functionForFetchingAlbumList()
    {
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            print("This is run on the background queue")
            //code for by Rajendra Jat---
            let completeURL = baseUrl+k_API_GalleryGetAlbumPhotoList
            let parameterst = [
                k_API_GalleryPhotoListAlbumId : self.varAlbumId,
                k_API_GalleryPhotoListGroupId : self.varGroupId,
                k_API_GalleryPhotoListUpdatedOn : "1970/01/01 00:00:00"
            ]
            print(completeURL)
            print(parameterst)
            DispatchQueue.main.async(execute: { () -> Void in
                print("This is run on the main queue, after the previous code in outer block")
                ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                    //=> Handle server response
                    print(response)
                   // print(response)
                    var varGetValueServerError = response.object(forKey: "serverError")as? String
                    if(varGetValueServerError == "Error")
                    {
                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                    //self.arrayGetAlbumPhotoListData=CreateAlbumModel().saveServiceProviderListInfo(((response.valueForKey("TBAlbumPhotoListResult")!.valueForKey("Result")!.valueForKey("newPhotos")! as! NSArray)))
                    // print(self.arrayGetAlbumPhotoListData)
                    self.colectionviewAlbumPhoto.reloadData()
                    
                    /*«««««««««««««««--code by rajendra jat temp code----»»»»»»»»»»»»»»»»»»»»»»»»»»»*/
                    let fsdf =  (((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as! NSArray)))
                    print(fsdf)
                    
                    for i in 0..<(((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).count
                    {
                        self.muarrayHoldingImageUrl.add(((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "url")! as AnyObject).object(at: i))
                        self.muarrayHoldingImageDescription.add(((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "description")! as AnyObject).object(at: i))
                    }
                    
                    var varGetCount:Int!=(((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).count
                    if(varGetCount>0)
                    {
                        self.buttonMessage.isHidden=true
                    }
                    else
                    {
                        self.buttonMessage.isHidden=false
                        
                    }
                    SVProgressHUD.dismiss()
                }
                })
            })
        })
    }
    
    
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrayGetAlbumPhotoListData.count
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  
    {
        prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DeletePhotoCell
        if(arrayGetAlbumPhotoListData.count>0)
        {
            prototypeCell.configureCellServicesProviderList(arrayGetAlbumPhotoListData.object(at: indexPath.row) as! NSDictionary)
            prototypeCell.buttonDeletePhoto.addTarget(self, action: #selector(DeletePhotoViewController.buttonDeleteClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonDeletePhoto.tag=indexPath.row
        }
        return prototypeCell
    }
    
    @objc func buttonDeleteClickEvent(_ sender:UIButton)
    {
        let row = sender.tag
        indexForSelectedLocalDataDelete = row
        print("Row: \(row)")
        let dict:NSDictionary = (arrayGetAlbumPhotoListData.object(at: row) as! NSDictionary)
        print(dict)
        varGetAlbumPhotoID = (dict.value(forKey: "photoId")as! String)
        print(varGetAlbumPhotoID)
        viewPopup.isHidden = false
        buttonOpticity.isHidden = false
        
        
        //        var objMenu:Menu=Menu()
        //        objMenu.muarrayHoldingImageUrl=muarrayHoldingImageUrl
        //        objMenu.muarrayHoldingImageDescription=muarrayHoldingImageDescription
        //        objMenu.strSelectedPhotoIndex=String(sender.tag)
        //        self.navigationController?.pushViewController(objMenu, animated: true)
    }
    
    
    
}
