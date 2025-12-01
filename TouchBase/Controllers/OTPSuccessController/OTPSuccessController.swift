//
//  OTPSuccessController.swift
//  TouchBase
//
//  Created by Kaizan on 15/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
class OTPSuccessController: UIViewController , UITableViewDataSource, UITableViewDelegate , webServiceDelegate {
    
    let loaderClass  = WebserviceClass()
   
    var varGetlastIndex:Int = 0

    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var labelFrom: UILabel!
    
    @IBOutlet weak var labelDistrictName: UILabel!
    
    var groupArray : NSArray = NSArray()
    var  groupNameAndID :NSArray = NSArray()
    
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubMemberName: UILabel!
    let bounds = UIScreen.main.bounds
     @IBOutlet var mobileNumLabel: UILabel!
    @IBOutlet var groupNamesTableView: UITableView!
    
    @IBOutlet var partOfGroupsLabel: UILabel!
    @IBOutlet var headersView: UIView!
    
    
    @IBOutlet weak var buttonNext: UIButton!
    var headImg = ""
    var muarrayForClubDistrictName:NSMutableArray=NSMutableArray()
    var muarrayForGroupId:NSMutableArray=NSMutableArray()
    // var menuTitles  = ["Kaizen Infotech","Thane HillView","Indian Overseas","HDFC"];
          var alertController = UIAlertController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        var lineView:UIView=UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1)
        lineView.backgroundColor = UIColor.lightGray
        buttonNext.addSubview(lineView)
        labelWelcome.isHidden=true
        labelFrom.isHidden=true
        rotaryIndiaRewampRIZoneAPI()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let Mobile_Number = UserDefaults.standard.string(forKey: "session_Mobile_Number")
        let Login_Type = UserDefaults.standard.string(forKey: "session_Login_Type")
        let Country_Code = UserDefaults.standard.string(forKey: "session_Country_Code")
        
        print(mainMemberID!,Mobile_Number!,Login_Type!,Country_Code!)
        
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        wsm.getAllGroupsWelcome(mainMemberID!, mobileno: Mobile_Number!, loginType: Login_Type!)
        self.view.backgroundColor = UIColor.white
//        self.createNavigationBar()
        
        //let masterID = defaults.stringForKey("masterUID")
        
        mobileNumLabel.text = UserDefaults.standard.string(forKey: "mobileNo")
        
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
                                 
                                 
                                 // Access the properties of the decoded data
                                 print("RI Decoded Data123:--- \(decodedData)")
                                 // Access individual properties like decodedData.propertyName
                                 self.groupNamesTableView.reloadData()
                             } catch {
                                 print("Error decoding JSON123: \(error)")
                             }
                         }
                case .failure(_): break
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
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Welcome"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(OTPSuccessController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
       // self.navigationItem.leftBarButtonItem = leftButton
        
