//
//  RassFeedWebViewContinueReadingViewController.swift
//  TouchBase
//
//  Created by rajendra on 15/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import WebKit
class RassFeedWebViewContinueReadingViewController: UIViewController ,WKNavigationDelegate {
    var outPutURL:NSURL=NSURL()
   // let customeWebView:WKWebView=WKWebView()

    var ContinueReadingLink:String! = ""
    var moduleName:String! = ""
     var ticksnew:String!=""
    @IBOutlet weak var webViewInfo: WKWebView!
    @IBOutlet weak var buttonClose: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavigationBar()
        webViewInfo.backgroundColor = UIColor.white
//        webViewInfo.navigationDelegate=self
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonClose.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.gray
        buttonClose.addSubview(lbel)
        buttonClose.titleLabel?.textColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        
        
//        self.customeWebView.frame=self.webViewInfo.frame
//        self.view.addSubview(self.customeWebView)
//        customeWebView.delegate=self
//
//        self.customeWebView.isHidden=true
//        self.customeWebView.backgroundColor=UIColor.white
        

        
        functionForOpenLinkInApp()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = moduleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(RassFeedWebViewContinueReadingViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem=sharing
    }
    
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- share methods
    @objc func shareButtonClickEvent()
    {
       // outPutURL=exportHTMLContentToPDF()
        sharePDFTo(url:exportHTMLContentToPDF())
    }

/*ss*/  func sharePDFTo(url:NSURL)
    {
        // let url = createPDFDataFromTableView(webView: AnnounceDetailTableView)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("cancel clicked ")
                self.removePDFFiles()
                return
            }
            print("other  clicked ")
            self.removePDFFiles()
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func exportHTMLContentToPDF() -> NSURL{
        let printPageRenderer:CustomPrintPageRenderer = CustomPrintPageRenderer()
        printPageRenderer.getWebView(webView: self.webViewInfo)
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x: 0.0, y: 25.0, width: 595.2, height: self.webViewInfo.frame.height+165.0)
        // Set the page frame.
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        // Set the horizontal and vertical insets (that's optional).
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
        printPageRenderer.addPrintFormatter(self.webViewInfo.viewPrintFormatter(), startingAtPageAt: 0)
        
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        self.ticksnew = getCurrentDate()
        let fileName:String!="Rotary_India_NEWS_\(self.ticksnew!)"
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName!).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        pdfData.write(to: outputURL, atomically: true)
        return outputURL as NSURL
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer:CustomPrintPageRenderer) -> NSMutableData {
        let data = NSMutableData()
        let pdfPageBounds =  CGRect(x:0, y:0.0, width:595.2,height:self.webViewInfo.frame.height+200.0)
        UIGraphicsBeginPDFContextToData(data, pdfPageBounds, nil)
        
        
        print("printPageRenderer.numberOfPages :: \(printPageRenderer.numberOfPages)")
        print("printPageRenderer.numberOfPages-1 :: \(printPageRenderer.numberOfPages-1)")
        if printPageRenderer.numberOfPages>0
        {
        for i in 0...printPageRenderer.numberOfPages-1 {
            UIGraphicsBeginPDFPage()
            if i==0
            {
               // printPageRenderer.drawHeaderForPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
            printPageRenderer.drawHeaderForPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        printPageRenderer.drawFooterForPage(at: printPageRenderer.numberOfPages-1, in: UIGraphicsGetPDFContextBounds())
        UIGraphicsEndPDFContext()
        }
        return data
    }
    
    
    func getCurrentDate() -> String
    {
        let date=Date()
        let formatter=DateFormatter()
        formatter.dateFormat="ddMMyyyy_HHmmss"
        return formatter.string(from: date)
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
                if extensionL == "pdf" && filName.contains("Rotary_India_NEWS_") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    
    //MARK:-
    
    @IBAction func buttonCloseClickEvent(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func webViewDidFinishLoad(_ webView: WKWebView) {
      
   }
    
   
    func functionForOpenLinkInApp()
    {
        print(ContinueReadingLink)
//        let url = NSURL (string: ContinueReadingLink)
//        let requestObj = NSURLRequest(URL: url!);
//        print(requestObj)
//        webViewInfo.loadRequest(requestObj)
//        
        
        // Do any additional setup after loading the view, typically from a nib.
//        let url = NSURL (string: ContinueReadingLink)
//        print(url)
//        let requestObj = NSURLRequest(URL: url!)
//        webViewInfo.loadRequest(requestObj)
//        print("ææææææææææææææææææææææææ")
//        print(ContinueReadingLink)
        
        let trimmedString = ContinueReadingLink.trimmingCharacters(in: CharacterSet.whitespaces)
        let url : NSString = trimmedString as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : URL = URL(string: urlStr as String)!
        print(searchURL)
        let requestObj = URLRequest(url: searchURL)
        webViewInfo.load(requestObj)
        //customeWebView.loadRequest(requestObj)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
