
//progressLabel
//  DocumentListViewControlller.swift
//  TouchBase
//
//  Created by Umesh on 05/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SDDownloadManager
import UIKit
import MobileCoreServices
import AssetsLibrary
import AVFoundation
import Photos
import Alamofire
import SVProgressHUD

protocol protocolForDocumentListing {
    func functionForDocumentListing(StringValue:String)
}


class DocumentListViewControlller : UIViewController ,  webServiceDelegate , DBRestClientDelegate , URLSessionDownloadDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,protocolForDocumentListing,UITableViewDataSource,UITableViewDelegate {
    
    func functionForDocumentListing(StringValue: String) {
        print("This is coming from added document @!!!!!!!")
        print(StringValue)
        
        SDDownloadManager.shared.cancelAllDownloads()
        progressLabel.textColor=UIColor.white
        progressLabel.textColor=UIColor.white
        BUTTONOPACITYDOWNLOADED.isHidden=true
        progressView.isHidden=true
        progressLabel.isHidden=true
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        searchTextField.autocorrectionType = .no
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        NoRecordLabel.isHidden = true
        createNavigationBar()
        // Do any additional setup after loading the view.
        varIsGroupAdmin=UserDefaults.standard.value(forKey: "isAdmin") as! String
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        listTypeTextField.delegate=self
        annType="1"
        listTypeTextField.text = "Published"
        //functionForGetData()
        functionForGetData()
       
    }
    var isCategory = ""
    var varGetSearchBoxValue:String!=""
    var appDelegate : AppDelegate!
    
    //   let loaderClass  = WebserviceClass()
    ///
    @IBOutlet weak var BUTTONOPACITYDOWNLOADED: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    var annType:NSString!
    // var isAdmin:NSString!
    @IBOutlet var pickerView:UIPickerView!
    let bounds = UIScreen.main.bounds
    // var appDelegate = AppDelegate()
    var groupIDX : String = ""
    var mainArray = NSArray()
    var copymainArray = NSArray()
    var searchTextField = UITextField()
    
    var listTypeTextField  = UITextField()
    @IBOutlet var NoRecordLabel: UILabel!
    @IBOutlet var docListTableView: UITableView!
    var imageToDownload = UIImageView()
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    
    var SMSCountStr :  String!
    
    var varIsGroupAdmin:String!=""
    var docListing = DocumentList()
    var dropboxMetadata: DBMetadata!
    var dbRestClient: DBRestClient!
    var docTypeToDownload : String = ""
    var grpPRofileID : NSString!
    //let loaderClass  = WebserviceClass()
    var isCalled:NSString!
    var pickerDataSource = ["Published","All","Scheduled", "Expired"];
    var varSender:String!=""
    
    
    var isAdmin:String!=""
    
