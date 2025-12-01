

    //
    //  NewShowCasePhotoDetailsVC.swift
    //  TouchBase
    //
    //  Created by tt on 17/10/18.
    //  Copyright © 2018 Parag. All rights reserved.
    //
    
    import UIKit
    import SDWebImage
    import SVProgressHUD
    import Alamofire


    class  NewShowCasePhotoDetailsVCGooglePushNotificaton   : UIViewController, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
     
        
   
        var isCalled:String!=""
        
        var appDelegate : AppDelegate = AppDelegate()
        let loaderClass  = WebserviceClass()
        
        var strCheckDelpass:String?
        var muarrayForFiveDetailsKey:NSMutableArray=NSMutableArray()
        var muarrayForFiveDetailsStore:NSMutableArray=NSMutableArray()
        var muarrayMainList:NSArray=NSArray()
        var strNavi:String?
        
        var muarrayHoldingImageUrl:NSMutableArray=NSMutableArray()
        var muarrayHoldingImageDescription:NSMutableArray=NSMutableArray()
        var muarrayHoldingPhotoId:NSMutableArray=NSMutableArray()
        
        var tempValue:NSMutableArray = []
        var tempName:NSMutableArray = []
        
        var TempArray:NSMutableArray = []
        var TempArrayName:NSMutableArray = []
        
        var strTypesss:String?
        
        var SelectImageIndex : Int=0
        let numberOfCellsPerRow: CGFloat = 3
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
        var getFinanceYear = ""
        var GetIsAdmin:String!=""
        var GetUserProfileID:String!=""
        var GetIsCategoryFromClubOrDistrict:String!=""
        var recipientType:String! = ""
        var GetImageUrl:String!=""
        var GetModuleID:String!=""
        var setValueUpDown:String!=""
        var GetShareType:String!=""
        var muaaryHoriZontal : NSMutableArray?
        var muaaryHoriZontalName : NSMutableArray?
        var muarrayAgendaorMetting : NSMutableArray?
        var muarrayAgendaorMettingName : NSMutableArray?
        var varChangesInPhotos:String = ""
        var strdistorClube : String?
        var strWhichType:String?
        var checkString:String!=""
        var pageTitle:String=""
        var getGroupDistrictList:NSMutableArray=NSMutableArray()
