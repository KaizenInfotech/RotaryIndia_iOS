//
//  DeleteCreatedAlbumViewController.swift
//  TouchBase
//
//  Created by Umesh on 10/01/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import PhotosUI
import Photos
import Alamofire
import SDWebImage
//import LiquidFloatingActionButton
class DeleteCreatedAlbumViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,webServiceDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource
{
    //floating button
    var actionButton: ActionButton!
    @IBOutlet weak var btnshowText: UIButton!
    @IBOutlet var expandView: UIView!
    @IBOutlet var expandTextView: UITextView!
    @IBOutlet var expandBtn: UIButton!
    //MARK:- Outlet
    @IBOutlet var viewAsGridList: UIView!
    
    @IBOutlet var collectionviewAlbum: UICollectionView!
    
    var categoryID:String!=""
    var Year:String!=""
    @IBOutlet var tableviewAlbum: UITableView!
    @IBOutlet var buttonOpacity: UIButton!
    
    @IBOutlet var viewPopup: UIView!
    var appDelegate : AppDelegate!
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    var albumDeleteConfirmOrNot:String! = ""
    //MARK:- Local Variable
    var stringModuleId:String! = ""
    var mainArray : NSMutableArray!
    var moduleID:String!=""
    //MARK:- Public Variable
    var varGetAlbumID:String!=nil
    var varGetAlbumIDForDelete:String!=""
    var varOpenPopUpGridList:Int=0
    //var muarrayListData:NSMutableArray=NSMutableArray()
    var muarrayListData:NSArray=NSArray()
    var grpID:String! = nil
    var  userID:String! = nil
    let reuseIdentifier = "cell"
    var prototypeCell:CreateAlbumViewCell=CreateAlbumViewCell()
    var prototypeCells:CreateAlbumTableViewCell=CreateAlbumTableViewCell()
    var indexForSelectedLocalDataDelete:Int=0
    //MARK:- Navigation grid/list button
    var editB = UIButton(type: UIButton.ButtonType.custom)
    //MARK:- Array,Dictionary Declaration
    var muarrayAlbumList:NSMutableArray=NSMutableArray()
    //MARK:- Class object
    override func viewDidLoad()
    {
        
        view.backgroundColor=UIColor.white
        
        functionForSetLeftNavigation()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        functionForFetchingAlbumList()
        functionForViewDidLoad()
//        self.edgesForExtendedLayout = []
    }
    func functionForViewDidLoad()
    {
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
        viewAsGridList.isHidden=true
        viewAsGridList.superview?.bringSubviewToFront( viewAsGridList)
    }
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreateAlbumViewCell
        print(muarrayListData.count)
        if(muarrayListData.count>0)
        {
            
            let titiel = (muarrayListData.value(forKey: "title") as AnyObject).object(at: indexPath.row) as! String
            prototypeCell.labelTitle.text = titiel
            let varImage = (muarrayListData.value(forKey: "image") as AnyObject).object(at: indexPath.row) as! String
            if varImage == ""
            {
                prototypeCell.imageAlbum.image = UIImage(named: "logo")
            }
            else
            {
                let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                prototypeCell.imageAlbum.sd_setImage(with: checkedUrl)
            }
            
            
            
            
            prototypeCell.buttonDetailClickEvent.addTarget(self, action: #selector(DeleteCreatedAlbumViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonDetailClickEvent.tag=indexPath.row
        }
        
        return prototypeCell
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
            //prototypeCells.configureCellServicesProviderList(muarrayListData.objectAtIndex(indexPath.row) as! NSDictionary)
            //prototypeCells.buttonDelete.hidden=false
            //prototypeCells.buttonDelete.addTarget(self, action: #selector(DeleteCreatedAlbumViewController.buttonDeletelickEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            //prototypeCells.buttonDelete.tag = indexPath.row
        }
        return prototypeCells
    }
    
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        
        let row = sender.tag
        indexForSelectedLocalDataDelete = row
        print("Row: \(row)")
        let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
        varGetAlbumID=(dict.value(forKey: "type")as! String)
        varGetAlbumIDForDelete = (dict.value(forKey: "albumId")as! String)
        print(dict)
        viewPopup.isHidden = false
        buttonOpacity.isHidden = false
        //        if(albumDeleteConfirmOrNot == "confirm")
        //        {
        //         functionForDeleteAlbum()
        //         albumDeleteConfirmOrNot = "confirmNot"
        //
        //        }
        print("Hellooooooo")
    }
    //delete album
    func buttonDeletelickEvent(_ sender:UIButton)
    {
        let row = sender.tag
        print("Row: \(row)")
        let dict:NSDictionary = (muarrayListData.object(at: row) as! NSDictionary)
        varGetAlbumID=(dict.value(forKey: "type")as! String)
        varGetAlbumIDForDelete = (dict.value(forKey: "albumId")as! String)
        print(varGetAlbumID)
        viewPopup.isHidden = false
        buttonOpacity.isHidden = false
        buttonOpacity.isHidden=false
        viewPopup.isHidden=false
    }
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
        varGetAlbumID="0"
    }
    
    @IBAction func buttonYesClickEvent(_ sender: AnyObject)
    {
        albumDeleteConfirmOrNot = "confirm"
        viewPopup.isHidden = true
        buttonOpacity.isHidden = true
        
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            functionForDeleteAlbum()
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            viewPopup.isHidden = true
            buttonOpacity.isHidden = true
        }
        print("yes")
    }
    
    
    @IBAction func buttonNoClickEvent(_ sender: AnyObject)
    {
        print("no")
        viewPopup.isHidden=true
        buttonOpacity.isHidden=true
        varGetAlbumID="0"
        albumDeleteConfirmOrNot = "confirmNot"
    }
    /*
     buttonOpacity
     */
    
    
    func functionForDeleteAlbum()
    {
       // loaderViewMethod()
        let varMemberID = UserDefaults.standard.string(forKey: "masterUID")
        var urlStr = baseUrl+touchbase_DeleteAlbum
        // define parameters
        let params = ["typeID": self.varGetAlbumIDForDelete!, "type": "Gallery" , "profileID": self.userID!]
        /*-------------------------------------------------------------*/
        let url = URL(string: baseUrl+touchbase_DeleteAlbum)!
        
        print(url)
        print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            switch response.result {
            case .success:
                // var result = [String:String]()
                if response.result.value != nil
                {
                    print( response.result.value)
                    var dictResponseData:NSDictionary=NSDictionary()
                    dictResponseData = response.result.value as! NSDictionary
                    print(dictResponseData)
                    let message = (dictResponseData.value(forKey: "DeleteResult")! as AnyObject).value(forKey: "message")as! String
                    if(message=="failed")
                    {
                        print("Hello Filed")
                        self.window=nil;
                    }
                    else
                    {
                        self.functionForFetchingAlbumList()
                        print("Hello Success")
                        self.window=nil;
                        let alert = UIAlertController(title: "Album", message: "Album Deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                            self.collectionviewAlbum.reloadData()
                            self.navigationController?.popViewController(animated: true)
                        }));
                        UserDefaults.standard.setValue("Changes", forKey: "IfAnyChanges")
                        if(self.muarrayListData.count==0)
                        {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(_): break
            }
        }
    }
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//
//    }
    
    //MARK:- Server api calling
    func functionForFetchingAlbumList()
    {
      //  loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetAlbumsList_New"
        var parameterst:NSDictionary=NSDictionary()
        parameterst =  ["groupId":self.grpID,
                        "district_id":"",
                        "club_id":"",
                        "category_id":categoryID,
                        "year":Year,
                        "SharType":"1",
                        "profileId":self.userID,
                        "moduleId":self.stringModuleId ]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
                let arrarrNewGroupList = (((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "newAlbums")) as! NSArray
                
                self.muarrayListData = arrarrNewGroupList
                if(self.muarrayListData.count>0)
                {
                    //self.buttonNoResult.hidden=true
                }
                else
                {
                    // self.buttonNoResult.hidden=false
                }
                self.collectionviewAlbum.reloadData()
                
                
                self.window = nil
            }
            else if((dd.object(forKey: "TBAlbumsListResult")! as AnyObject).object(forKey: "status") as! String == "Record not found")
            {
                
                self.window = nil
                UserDefaults.standard.setValue("Changes", forKey: "IfAnyChanges")
                self.navigationController?.popViewController(animated: true)
                
            }
                
            else
                
            {
                
                self.window = nil
                
            }
            SVProgressHUD.dismiss()
            }
        })
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //--set navigation  button left and right
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Delete Album" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white//(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DeleteCreatedAlbumViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        //        editB = UIButton(type: UIButton.ButtonType.custom)
        //        editB.frame = CGRectMake(50, 0, 20, 20)
        //        editB.setImage(UIImage(named:"gridGallery"), forState: UIControl.State.Normal)
        //        editB.addTarget(self, action: #selector(DeleteCreatedAlbumViewController.RightDropDownAction), forControlEvents: UIControlEvents.TouchUpInside)
        //        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        //        let buttons : NSArray = [edit]
        //        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     func RightDropDownAction()
     {
     //viewAsGridList.hidden=true
     
     //if(varOpenPopUpGridList==0)
     //{
     editB.setImage(UIImage(named:"gridGallery"), forState: UIControl.State.Normal)
     varOpenPopUpGridList=1
     viewAsGridList.hidden=false
     self.tableviewAlbum.hidden=true
     self.collectionviewAlbum.hidden=false
     //self.tableviewAlbum.reloadData()
     // prototypeCells.buttonDelete.hidden = true
     //        }
     //        else
     //        {
     //            varOpenPopUpGridList=0
     //            viewAsGridList.hidden=true
     //            self.collectionviewAlbum.hidden=false
     //            // prototypeCells.buttonDelete.hidden = false
     //            self.tableviewAlbum.hidden=true
     //            editB.setImage(UIImage(named:"listGallary"), forState: UIControl.State.Normal)
     //        }
     }
     
     
     */
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
}
