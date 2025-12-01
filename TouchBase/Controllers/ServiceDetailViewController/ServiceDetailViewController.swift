//
//  ServiceDetailViewController.swift
//  TouchBase
//
//  Created by Umesh on 19/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MessageUI
class ServiceDetailViewController: UIViewController ,webServiceDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate , MFMessageComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    
    var varCheckIdSMSEmailCallCalled:Int!=0
    
    var muarrayDescorAddress:NSMutableArray=NSMutableArray()
    
    
    @IBOutlet var textviewDescriptionOrAddress: UITextView!
    
    
    var varForDescriptionOrAddress:String!=""
    
    var directoryList = NSDictionary()
    
    var grpID: NSString!
    var serviceId:NSString!
    @IBOutlet var directoryTableView: UITableView!
    
    var mainArray : NSArray!
    var keymainArray : NSMutableArray!
    var valmainArray : NSMutableArray!
    var dataArray : NSMutableArray!
    var userID : NSString!
    var moduleId : NSString!
    var PhoneNumberSTR  : String = ""
    var EmailSTR  : String =  ""
    @IBOutlet var headerVC :  UIView!
    @IBOutlet  var servcPic : UIImageView!
    @IBOutlet  var nameLbl : UILabel!
    var appDelegate : AppDelegate!
    var  varIsImage:Int = 0
    var varImageUrl:String!=""
    
    
    var varCity:String!=""
    var varState:String!=""
    var varCountry:String!=""
    var varZip:String!=""
    var varWebSite:String?=""
    
    
    @IBOutlet var viewPopUp: UIView!
    
    @IBAction func buttonPopUpCloseClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewPopUp.isHidden=true
    }
    
    @IBOutlet var imagePopUp: UIImageView!
    @IBOutlet var buttonOpacity: UIButton!
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    {
        buttonOpacity.isHidden=true
        viewPopUp.isHidden=true
    }
    @objc func imageTapped(_ gestureRecognizer: UITapGestureRecognizer)
    {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        let tappedImageView = gestureRecognizer.view!
        print("image has been tapped !")
        if(varIsImage==1)
        {
            viewPopUp.isHidden=false
            buttonOpacity.isHidden=false
            
        }
        else
        {
            viewPopUp.isHidden=true
            buttonOpacity.isHidden=true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        varCheckIdSMSEmailCallCalled=0
        // servcPic.layer.cornerRadius = 100
        // servcPic.clipsToBounds = true
        
      //  directoryTableView.separatorStyle = .None
        
        servcPic.layer.borderWidth = 1.0
        servcPic.layer.masksToBounds = false
        servcPic.layer.borderColor = UIColor.white.cgColor
        servcPic.layer.cornerRadius = servcPic.frame.size.width/2
        servcPic.clipsToBounds = true
        
        
//        self.edgesForExtendedLayout = []
        createNavigationBar()
        viewPopUp.isHidden=true
        buttonOpacity.isHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view.
        // tapRecognizer, placed in viewDidLoad
        // let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        //self.view.addGestureRecognizer(longPressRecognizer)
        ////self.view.backgroundColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
        
        
        servcPic.isUserInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServiceDetailViewController.imageTapped(_:)))
        //Add the recognizer to your view.
        servcPic.addGestureRecognizer(tapRecognizer)
        
        
        
        getDetailServiceDirectList()
        
    }
    //Called, when long press occurred
    /*
     func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
     
     if longPressGestureRecognizer.state == UIGestureRecognizer.StateBegan {
     
     let touchPoint = longPressGestureRecognizer.locationInView(self.view)
     if let indexPath = directoryTableView.indexPathForRowAtPoint(touchPoint)
     {
     if(indexPath.row>0)
     {
     print(keymainArray.objectAtIndex(indexPath.row) as! String)
     print(valmainArray.objectAtIndex(indexPath.row) as! String)
     self.view!.makeToast("Copied to clipboard", duration: 2, position: CSToastPositionCenter)
     UIPasteboard.generalPasteboard().string = (valmainArray.objectAtIndex(indexPath.row)) as! String
     }
     }
     }
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        
        //if(varCheckIdSMSEmailCallCalled==0)
        //{
           // keymainArray=NSMutableArray()
           // valmainArray=NSMutableArray()
         //   dataArray=NSMutableArray()
            // mainArray = NSArray()
            //        let wsm : WebserviceClass = WebserviceClass.sharedInstance
            //        wsm.delegates=self
            //  wsm.getDetailServiceDirList(grpID, serviceDirId: serviceId)
       // }
    }
    func getdetServiceDirListDelegate(_ entityInfo : TBServiceDirectoryListResult){
    }
    //if (entityInfo.status == "0")
    // {
    
    func getDetailServiceDirectList()
    {
        // print(mainArray)
        keymainArray=NSMutableArray()
        valmainArray=NSMutableArray()
        dataArray=NSMutableArray()
        print(directoryList)
        
        /*
         {
         address = Address;
         categoryId = 0;
         city = jakar;
         contactNo = "+257-253689";
         contactNo2 = "+91-1425785875";
         country = out;
         countryId1 = 39;
         countryId2 = 1;
         csvKeywords = "";
         description = Description;
         email = "abc@abc.com";
         groupId = 482;
         image = "http://web.touchbase.in/Documents/servicedirectory/Group482/thumb/24042017062219PM.png";
         isdeleted = 0;
         lat = "0.00";
         long = "0.00";
         memberName = Patidar;
         moduleId = 15;
         pax = 2555;
         serviceDirId = 801;
         state = wata;
         website = "";
         zip = 111;
         }
         */
        var varGetValueAddress = directoryList.value(forKey: "address") as! String
        var varGetValuecategoryId = directoryList.value(forKey: "categoryId")  as! String
        var varGetValuecity = directoryList.value(forKey: "city")  as! String
        var varGetValuecontactNo = directoryList.value(forKey: "contactNo")  as! String
        

        var varGetValuecontactNo2 = directoryList.value(forKey: "contactNo2")  as! String
        var varGetValuecountry = directoryList.value(forKey: "country")  as! String
        var varGetValuecountryId1 = directoryList.value(forKey: "countryId1")  as! String
        var varGetValuecountryId2 = directoryList.value(forKey: "countryId2")  as! String
        
        var varGetValuecsvKeywords = directoryList.value(forKey: "csvKeywords")  as! String
        var varGetValuedescription = directoryList.value(forKey: "description")  as! String
        var varGetValueemail = directoryList.value(forKey: "email")  as! String
        var varGetValuegroupId = directoryList.value(forKey: "groupId")  as! String
        
       
        var varGetValueimage = directoryList.value(forKey: "image")  as! String
        var varGetValueisdeleted = directoryList.value(forKey: "isdeleted")  as! String
        var varGetValuememberName = directoryList.value(forKey: "memberName")  as! String
        var varGetValuemoduleId = directoryList.value(forKey: "moduleId")  as! String
        var varGetValuepax = directoryList.value(forKey: "pax")  as! String
        var varGetValueserviceDirId = directoryList.value(forKey: "serviceDirId")  as! String
        var varGetValuestate = directoryList.value(forKey: "state")  as! String
        var varGetValuewebsite = directoryList.value(forKey: "website")  as! String
        var varGetValuezip = directoryList.value(forKey: "zip")  as! String
        var varGetValuelat = directoryList.value(forKey: "lat")  as! String
        var varGetValuelong = directoryList.value(forKey: "long")  as! String
        
       directoryTableView.tableHeaderView = headerVC
        if varGetValuedescription.characters.count != 0
        {
            keymainArray.add("Description")
            valmainArray.add(varGetValuedescription)
            muarrayDescorAddress.add("Description")
        }
        if varGetValuecontactNo.characters.count != 0
        {
            keymainArray.add("Contact No1")
            valmainArray.add(varGetValuecontactNo)
            muarrayDescorAddress.add("Contact No1")
        }
        if varGetValuecontactNo2.characters.count != 0{
            keymainArray.add("Contact No2")
            valmainArray.add(varGetValuecontactNo2)
            muarrayDescorAddress.add("Contact No2")
        }
        if varGetValuepax.characters.count != 0{
            keymainArray.add("Pax No")
            valmainArray.add(varGetValuepax)
            muarrayDescorAddress.add("Pax No")
        }
        if varGetValueemail.characters.count != 0{
            keymainArray.add("Email")
            valmainArray.add(varGetValueemail)
            muarrayDescorAddress.add("Email")
        }
        
        if varGetValueAddress.characters.count != 0{
            keymainArray.add("Address")
            valmainArray.add(varGetValueAddress)
            muarrayDescorAddress.add("Address")
        }
        if varGetValuecsvKeywords.characters.count != 0{
            keymainArray.add("keywords")
            valmainArray.add(varGetValuecsvKeywords)
            muarrayDescorAddress.add("keywords")
            
            print("•••••••••••••••••••••••••")
            print(varGetValuecsvKeywords)
            
        }
        print(varGetValuewebsite)
        