//MARK:- Added on April 2020
        var MemberCount:String=""
        var BenificiaryCount:String=""

        @IBOutlet weak var lblHeading: UILabel!
        
        @IBOutlet weak var collectionHori: UICollectionView!
        @IBOutlet weak var tblView: UITableView!
        
        @IBOutlet weak var txtView: UITextView!
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var loadinglabel: UILabel!
        
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
        var wentFromMediaPhotoPAge:Bool=false
        fileprivate var images:[Image] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            print("my screen")
            print("ALBUMID---------------\(GetAlbumID)")
            print(checkString)
            setMediaPhotoView()
            self.title=""
            muarrayAgendaorMetting = NSMutableArray()
            muaaryHoriZontal = NSMutableArray()
            muarrayMainList = NSMutableArray()

            let tap = UITapGestureRecognizer(target: self, action: #selector(mediaPicClickEvent))
            mediaImageView.addGestureRecognizer(tap)
            mediaImageView.isUserInteractionEnabled = true


        }
        
        @objc func mediaPicClickEvent()
            {
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            wentFromMediaPhotoPAge=true
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

        
        override func viewDidLayoutSubviews() {
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            self.navigationController?.navigationBar.isHidden=false
            self.navigationItem.setHidesBackButton(false, animated: false)

            if  wentFromMediaPhotoPAge
            {
                wentFromMediaPhotoPAge=false
                return
            }
            muarrayHoldingImageUrl = NSMutableArray()
            muarrayHoldingImageDescription = NSMutableArray()
            self.navigationController?.isNavigationBarHidden = false
            SVProgressHUD.show()
            functionForGetAlbumDetails_New()
            functionForCollectionDetails()
            createNavigationBarmine()
        }

        func functionForRightNaviButton()
        {
            /*
             let searchButton = UIButton(type: UIButton.ButtonType.custom)
             searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
             searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
             searchButton.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.buttonnewShowDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
             let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
             let buttons : NSArray = [search]
             self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
             */
            
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DocumentListViewControlller.UploadDocControllerAction))
            add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0) //UIColor.whiteColor()
            // let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            
            let searchButton1 = UIButton(type: UIButton.ButtonType.custom)
            searchButton1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            searchButton1.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
            searchButton1.addTarget(self, action: #selector(buttonEditDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
            let search1: UIBarButtonItem = UIBarButtonItem(customView: searchButton1)
            
            
            // let searchButton = UIButton(type: UIButton.ButtonType.custom)
            ////  searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            // searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
            // searchButton.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.buttonnewShowDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
            //let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
            
            let buttons : NSArray = [search1]
            
            
            
            var mainMemberID:String! = UserDefaults.standard.string(forKey: "isAdmin")as! String
            print("admin right !!!")
            print(mainMemberID)
            if mainMemberID == "Yes"
            {
                print("if")
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
            else
            {
                print("else")
            }
            
            
            
            
        }

        func functionForRightNaviButton2()
        {
            /*
             let searchButton = UIButton(type: UIButton.ButtonType.custom)
             searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
             searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
             searchButton.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.buttonnewShowDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
             let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
             let buttons : NSArray = [search]
             self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
             */
            
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DocumentListViewControlller.UploadDocControllerAction))
            add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0) //UIColor.whiteColor()
            // let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            
            let searchButton1 = UIButton(type: UIButton.ButtonType.custom)
            searchButton1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            searchButton1.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
            searchButton1.addTarget(self, action: #selector(buttonEditDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
            let search1: UIBarButtonItem = UIBarButtonItem(customView: searchButton1)
            
            
            let searchButton = UIButton(type: UIButton.ButtonType.custom)
            searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
            searchButton.addTarget(self, action: #selector(buttonnewShowDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
            let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
            
            var buttons : NSArray = []
            // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            
            
            var mainMemberID:String! = UserDefaults.standard.string(forKey: "isAdmin")as! String
            print("admin right !!!")
            print(mainMemberID)
            if mainMemberID == "Yes"
            {
                print("if")
                var buttons : NSArray = [search1,search]
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
                
            }
            else
            {
                print("else")
                var buttons : NSArray = [search]
                self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            }
        }

        @objc func buttonnewShowDownloadableDocumentClickEvent()
        {
            let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocumentDownloadedViewController") as! DocumentDownloadedViewController
            self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)
        }

     @objc   func buttonEditDownloadableDocumentClickEvent()
        {
            if(self.GetIsCategoryFromClubOrDistrict == "2"){
                
                let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
                objAddPhoto.strAlbumId = GetAlbumID
                objAddPhoto.strGroupId = GetGroupID
                objAddPhoto.strcreatedBy = GetUserProfileID
                objAddPhoto.moduleId = GetModuleID
                objAddPhoto.isCalledFRom = "Edit"
                objAddPhoto.checkString = checkString
                objAddPhoto.MemberCount = self.MemberCount
                objAddPhoto.BenificiaryCount = self.BenificiaryCount
             //   objAddPhoto.objProtocolNameNew=self
                
                self.navigationController?.pushViewController(objAddPhoto, animated: true)
                
            }else{
                
                let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                objAddPhoto.strAlbumId = GetAlbumID
                objAddPhoto.strGroupId = GetGroupID
                objAddPhoto.strcreatedBy = GetUserProfileID
                objAddPhoto.moduleId = GetModuleID
                objAddPhoto.isCalledFRom = "Edit"
                objAddPhoto.checkString = strWhichType
                objAddPhoto.MemberCount = self.MemberCount
                objAddPhoto.BenificiaryCount = self.BenificiaryCount

                //objAddPhoto.objProtocolNameNew=self
                
                self.navigationController?.pushViewController(objAddPhoto, animated: true)
                
            }
        }
         @objc func backClicked()
        {
            self.navigationController?.popViewController(animated: true)
            if((self.presentingViewController) != nil){
                
                self.dismiss(animated: false, completion: nil)
                
                print("done")
                
            }
        }
        func createNavigationBarmine()
        {
            let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
            self.navigationController!.navigationBar.titleTextAttributes = attributes
            
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
            self.navigationController?.navigationBar.barTintColor=UIColor.white
            
             let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        // MARK: - Action Method
        
        @IBAction func BackAction(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @IBAction func EditAction(_ sender: Any) {
            if(self.GetIsCategoryFromClubOrDistrict == "2"){
                
                let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
                objAddPhoto.strAlbumId = GetAlbumID
                objAddPhoto.strGroupId = GetGroupID
                objAddPhoto.strcreatedBy = GetUserProfileID
                objAddPhoto.moduleId = GetModuleID
                objAddPhoto.isCalledFRom = "Edit"
                objAddPhoto.checkString = checkString
                objAddPhoto.MemberCount = self.MemberCount
                objAddPhoto.BenificiaryCount = self.BenificiaryCount

                print("this is category id for passing on next screen")
                print(CategoryIdForPassingNectScreen)
                objAddPhoto.categoryId=CategoryIdForPassingNectScreen
                
                self.navigationController?.pushViewController(objAddPhoto, animated: true)
                
            }else{
                
                let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
                objAddPhoto.strAlbumId = GetAlbumID
                objAddPhoto.strGroupId = GetGroupID
                objAddPhoto.strcreatedBy = GetUserProfileID
                objAddPhoto.moduleId = GetModuleID
                objAddPhoto.isCalledFRom = "Edit"
                objAddPhoto.checkString = strWhichType
                objAddPhoto.MemberCount = self.MemberCount
                objAddPhoto.BenificiaryCount = self.BenificiaryCount

               // objAddPhoto.objProtocolNameNew=self
                
                self.navigationController?.pushViewController(objAddPhoto, animated: true)
                
            }
        }
        
        
        // MARK: - Table View datasourece and delegate
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (TempArrayName.count)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tblView.dequeueReusableCell(withIdentifier: "DetialsTVC", for: indexPath) as! DetialsTVC
            
            if(TempArrayName.count>0){
                cell.lbl.text = (TempArrayName[indexPath.row] as! String)
                
                cell.btneye.addTarget(self, action: #selector(EyeAction(_:)), for: .touchUpInside)
                cell.btnedit.addTarget(self, action: #selector(DownloadAction(_:)), for: .touchUpInside)
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
        
      @objc  func DownloadAction(_ sender:UIButton)
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
            
            SVProgressHUD.show()
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
                    SVProgressHUD.dismiss()
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
                    SVProgressHUD.dismiss()
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
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
        // MARK: - Collection View datasourece and delegate
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if(collectionView == collectionHori ){
                return muaaryHoriZontal!.count
                
            }else{
                return muarrayMainList.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            if(collectionView == collectionHori ){
                let  ccell = collectionHori.dequeueReusableCell(withReuseIdentifier: "HorizontalCVC", for: indexPath) as! HorizontalCVC
                ccell.viewHori.layer.cornerRadius = 10
                
                if(indexPath.row == 0)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:1.00, green:0.58, blue:0.22, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    let strdate = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = dateConverter(strdate)
                    
                }
                else if(indexPath.row == 1)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.54, green:0.75, blue:0.30, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                    
                }
                else if(indexPath.row == 2)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.98, green:0.35, blue:0.32, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                    
                }
                else if(indexPath.row == 3)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    let strtemp = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                    // print(muaaryHoriZontal)
                    ccell.lbl2.text = strtemp
                    
                }
                else if(indexPath.row == 4)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.68, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                    
                }
                else if(indexPath.row == 5)
                {
                    
                    ccell.viewHori.backgroundColor = UIColor(red:0.48, green:0.25, blue:0.52, alpha:1.0)
                    ccell.lbl1.text = (muaaryHoriZontalName?.object(at: indexPath.row) as! String)
                    ccell.lbl2.text = (muaaryHoriZontal?.object(at: indexPath.row) as! String)
                }

                
                if( (muaaryHoriZontalName?.object(at: indexPath.row) as! String) == "Meeting Type"){
                    ccell.viewHori.backgroundColor = UIColor(red:0.84, green:0.00, blue:0.61, alpha:1.0)
                    
                }
                
                return ccell
            }
            else  {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCVC", for: indexPath) as! DetailsCVC
                print(muarrayMainList)
                let url = (muarrayMainList[indexPath.row] as AnyObject).value(forKey: "url")
                let ImageProfilePic:String = (url as AnyObject).replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.celImg.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "Asset10"))
                return cell
            }
        }
        
        
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
 if(collectionView == collectionHori ){
     
 }else{
     if let systemVersion = (UIDevice.current.systemVersion
      as? NSString)?.integerValue
     {
         if systemVersion <  0//13
      {
          let objMenu:Menu=Menu()
     print( self.muarrayHoldingImageUrl)
     objMenu.muarrayHoldingImageUrl = self.muarrayHoldingImageUrl
      print("self.muarrayHoldingImageUrl::: \(self.muarrayHoldingImageUrl)")
     objMenu.muarrayHoldingImageDescription = self.muarrayHoldingImageDescription
      // objMenu.muarrayHoldingPhotoId = (muarrayMainList[indexPath.row] as AnyObject).value(forKey: "url")
     objMenu.strSelectedPhotoIndex=String(indexPath.row)
      //print(strSelectedPhotoIndex)
      
      if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
      {
          self.navigationController?.pushViewController(objMenu, animated: true)
          
      }
      else
      {
          self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
          
      }
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
           controller.setPage(withIndex: indexPath.row)
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
    
//                let objMenu:Menu=Menu()
//                print( self.muarrayHoldingImageUrl)
//                objMenu.muarrayHoldingImageUrl = self.muarrayHoldingImageUrl
//                objMenu.muarrayHoldingImageDescription = self.muarrayHoldingImageDescription
//                // objMenu.muarrayHoldingPhotoId = (muarrayMainList[indexPath.row] as AnyObject).value(forKey: "url")
//                objMenu.strSelectedPhotoIndex=String(indexPath.row)
//                //print(strSelectedPhotoIndex)
//
//                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//                {
//                    self.navigationController?.pushViewController(objMenu, animated: true)
//                }
//                else
//                {
//                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//                }
            }
        }

        
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
        /// To Show the Date in String format
        func convertToShowFormatDate(dateString: String) -> String {
            
            let dateFormatterDate = DateFormatter()
            dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
            
            let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
            
            let dateFormatterString = DateFormatter()
            dateFormatterString.dateFormat = "dd MMM yyyy" //Your New Date format as per requirement change it own
            let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
            print(newDate) // New formatted Date string
            
            return newDate
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
        
        // MARK: - Call Services
        
func functionForCollectionDetails()
{
 let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
 var parameterst:NSDictionary=NSDictionary()
 
 parameterst =  ["albumId":GetAlbumID,
                 "groupId":GetGroupID,"Financeyear": getFinanceYear]
 
 print(parameterst)
 print(completeURL)
 ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
 //=> Handle server response
 let dd = response as! NSDictionary
 print("dd \(dd)")
 print(response)
 let varGetValueServerError = response.object(forKey: "serverError")as? String
 if(varGetValueServerError == "Error")
 {
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
     SVProgressHUD.dismiss()
 }
 else
 {
 if((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "status") as! String == "0")
 {
    if(((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "message") as! String).contains("Photo record not found")){
    self.view.makeToast("Photo record not found.", duration: 2, position: CSToastPositionCenter)
        self.photoView.isHidden=true
    }else{
        let arrarrNewGroupList = (dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "Result")
        self.muarrayMainList = arrarrNewGroupList as! NSArray
        
        for i in 00..<self.muarrayMainList.count{
            
            self.muarrayHoldingImageUrl.add((self.muarrayMainList[i] as AnyObject).value(forKey: "url") as! String)
            self.muarrayHoldingImageDescription.add((self.muarrayMainList[i] as AnyObject).value(forKey: "description") as! String)
        }
        if self.muarrayHoldingImageUrl.count>0
        {
            self.collectionView.isHidden = false
            self.photoView.isHidden=false
        }
        else
        {
            self.collectionView.isHidden = true
            self.photoView.isHidden=true
        }
        self.collectionView.reloadData()
        self.getImages()
        //SVProgressHUD.dismiss()
    }
 }
 else
 {
     self.photoView.isHidden=true
     self.collectionView.isHidden = true
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
     SVProgressHUD.dismiss()
}
}
})
}
        
        
        //AgendaDoc = "http://www.rosteronwheels.com/Documents/gallery/Group2765/ROW_21112018051933PM.pdf";
        // AgendaDocID = 6344;
        /// Attendance = 4;
        //  AttendancePer = "45.00";
        // MOMDoc = "http://www.rosteronwheels.com/Documents/gallery/Group2765/ROW_21112018051947PM.doc";
        
