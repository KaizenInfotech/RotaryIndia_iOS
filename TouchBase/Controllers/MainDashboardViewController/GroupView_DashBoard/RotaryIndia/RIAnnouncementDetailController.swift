//
//  AnnouncementDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import WebKit
class RIAnnouncementDetailController: UIViewController , UITableViewDataSource , UITableViewDelegate ,webServiceDelegate,annImgDelegate,protocolForAnnouncementListingCallingApi
{
    
    
    //MARK:- All IBOutlet declaration
    @IBOutlet var AnnounceDetailTableView: UITableView!

    //MARK:- All Variable declaration
    var objprotocolForAnnouncementListingCallingApi:protocolForAnnouncementListingCallingApi!=nil
    let bounds = UIScreen.main.bounds
    var annDetail:AnnounceList!
    var appDelegate : AppDelegate!
    var SMSCountStr : String!
    var FileNameToDelete:String=""
    var ExpiredStr = String()
    var grpID:NSString!
    var profileId:NSString!
    var annID:NSString!
    var alertController = UIAlertController()
    var ticksnew:String!=""
    var isCategory:String! = ""
    var grpName:String! = ""
    var webUrl:String!=""
    let webView:WKWebView=WKWebView()
    var mainHTMLString:String = ""

    
    //MARK:- All IBAction declaration
    
    
    //MARK:- All Methods Declaration
    func functionForAnnouncementListingCallingApi(stringFromWhereITCalling: String) {
        print("this is coming from screen")
        print(stringFromWhereITCalling)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        wsm.getAnnouceDetail(annDetail.announID as! NSString, grpID:grpID , memberProfileID:profileId )
    }

override func viewWillAppear(_ animated: Bool) {
        print("Back to View will appear")
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
        wsm.getAnnouceDetail(annID, grpID:grpID , memberProfileID:profileId )
    }

override func viewDidLoad()
{
        super.viewDidLoad()
        profileId = UserDefaults.standard.string(forKey: "masterUID") as NSString?
        self.view.backgroundColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: false)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    func getallAnnounOFUSerSuccss(string:TBAnnounceListResult){
        if(string.status == "0"){
        annDetail=string.announListResult[0] as! AnnounceList
        AnnounceDetailTableView.estimatedRowHeight = 55
        AnnounceDetailTableView.rowHeight = UITableView.automaticDimension
        AnnounceDetailTableView.reloadData()
        createHTMLAnnouncementPage()
            if (annDetail != nil && annDetail.announTitle != nil)
            {
                FileNameToDelete=annDetail.announTitle
                 print("Is FileNAmeTo Delete is available \(FileNameToDelete)")
                //removePDFFiles()
            }
            if annDetail.filterType == "3"
            {
                ExpiredStr = "Yes"
            }
            else
            {
                ExpiredStr = "No"
            }
            self.createNavigationBar()
            // self.AnnounceDetailTableView.isHidden=false //------if
            //   -----------Else
            alertController.dismiss(animated: true, completion: nil)
        }
        else
        {
             self.AnnounceDetailTableView.isHidden=true 
             alertController.dismiss(animated: true, completion: nil)
        }
    }

    func createNavigationBar(){
        self.title="Announcement"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white

        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
    
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AnnouncementDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = shareButtonAdd
    }


