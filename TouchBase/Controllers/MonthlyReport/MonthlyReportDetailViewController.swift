
//
//  MonthlyReportDetailViewController.swift
//  TouchBase
//
//  Created by rajendra on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import AVFoundation
import Photos
import Alamofire
import SVProgressHUD
class MonthlyReportDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,webServiceDelegate,URLSessionDownloadDelegate,DBRestClientDelegate,URLSessionDelegate,UITableViewDelegate,UITableViewDataSource
{
    
  //----
    var typeBysmsorMail:String!=""
    func functionForSendingMailandSMS()
    {
      
    let completeURL = baseUrl+"ClubMonthlyReport/SendSMSAndMailToNonSubmitedReports"
    var parameterst = ["":""]
    parameterst =  ["groupId": grpIDMonthReport,
                    "month": monthYear,
                    "Type": typeBysmsorMail,
                    
    ]
    
    print(parameterst)
    print(completeURL)
    ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
    if((((dd.value(forKey: "TBClubMonthlyReportListResult")as! AnyObject).value(forKey: "message")as! AnyObject) as! String)=="failed")
    {
    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
    SVProgressHUD.dismiss()
    }
    else
    {
     SVProgressHUD.dismiss()
        if self.typeBysmsorMail == "1" {
            self.view.makeToast("Whatsapp send successfully")
        }
        
        if self.typeBysmsorMail == "2" {
            self.view.makeToast("EMail send successfully")
        }
    }
     SVProgressHUD.dismiss()
    
    }
    })
}
    //-----
    
    
    
    @objc func buttonMessageClickEvent()
    {
        print("buttonMessageClickEvent")
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Do you want to sent Whatsapp to club President & Secretary?", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "No", style: .cancel) { _ in
            print("NO")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Yes", style: .default)
        { _ in
            print("Yes")
            self.typeBysmsorMail="1"
            self.functionForSendingMailandSMS()
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    @objc func buttonMailClickEvent()
    {
        print("buttonMailClickEvent")
        
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Do you want to sent Mail to club President & Secretary?", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "No", style: .cancel) { _ in
            print("NO")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Yes", style: .default)
        { _ in
            print("Yes")
             self.typeBysmsorMail="2"
            self.functionForSendingMailandSMS()
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
        
    }
    /*-------set button on Navigation right Bar start--------*/
    func createNavigationBarRight()
    {
//        let buttonDownload = UIButton(type: UIButton.ButtonType.custom)
//        buttonDownload.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        buttonDownload.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
//        buttonDownload.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
//        let downloadbutton: UIBarButtonItem = UIBarButtonItem(customView: buttonDownload)
        
        
        let buttonMSG = UIButton(type: UIButton.ButtonType.custom)
        buttonMSG.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        buttonMSG.setImage(UIImage(named:"whatsWithoutBorder"),  for: UIControl.State.normal)
        buttonMSG.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonMessageClickEvent), for: UIControl.Event.touchUpInside)
        let msgbutton: UIBarButtonItem = UIBarButtonItem(customView: buttonMSG)
        
//        Image("whatsWithoutBorder")
//        Image("whats")
        let buttonMail = UIButton(type: UIButton.ButtonType.custom)
        buttonMail.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        buttonMail.setBackgroundImage(UIImage(named:"mail_blue_monthlyreport"),  for: UIControl.State.normal)
        buttonMail.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonMailClickEvent), for: UIControl.Event.touchUpInside)
        let Mailbutton: UIBarButtonItem = UIBarButtonItem(customView: buttonMail)
        
        
        
        
