
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

protocol protocolNamePopValue
{
    func functionForPopBackValue(stringValue1:String)
    func functionForPopBackValue1(stringValue1:String)
}

class DetialsTVC:UITableViewCell{
    
    
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var btneye: UIButton!
    @IBOutlet weak var lbl: UILabel!
}

class DetailsCVC : UICollectionViewCell
{
    
    @IBOutlet weak var celImg: UIImageView!
}

class Image: NSObject, ImageSlideShowProtocol
{
    private let url: URL
    let title: String?
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
    func slideIdentifier() -> String {
        return String(describing: url)
    }
    
    func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: self.url) { data, response, error in
            
            if let data = data, error == nil
            {
                let image = UIImage(data: data)
                completion(image, nil)
            }
            else
            {
                completion(nil, error)
            }
        }.resume()
    }
}

class NewShowCasePhotoDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,protocolNamePopValue,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    var textfieldYear = ""
    var getGroupId = ""
    var navTitleName = ""
    var addCOMM: AddCOM?
    var avenueShareType: String? = ""
    var avenueEditTitle = ""
    var inddd = 0
    
    func createPDF() {
        let html = "<!DOCTYPE html><html><body><h2>HTML Image</h2><img src='pic_trulli.png' alt='Trulli' width='500' height='200'></body></html>"
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        pdfData.write(toFile: "\(documentsPath)/file.pdf", atomically: true)
        
        print("This is PDf path :------------")
        print(documentsPath)
        let documentsPath2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL(fileURLWithPath: documentsPath, isDirectory: true).appendingPathComponent("file").appendingPathExtension("pdf")
        let urlRequest = URLRequest(url: url)
        
        print("This is PDf documentsPath :------------")
        print(documentsPath2)
        print("This is PDf url :------------")
        print(url)
        print("This is PDf urlRequest :------------")
        print(urlRequest)
        
    }
    
    func loadPDF(filename: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL(fileURLWithPath: documentsPath, isDirectory: true).appendingPathComponent(filename).appendingPathExtension("pdf")
        let urlRequest = URLRequest(url: url)
       // webView.loadRequest(urlRequest)
    }

    var documentInteractionController: UIDocumentInteractionController = UIDocumentInteractionController()

    
    @IBAction func buttonShareClickEvent(_ sender: Any)
    {

        self.pdfDataWithTableView(tableView: self.tblView)

        let fileManager = FileManager.default
        if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            var fileURL = URL(string: "")
                fileURL = documentsURL.appendingPathComponent("SharedDocument.pdf")
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }

        /* working code for email @
        let fileManager = FileManager.default
        if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentoPath = documentsURL.appendingPathComponent("myDocument.pdf").path
            if fileManager.fileExists(atPath: documentoPath){
                let documento = NSData(contentsOfFile: documentoPath)
                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView=self.view
                present(activityViewController, animated: true, completion: nil)
            }
            else {
                print("document was not found")
            }
        }
       */

        //  DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            /* .pdf screen shot */

        // self.captureScreenshot()
       // })
        //--------1111
      
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//            let fileManager = FileManager.default
//            if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let databasePath = documentsURL.appendingPathComponent("myDocument.pdf").path
//
//                /*-----------*/
//                var fileURL = URL(string: databasePath)
//                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                    fileURL = documentsURL.appendingPathComponent("myDocument.pdf")
//
//
//                let activityViewController = UIActivityViewController(
//                    activityItems: [fileURL!],
//                    applicationActivities: nil
//                )
//                /*-----------*/
//
//
//
//
//                print("directory path:", documentsURL.path)
//                print("database path:", databasePath)
//                let fileManager2 = FileManager.default
//                if fileManager2.fileExists(atPath: databasePath){
////                    let documento = NSData(contentsOfFile: databasePath)
////                    let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
////                    activityViewController.popoverPresentationController?.sourceView=self.view
////                    self.present(activityViewController, animated: true, completion: nil)
////
////                ///---
////                   // if let image = UIImage(named: "whatsappIcon") {
////                      //  if let imageData = UIImageJPEGRepresentation(image, 1.0) {
////                            let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(databasePath)
////                            do {
////                                print(tempFile)
////                                try documento?.write(to: tempFile, options: .atomic)
////                                self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
////                                self.documentInteractionController.uti = "net.whatsapp.image"
////                                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
////
////                            } catch {
////                                print(error)
////                            }
////                        //}
////                   // }
////                    //----
//
//
//                }
//                else {
//                    print("document was not found")
//                }
//            }
//        })
//
//        //--------1111
//        //-------2222
//
//        /////3333
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
//            let fileManager = FileManager.default
//            if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let databasePath = documentsURL.appendingPathComponent("myDocument.pdf").path
//                print("directory path:", documentsURL.path)
//                print("database path:", databasePath)
//                if fileManager.fileExists(atPath: databasePath){
//
//                    var fileURL = URL(string: databasePath)
//                  //  let _: DownloadRequest.DownloadFileDestination = { _, _ in
//                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                        fileURL = documentsURL.appendingPathComponent("myDocument.pdf")
//                        print("1111")
//                        print(fileURL)
//                       // return (fileURL!, [.removePreviousFile, .createIntermediateDirectories])
//                   // }
//                    print("222")
//                    print(fileURL)
//                    let activityViewController = UIActivityViewController(
//                        activityItems: ["http://ameetmehtaweb.touchbase.in/Documents/TAC.pdf"],
//                        applicationActivities: nil
//                    )
//
//                    /*-----11 start-----------------------------------------------------------------------------------------*/
//                    let urlWhats = "whatsapp://app"
//                    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
//                        if let whatsappURL = URL(string: urlString) {
//
//                            if UIApplication.shared.canOpenURL(whatsappURL as URL) {
//
//                                if let image = UIImage(named: "whatsappIcon") {
//                                    if let imageData = UIImageJPEGRepresentation(image, 1.0) {
//                                        let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
//                                        do {
//                                            print(tempFile)
//                                            try imageData.write(to: tempFile, options: .atomic)
//                                            self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
//                                            self.documentInteractionController.uti = "net.whatsapp.image"
//                                            self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
//
//                                        } catch {
//                                            print(error)
//                                        }
//                                    }
//                                }
//
//                            } else {
//                                // Cannot open whatsapp
//                            }
//                        }
//                    }
//
//                    /*---11 end---------------------------------------------------------------------------------------*/
//
//
//
//
//
//
//
//
//                }
//                else {
//                    print("document was not found")
//                }
//            }
//        })
//
        
    }
    
    
    
    
    func captureScreenshot(){
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        // Creates UIImage of same size as view
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // THIS IS TO SAVE SCREENSHOT TO PHOTOS
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
    }
    
    
    func pdfDataWithTableView(tableView: UITableView) {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        print(docURL)
        docURL = docURL.appendingPathComponent("SharedDocument.pdf")
        pdfData.write(to: docURL as URL, atomically: true)
    }
    
    
    
    
    
    func functionForPopBackValue(stringValue1: String) {
        //backvalue
        print("bvalue d",stringValue1)
        strWhichType = stringValue1
        if(strWhichType == "Club Service"){
        //     self.title = "Club Meeting"
        }else{
         //    self.title = "Service Project"
        }
    }
    
    func functionForPopBackValue1(stringValue1: String) {
        //backvalue
        print("this is value ")
        print("bvalue d",stringValue1)
        strWhichType = stringValue1
        if(strWhichType == "Club Service"){
           // self.title = "District Event"
        }else{
          //  self.title = "District Project"
        }
    }
    
 
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
    var year:String!=""
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
    var muaaryHoriZontal : NSMutableArray?
    var muaaryHoriZontalName : NSMutableArray?
    var muarrayAgendaorMetting : NSMutableArray?
    var muarrayAgendaorMettingName : NSMutableArray?
    var varChangesInPhotos:String = ""
    var strdistorClube : String?
    var strWhichType:String?
    var checkString:String!=""
    var pageTitle:String=""
    fileprivate var images:[Image] = []
    
    var getGroupDistrictList:NSMutableArray=NSMutableArray()
 
    //MARK:-Added on April 2020
    var MemberCount:String=""
    var BenificiaryCount:String=""

    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var collectionHori: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    
    
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- New IBOutlet on April 2020
//    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var btnMediaTitle: UIButton!
    @IBOutlet weak var btnPhotoTitle: UIButton!
