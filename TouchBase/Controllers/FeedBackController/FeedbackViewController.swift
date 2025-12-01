//
//  FeedbackViewController.swift
//  TouchBase
//
//  Created by rajendra on 27/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class FeedbackViewController: UIViewController  , UITextViewDelegate , UIGestureRecognizerDelegate{

    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var textviewDescription: UITextView!
    @IBOutlet weak var viewUnderLine: UIView!
    @IBOutlet weak var buttonSend: UIButton!
    
    var moduleName:String! = ""
    var profileID:String! = ""
    var appDelegate : AppDelegate = AppDelegate()
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
//        self.edgesForExtendedLayout = []
        textviewDescription.functionTextViewFullBorder()
        FunctionForTextFieldPlaceHolder()
        buttonSend.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*-------------------------------Navigation bar Setting --------------------------------Start----------------*/
    func createNavigationBar()
    {
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
        buttonleft.addTarget(self, action: #selector(FeedbackViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
     @objc func backClicked()
    {
    self.navigationController?.popViewController(animated: true)
    }
    
    /*----------------------------------------------------------------------------DPK----------------------------*/
    //MARK:- Loader Method
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//        
//    }
    
    
    func FunctionForTextFieldPlaceHolder()
    {
        /*----------------textViewDescription placeholder setting------------------------------------------*/
        
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 30.0
        paragraphStyle.maximumLineHeight = 30.0
        paragraphStyle.minimumLineHeight = 30.0
        let ats = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 17.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        textviewDescription.attributedText = NSAttributedString(string: textviewDescription.text!, attributes: ats)
        textviewDescription.textAlignment = .justified
        
        textviewDescription.delegate = self
        textviewDescription.text = nil
        lblPlaceHolder.text = "Please enter your feedback here. This feedback will be sent to the Rotary India Team. Your suggestions are really appreciated!"
        lblPlaceHolder.textColor = UIColor.lightGray
       // textviewDescription.addSubview(lblPlaceHolder)
       // lblPlaceHolder.frame.origin = CGPoint(x: 5, y: textviewDescription.frame.origin.y)
        lblPlaceHolder.textColor = UIColor(white: 0, alpha: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    
    
    //MARK:- Placehoder in textview
    /*------------------------------placeholder --------------------------------------End----------------*/
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        textviewDescription.resignFirstResponder()
        // handling code
    }
    /*comment by rajendra jat on 11/10/2018
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView==textviewDescription)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                textviewDescription.resignFirstResponder()
                return false
            }
            return true
        }
        return true
    }
    */
    
    /*------------------------------placeholder--------------------------------------End----------------*/
//MARK:- Button Action
    @IBAction func buttonSendFeedBackClickEvent(_ sender: AnyObject)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if(textviewDescription.text! == "")
            {
                self.view.makeToast("Please enter feedback.", duration: 2, position: CSToastPositionCenter)
 
            }
            else
            {
                functionForGetEmailIdForFeedBack(profileID, stringFeedBack: textviewDescription.text!)
            }
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    //MARK:- SERVER CALLING
    func functionForGetEmailIdForFeedBack(_ stringProfileID:String,stringFeedBack:String)
    {
       // loaderViewMethod()
        let completeURL = baseUrl+row_SendFeedback
        let parameterst = [
            "ProfileId" :stringProfileID ,
            "Feedback" :stringFeedBack
        ]
        print(completeURL)
        print(parameterst)
       SVProgressHUD.show()
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let letGetMessage=(response.value(forKey: "FeedbackResult")! as AnyObject).value(forKey: "message") as! String
            let letGetStatus=(response.value(forKey: "FeedbackResult")! as AnyObject).value(forKey: "status") as! String
            if(letGetStatus=="0")
            {
                self.window=nil;
                let alert = UIAlertController(title: "Feedback", message: "Successfully Sent.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                
                let alert = UIAlertController(title: "Feedback", message: "Your Email ID Not Exist!.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
                 self.window = nil
            }
            self.window = nil
            SVProgressHUD.dismiss()
            }
        })
        
    }

}