//        let buttons : NSArray = [downloadbutton,msgbutton,Mailbutton]
        let buttons : NSArray = [msgbutton,Mailbutton]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
    }
    /*-------set button on Navigation right Bar end--------*/

    
    
    
    @IBOutlet weak var pickerZoneList: UIPickerView!
    @IBOutlet weak var textfieldZone: UITextField!
    @IBAction func buttonZoneClikcEvent(_ sender: Any)
    {
        print("clikced 11111")
        pickerZoneList.reloadAllComponents()
        pickerZoneList.isHidden=false
        pickerViewMain.isHidden=true
        buttonHide.isHidden=false

        
         print(self.muarrayZoneList)
    }
    
    
    
    @IBOutlet weak var tableviewMonthlyReportDetail: UITableView!
    var appDelegate : AppDelegate!
    let loaderClass  = WebserviceClass()
    var varSender:String!=""
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: Foundation.URLSession!
    var docListing = DocumentList()
    var docTypeToDownload : String = ""
    var grpPRofileID : NSString!
    var mainArray = NSArray()
    
    
    
    
    var muarrayListOfDownloadedPdfList:NSMutableArray=NSMutableArray()
    var prototypeCells:MonthlyReportDetailTableViewCell=MonthlyReportDetailTableViewCell()
    let reuseIdentifier = "cell"
    // var muarrayListData:NSMutableArray=NSMutableArray()
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var textfieldSubmitFilter: UITextField!
    @IBOutlet var pickerViewMain:UIPickerView!
    var pickerDataSource = [ "Submitted", "Not Submitted"];
    
    var grpIDMonthReport: String!=""
    var varModuleIdMonthReport:String!=""
    var moduleNameMonthReport:String!=""
    var isAdminMonthReport:String! = ""
    var monthYear:String! = ""
    var varGetMonthProfileID:String!=""
    @IBOutlet weak var lblNoresult: UILabel!
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    var muarrayZoneList:NSMutableArray=NSMutableArray()
    var arrayZoneList:NSArray=NSArray()
    
    func functionForFetchingZoneList()
    {
        let completeURL = baseUrl+"Group/getZonelist"
        var parameterst = ["":""]
        parameterst =  ["grpId": grpIDMonthReport
        ]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
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
                if((((dd.value(forKey: "zonelistResult")as! AnyObject).value(forKey: "message")as! AnyObject) as! String)=="failed")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                    self.arrayZoneList=((dd.value(forKey: "zonelistResult")as! AnyObject).value(forKey: "list")as! AnyObject) as! NSArray
                    self.muarrayZoneList=NSMutableArray()
                    var zoneDict:NSDictionary=NSDictionary()
                    zoneDict=["PK_zoneID":"0","zoneName":"All"]
                    self.muarrayZoneList.add(zoneDict)
                    for i in 00..<self.arrayZoneList.count
                    {
                        zoneDict=NSDictionary()
                        var PK_zoneID:String!=(self.arrayZoneList.object(at: i) as! AnyObject).value(forKey: "PK_zoneID")as! String
                        var zoneName:String!=(self.arrayZoneList.object(at: i) as! AnyObject).value(forKey: "zoneName")as! String
                        
                        zoneDict=["PK_zoneID":PK_zoneID,"zoneName":zoneName]
                        self.muarrayZoneList.add(zoneDict)
                        
                        print(self.muarrayZoneList)
                    }
                    print(self.muarrayZoneList)
                }
                
            }
        })
    }
    
    @IBOutlet weak var buttonHide: UIButton!
    @IBAction func buttonHidePickerClickEvent(_ sender: Any)
    {
      pickerViewMain.isHidden=true
        pickerZoneList.isHidden=true
        buttonHide.isHidden=true


    }
    override func viewWillAppear(_ animated: Bool) {
        
        pickerViewMain.isHidden=true
        pickerZoneList.isHidden=true
        buttonHide.isHidden=true
        textfieldSubmitFilter.rightViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image2 = UIImage(named: "downArrowCalendar")
        imageView2.image = image2
        textfieldSubmitFilter.rightView = imageView2
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        buttonHide.backgroundColor = .clear
        buttonHide.layer.cornerRadius = 5
        buttonHide.layer.borderWidth = 1
        buttonHide.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        buttonHide.isHidden=true
        
        buttonHide.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0), for: .normal)
       buttonHide.backgroundColor=UIColor.white
        textfieldSubmitFilter.isUserInteractionEnabled = false
        
        //
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: "donePicker")
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "donePicker")
//
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//    textfieldSubmitFilter.inputView = pickerViewMain
//        textfieldSubmitFilter.inputAccessoryView = toolBar
        ///
        
        
        
        zoneId="0"
        textfieldZone.text="All"
        pickerZoneList.isHidden=true
       
        textfieldZone.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "downArrowCalendar")
        imageView.image = image
        textfieldZone.rightView = imageView
        
        
        
     
        
        
        
        
        createNavigationBar()
        // let _ = DownloadManager.shared.activate()
        self.lblNoresult.text=""
        self.lblNoresult.isHidden=true
        
        print(grpIDMonthReport)
        print(varModuleIdMonthReport)
        print(moduleNameMonthReport)
        print(isAdminMonthReport)
        print(monthYear)