//    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    //MARK:- New var add on April 2020
//    var originalMediaFrame:CGRect=CGRect()
    var originalPhotoFrame:CGRect=CGRect()
    var mediaPhotoPAth:String=""
    var mediaPhotoDesc:String=""
    var wentFromMediaPhotoPAge:Bool=false

    /*
     DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
     let fileManager = FileManager.default
     if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
     let databasePath = documentsURL.appendingPathComponent("myDocument.pdf").path
     print("directory path:", documentsURL.path)
     print("database path:", databasePath)
     let fileManager2 = FileManager.default
     if fileManager2.fileExists(atPath: databasePath){
     let documento = NSData(contentsOfFile: databasePath)
     let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
     activityViewController.popoverPresentationController?.sourceView=self.view
     self.present(activityViewController, animated: true, completion: nil)
     }
     else {
     print("document was not found")
     }
     }
     })
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPDF()
        print("This is Activity Detail Pafe for ")
        print(checkString)//empty for Club // for district Service Project and Club Service
        print(strWhichType)
        print(pageTitle)
        self.title=self.pageTitle
        setMediaPhotoView()
        muarrayAgendaorMetting = NSMutableArray()
        muaaryHoriZontal = NSMutableArray()
        muarrayMainList = NSMutableArray()
        SVProgressHUD.show()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(mediaPicClickEvent))
//        mediaImageView.addGestureRecognizer(tap)
//        mediaImageView.isUserInteractionEnabled = true
       
        //-------------------------
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
//        originalMediaFrame=self.mediaView.frame
        originalPhotoFrame=self.photoView.frame

        if strWhichType == "Club Service" || strWhichType == "District Events"
        {
//            self.mediaView.isHidden=true
//            self.photoView.frame = CGRect(x: self.mediaView.frame.origin.x, y: self.mediaView.frame.origin.y, width: self.view.frame.width, height: self.photoView.frame.height+100)
            self.btnPhotoTitle.setTitle("Photos", for: .normal)
        }
        else if strWhichType == "District Projects" || strWhichType == "Service Projects"
        {
            self.btnPhotoTitle.setTitle("Project Photos", for: .normal)
        }
    }
   
    override func viewDidLayoutSubviews() {
        print("test here is come or not")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Coming in view will appear")
        self.navigationController?.navigationBar.isHidden=false
        self.navigationItem.setHidesBackButton(false, animated: false)
        if wentFromMediaPhotoPAge
        {
            wentFromMediaPhotoPAge=false
            return
        }
        muarrayHoldingImageUrl = NSMutableArray()
        muarrayHoldingImageDescription = NSMutableArray()
        self.navigationController?.isNavigationBarHidden = false
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
        self.navigationItem.righctBarButtonItems = buttons as? [UIBarButtonItem]
        */
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DocumentListViewControlller.UploadDocControllerAction))
        add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0) //UIColor.whiteColor()
       // let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
       
        let searchButton1 = UIButton(type: UIButton.ButtonType.custom)
        searchButton1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchButton1.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        searchButton1.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.buttonEditDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
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
    
    ////---
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
        searchButton1.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.buttonEditDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
        let search1: UIBarButtonItem = UIBarButtonItem(customView: searchButton1)
        
        
