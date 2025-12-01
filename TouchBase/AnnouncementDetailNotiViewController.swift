
import UIKit
import SVProgressHUD
class AnnouncementDetailNotiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var isCategory:String! = ""
    var grpName:String!=""
    var ticksnew:String!=""
    var FileNameToDelete:String=""

    @objc func buttonbuttonImageViewViewEventClickEvent(_ sender:UIButton)
    {
        let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
        //here need to add condition for is contain image path on zero index
        objImageFullViewViewController.varGetImageUrl=muarrayHoldInfo.object(at: 0) as! String
        self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
    }
    
    @IBOutlet weak var tableviewAnnouncementDetailNoti: UITableView!
    
    func createNavigationBar()
    {
        
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LinkViewController.methodOfReceivedNotification(_:)), name:"NotificationIdentifier", object: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Announcement"
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
        //    let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DirectoryViewController.AddEventAction))
        //    add.tintColor = UIColor.whiteColor()
        self.view.addSubview(buttonleft)
        //self.view.addSubview(leftButton)
        //self.view.addSubview()
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        
        if let systemVersion = (UIDevice.current.systemVersion
         as? NSString)?.integerValue
        {
         //if systemVersion < 13
         //{
            self.navigationItem.rightBarButtonItem=shareButtonAdd
         //}
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
    
    var ann_img:String!=""
    var ann_title:String!=""
    var Ann_date:String!=""
    var ann_lnk:String!=""
    var ann_desc:String!=""
    var ann_footer:String!="test description"
    override func viewDidLoad() {
        super.viewDidLoad()
         tableviewAnnouncementDetailNoti.separatorStyle = .none
        self.view.backgroundColor=UIColor.lightGray
        createNavigationBar()
        
        print(ann_img)
        print(ann_title)
        print(Ann_date)
        print(ann_lnk)
        print(ann_desc)
        print(ann_footer)

        muarrayHoldInfo.add(ann_img)
        muarrayHoldInfo.add(ann_title)
        var sDate:String=""
        if let date=Ann_date{
            let df:DateFormatter=DateFormatter()
            df.dateFormat="yyyy-MM-dd HH:mm:ss"
            let sDte=df.date(from: date)
            let dfs:DateFormatter=DateFormatter()
            dfs.dateFormat="dd MMM yyyy hh:mm a"
            if let sd = sDte {
                sDate=dfs.string(from: sd)
            }
        }
        muarrayHoldInfo.add(sDate)
        muarrayHoldInfo.add(ann_lnk)
        muarrayHoldInfo.add(ann_desc)
        //for future purpose
        //muarrayHoldInfo.add(ann_footer)
    tableviewAnnouncementDetailNoti.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var varRowHeight:CGFloat!=0.0

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayHoldInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        //        if(indexPath.row==0)
        //        {
        //           return 333.0
        //        }
        //        else
        //        {
        //        return varRowHeight
        //        }
        return varRowHeight
    }

    var muarrayHoldInfo:NSMutableArray=NSMutableArray()

    func assignHeadFootToTableView()
    {
        var headerImage:UIImage=UIImage()
        var footerImage:UIImage=UIImage()
        if(isCategory=="1")
        {
            headerImage=UIImage(named:"ClubHeader")!
            footerImage=UIImage(named: "common_footer.jpg")!
        }
        else if(isCategory=="2")
        {
            headerImage=UIImage(named:"DistHeader")!
            footerImage=UIImage(named: "common_footer.jpg")!
        }
        else
        {
            headerImage=UIImage(named:"rt_header.jpg")!
            footerImage=UIImage(named: "rt_footer.png")!
        }
        let topView:UIView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: tableviewAnnouncementDetailNoti.contentSize.width, height: 95.0)
        topView.backgroundColor = UIColor.clear
        let headerImgView:UIImageView=UIImageView()
        headerImgView.frame = CGRect(x: 0, y: 0, width: tableviewAnnouncementDetailNoti.contentSize.width, height: 95.0)
        headerImgView.image=headerImage
        topView.addSubview(headerImgView)
        
        let headerLabel:UILabel=UILabel()
        headerLabel.frame=CGRect(x: 0, y: 60, width: tableviewAnnouncementDetailNoti.contentSize.width, height: 35.0)
        headerLabel.backgroundColor=UIColor.clear
        if grpName.contains("Rotary India")
        {
           headerLabel.text=""
        }
        else
        {
        headerLabel.text=grpName!
        }
        headerLabel.font=UIFont(name: "Roboto-Regular", size: 18)
        headerLabel.textColor=UIColor.white
        headerLabel.textAlignment=NSTextAlignment.center
        topView.addSubview(headerLabel)
        topView.bringSubviewToFront(headerLabel)
        
        tableviewAnnouncementDetailNoti.tableHeaderView = topView
        
        let bottomView:UIView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: tableviewAnnouncementDetailNoti.contentSize.width, height: 45.0)
        bottomView.backgroundColor = UIColor.clear
        
        let footerImgView:UIImageView=UIImageView()
        footerImgView.frame = CGRect(x: 0, y: 0, width: tableviewAnnouncementDetailNoti.contentSize.width, height: 45.0)
        footerImgView.image=footerImage
        bottomView.addSubview(footerImgView)
        tableviewAnnouncementDetailNoti.tableFooterView = bottomView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableviewAnnouncementDetailNoti.dequeueReusableCell(withIdentifier: "Cell") as! AnnouncementDetailNotiiTableViewCell
        
        /*--------*/
        /*
         
         //1.
         @IBOutlet weak var viewImage: UIView!
         @IBOutlet weak var imageMain: UIImageView!
         //2.
         @IBOutlet weak var viewTitleLinkDate: UIView!
         @IBOutlet weak var labelLink: UILabel!
         @IBOutlet weak var buttonLink: UIButton!
         @IBOutlet weak var labelTitleDate: UILabel!
         //3.
         @IBOutlet weak var viewVenue: UIView!
         @IBOutlet weak var buttonLocation: UIButton!
         @IBOutlet weak var textviewVenue: UITextView!
         //4.
         @IBOutlet weak var viewDescription: UIView!
         @IBOutlet weak var textviewDescription: UITextView!
         //5.
         @IBOutlet weak var viewBottomBar: UIView!
         */
        /*--------*/
        cell.viewImage.isHidden=true
        cell.viewTitleLinkDate.isHidden=true
        cell.viewDescription.isHidden=true
        
        
        if(indexPath.row==0)
        {
            let varGetImage = muarrayHoldInfo.object(at: 0)
            print("************************************",varGetImage)
            
            if muarrayHoldInfo.object(at: 0) as! String == ""
            {
                cell.imageMain.image = UIImage(named: "profile_pic")
                varRowHeight=0.0
            }
            else
            {
                let varGetImageUrl:String=muarrayHoldInfo.object(at: 0) as! String
                print(varGetImageUrl)
                let url = URL(string: varGetImage as! String)
                let ImageProfilePic:String = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imageMain.sd_setImage(with: checkedUrl)
                varRowHeight=252.0
                cell.viewImage.isHidden=false
                cell.buttonImageFullView.addTarget(self, action: #selector(buttonbuttonImageViewViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                
            }
        }
        else  if(indexPath.row==1)
        {
            cell.labelTitleDate.text=muarrayHoldInfo.object(at: 1)as! String
            
            print("Object @ 1 \(muarrayHoldInfo.object(at: 1)as! String)")
            cell.labelLink.isHidden=true
            cell.buttonLink.isHidden=true
            varRowHeight=60.0
            cell.labelTitleDate.isHidden=false
            cell.viewTitleLinkDate.isHidden=false
            
            cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 60.0)
            cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 60.0)
           let title=muarrayHoldInfo.object(at: 1)as! String
         
            if title.count < 35
            {
              varRowHeight=43.0
                cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 43.0)
                cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 43.0)
                
            }
            else if title.count > 35 && title.count < 68
            {
                varRowHeight=68.0
                cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 68.0)
                cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 68.0)
           }
            else if title.count > 68
            {
                varRowHeight=120.0
                cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 120.0)
                cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 120.0)
            }

            
        }
        else  if(indexPath.row==2)
        {
            cell.labelTitleDate.text=muarrayHoldInfo.object(at: 2)as! String
            print("Object @ 2 \(muarrayHoldInfo.object(at: 2)as! String)")
            cell.labelLink.isHidden=true
            cell.buttonLink.isHidden=true
            cell.labelTitleDate.isHidden=false
            varRowHeight=25.0
            cell.viewTitleLinkDate.isHidden=false
            cell.labelTitleDate.font=UIFont(name: "Roboto-regular", size: 14.0)
            cell.labelTitleDate.lineBreakMode=NSLineBreakMode.byTruncatingTail
            cell.labelTitleDate.frame=CGRect(x: cell.labelTitleDate.frame.origin.x, y: cell.labelTitleDate.frame.origin.y, width: cell.labelTitleDate.frame.width, height: 30.0)
            cell.viewTitleLinkDate.frame=CGRect(x: cell.viewTitleLinkDate.frame.origin.x, y: cell.viewTitleLinkDate.frame.origin.y, width: cell.viewTitleLinkDate.frame.width, height: 30.0)
        }
        else  if(indexPath.row==3)
        {
            print("Object @ 3 \(muarrayHoldInfo.object(at: 3)as! String)")
            var getLink:String!=muarrayHoldInfo.object(at: 3)as! String
            if(getLink.characters.count>8)
            {
            cell.labelTitleDate.text=muarrayHoldInfo.object(at: 3)as! String
            cell.labelLink.isHidden=false
            cell.buttonLink.isHidden=false
            cell.labelTitleDate.isHidden=true
            varRowHeight=50.0
            cell.viewTitleLinkDate.backgroundColor=UIColor.white
            cell.buttonLink.setTitle(muarrayHoldInfo.object(at: 3)as! String, for: .normal)
            cell.viewTitleLinkDate.isHidden=false
//            cell.buttonLink.addTarget(self, action: #selector(EventDetailNotiViewController.buttonLinkViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
                 cell.buttonLink.addTarget(self, action: #selector(buttonLinkViewEventClickEvent(_:)), for: UIControl.Event.touchUpInside)
            }
            else
            {
               varRowHeight=0.0
            }
        }
        else  if(indexPath.row==4)
        {
            cell.textviewDescription.text=muarrayHoldInfo.object(at: 4)as! String
            let varGetDesc=muarrayHoldInfo.object(at: 4)  as! String
            cell.textviewDescription.text=varGetDesc
            let fixedWidth = cell.textviewDescription.frame.size.width
            cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.textviewDescription.frame
            varRowHeight=newSize.height+5
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            cell.textviewDescription.frame = newFrame;
            cell.viewDescription.isHidden=false
        }
        
        return cell
    }
    func buttonbuttonLocationViewEventClickEvent(_ sender:UIButton)
    {
        print("button location click event !!!!!!")
    }
    
    @objc func buttonLinkViewEventClickEvent(_ sender:UIButton)
    {
        print("button buttonLinkViewEventClickEvent click event !!!!!!")
        //URLstr
        SVProgressHUD.show()
        /*
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
        objWebSiteOpenUrlViewController.URLstr=muarrayHoldInfo.object(at: 3)as! String
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
        */
        var stringUrl:String!=""
        stringUrl=muarrayHoldInfo.object(at: 3)as! String
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
//            UIApplication.shared.openURL(url as URL)
            
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
    
    //MARK:- Extra PDF methods by harshada
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
    }
    
    @objc func shareButtonClickEvent()
    {
        self.assignHeadFootToTableView()
        sharePDFTo(url:createPDFDataFromTableView(tableView: tableviewAnnouncementDetailNoti))
//         tableviewAnnouncementDetailNoti.tableHeaderView=nil
//         tableviewAnnouncementDetailNoti.tableFooterView=nil
    }

    func sharePDFTo(url:NSURL)
    {

        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("cancel clicked ")
                self.removePDFFiles()
                return
            }
            self.removePDFFiles()
            print("other  clicked ")
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
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
                if extensionL == "pdf" && filName.contains("\(FileNameToDelete)") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { //print(error)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
    }
    func createPDFDataFromTableView(tableView: UITableView) -> NSURL {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x:0, y:0, width:fittedSize.width, height:fittedSize.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.tableviewAnnouncementDetailNoti.contentSize.height)
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
            print(pageOriginY)
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        
        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        self.ticksnew = getCurrentDate()
        
        if let titleName=muarrayHoldInfo.object(at: 1)as? String
        {
            FileNameToDelete=titleName
        }
        let fileName:String!="\(FileNameToDelete).pdf"
        print(fileName)
        let path = dir?.appendingPathComponent(fileName!)
        
        do {
            try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            print("error catched")
        }
        return path! as NSURL
    }
}

