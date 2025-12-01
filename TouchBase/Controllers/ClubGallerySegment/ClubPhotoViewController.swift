//
//  ClubPhotoViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Photos
import MWPhotoBrowser
//import LiquidFloatingActionButton
//import Kingfisher
import SDWebImage
import Alamofire

class HorizontalCollection: UICollectionViewCell {
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var viewHori: UIView!
}

class DetialTVC:UITableViewCell{

    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var btneye: UIButton!
    @IBOutlet weak var lbl: UILabel!
}



class ClubPhotoViewController: UIViewController , webServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource
{
    
    fileprivate var images:[Image] = []
    let loaderClass  = WebserviceClass()
    var actionButton: ActionButton!
    var varLastUpdateDateForAddPhoto:String! = ""
    var AgendaDocUrl:String!=""
    var MOMDocUrl:String!=""

    //------From Album info------DPK
    var recipientType:String! = ""
    var varModuleId:String! = ""
    var imageUrlForAlbumImage:String! = ""
    var createdByORUserIdOrProfileId:String! = ""
    var isAdmin:String! = ""
    var selectedAssetsArray : NSMutableArray = NSMutableArray()
    var muDictionryPhotoList:NSMutableDictionary=NSMutableDictionary()
    var muarrayGridPhotoCollection:NSMutableArray=NSMutableArray()

    @IBOutlet weak var clubTableView: UITableView!
    //Public Variable
    var str:String! = ""
    var userID:String! = ""
    var varGroupId:String!=nil
    var varAlbumId:String!=nil
    var YearStr:String!=nil
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
    var muarrayKEY:NSMutableArray=NSMutableArray()
    var muarrayVALUE:NSMutableArray=NSMutableArray()
    var TempArray:NSMutableArray = []
    var TempArrayName:NSMutableArray = []

    
    //IB Outlet
    @IBOutlet var textviewDescription: UITextView!
    @IBOutlet var buttonExpandCollapse: UIButton!
    @IBOutlet var colectionviewAlbumPhoto: UICollectionView!
    //@IBOutlet weak var lblActivityTitle: UILabel!
    @IBOutlet weak var colectionViewHorizontal: UICollectionView!
    
