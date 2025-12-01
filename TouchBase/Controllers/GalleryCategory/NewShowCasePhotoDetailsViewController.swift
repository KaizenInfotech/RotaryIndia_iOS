
//
//  NewShowCasePhotoDetailsViewController.swift
//  TouchBase
//
//  Created by tt on 12/07/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class NewShowCasePhotoDetailsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    
    var muarrayForFiveDetailsKey:NSMutableArray=NSMutableArray()
    var muarrayForFiveDetailsStore:NSMutableArray=NSMutableArray()
    var muarrayMainList:NSArray=NSArray()
    
    
    var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
    var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
    var muarrayHoldingPhotoId:NSMutableArray=NSMutableArray()
    
    var SelectImageIndex : Int=0
    
    var Getworking_hour_type:String!=""
    var Getcost_of_project_type:String!=""
    var GetNumberOfRotarian:String!=""
    var GetClubName:String!=""
    var Getdescription:String!=""
    var Getbeneficiary:String!=""
    var Getproject_cost:String!=""
    var Getproject_date:String!=""
    var Gettitle:String!=""
    var GetManHours:String!=""
    var GetAlbumID:String!=""
    var GetGroupID:String!=""
    var GetIsAdmin:String!=""
    var GetUserProfileID:String!=""
    var GetIsCategoryFromClubOrDistrict:String!=""
    var recipientType:String! = ""
    var GetImageUrl:String!=""
    var GetModuleID:String!=""
    var setValueUpDown:String!=""
    var GetShareType:String!=""
    
    var varChangesInPhotos:String = ""
    
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    
    
    
    
    @IBOutlet weak var viewCollection: UIView!
    
    fileprivate var images:[Image] = []

    
    func getImages()
    {
        //images = []
        images.removeAll()
        images=[Image]()
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
    
    
    
    //MARK:- Date Copnverter
    func dateConverter(_ dateString:String) -> String
    {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        
        return dateString
    }
    //MARK:- Collection Details Get
    func functionForCollectionDetails()
    {
        
        
        if(GetShareType=="0")
        {
            
        }
        else
        {
            //1. Date of the Project:
            if(Getproject_date != "" && Getproject_date != nil )
            {
                
                muarrayForFiveDetailsKey.add("Date")
                muarrayForFiveDetailsStore.add(dateConverter (Getproject_date))
            }
            else
            {
            }
            if(Getcost_of_project_type=="1")
            {
                Getcost_of_project_type = "₹"
            }
            else if(Getcost_of_project_type=="2")
            {
                Getcost_of_project_type = "$"
            }
            else
            {
                
            }
            //2.Cost of Project:
            if(Getproject_cost != "" && Getproject_cost != nil && Getcost_of_project_type != "")
            {
                muarrayForFiveDetailsKey.add("Cost")
                muarrayForFiveDetailsStore.add(Getproject_cost+" "+Getcost_of_project_type)
            }
            else
            {
                muarrayForFiveDetailsKey.add("Cost")
                muarrayForFiveDetailsStore.add(Getproject_cost+Getcost_of_project_type)
                
            }
            
            //3. Beneficiary
            if(Getbeneficiary != "" && Getbeneficiary != nil)
            {
                muarrayForFiveDetailsKey.add("Beneficiaries")
                muarrayForFiveDetailsStore.add(Getbeneficiary)
            }
            else
            {
            }
            //4. Time Spent:
            if(GetManHours != "" && GetManHours != nil && Getworking_hour_type != "")
            {
                muarrayForFiveDetailsKey.add("Man hours")
                muarrayForFiveDetailsStore.add(GetManHours+" "+Getworking_hour_type)
            }
            else
            {
                muarrayForFiveDetailsKey.add("Man hours")
                muarrayForFiveDetailsStore.add(GetManHours+Getworking_hour_type)
            }
            //5. No of Rotarian involved:
            if(GetNumberOfRotarian != "" && GetNumberOfRotarian != nil)
            {
                muarrayForFiveDetailsKey.add("Rotarians")
                muarrayForFiveDetailsStore.add(GetNumberOfRotarian)
            }
            else
            {
            }
            
            print("*********************-------------------------",muarrayForFiveDetailsStore.count)
            
            if(muarrayForFiveDetailsStore.count>0)
            {
                myCollectionView.reloadData()
            }
            else
            {
                
            }
            
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.edgesForExtendedLayout=[]
        UserDefaults.standard.setValue("No", forKey: "session_IsComingFromImageSave")
        varChangesInPhotos = "Changes"
        UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
        
        
        myCollectionView.backgroundColor = UIColor.white
        
        functionForCollectionDetails()
        myTableView.estimatedRowHeight = 250
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.reloadData()
        functionForFetchingAlbumPhotosListData()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden=false
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            // let mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("session_NewImageAddedSuccess")
            if(varChangesInPhotos == UserDefaults.standard.string(forKey: "session_NewImageAddedSuccess"))
            {
                functionForFetchingAlbumPhotosListData()
                UserDefaults.standard.setValue("NoChanges", forKey: "session_NewImageAddedSuccess")
            }
            else
            {
            }
        }
        else
        {
            
        }
        self.myTableView.reloadData()
        createNavigationBar()
    }
    
    
    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
       //  self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = self.Gettitle
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewShowCasePhotoDetailsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(NewShowCasePhotoDetailsViewController.editEbullAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        if(self.GetIsAdmin=="Yes")
        {
            print("From Club")
            let buttons : NSArray = [edit]
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        else
        {
            print("From Show case and District")
        }
        
        
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editEbullAction()
    {
        
        let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
        albumControllerObject.GetNumberOfRotarian = self.GetNumberOfRotarian
        albumControllerObject.GetClubName = self.GetClubName
        albumControllerObject.Getworking_hour_type = self.Getworking_hour_type
        albumControllerObject.Getcost_of_project_type = self.Getcost_of_project_type
        albumControllerObject.titleForText = self.Gettitle
        albumControllerObject.descriptionForAlbum = self.Getdescription
        albumControllerObject.imageUrlForAlbumImage = self.GetImageUrl
        albumControllerObject.annTypeStr = self.recipientType as! NSString
        albumControllerObject.stringModuleId = self.GetModuleID
        albumControllerObject.isCalledFRom = "edit"
        albumControllerObject.grpID = self.GetGroupID
        albumControllerObject.groupID = self.GetGroupID
        albumControllerObject.varAlbumID = self.GetAlbumID
        albumControllerObject.createdByORUserIdOrProfileId = self.GetUserProfileID
        albumControllerObject.isAdmin = self.GetIsAdmin
        albumControllerObject.isCategory=self.GetIsCategoryFromClubOrDistrict
        albumControllerObject.GetShareTypes=self.GetShareType
        albumControllerObject.muarrayMainList=self.muarrayMainList
        
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            self.navigationController?.pushViewController(albumControllerObject, animated: true)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayForFiveDetailsKey.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let  ccell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewShowCasePhotoDetailsCollectionCell", for: indexPath) as! NewShowCasePhotoDetailsCollectionCell
        ccell.view1.layer.cornerRadius = 10
        
        if(muarrayForFiveDetailsKey.count>0)
        {
            ccell.lblOne.text = muarrayForFiveDetailsKey.object(at: indexPath.row) as! String
            ccell.lblTwo.text = muarrayForFiveDetailsStore.object(at: indexPath.row) as! String
            
        }
        
        
        if(indexPath.row == 0)
        {
            ccell.view1.backgroundColor = UIColor(red:1.00, green:0.58, blue:0.22, alpha:1.0)
            
        }
        else if(indexPath.row == 1)
        {
            ccell.view1.backgroundColor = UIColor(red:0.54, green:0.75, blue:0.30, alpha:1.0)
        }
        else if(indexPath.row == 2)
        {
            ccell.view1.backgroundColor = UIColor(red:0.98, green:0.35, blue:0.32, alpha:1.0)
        }
        else if(indexPath.row == 3)
        {
            ccell.view1.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
        }
        else if(indexPath.row == 4)
        {
            ccell.view1.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.68, alpha:1.0)
        }
        else
        {
            
        }
        
        
        
        return ccell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(self.muarrayForFiveDetailsStore.count>0)
        {
            return 10
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        myTableView.tableHeaderView?.backgroundColor = UIColor.white
        myTableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.myCollectionView.frame.size.width, height: 100)
        //let customView = UIView(frame: CGRectMake(0, 0, 375, 100))
        //customView.backgroundColor = UIColor.redColor()
        //customView.addSubview(self.myCollectionView)
        //myTableView.tableHeaderView = self.myCollectionView
        
        
        return myTableView.tableFooterView
    }
    
    
    
    
    //MARK:- Table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "NewShowCasePhotoDetailsCell", for: indexPath) as! NewShowCasePhotoDetailsCell
        
        if(indexPath.row == 0)
        {
            cell.lblDesc.isHidden = false
            cell.viewOne.isHidden = true
            cell.lblDesc.text = self.Getdescription
            
        }
        else if indexPath.row == 1
        {
            cell.lblDesc.isHidden = true
            cell.viewOne.isHidden = false
            for i in 0..<self.muarrayMainList.count
            {
                
                if(i==0)
                {
                    let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                    if imgUrl == ""
                    {
                        cell.img1.image = UIImage(named: "")
                        cell.img1.isHidden=true
                    }
                    else
                    {
                        cell.img1.isHidden=false
                        let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.img1.sd_setImage(with: checkedUrl)
                        
                        let tap1 = UITapGestureRecognizer(target: self, action: #selector(NewShowCasePhotoDetailsViewController.FindARotarianCE))
                        cell.img1.addGestureRecognizer(tap1)
                        cell.img1.isUserInteractionEnabled = true
                    }
                }
                else if(i==1)
                {
                    let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                    if imgUrl == ""
                    {
                        cell.img2.image = UIImage(named: "")
                        cell.img2.isHidden=true
                    }
                    else
                    {
                        cell.img2.isHidden=false
                        let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.img2.sd_setImage(with: checkedUrl)
                        
                        
                        
                        let tap2 = UITapGestureRecognizer(target: self, action: #selector(NewShowCasePhotoDetailsViewController.ShowCaseCE))
                        cell.img2.addGestureRecognizer(tap2)
                        cell.img2.isUserInteractionEnabled = true
                    }
                }
                else if(i==2)
                {
                    let  imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                    if imgUrl == ""
                    {
                        cell.img3.image = UIImage(named: "")
                        cell.img3.isHidden=true
                    }
                    else
                    {
                        let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.img3.sd_setImage(with: checkedUrl)
                        cell.img3.isHidden=false
                        
                        
                        
                        
                        let tap3 = UITapGestureRecognizer(target: self, action: #selector(NewShowCasePhotoDetailsViewController.LibraryCE))
                        cell.img3.addGestureRecognizer(tap3)
                        cell.img3.isUserInteractionEnabled = true
                    }
                }
                else if(i==3)
                {
                    let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                    if imgUrl == ""
                    {
                        cell.img4.image = UIImage(named: "")
                        cell.img4.isHidden=true
                    }
                    else
                    {
                        let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.img4.sd_setImage(with: checkedUrl)
                        cell.img4.isHidden=false
                        
                        
                        
                        let tap4 = UITapGestureRecognizer(target: self, action: #selector(NewShowCasePhotoDetailsViewController.RotaryNewsCE))
                        cell.img4.addGestureRecognizer(tap4)
                        cell.img4.isUserInteractionEnabled = true
                    }
                }
                else if(i==4)
                {
                    let  imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                    if imgUrl == ""
                    {
                        cell.img5.image = UIImage(named: "")
                        cell.img5.isHidden=true
                        
                    }
                    else
                    {
                        let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                        let checkedUrl = URL(string: ImageProfilePic)
                        cell.img5.sd_setImage(with: checkedUrl)
                        cell.img5.isHidden=false
                        
                        
                        
                        let tap5 = UITapGestureRecognizer(target: self, action: #selector(NewShowCasePhotoDetailsViewController.RotaryBlogsCE))
                        cell.img5.addGestureRecognizer(tap5)
                        cell.img5.isUserInteractionEnabled = true
                    }
                    
                }
            }
            
            
            
            
            
            
            
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row==0)
        {
            return UITableView.automaticDimension
        }
        else
        {
            if (self.muarrayMainList.count<=0)
            {
                return 0
            }
            else
            {
                return 250
            }
            
        }
    }
    
    
    
    
    
    func FunctionForSelectedImageUpdate()
    {
        
        muarrayHoldingImageUrl=NSMutableArray()
        muarrayHoldingImageDescription=NSMutableArray()
        muarrayHoldingPhotoId=NSMutableArray()
        for i in 0..<muarrayMainList.count
        {
            let urls =  (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
            muarrayHoldingImageUrl.add(urls)
        }
        for i in 0..<muarrayMainList.count
        {
            let urls =  (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
            muarrayHoldingImageDescription.add(urls)
        }
        for i in 0..<muarrayMainList.count
        {
            let urls =  (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
            muarrayHoldingPhotoId.add(urls)
        }
        
        if let systemVersion = (UIDevice.current.systemVersion
         as? NSString)?.integerValue
        {
            if systemVersion <  0//13
            {
                let objMenu:Menu=Menu()
                if((GetIsCategoryFromClubOrDistrict=="1" || GetIsCategoryFromClubOrDistrict=="2") && self.GetIsAdmin == "Yes")
                {
                    objMenu.strFromDistrictGallery="strFromClubGallerys"
                }
                else
                {
                    objMenu.strFromDistrictGallery="strFromDistrictGallerys"
                }
                let photoID =  (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: SelectImageIndex) as! String
                UserDefaults.standard.setValue(self.GetUserProfileID, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.GetAlbumID, forKey: "session_AlbumID")
                //NSUserDefaults.standardUserDefaults().setValue(self.Getdescription, forKey: "session_Description")
                UserDefaults.standard.setValue(photoID, forKey: "session_imagePhotoId")
                UserDefaults.standard.setValue(self.GetGroupID, forKey: "session_GetGroupId")
                print(muarrayHoldingImageUrl)
                print(muarrayHoldingImageDescription)
                print(muarrayHoldingPhotoId)
                objMenu.muarrayHoldingImageUrl=muarrayHoldingImageUrl
                objMenu.muarrayHoldingImageDescription=muarrayHoldingImageDescription
                objMenu.muarrayHoldingPhotoId=muarrayHoldingPhotoId
                objMenu.strSelectedPhotoIndex=String(SelectImageIndex)
                //print(strSelectedPhotoIndex)
                
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    self.navigationController?.pushViewController(objMenu, animated: true)
                    
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                     SVProgressHUD.dismiss()
                }

            }
            else
            {
                getImages()
                ImageSlideShowViewController.presentFrom(self){ [weak self] controller in
                    print("image count \(self?.images.count)")
                    print("desc count \(self!.muarrayHoldingImageDescription.count)")
                   controller.dismissOnPanGesture = true
                   controller.slides = self?.images
                   controller.enableZoom = true
                    controller.imgDescription = self!.muarrayHoldingImageDescription
                    controller.setPage(withIndex: self!.SelectImageIndex)
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
    
    
    
    @objc func FindARotarianCE()
    {
        print("First Image")
        SelectImageIndex = 0
        FunctionForSelectedImageUpdate()
    }
    @objc func ShowCaseCE()
    {
        print("Second Image")
        SelectImageIndex = 1
        FunctionForSelectedImageUpdate()
    }
    @objc func LibraryCE()
    {
        print("Third Image")
        SelectImageIndex = 2
        FunctionForSelectedImageUpdate()
    }
    @objc func RotaryNewsCE()
    {
        print("Fourth Image")
        SelectImageIndex = 3
        FunctionForSelectedImageUpdate()
    }
    @objc func RotaryBlogsCE()
    {
        print("Fifth Image")
        SelectImageIndex = 4
        FunctionForSelectedImageUpdate()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Server api calling
    func functionForFetchingAlbumPhotosListData()
    {//
       // loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
        let parameterst = ["groupId":self.GetGroupID,"albumId": self.GetAlbumID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
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
            if((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "status") as! String == "0" && ((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "message") as! String == "success"))
            {
                let arrarrNewGroupList = ((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "Result")) as! NSArray
                print(arrarrNewGroupList)
                self.muarrayMainList = arrarrNewGroupList
                
                
                
                
                //dpk code for image count for max photo five
                var CountImag :String! = ""
                CountImag = String(self.muarrayMainList.count)
                print(CountImag)
                UserDefaults.standard.setValue(CountImag, forKey: "ImageCountFiveOrNot")
                print(UserDefaults.standard.value(forKey: "ImageCountFiveOrNot"))
                
                
                if(self.muarrayMainList.count>0)
                {
                    //self.buttonNoResult.hidden=true
                }
                else
                {
                    //self.buttonNoResult.hidden=false
                }
                self.myTableView.reloadData()
                
                self.loaderClass.window = nil
            }
            else
            {
                
                if(self.muarrayMainList.count>0)
                {
                    //self.buttonNoResult.hidden=true
                }
                else
                {
                    //self.buttonNoResult.hidden=false
                }
                 SVProgressHUD.dismiss()
                self.loaderClass.window = nil
                //self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                
                print("NO Result")
            }
            
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }
    
    
    
}
