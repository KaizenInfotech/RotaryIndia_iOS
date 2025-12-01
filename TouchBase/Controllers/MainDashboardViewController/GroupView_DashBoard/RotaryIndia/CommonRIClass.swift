//
//  CommonRIClass.swift
//  TouchBase
//
//  Created by IOS on 22/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

@objc protocol RIServerDelegate
   {
    @objc optional func OnReceiveAnnounceResult(announceResult:NSDictionary)
    @objc optional func OnReceiveEventResult(EvenResult:NSDictionary)
    @objc optional func OnReceiveDocumentResult(DocumentResult:NSDictionary)
    @objc optional func OnReceiveNewsLetterResult(NewsLetterResult:NSDictionary)
   }

class CommonRIClass
{
    var uiVC:UIViewController=UIViewController()
    var riServerDelegate:RIServerDelegate?
   
    
    func setNavigationBar(moduleName:String,uiVC:UIViewController)
   {
        self.uiVC=uiVC
        uiVC.title=moduleName
        uiVC.navigationItem.setHidesBackButton(true, animated: false)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        uiVC.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        uiVC.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        uiVC.navigationController?.navigationBar.barTintColor = UIColor.white
        uiVC.navigationController?.navigationBar.tintColor = UIColor.white
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        uiVC.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func backClicked()
    {
      uiVC.navigationController?.popViewController(animated: true)
        
      if uiVC is RIDocumentListVC
      {
        if((uiVC.presentingViewController) != nil){
            uiVC.dismiss(animated: false, completion: nil)
            print("done")
        }
      }
    }

    func getModuleListFromServer(fromYear:String,toYear:String)
    {
        var mainMemberID:String=""
        
        if let mainMemberIDs = UserDefaults.standard.string(forKey: "masterUID")
        {
            mainMemberID=mainMemberIDs
        }
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            var completeURL:String!=baseUrl
            var parameters:[String:String] = [String:String]()
            switch uiVC {
            case is RIAnnouncementListVC:
                completeURL = completeURL+"Announcement/RotaryIndiaAnnouncementlist"
                parameters = [
                "memberProfileId":mainMemberID,
                "groupId":"-1",
                "searchText":"",
                "type":"1",
                "isAdmin":"1"
                ]
                break
            case is RIEventsListVC:
                completeURL = completeURL+"Event/RotaryIndiaGetEventList"
                parameters = [
                "groupProfileID":mainMemberID,
                "grpId":"-1",
                "Type":"1",
                "Admin":"1",
                "searchText":""
                ]
                break
            case is RIDocumentListVC:
                completeURL = completeURL+"DocumentSafe/RotaryIndiaGetDocumentList"
                parameters = [
                "memberProfileId": mainMemberID,
                "grpID":"-1",
                "searchText":"",
                "type":"1",
                "isAdmin":"1"
                ]
                break
            case is RINewsLetterListVC:
                completeURL = completeURL+"Ebulletin/RotaryIndiaNewsletterlist"
                parameters = [
                "fromYear":fromYear,
                "toYear":toYear,
                "memberProfileId":mainMemberID,
                "groupId":"-1"
                ]
                break
            default:
                break
            }
           
            SVProgressHUD.show()
            print(completeURL)
            print(parameters)
            Alamofire.request(completeURL,method: .post, parameters: parameters, encoding: URLEncoding.default, headers:nil).responseJSON { response in
                SVProgressHUD.dismiss()
                if let resultData = response.result.value as? NSDictionary
                {
                    switch self.uiVC {
                    case is RIAnnouncementListVC:
                        self.riServerDelegate?.OnReceiveAnnounceResult?(announceResult: resultData)
                        break
                    case is RIEventsListVC:
                        self.riServerDelegate?.OnReceiveEventResult?(EvenResult: resultData)
                        break
                    case is RIDocumentListVC:
                        self.riServerDelegate?.OnReceiveDocumentResult?(DocumentResult: resultData)
                        break
                    case is RINewsLetterListVC:
                        self.riServerDelegate?.OnReceiveNewsLetterResult?(NewsLetterResult: resultData)
                    default:
                        break
                    }
                }
            }
            
        }
        else
        {
            uiVC.navigationController?.view.makeToast("No internet access.", duration: 2, position: CSToastPositionCenter)
        }
    }
}
