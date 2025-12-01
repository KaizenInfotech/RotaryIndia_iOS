
    import UIKit
    import SVProgressHUD
import WebKit
    class AdminListWebViewViewController: UIViewController, WKNavigationDelegate{
        
        @IBOutlet weak var webViewInfo: WKWebView!

        func webViewDidFinishLoad(_ webView : WKWebView)
        {
            SVProgressHUD.dismiss()
        }
        
        let bounds = UIScreen.main.bounds
        var appDelegate = AppDelegate()
        var moduleName : String! = ""
        var URLstr : String! = ""
        var varTitle:String! = ""
        var varWebViewDescription:String! = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            webViewInfo.backgroundColor = UIColor.white
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            createNavigationBar()
            print("url str \(URLstr)")
            webViewInfo.navigationDelegate = self
            if(URLstr.hasPrefix("Optional("))
            {
                let temp = String(URLstr.dropFirst(10))
                print(temp)
                URLstr = String(temp.dropLast(2))
                print(URLstr)
            }
            print(URLstr)
            print(URLstr!)
            
            let url = URL (string: URLstr!)
            let requestObj = URLRequest(url: url!)
            webViewInfo.load(requestObj)
            let when = DispatchTime.now() + 8
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
                SVProgressHUD.dismiss()
            })
        }
        //fghfthrgdgt hfhtr
        
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
            buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
               decisionHandler(.allow)
            
               guard
                let urlAsString = navigationAction.request.url?.absoluteString.lowercased() else { return }
             print(urlAsString)
            
            if urlAsString.range(of: "the url that the button redirects the webpage to") != nil {
               print(urlAsString)
            } else {
                
                print(urlAsString)
//                if urlAsString.contains("https://weblink.rotaryindia.org/weblink.aspx?id=") {
//                    if let url = URL(string: urlAsString) {
//                        UIApplication.shared.open(url, options: [:]) { success in
//                            print("URL opened: \(success)")
//                        }
//                    }
//
//                }
            }
            }
        
         @objc func backClicked()
        {
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
        @IBAction func buttonLinkOpenClickEvent(_ sender: AnyObject)
        {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
                let objWebViewToUrlOpenViewControllr = self.storyboard?.instantiateViewController(withIdentifier: "WebViewToUrlOpenViewController") as! WebViewToUrlOpenViewController
                objWebViewToUrlOpenViewControllr.isCallFrom = "weblink"
                objWebViewToUrlOpenViewControllr.URLstr = URLstr
                objWebViewToUrlOpenViewControllr.moduleName = moduleName
                self.navigationController?.pushViewController(objWebViewToUrlOpenViewControllr, animated: true)
            }
            else
            {
                SVProgressHUD.dismiss()
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            }
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
}


