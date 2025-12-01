//
//  ClassificationMemberListViewController.swift
//  TouchBase
//
//  Created by rajendra on 25/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
class ClassificationMemberListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableClassificationMemberList: UITableView!
    
    var groupID:String!=""
    var classificationText:String!=""
    var classiMembers: ClassificationMember?
    
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate!
    var muarrayForGetList:NSMutableArray=NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        functionForGetClassificationMemberList()
        loadClassiMemberList(id: self.groupID, classi: self.classificationText)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Navigation setting
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Directory"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ClassificationMemberListViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadClassiMemberList(id: String?, classi: String?) {
            
            if let grpIdd = id, let classifi = classi {
                
                let completeURL = baseUrl + dirClassificationMemberList
                
                let parameterst = ["grpID":grpIdd,"classification":classifi]
                
                print("Club Online Directory parameterst:: \(parameterst)")
                print("Club Online Directory completeURL:: \(completeURL)")
                
                //------------------------------------------------------
                Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    switch response.result {
                    case .success:
                        
                        
                             if let value = response.result.value {
                                 do {
                                     // Attempt to decode the JSON data
                                     let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                     let decoder = JSONDecoder()
                                     let decodedData = try decoder.decode(ClassificationMember.self, from: jsonData)
                                     
                                     // Access the properties of the decoded data
                                     print("Decoded Data:--- \(decodedData)")
                                     self.classiMembers = decodedData
                                     SVProgressHUD.dismiss()
                                     self.tableClassificationMemberList.reloadData()
                                     // Access individual properties like decodedData.propertyName
                                 } catch {
                                     print("Error decoding JSON: \(error)")
                                 }
                             }
                    case .failure(_): break
                    }
                }
            }
        }
    
    
    //MARK:- Table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return muarrayForGetList.count
    }
    
    @objc func buttonPicBigViewClickEvent(_ sender:UIButton)
    {
         let isUpperImageAvailable = (muarrayForGetList.value(forKey: "pic") as AnyObject).object(at: sender.tag) as! String
        
       // let  directoryList = mainArray[sender.tag] as! NSDictionary
        //let isUpperImageAvailable = directoryList.objectForKey("profilePic") as? String
        
        print(isUpperImageAvailable)
        print("Clicked !!")
        if(isUpperImageAvailable.characters.count>10)
        {
            print(isUpperImageAvailable)
            print("available")
            let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
            objImageFullViewViewController.varGetImageUrl=isUpperImageAvailable
            self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
        }
        else
        {
            print("User image is not available !!")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableClassificationMemberList.dequeueReusableCell(withIdentifier: "ClassificationCustomTableViewCell", for: indexPath) as! ClassificationCustomTableViewCell
            
        cell.userName.text! = self.classiMembers?.memberListResult.result[indexPath.row].memberName ?? ""
        cell.userMobileNumber.text! = self.classiMembers?.memberListResult.result[indexPath.row].clubName ?? ""
                print((muarrayForGetList.value(forKey: "pic") as AnyObject).object(at: indexPath.row) as! String)
        if self.classiMembers?.memberListResult.result[indexPath.row].pic == ""
        {
            cell.imgProfile.image = UIImage(named: "profile_pic")
        }
        else
        {
      
            //let url = NSURL(string: varGetImage!)
            
            let ImageProfilePic:String = self.classiMembers?.memberListResult.result[indexPath.row].pic.replacingOccurrences(of: " ", with: "%20") ?? ""
            let checkedUrl = URL(string: ImageProfilePic)
            cell.imgProfile.sd_setImage(with: checkedUrl)
        }
                
                
                 cell.buttonPicBigView.tag=indexPath.row
                 cell.buttonPicBigView.isHidden=false
                 cell.buttonPicBigView.addTarget(self, action: #selector(ClassificationMemberListViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//            let  memberName = ((muarrayForGetList.value(forKey: "memberName") as AnyObject).object(at: indexPath.row) as! String)
//            let  membermobile = ((muarrayForGetList.value(forKey: "membermobile") as AnyObject).object(at: indexPath.row) as! String)
//            let  masterUID = ((muarrayForGetList.value(forKey: "masterUID") as AnyObject).object(at: indexPath.row) as! String)
//            let  pic = ((muarrayForGetList.value(forKey: "pic") as AnyObject).object(at: indexPath.row) as! String)
//            let  profileID = ((muarrayForGetList.value(forKey: "profileID") as AnyObject).object(at: indexPath.row) as! String)
//            let  grpID = ((muarrayForGetList.value(forKey: "grpID") as AnyObject).object(at: indexPath.row) as! String)
//            print(memberName,membermobile,masterUID,pic,profileID,grpID)
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
//            obj.userName=memberName
//            obj.userMobileNumber=membermobile
//            obj.userProfile=pic
        obj.selectedMemberProfileID=self.classiMembers?.memberListResult.result[indexPath.row].profileID
            obj.groupID=self.classiMembers?.memberListResult.result[indexPath.row].grpID
            self.navigationController?.pushViewController(obj, animated: true)
    }
    
   
    


    //MARK:- Server Calling
    func functionForGetClassificationMemberList()
    {
        
       // loaderClass.loaderViewMethod()
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
        var  completeURL:String!=""
        completeURL = baseUrl+"District/GetMemberByClassification"
        let parameterst = ["classification": classificationText,"grpID":self.groupID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print(dd)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "MemberListResult")! as AnyObject).value(forKey: "status") as! String == "0" )
            {
                
                for i in 0 ..< ((((dd.value(forKey: "MemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "profileID")! as AnyObject).count)
                {
                    let result = ((dd.value(forKey: "MemberListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: i)
                    self.muarrayForGetList.add(result)
                }
                if(self.muarrayForGetList.count>0)
                {
                    self.tableClassificationMemberList.reloadData()
                }
                
                self.loaderClass.window=nil
            }
            else
            {
                self.loaderClass.window=nil
            }
            SVProgressHUD.dismiss()
            }
        })
    }

}
