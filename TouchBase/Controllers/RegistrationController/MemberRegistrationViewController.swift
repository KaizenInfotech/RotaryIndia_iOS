//
//  MemberRegistrationViewController.swift
//  TouchBase
//
//  Created by rajendra on 18/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MessageUI
import SVProgressHUD
class MemberRegistrationViewController: UIViewController , UIScrollViewDelegate , UITextFieldDelegate , UITextViewDelegate , UIGestureRecognizerDelegate , MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var textviewFeedBack: UITextView!
    
    @IBOutlet weak var buttonEmailLinkOnPopUpView: UIButton!
    @IBOutlet weak var buttonWebSiteLinkOnPopUpView: UIButton!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    //MARK:- Public variable
    var varNotRegisteredMobileNumber:String! = ""
    var AllMemberCheckUnCheck:String! = ""
    var AllNonSmartPhoneCheckUncheck:String!=""
    var RotarianOrNot:String! = ""
    var EmailSTR  : String =  ""

    //MARK:- User Interface
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var textfieldMobileNumber: UITextField!
    @IBOutlet weak var buttonYesRotarian: UIButton!
    @IBOutlet weak var buttonNoRotarian: UIButton!
    @IBOutlet weak var textfieldMemberName: UITextField!
    @IBOutlet weak var textfieldEmailId: UITextField!
    @IBOutlet weak var textfieldClubName: UITextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    
    @IBOutlet weak var viewForNoRotarianSelect: UIView!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblMailID: UILabel!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmaiID: UILabel!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var lblForMoreDetails: UILabel!
    
    @IBOutlet weak var buttonEmailIdLink: UIButton!
    @IBOutlet weak var buttonWebsiteLink: UIButton!
    @IBOutlet weak var lblEmaiIDForMoreDetails: UILabel!
    @IBOutlet weak var lblWebSiteForMorDetails: UILabel!
    @IBOutlet weak var viewUnderLine1: UIView!
    @IBOutlet weak var viewUnderLine2: UIView!
    @IBOutlet weak var viewUnderLine3: UIView!
    @IBOutlet weak var viewUnderLine4: UIView!
    @IBOutlet weak var viewUnderLine5: UIView!
    @IBOutlet weak var viewUnderLine6: UIView!
    
    
    
    
    // Class Variable
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    
    func FunctionForNoSelectionHiddenUi()
    {
        //viewUnderLine1.hidden = true
        //viewUnderLine2.hidden = true
        viewUnderLine3.isHidden = true
        viewUnderLine4.isHidden = true
        viewUnderLine5.isHidden = true
        viewUnderLine6.isHidden = true
        lblName.isHidden = true
        lblEmaiID.isHidden = true
        lblClubName.isHidden = true
        lblFeedback.isHidden = true
        textfieldMemberName.isHidden = true
        textfieldEmailId.isHidden = true
        textfieldClubName.isHidden = true
        textviewFeedBack.isHidden = true
        labelPlaceHolder.isHidden = true
        lblForMoreDetails.isHidden = true
        buttonEmailIdLink.isHidden = true
        buttonWebsiteLink.isHidden = true
        lblWebSiteForMorDetails.isHidden = true
        lblEmaiIDForMoreDetails.isHidden = true
        
    }
    
    func FunctionForDefaultSelectionShow()
    {
        //viewUnderLine1.hidden = false
        //viewUnderLine2.hidden = false
        viewUnderLine3.isHidden = false
        viewUnderLine4.isHidden = false
        viewUnderLine5.isHidden = false
        viewUnderLine6.isHidden = false
        lblName.isHidden = false
        lblEmaiID.isHidden = false
        lblClubName.isHidden = false
        lblFeedback.isHidden = false
        textfieldMemberName.isHidden = false
        textfieldEmailId.isHidden = false
        textfieldClubName.isHidden = false
        textviewFeedBack.isHidden = false
        if textviewFeedBack.text.count==0{
            labelPlaceHolder.isHidden = false}else{
            labelPlaceHolder.isHidden = true
        }
        lblForMoreDetails.isHidden = false
        buttonEmailIdLink.isHidden = false
        buttonWebsiteLink.isHidden = false
        lblWebSiteForMorDetails.isHidden = false
        lblEmaiIDForMoreDetails.isHidden = false
    }
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Registration"
        createNavigationBar()
        functionForTextFieldLableButtonViewTableScrollViewSetting()
        FunctionForDefaultSelectionShow()
        FunctionByDefaultYesCheck()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Function
    func functionForTextFieldLableButtonViewTableScrollViewSetting()
    {
        
        
        let lbel = UILabel()
        lbel.frame = CGRect(x: 0, y: self.buttonSubmit.frame.size.height-52, width: self.view.frame.size.width, height: 1)
        lbel.backgroundColor =  UIColor.gray
        buttonSubmit.addSubview(lbel)
        //   [UIColor blackColor].CGColor;
        
        
        buttonOK.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonWebsiteLink.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonEmailIdLink.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonWebSiteLinkOnPopUpView.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonEmailLinkOnPopUpView.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonSubmit.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
    
        
        //Feedback PlaceHolder
        textviewFeedBack.delegate = self
        labelPlaceHolder.text = "Enter Feedback"
        labelPlaceHolder.textColor = UIColor.lightGray
        textviewFeedBack.addSubview(labelPlaceHolder)
        labelPlaceHolder.frame.origin = CGPoint(x: 5, y: textviewFeedBack.font!.pointSize / 2)
        labelPlaceHolder.textColor = UIColor(white: 0, alpha: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(MemberRegistrationViewController.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)

        //View Setting
        viewForNoRotarianSelect.isHidden = true
        buttonOpticity.isHidden = true
        //Common
        AllMemberCheckUnCheck = "Unchecked"
        AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
        RotarianOrNot = "Yes"
        //TextField Setting
        textfieldMobileNumber.delegate = self
        textfieldEmailId.delegate = self
        textfieldClubName.delegate = self
        textfieldMemberName.delegate = self
//        textfieldMemberName.functionTextFieldFullBorder()
//        textfieldEmailId.functionTextFieldFullBorder()
//        textfieldClubName.functionTextFieldFullBorder()
//        textfieldMobileNumber.functionTextFieldFullBorder()
        textfieldMobileNumber.text! = varNotRegisteredMobileNumber
        //TextView Setting
        textviewFeedBack.functionTextViewFullBorder()
        //ScrollView Setting
        self.myScrollView.delegate = self
        self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+200)
    }

    func textViewDidBeginEditing(_ textView: UITextView)
 {
    if(textView==textviewFeedBack)
    {
        //animateViewMoving(true, moveValue: 100)
    }
    else
    {
        //animateViewMoving(true, moveValue: 100)
    }
    
 }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if(textView==textviewFeedBack)
        {
            //animateViewMoving(true, moveValue: -100)
        }
        else
        {
            //animateViewMoving(true, moveValue: 100)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        if(textField==textfieldMemberName)
        {
            //animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldMobileNumber)
        {
            //animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldEmailId)
        {
            //animateViewMoving(true, moveValue: 90)
        }
        else if(textField==textfieldClubName)
        {
          //animateViewMoving(true, moveValue: 165)
        }
        else
        {
        //animateViewMoving(true, moveValue: 100)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if(textField==textfieldMemberName)
        {
            //animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldMobileNumber)
        {
            //animateViewMoving(true, moveValue: 0)
        }
        else if(textField==textfieldEmailId)
        {
            //animateViewMoving(true, moveValue: -90)
        }
        else if(textField==textfieldClubName)
        {
            //animateViewMoving(true, moveValue: -165)
        }
        else
        {
            //animateViewMoving(true, moveValue: 100)
        }
    }

    
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textfieldMobileNumber.resignFirstResponder()
        textfieldMemberName.resignFirstResponder()
        textfieldClubName.resignFirstResponder()
        textfieldEmailId.resignFirstResponder()
        return true
    }
    
    //MARK:- Placehoder in textview
    /*------------------------------placeholder --------------------------------------End----------------*/
    
    func textViewDidChange(_ textView: UITextView) {
        if textView==textviewFeedBack{
            if  textView.text.count==0
            {
         labelPlaceHolder.isHidden = false
            }
            else
            {
         labelPlaceHolder.isHidden = true
            }
         
        }
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        textviewFeedBack.resignFirstResponder()
        textfieldMobileNumber.resignFirstResponder()
        textfieldMemberName.resignFirstResponder()
        textfieldClubName.resignFirstResponder()
        
        // handling code
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView==textviewFeedBack)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                textviewFeedBack.resignFirstResponder()
                return false
            }
            return true
        }
        return true
    }
    /*------------------------------placeholder--------------------------------------End----------------*/
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Registration"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MemberRegistrationViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
     @objc func backClicked()
    {
        viewForNoRotarianSelect.isHidden = true
        buttonOpticity.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    func FunctionByDefaultYesCheck()
    {
         buttonYesRotarian.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
        AllMemberCheckUnCheck = "Checked"
        AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
    }
    //MARK:- Click Event
    
    
    func MailAction()
    {
        EmailSTR = "support@rotaryindia.org"
        print("Email Sent")
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([EmailSTR])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please check whether you have logged in to your mail account."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()

        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func buttonWebsiteForMoreDetailsClickEvent(_ sender: AnyObject)
    {
        if let requestUrl = URL(string: "http://rotaryindia.org/") {
//            UIApplication.shared.openURL(requestUrl)
            
               if UIApplication.shared.canOpenURL(requestUrl) {
                    UIApplication.shared.open(requestUrl, options: [:]) { success in
                        if success {
                            print("The URL was successfully opened.")
                        } else {
                            print("Failed to open the URL.")
                        }
                    }
                }
            
        }
    }
    
    @IBAction func buttonEmailIDForMoreDetailsClickEvent(_ sender: AnyObject)
    {
        MailAction()
    }
    
    
    
    @IBAction func buttonWebsiteClickEventOnPopUp(_ sender: AnyObject) {
        if let requestUrl = URL(string: "http://rotaryindia.org/") {
//            UIApplication.shared.openURL(requestUrl)
            
            if UIApplication.shared.canOpenURL(requestUrl) {
                 UIApplication.shared.open(requestUrl, options: [:]) { success in
                     if success {
                         print("The URL was successfully opened.")
                     } else {
                         print("Failed to open the URL.")
                     }
                 }
             }
        }
    }
    @IBAction func buttonEmailIDClickEventOnPOpUp(_ sender: AnyObject)
    {
        MailAction()
    }
    
    
    
    @IBAction func buttonYesRotarianClickEvent(_ sender: AnyObject)
    {
        if(AllMemberCheckUnCheck == "Unchecked" )
        {
            buttonYesRotarian.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
            buttonNoRotarian.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
            AllMemberCheckUnCheck = "Checked"
            AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
            RotarianOrNot = "Yes"
            FunctionForDefaultSelectionShow()
            
            buttonSubmit.setTitle("Submit",  for: UIControl.State.normal)
           // val = "1"
        }
        else if(AllMemberCheckUnCheck == "Checked")
        {
            buttonYesRotarian.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
            AllMemberCheckUnCheck = "Unchecked"
            //val = "0"
        }
        self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+200)

    }
    @IBAction func buttonNoRotarianClickEvent(_ sender: AnyObject)
    {
        if(AllNonSmartPhoneCheckUncheck == "AllNonSmartUserUnCheck" )
        {
            buttonNoRotarian.setImage(UIImage(named: "radio_btn_Check.png"),  for: UIControl.State.normal)
            buttonYesRotarian.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
            AllNonSmartPhoneCheckUncheck = "Checked"
            AllMemberCheckUnCheck = "Unchecked"
            RotarianOrNot = "No"
            FunctionForNoSelectionHiddenUi()
            viewForNoRotarianSelect.isHidden = false
            buttonOpticity.isHidden = false
           // val = "1"
        }
        else if(AllNonSmartPhoneCheckUncheck == "Checked")
        {
            buttonNoRotarian.setImage(UIImage(named: "radio_btn_Uncheck.png"),  for: UIControl.State.normal)
            AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
           // val = "0"
        }
        self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)

    }
    @IBAction func buttonSubmitClickEvent(_ sender: AnyObject)
    {
        if(buttonSubmit.titleLabel?.text! == "Exit")
        {
         exit(0)
        }
        else
        {
            if(textfieldMemberName.text! == "")
            {
                self.view.makeToast("Please enter name", duration: 2, position: CSToastPositionCenter)
            }
            else if(textfieldEmailId.text! == "")
            {
                self.view.makeToast("Please enter email ID", duration: 2, position: CSToastPositionCenter)
                
            }
            else if (textfieldEmailId.text?.isEmail == false)
            {
                self.view.makeToast("Please enter valid email ID", duration: 2, position: CSToastPositionCenter)
  
            }
            else if(textfieldClubName.text! == "")
            {
                self.view.makeToast("Please enter club name", duration: 2, position: CSToastPositionCenter)
                
            }
            else
            {
              FunctionForMemberRegistration()
            }
            
        }
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textfieldMemberName.resignFirstResponder()
//        textfieldEmailId.resignFirstResponder()
//        textfieldClubName.resignFirstResponder()
//        textfieldMobileNumber.resignFirstResponder()
//        return true
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        resignFirstResponder()
    }
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject) {
    }
    
    @IBAction func buttonOkClickEvent(_ sender: AnyObject) {
        buttonOpticity.isHidden = true
        viewForNoRotarianSelect.isHidden = true
        buttonSubmit.setTitle("Exit",  for: UIControl.State.normal)
    
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
    
    //MARK:- Server Calling Function
    func FunctionForMemberRegistration()
    {
      //  loaderViewMethod()
        let completeURL = baseUrl+row_LoginRegistration
        let parameterst = ["MobileNo":textfieldMobileNumber.text!,"IsRotarian":RotarianOrNot,"Name":textfieldMemberName.text!,"Email":textfieldEmailId.text!,"Club":textfieldClubName.text!,  "Feedback":textviewFeedBack.text!]
        print(parameterst)
        print(completeURL)
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
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            let status = (dictResponseData.object(forKey: "RegistrationResult")! as AnyObject).object(forKey: "status") as! String
            
            if status == "0"
            {
                let alert = UIAlertController(title: "Registration", message: "Registration Request success.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
                
                
                //let memberRegiSuccess = self.storyboard?.instantiateViewControllerWithIdentifier("rootDash") as! RootDashViewController
                //self.navigationController?.pushViewController(memberRegiSuccess, animated: true)
                
                //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true)

                 self.window = nil
                SVProgressHUD.dismiss()
            }
            else
            {
                self.view.makeToast("Registration Request Failed", duration: 2, position: CSToastPositionCenter)
                 self.window = nil
                SVProgressHUD.dismiss()
            }
            
            self.window = nil
            
            }
        })
      }
   }