    @objc func backClicked()
    {
            self.navigationController?.popViewController(animated: true) //DPK
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    @objc func buttonLinkClickEvent(_ sender:UIButton)
    {
        
        
        print(sender.titleLabel?.text)
        if(sender.titleLabel?.text == nil)
        {
            
        }
        else
        {
            print("clicxked !!!!")
            var getValue = sender.titleLabel?.text
            print(getValue)
            if(getValue?.contains("<null>"))!
            {
                print("if")
            }
            else
            {
                
                var stringUrl:String!=""
                stringUrl=webUrl
                //--
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
//                    UIApplication.shared.openURL(url as URL)
                    
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
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == AnnounceDetailTableView
        {
        if(indexPath.section == 0)
        {
            alertController.dismiss(animated: true, completion: nil)
            let cell = AnnounceDetailTableView.dequeueReusableCell(withIdentifier: "ancDetailCell", for: indexPath) as! AnnounceDetailCell

          if(annDetail != nil)
          {
            cell.indicator.stopAnimating()

            cell.buttonLink.setTitle(annDetail.link,  for: UIControl.State.normal)
            cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
            print(annDetail)
            if(annDetail != nil )
            {
            cell.announceNameLabel.text = annDetail.announTitle
            
            var getValue:String! =  UserDefaults.standard.value(forKey: "session_LinkValueAnnouncement") as! String
                if(getValue=="nothing")
                {
                    webUrl="nothing"
                    cell.labelLink.isHidden=true
                }
                else
                {
                    cell.buttonLink.setTitle(getValue,  for: UIControl.State.normal)
                    webUrl=getValue
                    cell.labelLink.isHidden=false
                }
                
                
                cell.buttonLink.addTarget(self, action: #selector(AnnouncementDetailController.buttonLinkClickEvent(_:)), for: UIControl.Event.touchUpInside)
                
            cell.announceDateTimeLabel.text=annDetail.publishDateTime
            cell.delegates=self
            cell.imgUrl=annDetail.announImg as! NSString
            cell.indicator.stopAnimating()
            if(annDetail.announImg == ""){
                
                cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
                cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 0)
                cell.imgClkBtn.isHidden=true
                cell.imgClkBtn.isUserInteractionEnabled=false
                cell.indicator.stopAnimating()
                
            }else{
                cell.announceImage.translatesAutoresizingMaskIntoConstraints = true
                cell.announceImage.frame=CGRect(x: 0, y: 0, width: bounds.width,height: 170)
                cell.imgClkBtn.isHidden=false
                cell.imgClkBtn.isUserInteractionEnabled=true
                if let checkedUrl = URL(string: annDetail.announImg) {
                    
                    
                    if let data = try? Data(contentsOf: checkedUrl)
                    {
                        cell.announceImage.image = UIImage(data: data)
                    }
                }else{
                     cell.indicator.stopAnimating()
                }
            }
            
            }
            }
            return cell
           
        }
        else
        {
           
            let cell = AnnounceDetailTableView.dequeueReusableCell(withIdentifier: "ancDescriptCell", for: indexPath) as! AnnounceDescriptionCell
            if(annDetail != nil )
            {
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 30.0
            paragraphStyle.maximumLineHeight = 30.0
            paragraphStyle.minimumLineHeight = 30.0
                let ats = [NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 16.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

                cell.textDescriptionForAnnounceDetails.attributedText = NSAttributedString(string: annDetail.announceDEsc as! String, attributes: ats)
            cell.textDescriptionForAnnounceDetails.text = annDetail.announceDEsc
            }
            return cell
        }
    }
    
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        AnnounceDetailTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func EventImgBtnClk(_ imgUrl:NSString){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "fullImg") as! ImageFullViewController
        secondViewController.urlLink=imgUrl
        //secondViewController.eventDetail = grp
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //MARK:- Extra PDF methods by harshada
    
    func removePDFFiles()
    {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            for fileURL in fileURLs {
                let filName:String=fileURL.lastPathComponent
                let extensionL:String=fileURL.pathExtension
                if extensionL == "pdf" && filName.contains(FileNameToDelete) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }

    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
    }

    @objc func shareButtonClickEvent()
    {
        sharePDFTo(url: exportHTMLContentToPDF(HTMLContent: mainHTMLString ))
    }
    
    
    
  /*ss*/  func sharePDFTo(url:NSURL)
    {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if error != nil{
            print("Error while generating PDF \(error)")
            }
            if !completed {
                print("XXXX cancel clicked XXXX ")
                self.removePDFFiles()
                return
            }
            
               self.removePDFFiles()
               print("other  clicked ")
        }
       
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func createHTMLAnnouncementPage()
    {
        webView.frame=self.view.bounds
        self.view.addSubview(webView)
        webView.isHidden=true
        let headerImagePath = Bundle.main.path(forResource: "rt_header", ofType: "jpg")
        
        let headerHtmlString:String = "<!DOCTYPE html><html><head><style>.myDiv{background-color: lightgrey;text-align:start;}</style></head><body><img src=\"file://\(headerImagePath!)\" width = 100% height=\"100px\"/>"
        
        var annImageString:String=""
        if(annDetail.announImg == ""){
        }else{
            if let checkedUrl = annDetail.announImg {
                annImageString="<br/><center><img width=\"80%\" height=\"400px\" src=\"\(checkedUrl)\"/></center>"
            }
        }

        let titleHtmlString:String = "<div class=\"myDiv\"><div style=\"margin-left:7px;margin-top:5px;margin-bottom:15px\"><p style = \"font-family:roboto-regular;font-size:20px;font-style:none;color:#696969;\">\(annDetail.announTitle!)</p><p style = \"font-family:roboto-regular;font-size:15px;font-style:none;color:#696969;margin-top:-10px\">\(annDetail.publishDateTime!)</p>"
                
        var linkHtmlString:String=""
        if let getValue:String =  UserDefaults.standard.value(forKey: "session_LinkValueAnnouncement") as? String
        {
            if(getValue=="nothing")
            {
            }
            else
            {
                 linkHtmlString="<p style = \"font-family:roboto-regular;font-size:15px;font-style:none;color:#696969;margin-top:-10px\">Link: &nbsp; <span style=\"color: blue;\">\(getValue)</span></p>"
            }
        }

     let closeDivString:String = "</div></div>"
      var mainDescription:String=""
      let desc=(annDetail.announceDEsc as String).split(separator: "\n")
      if desc.count>0
      {
        for i in 0 ..< desc.count
        {
            mainDescription=mainDescription+"\(desc[i])<br/>"
        }
      }
      else{
        mainDescription=annDetail.announceDEsc
        }
      let descHtmlString:String = "<br/><p style = \"font-family:roboto-regular;font-size:19px;font-style:none;color:#000000;margin-top:-10px;text-align:justify\">\(mainDescription)</p>"
        let closingHTMLString:String="</body></html>"
        mainHTMLString = headerHtmlString+annImageString+titleHtmlString+linkHtmlString+closeDivString+descHtmlString+closingHTMLString
        print("MAin Html Strin \(mainHTMLString)")
        webView.loadHTMLString((mainHTMLString), baseURL: nil)
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String) -> NSURL{
        let printPageRenderer:CustomPrintRender = CustomPrintRender()
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x:0, y:0, width: self.webView.frame.width, height: self.webView.frame.height-70)
        // Set the page frame.
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        // Set the horizontal and vertical insets (that's optional).
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
        printPageRenderer.addPrintFormatter(self.webView.viewPrintFormatter(), startingAtPageAt: 0)
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)

        self.ticksnew = getCurrentDate()
        if annDetail.announTitle != nil
        {
            FileNameToDelete=annDetail.announTitle
        }
        let fileName:String!="\(FileNameToDelete)"
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName!).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        pdfData.write(to: outputURL, atomically: true)
        return outputURL as NSURL
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer:CustomPrintRender) -> NSMutableData {
        let data = NSMutableData()
        let pdfPageBounds =  CGRect(x:0, y:0.0, width:self.webView.frame.width,height:self.webView.frame.height)
        UIGraphicsBeginPDFContextToData(data, pdfPageBounds, nil)
        print("printPageRenderer.numberOfPages :: \(printPageRenderer.numberOfPages)")
        print("printPageRenderer.numberOfPages-1 :: \(printPageRenderer.numberOfPages-1)")
        if printPageRenderer.numberOfPages>0
        {
            printPageRenderer.drawHeaderForPage(at: 0, in: UIGraphicsGetPDFContextBounds())
            for i in 0...printPageRenderer.numberOfPages-1 {
                UIGraphicsBeginPDFPage()
                printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            printPageRenderer.drawHeaderForPage(at: 0, in: UIGraphicsGetPDFContextBounds())
            printPageRenderer.drawFooterForPage(at: printPageRenderer.numberOfPages-1, in: UIGraphicsGetPDFContextBounds())
            UIGraphicsEndPDFContext()
        }
        return data
    }
 
}
