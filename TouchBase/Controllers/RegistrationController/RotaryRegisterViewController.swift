//
//  RotaryRegisterViewController.swift
//  TouchBase
//
//  Created by Harshada on 07/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import MessageUI

class RotaryRegisterViewController: UIViewController,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    
//MARK:- Model View Declaration
    
    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var exitView: UIView!

    @IBOutlet weak var rotarianYesView: UIView!

    @IBOutlet weak var rotarianNoView: UIView!

    @IBOutlet weak var txfmainMobNuum: UITextField!

    @IBOutlet weak var btnYesRotarian: UIButton!

    @IBOutlet weak var btnNoRotarian: UIButton!

    @IBOutlet weak var btnYesJoin: UIButton!

    @IBOutlet weak var btnNoJoin: UIButton!
    
    @IBOutlet weak var notRegisteredLbl: UILabel!
    
    @IBOutlet weak var btnMail: UIButton!
    var headTitle = ""
    var supportMail = ""
    //MARK:- Variable declaration

    var isRotarianFlag:String=""
    var isJoinRotaryFlag:String=""
    var varNotRegisteredMobileNumber:String=""
    var varNotRegisteredCode:String=""
    //MARK:- Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        rotaryIndiaRewampRIZoneAPI()
        self.txfmainMobNuum.text=varNotRegisteredCode + "-" +  varNotRegisteredMobileNumber
        createNavigationBar()
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
                                 self.notRegisteredLbl.text = "Is not registered with \(decodedData.registrationResult.result.table[0].applicationNameText)"
                                 self.headTitle = decodedData.registrationResult.result.table[0].applicationNameText
                                 self.supportMail = decodedData.registrationResult.result.table[0].supportMailID
                                 self.btnMail.setTitle(decodedData.registrationResult.result.table[0].supportMailID, for: .normal)
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
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
    }

    //MARK:- Other methods

    func MailAction()
    {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([ self.supportMail])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        }
        else
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = self.headTitle
            alertView.message = "Please check whether you have logged in to your mail account."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
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
    
   func isRotarianCheck(flag:String)
    {
        isRotarianFlag=flag
        if isRotarianFlag==""
        {
            self.rotarianYesView.isHidden=true
            self.rotarianNoView.isHidden=true
        }
        else if isRotarianFlag=="0"
        {
            self.rotarianYesView.isHidden=true
            self.rotarianNoView.isHidden=false
        }
        else if isRotarianFlag=="1"
        {
            self.rotarianYesView.isHidden=false
            self.rotarianNoView.isHidden=true
        }
    }


    //MARK:- Click Action

    @IBAction func btnRotarianYesClickEvent(_ sender: Any) {
        btnYesRotarian.setImage(UIImage(named: "radio_btn_Check"), for: .normal)
        btnNoRotarian.setImage(UIImage(named: "radio_btn_Uncheck"), for: .normal)
         isRotarianCheck(flag:"1")
    }

    @IBAction func btnRotarianNoClickEvent(_ sender: Any) {
        btnYesRotarian.setImage(UIImage(named: "radio_btn_Uncheck"), for: .normal)
        btnNoRotarian.setImage(UIImage(named: "radio_btn_Check"), for: .normal)
        isRotarianCheck(flag:"0")
       }

    @IBAction func btnRotarianYesExitClickEvent(_ sender: Any) {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "splash_screens") as! SplashScreenController
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func btnJoinrotaryYesClickEvent(_ sender: Any) {
        let viewController=self.storyboard?.instantiateViewController(withIdentifier: "SubRegisterViewController") as! SubRegisterViewController
        
        viewController.varMobileNo=varNotRegisteredMobileNumber
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

    @IBAction func btnJoinrotaryNoClickEvent(_ sender: Any) {
        self.mainView.isHidden=true
        self.exitView.isHidden=false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    @IBAction func btnexitViewExitClickEvent(_ sender: Any) {
                let viewController=self.storyboard?.instantiateViewController(withIdentifier: "splash_screens") as! SplashScreenController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func btnMailWebClickEvent(_ sender: Any) {
        MailAction()
    }
}