//        if (varGetValuewebsite.characters.count<=0 || varGetValuewebsite=="")
//        {
//            
//            
//        }
//        else
//        {
//            keymainArray.addObject("WebSite")
//            valmainArray.addObject(varGetValuewebsite)
//            muarrayDescorAddress.addObject("WebSite")
//        }
        
        
        /*---------------------------------------Image Upload Code ----------------------------------*/
                    print(varGetValueimage)
                    let letGetUrl:String!=varGetValueimage.removingPercentEncoding
        //myy code
//                    let link =  varGetValueimage.removingPercentEncoding!.addingPercentEscapes(using: String.Encoding.utf8)!

        let link =  varGetValueimage.removingPercentEncoding!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        
      //  let link =  varGetValueimage

        if let checkedUrl = URL(string: link) {
                        if let checkedUrl = URL(string: varGetValueimage) {
        
                            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                                DispatchQueue.main.async { () -> Void in
                                    guard let data = data, error == nil else { return }
                                    print(response?.suggestedFilename ?? "")
                                    print("Download Finished")
                                    self.servcPic.image = UIImage(data: data)
                                    //cell.indicator.stopAnimating()
                                    self.varIsImage=1
                                    self.varImageUrl=varGetValueimage
        
                                    if URL(string:  self.varImageUrl) != nil {
                                        if let checkedUrl = URL(string:  self.varImageUrl) {
        
                                            self.appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                                                DispatchQueue.main.async { () -> Void in
                                                    guard let data = data, error == nil else { return }
                                                    print(response?.suggestedFilename ?? "")
                                                    print("Download Finished")
                                                    self.imagePopUp.image = UIImage(data: data)
                                                    //cell.indicator.stopAnimating()
                                                }
                                            }
                                        }
        
                                    }
                                }
                                if(self.varIsImage==0)
                                {
                                    self.varIsImage=0;
                                    self.servcPic.image = UIImage(named: "profile_pic")!
                                }
                            }
        
                            if(self.varIsImage==0)
                            {
                                self.varIsImage=0;
                                self.servcPic.image = UIImage(named: "profile_pic")!
                            }
        
        
                        }
        
                    }
        
                    else{
        
        
                        self.varIsImage=0;
                        self.servcPic.image = UIImage(named: "profile_pic")!
                    }
                    if varGetValuememberName.characters.count != 0{
                        nameLbl.text! = varGetValuememberName
        
                         nameLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        
                    }
        /*--------------------------------------------------------------------*/
        
        
        
        
        
        
        
        
        
        //mainArray = mainArray as NSArray // entityInfo.ServiceDirListResult as NSArray
      
        
        //  var directoryList = ServiceDirList()
        //            directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        //            print(directoryList)
        //
        //            if directoryList.serviceDescription.characters.count != 0{
        //                keymainArray.addObject("Description")
        //                valmainArray.addObject(directoryList.serviceDescription)
        //                  muarrayDescorAddress.addObject("Description")
        //            }
        //            if directoryList.serviceMobile1.characters.count != 0{
        //                keymainArray.addObject("Contact No1")
        //                valmainArray.addObject(directoryList.serviceMobile1)
        //                  muarrayDescorAddress.addObject("Contact No1")
        //            }
        //            if directoryList.serviceMobile2.characters.count != 0{
        //                keymainArray.addObject("Contact No2")
        //                valmainArray.addObject(directoryList.serviceMobile2)
        //                  muarrayDescorAddress.addObject("Contact No2")
        //            }
        //            if directoryList.servicePaxNo.characters.count != 0{
        //                keymainArray.addObject("Pax No")
        //                valmainArray.addObject(directoryList.servicePaxNo)
        //                  muarrayDescorAddress.addObject("Pax No")
        //            }
        //            if directoryList.serviceEmail.characters.count != 0{
        //                keymainArray.addObject("Email")
        //                valmainArray.addObject(directoryList.serviceEmail)
        //                  muarrayDescorAddress.addObject("Email")
        //            }
        //
        //            if directoryList.serviceAddress.characters.count != 0{
        //                keymainArray.addObject("Address")
        //                valmainArray.addObject(directoryList.serviceAddress)
        //                  muarrayDescorAddress.addObject("Address")
        //            }
        //            if directoryList.serviceKeywords.characters.count != 0{
        //                keymainArray.addObject("keywords")
        //                valmainArray.addObject(directoryList.serviceKeywords)
        //                  muarrayDescorAddress.addObject("keywords")
        //
        //                print("•••••••••••••••••••••••••")
        //                print(directoryList.serviceKeywords)
        //
        //            }
        //            print(varWebSite)
        //            if (varWebSite==nil || varWebSite?.characters.count<=0 || varWebSite=="")
        //            {
        //
        //
        //            }
        //            else
        //            {
        //                keymainArray.addObject("WebSite")
        //                valmainArray.addObject(varWebSite!)
        //                muarrayDescorAddress.addObject("WebSite")
        //            }
        //
        //            //serviceWebSite
        //
        //
        //
        //            print(directoryList.serviceThumbimage)
        //            let letGetUrl:String!=directoryList.serviceThumbimage
        //
        //            let link =  directoryList.serviceThumbimage.stringByRemovingPercentEncoding!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        //
        //            if let checkedUrl = NSURL(string: link) {
        //                if let checkedUrl = NSURL(string: directoryList.serviceThumbimage) {
        //
        //                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
        //                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
        //                            guard let data = data where error == nil else { return }
        //                            print(response?.suggestedFilename ?? "")
        //                            print("Download Finished")
        //                            self.servcPic.image = UIImage(data: data)
        //                            //cell.indicator.stopAnimating()
        //                            self.varIsImage=1
        //                            self.varImageUrl=directoryList.serviceImage
        //
        //                            if NSURL(string:  self.varImageUrl) != nil {
        //                                if let checkedUrl = NSURL(string:  self.varImageUrl) {
        //
        //                                    self.appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
        //                                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
        //                                            guard let data = data where error == nil else { return }
        //                                            print(response?.suggestedFilename ?? "")
        //                                            print("Download Finished")
        //                                            self.imagePopUp.image = UIImage(data: data)
        //                                            //cell.indicator.stopAnimating()
        //                                        }
        //                                    }
        //                                }
        //
        //                            }
        //                        }
        //                        if(self.varIsImage==0)
        //                        {
        //                            self.varIsImage=0;
        //                            self.servcPic.image = UIImage(named: "profile_pic")!
        //                        }
        //                    }
        //
        //                    if(self.varIsImage==0)
        //                    {
        //                        self.varIsImage=0;
        //                        self.servcPic.image = UIImage(named: "profile_pic")!
        //                    }
        //
        //
        //                }
        //
        //            }
        //
        //            else{
        //
        //
        //                self.varIsImage=0;
        //                self.servcPic.image = UIImage(named: "profile_pic")!
        //            }
        //            if directoryList.serviceMemberName.characters.count != 0{
        //                nameLbl.text! = directoryList.serviceMemberName
        //
        //                 nameLbl.font = UIFont.boldSystemFontOfSize(20.0)
        //
        //
        //            }
        //servcPic.image =
        createCell()
        print(servcPic.frame)
        directoryTableView.rowHeight = UITableView.automaticDimension
        directoryTableView.estimatedRowHeight = 140
        directoryTableView.reloadData()
        
        servcPic.layer.cornerRadius = servcPic.frame.size.height / 2
        //servcPic.layer.masksToBounds = true
    }
    //     else
    //        {
    //            self.servcPic.image  = UIImage(named:"galleryplaceholder")
    //            //self.servcPic.layer.cornerRadius = 35
    //            //self.servcPic.clipsToBounds = true
    //            mainArray = NSArray()
    //            directoryTableView.reloadData()
    //
    //        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Choose your custom row height
        
        
        
        
        var varGetCountVar:String!=valmainArray.object(at: indexPath.row) as! String
        
        
        //var varGetCountVar:String!=" hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf  hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf hsa as as;f saf asfh  sdf sdfhsf"
        
        
        let varGetCount:Int!=varGetCountVar.characters.count
        
        //ahg g hg Hagaga DAhdg D Ghadg hDG alDD
        
        
        let varGetValue:String!=muarrayDescorAddress.object(at: indexPath.row) as! String
        print(varGetValue)
        
        print(varGetCount)
        if(varGetValue=="Description")
        {
            
            if(varGetCount<=40)
            {
                return 50.0;
            }
            
            else
            {
                let screenSize: CGRect = UIScreen.main.bounds
                let screenWidth = (screenSize.width)
                
                
                
            var varGetCountCalcu:Int!=0
            varGetCountCalcu=varGetCount%40
            print(varGetCountCalcu)
                var varGetCountCalcuNew:Int!=0
                varGetCountCalcuNew=varGetCount/40
                print(varGetCountCalcuNew)
                if(varGetCountCalcu==0)
                {
                     return CGFloat(varGetCountCalcuNew*40);
                }
                else
                {
                    if(screenWidth==320)
                    {
                  return CGFloat((varGetCountCalcuNew*40)+70);
                    }
                    else
                    {
                        let result:CGFloat = CGFloat((varGetCountCalcuNew * 40)+40)
                        return CGFloat(result-300);
                    }
                }
            }
//            print("hello this is coun t ‘‘‘‘‘‘‘‘‘‘‘‘‘‘‘‘‘‘‘",varGetCount)
//            if(varGetCount<=40)
//            {
//                return 40.0;
//            }
//            else  if(varGetCount>=40 && varGetCount<=80)
//            {
//                return 45.0;
//            }
//            else  if(varGetCount>=80 && varGetCount<=100)
//            {
//                return 60.0;
//            }
//            else  if(varGetCount>=100 && varGetCount<=140)
//            {
//                return 70.0;
//            }
//            else  if(varGetCount>=140 && varGetCount<=180)
//            {
//                return 80.0;
//            }
//            else  if(varGetCount>=180 && varGetCount<=220)
//            {
//                return 100.0;
//            }
//            else  if(varGetCount>=220 && varGetCount<=260)
//            {
//                return 120.0;
//            }
//            else  if(varGetCount>=260 && varGetCount<=300)
//            {
//                return 140.0;
//            }
//            else  if(varGetCount>=300 && varGetCount<=340)
//            {
//                return 160.0;
//            }
//            else  if(varGetCount>=340 && varGetCount<=380)
//            {
//                return 180.0;
//            }
//            else  if(varGetCount>=380 && varGetCount<=410)
//            {
//                return 200.0;
//            }
//            else  if(varGetCount>=410 && varGetCount<=510)
//            {
//                return 250.0;
//            }
//            else  if(varGetCount>=510 && varGetCount<=610)
//            {
//                return 300.0;
//            }
//            else  if(varGetCount>=610 && varGetCount<=710)
//            {
//                return 350.0;
//            }
//            else  if(varGetCount>=710 && varGetCount<=810)
//            {
//                return 400.0;
//            }
//            else  if(varGetCount>=810 && varGetCount<=910)
//            {
//                return 450.0;
//            }
//            else  if(varGetCount>=910 && varGetCount<=1010)
//            {
//                return 500.0;
//            }
//            else  if(varGetCount>=1010 && varGetCount<=1110)
//            {
//                return 550.0;
//            }
//            else  if(varGetCount>=1110 && varGetCount<=1210)
//            {
//                return 600.0;
//            }
//            else  if(varGetCount>=1210 && varGetCount<=1310)
//            {
//                return 650.0;
//            }
//            else  if(varGetCount>=1310 && varGetCount<=1410)
//            {
//                return 700.0;
//            }
//            else  if(varGetCount>=1410 && varGetCount<=1510)
//            {
//                return 750.0;
//            }
//            else  if(varGetCount>=1510 && varGetCount<=1610)
//            {
//                return 800.0;
//            }
//            else  if(varGetCount>=1610 && varGetCount<=1710)
//            {
//                return 1100.0;
//            }
//            else  if(varGetCount>=1710 && varGetCount<=1810)
//            {
//                return 1200.0;
//            }
//            else  if(varGetCount>=1810 && varGetCount<=1910)
//            {
//                return 1900.0;
//            }
//            else  if(varGetCount>=1910 && varGetCount<=2110)
//            {
//                return 1400.0;
//            }
            
            
            //            else  if(varGetCount>=410 && varGetCount<=450)
            //            {
            //                return 430.0;
            //            }
            //            else  if(varGetCount>=450 && varGetCount<=490)
            //            {
            //                return 460.0;
            //            }
            //            else  if(varGetCount>=490 && varGetCount<=520)
            //            {
            //                return 470.0;
            //            }
            //            else  if(varGetCount>=520 && varGetCount<=560)
            //            {
            //                return 500.0;
            //            }
            //            else  if(varGetCount>=560 )
            //            {
            //                return 600.0;
            //            }
        }
        if(varGetValue=="Address")
        {
            
            print(varGetCount)
            
            if(varGetCount<=40)
            {
                return 90.0;
            }
            else  if(varGetCount>=40 && varGetCount<=80)
            {
                return 100.0;
            }
            else  if(varGetCount>=80 && varGetCount<=100)
            {
                return 180.0;
            }
            else  if(varGetCount>=100 && varGetCount<=120)
            {
                return 200.0;
            }
            else  if(varGetCount>=120 && varGetCount<=140)
            {
                return 220.0;
            }
            else  if(varGetCount>=140 && varGetCount<=160)
            {
                return 240.0;
            }
            else  if(varGetCount>=160 && varGetCount<=180)
            {
                return 260.0;
            }
            else  if(varGetCount>=180 && varGetCount<=200)
            {
                return 280.0;
            }
        }
        print(varGetValue)
        return 70.0;
    }
    func createNavigationBar(){
        self.title="Details"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ServiceDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        editB.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(ServiceDetailViewController.editEbullAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        
        let trashB = UIButton(type: UIButton.ButtonType.custom)
        trashB.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        trashB.setImage(UIImage(named:"Delete_blue"),  for: UIControl.State.normal)
        trashB.addTarget(self, action: #selector(ServiceDetailViewController.deleteEbullAction), for: UIControl.Event.touchUpInside)
        let trash: UIBarButtonItem = UIBarButtonItem(customView: trashB)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        if mainMemberID == "Yes"
        {
            let buttons : NSArray = [trash, edit]
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
        
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func editEbullAction()
    {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "addservice") as! ServiceAddEditViewController
            profVC.grpId =  grpID as String as String as NSString
            profVC.userId = userID as String as String as NSString
            profVC.isCalledFRom = "edit"
            profVC.serviceId = serviceId
            profVC.moduleIdPassString = moduleId
            
            /*
             profVC.varCity=varCity
             profVC.varState=varState
             profVC.varCountry=varCountry
             profVC.varZip=varZip
             */
            
            
            print(UserDefaults.standard.value(forKey: "session_City") as! String)
            print(UserDefaults.standard.value(forKey: "session_State") as! String)
            print(UserDefaults.standard.value(forKey: "session_Country") as! String)
            print(UserDefaults.standard.value(forKey: "session_Zip") as! String)
            
            profVC.varCity=UserDefaults.standard.value(forKey: "session_City") as! String
            profVC.varState=UserDefaults.standard.value(forKey: "session_State")as! String
            profVC.varCountry=UserDefaults.standard.value(forKey: "session_Country")as! String
            profVC.varZip=UserDefaults.standard.value(forKey: "session_Zip")as! String
            varCheckIdSMSEmailCallCalled=0
            
            self.navigationController?.pushViewController(profVC, animated: true)
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       SVProgressHUD.dismiss()
        }
        
    }
    @objc func deleteEbullAction()
    {
        /*--------------------------------DPk---------------------------------------------------*/
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            let alert=UIAlertController(title: "Confirm", message:"Are you sure, you want to delete?", preferredStyle: UIAlertController.Style.alert);
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil));
            //event handler with closure
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.deleteDataWebservice(self.serviceId as String, type: "ServiceDirectory", profileID:  self.userID as String)
            }));
            self.present(alert, animated: true, completion: nil);
            
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        SVProgressHUD.dismiss()
        }
        
        /*--------------------------------DPk---------------------------------------------------*/
        
        
    }
    func deleteSucc(_ docListing : DeleteResult)
    {
        
        if docListing.status == "0"
        {
            self.navigationController?.popViewController(animated: true)
            
        }
        else
        {
            /*
             let alert = UIAlertController(title: "Rotary India", message: "Could not DELETE, please Try Again!", preferredStyle: UIAlertController.Style.Alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: nil))
             self.presentViewController(alert, animated: true, completion: nil)
             */
            
            self.view.makeToast("Could not DELETE, please Try Again!", duration: 2, position: CSToastPositionCenter)
            
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return keymainArray.count
    }
     @objc func longTap(_ sender : UIGestureRecognizer)
    {
        print("Long tap")
        if sender.state == .ended
        {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began
        {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            let touchPoint = sender.location(in: self.directoryTableView)
            if let indexPath = directoryTableView.indexPathForRow(at: touchPoint)
            {
                if(indexPath.row>0)
                {
                    print(keymainArray.object(at: indexPath.row) as! String)
                    print(valmainArray.object(at: indexPath.row) as! String)
                    self.view!.makeToast("Copied to clipboard", duration: 2, position: CSToastPositionCenter)
                    UIPasteboard.general.string = (valmainArray.object(at: indexPath.row)) as! String
                }
            }
            
        }
        
        
        
        
        
        
        //let position = sender.locationInView(sender.view)
        
        //        if let indexPath : NSIndexPath = ((sender.view as! UICollectionView).indexPathForItemAtPoint(position))!{
        //            print("You holding cell #\(indexPath.item)!")
        //        }
        
        
        
        
    }
    func createCell(){
        
        print(keymainArray)
        
        
        for index in 0..<keymainArray.count {
            
            
            let cell = directoryTableView.dequeueReusableCell(withIdentifier: "dirserCell") as! SErviceDetCell
            
            
            cell.keyLabel.text   =  keymainArray.object(at: index) as! String //nameTitles[indexPath.row]
            cell.valLabel.text =  valmainArray.object(at: index) as! String
            cell.keyLabel.font = UIFont(name: "Roboto-Regular", size: 17)
            cell.valLabel.font = UIFont(name: "Roboto-Regular", size: 17)
            cell.valLabel.textColor=UIColor.blue
            //cell.valLabel.font = UIFont(name: cell.valLabel.font.fontName, size: 17)
            
            
            
           // let attributes = [NSFontAttributeName : UIFont(name: "Roboto-Regular", size: 17)!, NSForegroundColorAttributeName : UIColor.blackColor()]

            cell.textviewDescriptionOrAddress.isHidden=true
            varForDescriptionOrAddress=""
            
            // let tapGesture = UITapGestureRecognizer(target: self, action: "normalTap")
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ServiceDetailViewController.longTap(_:)))
            // tapGlongGestureesture.numberOfTapsRequired = 1
            cell.buttonLongPress.addGestureRecognizer(longGesture)
            
            
            /*-------------------*/
            if(keymainArray.object(at: index) as! String=="Description")
            {
                cell.keyLabel.text = ""
                cell.valLabel.textColor=UIColor.black
                cell.textviewDescriptionOrAddress.frame.origin = CGPoint(x: 8, y: 0)
                
                
                // cell.keyLabel.frame.origin = CGPoint(x: 8, y: 18)
                
                //cell.valLabel.font = UIFont.systemFontSize()
                // cell.valLabel.font = UIFont.systemFontSize(20.0)
                
                // cell.keyLabel.font = UIFont(name: cell.valLabel.font.fontName, size: 17)
                
                cell.textviewDescriptionOrAddress.text=valmainArray.object(at: index) as! String
                
                
                //----
                //cell.textviewDescriptionOrAddress.font = UIFont(name: cell.textviewDescriptionOrAddress.font!.fontName, size: 16)
/*1.
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 20
                let attributes = [NSParagraphStyleAttributeName : style]
                cell.textviewDescriptionOrAddress.attributedText = NSAttributedString(string: valmainArray.objectAtIndex(index) as! String, attributes:attributes)
                */
                let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineHeightMultiple = 30.0
                paragraphStyle.maximumLineHeight = 30.0
                paragraphStyle.minimumLineHeight = 30.0
                let ats = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 19.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
                cell.textviewDescriptionOrAddress.attributedText = NSAttributedString(string: valmainArray.object(at: index) as! String, attributes: ats)
                //-----30April2017TB-AF-DEEPAK

                cell.valLabel.text=""
                cell.textviewDescriptionOrAddress.isHidden=false
                varForDescriptionOrAddress="Description"
                let fixedWidth =  cell.textviewDescriptionOrAddress.frame.size.width
                cell.textviewDescriptionOrAddress.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize =  cell.textviewDescriptionOrAddress.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame =  cell.textviewDescriptionOrAddress.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewDescriptionOrAddress.frame = newFrame;
                cell.textviewDescriptionOrAddress.textAlignment = .justified
            }
            if(keymainArray.object(at: index) as! String=="keywords")
            {
                // cell.keyLabel.text = ""
                // cell.valLabel.frame.origin = CGPoint(x: 8, y: 10)
                cell.valLabel.textColor=UIColor.black
                cell.keyLabel.text=""
            }
            
            if(keymainArray.object(at: index) as! String=="Address")
            {
                //                cell.valLabel.textColor=UIColor.blackColor()
                //                cell.valLabel.text=""
                //
                //                cell.textviewDescriptionOrAddress.hidden=false
                //                varForDescriptionOrAddress="Address"
                //
                //                cell.textviewDescriptionOrAddress.frame.origin = CGPoint(x: 8, y: 20)
                //cell.textviewDescriptionOrAddress.textColor=UIColor.lightGrayColor()
                //               // cell.valLabel.frame.origin = CGPoint(x: 8, y: 18)
                // cell.keyLabel.text = ""
                cell.valLabel.textColor=UIColor.black
                cell.textviewDescriptionOrAddress.frame.origin = CGPoint(x: 8, y: 25)
                cell.textviewDescriptionOrAddress.textAlignment = .left
                
                // cell.keyLabel.frame.origin = CGPoint(x: 8, y: 18)
                
                //cell.valLabel.font = UIFont.systemFontSize()
                // cell.valLabel.font = UIFont.systemFontSize(20.0)
                
                /*---code by Rajendra Jat need to add address or contact----------*/
                let varCity=UserDefaults.standard.value(forKey: "session_City") as! String
                let varState=UserDefaults.standard.value(forKey: "session_State") as! String
                let varCountry=UserDefaults.standard.value(forKey: "session_Country") as! String
                let varZip=UserDefaults.standard.value(forKey: "session_Zip") as! String
                
                
                let varGetFullAddress=varCity+" "+varState+" "+varCountry+" "+varZip
                
                //  cell.keyLabel.font = UIFont(name: cell.valLabel.font.fontName, size: 17)
                
                cell.textviewDescriptionOrAddress.text=valmainArray.object(at: index) as! String+" "+varGetFullAddress
                
                
                
                print("This is address:-----------")
                print(varCity)
                print(varState)
                print(varCountry)
                print(varZip)
                
                cell.valLabel.text=""
                cell.textviewDescriptionOrAddress.isHidden=false
                varForDescriptionOrAddress="Address"
                let fixedWidth =  cell.textviewDescriptionOrAddress.frame.size.width
                cell.textviewDescriptionOrAddress.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize =  cell.textviewDescriptionOrAddress.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame =  cell.textviewDescriptionOrAddress.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewDescriptionOrAddress.frame = newFrame;
            }
            if(keymainArray.object(at: index) as! String=="Pax No")
            {
                cell.valLabel.textColor=UIColor.black
                
                // cell.valLabel.frame.origin = CGPoint(x: 8, y: 18)
            }
            
            
            
            //cell.valLabel.frame.origin = CGPoint(x: 8, y: 18)
            /*--------------------*/
            
            //cell.keyLabel.frame.origin = CGPoint(x: 8, y: 18)
            
            
            
            //        if(index==0)
            //        {
            //            cell.backgroundColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
            //        }
            if(keymainArray.object(at: index) as! String == "Contact No1")
            {
                
                cell.valLabel.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.fun1btn.isHidden = false
                cell.fun2btn.isHidden = false
                cell.fun1btn.setImage(UIImage(named:"call_blue"),  for: UIControl.State.normal)
                cell.fun2btn.setImage(UIImage(named:"message_blue"),  for: UIControl.State.normal)
                cell.fun1btn.addTarget(self, action:#selector(ServiceDetailViewController.callClk(_:)), for: .touchUpInside)
                cell.fun2btn.addTarget(self, action:#selector(ServiceDetailViewController.messageClk(_:)), for: .touchUpInside)
                cell.fun2btn.tag=300
            }
            else if(keymainArray.object(at: index) as! String == "Contact No2")
                
            {
                cell.valLabel.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
                cell.fun1btn.isHidden = false
                cell.fun2btn.isHidden = false
                cell.fun1btn.setImage(UIImage(named:"call_blue"),  for: UIControl.State.normal)
                cell.fun2btn.setImage(UIImage(named:"message_blue"),  for: UIControl.State.normal)
                // cell.fun1btn.addTarget(self, action:#selector(ServiceDetailViewController.callClk), forControlEvents: .TouchUpInside)
                // cell.fun2btn.addTarget(self, action:#selector(ServiceDetailViewController.messageClk), forControlEvents: .TouchUpInside)
                
                cell.fun1btn.addTarget(self, action:#selector(ServiceDetailViewController.callClk2(_:)), for: .touchUpInside)
                cell.fun2btn.addTarget(self, action: #selector(ServiceDetailViewController.messageClk2(_:)), for: UIControl.Event.touchUpInside)
                
                
                cell.fun2btn.tag=400
            }
            else if(keymainArray.object(at: index) as! String == "Email")
            {
                cell.valLabel.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)

                cell.fun1btn.isHidden = true
                cell.fun2btn.isHidden = false
                //  muarrayDescorAddress.addObject("")
                cell.fun2btn.setImage(UIImage(named:"mail_blue"),  for: UIControl.State.normal)
                
                // cell.fun2btn.addTarget(self, action:#selector(ServiceDetailViewController.emailClk), forControlEvents: .TouchUpInside)
                
                cell.fun2btn.addTarget(self, action: #selector(ServiceDetailViewController.emailClk(_:)), for: UIControl.Event.touchUpInside)
                
                
                cell.fun2btn.tag=500
                // cell.valLabel.frame.origin = CGPoint(x: 8, y: 27)
                
                
            }
            else if(keymainArray.object(at: index) as! String == "Address")
            {
                cell.fun1btn.isHidden = true
                cell.fun2btn.isHidden = true
                cell.fun2btn.setImage(UIImage(named:"lcationmap"),  for: UIControl.State.normal)
                // cell.fun2btn.addTarget(self, action:#selector(ServiceDetailViewController.mapClk), forControlEvents: .TouchUpInside)
            }
                
            else if(keymainArray.object(at: index) as! String == "WebSite")
            {
                cell.fun1btn.isHidden = true
                cell.fun2btn.isHidden = false
                //  muarrayDescorAddress.addObject("")
                cell.fun2btn.setImage(UIImage(named:"link"),  for: UIControl.State.normal)
                
                // cell.fun2btn.addTarget(self, action:#selector(ServiceDetailViewController.emailClk), forControlEvents: .TouchUpInside)
                
                cell.fun2btn.addTarget(self, action: #selector(ServiceDetailViewController.emailClk(_:)), for: UIControl.Event.touchUpInside)
                
                
                cell.fun2btn.tag=550
                // cell.valLabel.frame.origin = CGPoint(x: 8, y: 27)
                
                
            }
                
            else
                
            {
                cell.fun2btn.isHidden = true
                cell.fun1btn.isHidden = true
            }
            dataArray.add(cell)
            
            //textviewDescriptionOrAddress
            print("variable name is:---->")
            print(varForDescriptionOrAddress)
        }
    }
    
    
    @IBAction func emailClk(_ sender: UIButton)
    {
        
        if(sender.tag==400)
        {
            print("SMS sent")
            
            varCheckIdSMSEmailCallCalled=1
            
            //var directoryList = ServiceDirList()
           // directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
            let varGetValuecontactNo2 = directoryList.value(forKey: "contactNo2")  as! String //--------Changes by DPK
            PhoneNumberSTR = varGetValuecontactNo2
            let messageVC = MFMessageComposeViewController()
            messageVC.body = ""
            messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            present(messageVC, animated: true, completion: nil)
        }
        else if(sender.tag==300)
        {
            print("SMS sent")
            
            varCheckIdSMSEmailCallCalled=1
            let varGetValuecontactNo = directoryList.value(forKey: "contactNo")  as! String //--------Changes by DPK
           // var directoryList = ServiceDirList()
           // directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
            PhoneNumberSTR = varGetValuecontactNo
            let messageVC = MFMessageComposeViewController()
            messageVC.body = ""
            messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            present(messageVC, animated: true, completion: nil)
        }
        else   if(sender.tag==500)
        {
            print("Email Sent")
            varCheckIdSMSEmailCallCalled=1
            //var directoryList = ServiceDirList()
           // directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
            let varGetValueemail = directoryList.value(forKey: "email")  as! String //--------Changes by DPK
            EmailSTR = varGetValueemail
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([EmailSTR])      // gg@hing.co.in
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
            }
            
        }
        else  if(sender.tag==550)
        {
            print(varWebSite)
            let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
            objWebSiteOpenUrlViewController.varOpenUrl=varWebSite
            self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
            
        }
        
    }
    
    @IBAction func messageClk(_ sender: UIButton){
        print("SMS sent")
        varCheckIdSMSEmailCallCalled=1
        
       // var directoryList = ServiceDirList()
        //directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        let varGetValuecontactNo = directoryList.value(forKey: "contactNo")  as! String //--------Changes by DPK
        
        PhoneNumberSTR = varGetValuecontactNo
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    
    @IBAction func messageClk2(_ sender: UIButton){
        //var directoryList = ServiceDirList()
        //directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        let varGetValuecontactNo2 = directoryList.value(forKey: "contactNo2")  as! String //--------Changes by DPK
        PhoneNumberSTR = varGetValuecontactNo2
        let messageVC = MFMessageComposeViewController()
        messageVC.body = ""
        messageVC.recipients = [PhoneNumberSTR] // Optionally add some tel numbers
        messageVC.messageComposeDelegate = self
        // Open the SMS View controller
        present(messageVC, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func callClk(_ sender: UIButton){
        
        varCheckIdSMSEmailCallCalled=1
        //
        let varGetValuecontactNo = directoryList.value(forKey: "contactNo")  as! String  //--------Changes by DPK
        
        
        //var directoryList = ServiceDirList()
        //directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        PhoneNumberSTR = varGetValuecontactNo
        PhoneNumberSTR = PhoneNumberSTR.replacingOccurrences(of: " ", with: "")
        print("calling\(PhoneNumberSTR)")
        
        let varGetValuecontactNo2 = directoryList.value(forKey: "contactNo2")  as! String   //--------Changes by DPK
        //var directoryList = ServiceDirList()
        //directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        PhoneNumberSTR = varGetValuecontactNo2
        PhoneNumberSTR = PhoneNumberSTR.replacingOccurrences(of: " ", with: "")
        print("calling\(PhoneNumberSTR)")
        
//        let url = URL(string: "tel://\(PhoneNumberSTR)")
//        UIApplication.shared.openURL(url!)
        
        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        /*
        if PhoneNumberSTR.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
            alertView.delegate = self
            alertView.tag = 1
            alertView.addButtonWithTitle("No")
            alertView.addButtonWithTitle("Yes")
            alertView.show()
            
        }
        */
    }
    
    
    @IBAction func callClk2(_ sender: UIButton){
        
        let varGetValuecontactNo2 = directoryList.value(forKey: "contactNo2")  as! String   //--------Changes by DPK
        //var directoryList = ServiceDirList()
        //directoryList = mainArray.objectAtIndex(0) as! ServiceDirList
        PhoneNumberSTR = varGetValuecontactNo2
        PhoneNumberSTR = PhoneNumberSTR.replacingOccurrences(of: " ", with: "")
        print("calling\(PhoneNumberSTR)")
        
//        let url = URL(string: "tel://\(PhoneNumberSTR)")
//        UIApplication.shared.openURL(url!)
        
        if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }
        
        /*
        if PhoneNumberSTR.characters.count > 1
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
            alertView.delegate = self
            alertView.tag = 1
            alertView.addButtonWithTitle("No")
            alertView.addButtonWithTitle("Yes")
            alertView.show()
            
        }
        */
    }
    
    
    
    
    
    
    
    
    
    
    func alertView(_ View: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(View.tag == 1)
        {
            switch buttonIndex{
                
            case 1:
                
//                let url = URL(string: "tel://\(PhoneNumberSTR)")
//                UIApplication.shared.openURL(url!)
                if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Unable to make a call. Invalid phone number or URL.")
                }
                
                break;
            case 0:
                
                //mobileNumberField.becomeFirstResponder()
                
                break;
            default:
                NSLog("Default");
                break;
                
            }
        }
        else
        {
            
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        /*
         switch result.rawValue {
         case MessageComposeResultCancelled.rawValue :
         print("message canceled")
         
         case MessageComposeResultFailed.rawValue :
         print("message failed")
         
         case MessageComposeResultSent.rawValue :0
         print("message sent")
         
         default:
         break
         }
         */
        controller.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
      
        return dataArray.object(at: indexPath.row) as! UITableViewCell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
