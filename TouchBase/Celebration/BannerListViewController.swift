//
//  BannerListViewController.swift
//  TouchBase
//
//  Created by Kaizen iOS on 08/02/22.
//  Copyright © 2022 Parag. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class BannerListViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource   {

    
    
    var index111:Int = 0
    var bannerListArr:NSArray=NSArray()
    
    @IBOutlet var ListTbleView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForBirthDayAnniversaryEvent()
        createNavigationBarmine()
        print(self.bannerListArr)
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    //MARK:- Table Methods
    func functionForBirthDayAnniversaryEvent()
    {
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            let completeURL:String! = baseUrl+row_GetDashboardBirthAnniEvent
            let parameterst = [
                "MasterId": mainMemberID!
//                "MasterId": "2345672"
//                "MasterId": "43115"

            ]
        
//        let completeURL:String! = "http://rotaryindiaapi.rosteronwheels.com/api/Group/GetNewDashboard"
//        let parameterst = [
//            "MasterId": 370933
////                "MasterId": "2345672"
////                "MasterId": "43115"
//
//        ]
        
        
        
            print(parameterst)
            print(completeURL)
//           print("Banner API Call @ \(Date())")
        
//            DispatchQueue.main.async{
////                self.imgGrayIconROW.isHidden=true
//                self.indicator.startAnimating()
//                self.lblBAEDesc.text!=""
//            }
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 200
//
//        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON()
//
//
        SVProgressHUD.show()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 200

        manager.request(completeURL, method: .post, parameters:parameterst,encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            
//            let sessionConfig = URLSessionConfiguration.default
//            sessionConfig.timeoutIntervalForRequest = 30.0
//            sessionConfig.timeoutIntervalForResource = 60.0
//            let session = URLSession(configuration: sessionConfig)
            
            SVProgressHUD.show()
            
                switch response.result {
                case .success:
                    print("Banner API main response @ \(Date())")
                    if let value = response.result.value {
//                        self.labelFirstTimeSyncMessage.isHidden=true
                        print("22222222This is device token by Rajendra JAt 1 March !!!!!")
                        SVProgressHUD.dismiss()
                        let dd = response.result.value as! NSDictionary
                        var varGetValueServerError = dd.object(forKey: "serverError")as? String
                        
                        if(varGetValueServerError == "Error")
                        {
                            //comment by seema for 5 dec
//                            DispatchQueue.global(qos:.background).async {
//                                self.getBirthDayAnniversaryEventsDetails()
//                            }
                            SVProgressHUD.dismiss()
                        }
                        else
                        {
                            SVProgressHUD.dismiss()
                            print(dd)
                            if((dd.object(forKey: "TBDashboardResult")! as AnyObject).object(forKey: "status") as! String == "0")
                            {
//                                self.functionDashboardBirthAnniEventDelete()
//                                self.muarrayForBirthdayAnniversaryEvent=NSMutableArray()
                                
                                if let subToSubCategoryList = (dd.value(forKey: "TBDashboardResult")! as AnyObject).value(forKey: "Result") as? NSArray
                               {
                                self.bannerListArr=subToSubCategoryList
                               }
//                                self.bannerListArr =  (dd.value(forKey: "TBDashboardResult")! as AnyObject).value(forKey: "Result") as? NSArray

                            print(self.bannerListArr)
                               
                                 print("Banner API Response @ \(Date())")
//                                self.viewPager.scrollToPage(0)
//                                self.viewPager.dataSource = self
//                                self.viewPager.animationNext()
////                                self.imgGrayIconROW.isHidden=true
//                                self.viewPager.reloadData()
//                                self.viewPager.reloadInputViews()
//                                self.indicator.stopAnimating()
                            }
                            else
                            {
//                                self.indicator.stopAnimating()
//                                self.imgGrayIconROW.isHidden=false
                            }
                        }
//                        if self.muarrayForBirthdayAnniversaryEvent.count == 0
//                        {
//                             self.imgGrayIconROW.isHidden=false
//                        }
                    }
//                    else{
//
//                    }
//                    self.labelFirstTimeSyncMessage.isHidden=true
//                    self.view.makeToast("Network issue")
                    print("Rotaryyyy India failed")
                case .failure(_):break
                }
            
            print("Rotaryyyy Indiaaaaa")
            
            }
       
        print("Rotaryyyy Indiaaaaa 1234567890")
    }
    func createNavigationBarmine()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Please Select"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        print(titleDict as? [NSAttributedString.Key : Any])
        self.navigationController?.navigationBar.barTintColor=UIColor.white
