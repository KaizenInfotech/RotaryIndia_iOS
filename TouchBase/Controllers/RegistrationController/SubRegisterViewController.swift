//
//  SubRegisterViewController.swift
//  TouchBase
//
//  Created by Harshada on 08/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import Alamofire

class SubRegisterViewController: UIViewController {

    @IBOutlet weak var exitView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var txfFirstName: UITextField!
    @IBOutlet weak var txfLastName: UITextField!
    @IBOutlet weak var txfMobileNumber: UITextField!
    @IBOutlet weak var txfEmailID: UITextField!
    @IBOutlet weak var txfCity: UITextField!
    @IBOutlet weak var txfState: UITextField!
    @IBOutlet weak var txfOccupation: UITextField!
    @IBOutlet weak var txvFeedBack: UITextView!
    
    @IBOutlet weak var websiteBtn: UIButton!
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    var varMobileNo:String=""
    var varFeedBack:String=""
    var webBtn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        txvFeedBack.layer.borderColor=UIColor.lightGray.cgColor
        txvFeedBack.layer.borderWidth=1
        txvFeedBack.layer.cornerRadius=5
        self.myScrollView.contentSize=CGSize(width: self.view.frame.width, height: 738)
    }
    
    func rotaryIndiaRewampRIZoneAPI() {
            
            let completeURL = baseUrl + rIImgText
            
            let parameterst = [:] as [String:Any]
            
            print("RI parameterst:: \(parameterst)")
            print("RI completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(RIImgText.self, from: jsonData)
                                 self.webBtn = decodedData.registrationResult.result.table[0].websiteShowURL
                                 self.websiteBtn.setTitle("FOR MORE DETAILS PLEASE VISIT \(decodedData.registrationResult.result.table[0].websiteShowURL)", for: .normal)
                                 // Access the properties of the decoded data
                                 print("RI Decoded Data:--- \(decodedData)")
                                 // Access individual properties like decodedData.propertyName
                             } catch {
                                 print("Error decoding JSON: \(error)")
                             }
                         }
                case .failure(_): break
                }
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
     func createNavigationBar(){
         self.navigationItem.setHidesBackButton(true, animated: false)

         self.title="Registration"
         let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
         
         let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
         self.navigationController!.navigationBar.titleTextAttributes = attributes
         
         self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
         self.navigationController?.navigationBar.barTintColor=UIColor.white
         
          let buttonleft = UIButton(type: UIButton.ButtonType.custom)
         buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
         buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
         buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
         let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
         self.navigationItem.leftBarButtonItem = leftButton
     }
     
    @objc func backClicked()
     {
      self.navigationController?.popViewController(animated: true)
     }
    
    func isFormValid() -> Bool
    {
        if txfFirstName.text == ""
        {
            self.showToastMSG(message: "Please enter your first name.")
            return false
        }
        if txfLastName.text == ""
        {
            self.showToastMSG(message: "Please enter your last name.")
            return false
        }
        if txfMobileNumber.text == ""
        {
            self.showToastMSG(message: "Please enter your mobile number.")
            return false
        }
        if txfEmailID.text == ""
        {
            self.showToastMSG(message: "Please enter your email ID.")
            return false
        }
        else if !isValidEmail(txfEmailID.text!)
        {
            self.showToastMSG(message: "Please enter valid email ID.")
            return false
        }
        if txfCity.text == ""
        {
            self.showToastMSG(message: "Please enter city.")
            return false
        }
        if txfState.text == ""
        {
            self.showToastMSG(message: "Please enter state.")
            return false
        }
        if txfOccupation.text == ""
        {
            self.showToastMSG(message: "Please enter occupation.")
            return false
        }
        
        if txvFeedBack.text != ""
        {
            varFeedBack=txvFeedBack.text
        }

       return true
    }
    
    func showToastMSG(message:String)
    {
        self.view.makeToast(message, duration: 2, position: CSToastPositionCenter)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
       loadingNotification.color = .clear
       loadingNotification.activityIndicatorColor = .gray
        loadingNotification.show(true)
    }
    
    func hideMBProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    
    //MARK:- Click event
    @IBAction func btnSubmitClickEvent(_ sender: Any) {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            if isFormValid(){
            FunctionForMemberRegistration()
            }
        }
        else
        {
             self.navigationController?.view.makeToast("No internet available.")
        }

    }

    @IBAction func btnExitClickEvent(_ sender: Any) {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "splash_screens") as! SplashScreenController
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func btnWebClickEvent(_ sender: Any) {
        
        if !webBtn.lowercased().hasPrefix("http://") && !webBtn.lowercased().hasPrefix("https://") {
            webBtn = "https://" + webBtn
            if let requestUrl = URL(string: webBtn) {
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
        

    }
    
    //MARK:- Server Calling Function
    func FunctionForMemberRegistration()
    {
      //  loaderViewMethod()
        let completeURL = baseUrl+row_LoginRegistration
        let parameterst =
            ["FirstName": txfFirstName.text!,
             "LastName": txfLastName.text!,
             "MobileNumber": txfMobileNumber.text!,
             "EmailID": txfEmailID.text!,
             "City": txfCity.text!,
             "State": txfState.text!,
             "Occupation": txfOccupation.text!,
             "Feedaback": varFeedBack]
        print(parameterst)
        print(completeURL)
        self.showMBProgress(str: "")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.hideMBProgress()
            }
            else
            {
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            let status = (dictResponseData.object(forKey: "RegistrationResult")! as AnyObject).object(forKey: "status") as! String
            
            if status == "0"
            {
                let alert = UIAlertController(title: "", message: "Registration done successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.myScrollView.isHidden=true
                    self.exitView.isHidden=false
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                }));
                self.present(alert, animated: true, completion: nil)
                self.hideMBProgress()
            }
            else
            {
                self.view.makeToast("Registration Request Failed", duration: 2, position: CSToastPositionCenter)
                self.hideMBProgress()
                }
            }
        })
      }
}