/*
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRectMake(0, 0, 60, 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.Right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        buttonlog.setTitle("SKIP", forState: UIControl.State.Normal)
        buttonlog.addTarget(self, action: #selector(OTPSuccessController.skipClicked), forControlEvents: UIControl.Event.TouchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
*/        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func skipClicked(){
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "create_profile") as UIViewController, animated: true)
    }
    
    
    func WelcomeDelegateFunction(_ welcome: WelcomeResult)
    {
        print(welcome.status)
        print(welcome.message)
       
       print(welcome)
         if welcome.status == "0"
        {
            print(welcome.name)
            self.lblClubMemberName.text! = welcome.name as String
            if let username = welcome.name
            {
                print("Username is is is \(username)")
            UserDefaults.standard.setValue(username, forKey: "rotaryusername")
            }
            groupArray = welcome.grpPartResults as NSArray
            var groupNames :  GrpPartResult!
            
            groupNames = groupArray.object(at: 0) as! GrpPartResult
            
            print(groupNames)
            lblClubName.text = groupNames.grpName
            let varGroupID = groupNames.grpId
            
            UserDefaults.standard.setValue(varGroupID, forKey: "grpId")
            print("-------------------------------------------->",groupNames.grpName)
            print(varGroupID)
            let mainMemberID = UserDefaults.standard.string(forKey: "grpId")
            print(mainMemberID)
            if(groupArray.count>1)
            {
                var DistrictName :  GrpPartResult!
                DistrictName = groupArray.object(at: 1) as! GrpPartResult
             labelDistrictName.text = DistrictName.grpName
                let varDistrictName = DistrictName.grpId
                print("-------------------------------------------->",DistrictName.grpName)
                print(varDistrictName)
            }
           
            let defaults = UserDefaults.standard
         
            if let name = defaults.string(forKey: "mobile")
            {
                mobileNumLabel.text = name;
            }
            
            labelWelcome.isHidden=false
            labelFrom.isHidden=false
            
            
            //
            for i in 00..<groupArray.count
            {
                groupNames = groupArray.object(at: i) as! GrpPartResult
                
                let varClubName = groupNames.grpName
                let varGroupID = groupNames.grpId
                self.muarrayForClubDistrictName.add(varClubName as! String)
                self.muarrayForGroupId.add(varGroupID as! String)
                print("222222222222222212121212121212121212121",self.muarrayForClubDistrictName)
                
                
            }
            
            ////
            self.muarrayForClubDistrictName.add("")
            self.muarrayForGroupId.add("")
            
            groupNamesTableView.reloadData()
        }
        else
        {
            groupArray=[]
            partOfGroupsLabel.text = welcome.message
            partOfGroupsLabel.font = UIFont(name: "Roboto-Regular", size: 14)
            groupNamesTableView.reloadData()
        }
        
        ///------
      
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(muarrayForClubDistrictName.count)
        return muarrayForClubDistrictName.count
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
 //       headersView.hidden = false
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 110)
        headerView.backgroundColor = UIColor.white
        
        
        let HeaderLabel = UILabel()
        HeaderLabel.frame = CGRect(x: 0, y: 10, width: self.groupNamesTableView.frame.size.width, height: 100)
        if groupArray.count == 1
        {
            HeaderLabel.text = String(format:"Welcome  \n\n \(self.lblClubMemberName.text!)  ")
        }
        else if groupArray.count > 1
        {
            HeaderLabel.text = String(format:"Welcome  \n\n \(self.lblClubMemberName.text!)  ")
        }
        else
        {
            HeaderLabel.text = String(format:"Welcome  \n\n \(self.lblClubMemberName.text!)  \n ")
        }
        
        HeaderLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        HeaderLabel.textAlignment = NSTextAlignment.center
        HeaderLabel.numberOfLines = 4
        HeaderLabel.textColor = UIColor.black
        headerView.addSubview(HeaderLabel)
       
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = groupNamesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OTPSuccessCell
        
        alertController.dismiss(animated: true, completion: nil)

       // var groupNames :  GrpPartResult!
       // groupNames = groupArray.objectAtIndex(indexPath.row) as! GrpPartResult
        
       // print(groupNames)
        
        cell.GroupNameLabel.text = muarrayForClubDistrictName.object(at: indexPath.row) as! String//groupNames.grpName
        cell.ImageRowLogo.isHidden=true
        cell.GroupNameLabel.isHidden = false
        
//        if(indexPath.row==0)
//        {
//         varGetlastIndex = indexPath.row
//        }
//        
        let varGetArrqayCount:Int=muarrayForClubDistrictName.count
        
        print()
        
        if(varGetArrqayCount-1==indexPath.row)
        {
            print("hello")
         cell.GroupNameLabel.isHidden = true
         cell.ImageRowLogo.isHidden=false
            self.downloadImage(from: headImg) { downloadedImage in
                // Use the downloaded image here
                print("Image From API----123\(self.headImg)")
                DispatchQueue.main.async {
                    if let image = downloadedImage {
                        // Set the downloaded image to an existing UIImageView
                        print("Image From API")
                        cell.ImageRowLogo.image = image
                        print("IMAGE LOADED3")
                    } else {
                        // Handle the case where the image couldn't be downloaded
                        print("Failed to download image3")
                    }
                }
            }

            
        }
      //  let row = indexPath.row
      //  cell.LanguageLabel.text = languagesArray[row]
      //  cell.LanguageLabel.highlightedTextColor =  UIColor.blueColor()
        
     //   cell.CountryImage.image = UIImage(named: languageImagesArray[row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        
    {
        
//        if(indexPath.row==0)
//        {
//            varGetlastIndex = indexPath.row
//        }
//        
       let varGetArrqayCount:Int=muarrayForClubDistrictName.count
//        
        
        
        if(varGetArrqayCount-1==indexPath.row)
        {
          return 200.0;
        }
        else
        {
          return 45.0;
        }
        
        
        
        
        
//        
//        var varGetlastIndex:Int = indexPath.row-1
//        if(indexPath.row-1==varGetlastIndex)
//        {
//            
//            return 400.0;
//            
//        }
//        else
//        {
//            return 35.0;
//        }
        
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
       // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("create_profile") as UIViewController, animated: true) //
        // self.loaderClass.loaderViewMethod()
         SVProgressHUD.show()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "rootDashss") as UIViewController, animated: true)

        })
 
    }
}