//        self.navigationController?.navigationBar.titleTextAttributes = ""
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(BannerListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bannerListArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        let cell = tb.dequeueReusableCell(withIdentifier: "NewDistictMemberCell", for: indexPath) as! NewDistictMemberCell
     
        let cell = ListTbleView.dequeueReusableCell(withIdentifier: "BannerListTbleViewCell", for: indexPath) as! BannerListTbleViewCell
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        let viewShadow = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
//        viewShadow.center = self.view.center
//        cell.mainView.layer.borderWidth = 5
        let GrpCategory = (bannerListArr.value(forKey: "group_category") as AnyObject).object(at: indexPath.row) as! String
        
        print(GrpCategory)
        if GrpCategory == "1" {
            cell.mainView.backgroundColor = UIColor.white
           
            cell.imgVieww.layer.shadowOpacity = 3
            cell.mainView.layer.shadowOffset = CGSize.zero
            cell.mainView.layer.shadowRadius = 10
            index111 = indexPath.row
            cell.mainView.layer.cornerRadius = 15
            cell.mainView.dropShadow(color:.systemBlue, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
            cell.nameLblll.textColor  = UIColor .systemBlue
//            cell.mainView.layer.shadowColor = UIColor(red: 3, green: 169, blue: 244, alpha: 1).cgColor
        }
        else{
//            235,151,27
            cell.mainView.backgroundColor = UIColor.white
            cell.mainView.layer.shadowColor = UIColor(red: 235, green: 151, blue: 27, alpha: 1).cgColor
            cell.imgVieww.layer.shadowOpacity = 3
            cell.mainView.layer.shadowOffset = CGSize.zero
            cell.mainView.layer.shadowRadius = 10
            index111 = indexPath.row
            cell.mainView.layer.cornerRadius = 15
            cell.mainView.dropShadow(color:.orange, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 5, scale: true)
            cell.nameLblll.textColor  = UIColor .orange
//            cell.mainView.layer.shadowColor = UIColor(red: 235, green: 151, blue: 27, alpha: 1).cgColor
        }
        
       

        cell.nameLblll.text = (bannerListArr.value(forKey: "ClubName") as AnyObject).object(at: indexPath.row) as! String
        let varImage = (bannerListArr.value(forKey: "club_image") as AnyObject).object(at: indexPath.row) as! String
        cell.imgVieww.ImageCircle()
        if varImage == ""
        {
            cell.imgVieww.image = UIImage(named: "rt_dash_logo")
        }
        else
        {
            let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            cell.imgVieww.sd_setImage(with: checkedUrl)
            cell.imgVieww.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "rt_dash_logo"))
        }
        
        
//        UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
//        Image("rt_dash_logo")
//        self.view.addSubview(viewShadow)
        
        
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
//        let varBAEType = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Type") as! String
        let clubname = (bannerListArr.object(at: indexPath.row) as AnyObject).value(forKey: "ClubName") as! String
//        let Description = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Description") as! String
//        let Title = (bannerListArr.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "Title") as! String
//        let TodaysCount = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "TodaysCount") as! String
        let ClubCategory = (bannerListArr.object(at: indexPath.row) as AnyObject).value(forKey: "group_category") as! String

        let ClubId: Int = (bannerListArr.object(at: indexPath.row) as AnyObject).value(forKey: "ClubId") as! Int

//        let ProfileId = (bannerListArr.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "ProfileId") as! String
//        let isAdmin = (muarrayForBirthdayAnniversaryEvent.object(at: selectedIndexForSilder) as AnyObject).value(forKey: "IsAdmin") as! String

        //Birthday
//        if(varBAEType=="Birthday")
//        {

//            UserDefaults.standard.setValue(ProfileId, forKey: "user_auth_token_profileId")
            UserDefaults.standard.setValue(ClubId, forKey: "user_auth_token_groupId")
//            UserDefaults.standard.set(isAdmin, forKey: "isAdmin")

//        let x : Int = 42
        var myString = String(ClubId)
        let getProfileId =  UserDefaults.standard.value(forKey: "user_auth_token_profileId")
        let getGroupId =  UserDefaults.standard.value(forKey: "user_auth_token_groupId")
        print( UserDefaults.standard.value(forKey: "user_auth_token_profileId"))
        print(getProfileId)
        
            //Need to Code by Rajendra Sir
            if #available(iOS 13.0, *) {
                let objCelebrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
                print(ClubId)
                objCelebrationViewController.isfromBanner = "yes"
                    objCelebrationViewController.stringGroupID = myString
                    objCelebrationViewController.isCategory=ClubCategory
                    objCelebrationViewController.varType="B"
                    objCelebrationViewController.moduleName="Calendar"
                    objCelebrationViewController.isBirthdayorAnniv="birthday"
                    objCelebrationViewController.isAdmin="yes"
                    self.navigationController?.pushViewController(objCelebrationViewController, animated: true)
            } else {
                // Fallback on earlier versions
            }
//        objCelebrationViewController.stringProfileId = getProfileId as! String
      

            /* objCelebrationViewController.stringProfileId = grpDetailPrevious["grpProfileid"] as! String
             objCelebrationViewController.stringGroupID = dict["groupId"] as! String*/
//        }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
 
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