    var appDelegate : AppDelegate!
    var varChangesInPhotos:String = ""
    //MARK:- New IBOutlet on April 2020
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var btnMediaTitle: UIButton!
    @IBOutlet weak var btnPhotoTitle: UIButton!
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    //MARK:- New var add on April 2020
    var originalMediaFrame:CGRect=CGRect()
    var originalPhotoFrame:CGRect=CGRect()
    var mediaPhotoPAth:String=""
    var mediaPhotoDesc:String=""

    
    override func viewDidLoad()
    {
        
        print("ALBUMID:--\(varAlbumId)")
        print("GROUPID:--\(varGroupId)")
        UserDefaults.standard.setValue("No", forKey: "session_IsComingFromImageSave")
        varChangesInPhotos = "Changes"
        UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
        functionForSetLeftNavigation()
        self.mainArray = NSMutableArray()
        buttonMessage.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        setMediaPhotoView()
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            SVProgressHUD.show()
            functionForFetchingAlbumList()
            functionForGetAlbumDetails_New()
        }
        else
        {
             SVProgressHUD.dismiss()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(mediaPicClickEvent))
        mediaImageView.addGestureRecognizer(tap)
        mediaImageView.isUserInteractionEnabled = true

    }
    
    @objc func mediaPicClickEvent()
        {
     if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "MediaPhotoViewController") as! MediaPhotoViewController
        viewController.mediaPhotoPath=mediaPhotoPAth
        viewController.mediaDesc=mediaPhotoDesc
        self.navigationController?.pushViewController(viewController, animated: true)
    }
     else
     {
      self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
     }
    }
    
    func setMediaPhotoView()
    {
        originalMediaFrame=self.mediaView.frame
        originalPhotoFrame=self.photoView.frame
    }

    override func viewWillAppear(_ animated: Bool)
    {
      self.navigationController?.navigationBar.isHidden=false
      self.navigationItem.setHidesBackButton(false, animated: false)
        functionForViewDidLoad()
        functionForSetLeftNavigation()
        //for getting album latest description
        //functionForGetAlbumDerscription()
    }
    func functionForViewDidLoad()
    {
        colectionviewAlbumPhoto.showsVerticalScrollIndicator=false
//        self.edgesForExtendedLayout = []
        //buttonExpandCollapse.setBackgroundImage(UIImage(named: "g_down_l"),  for: UIControl.State.normal)
        textviewDescription.text=varDescription
        textviewDescription.isEditable=false
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
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
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
        var mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        //code for by Rajendra Jat---
        let completeURL = baseUrl+k_API_GalleryGetAlbumPhotoList
        var parameterst:NSDictionary=NSDictionary()
        parameterst = [
            k_API_GalleryPhotoListAlbumId : self.varAlbumId,
            k_API_GalleryPhotoListGroupId : self.varGroupId,
            "Financeyear" : YearStr,
            k_API_GalleryPhotoListUpdatedOn : "1970-1-1 0:0:0"
        ]
        
//
        
//        [albumId=8292, updatedOn=1970/01/01 00:00:00, groupId=31363, Financeyear=2021-2022]
        print(completeURL)
        print(parameterst)
        DispatchQueue.main.async(execute: { () -> Void in
            print("This is run on the main queue, after the previous code in outer block")
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print(response)
                //print(response)
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
                    print((response.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "updatedOn"))
                    for i in 0..<((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "albumId")! as AnyObject).count
                    {
                        /* "newPhotos": [
                         {
                         "photoId": "338",
                         "url": "http://www.rosteronwheels.com/Documents/gallery/Group2765/Album67/login07072017102303AM.jpg",
                         "description": ""
                         }] */
                        
                        let photoId=(((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "photoId")! as AnyObject).object(at: i)) as! String
                        let description=((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "description")! as AnyObject).object(at: i) as! String
                        let image=(((((response.value(forKey: "TBAlbumPhotoListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "newPhotos")! as AnyObject).value(forKey: "url")! as AnyObject).object(at: i)) as! String
                        
                        
                        self.muarrayHoldingImageUrl.add(image)
                        self.muarrayHoldingImageDescription.add(description)
                        self.muarrayHoldingPhotoId.add(photoId)
                        
                        self.muDictionryPhotoList=["photoId": photoId,"description": description,"image": image]
                        print(self.muDictionryPhotoList)
                        self.muarrayGridPhotoCollection.add(self.muDictionryPhotoList)
                        print("33333333333333333333333333333333333333",self.muarrayGridPhotoCollection.count)
                    }
                    self.colectionviewAlbumPhoto.reloadData()
                    self.getImages()
                    self.clubTableView.reloadData()
                    self.clubTableView.estimatedRowHeight = 285.0
                    self.clubTableView.rowHeight = UITableView.automaticDimension
                    self.loaderClass.window = nil
                    if self.muarrayGridPhotoCollection.count>0{
                    self.photoView.isHidden=false
                    }else
                    {
                        self.photoView.isHidden=true
                    }
                }
                else
                {
                    self.loaderClass.window = nil
                }
                }
            })
            
            
        })
        //})
    }
    
    
    //--set navigation  button left and right
    func functionForSetLeftNavigation()
    {
       // self.navigationItem.setHidesBackButton(true, animated: false)
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
    
    func functionForGetAlbumDetails_New()
       {
           SVProgressHUD.show()
           let completeURL = baseUrl+"Gallery/GetAlbumDetails_New"
           var parameterst:NSDictionary=NSDictionary()

//        GetAlbumDetails_New :-
//        [albumId=8292, Financeyear=2021-2022]
//        GetAlbumDetails_New :-
//        [albumId=8292, Financeyear=2021-2022]
        parameterst =  ["albumId":varAlbumId as Any,
                        "Financeyear" :YearStr as Any]
           print(parameterst)
           print(completeURL)
           ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
               //=> Handle server response
               let dd = response as! NSDictionary
               print("New list VC dd \(dd)")
               print(response)
               let varGetValueServerError = response.object(forKey: "serverError")as? String
               if(varGetValueServerError == "Error")
               {
                   self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                   SVProgressHUD.dismiss()
               }
               else
               {
               if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
               {
                   let arrarrNewGroupList = (dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "AlbumDetailResult") as! NSArray
                   let muarrayListData = arrarrNewGroupList.value(forKey: "AlbumDetail") as! NSArray
                   print(muarrayListData)
                   

                   let albumId  =  (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: 0) as! String
                   let beneficiary  =          (muarrayListData.value(forKey: "beneficiary") as AnyObject).object(at: 0) as! String
                   let albumTitle =            (muarrayListData.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String
                   let description  =          (muarrayListData.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String
                   let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: 0) as! String
                   let project_date =           (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: 0) as! String
                   let type      =              (muarrayListData.value(forKey: "MeetingType") as AnyObject).object(at: 0) as! String
                   let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: 0) as! String
                   let Attendance =            (muarrayListData.value(forKey: "Attendance") as AnyObject).object(at: 0) as? String
                   let AttendancePer =         (muarrayListData.value(forKey: "AttendancePer") as AnyObject).object(at: 0) as? String
                   let AgendaAttachement =     (muarrayListData.value(forKey: "AgendaDocID") as AnyObject).object(at: 0) as? String
                   let MOMAttachement =        (muarrayListData.value(forKey: "MOMDocID") as AnyObject).object(at: 0) as?String

                var NumberOfRotarian:String = ""
                if let test=muarrayListData.object(at: 0) as? AnyObject
                {
                    if let str=test.value(forKey: "NumberOfRotarian") as? String
                    {
                        NumberOfRotarian=str
                    }
                }

                //MARK:- New Data on Aril 2020
                var NumberOfRotractors:String = "0"
                if let test=muarrayListData.object(at: 0) as? AnyObject
                {
                    if let str=test.value(forKey: "Rotaractors") as? String
                    {
                        NumberOfRotractors=str
                    }
                }
                if NumberOfRotractors == ""
                {
                    NumberOfRotractors="0"
                }
                 if let test=muarrayListData.object(at: 0) as? AnyObject
                 {
                     if let str=test.value(forKey: "Mediaphoto") as? String
                     {
                        self.mediaPhotoPAth=str
                     }
                 }

                    
                    if let test=muarrayListData.object(at: 0) as? AnyObject
                    {
                        if let str=test.value(forKey: "MediaDesc") as? String
                        {
                            self.mediaPhotoDesc=str
                        }
                    }

                    
                    if self.mediaPhotoPAth != ""
                {
                  //  self.mediaView.frame=self.originalMediaFrame
                   // self.photoView.frame=self.originalPhotoFrame
                    self.mediaView.frame = CGRect(x: self.originalMediaFrame.origin.x, y: self.originalMediaFrame.origin.y, width: self.view.frame.width, height: self.originalMediaFrame.height)
                    
                    self.photoView.frame = CGRect(x: self.originalPhotoFrame.origin.x, y: self.originalPhotoFrame.origin.y, width: self.view.frame.width, height: self.originalPhotoFrame.height)

                     self.mediaView.isHidden=false
                     let ImageMediaPic:String = (self.mediaPhotoPAth as AnyObject).replacingOccurrences(of: " ", with: "%20")
                     let checkedUrl = URL(string: ImageMediaPic)
                     self.mediaImageView.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                 }
                 else
                 {
                  self.mediaView.isHidden=true
                  self.photoView.frame = CGRect(x: self.mediaView.frame.origin.x, y: self.mediaView.frame.origin.y, width: self.view.frame.width, height: self.photoView.frame.height+100)
                    }
         //MARK:- End
                

                self.AgendaDocUrl=(muarrayListData.value(forKey: "AgendaDoc") as AnyObject).object(at: 0) as?String
                self.MOMDocUrl=(muarrayListData.value(forKey: "MOMDoc") as AnyObject).object(at: 0) as?String

                
                 // let sharetype:String!=(muarrayListData.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
                //self.lblActivityTitle.text = albumTitle
                self.muarrayKEY.add("Date")
                
                
                let dF:DateFormatter=DateFormatter()
                dF.dateFormat="YYYY-MM-dd HH:mm:ss"
                print("Project date is \(project_date)")
                if let pDate = dF.date(from: project_date)
                {
                    let dff:DateFormatter=DateFormatter()
                    dff.dateFormat="dd-MMM-YYYY"
                  if let pDates=dff.string(from: pDate) as? String
                  {
                    print("Formatted project date is \(pDates)")
                    self.muarrayVALUE.add(pDates)
                  }
                  else
                  {
                    self.muarrayVALUE.add("")
                  }
                }
                else
                {
                  self.muarrayVALUE.add("")
                }
                
                
                
                self.muarrayKEY.add("Cost")
                self.muarrayKEY.add("Beneficiaries")
                self.muarrayKEY.add("Man hours")
                self.muarrayKEY.add("Rotarians")
                self.muarrayKEY.add("Rotaractors")

                self.muarrayVALUE.add(" ₹" + project_cost)
                self.muarrayVALUE.add(beneficiary)
                self.muarrayVALUE.add(working_hour + " Hours")
                self.muarrayVALUE.add(NumberOfRotarian)
                self.muarrayVALUE.add(NumberOfRotractors)

                
                
                if(AgendaAttachement == "" || AgendaAttachement == "0"){
               }
                else{
                     self.TempArrayName.add("Agenda")
                     self.TempArray.add(AgendaAttachement as Any)
                    }
                if(MOMAttachement == "" || MOMAttachement == "0" ){
                }
                else{
                    self.TempArrayName.add("Minutes of Meeting")
                    self.TempArray.add(MOMAttachement as Any)
                   }
                self.colectionViewHorizontal.reloadData()
                self.clubTableView.reloadData()
                self.clubTableView.estimatedRowHeight = 285.0
                self.clubTableView.rowHeight = UITableView.automaticDimension
                SVProgressHUD.dismiss()
               }
               else
               {
               self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
               SVProgressHUD.dismiss()
              }
            }
           })
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
            
        }
    }
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.colectionviewAlbumPhoto
            {
                 return muarrayGridPhotoCollection.count
        }
            else if collectionView == colectionViewHorizontal  {
            return muarrayKEY.count
        }
       return 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
 if collectionView == self.colectionviewAlbumPhoto
     {
prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumPhotosCell
 prototypeCell.lableTitle.isHidden=true
 if(muarrayGridPhotoCollection.count>0)
 {
     let varGetAlbumImages = (muarrayGridPhotoCollection.object(at: indexPath.row) as AnyObject).value(forKey: "image") as! String
     //let varGetAlbumTitle = muarrayGridPhotoCollection.objectAtIndex(indexPath.row).valueForKey("title") as! String
     //prototypeCell.lableTitle.text! = varGetAlbumTitle
     print(varGetAlbumImages)
     if(varGetAlbumImages == "")
     {
         prototypeCell.imageAlbumPhoto.image = UIImage(named: "profile_pic")
     }
     else
     {
         /*------------------------------Code by --------------------DPK--------------------------- */
         if let checkedUrl = URL(string: varGetAlbumImages )
         {
             
             let ImageProfilePic:String = varGetAlbumImages.replacingOccurrences(of: " ", with: "%20")
             let checkedUrl = URL(string: ImageProfilePic)
             self.prototypeCell.imageAlbumPhoto.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                 //                    KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                 //                        print(image)
                 //                        self.prototypeCell.imageAlbumPhoto.image = image
                 //                    })
                                     /*-----------------Code by --------------------DPK--------------------------- */
                                 }
                             }
                         }
                prototypeCell.buttonMain.tag=indexPath.row
                
       prototypeCell.buttonMain.addTarget(self, action: #selector(ClubPhotoViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
                         prototypeCell.buttonMain.tag=indexPath.row;
                         return prototypeCell

        }
            else if collectionView == colectionViewHorizontal  {
                let  ccell = colectionViewHorizontal.dequeueReusableCell(withReuseIdentifier: "Horizon", for: indexPath) as! HorizontalCollection
                ccell.viewHori.layer.cornerRadius = 10
                
                if(indexPath.row == 0)
                {
                    ccell.viewHori.backgroundColor = UIColor(red:1.00, green:0.58, blue:0.22, alpha:1.0)
                    ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)
                }
                else if(indexPath.row == 1)
                {
                    ccell.viewHori.backgroundColor = UIColor(red:0.54, green:0.75, blue:0.30, alpha:1.0)
                    ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)

                }
                else if(indexPath.row == 2)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.98, green:0.35, blue:0.32, alpha:1.0)
                    ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)

                }
                else if(indexPath.row == 3)
                {
                    ccell.viewHori.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
                    ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)
                    // print(muaaryHoriZontal)
                    
                }
                else if(indexPath.row == 4)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.68, alpha:1.0)
                    ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)

                }
            else if(indexPath.row == 5)
            {
                ccell.viewHori.backgroundColor = UIColor(red:0.48, green:0.25, blue:0.52, alpha:1.0)
                ccell.lbl1.text = (muarrayKEY.object(at: indexPath.row) as! String)
                ccell.lbl2.text = (muarrayVALUE.object(at: indexPath.row) as! String)
            }

            if( (muarrayKEY.object(at: indexPath.row) as! String) == "Meeting Type"){
                    ccell.viewHori.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
                }
                return ccell
            }
        return UICollectionViewCell()
    }

    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