//        self.edgesForExtendedLayout=[]
        textfieldSubmitFilter.textFieldFullBorder()
        //
        IsSubmit=true
        textfieldSubmitFilter.text="Submitted"
        //
        self.pickerViewMain.dataSource = self;
        self.pickerViewMain.delegate = self;
        
        monthYear =  dateConverter(monthYear)
        
        textfieldSearch.addTarget(self, action: #selector(MonthlyReportDetailViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        functionForFetchingMonthlyReportDetailListData(textfieldSubmitFilter.text!)
        functionForFetchingZoneList()
    }
    
    
    
    func dateConverter(_ dateString:String) -> String
    {//2018-06-15 14:30:00
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MMMM yyyy"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "MM-yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        
        return dateString
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
        textfieldSearch.resignFirstResponder()
        pickerViewMain.isHidden=true
        pickerZoneList.isHidden=true
         buttonHide.isHidden=true
      
    }
    var IsSubmit:Bool=true
    @IBAction func buttonSubmitNotSubmitClickEvent(_ sender: AnyObject)
    {
         pickerViewMain.reloadAllComponents()
        pickerViewMain.isHidden=false
        buttonHide.isHidden=false
        pickerZoneList.isHidden=true
     
    }
    ///////..
    func functionForMonthWordWiseNew(_ varGetMonth:String)->String
    {
        let varGetMonth = varGetMonth
        var varGetMonthNew:String!=""
        
        if(varGetMonth=="01" || varGetMonth=="1")
        {
            // varGetMonthNew="January"
            varGetMonthNew="January"
            
        }
        else  if(varGetMonth=="02" || varGetMonth=="2")
        {
            // varGetMonthNew="February"
            varGetMonthNew="February"
            
        }
        else  if(varGetMonth=="03" || varGetMonth=="3")
        {
            // varGetMonthNew="March"
            varGetMonthNew="March"
            
        }
        else  if(varGetMonth=="04" || varGetMonth=="4")
        {
            // varGetMonthNew="April"
            varGetMonthNew="April"
            
        }
        else  if(varGetMonth=="05" || varGetMonth=="5")
        {
            // varGetMonthNew="May"
            varGetMonthNew="May"
            
        }
        else  if(varGetMonth=="06" || varGetMonth=="6")
        {
            // varGetMonthNew="June"
            varGetMonthNew="June"
            
        }
        else  if(varGetMonth=="07" || varGetMonth=="7")
        {
            // varGetMonthNew="July"
            varGetMonthNew="July"
            
        }
        else  if(varGetMonth=="08" || varGetMonth=="8")
        {
            // varGetMonthNew="August"
            varGetMonthNew="August"
            
        }
        else  if(varGetMonth=="09" || varGetMonth=="9")
        {
            // varGetMonthNew="September"
            varGetMonthNew="September"
            
        }
        else  if(varGetMonth=="10")
        {
            // varGetMonthNew="October"
            varGetMonthNew="October"
            
        }
        else  if(varGetMonth=="11")
        {
            // varGetMonthNew="November"
            varGetMonthNew="November"
            
        }
        else  if(varGetMonth=="12")
        {
            // varGetMonthNew="December"
            varGetMonthNew="December"
            
        }
        return varGetMonthNew
    }

    //........
    
    
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        
        if(monthYear.contains("-"))
        {
            var getArray=monthYear.components(separatedBy: "-")
            print(getArray[0])
            print(getArray[1])
           var getValue = functionForMonthWordWiseNew(getArray[0])
            

            self.title = getValue+" "+getArray[1]
        }
        else
        {
        self.title = monthYear
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MonthlyReportDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
//        let searchButton = UIButton(type: UIButton.ButtonType.custom)
//        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
//        searchButton.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
//        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
//        let buttons : NSArray = [search]
//        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
   
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Button Folder Downloaded File List
    @objc func buttonDownloadableDocumentClickEvent()
    {
        
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MontlyPDFListViewControllerViewController") as! MontlyPDFListViewControllerViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        print("Create New pdf List View Controller")
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView==pickerViewMain)
        {
        return 1
        }
        else if(pickerView==pickerZoneList)
        {
                return 1
        }
         return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==pickerViewMain)
        {
        return pickerDataSource.count;
        }
        else if(pickerView==pickerZoneList)
        {
            return muarrayZoneList.count;
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView==pickerViewMain)
        {
        return pickerDataSource[row]
        }
        else if(pickerView==pickerZoneList)
        {
             //return pickerDataSource[row]
            print((muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as! String)
            
            return (muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as! String
        }
       return "0"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(pickerView==pickerViewMain)
        {
            print("This is value while selecting Picker !!!!")
          print(pickerDataSource[row])
            
            
        //if(IsSubmit==true)
    if(pickerDataSource[row]=="Submitted")
        {
           
            IsSubmit=false
            textfieldSubmitFilter.text="Submitted"
            functionForFetchingMonthlyReportDetailListData("Submitted")
        }
        //else  if(IsSubmit==false)
      else  if(pickerDataSource[row]=="Not Submitted")
        {
             createNavigationBar()
            IsSubmit=true
            textfieldSubmitFilter.text="Not Submitted"
            functionForFetchingMonthlyReportDetailListData("Not Submitted")
        }
        textfieldSearch.text=""
        pickerViewMain.isHidden=true
        }
        else if(pickerView==pickerZoneList)
        {
           
            print(muarrayZoneList[row] )
            textfieldZone.text=(muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as! String
            zoneId=(muarrayZoneList[row] as! AnyObject).value(forKey: "PK_zoneID")as! String
            
            self.pickerZoneList.isHidden=true
            functionForFetchingMonthlyReportDetailListData(textfieldSubmitFilter.text!)
        }
        buttonHide.isHidden=true

        /*
         pickerZoneList.isHidden=false
         pickerView.isHidden=true
         */
        
    }
      var zoneId:String!=""
    func textFieldDidBeginEditing(_ textField: UITextField!) {    //delegate method
        pickerViewMain.isHidden=true
         pickerZoneList.isHidden=true
        buttonHide.isHidden=true

    }
    ////
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(self.textfieldSubmitFilter.text == "Submitted")
        {
            return 100.0
        }
        else
        {
            return 52.0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MonthlyReportDetailTableViewCell
        if(muarrayListData.count>0)
        {
            // prototypeCells.labelDetail.text=muarrayListData.valueForKey("AttendanceResult").valueForKey("clubName")!.objectAtIndex(indexPath.row) as! String
            
            //reportUrl
            //ClubId1
            
            let RIDclubId1 = (muarrayListData.value(forKey: "ClubId1") as AnyObject).object(at: indexPath.row) as! String
            prototypeCells.labelDetail.text=(muarrayListData.value(forKey: "clubName") as AnyObject).object(at: indexPath.row) as! String + " (Club "+RIDclubId1+")"
            var clubAg = (muarrayListData.value(forKey: "clubAG") as AnyObject).object(at: indexPath.row) as? String
            prototypeCells.lblAG.text = "AG: "+clubAg!
            
            let url = (muarrayListData.value(forKey: "reportUrl") as AnyObject).object(at: indexPath.row) as? String
            let varGetDateandTime:String!=((muarrayListData.value(forKey: "SendToDistrictDate") as AnyObject).object(at: indexPath.row) as! String)+" | "+((muarrayListData.value(forKey: "SendToDistrictTime") as AnyObject).object(at: indexPath.row) as! String)
            prototypeCells.labelDateTime.text=varGetDateandTime
            if(self.textfieldSubmitFilter.text == "Submitted")
            {
                prototypeCells.imgUnderLineForNotSubmited.isHidden=true
                prototypeCells.lblAG.isHidden=false
                prototypeCells.buttonEyeShowPdfDeatils.isHidden=false
                prototypeCells.buttonDownloadPdfDetails.isHidden=false
                prototypeCells.labelDateTime.isHidden=false
            }
            else if (self.textfieldSubmitFilter.text == "Not Submitted")
            {
                prototypeCells.imgUnderLineForNotSubmited.isHidden=false
                prototypeCells.buttonEyeShowPdfDeatils.isHidden=true
                prototypeCells.buttonDownloadPdfDetails.isHidden=true
                prototypeCells.labelDateTime.isHidden=true
                prototypeCells.lblAG.isHidden=true
            }
            
            prototypeCells.buttonMain.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonMonthReportClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMain.tag = indexPath.row
            prototypeCells.buttonEyeShowPdfDeatils.tag=indexPath.row
            prototypeCells.buttonEyeShowPdfDeatils.addTarget(self, action: #selector(MonthlyReportDetailViewController.buttonEyeShowPdfDeatilsClickEvet(_:)), for: .touchUpInside)
            prototypeCells.buttonDownloadPdfDetails.tag=indexPath.row
            prototypeCells.buttonDownloadPdfDetails.addTarget(self, action: #selector(MonthlyReportDetailViewController.downloadPDFAction(_:)), for: .touchUpInside)
            
            
            
            
        }
        return prototypeCells
    }
    
    func isFileAvailable()
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        
        let filePath = url.appendingPathComponent("nameOfFileHere").path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
        }
    }
    
    //details album
    @objc func buttonMonthReportClickEvent(_ sender:UIButton)
    {
        
    }
    
    @objc func buttonEyeShowPdfDeatilsClickEvet(_ sender:UIButton)
    {
        //let url = muarrayListData.valueForKey("reportUrl").objectAtIndex(sender.tag) as? String
        if(muarrayListData.count>0)
        {
            let url = (muarrayListData.value(forKey: "reportUrl") as AnyObject).object(at: sender.tag) as? String
            
            if(url=="")
            {
                self.view!.makeToast("Download link not Available", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
                ///let url = "http://webtest.rosteronwheels.com/Documents/documentsafe/Group2765/ROW_11072018125802PM.pdf"
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyPDFViewWebViewController") as! MonthlyPDFViewWebViewController
                secondViewController.URLstr = url
                secondViewController.iscallFrom = ""
                secondViewController.moduleName = (muarrayListData.value(forKey: "clubName") as AnyObject).object(at: sender.tag) as? String
                self.navigationController?.pushViewController(secondViewController, animated: true)
                print("View PDF File------------------")
            }
            
        }
        // functionForGetAllDownloadedDocumentFromDirectory()
    }
    
    func funForOpeningDocs(urlString:String)
    {
        if urlString == nil
        {
            return
        }
        if urlString == ""
        {
            return
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyPDFViewWebViewController") as! MonthlyPDFViewWebViewController
        secondViewController.URLstr = urlString
        secondViewController.iscallFrom = "FirstDownloadList"
        secondViewController.moduleName = "Downloaded document"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    func functionForGetAllDownloadedDocumentFromDirectory()
    {
        let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        print(dirst)
        if dirst != nil
        {
            let dirt = dirst![0]
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
                print(fileList)
                print(fileList)
                
                for i in 00 ..< fileList.count
                {
                    let varValue=fileList[i]
                    if(varValue.hasSuffix(".sqlite") || varValue.hasSuffix(".db") || varValue.hasSuffix(".sqlite-wal") || varValue.hasSuffix(".sqlite-shm"))
                    {
                        
                    }
                    else
                    {
                        muarrayListOfDownloadedPdfList.add(fileList[i])
                    }
                    print(varValue)
                }
            }
            catch
            {
            }
        }
    }
    @objc func downloadPDFAction(_ sender:UIButton)
    {
        var desURL:String=""
        if(muarrayListData.count>0)
        {
            let pdfUrl = (muarrayListData.value(forKey: "reportUrl") as AnyObject).object(at: sender.tag) as? String
            
            if(pdfUrl=="")
            {
                self.view!.makeToast("Download link not Available", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
               // loaderClass.loaderViewMethod()
                print("Download PDF File------------------")
                print(sender.tag)
                //  let pdfUrl =  "http://webtest.rosteronwheels.com/Documents/documentsafe/Group2765/ROW_11072018125802PM.pdf"//muarrayListData.valueForKey("reportUrl").objectAtIndex(sender.tag) as? String
                print(pdfUrl)
                
                
                //-------------------------------
                let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
                
                
                Alamofire.download(pdfUrl!,method: .get, parameters: nil, encoding: JSONEncoding.default,headers: nil, to: destination).downloadProgress(closure: { (progress) in
                    //progress closure
                }).responseJSON(completionHandler: { (result) in
                    print("result is:-:-:-: \(result)")
                    print("%%%%%%%%%%%%%%%%-----------------*****************--------------%%%%%%%%%%%%%%%%%%%")
                }).response(completionHandler: { (DefaultDownloadResponse) in
                    //here you able to access the DefaultDownloadResponse
                    //result closure
                    if let URl:String=DefaultDownloadResponse.destinationURL?.absoluteString
                    {
                        desURL=URl
                        print("desURL\(desURL)")
                    }
                    
                    print("************-----------------*****************--------------***************")
                }).responseData { response in
                    switch response.result {
                    case .success:
                        print(response.result.value)
                        print("Validation Successful")
                        print("Downloaded file successfully")
                        //self.view!.makeToast("Downloaded file successfully", duration: 2, position: CSToastPositionCenter)
                        self.funForOpeningDocs(urlString: desURL)
                        self.loaderClass.window = nil
                        self.loaderClass.window = nil
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
                            print("exists")
                            let Alert: UIAlertView = UIAlertView()
                            Alert.delegate = self
                            Alert.title = "Rotary India"
                            Alert.message = "This Document is already downloaded"
                            Alert.addButton(withTitle: "okay")
                            //Alert.show()
                            self.funForOpeningDocs(urlString: desURL)
                            self.tableviewMonthlyReportDetail.reloadData()
                            self.loaderClass.window = nil
                        }
                        else
                        {
                            print("Downloaded file successfully")
                            self.view!.makeToast("Downloaded file successfully", duration: 2, position: CSToastPositionCenter)
                            self.loaderClass.window = nil
                        }
                    }
                }
            }
        }
        
    }
    
    func fileExistance() -> Bool
    {
        //ClubId replace by varGetMonthProfileID + ".pdf"
        
        let str = varGetMonthProfileID + ".pdf"
        let fileManager = FileManager.default
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("\(str)")
        let filePath:String = fileURL.path
        print(filePath)
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
            {//self.mainArray=NSArray()
            // self.functionForRefreshingData()
            SVProgressHUD.dismiss()
            }
        })
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()  //if desired
        functionForSearchByPredicate(textfieldSearch.text!)
        return true
    }
    var varGetSearchText:String!=""
    
    
    func functionForSearchByPredicate(_ searchText:String)
    {
        print("Click event keyboard return button")
        
        
        print("searchText \(textfieldSearch.text!)")
        varGetSearchText = textfieldSearch.text!
        print("use predicate 2 here")
        //textfieldSearch.resignFirstResponder()
        if(varGetSearchText.characters.count>0)
        {
            //let predicate =  NSPredicate(format: "title contains[c] %@ OR clubname contains[c] %@", varGetSearchText,varGetSearchText)
            let predicate =  NSPredicate(format: "clubName contains[c] %@ OR ClubId1 contains[c] %@", varGetSearchText,varGetSearchText)
            let searchDataSource = muarrayMainList.filtered(using: predicate)
            muarrayListData=searchDataSource as NSArray
            print(muarrayListData)
            self.tableviewMonthlyReportDetail.reloadData()
        }
        else
        {
            muarrayListData=NSArray()
            self.muarrayListData = self.muarrayMainList
            self.tableviewMonthlyReportDetail.reloadData()
        }
        
//        if(muarrayListData.count>0)
//        {
//
//        }
//        else
//        {
//            self.view.makeToast("No record found ", duration: 4, position: CSToastPositionCenter)
//        }
        
        if(self.muarrayListData.count>0)
        {
            self.lblNoresult.text=""
            self.lblNoresult.isHidden=true
            
        }
        else
        {
            
            self.lblNoresult.text="No record found"
            self.lblNoresult.isHidden=false
        }
        
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        //your code
        print(textField.text)
        functionForSearchByPredicate(textField.text!)
    }
    
    //calling web services
    func functionForFetchingMonthlyReportDetailListData(_ stringSubmitorNotSubmit:String)
    {
        print(stringSubmitorNotSubmit)
        
      //  loaderClass.loaderViewMethod()
        var types:String!=""
        if(stringSubmitorNotSubmit=="Not Submitted")
        {
            types = "2"
        }
        else
        {
            types = "1"
        }
        let completeURL = baseUrl+"ClubMonthlyReport/GetMonthlyReportList"//"Galxzclery/GetAlbumsList_New"
        let parameterst = [ "profileId":varGetMonthProfileID!,
                            "groupId":grpIDMonthReport!,
                            "month":monthYear!,
                            "Fk_ZoneID":zoneId,
            "type":types]
        //        let parameterst = [
        //            "groupId":"2765",
        //            "district_id":"0",
        //            "club_id":"0",
        //            "category_id":"0",
        //            "year":"2017-2018",
        //            "SharType":"0"
        //        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            // print(response)
            let dd = response as! NSDictionary
            //  print("dd \(dd)")
            var varGetValueServerError = dd.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
         
             SVProgressHUD.dismiss()
            
            }
            else
            {
                if((dd.object(forKey: "TBClubMonthlyReportListResult")! as AnyObject).object(forKey: "status") as! String == "0")
                {
                    let arrarrNewGroupList = ((dd.object(forKey: "TBClubMonthlyReportListResult")! as AnyObject).object(forKey: "Result") as! NSArray)
                    print(arrarrNewGroupList)
                    // let arrUpdateGroupList = (dd.objectForKey("TBClubMonthlyReportListResult")!.objectForKey("ClubMonthlyReportListResult")!.objectForKey("updatedAlbums")) as! NSArray
                    // print(arrUpdateGroupList)
                    self.muarrayMainList = arrarrNewGroupList
                    self.muarrayListData = arrarrNewGroupList
                    print(self.muarrayMainList)
                    if(self.muarrayMainList.count>0)
                    {
                        self.lblNoresult.text=""
                        self.lblNoresult.isHidden=true
                        var getValue:String!=self.textfieldSubmitFilter.text
                        /*
                         [ "Submitted", "Not Submitted"];
                         */
                        if(getValue=="Submitted")
                        {
                           self.createNavigationBar()
                        }
                        else if(getValue=="Not Submitted")
                        {
                         self.createNavigationBarRight()
                        }
                    }
                    else
                    {
                         self.createNavigationBar()
                        self.lblNoresult.text="Monthly Report Not Found."
                        self.lblNoresult.isHidden=false
                    }
                    self.tableviewMonthlyReportDetail.reloadData()
                    
                    self.loaderClass.window=nil
                }
                else
                {
                    self.loaderClass.window=nil
                    print("NO Result")
                }
                
            }
            SVProgressHUD.dismiss()
        })
    }
    // 1
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,didFinishDownloadingTo location: URL){
        
        let str = varGetMonthProfileID + ".pdf"
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath + "/\(str)")
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            print(destinationURLForFile.path)
            self.fileExistance()
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                print(destinationURLForFile.path)
                self.fileExistance()
            }
            catch
            {
                print("An error occurred while moving file to destination url")
            }
        }
    }
    // 2
    func urlSession(_ session: URLSession,downloadTask: URLSessionDownloadTask,didWriteData bytesWritten: Int64,totalBytesWritten: Int64,totalBytesExpectedToWrite: Int64)
    {
    }
    
    
    func urlSession(_ session: URLSession,task: URLSessionTask,didCompleteWithError error: Error?)
    {
        downloadTask = nil
        if (error != nil)
        {
            // print(error?.description)
        }else
        {
            print("The task finished transferring data successfully")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController{
        return self
    }
    func removeFile()
    {
        let str = varGetMonthProfileID + ".pdf"
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
}
