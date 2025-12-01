//
//  AboutUsViewController.swift
//  TouchBase
//
//  Created by Umesh on 08/02/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import MessageUI
import Alamofire
class AboutUsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    var appDelegate : AppDelegate!
    var EmailSTR:String =  ""
    @IBOutlet weak var imagRowICon: UIImageView!
    @IBOutlet var labelVersion: UILabel!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var buttonWebsite: UIButton!
    @IBOutlet weak var buttonMobile: UIButton!
    
    var headImg = ""
    var headTitle = ""
    var supportMail = ""
    var websiteURL = ""
    
    override func viewWillAppear(_ animated: Bool) {
        //----code by Rajendra Ja fro session timeout start
        // commonClassFunction().functionForCheckIsSessionTimeoutOrNot()
        //----code by Rajendra Ja fro session timeout end
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        }
        else
        {
            SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        rotaryIndiaRewampRIZoneAPI()
        functionForSetLeftNavigation()
        //First get the nsObject by defining as an optional anyObject
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        //Then just cast the object as a String, but be careful, you may want to double check for nil
        let version = nsObject as! String
        labelVersion.text="version "+version
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
                        self.headImg = decodedData.registrationResult.result.table[0].headerlogo
                        self.supportMail = decodedData.registrationResult.result.table[0].supportMailID
                        self.websiteURL = decodedData.registrationResult.result.table[0].websiteShowURL
                        self.buttonWebsite.setTitle(self.websiteURL, for: .normal)
                        self.buttonEmail.setTitle(self.supportMail, for: .normal)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.loadHeaderLogo(headImg: self.headImg)
                        }
                        
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
    
    func loadHeaderLogo(headImg: String) {
        self.downloadImage(from: headImg) { downloadedImage in
            // Use the downloaded image here
            DispatchQueue.main.async {
                if let image = downloadedImage {
                    // Set the downloaded image to an existing UIImageView
                    self.imagRowICon.image = image
                    print("IMAGE LOADED1")
                } else {
                    // Handle the case where the image couldn't be downloaded
                    print("Failed to download image1")
                }
            }
        }
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Check if the URL is valid
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        // Create a URLSessionDataTask to download the image data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Check if there is data
            guard let data = data else {
                completion(nil)
                return
            }
            
            // Create a UIImage from the downloaded data
            if let image = UIImage(data: data) {
                // Call the completion handler with the downloaded image
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //--set navigation  button left and right
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "\(headTitle) Helpline" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AboutUsViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
    
    @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonMobileClickEvent(_ sender: AnyObject) {
        //let formatedNumber="+919004404397"//+91 8424064369
        let formatedNumber="+918424064369"
        let phoneUrl = "tel://\(formatedNumber)"
        let url:URL = URL(string: phoneUrl)!
        //        UIApplication.shared.openURL(url)
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("The URL was successfully opened.")
                } else {
                    print("Failed to open the URL.")
                }
            }
        }
        
    }
    
    @IBAction func buttonContactClickEvent(_ sender: AnyObject)
    {
        //        let formatedNumber="+912241516999"
        let formatedNumber="+918928755144"
        let phoneUrl = "tel://\(formatedNumber)"
        let url:URL = URL(string: phoneUrl)!
        //        UIApplication.shared.openURL(url)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("The URL was successfully opened.")
                } else {
                    print("Failed to open the URL.")
                }
            }
        }
        
    }
    
    @IBAction func buttonEmailClickEvent(_ sender: AnyObject)
    {
        EmailSTR = supportMail
        print("Email Sent----------\(EmailSTR)")
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([EmailSTR])      // gg@hing.co.in
            mail.setMessageBody("", isHTML: true)
            present(mail, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonWebSiteClickEvent(_ sender: AnyObject)
    {
        if !websiteURL.lowercased().hasPrefix("http://") && !websiteURL.lowercased().hasPrefix("https://") {
            websiteURL = "https://" + websiteURL
            if let requestUrl = URL(string: websiteURL) {
                //            UIApplication.shared.openURL(requestUrl)
                print("requestUrl----------\(requestUrl)")
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
        } else {
            print("Failed to open the URL. HTTP is missing")
        }
        
   
    }
    
    @IBAction func buttonRecommendTB(_ sender: AnyObject)
    {
        let emailTitle = "I recommend this for you"
        let messageBody = "I have been using TouchBase app and found it to be very useful people engagement tool. It is a focused, simplified collaborative app which any organization must have for structured communication. I recommend you to try out TouchBase by clicking the link below. Download TouchBase Now"
        let toRecipents = [Array<Any>]()
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents as! [String])
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}



