if let systemVersion = (UIDevice.current.systemVersion
   as? NSString)?.integerValue
  {
 if systemVersion < 0//13
 {
      let objMenu:Menu=Menu()
      // mainArray.addObject(dd)
      objMenu.muarrayHoldingImageUrl=muarrayHoldingImageUrl
      objMenu.muarrayHoldingImageDescription=muarrayHoldingImageDescription
      objMenu.muarrayHoldingPhotoId=muarrayHoldingPhotoId
      objMenu.strSelectedPhotoIndex=String(sender.tag)
      objMenu.strFromClub="ClubPhotoSegment"
      print(muarrayHoldingImageUrl.count)
      UserDefaults.standard.setValue(self.userID, forKey: "session_createdByORUserIdOrProfileId")
      UserDefaults.standard.setValue(self.varAlbumId, forKey: "session_AlbumID")
      self.navigationController?.pushViewController(objMenu, animated: true)
 }
 else
    {
        ImageSlideShowViewController.presentFrom(self){ [weak self] controller in
            print("image count \(self?.images.count)")
            print("desc count \(self!.muarrayHoldingImageDescription.count)")
           controller.dismissOnPanGesture = true
           controller.slides = self?.images
           controller.enableZoom = true
            controller.imgDescription = self!.muarrayHoldingImageDescription
            controller.setPage(withIndex: sender.tag)
           controller.controllerDidDismiss = {
               debugPrint("Controller Dismissed")
               debugPrint("last index viewed: \(controller.currentIndex)")
           }

           controller.slideShowViewDidLoad = {
               debugPrint("Did Load")
           }
    
           controller.slideShowViewWillAppear = { animated in
               debugPrint("Will Appear Animated: \(animated)")
           }
    
           controller.slideShowViewDidAppear = { animated in
               debugPrint("Did Appear Animated: \(animated)")
                        }
                    }
              }
        }
  }
    
    func getImages()
    {
        //images = []
        if self.muarrayHoldingImageUrl.count>0
        {
        for i in 0 ..< self.muarrayHoldingImageUrl.count
        {
            if let url = self.muarrayHoldingImageUrl[i] as? String
            {
                let ImageProfilePic:String = (url as AnyObject).replacingOccurrences(of: " ", with: "%20")
                if let checkedUrl = URL(string: ImageProfilePic)
                {
                images.append(Image(title: "Image \(i+1)", url: checkedUrl))
                }
             }
          }
        }
    }
    
    //MARK:- Table View Delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return clubTableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempArrayName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = clubTableView.dequeueReusableCell(withIdentifier: "DetialTVC", for: indexPath) as! DetialTVC
        
        if(TempArrayName.count>0){
            cell.lbl.text = (TempArrayName[indexPath.row] as! String)
            
            cell.btneye.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.EyeAction(_:)), for: .touchUpInside)
            cell.btnedit.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.DownloadAction(_:)), for: .touchUpInside)
            cell.btneye.tag = indexPath.row
            cell.btnedit.tag = indexPath.row
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    
    @objc func EyeAction(_ sender:UIButton)
    {
        
        var urls:String!=""
        var strNavi:String! = ""
        
        
        var varGetText = (TempArrayName[sender.tag] as! String)
        
       // if(sender.tag==0)
        if(varGetText == "Agenda")
        {
            strNavi = "Agenda"
            print(self.AgendaDocUrl)
            urls=self.AgendaDocUrl
        }
       // else  if(sender.tag==1)
        else  if(varGetText == "Minutes of Meeting")
        {
             strNavi = "Minutes of Meeting"
            print(self.MOMDocUrl)
            urls=self.MOMDocUrl
        }
        
        print("this is test url !!!!!!")
        print(self.AgendaDocUrl)
        print(self.MOMDocUrl)
        let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DownloadedDocViewViewController") as! DownloadedDocViewViewController
       
        print("this is view url mom by rajnedra !!!")
        print(urls)
        objDocumentDownloadedViewController.filename=urls
        objDocumentDownloadedViewController.Navi = strNavi
        objDocumentDownloadedViewController.IsComingNewShowCase="yes"

        self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)
        
    }
    
    @objc func DownloadAction(_ sender:UIButton)
    {
       
        let alert = UIAlertController(title: "Downloading...", message: "Once downloaded, please click the folder symbol on the top right corner to view the file.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        var urls:String!=""
        var isAgendaorMOM:String!=""
        
        
        
           var varGetText = (TempArrayName[sender.tag] as! String)
       // if(sender.tag==0)
            if(varGetText == "Agenda")
        {
           print(AgendaDocUrl)
            urls=AgendaDocUrl
            isAgendaorMOM="Agenda"
        }
       // else  if(sender.tag==1)
        else  if(varGetText == "Minutes of Meeting")
        {
            print(MOMDocUrl)
             urls=MOMDocUrl
             isAgendaorMOM="Minutes of Meeting"
        }
        
        /*
         
         if(varGetText == "Agenda")
         {
         strNavi = "Agenda"
         print(AgendaDocUrl)
         urls=AgendaDocUrl
         }
         // else  if(sender.tag==1)
         else  if(varGetText == "Minutes of Meeting")
         {
         strNavi = "Minutes of Meeting"
         print(MOMDocUrl)
         urls=MOMDocUrl
         }
         */
        
        
        
        print("this is url")
        print(urls)
        print("Download PDF File------------------")
        print(sender.tag)
        //  let pdfUrl =  "http://webtest.rosteronwheels.com/Documents/documentsafe/Group2765/ROW_11072018125802PM.pdf"//muarrayListData.valueForKey("reportUrl").objectAtIndex(sender.tag) as? String
        // print(docList.docURL)
        
        
        //-------------------------------
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        
        Alamofire.download(urls,method: .get, parameters: nil, encoding: JSONEncoding.default,headers: nil, to: destination).downloadProgress(closure: { (progress) in
            //progress closure
        }).responseJSON(completionHandler: { (result) in
            print(result)
        }).response(completionHandler: { (DefaultDownloadResponse) in
            //here you able to access the DefaultDownloadResponse
            //result closure
            print(DefaultDownloadResponse)
        }).responseData { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                print("Downloaded file successfully")
                // self.view!.makeToast("Downloaded file successfully", duration: 2, position: CSToastPositionCenter)
                alert.dismiss(animated: true, completion: nil)
                
                let alert = UIAlertController(title: "", message: "Downloaded file successfully", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                      // Comment by Hiten and open by rajendra
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDocumentViewController") as! ShowDocumentViewController

                    secondViewController.filename=urls!
                      secondViewController.isComingFromActivity=isAgendaorMOM!
                    
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                
                
            case .failure(let error):
                print(error)
                // if let errort = error
                // {
                // print("Failed with error: errorrt)")
                let letGetResponse:String!=String(describing: error)
                print(letGetResponse)
                //myy code
                //if letGetResponse.rangeOfString("File exists") != nil
                if letGetResponse.contains("File exists") != nil
                {
                    alert.dismiss(animated: true, completion: nil)
                    
                    let alert = UIAlertController(title: "", message: "This Document is already downloaded", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    // change to desired number of seconds (in this case 5 seconds)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                        // your code with delay
                        alert.dismiss(animated: true, completion: nil)
                        // Comment by Hiten and open by rajendra
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDocumentViewController") as! ShowDocumentViewController

                        secondViewController.filename=urls!
                         secondViewController.isComingFromActivity=isAgendaorMOM!
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        
                        
                    }
                  
                    
                }
                else
                {
                    
                    let alert = UIAlertController(title: "", message: "This Document is already downloaded", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    // change to desired number of seconds (in this case 5 seconds)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                        // your code with delay
                        alert.dismiss(animated: true, completion: nil)
                          // Comment by Hiten and open by rajendra
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDocumentViewController") as! ShowDocumentViewController

                        secondViewController.filename=urls!
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        
                        
                    }
                    alert.dismiss(animated: true, completion: nil)
                    // alert.dismiss(animated: true, completion: nil)
                    print("Downloaded file successfully")
                    // self.view!.makeToast("Downloaded file successfully", duration: 2, position: CSToastPositionCenter)
                    // self.loaderClass.window = nil
                }
            }
        }
    }
    
    
    
}
