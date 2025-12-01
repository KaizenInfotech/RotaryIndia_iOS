//
//  RotaryLibraryWevViewViewController.swift
//  TouchBase
//
//  Created by rajendra on 24/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit
class RotaryLibraryWevViewViewController: UIViewController  , WKNavigationDelegate{

    @IBOutlet weak var webViewRotary: WKWebView!
    //@IBOutlet weak var lblTitle: UILabel!
    var varRotaryLibraryDescription:String! = ""
    var moduleName:String! = ""
    var varTitle:String! = ""
    let bounds = UIScreen.main.bounds
    var appDelegate = AppDelegate()
    let customeWebView:WKWebView=WKWebView()
    var ticksnew:String!=""
    var outPutURL:NSURL=NSURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        lblTitle.text! = varTitle
        SVProgressHUD.show()
        webViewRotary.backgroundColor = UIColor.white
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        createNavigationBar()
        print("url str \(varRotaryLibraryDescription)")
//        webViewRotary.delegate = self
//        webViewRotary.navigationDelegate = self
        webViewRotary.loadHTMLString(varRotaryLibraryDescription, baseURL: nil)
        
        //removePDFFiles()
        self.customeWebView.frame=webViewRotary.frame
        self.view.addSubview(self.customeWebView)
//        customeWebView.delegate=self
        customeWebView.navigationDelegate = self
        customeWebView.loadHTMLString(createHTMLString(), baseURL: nil)
        self.customeWebView.isHidden=true
        self.customeWebView.backgroundColor=UIColor.lightGray
        
       webViewRotary.loadHTMLString(createHTMLStringForWebView(), baseURL: nil)
        SVProgressHUD.dismiss()
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
        buttonleft.addTarget(self, action: #selector(RotaryLibraryWevViewViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(self.shareButtonClickEvent), for: UIControl.Event.touchUpInside)
        let shareButtonAdd: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
       
    if(moduleName.contains("Rotary Library"))
   {
     self.navigationItem.rightBarButtonItem = shareButtonAdd
   }
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        sharePDFTo(url:exportHTMLContentToPDF(HTMLContent: createHTMLString()))
        //  webViewRotary.loadRequest(NSURLRequest(url: outPutURL as URL) as URLRequest)
    }
    
/*ss*/ func sharePDFTo(url:NSURL)
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
            self.removePDFFiles()
            print("other  clicked ")
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: WKWebView) {
        SVProgressHUD.dismiss()
        if webView==self.customeWebView
        {
           // self.outPutURL=exportHTMLContentToPDF(HTMLContent: createHTMLString())
        }
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    
    func createHTMLStringForWebView() -> String
    {
        let headerTile:String!="<H3>\(self.varTitle!)</H3><hr width=100%/>"
        var html=""
        print("HTML Code: \(html)")
        if moduleName=="About Developer"
        {
            html="<p align=\"justify\",style=\"font-size:22px\">\(self.varRotaryLibraryDescription!)</p>"
        }
        else{
            html="\(headerTile!) <p align=\"justify\",style=\"font-size:22px\">\(self.varRotaryLibraryDescription!)</p>"
        }
        return html as String
    }
    
    func createHTMLString() -> String
    {
        // 1. Create a print formatter
        let headerTile:String!="<H3>\(self.varTitle!)</H3><hr width=100%/>"
        
        let html="\(headerTile!)\(self.varRotaryLibraryDescription!)"
        print("HTML Code: \(html)")
        return html as String
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
                if extensionL == "pdf" && filName.contains("Rotary_India_Library_") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) -> NSURL{
        let printPageRenderer:CustomPrintPageRenderer = CustomPrintPageRenderer()
        printPageRenderer.getWebView(webView: self.customeWebView)
        // Specify the frame of the A4 page.
        print("HEIGHT OF PRINT PAGE RENDER :: \(self.customeWebView.frame.height+65.0)")
        let pageFrame = CGRect(x: 0.0, y: 95.0, width: 595.2, height: 510.0)
        // Set the page frame.
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        // Set the horizontal and vertical insets (that's optional).
        printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
        printPageRenderer.addPrintFormatter(self.customeWebView.viewPrintFormatter(), startingAtPageAt: 0)
        
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)

        self.ticksnew = getCurrentDate()
        let fileName:String!="Rotary_India_Library_\(self.ticksnew!)"
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName!).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        pdfData.write(to: outputURL, atomically: true)
        return outputURL as NSURL
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer:CustomPrintPageRenderer) -> NSMutableData {
        let data = NSMutableData()
        let pdfPageBounds =  CGRect(x:0, y:0.0, width:595.2,height:self.view.frame.height)
        UIGraphicsBeginPDFContextToData(data, pdfPageBounds, nil)
        print("printPageRenderer.numberOfPages :: \(printPageRenderer.numberOfPages)")
        print("printPageRenderer.numberOfPages-1 :: \(printPageRenderer.numberOfPages-1)")
        if printPageRenderer.numberOfPages>0
        {
        for i in 0...printPageRenderer.numberOfPages-1 {
            UIGraphicsBeginPDFPage()
            if i==0
            {
                printPageRenderer.drawHeaderForPage(at: i, in: UIGraphicsGetPDFContextBounds())
            }
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
            printPageRenderer.drawHeaderForPage(at: 0, in: UIGraphicsGetPDFContextBounds())

        printPageRenderer.drawFooterForPage(at: printPageRenderer.numberOfPages-1, in: UIGraphicsGetPDFContextBounds())
        UIGraphicsEndPDFContext()
        }
        return data
    }
}