//        let searchButton = UIButton(type: UIButton.ButtonType.custom)
//        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
//        searchButton.addTarget(self, action: #selector(self.buttonnewShowDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
//        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        var buttons : NSArray = []
       // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
        
        var mainMemberID:String! = UserDefaults.standard.string(forKey: "isAdmin")as! String
        print("admin right !!!")
        print(mainMemberID)
        if mainMemberID == "Yes"
        {
               print("if")
            var buttons : NSArray = [search1]
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        else
        {
               print("else")
            var buttons : NSArray = []
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }

    @objc func buttonnewShowDownloadableDocumentClickEvent()
    {
        let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocumentDownloadedViewController") as! DocumentDownloadedViewController
        self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)
    }

    @objc func buttonEditDownloadableDocumentClickEvent()
    {
        if(self.GetIsCategoryFromClubOrDistrict == "2"){
            
//            editcommunity()
            let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
            objAddPhoto.year = year
            objAddPhoto.strAlbumId = GetAlbumID
            objAddPhoto.strGroupId = GetGroupID
            objAddPhoto.strcreatedBy = GetUserProfileID
            objAddPhoto.moduleId = GetModuleID
            objAddPhoto.apiKeyYear = year
            objAddPhoto.isCalledFRom = "Edit"
            objAddPhoto.objProtocolNameNew=self
            objAddPhoto.MemberCount = self.MemberCount
            objAddPhoto.BenificiaryCount = self.BenificiaryCount
            objAddPhoto.strWitchType = self.strWhichType
            objAddPhoto.alertTitle=self.pageTitle
            objAddPhoto.checkString = checkString//Club Service or Service Project
            self.navigationController?.pushViewController(objAddPhoto, animated: true)
            
        }else{
            
//            let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
//            objAddPhoto.strAlbumId = GetAlbumID
//            objAddPhoto.strGroupId = GetGroupID
//            objAddPhoto.strcreatedBy = GetUserProfileID
//            objAddPhoto.moduleId = GetModuleID
//            objAddPhoto.year = year
//            print(objAddPhoto.strAlbumId)
//            print(objAddPhoto.strGroupId)
//            print(objAddPhoto.year)
//            objAddPhoto.isCalledFRom = "Edit"
//            objAddPhoto.objProtocolNameNew=self
//            objAddPhoto.MemberCount = self.MemberCount
//            objAddPhoto.BenificiaryCount = self.BenificiaryCount
//            objAddPhoto.checkString = strWhichType
//            objAddPhoto.strWitchType = self.strWhichType
//            objAddPhoto.alertTitle=self.pageTitle
//            objAddPhoto.navTitle = (self.navTitleName == "Club Service") ? "Edit Club Service" : "Edit Community Service Project"
//            print( objAddPhoto.navTitle)
//            self.navigationController?.pushViewController(objAddPhoto, animated: true)
            editcommunity()
            
        }
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @objc func editClicked()
   {
       print("GetIsCategoryFromClubOrDistrict-----------\(self.GetIsCategoryFromClubOrDistrict)")
       if(self.GetIsCategoryFromClubOrDistrict == "2"){
           let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "DistAddPhotoNewVC") as! DistAddPhotoNewVC
           objAddPhoto.year = year
           objAddPhoto.strAlbumId = GetAlbumID
           objAddPhoto.strGroupId = GetGroupID
           objAddPhoto.strcreatedBy = GetUserProfileID
           objAddPhoto.moduleId = GetModuleID
           objAddPhoto.isCalledFRom = "Edit"
           objAddPhoto.objProtocolNameNew=self
           objAddPhoto.MemberCount = self.MemberCount
           objAddPhoto.BenificiaryCount = self.BenificiaryCount
           objAddPhoto.strWitchType = self.strWhichType
           objAddPhoto.alertTitle=self.pageTitle
           objAddPhoto.checkString = checkString//Club Service or Service Project
           self.navigationController?.pushViewController(objAddPhoto, animated: true)
       } else {
           editcommunity()
       }
       
//       let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
//       objAddPhoto.strAlbumId = GetAlbumID
//       objAddPhoto.strGroupId = GetGroupID
//       objAddPhoto.strcreatedBy = GetUserProfileID
//       objAddPhoto.moduleId = GetModuleID
//       objAddPhoto.year = year
//       print(objAddPhoto.strAlbumId)
//       print(objAddPhoto.strGroupId)
//       print(objAddPhoto.year)
//       objAddPhoto.isCalledFRom = "Edit"
//       objAddPhoto.objProtocolNameNew=self
//       objAddPhoto.MemberCount = self.MemberCount
//       objAddPhoto.BenificiaryCount = self.BenificiaryCount
//       objAddPhoto.checkString = strWhichType
//       objAddPhoto.strWitchType = self.strWhichType
//       objAddPhoto.alertTitle=self.pageTitle
//       objAddPhoto.navTitle = (self.navTitleName == "Club Service") ? "Edit Club Service" : "Edit Community Service Project"
//       print( objAddPhoto.navTitle)
//       self.navigationController?.pushViewController(objAddPhoto, animated: true)

       
       
       
//       let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
//       print(self.GetAlbumID)
//       albumControllerObject.year=self.textfieldYear as Any as! String
//       albumControllerObject.strAlbumId = ""
//       albumControllerObject.strGroupId = self.getGroupId
//       albumControllerObject.moduleId = self.getModuleID
//       albumControllerObject.isCalledFRom = "add"
//       albumControllerObject.categoryId = ""
//       albumControllerObject.strcreatedBy = self.GetUserProfileID
//       albumControllerObject.MemberCount=self.MemberCount
//       albumControllerObject.BenificiaryCount=self.BenificiaryCount
//       albumControllerObject.alertTitle=self.pageTitle
//       albumControllerObject.strWitchType=self.GetModuleName
//       self.navigationController?.pushViewController(albumControllerObject, animated: true)
//
      
   }
    
    func editcommunity() {
        SVProgressHUD.show()
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/GetWebAdminAvenueofServicelink"
//                if let masterID = masterUId, let loginType = varGetLoginType, let mobile = varGetMobileNumber {
        if let grpID = GetGroupID, let pro = GetUserProfileID, let al = self.GetAlbumID, let shareTyp = self.avenueShareType {
            let parameterst = ["Fk_groupID":grpID,"fk_ProfileID":pro,"sharetype":shareTyp,"AlbumID": al, "Projectyear": textfieldYear]
            print("Club Online CO<Dashboard parameterst:: \(parameterst)")
            print("Club Online CO<Dashboard completeURL:: \(url)")
            
            //------------------------------------------------------
            Alamofire.request(url, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                    if let value = response.result.value {
                        do {
                            // Attempt to decode the JSON data
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(AddCOM.self, from: jsonData)
                            SVProgressHUD.dismiss()
                            print("ListSyncOnline:--- \(decodedData)")
                            self.addCOMM = decodedData
                            if self.addCOMM?.adminSubmodulesResult?.status == "0" {
                              
                                
                                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
                                editProfileScreen.url = self.addCOMM?.adminSubmodulesResult?.list?[self.inddd].url ?? ""
                                editProfileScreen.moduleName = self.avenueEditTitle
                                editProfileScreen.varFromCalling = "Avenue Service"
                                print(editProfileScreen.url)
                                self.navigationController?.pushViewController(editProfileScreen, animated: true)
                               
                            }
                        }
                        catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                case .failure(_): break
                }
            }
        }
//        }
    }
    
    func createNavigationBarmine()
    {
        self.title = strWhichType
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        if GetIsAdmin=="Yes" {
            let buttonRight = UIButton(type: UIButton.ButtonType.custom)
            buttonRight.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonRight.setImage(UIImage(named:"editDEdit"), for: UIControl.State.normal)
            buttonRight.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.editClicked), for: UIControl.Event.touchUpInside)
            let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
            self.navigationItem.rightBarButtonItem = rightButton
        }
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
            objAddPhoto.year = year
            objAddPhoto.strAlbumId = GetAlbumID
            objAddPhoto.strGroupId = GetGroupID
            objAddPhoto.strcreatedBy = GetUserProfileID
            objAddPhoto.moduleId = GetModuleID
            objAddPhoto.isCalledFRom = "Edit"
            objAddPhoto.MemberCount = self.MemberCount
            objAddPhoto.BenificiaryCount = self.BenificiaryCount
            print(CategoryIdForPassingNectScreen)
            objAddPhoto.categoryId=CategoryIdForPassingNectScreen
            objAddPhoto.strWitchType = self.strWhichType
            objAddPhoto.alertTitle=self.pageTitle
            objAddPhoto.checkString = checkString //Club Service or Service Project

            self.navigationController?.pushViewController(objAddPhoto, animated: true)
        }else{
            let objAddPhoto = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
            objAddPhoto.strAlbumId = GetAlbumID
            objAddPhoto.strGroupId = GetGroupID
            print(objAddPhoto.strGroupId)
            print(objAddPhoto.strAlbumId)
            objAddPhoto.strcreatedBy = GetUserProfileID
            objAddPhoto.moduleId = GetModuleID
            objAddPhoto.isCalledFRom = "Edit"
            objAddPhoto.objProtocolNameNew=self
            objAddPhoto.MemberCount = self.MemberCount
            objAddPhoto.BenificiaryCount = self.BenificiaryCount
            objAddPhoto.checkString = strWhichType
            objAddPhoto.strWitchType = self.strWhichType
            objAddPhoto.alertTitle=self.pageTitle
            objAddPhoto.navTitle = (self.navTitleName == "Club Service") ? "Edit Club Service" : "Edit Community Service Project"
            print( objAddPhoto.navTitle)

            self.navigationController?.pushViewController(objAddPhoto, animated: true)
        }
    }
    
    
    // MARK: - Table View datasourece and delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (TempArrayName.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "DetialsTVC", for: indexPath) as! DetialsTVC
        
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
        SVProgressHUD.show()
       // if(sender.tag==0)
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
        SVProgressHUD.dismiss()
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
                print("Validation Successful")
                print("Downloaded file successfully")
                // self.view!.makeToast("Downloaded file successfully", duration: 2, position: CSToastPositionCenter)
                alert.dismiss(animated: true, completion: nil)
                SVProgressHUD.dismiss()
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
                SVProgressHUD.dismiss()
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
            //cell.celImg.sd_setImage(with: checkedUrl)
            cell.celImg.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: ""))
            return cell
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        /*
        let custImageView:UIImageView=UIImageView()
        custImageView.frame=CGRect(x: 0, y: 0, width: 300.0, height: 300.0)
        
        let url = (muarrayMainList[indexPath.row] as AnyObject).value(forKey: "url")
        let ImageProfilePic:String = (url as AnyObject).replacingOccurrences(of: " ", with: "%20")
        let checkedUrl = URL(string: ImageProfilePic)

        custImageView.sd_setImage(with: checkedUrl)
        
        let image:UIImage=custImageView.image!
        
        self.shareImageWithTitle(image: image, desc: muarrayHoldingImageDescription.object(at: indexPath.row) as! String)
    */
        
        // need to uncomment below lines
 
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
    }
}
    /*
     if collectionView == self.collectionView{
     print("selfView width \(self.view.bounds.width)")
     print("selfView width 1 \(self.view.frame.width)")
     print("collectionView width \(self.collectionView.bounds.width)")
     print("collectionView width \(self.collectionView.frame.width)")
     print("Actual Cell width \((collectionView.bounds.width - (3 * 0))/3)")
     }
     */
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 5))/3, height: 120)
//        return cellSize
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
//    {
//        let sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
//        return sectionInset
//    }

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

    func shareImageWithTitle(image:UIImage,desc:String)
    {
        let items:NSMutableArray=[image]
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: items as! [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                //print("cancel clicked ")
                return
            }
            //print("other  clicked ")
        }
        self.present(activityViewController, animated: true, completion: nil)
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
        SVProgressHUD.show()
        let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
        var parameterst:NSDictionary=NSDictionary()
        
        parameterst =  ["albumId":GetAlbumID,
                        "groupId":GetGroupID,
                        "Financeyear": year]
        
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
                let arrarrNewGroupList = (dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "Result")

                //
                //                print(arrarrNewGroupList)
                //                print(arrarrNewGroupList as! NSArray)

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
            }
            else
            {
                self.photoView.isHidden = true
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
        
//        GetAlbumDetails_New :- [albumId=687, Financeyear=2021-2022]
        
        SVProgressHUD.show()
        let completeURL = baseUrl+"Gallery/GetAlbumDetails_New"
        var parameterst:NSDictionary=NSDictionary()

        parameterst =  ["albumId":GetAlbumID as Any,"Financeyear" : year ]
        self.TempArray = NSMutableArray()
        self.TempArrayName  = NSMutableArray()
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
 //=> Handle server response
 let dd = response as! NSDictionary
 print("dd \(dd)")
 print(self.strWhichType)
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

print("witch type: \(self.strWhichType)")
 if self.strWhichType == "District Projects" || self.strWhichType == "Service Projects"
 {
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
//    self.mediaView.frame = CGRect(x: self.originalMediaFrame.origin.x, y: self.originalMediaFrame.origin.y, width: self.view.frame.width, height: self.originalMediaFrame.height)
    
    self.photoView.frame = CGRect(x: self.originalPhotoFrame.origin.x, y: self.originalPhotoFrame.origin.y, width: self.view.frame.width, height: self.originalPhotoFrame.height)

//     self.mediaView.isHidden=false
    let ImageMediaPic:String = (self.mediaPhotoPAth as AnyObject).replacingOccurrences(of: " ", with: "%20")
     let checkedUrl = URL(string: ImageMediaPic)
//     self.mediaImageView.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: ""))
 }
 else
 {
//  self.mediaView.isHidden=true
//  self.photoView.frame = CGRect(x: self.mediaView.frame.origin.x, y: self.mediaView.frame.origin.y, width: self.view.frame.width, height: self.photoView.frame.height+100)
    }
 }

 // let NumberOfRotarian =      (muarrayListData.value(forKey: "NumberOfRotarian") as AnyObject).object(at: 0) as! String
  let albumId  =          (muarrayListData.value(forKey: "albumId") as AnyObject).object(at: 0) as! String
  let beneficiary  =          (muarrayListData.value(forKey: "beneficiary") as AnyObject).object(at: 0) as! String
  let albumTitle =            (muarrayListData.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String
  //  let clubname =              (muarrayListData.value(forKey: "clubname") as AnyObject).object(at: 0) as! String
  //  let cost_of_project_type =  (muarrayListData.value(forKey: "cost_of_project_type") as AnyObject).object(at: 0) as! String
  let description  =          (muarrayListData.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String
  //   let groupId      =          (muarrayListData.value(forKey: "groupId") as AnyObject).object(at: 0) as! String
  //    let image =                 (muarrayListData.value(forKey: "image") as AnyObject).object(at: 0) as! String
  //let isAdmin =             muarrayListData.valueForKey("isAdmin").objectAtIndex(sender.tag) as? String
  //    let moduleId =              ((muarrayListData.value(forKey: "moduleId") as AnyObject).object(at: 0) as! String)
  let project_cost =          (muarrayListData.value(forKey: "project_cost") as AnyObject).object(at: 0) as! String
  let project_date =           (muarrayListData.value(forKey: "project_date") as AnyObject).object(at: 0) as! String
  //   let title        =           (muarrayListData.value(forKey: "title") as AnyObject).object(at: 0) as! String
  let type = (muarrayListData.value(forKey: "MeetingType") as AnyObject).object(at: 0) as! String
  let working_hour =          (muarrayListData.value(forKey: "working_hour") as AnyObject).object(at: 0) as! String
  //    let working_hour_type =     (muarrayListData.value(forKey: "working_hour_type") as AnyObject).object(at: 0) as! String
  //     let sharetype =             (muarrayListData.value(forKey: "sharetype") as AnyObject).object(at: 0) as! String
  let Attendance =            (muarrayListData.value(forKey: "Attendance") as AnyObject).object(at: 0) as? String
  let AttendancePer =         (muarrayListData.value(forKey: "AttendancePer") as AnyObject).object(at: 0) as? String
  let AgendaAttachement =     (muarrayListData.value(forKey: "AgendaDocID") as AnyObject).object(at: 0) as? String
  let MOMAttachement =        (muarrayListData.value(forKey: "MOMDocID") as AnyObject).object(at: 0) as?String

      if(self.strWhichType == "Service Projects")
      {
//          self.functionForRightNaviButton()
      }
      else if(self.strWhichType == "Club Service" && (type == "1" || type == "2" || type == "0" || type == "3" || type == "4"))
      {
//          self.functionForRightNaviButton2()
      }
  self.CategoryIdForPassingNectScreen=(muarrayListData.value(forKey: "albumCategoryID") as AnyObject).object(at: 0) as?String
  
   self.AgendaDocUrl=(muarrayListData.value(forKey: "AgendaDoc") as AnyObject).object(at: 0) as?String
   self.MOMDocUrl=(muarrayListData.value(forKey: "MOMDoc") as AnyObject).object(at: 0) as?String
  
  print("this is test url !!!!")
  print(self.AgendaDocUrl)
   print(self.MOMDocUrl)
  
  self.lblHeading.text = albumTitle
  print(muarrayListData)
  print(albumId)
  print(working_hour)
      print(AgendaAttachement)
  print(MOMAttachement)
  
  //  print("sjdhfdshfjkdshf=============",self.strWhichType)
  if(self.GetIsCategoryFromClubOrDistrict == "2"){
      if(self.strWhichType == "Club Service"){
     
        
         if(project_date == "" || project_date == "0"){
             
         }else{
             
             self.tempValue.add(project_date)
             self.tempName.add("Date")
         }
         
         print( self.tempValue)
     }
     else {

         //MARK:- code by rajendra jat 11 dec 2.13pm
         if( self.strWhichType=="District Events")
         {
              self.tempName.add("Date")
              self.tempValue.add(project_date)
         }
         else
         {
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
         }
//         self.functionForRightNaviButton()
     }
     
 //code by rajendra jat on 12 dec 12.52pm start
     print(muarrayListData)
     let Attendancetest=(muarrayListData.value(forKey: "Attendance") as AnyObject).object(at: 0) as? String

     print(Attendancetest)
     let sharetype:String!=(muarrayListData.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
     
     print(sharetype)
     
     if(sharetype=="1")
     {
         
         print("thi sis value:------")
         print(self.tempName)
         print(self.tempValue)

         
         
           self.tempName = NSMutableArray()
          self.tempValue = NSMutableArray()
         
         self.TempArrayName = NSMutableArray()
         
         //TempArrayName
         print("thi sis value2222:------")
         print(self.tempName)
            print(self.tempValue)
        // self.tempName.add("Date")
        // self.tempValue.add(project_date)
         
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
     }
     //----start
     
     if(sharetype=="0")
     {
         
         print("thi sis value:------")
         print(self.tempName)
         print(self.tempValue)
         
         
         
         self.tempName = NSMutableArray()
         self.tempValue = NSMutableArray()
         
         self.TempArrayName = NSMutableArray()
         
         //TempArrayName
         print("thi sis value2222:------")
         print(self.tempName)
         print(self.tempValue)
         // self.tempName.add("Date")
         // self.tempValue.add(project_date)
         
         self.tempName.add("Date")
       
         
         self.tempValue.add(project_date)
       
     }
     //-----end
     
     
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
     //code by rajendra jat on 12 dec 12.52pm start  end
     
     
     
     self.muaaryHoriZontal = self.tempValue
     self.muaaryHoriZontalName = self.tempName
     
     self.muarrayAgendaorMettingName = self.TempArrayName
     
     self.txtView.text = description
     
     self.collectionHori.reloadData()
     self.tblView.reloadData()
 }
 else{
     if(self.strWhichType == "Club Service"){
         
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
         else if(type == "4"){
             self.tempName.add("Meeting Type")
             self.tempValue.add("Trust")
             
         }
         print( self.tempValue)
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
         print( self.tempValue)
         self.muaaryHoriZontal = self.tempValue
         self.muaaryHoriZontalName = self.tempName
        
         self.txtView.text = description
     }
     
     self.collectionHori.reloadData()
     self.tblView.reloadData()
      SVProgressHUD.dismiss()
 }
 self.collectionHori.reloadData()
 self.tblView.reloadData()
  SVProgressHUD.dismiss()
 
 //later code by rajendra jat
 
 let sharetype:String!=(muarrayListData.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
 if(self.GetIsCategoryFromClubOrDistrict == "2")
 {
     if(sharetype=="1")
     {
//         self.title = "District Project"
     }
     else
     {
 //        self.title = "District Event"
     }
 }
 else
 {
     if(sharetype=="1")
     {
 //        self.title = "Service Project"
     }
     else
     {
 //        self.title = "Club Meeting"
     }
 }
}
    else
    {
        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
    }
}
 })
    }
}


