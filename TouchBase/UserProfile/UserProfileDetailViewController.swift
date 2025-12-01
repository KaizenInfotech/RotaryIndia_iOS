//
//  UserProfileDetailViewController.swift
//  TouchBase
//
//  Created by Kaizen iOS on 08/04/21.
//  Copyright © 2021 Parag. All rights reserved.
//

import UIKit
import CoreTelephony
import SystemConfiguration
import CoreTelephony
import SVProgressHUD
import UIKit
import Alamofire
import Foundation
import SJSegmentedScrollView
import SDWebImage
import SVProgressHUD
class profileDetailTbleViewCell:UITableViewCell
{
    @IBOutlet var profileTitleLbl: UILabel!
    @IBOutlet var profileValueLbl: UILabel!
    @IBOutlet var reportingLbl: UILabel!
    @IBOutlet var reportingEmpCodeLbl: UILabel!
    
    @IBOutlet var reportingValueLbl: UILabel!
}
class UserProfileDetailViewController: UIViewController {
    

    @IBOutlet var footerViewww: UIView!
    @IBOutlet var headerViewww: UIView!
    
    @IBOutlet weak var tbleVieww: UITableView!
    var userProfileDict:NSMutableDictionary=NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbleVieww.reloadData()
        // Do any additional setup after loading the view.
    }
    //MARK:- table view delegate
    override func viewWillAppear(_ animated: Bool) {
//        userProfileDetail()
    }
    
//    func userProfileDetail(){
//        let userProfileUrl:String! = "http://rowtestapi.rosteronwheels.com/V4/api/Member/GetProfile"
//        
//        let para = ["MemberId":"376941"]
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: userProfileUrl, parameters: para, forTask: TaskType.kUserProfileDetailList, currentView: self.view, useAccessToken: false, completionHandler:  {(response: AnyObject) -> Void in
//            let dd = response as! NSDictionary
//            var varGetValueServerError = dd.object(forKey: "message")as? String
//            print(dd)
//            if(varGetValueServerError == "Error")
//            {
//                SVProgressHUD.dismiss()
//            }
//            else
//            {
//                if((((dd.object(forKey: "message")! as AnyObject) as! String) == "Success") && (((dd.object(forKey: "status")! as AnyObject) as! String) == "0"))
//                {
////                    var dictTemporaryDictionary:NSDictionary=((dd.value(forKey: "TBVersionResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: 0)
////                    self.ituneDynamicUrlFromServer=dictTemporaryDictionary.value(forKey: "URL")as! String
////                    var versionNumber:String!=dictTemporaryDictionary.value(forKey: "versionNumber")as! String
////                    self.getUpdateAppVersionPOPUP()
//                    
//                    
//                    self.userProfileDict = ((dd.value(forKey: "result")! as AnyObject).value(forKey: "Table")! as AnyObject).object(at: 0)
//                    print(self.userProfileDict)
//                }
//            }
//        })
//        
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 1 {
//      
//            return 5
//        
//        }
//        else{
//        return 0
//        }
//    }
// 
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:profileDetailTbleViewCell = tableView.dequeueReusableCell(withIdentifier: "profileDetailTbleViewCell", for: indexPath) as! profileDetailTbleViewCell
////        if indexPath.section == 1 {
//            cell.selectionStyle = .none
//            return cell
////        }
////        else
////        {
////            return cell
////        }
////        if indexPath.section == 1 {
//          
//       
////            }
////            cell.selectionStyle = .none
////            return cell
////        }
////
////
////        return cell
//
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 1 {
//       return 70
//        }
//       
//        else{
//        return 0
//        }
//    }
//    
//func tableView(_ tableView: UITableView,
//            viewForHeaderInSection section: Int) -> UIView?  {
//    if section == 0 {
//        return headerViewww
//    }
//    else if section == 2{
//        return footerViewww
//    }
//    else
//    {
//        return nil
//    }
//     }
//func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    if section == 0 {
//        return headerViewww.frame.size.height
//    }
//    else if section == 2{
//        return footerViewww.frame.size.height
//    }
//    else
//    {
//        return 0
//    }
//     }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        
//    }
// 
//    
//    
//func numberOfSections(in tableView: UITableView) -> Int
//{
//   return 3
//}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
