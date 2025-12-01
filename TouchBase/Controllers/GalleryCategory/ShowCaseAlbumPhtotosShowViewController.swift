
//
//  ShowCaseAlbumPhtotosShowViewController.swift
//  TouchBase
//
//  Created by tt on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SDWebImage
//import LiquidFloatingActionButton

class ShowCaseAlbumPhtotosShowViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableshowcaseFiveDetails: UITableView!
    
    
    var muarrayForFiveDetailsKey:NSMutableArray=NSMutableArray()
    
    var muarrayForFiveDetailsStore:NSMutableArray=NSMutableArray()
    
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    var actionButton: ActionButton!
    
    var selectedAssetsArray : NSMutableArray = NSMutableArray()
    var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
    var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
    var muarrayHoldingPhotoId:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var lblNoOfRotarians: UILabel!
    @IBOutlet weak var buttonDownMore: UIButton!
    @IBOutlet weak var textviewDescription: UITextView!
    @IBOutlet weak var lblManHoursSpent: UILabel!
    @IBOutlet weak var lblBeneficiary: UILabel!
    @IBOutlet weak var lblCostOfProject: UILabel!
    @IBOutlet weak var lblDateofTheProject: UILabel!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var buttonNoResult: UIButton!
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    
    @IBOutlet weak var lblUnderline: UILabel!
    
    var clSizeX:CGFloat! = 0.0
    var clSizeY:CGFloat! = 0.0
    var clSizeheight:CGFloat! = 0.0
    
    
    
    var muarrayMainList:NSArray=NSArray()
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue("0", forKey: "ImageCountFiveOrNot")
        
        //        let border = CALayer()
        //        border.backgroundColor = UIColor.darkGrayColor().CGColor
        //        border.frame = CGRectMake(0, buttonDownMore.frame.size.height/2, buttonDownMore.frame.size.width, 1)
        //        buttonDownMore.layer.addSublayer(border)
        //
        
        // tableshowcaseFiveDetails.TextViewPlaceHolder("")
        
        
        
        UserDefaults.standard.setValue("No", forKey: "session_IsComingFromImageSave")
        varChangesInPhotos = "Changes"
        UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
        //1. Date of the Project:
        if(Getproject_date != "" && Getproject_date != nil )
        {
            lblDateofTheProject.text! = dateConverter (Getproject_date)
            muarrayForFiveDetailsKey.add("Project date:")
            muarrayForFiveDetailsStore.add(dateConverter (Getproject_date))
            
        }
        else
        {
            //lblDateofTheProject.text! = Getproject_date
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
            muarrayForFiveDetailsKey.add("Project Cost:")
            muarrayForFiveDetailsStore.add(Getproject_cost+" "+Getcost_of_project_type)
        }
        else
        {
            //lblCostOfProject.text! = Getproject_cost+Getcost_of_project_type
        }
        
        //3. Beneficiary
        
        if(Getbeneficiary != "" && Getbeneficiary != nil)
        {
            muarrayForFiveDetailsKey.add("Beneficiaries:")
            muarrayForFiveDetailsStore.add(Getbeneficiary)
        }
        else
        {
            // lblBeneficiary.text! = Getbeneficiary
        }
        //4. Time Spent:
        
        
        if(GetManHours != "" && GetManHours != nil && Getworking_hour_type != "")
        {
            muarrayForFiveDetailsKey.add("Man hours spent:")
            muarrayForFiveDetailsStore.add(GetManHours+" "+Getworking_hour_type)
        }
        else
        {
            
        }
        
        //5. No of Rotarian involved:
        
        if(GetNumberOfRotarian != "" && GetNumberOfRotarian != nil)
        {
            muarrayForFiveDetailsKey.add("No. of Rotarians involved:")
            muarrayForFiveDetailsStore.add(GetNumberOfRotarian)
        }
        else
        {
            // lblNoOfRotarians.text! = GetNumberOfRotarian
        }
        
        
        
        
        
        if(muarrayForFiveDetailsStore.count>0)
        {
            tableshowcaseFiveDetails.reloadData()
        }
        
        if(GetManHours=="NA")
        {
            //lblManHoursSpent.text! = GetManHours
        }
        else
        {
            //lblManHoursSpent.text! = GetManHours+" "+Getworking_hour_type
        }
        
        
        if(Getdescription=="")
        {
            textviewDescription.text! = "No Description"
            textviewDescription.textAlignment = .center
        }
        else
        {
            textviewDescription.text! = Getdescription
        }
        
        
        
        print(muarrayForFiveDetailsStore.count)
        print(self.GetShareType)
        if(self.GetShareType=="0")
        {
            tableshowcaseFiveDetails.isHidden = true
            textviewDescription.frame = CGRect(x: textviewDescription.frame.origin.x, y: 0, width: textviewDescription.frame.size.width, height: textviewDescription.frame.size.height+100)
        }
        else  if(self.GetShareType=="1" && muarrayForFiveDetailsStore.count<=0)
        {
            tableshowcaseFiveDetails.isHidden = true
            textviewDescription.frame = CGRect(x: textviewDescription.frame.origin.x, y: 0, width: textviewDescription.frame.size.width, height: textviewDescription.frame.size.height+100)
        }
        else
        {
            tableshowcaseFiveDetails.isHidden = false
            textviewDescription.frame = CGRect(x: textviewDescription.frame.origin.x, y: 133, width: textviewDescription.frame.size.width, height: 167)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        setValueUpDown="Down"
        self.lblUnderline.isHidden=true
        buttonNoResult.isHidden=true
//        self.edgesForExtendedLayout=[]
        clSizeheight = collectionViewPhotos.frame.size.height
        clSizeY = collectionViewPhotos.frame.origin.y
        print(clSizeY)
        print(clSizeheight)
        createNavigationBar()
        functionForFetchingAlbumPhotosListData()
        // functiuonFloatingButton()
        //if(GetIsCategoryFromClubOrDistrict=="1" && self.GetIsAdmin=="Yes")
        if(self.GetIsAdmin=="Yes")
        {
            print("From Club")
            functiuonFloatingButton()
        }
        else
        {
            print("From Show case and District")
        }
        //myScrollView.delegate=self
        //myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.collectionViewPhotos.reloadData()
        
        
        
        createNavigationBar()
    }
    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
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
        buttonleft.addTarget(self, action: #selector(ShowCaseAlbumPhtotosShowViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Button Action
    @IBAction func buttonDownMoreClickEvent(_ sender: AnyObject)
    {
        if(setValueUpDown=="Down")
        {
            
            buttonDownMore.frame = CGRect(x: 0, y: self.view.frame.origin.y+195, width: self.view.frame.size.width, height: self.buttonDownMore.frame.size.height)
            collectionViewPhotos.frame = CGRect(x: 0,  y: 300, width: self.view.frame.size.width, height: clSizeheight-220)
            self.lblUnderline.isHidden=false
            buttonDownMore.setImage(UIImage(named: "Sup"),  for: UIControl.State.normal)
            setValueUpDown="Up"
        }
        else if(setValueUpDown=="Up")
        {
            self.lblUnderline.isHidden=true
            buttonDownMore.frame = CGRect(x: 0, y: 74, width: self.view.frame.size.width, height: self.buttonDownMore.frame.size.height)
            collectionViewPhotos.frame = CGRect(x: 0, y: 120, width: self.view.frame.size.width, height: clSizeheight-40)
            setValueUpDown = "Down"
            buttonDownMore.setImage(UIImage(named: "Sdown"),  for: UIControl.State.normal)
        }
    }
    //MARK:- collection delegate AS Grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return muarrayMainList.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let  prototypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCaseAlbumPhtotosShowCollectionViewCell", for: indexPath) as! ShowCaseAlbumPhtotosShowCollectionViewCell
        //prototypeCell.imageAlbumPhoto.image=UIImage(named: "logo")
        if(muarrayMainList.count>0)
        {
            
            
            let url =  (muarrayMainList.value(forKey: "url") as AnyObject).object(at: indexPath.row) as! String
            if url == ""
            {
                prototypeCell.imageAlbumPhoto.image = UIImage(named: "logo")
            }
            else
            {
                let ImageProfilePic:String = url.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                prototypeCell.imageAlbumPhoto.sd_setImage(with: checkedUrl)
            }
            prototypeCell.buttonMain.addTarget(self, action: #selector(ShowCaseAlbumPhtotosShowViewController.buttonDetailClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCell.buttonMain.tag = indexPath.row
            
            
            
        }
        return prototypeCell
    }
    //details album
    @objc func buttonDetailClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        
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
        let objMenu:Menu=Menu()
        if((GetIsCategoryFromClubOrDistrict=="1" || GetIsCategoryFromClubOrDistrict=="2") && self.GetIsAdmin == "Yes")
        {
            objMenu.strFromDistrictGallery="strFromClubGallerys"
        }
        else
        {
            objMenu.strFromDistrictGallery="strFromDistrictGallerys"
        }
        //        if(GetIsCategoryFromClubOrDistrict=="1")
        //        {
        //         objMenu.strFromDistrictGallery="strFromClubGallerys"
        //        }
        //        else
        //        {
        //         objMenu.strFromDistrictGallery="strFromDistrictGallerys"
        //        }
        
        
        let photoID =  (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: sender.tag) as! String
        
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
        objMenu.strSelectedPhotoIndex=String(sender.tag)
        //print(strSelectedPhotoIndex)
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    //MARK:- Server api calling
    func functionForFetchingAlbumPhotosListData()
    {
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
                    self.buttonNoResult.isHidden=true
                }
                else
                {
                    self.buttonNoResult.isHidden=false
                }
                self.collectionViewPhotos.reloadData()
                
                self.loaderClass.window = nil
            }
            else
            {
                
                if(self.muarrayMainList.count>0)
                {
                    self.buttonNoResult.isHidden=true
                }
                else
                {
                    self.buttonNoResult.isHidden=false
                }
                
                self.loaderClass.window = nil
                //self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                 SVProgressHUD.dismiss()
                print("NO Result")
            }
            
            self.loaderClass.window = nil
            
            SVProgressHUD.dismiss()
            }
            
        })
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
                
                print()
                if(self.muarrayMainList.count>=5)
                {
                    self.view.makeToast("Maximum 5 photos are allowed", duration: 3, position: CSToastPositionCenter)
                }
                else
                {
                    UserDefaults.standard.setValue(self.GetUserProfileID, forKey: "session_createdByORUserIdOrProfileId")
                    UserDefaults.standard.setValue(self.GetAlbumID, forKey: "session_AlbumID")
                    UserDefaults.standard.setValue(self.Getdescription, forKey: "session_Description")
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
                }
                //self.arrayGetAlbumPhotoListData.a
                // self.navigationController?.pushViewController(albumControllerObject, animated: true)
        }
        editAlbums.action =
            {
                item in print("Album...")
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
                // albumControllerObject.grpID = self.varGroupId
                // albumControllerObject.createdByORUserIdOrProfileId = self.userID
                //albumControllerObject.stringModuleId=self.stringModuleId
                
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    //
                    
                    
                    
                    self.navigationController?.pushViewController(albumControllerObject, animated: true)
                    
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
        }
        let invitation = ActionButtonItem(title: "Delete Photo", image: deleteAlbum)
        invitation.action =
            {
                item in print("Google Plus...")
                //                let albumControllerObject = self.storyboard?.instantiateViewControllerWithIdentifier("DeletePhotoViewController") as! DeletePhotoViewController
                //                albumControllerObject.userID = self.GetUserProfileID
                //                albumControllerObject.varGroupId = self.GetGroupID
                //                albumControllerObject.varAlbumId = self.GetAlbumID //(dict.valueForKey("albumId")as! String)
                //                albumControllerObject.varNavigationTitle = self.Gettitle//(dict.valueForKey("title")as! String)
                //                albumControllerObject.varDescription =  self.Getdescription//(dict.valueForKey("description")as! String)
                //
                //
                //                self.navigationController?.pushViewController(albumControllerObject, animated: true)
                
                
                
                
                
                
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseDeletePhotoViewController") as! ShowCaseDeletePhotoViewController
                obj.Gettitle=self.Gettitle
                obj.GetUserIdProfileID = self.GetUserProfileID
                obj.GetGroupID = self.GetGroupID
                obj.GetAlbumID = self.GetAlbumID //(dict.valueForKey("albumId")as! String)
                //                obj.varNavigationTitle = self.Gettitle//(dict.valueForKey("title")as! String)
                //                obj.varDescription =  self.Getdescription//(dict.valueForKey("description")as! String)
                
                
                self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    self.navigationController?.pushViewController(obj, animated: true)
                }
                else
                {
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                   SVProgressHUD.dismiss()
                }
        }
        actionButton = ActionButton(attachedToView: self.view, items: [invitation,editAlbums,phonebook])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State.normal)
        actionButton.backgroundColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha:1.0)
    }
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muarrayForFiveDetailsKey.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableshowcaseFiveDetails.dequeueReusableCell(withIdentifier: "ShowcaseFiveDetailsCell", for: indexPath) as! ShowcaseFiveDetailsCell
        
        cell.lblTitle.text = muarrayForFiveDetailsKey.object(at: indexPath.row) as! String
        cell.lblValue.text = muarrayForFiveDetailsStore.object(at: indexPath.row) as! String
        
        return cell
    }
}