    var moduleName:String! = ""
    var varGetSearchText:String!=""
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    func   functionForGetData()
    {
        var varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")as! String
        
        if(varGetValue=="no")
        {
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=self
            let defaults = UserDefaults.standard
            if let uid = defaults.string(forKey: "masterUID")
            {
                print(groupIDX)
                print(grpPRofileID as String)
                
                
                if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
                {
                    
                    
                    if isAdmin == "Yes"
                    {
                        wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: annType as String, stringIsAdmin: "1", StringSearchTest: varGetSearchText)
                    }
                    else
                    {
                        wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: "1", stringIsAdmin: "0", StringSearchTest: varGetSearchText)
                    }
                }
                else
                {
                    
                    SVProgressHUD.dismiss()
                    self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                }
                
            }
        }
    }
    
    
    func functionForRefreshingData()
    {
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        let defaults = UserDefaults.standard
        if let uid = defaults.string(forKey: "masterUID")
        {
            print(groupIDX)
            print(grpPRofileID as String)
            /*
             "type":"0","isAdmin":"0","searchText":
             */
            // wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String)
            if isAdmin == "Yes"
            {
                wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: annType as String, stringIsAdmin: "1", StringSearchTest: varGetSearchText)
            }
            else
            {
                wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: "1", stringIsAdmin: "0", StringSearchTest: varGetSearchText)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SDDownloadManager.shared.cancelAllDownloads()
        progressLabel.textColor=UIColor.white
        progressLabel.textColor=UIColor.white
        BUTTONOPACITYDOWNLOADED.isHidden=true
        progressView.isHidden=true
        progressLabel.isHidden=true
        
        
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        
        searchTextField.autocorrectionType = .no
        
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        NoRecordLabel.isHidden = true
        
        createNavigationBar()
        // Do any additional setup after loading the view.
        
        varIsGroupAdmin=UserDefaults.standard.value(forKey: "isAdmin") as! String
        
        
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //removeFile()
        // fileExistance()
        //        if !DBSession.sharedSession().isLinked() {
        //            DBSession.sharedSession().linkFromController(self)
        //        }
        //        else {
        //            DBSession.sharedSession().unlinkAll()
        //            dbRestClient = nil
        //        }
        
        //        DBChooser.defaultChooser().openChooserForLinkType(DBChooserLinkTypePreview, fromViewController: self, completion: { (results: [AnyObject]!) -> Void in
        //          print(results.description)
        //      })
        
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        
        
        
        
        
        listTypeTextField.delegate=self
        annType="1"
        listTypeTextField.text = "Published"
        //functionForGetData()
        functionForGetData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        functionForGetData()
        
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DocumentListViewControlller.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        //        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        //        buttonlog.frame = CGRectMake(0, 0, 40, 40)
        //        buttonlog.titleLabel?.textAlignment = NSTextAlignment.Right
        //        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        //        buttonlog.setImage(UIImage(named: "upload"),forState: UIControl.State.Normal)
        //        buttonlog.addTarget(self, action: #selector(DocumentListViewControlller.UploadDocControllerAction), forControlEvents: UIControlEvents.TouchUpInside)
        //        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        //        self.navigationItem.rightBarButtonItem = skipButton
        /*
         
         var editB = UIButton(type: UIButton.ButtonType.custom)
         
         editB = UIButton(type: UIButton.ButtonType.custom)
         editB.frame = CGRectMake(50, 0, 20, 20)
         editB.setImage(UIImage(named:"list_view"), forState: UIControl.State.Normal)
         editB.addTarget(self, action: #selector(CreateAlbumViewController.RightDropDownAction), forControlEvents: UIControlEvents.TouchUpInside)
         let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
         let buttons : NSArray = [edit]
         self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
         */
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DocumentListViewControlller.UploadDocControllerAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0) //UIColor.whiteColor()
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        let searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
        searchButton.addTarget(self, action: #selector(DocumentListViewControlller.buttonDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        //let buttons : NSArray = [search, setting] //14 mar
        
        
        //let buttons : NSArray = [search, setting] //14 mar
        if self.isAdmin == "Yes"
        {
//            let buttons : NSArray = [add,search]
            let buttons : NSArray = [add]
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        else
        {
//            let buttons : NSArray = [search]
//            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }
    
    @objc func buttonDownloadableDocumentClickEvent()
    {
        let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocumentDownloadedViewController") as! DocumentDownloadedViewController
        self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)
    }
    
    
    
    
     @objc func backClicked(){
        
        if(isCalled == "notify"){
            // appDelegate.setRootView()
            self.navigationController?.popViewController(animated: true) //DPK
            // self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        }else if(isCalled == "notify1"){
            //appDelegate.setRootView()
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
        
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
    }
    
    @objc func UploadDocControllerAction(){
        //self.navigationController?.popViewControllerAnimated(true)
        //uploadVC
        UserDefaults.standard.set("", forKey: "groupsID")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "uploadVC") as! UploadDocViewController
        secondViewController.groupID = groupIDX
        secondViewController.SMSCountStr = SMSCountStr
        
        secondViewController.objprotocolForDocumentListing=self
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
    func DocumentListingDelegateFunction(_ docListing : TBDocumentistResult)
    {
        SMSCountStr = docListing.smscount
        
        if (docListing.status == "0")
        {
            NoRecordLabel.isHidden = true
            //          mainArray = docListing.DocumentLsitResult as NSArray
            copymainArray = docListing.documentLsitResult as! NSArray
            
            // var docList = DocumentList()
            //docList = mainArray.objectAtIndex(1) as! DocumentList
            
            // cell.docNameLabel.text = docList.docTitle
            //  cell.docDateTimeLabel.text = docList.createDateTime
            
            //print(docList)
            
            
            mainArray=copymainArray .mutableCopy() as! NSArray
            docListTableView.reloadData()
        }
        else
        {
            NoRecordLabel.isHidden = false
            copymainArray = NSArray()
            mainArray=copymainArray .mutableCopy() as! NSArray
            
            docListTableView.reloadData()
        }
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width+5, height: 60)
        headerView.backgroundColor = UIColor.white
        
        
        let headerImageView = UIImageView()
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 60)
        headerImageView.image = UIImage(named: "heder2")
        headerView.addSubview(headerImageView)
        
        
        //  let textImageView = UIImageView()
        
        // textImageView.image = UIImage(named: "textfield")
        // textImageView.userInteractionEnabled = true
        
        
        
        
        
        searchTextField = UITextField()
        searchTextField.frame = CGRect(x: 35, y: 12, width: self.view.frame.size.width-60, height: 35)
        searchTextField.placeholder = "Search"
        searchTextField.textColor = UIColor.black
        searchTextField.font = UIFont(name: "Roboto-Regular", size: 18)
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.delegate = self
        searchTextField.isUserInteractionEnabled = true
        //searchTextField.borderStyle = UITextField.BorderStyle.None
        // searchTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.AllEditingEvents)
        
        searchTextField.autocorrectionType = .no
        searchTextField.borderStyle = .roundedRect
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        searchTextField.spellCheckingType = .no
        searchTextField.returnKeyType = .search
        
        
        /*--------------------------------------*/
        if isAdmin == "Yes"
        {
            
            
            // textImageView.frame = CGRectMake(30, 10, self.view.frame.size.width-140, 35)
            // headerImageView.addSubview(textImageView)
            
            
            searchTextField.frame = CGRect(x: 10, y: 12, width: self.view.frame.size.width-115, height: 35)
            
            ///
            
            listTypeTextField.frame = CGRect(x: self.searchTextField.frame.size.width+13, y: 12, width: 98, height: 35)
            
            listTypeTextField.textColor = UIColor.black
            listTypeTextField.font = UIFont(name: "Roboto-Regular", size: 12)
            listTypeTextField.backgroundColor = UIColor.clear
            listTypeTextField.delegate = self
            listTypeTextField.isUserInteractionEnabled = true
            listTypeTextField.borderStyle = .roundedRect
            // listTypeTextField.layer.cornerRadius = 5.0
            // listTypeTextField.layer.masksToBounds = true
            //  listTypeTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
            // listTypeTextField.layer.borderWidth = 1.0
            listTypeTextField.tag=22
            listTypeTextField.textAlignment = .center
            
            /////
            headerView.addSubview(listTypeTextField)
            headerView.bringSubviewToFront( listTypeTextField)
        }
        else
        {
            searchTextField.frame = CGRect(x: 10, y: 12, width: self.view.frame.size.width-20, height: 35)
            listTypeTextField.isHidden=true
            // textImageView.frame = CGRectMake(30, 10, self.view.frame.size.width-60, 35)
            // headerImageView.addSubview(textImageView)
            
        }
        /*-----------------------------------------*/
        
        headerView.addSubview(searchTextField)
        headerView.bringSubviewToFront( searchTextField)
        
        return headerView
    }
    
    
    
    //    func textFieldDidChange(textField: UITextField) {
    //
    ////
    //
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            
            
            
            
            if(textField.text!==""){
                mainArray = copymainArray .mutableCopy() as! NSArray
                if(mainArray.count == 0) {
                    
                    NoRecordLabel.isHidden = false
                    docListTableView.isHidden = true;
                }
                else {
                    
                    NoRecordLabel.isHidden = true
                    docListTableView.isHidden = false;
                    
                }
                searchTextField.text="";
                searchTextField.resignFirstResponder()
                docListTableView.reloadData()
            }else{
                mainArray=[]
                
                let predicate = NSPredicate(format: "docTitle contains[c] %@", searchTextField.text!)
                mainArray = copymainArray.filtered(using: predicate) as NSArray
                if (mainArray.count==0) {
                    
                    NoRecordLabel.isHidden = false
                    docListTableView.reloadData()
                }
                else{
                    
                    NoRecordLabel.isHidden = true
                    docListTableView.reloadData()
                }
            }
            
            searchTextField.resignFirstResponder()
            return true
        }
        else
        {
            
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            return false
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = docListTableView.dequeueReusableCell(withIdentifier: "docCell", for: indexPath) as! DocumentCell
        alertController.dismiss(animated: true, completion: nil)
        
        var docList = DocumentList()
        docList = mainArray.object(at: indexPath.row) as! DocumentList
        
        print(docList.docID)
        
        cell.docNameLabel.text = docList.docTitle
        cell.docDateTimeLabel.text = docList.createDateTime
        
        //        cell.downloadButton.addTarget(self, action: #selector(DocumentListViewControlller.downloadPDFAction(_:)), forControlEvents: .TouchUpInside)
        //        cell.downloadButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(DocumentListViewControlller.deletePDFAction(_:)), for: .touchUpInside)
        //        cell.buttonView.addTarget(self, action: #selector(DocumentListViewControlller.buttonViewActionClickEvent(_:)), forControlEvents: .TouchUpInside)
        //        cell.buttonView.tag=indexPath.row
        //
        
        cell.buttonMain.tag=indexPath.row
        cell.buttonMain.addTarget(self, action: #selector(DocumentListViewControlller.downloadPDFAction(_:)), for: .touchUpInside)
        
        
        ///1....
        let letGetValuew = docList.docAccessType
        // print(indexPath.row)
        //  print(letGetValuew)
        if(letGetValuew=="0")
        {
            cell.downloadButton.isHidden=true
            cell.buttonView.isHidden=false
            // cell.buttonMain.tag=indexPath.row
            //  cell.buttonMain.addTarget(self, action: #selector(DocumentListViewControlller.buttonViewActionClickEvent(_:)), forControlEvents: .TouchUpInside)
            
            
            //buttonMain
        }
        else
        {
            cell.downloadButton.isHidden=false
            cell.buttonView.isHidden=true
            
        }
        ///2.
        let letIsRead=docList.isRead
        if(letIsRead=="0")
        {
            cell.docNameLabel.textColor=UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        }
        else
        {
            cell.docNameLabel.textColor=UIColor.black
        }
        ///3.isAdmin
        if(isAdmin=="Yes")
        {
            cell.deleteButton.isHidden=false
        }
        else
        {
            cell.deleteButton.isHidden=true
        }
        
        return cell
        
        //let indexPath = NSIndexPath(forRow: index, inSection: 0)
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    func functionForUpdateReadStatus(_ stringDocId:String,stringgroupProfileId:String)
    {
        //moduleId
        let completeURL = baseUrl+touchBase_UpdateDocumentIsRead
        let parameterst = [
            k_API_DocID : stringDocId,
            k_API_memberProfileID : stringgroupProfileId
        ]
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                self.mainArray=NSArray()
                self.functionForRefreshingData()
                SVProgressHUD.dismiss()
            }
            //=> Handle server response
            //  print(response)
            //add data in local if first time coming on this screen after install app
            // self.varGalleryOffline.functionForSaveDataInlocalGalleryAlbum(self.muarrayListData)
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*
         docListTableView.deselectRowAtIndexPath(indexPath, animated: true)
         
         
         var docList = DocumentList()
         docList = mainArray.objectAtIndex(indexPath.row) as! DocumentList
         
         let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("doc_detail") as! DocucxfdsfmentsDetailController
         secondViewController.docListClass = docList
         secondViewController.grpProfileID = grpPRofileID
         self.navigationController?.pusdfshViewController(secondViewController, animated: true)
         */
        
        // let row = indexPath.row
        //print(languagesArray[row])
        // print(row)
        
        // let cell = LanguageTableView.cellForRowAtIndexPath(indexPath) as! LanguagesCell
        // cell.LanguageLabel.textColor = UIColor.blueColor()
        
        
        // self.navigationController!.pusdfshViewController(self.storyboard!.instantiateViewControllerWithIdentifier("announceDetail") as UIViewController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    var intSenderTag:Int!=0
    @objc func downloadPDFAction(_ sender:UIButton)
    {
        intSenderTag=sender.tag
        print(sender.tag)
        var docList = DocumentList()
        docList = mainArray.object(at: sender.tag) as! DocumentList
        let letGetValuew = docList.docAccessType
        print(letGetValuew)
        
        print("1.my queue value...>>>")
        print(mainArray)
        print(docList)
        print(docList.docAccessType)
        print(letGetValuew)
        print("2.my queue value...>>>")
        
        
        if(letGetValuew=="0")
        {
            print(letGetValuew)
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "doc_detail") as! DocumentsDetailController
            secondViewController.docListClass = docList
            secondViewController.grpProfileID = grpPRofileID
            secondViewController.docID=docList.docID as! NSString
            secondViewController.isAdmin=isAdmin
            secondViewController.isCategory = isCategory
            secondViewController.objprotocolForDocumentListing=self
            secondViewController.documentURL=docList.docURL
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else if(letGetValuew=="1")
        {
            varSender=String(sender.tag)

            var docList = DocumentList()
            docList = mainArray.object(at: sender.tag) as! DocumentList
            docListing = docList
            
            print(docList.docURL)
            print(docList)
            
            if fileExistance() == true
            {
                functionForRefreshingData()
                docListTableView.reloadData()
            }
            else
            {
                var isExist:Int=0

                /*------------------here need to check if url already exist start---------------------*/
               if(isExist==0)
               {
          functionForDownloadingManager(stringUrlTemp: docList.docURL!)

            }
                ///-----
            }
            ///-----
        }
    }
    /*----------------------this is code for the function for downloading and adding value start---------------------------------------*/
    var directoryName : String = "NewsLetterDirectory"
    var isExist:Int!=0
    func functionForDownloadingManager(stringUrlTemp:String)
    {
        var stringUrl:String!=""
        stringUrl=stringUrlTemp
       // var stringUrl:String! = (arrayResponse.object(at: indexPath.row) as AnyObject).object(forKey: "ebulletinlink")as! String
        if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
        {
        var isExist:Int=0
        let cacehDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if cacehDirectoryPath != nil
        {
            let tempcacehDirectoryPath = cacehDirectoryPath
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: tempcacehDirectoryPath[0])
                print(fileList)
                for i in 00 ..< fileList.count
                {
                    var varValue=fileList[i]
                    print(varValue)
                    if(stringUrl.contains(varValue))
                    {
                        progressLabel.isHidden=true
                        progressView.isHidden=true
                        var varGetFilePAth:String=""
                        varGetFilePAth=fileList[i]
                        isExist=1
                        varValue=String(describing: tempcacehDirectoryPath[0])+"/"+varValue
                        print(varValue)
                        let url = URL (string:varValue);
                        let requestObj = URLRequest(url: url!);
                        
                        var docList = DocumentList()
                        docList = mainArray.object(at: intSenderTag) as! DocumentList
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDocumentViewController") as! ShowDocumentViewController
                        secondViewController.filename=varValue
                        secondViewController.isComingFromDocument="yes"
                        secondViewController.objprotocolForDocumentListing=self
                        secondViewController.grpProfileID = grpPRofileID
                        secondViewController.docID=docList.docID as! NSString
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        break
                    }
                    else
                    {
                    }
                }
            }
            catch
            {
            }
        }
        if(isExist==0)
        {
            
            let string = stringUrl
            if (string?.isValidURL)! {
                print("This is right url")
            }
            else
            {
                print("This is wrong url")
            }
            self.progressView.setProgress(0, animated: false)
            self.progressLabel.text = "0.0 %"
            
            // let request = URLRequest.init(url: URL.init(string: "http://files.shareholder.com/downloads/AAPL/4907179320x0x952191/4B5199AE-34E7-47D7-8502-CF30488B3B05/10-Q_Q3_2017_As-Filed_.pdf")!)
            //http:\/\/www.rosteronwheels.com\/Documents\/documentsafe\/Group2765\/ROW_30112018060057PM.mov
            
            let request = URLRequest.init(url: URL.init(string: stringUrl)!)
            print("Thi sis newsletter url ")
            print(stringUrl)
            if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
            {
                self.progressView.isHidden=false
                self.progressLabel.isHidden=false
                self.BUTTONOPACITYDOWNLOADED.isHidden=false

                let downloadKey = SDDownloadManager.shared.dowloadFile(withRequest: request,
               inDirectory: nil,
               withName: nil,
               onProgress:  { [weak self] (progress) in
                let percentage = String(format: "%.1f %", (progress * 100))
                self?.progressView.setProgress(Float(progress), animated: true)
                self?.progressLabel.text = "\(percentage) %"
                }) { [weak self] (error, url) in
                    if let error = error
                    {
                        print("Error is \(error as NSError)")
                    }
                    else
                    {
                   if let url = url {
                       print("Downloaded file's url is \(url.path)")
                       //-----
                       let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                       let url = URL (string: url.path);
                       print(url?.path)
                       print(url)
                       let requestObj = URLRequest(url: url!);
                   }
               }
               print("Downloaded file's url is value :------ \(url?.path)")
               print("This is listing screen by Rajendra jat !!!")
               let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                    print(documentsPath)
                    if(url?.path != nil)
                    {
                        print("this is if part 1")
                        let url = URL (string: (url?.path)!);
                        let requestObj = URLRequest(url: url!);
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                        self?.BUTTONOPACITYDOWNLOADED.isHidden=true
                        var docList = DocumentList()
                        docList = self?.mainArray.object(at: (self?.intSenderTag)!) as! DocumentList
                        let secondViewController = self?.storyboard?.instantiateViewController(withIdentifier: "ShowDocumentViewController") as! ShowDocumentViewController
                        secondViewController.filename=(url?.path)!
                        secondViewController.isComingFromDocument="yes"
                        secondViewController.grpProfileID = self?.grpPRofileID
                        secondViewController.docID=docList.docID as! NSString
                        secondViewController.objprotocolForDocumentListing=self
                        self?.navigationController?.pushViewController(secondViewController, animated: true)
                    }
                    else
                    {
                         print("this is else part 1")
                        // self?.view.makeToast("Something went wrong, File not available.", duration: 2, position: CSToastPositionCenter)
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                        self?.BUTTONOPACITYDOWNLOADED.isHidden=true
                        SVProgressHUD.dismiss()
                        SVProgressHUD.dismiss()
                    }
                }
            }
            else
            {
                self.progressView.isHidden=false
                self.progressLabel.isHidden=false
                self.BUTTONOPACITYDOWNLOADED.isHidden=false
                let url = URL (string: (stringUrl));
                print(url)
                let requestObj = URLRequest(url: url!);
                print("http://-----------------------")
                let downloadKey = SDDownloadManager.shared.dowloadFile(withRequest: request,
                inDirectory: directoryName,
                withName: nil,
                onProgress:  { [weak self] (progress) in
                 let percentage = String(format: "%.1f %", (progress * 100))
                 self?.progressView.setProgress(Float(progress), animated: true)
                 self?.progressLabel.text = "\(percentage) %"
                 
                }) { [weak self] (error, url) in
                    if let error = error
                    {
                          print("this is if part 2")
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                        SVProgressHUD.dismiss()
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        print("this is else part 2")
                        self?.progressView.isHidden=true
                        self?.progressLabel.isHidden=true
                        SVProgressHUD.dismiss()
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
        }
        else
        {
            if(stringUrl.contains("http"))
            {
                
            }
            else
            {
                stringUrl="http://"+stringUrl
            }
            let url = URL (string: (stringUrl));
            print(url)
            
            let requestObj = URLRequest(url: url!);
            print("http://-----------------------")
            
            if let url = NSURL(string: stringUrl){
//                UIApplication.shared.openURL(url as URL)
                
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }
            }

        }
    }
    /*--------------------This is code for the function for downloading and adding value end-------------------------------------------*/
    func functionToCall()
    {
        // alertController.dismiss(animated: true, completion: nil)
        // self.view!.makeToast("Downsadfdasfloaded file successfully", duration: 2, position: CSToastPositionCenter)
        
    }
    
    var alertController = UIAlertController()
    
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            
            var docList = DocumentList()
            docList = self.mainArray.object(at: Int(varSender)!) as! DocumentList
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "doc_detail") as! DocumentsDetailController
            secondViewController.docListClass = docList
            secondViewController.grpProfileID = self.grpPRofileID
            secondViewController.docID=docList.docID as! NSString
            
            // self.navigationController?.puxdfgshViewController(secondViewController, animated: true)
            
            
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    func deleteSucc(_ docListing : DeleteResult)
    {
        functionForGetData()
        if(docListing.value(forKey: "status") as! String == "0" )
        {
            
            let alert = UIAlertController(title: "Documents", message: "Document Deleted Successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                // self.navigationController?.popViewControllerAnimated(true)
            }));
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
        }
        ////DPK19-03-2018
    }
    @objc func deletePDFAction(_ sender : UIButton)
    {
        
        var docList = DocumentList()
        docList = mainArray.object(at: sender.tag) as! DocumentList
        
        
        let letGetGroupProfileId=grpPRofileID
        
        print("Delete PDF")
        //--------Action Sheet for confirmation----------
        let alertController = UIAlertController(title: "Confirmation", message: "Want to delete this document ?", preferredStyle: .actionSheet)
        let sendButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            //----------∆∆∆∆∆∆∆∆∆∆∆∆
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(docList.docID, type: "Document", profileID: letGetGroupProfileId as! String)
            print("deleteDOCAction")
            //need to reload tableview
            // let wsm : WebserviceClass = WebserviceClass.sharedInstance
            // wsm.delegates=self
            let defaults = UserDefaults.standard
            if let uid = defaults.string(forKey: "masterUID")
            {
                //wsm.DocumentsListing(self.groupIDX, memberProfileID: self.grpPRofileID as String)
                
                if self.isAdmin == "Yes"
                {
                    wsm.DocumentsListing(self.groupIDX, memberProfileID: self.grpPRofileID as String, stringType: self.annType as String, stringIsAdmin: "1", StringSearchTest: self.varGetSearchText)
                }
                else
                {
                    wsm.DocumentsListing(self.groupIDX, memberProfileID: self.grpPRofileID as String, stringType: "1", stringIsAdmin: "0", StringSearchTest: self.varGetSearchText)
                }
            }
            //--------∆∆∆∆∆∆∆∆∆∆
        })
        let  deleteButton = UIAlertAction(title: "No", style: .default, handler: { (action) -> Void in
        })
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
//        })
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
//        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
        
        /////////------------------
    }
    func buttonViewActionClickEvent(_ sender : UIButton)
    {
        
        print(sender.tag)
        
        
        
        var docList = DocumentList()
        docList = mainArray.object(at: sender.tag) as! DocumentList
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "doc_detail") as! DocumentsDetailController
        secondViewController.docListClass = docList
        self.pickerView.isHidden=true
        secondViewController.grpProfileID = grpPRofileID
        secondViewController.docID=docList.docID as! NSString
        secondViewController.objprotocolForDocumentListing=self
        
        let letGetValuew = docList.docAccessType
        
        print(letGetValuew)
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // 1
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        
        
        let aString = docListing.docTitle
        let newString = aString?.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print("2 this is value :-----")
        
        
        print(newString)
        print(docListing.docType)
        
        
        if(newString==nil)
        {
            
        }
        else
        {
            let str = newString! + docListing.docType
            
            print("11111this is value :-----")
            print(str)
            print(docListing.docURL)
            print(docListing.docID)
            print(docListing.docTitle)
            print(docListing.docType)
            print(docListing.docAccessType)
            // print(docListing.doc)
            
            
            print("222 this is value :-----")
            print(docListing.docID + docListing.docType)
            
            
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentDirectoryPath:String = path[0]
            let fileManager = FileManager()
            let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/\(str)")
            
            print("this is value :-----")
            print(destinationURLForFile)
            
            if fileManager.fileExists(atPath: destinationURLForFile.path){
                
                print(destinationURLForFile.path)
                
                self.fileExistance()
                
            }
            else{
                do {
                    try fileManager.moveItem(at: location, to: destinationURLForFile)
                    // show file
                    //                    let uploadFilename = ""
                    //                    let sourcePath = NSBundle.mainBundle().pathForResource("download", ofType: "pdf")
                    //                    let destinationPath = "/"
                    //
                    //                    self.dbRestClient.uploadFile(uploadFilename, toPath: destinationPath, withParentRev: nil, fromPath: sourcePath)
                    
                    print(destinationURLForFile.path)
                    
                    self.fileExistance()
                    
                }catch{
                    print("An error occurred while moving file to destination url")
                }
            }
        }
    }
    // 2
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
    }
    
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?){
        downloadTask = nil
        if (error != nil) {
            //  print(error?.description)
        }else{
            print("The task finished transferring data successfully")
        }
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    func removeFile()
    {
        let str = docListing.docID + docListing.docType
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("\(str)")
        let filePath:String = fileURL.path
        
        do
        {
            try fileManager.removeItem(atPath: filePath)
        }
        catch
        {
        }
    }
    
    func fileExistance() -> Bool
    {
        let str = docListing.docID + docListing.docType
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("\(str)")
        let filePath:String = fileURL.path
        
        //  print(filePath)
        if  fileManager.fileExists(atPath: filePath)
        {
            print("FILE AVAILABLE");
            
            return true
        }
        else
        {
            print("FILE NOT AVAILABLE");
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        //{
        
        
        
        
        //NoRecordLabel.hidden = true
        //loaderClass.loaderViewMethod()
        varGetSearchBoxValue = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        let strValues = varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
        
        
        print(strValues)
        print(varGetSearchBoxValue)
        //            if(strValues==""){
        //                mainArray = copymainArray .mutableCopy() as! NSArray
        //                if([mainArray.count] == 0) {
        //
        //                    NoRecordLabel.hidden = false
        //                    docListTableView.hidden = true;
        //                }
        //                else {
        //
        //                    NoRecordLabel.hidden = true
        //                    docListTableView.hidden = false;
        //
        //                }
        //                // searchTextField.text="";
        //                //searchTextField.resignFirstResponder()
        //                docListTableView.reloadData()
        //            }else{
        //                mainArray=[]
        //
        //                let predicate = NSPredicate(format: "docTitle contains[c] %@",strValues)
        //                mainArray = copymainArray.filteredArrayUsingPredicate(predicate)
        //                if (mainArray.count==0)
        //                {
        //
        //                    NoRecordLabel.hidden = false
        //                    docListTableView.reloadData()
        //                }
        //                else
        //                {
        //
        //                    NoRecordLabel.hidden = true
        //                    docListTableView.reloadData()
        //                }
        //                docListTableView.reloadData()
        //            }
        //            self.loaderClass.window = nil
        //            //searchTextField.resignFirstResponder()
        //            return true
        //        }
        //        else
        //        {
        //            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        //            return false
        //        }
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if(isAdmin=="Yes")
        {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            var docList = DocumentList()
            docList = mainArray.object(at: indexPath.row) as! DocumentList
            let letGetGroupProfileId=grpPRofileID
            print("Delete PDF")
            //----------∆∆∆∆∆∆∆∆∆∆∆∆
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates=nil
            wsm.delegates=self
            wsm.deleteDataWebservice(docList.docID, type: "Document", profileID: letGetGroupProfileId as! String)
            print("deleteDOCAction")
            //need to reload tableview
            // let wsm : WebserviceClass = WebserviceClass.sharedInstance
            // wsm.delegates=self
            let defaults = UserDefaults.standard
            if let uid = defaults.string(forKey: "masterUID")
            {
                //wsm.DocumentsListing(self.groupIDX, memberProfileID: self.grpPRofileID as String)
                if isAdmin == "Yes"
                {
                    wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: annType as String, stringIsAdmin: "1", StringSearchTest: varGetSearchText)
                }
                else
                {
                    wsm.DocumentsListing(groupIDX, memberProfileID: grpPRofileID as String, stringType: "1", stringIsAdmin: "0", StringSearchTest: varGetSearchText)
                }
            }
        }
    }
    //////////---------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDataSource.count;
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //if isAdmin == "Yes"
        //{
        return pickerDataSource[row]
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(pickerDataSource[row])
        //var pickerDataSource = ["All", "Published", "Scheduled", "Expired"];
        NoRecordLabel.isHidden=true
        
        //if isAdmin == "Yes"
        // {
        if(pickerDataSource[row]=="All")
        {
            self.listTypeTextField.text="All"
            self.annType="0"
        }
        else if(pickerDataSource[row]=="Published")
        {
            self.listTypeTextField.text="Published"
            self.annType="1"
        }else if(pickerDataSource[row]=="Scheduled")
        {
            self.listTypeTextField.text="Scheduled"
            self.annType="2"
        }
        else if(pickerDataSource[row]=="Expired")
        {
            self.listTypeTextField.text="Expired"
            
            self.annType="3"
        }
        self.pickerView.isHidden=true
        searchTextField.text=nil
        mainArray = NSArray()
        UserDefaults.standard.setValue("no", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        functionForGetData()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(textField.tag==22)
            {
                searchTextField.resignFirstResponder()
                self.view .bringSubviewToFront( self.pickerView)
                self.pickerView.isHidden=false
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            searchTextField.resignFirstResponder()
            self.view .bringSubviewToFront( self.pickerView)
            self.pickerView.isHidden=true
            return false
            
            SVProgressHUD.dismiss()
        }
    }
    
    
}
