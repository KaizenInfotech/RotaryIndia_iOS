////
////  WebSiteOpenUrlViewController.swift
////  myappp
////
////  Created by deepak on 22/04/17.
////  Copyright © 2017 kaizen. All rights reserved.
////
//
//import UIKit
//import SVProgressHUD
//import WebKit
//class WebSiteOpenUrlViewController: UIViewController {
//    var appDelegate : AppDelegate!
//    var varOpenUrl:String!=""
//    var navTitle = ""
////    @IBOutlet weak var indicator: UIActivityIndicatorView!
//    @IBOutlet weak var webviewOprnrl: WKWebView!
//
//    var activityIndicator = UIActivityIndicatorView()
//    var strLabel = UILabel()
//    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.activityIndicator("Loading Please Wait")
//        self.navigationController?.isNavigationBarHidden = false
//
//
//
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//
//            let url = URL (string: self.varOpenUrl)
//        print(self.varOpenUrl)
//            if let urlReq = url {
//                let requestObj = URLRequest(url: urlReq)
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.webviewOprnrl.load(requestObj)
//                    self.effectView.removeFromSuperview()
//                }
//            }
//
//        createNavigationBar()
//
//
//        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
//        {
//
//        }
//        else
//        {
//            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
//
//            SVProgressHUD.dismiss()
//        }
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if navigationAction.navigationType == .formSubmitted {
//            print("Button clicked!")
//        }
//        decisionHandler(.allow)
//    }
//
//
//
//    func createNavigationBar()
//    {
//        self.navigationItem.setHidesBackButton(true, animated: false)
//
//        self.title = navTitle
//        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
//        self.navigationController!.navigationBar.titleTextAttributes = attributes
//
//        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        self.navigationController?.navigationBar.barTintColor=UIColor.white
//
//        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
//        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
//        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
//        buttonleft.addTarget(self, action: #selector(DirectoryViewController.backClicked), for: UIControl.Event.touchUpInside)
//        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
//        self.navigationItem.leftBarButtonItem = leftButton
//        self.view.addSubview(buttonleft)
//
//    }
//    @objc func backClicked()
//    {
//        self.navigationController?.popViewController(animated: true)
//
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func activityIndicator(_ title: String) {
//        strLabel.removeFromSuperview()
//        activityIndicator.removeFromSuperview()
//        effectView.removeFromSuperview()
//        strLabel = UILabel(frame: CGRect(x: view.frame.minX + ((UIScreen.main.bounds.size.width / 4) + 30), y: view.frame.midY, width: 200, height: 60))
//        strLabel.text = title
//        strLabel.font = .systemFont(ofSize: 17, weight: .bold)
//        strLabel.textColor = UIColor.black
//        effectView.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//        effectView.layer.masksToBounds = true
//        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
//        activityIndicator.frame = CGRect(x: view.frame.minX + (UIScreen.main.bounds.size.width / 6), y: view.frame.midY, width: 30, height: 60)
//        activityIndicator.startAnimating()
//        effectView.contentView.addSubview(activityIndicator)
//        effectView.contentView.addSubview(strLabel)
//        view.addSubview(effectView)
//    }
//}


import UIKit
import WebKit
import SVProgressHUD

class WebSiteOpenUrlViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var varOpenUrl: String! = ""
    var navTitle = ""
    var webView: WKWebView!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        // Configure WKWebView with JavaScript enabled
//        let webConfiguration = WKWebViewConfiguration()
//        webConfiguration.preferences.javaScriptEnabled = true
        
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true // Allow JavaScript content
                
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.defaultWebpagePreferences = webpagePreferences
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        javaBtnAction()
        view.addSubview(webView)
        
        // Auto-layout the webview
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Show activity indicator
        self.activityIndicator("Loading Please Wait")
        self.navigationController?.isNavigationBarHidden = false
        
        if let url = URL(string: self.varOpenUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("Invalid URL: \(self.varOpenUrl ?? "")")
        }
        
        createNavigationBar()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.effectView.removeFromSuperview()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
        self.effectView.removeFromSuperview()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
               if let mapURL = navigationAction.request.url {
                   // If it's a valid URL, allow the navigation
                   print("Opening URL: \(mapURL)")
                   decisionHandler(.allow)
               } else {
                   // If the URL is invalid, cancel the navigation
                   print("Invalid URL or handling differently")
                   decisionHandler(.cancel)
               }
           } else {
               // For other types of navigation actions, allow them to continue
               print("Loading request: \(navigationAction.request)")
               decisionHandler(.allow)
           }
    }

    
    func createNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = navTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let buttonLeft = UIButton(type: .custom)
        buttonLeft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonLeft.setImage(UIImage(named: "back_btn_blue"), for: .normal)
        buttonLeft.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: buttonLeft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: view.frame.minX + ((UIScreen.main.bounds.size.width / 4) + 30), y: view.frame.midY, width: 200, height: 60))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 17, weight: .bold)
        strLabel.textColor = UIColor.black
        
        effectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: view.frame.minX + (UIScreen.main.bounds.size.width / 6), y: view.frame.midY, width: 30, height: 60)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    func javaBtnAction() {
        // Button to trigger JavaScript evaluation
        let debugButton = UIButton(type: .system)
        debugButton.setTitle("Run JS", for: .normal)
        debugButton.addTarget(self, action: #selector(runJavaScript), for: .touchUpInside)
        view.addSubview(debugButton)
        
        // Auto-layout the button
        debugButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            debugButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            debugButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    @objc func runJavaScript() {
        let jsCode = "document.querySelector('button').click();" // Adjust the selector as needed
        webView.evaluateJavaScript(jsCode) { (result, error) in
            if let error = error {
                print("JavaScript evaluation error: \(error.localizedDescription)")
            } else {
                print("JavaScript result: \(result ?? "No result")")
            }
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        })

        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Confirm", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler(true)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let input = alertController.textFields?.first?.text
            completionHandler(input)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
}