var AgendaDocUrl:String!=""
var MOMDocUrl:String!=""

var CategoryIdForPassingNectScreen:String!=""
func functionForGetAlbumDetails_New()
{
            
SVProgressHUD.show()
self.tblView.isHidden=true
self.loadinglabel.isHidden=false
self.loadinglabel.text="Loading... Please Wait"
            
let completeURL = baseUrl+"Gallery/GetAlbumDetails_New"
var parameterst:NSDictionary=NSDictionary()
parameterst =  ["albumId":GetAlbumID as Any,"Financeyear" :getFinanceYear]
            
self.TempArray = NSMutableArray()
self.TempArrayName  = NSMutableArray()
            
print(parameterst)
print(completeURL)
            
ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
    //=> Handle server response
    let dd = response as! NSDictionary
    print("dd \(dd)")
    let varGetValueServerError = response.object(forKey: "serverError")as? String
    if(varGetValueServerError == "Error")
    {
        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
        self.loadinglabel.isHidden=false
        self.loadinglabel.text="Could not connect to server."
    }
    else
    {
    if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
    {
      if(((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "message") as! String).contains("Record not found")){
         self.loadinglabel.isHidden=false
         self.loadinglabel.text="Record not found."
        self.tblView.isHidden=true
         self.view.makeToast("Record not found.", duration: 2, position: CSToastPositionCenter)
       }else{
        let arrarrNewGroupList = (dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "AlbumDetailResult") as! NSArray
        let muarrayListData = arrarrNewGroupList.value(forKey: "AlbumDetail") as! NSArray
        print(muarrayListData)
     
        self.tempValue = NSMutableArray()
        self.tempName = NSMutableArray()
     
       var NumberOfRotarian:String = ""
       if let test=muarrayListData.object(at: 0) as? AnyObject
     {
         if let str=test.value(forKey: "NumberOfRotarian") as? String
         {
             NumberOfRotarian=str
         }
     }
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
     let albumId      =          (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: 0) as! String
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
     
     
     
     //MARK:- this is hidden navigation folder
     
     if(self.strWhichType == "Service Projects" && type == "0")
     {
         //self.functionForRightNaviButton()
     }
     else if(self.strWhichType == "Club Meetings" && (type == "1" || type == "2"))
     {
         //self.functionForRightNaviButton2()
     }
     self.CategoryIdForPassingNectScreen=(muarrayListData.value(forKey: "albumCategoryID") as AnyObject).object(at: 0) as?String
     
     self.AgendaDocUrl=(muarrayListData.value(forKey: "AgendaDoc") as AnyObject).object(at: 0) as?String
     self.MOMDocUrl=(muarrayListData.value(forKey: "MOMDoc") as AnyObject).object(at: 0) as?String

     self.lblHeading.text = albumTitle
     let sharetype:String!=(muarrayListData.value(forKey: "shareType") as AnyObject).object(at: 0) as! String

  
         if(sharetype == "0"){
             
             self.tempValue.add(project_date)
             self.tempName.add("Date")
             
             if(Attendance == ""){
                 
             }else{
                 self.tempValue.add(Attendance as Any)
                 self.tempName.add("Attendance")
             }
             
             if(AttendancePer == ""){
                 
             }else{
                 self.tempValue.add(AttendancePer as Any)
                 self.tempName.add("Attendance(%)")
             }
             
             
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
             
             if(type == "0"){
                 self.tempName.add("Meeting Type")
                 self.tempValue.add("Regular")
                 
             }
             else if(type == "1"){
                 self.tempName.add("Meeting Type")
                 self.tempValue.add("BOD")
                 
             }else if(type == "2"){
                 self.tempName.add("Meeting Type")
                 self.tempValue.add("Assembly")
                 
             }
             else if(type == "3"){
                self.tempName.add("Meeting Type")
                self.tempValue.add("Fellowship")
            }
            
             self.muaaryHoriZontal = self.tempValue
             self.muaaryHoriZontalName = self.tempName
             self.muarrayAgendaorMettingName = self.TempArrayName
             self.txtView.text = description
         }
         else {
             self.tempName.add("Date")
             self.tempName.add("Cost")
             self.tempName.add("Beneficiaries")
             self.tempName.add("Man hours")
             self.tempName.add("Rotarians")
             self.tempName.add("Rotaractors")
             self.tempValue.add(project_date)
             self.tempValue.add(" ₹" + project_cost)
             self.tempValue.add(beneficiary)
             self.tempValue.add(working_hour + " Hours")
             self.tempValue.add(NumberOfRotarian)
             self.tempValue.add(NumberOfRotractors)
             self.muaaryHoriZontal = self.tempValue
             self.muaaryHoriZontalName = self.tempName
             self.txtView.text = description
         }
     //later code by rajendra jat
     let sharetype2:String!=(muarrayListData.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
     self.title = self.strWhichType
     print(self.strWhichType)
    
         if(sharetype2=="1")
         {
             self.title = "Service Project"
             self.btnPhotoTitle.setTitle("Project Photos", for: .normal)
             self.strWhichType="Service Projects"
             self.checkString="Service Projects"
             self.pageTitle = "Service Project"
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
         }
         else
         {
            self.title = "Club Meeting"
            self.strWhichType="Club Meetings"
            self.checkString = "Club Meetings"
            self.pageTitle = "Club Meeting"
            self.mediaView.isHidden=true
            self.btnPhotoTitle.setTitle("Photos", for: .normal)
            self.photoView.frame = CGRect(x: self.mediaView.frame.origin.x, y: self.mediaView.frame.origin.y, width: self.view.frame.width, height: self.photoView.frame.height+100)
         }
        self.collectionHori.reloadData()
        self.tblView.reloadData()
        self.loadinglabel.isHidden=true
        self.tblView.isHidden=false
        }
     }
     else
     {
        self.loadinglabel.isHidden=false
        self.loadinglabel.text="Could not connect to server."
         self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
     }
     SVProgressHUD.dismiss()
   }
  })
 }
}


