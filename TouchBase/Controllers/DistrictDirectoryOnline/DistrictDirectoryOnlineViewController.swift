//
//  DistrictDirectoryOnlineViewController.swift
//  TouchBase
//
//  Created by rajendra on 22/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import Alamofire
class DistrictDirectoryOnlineViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var noRecrdLbl: UILabel!
    @IBOutlet weak var buttonOptocity: UIButton!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var pickerViews: UIPickerView!
    @IBOutlet weak var viewForPicker: UIView!
    var mainArraySettingForPicker = NSArray()
    var varGetPickerSelectValue:String! = ""
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var buttonFilter: UIButton!
    @IBOutlet weak var tableDistrictDirectoryList: UITableView!
    var muarrayForGetList:NSMutableArray=NSMutableArray()
    var groupID:String!=""
    var muarrayForGetClassifcationList:NSMutableArray=NSMutableArray()
    var districtmemberDetailMemberName: [Result]?
    var tfCount = 0
    var pageIndex = 1
    //For Pagination
    var isDataLoading:Bool=true
    var pageNo:Int=1
    var limit:Int=0
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false
    var searchORNot :String=""
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate!
    var isAdminss = ""
    var dirOnline: DistDirectoryOnline?
    
    var memberFilterName = [String]()
    var clubFilterName = [String]()
    var imgFilterName = [String]()
    var memMobileFilterName = [String]()
    var profileIDFilterName = [String]()
    var grpIDFilterName = [String]()
    
    var classOnline: DirectoryClassificationOnline?
    var classiDetailMemberName: [Resultses]?
    var filterdsgns = [String]()
    var classiList = [String]()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let iconWidth = 20;
        let iconHeight = 20;
        textfieldSearch.placeholder=" Search Rotarian"
        //Define the imageView
        let imageView = UIImageView();
        let imageEmail = UIImage(named: "searchNew.png");
        imageView.image = imageEmail;
        // set frame on image before adding it to the uitextfield
        imageView.frame = CGRect(x: 10, y: 8, width: iconWidth, height: iconHeight)
        textfieldSearch.leftViewMode = UITextField.ViewMode.always
        textfieldSearch.addSubview(imageView)
        noRecrdLbl.isHidden = true
        
        
        
        //set Padding
        let paddingView = UIView(frame: CGRect(x:0, y:0,width: 25,height: self.textfieldSearch.frame.height))
        textfieldSearch.leftView = paddingView
        
        
        createNavigationBar()
        buttonOptocity.isHidden=true
        viewForPicker.isHidden=true
        mainArraySettingForPicker = ["Rotarian" , "Classification"]
        textfieldSearch.delegate=self
        textfieldSearch.returnKeyType = .search
        textfieldSearch.layer.cornerRadius = 15.0
        textfieldSearch.layer.borderColor = UIColor.lightGray.cgColor
        textfieldSearch.layer.borderWidth = 1.0
        textfieldSearch.layer.masksToBounds = true
        buttonFilter.layer.cornerRadius = 13.0
        buttonFilter.layer.borderColor = UIColor.lightGray.cgColor
        buttonFilter.layer.borderWidth = 1.0
        buttonFilter.layer.masksToBounds = true
//        self.edgesForExtendedLayout=[]
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
       // loaderClass.loaderViewMethod()
        functionForGetDistrictMemberList(String(1),pagelimit: String(100))

             loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
             
        }
        else
        {
            
            
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tfCount = 0
        textfieldSearch.text=""
        textfieldSearch.resignFirstResponder()
        self.filterdsgns.removeAll()
        self.memberFilterName.removeAll()
        loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
    }
    
    func apiData(searchTxt: String) {
        if let grpIdd = self.groupID {
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
            let url = baseUrl + distdirectoryOnline
            var request = URLRequest(url: URL(string:url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: Any] = [
                "pageNo": "",
                "masterUID": mainMemberID,
                "grpID": grpIdd,
                "recordCount": "100",
                "searchText": searchTxt
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print("Error serializing JSON: \(error)")
                return
            }
            
            // Create a URLSession data task
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error making request: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    self.memberFilterName.removeAll()
                    self.clubFilterName.removeAll()
                    self.imgFilterName.removeAll()
                    self.memMobileFilterName.removeAll()
                    self.profileIDFilterName.removeAll()
                    self.grpIDFilterName.removeAll()
                      if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                         let members = json["Result"] as? [[String: Any]] {
                          // Extract member names
                          let memberNames = members.compactMap { $0["memberName"] as? String }
                          print("Member Names: \(memberNames)")
                          self.memberFilterName.append(contentsOf: memberNames)
                          print("memberFilterName-------\(self.memberFilterName)")
                          let clubNames = members.compactMap { $0["club_name"] as? String }
                          print("club_name: \(clubNames)")
                          self.clubFilterName.append(contentsOf: clubNames)
                          let imgNames = members.compactMap { $0["pic"] as? String }
                          print("imgNames: \(imgNames)")
                          self.imgFilterName.append(contentsOf: imgNames)
                          let memMobile = members.compactMap { $0["membermobile"] as? String }
                          self.memMobileFilterName.append(contentsOf: memMobile)
                          let proID = members.compactMap { $0["profileID"] as? String }
                          self.profileIDFilterName.append(contentsOf: proID)
                          let grpID = members.compactMap { $0["grpID"] as? String }
                          self.grpIDFilterName.append(contentsOf: grpID)
                          
                      }
                  } catch let error {
                    print("Error parsing JSON: \(error)")
                }
                print("self.memberFilterName.count--------------------: \(self.memberFilterName.count)")
                DispatchQueue.main.async {
                    if self.memberFilterName.count == 0 {
                        self.noRecrdLbl.isHidden = false
                    }
                    self.tableDistrictDirectoryList.reloadData()
                }
            }
            task.resume()
        }
 }
    
    func loadDistrictDirectoryList(_ pageNumber:String , pagelimit:String, searchTxt:String) {
        
        if let grpIdd = self.groupID {
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
            let completeURL = baseUrl + distdirectoryOnline
            
            let parameterst = ["pageNo":pageNumber,"masterUID":mainMemberID,"grpID":grpIdd,"recordCount":pagelimit,"searchText":searchTxt]
            
            print("District Online Directory parameterst:: \(parameterst)")
            print("District Online Directory completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    SVProgressHUD.dismiss()
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DistDirectoryOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data: \(decodedData)")
                                 self.dirOnline = decodedData
                                 if (self.dirOnline?.result?.count == 0) {

                                     print("TABLEVIEW CONTENT HEIGHT----")
                                     self.loadDistrictDirectoryList("1", pagelimit: String(100), searchTxt: "")
                                 }
                                 self.tableDistrictDirectoryList.reloadData()
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
    
    func loadDistrictClassificationList() {
        
        if let grpIdd = self.groupID {
            
            let completeURL = baseUrl + dirClassificationOnline
            
            let parameterst = ["pageNo":"1","grpID":grpIdd,"recordCount":"","searchText":""]
            
            print("Club Online Directory Classification parameterst:: \(parameterst)")
            print("Club Online Directory Classification completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                         if let value = response.result.value {
                             do {
                                 // Attempt to decode the JSON data
                                 let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                 let decoder = JSONDecoder()
                                 let decodedData = try decoder.decode(DirectoryClassificationOnline.self, from: jsonData)
                                 
                                 // Access the properties of the decoded data
                                 print("Decoded Data:--- \(decodedData)")
                                 self.classOnline = decodedData
                                 for i in 0 ..< (self.classOnline?.classificationListResult.result.count ?? 0) {
                                     if !(self.classOnline?.classificationListResult.result[i].classification == "") {
                                         self.classiList.append(self.classOnline?.classificationListResult.result[i].classification ?? "")
                                         print(self.classiList)
                                     }
//                                     self.varGetCount = "\(self.classOnline?.classificationListResult.result.count ?? 0)"
                                 }
                                 SVProgressHUD.dismiss()
                                 self.tableDistrictDirectoryList.reloadData()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var textForEmpty = textfieldSearch.text!
        print(textForEmpty.characters.count)
        
        var varGetSearchBoxValue = (self.textfieldSearch.text! as NSString).replacingCharacters(in: range, with: string) as NSString as String
        textForEmpty = (varGetSearchBoxValue.trimmingCharacters(in: CharacterSet.whitespaces)as NSString) as String
         
         if (textForEmpty.characters.count > 0) {
             self.tfCount = 1
            
             if(buttonFilter.titleLabel?.text! == "Classification")
             {
                 muarrayForGetClassifcationList=NSMutableArray()
                 pageNo = 1
                 functionForGetDistrictMemberListSearching(String(pageNo), pagelimit: String(100), SearchText: textForEmpty)
             }
             else
             {
                self.apiData(searchTxt:textForEmpty)
             }
             return true
         } else {
             self.tfCount = 0
             self.memberFilterName.removeAll()
             self.noRecrdLbl.isHidden = true
             self.tableDistrictDirectoryList.isHidden = false
             self.loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
             return true
         }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.tfCount = 0
        self.memberFilterName.removeAll()
        self.noRecrdLbl.isHidden = true
        self.tableDistrictDirectoryList.isHidden = false
        self.loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        if(textField==textfieldSearch)
        {
            
            if(buttonFilter.titleLabel?.text! == "Classification")
            {
                searchORNot=="Classification"
               performActionForClassication()
//                textfieldSearch.resignFirstResponder()
            }
            else
            {
                searchORNot="Search"
                performAction()
//                textfieldSearch.resignFirstResponder()
            }
            
        }
        else
        {
        }
        return true
    }
    
    func performAction() {
        //action events
        pageNo = 1
        muarrayForGetList=NSMutableArray()
        let searchText = textfieldSearch.text!
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
          functionForGetDistrictMemberListSearching(String(pageNo), pagelimit: String(100), SearchText: searchText)
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        
         SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    func performActionForClassication() {
        //action events
        pageNo = 1
        muarrayForGetClassifcationList=NSMutableArray()
        let searchText = textfieldSearch.text!
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            functionForGetClasssificationMemberList(String(pageNo), pagelimit: String(100), SearchText: searchText)
        }
        else
        {
             SVProgressHUD.dismiss()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
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
        buttonleft.addTarget(self, action: #selector(DistrictDirectoryOnlineViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Server Calling
    func functionForGetDistrictMemberList(_ pageNumber:String , pagelimit:String)
    {
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
        var  completeURL:String!=""
            completeURL = baseUrl+"District/GetDistrictMemberList"
        let parameterst = ["masterUID": mainMemberID,"grpID":self.groupID, "searchText":"","pageNo":pageNumber,"recordCount":pagelimit]
        print("District Directory parameterst ::\(parameterst)")
        print("District Directory completeURL ::\(completeURL)")
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
            let resultCount = dd.object(forKey: "resultCount") as? String
            let TotalPages = dd.object(forKey: "TotalPages") as? String
            let currentPage = dd.object(forKey: "currentPage") as? String
            if(dd.object(forKey: "status") as! String == "0" )
            {
              
                for i in 0 ..< (((dd.value(forKey: "Result")! as AnyObject).value(forKey: "profileID")! as AnyObject).count)
                    {
                        let result = (dd.value(forKey: "Result")! as AnyObject).object(at: i)
                        self.muarrayForGetList.add(result)
                    }
                    if(self.muarrayForGetList.count>0)
                    {
                        self.tableDistrictDirectoryList.reloadData()
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
    //MARK:- Search Online Member
    func functionForGetDistrictMemberListSearching(_ pageNumber:String , pagelimit:String?,SearchText:String?)
    {
        if buttonFilter.titleLabel?.text! == "Classification" {
            
            print("---------------CLASSIFICATION----------------------------")
            print("SearchText------\(SearchText)")
            filterdsgns.removeAll()
            var memberDetail = self.classOnline?.classificationListResult.result
            let filteredMembers = memberDetail?.filter { member in
                guard let memberName = member.classification?.lowercased(),
                      let clubName = SearchText?.lowercased() else { return false }
                print("DISTRICTclubName\(clubName)")
                return memberName.contains(clubName)
            }
            print("DISTRICT FILTEREDMEMBER:: \(filteredMembers)")
            self.classiDetailMemberName = filteredMembers
            print("DISTRICT FILTERED CLUB NAME:: \(memberDetail)")
            print("DISTRICT FILTERED CLUB123 NAME:: \(self.classiDetailMemberName?.count)")
            
            for i in 0 ..< (self.classiDetailMemberName?.count ?? 0) {
                var dssgn = self.classiDetailMemberName?[i].classification ?? ""
                filterdsgns.append(dssgn)
                print("filterdsgns:: \(filterdsgns)")
            }
            
            
            if (self.filterdsgns.count == 0) && (self.tfCount != 0) {
                //            tableDistrictDirectoryList.isHidden = true
                noRecrdLbl.isHidden = false
            } else {
                tableDistrictDirectoryList.isHidden = false
                noRecrdLbl.isHidden = true
            }
        } else {
            print("---------------ROTARIAN----------------------------")
            
//            if let grpIdd = self.groupID, let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String?, let pagelim = pagelimit, let search = SearchText {
//                
//                let completeURL = baseUrl + distdirectoryOnline
//                
//                let parameterst = ["pageNo":"","masterUID":mainMemberID,"grpID":grpIdd,"recordCount":pagelim,"searchText":search]
//                
//                print("District Online SEARCH Directory parameterst:: \(parameterst)")
//                print("District Online SEARCH Directory completeURL:: \(completeURL)")
//                
//                //------------------------------------------------------
//                Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
//                    switch response.result {
//                    case .success:
//                        
//                        SVProgressHUD.dismiss()
//                             if let value = response.result.value {
//                                 do {
//                                     // Attempt to decode the JSON data
//                                     let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//                                     let decoder = JSONDecoder()
//                                     let decodedData = try decoder.decode(DistDirectoryOnline.self, from: jsonData)
//                                     
//                                     // Access the properties of the decoded data
//                                     print("Decoded Data: \(decodedData)")
//                                     self.dirOnline = decodedData
//                                     self.tableDistrictDirectoryList.reloadData()
//                                     // Access individual properties like decodedData.propertyName
//                                 } catch {
//                                     print("Error decoding JSON: \(error)")
//                                 }
//                             }
//                    case .failure(_): break
//                    }
//                }
//            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//            var memberDetail = self.dirOnline?.result
//                    let filteredMembers = memberDetail?.filter { member in
//                        guard let memberName = member.memberName?.lowercased(),
//                        let clubName = SearchText?.lowercased() else { return false }
//                        print("DISTRICTclubName\(clubName)")
//                        return memberName.contains(clubName)
//                    }
//                    memberDetail = filteredMembers
//                    self.districtmemberDetailMemberName = filteredMembers
//                    print("DISTRICT FILTERED CLUB NAME:: \(memberDetail)")
//                    print("DISTRICT FILTERED CLUB123 NAME:: \(self.districtmemberDetailMemberName?.count)")
//                    if (self.districtmemberDetailMemberName?.count == 0) && (self.tfCount != 0) {
//            //            tableDistrictDirectoryList.isHidden = true
//                        noRecrdLbl.isHidden = false
//                    } else {
//                        tableDistrictDirectoryList.isHidden = false
//                        noRecrdLbl.isHidden = true
//                    }
        }
        
        tableDistrictDirectoryList.reloadData()
        
//        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
//        var  completeURL:String!=""
//        completeURL = baseUrl+"District/GetDistrictMemberList"
//        let parameterst = ["masterUID": mainMemberID,"grpID":self.groupID, "searchText":SearchText,"pageNo":pageNumber,"recordCount":pagelimit]
//        print(parameterst)
//        print(completeURL)
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//            //=> Handle server response
//            let dd = response as! NSDictionary
//            print(dd)
//            var varGetValueServerError = response.object(forKey: "serverError")as? String
//            if(varGetValueServerError == "Error")
//            {
//                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//                SVProgressHUD.dismiss()
//            }
//            else
//            {
//            let resultCount = dd.object(forKey: "resultCount") as! String
//            let TotalPages = dd.object(forKey: "TotalPages") as! String
//            let currentPage = dd.object(forKey: "currentPage") as! String
//            if(dd.object(forKey: "status") as! String == "0" )
//            {
//                for i in 0 ..< (((dd.value(forKey: "Result")! as AnyObject).value(forKey: "profileID")! as AnyObject).count)
//                {
//                    let result = (dd.value(forKey: "Result")! as AnyObject).object(at: i)
//                    self.muarrayForGetList.add(result)
//                }
//                if(self.muarrayForGetList.count>0)
//                {
//                self.tableDistrictDirectoryList.reloadData()
//                }
//                else if(resultCount=="0")
//                {
//                    self.tableDistrictDirectoryList.reloadData()
//                    self.view.makeToast("No result found", duration: 2, position: CSToastPositionCenter)
//                }
//                else
//                {
//                    
//                }
//                
//            }
//            else
//            {
//            }
//            SVProgressHUD.dismiss()
//            }
//        })
    }
    
    
    
  
    
    //MARK:- Server Calling Classification
    func functionForGetClasssificationMemberList(_ pageNumber:String , pagelimit:String,SearchText:String)
    {
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
        var  completeURL:String!=""
        //completeURL = baseUrl+"District/GetClassificationList"
       completeURL = baseUrl+"District/GetClassificationList_New"
        
        
        
        let parameterst = ["grpID":self.groupID,"pageNo":pageNumber,"recordCount":pagelimit,"searchText":SearchText]
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
            let resultCount = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "resultCount") as! String
            let TotalPages = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "TotalPages") as! String
            let currentPage = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "currentPage") as! String
            print(resultCount,TotalPages,currentPage)
            if((dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "status") as! String == "0" )
            {
                
                
                for i in 0 ..< ((((dd.object(forKey: "ClassificationListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "profileID")! as AnyObject).count)
                {
                    let result = ((dd.object(forKey: "ClassificationListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: i)
                    self.muarrayForGetClassifcationList.add(result)
                }
                if(self.muarrayForGetClassifcationList.count>0)
                {
                    self.tableDistrictDirectoryList.reloadData()
                }
                else if(resultCount=="0")
                {
                    self.tableDistrictDirectoryList.reloadData()
                    self.view.makeToast("No result found", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    
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
    
    
    
    //MARK:- Server Calling Classification Search
    func functionForGetClasssificationSearchMemberList(_ pageNumber:String , pagelimit:String ,SearchText:String)
    {
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")! as String
        var  completeURL:String!=""
        completeURL = baseUrl+"District/GetClassificationList"
        let parameterst = ["grpID":self.groupID,"pageNo":pageNumber,"recordCount":pagelimit,"searchText":SearchText]
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
            let resultCount = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "resultCount") as! String
            let TotalPages = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "TotalPages") as! String
            let currentPage = (dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "currentPage") as! String
            print(resultCount,TotalPages,currentPage)
            if((dd.object(forKey: "ClassificationListResult")! as AnyObject).object(forKey: "status") as! String == "0" )
            {
                
                for i in 0 ..< ((((dd.object(forKey: "ClassificationListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "profileID")! as AnyObject).count)
                {
                    let result = ((dd.object(forKey: "ClassificationListResult")! as AnyObject).value(forKey: "Result")! as AnyObject).object(at: i)
                    self.muarrayForGetClassifcationList.add(result)
                }
                if(self.muarrayForGetClassifcationList.count>0)
                {
                    self.tableDistrictDirectoryList.reloadData()
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
    
    
    
    
    //MARK:- Table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(varGetPickerSelectValue=="Classification")
        {
            if ((classiList.count != 0) && (self.filterdsgns.count == nil) && (self.tfCount == 0)) {
                print("Classification list count \(classiList.count)")
                return classiList.count
            } else if ((classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
                print("Classification list count \(classiList.count)")
                return classiList.count
            } else if (self.filterdsgns.count != nil) && (self.tfCount != 0){
                print("self.memberDetailMemberName?.count \(self.filterdsgns.count ?? 0)")
                return self.filterdsgns.count ?? 0
            } else if ((self.filterdsgns.count == 0) && (self.tfCount != 0)){
                print("self.memberDetailMemberName?.count123 \(self.filterdsgns.count)")
                return 0
            } else {
                return 0
            }
        }
        else
        {
//             return muarrayForGetList.count
//            return dirOnline?.result?.count ?? 0
            
            var countss = 0
            if let countsss = dirOnline?.result?.count {
                countss = countsss
                print("countss:: \(countss)")
            }
            if ((countss != 0) && (self.memberFilterName.count == 0) && (self.tfCount == 0)) {
                    print("self.dirOnline?.memberDetail?.memberDetails?.count1 \(dirOnline?.result?.count)")
                    return countss
            } else  if ((countss != 0) && (self.memberFilterName.count == 0) && (self.tfCount == 0)) {
                print("self.dirOnline?.memberDetail?.memberDetails?.count1 \(self.dirOnline?.result?.count)")
                return countss
        } else if (self.memberFilterName.count != 0) && (self.tfCount != 0) {
                print("self.memberDetailMemberName?.count12 \(self.districtmemberDetailMemberName?.count)")
                return self.memberFilterName.count
            } else if (self.memberFilterName.count == 0) && (self.tfCount != 0) {
                print("self.dirOnline?.memberDetail?.memberDetails?.count123 \(countss)")
                print("self.memberDetailMemberName?.count \(self.districtmemberDetailMemberName?.count)")
                return 0
            } else {
                return 0
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableDistrictDirectoryList.dequeueReusableCell(withIdentifier: "DistrictDirOnlineTableCell", for: indexPath) as? DistrictDirOnlineTableCell else {return UITableViewCell()}
       cell.buttonPicBigView.isHidden=true
        if(varGetPickerSelectValue=="Classification")
        {
            tableDistrictDirectoryList.isHidden = false
            noRecrdLbl.isHidden = true
                cell.lblUnderLine.isHidden=true
                cell.imgNext.isHidden=true
                cell.imgProfile.isHidden=true
                cell.lblName.isHidden=true
                cell.lblMobileNumber.isHidden=true
                cell.viewClassification.isHidden=false
            if ((self.classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
                cell.lblClassificationName.text = classiList[indexPath.row]
        } else if (self.filterdsgns.count != 0) && (self.tfCount != 0) {
//                var dsgnation = memberDetailMemberName?[indexPath.row].designation ?? ""
//                filterdsgns.append(dsgnation)
            cell.lblClassificationName.text = filterdsgns[indexPath.row]
        } else if ((self.classiList.count != 0) && (self.filterdsgns.count == 0) && (self.tfCount == 0)) {
            cell.lblClassificationName.text = classiList[indexPath.row]
        } else if (self.filterdsgns.count == 0) && (self.tfCount != 0) {
            cell.lblClassificationName.text = ""
        } else {
            tableDistrictDirectoryList.isHidden = true
            noRecrdLbl.isHidden = false
        }
                
//            }
        }
        else
        {
            tableDistrictDirectoryList.isHidden = false
            noRecrdLbl.isHidden = true
            cell.lblUnderLine.isHidden=false
//            cell.imgNext.isHidden=false
            cell.imgProfile.isHidden=false
            cell.lblName.isHidden=false
            cell.lblMobileNumber.isHidden=false
            cell.viewClassification.isHidden=true
            //            cell.lblName.text! = ((muarrayForGetList.value(forKey: "memberName") as AnyObject).object(at: indexPath.row) as! String)
            //            cell.lblMobileNumber.text! = ((muarrayForGetList.value(forKey: "club_name") as AnyObject).object(at: indexPath.row) as! String)
            
            var countss = 0
            if let countsss = dirOnline?.result?.count {
                countss = countsss
                print("countss:: \(countss)")
            }
            
            if ((countss != 0) && (self.memberFilterName.count == 0) && (self.tfCount == 0)) {
                
                if let memberName = dirOnline?.result?[indexPath.row].memberName, let clubName = dirOnline?.result?[indexPath.row].clubName, let img = dirOnline?.result?[indexPath.row].pic {
                cell.lblName.text = memberName
                cell.lblMobileNumber.text = clubName
                
                if img == ""  || img == "profile_photo.png"
                {
                    cell.imgProfile.image = UIImage(named: "profile_pic")
                }
                else
                {
                    
                    // /*------------------------------Code by --------------------DPK--------------------------- */
                    let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                    print("ImageProfilePic: \(ImageProfilePic)")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.imgProfile.sd_setImage(with: checkedUrl)
                    
                }
            }
            
            cell.buttonPicBigView.isHidden=false
            cell.buttonPicBigView.tag=indexPath.row
            cell.buttonPicBigView.addTarget(self, action: #selector(DistrictDirectoryOnlineViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
            
            
            
        } else if ((countss != 0) && (self.memberFilterName.count == 0) && (self.tfCount == 0)) {
            
            if let memberName = dirOnline?.result?[indexPath.row].memberName, let clubName = dirOnline?.result?[indexPath.row].clubName, let img = dirOnline?.result?[indexPath.row].pic {
            cell.lblName.text = memberName
            cell.lblMobileNumber.text = clubName
            if img == ""  || img == "profile_photo.png"
            {
                cell.imgProfile.image = UIImage(named: "profile_pic")
            }
            else
            {
                
                // /*------------------------------Code by --------------------DPK--------------------------- */
                let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                print("ImageProfilePic: \(ImageProfilePic)")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imgProfile.sd_setImage(with: checkedUrl)
                
            }
        }
        cell.buttonPicBigView.isHidden=false
        cell.buttonPicBigView.tag=indexPath.row
        cell.buttonPicBigView.addTarget(self, action: #selector(DistrictDirectoryOnlineViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)

        } else if (self.memberFilterName.count != 0) && (self.tfCount != 0) {
            
            let memberName = self.memberFilterName[indexPath.row]
            let clubName = self.clubFilterName[indexPath.row]
            let img = self.imgFilterName[indexPath.row]
            cell.lblName.text = memberName
            cell.lblMobileNumber.text = clubName
            
            if img == ""  || img == "profile_photo.png"
            {
                cell.imgProfile.image = UIImage(named: "profile_pic")
            }
            else
            {
                
                // /*------------------------------Code by --------------------DPK--------------------------- */
                let ImageProfilePic:String = img.replacingOccurrences(of: " ", with: "%20")
                print("ImageProfilePic: \(ImageProfilePic)")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imgProfile.sd_setImage(with: checkedUrl)
                
            }
        
        cell.buttonPicBigView.isHidden=false
        cell.buttonPicBigView.tag=indexPath.row
        cell.buttonPicBigView.addTarget(self, action: #selector(DistrictDirectoryOnlineViewController.buttonPicBigViewClickEvent(_:)), for: UIControl.Event.touchUpInside)
        } else {
            tableDistrictDirectoryList.isHidden = true
            noRecrdLbl.isHidden = false
        }
        }
        return cell
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
    
    @objc func buttonPicBigViewClickEvent(_ sender:UIButton)
    {
        
        
        if (self.memberFilterName.count != 0) {
            
            let isUpperImageAvailable = imgFilterName[sender.tag]
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
        } else {
            let isUpperImageAvailable = (muarrayForGetList.value(forKey: "pic") as AnyObject).object(at: sender.tag) as! String
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
    }

    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Select Row Index --  ", indexPath.row)
        
        
        if(varGetPickerSelectValue=="Classification")
        {
//          let designation =   ((muarrayForGetClassifcationList.value(forKey: "classification") as AnyObject).object(at: indexPath.row) as! String)
            //"classification":"a","groupId":"31085"
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ClassificationMemberListViewController") as! ClassificationMemberListViewController
            if ((classiList.count != 0) && (self.filterdsgns.count == nil) && (tfCount == 0)) {
                obj.classificationText = classiList[indexPath.row]
                obj.groupID = self.groupID
            } else if ((classiList.count != 0) && (self.filterdsgns.count == 0) && (tfCount == 0)) {
                obj.classificationText = classiList[indexPath.row]
                obj.groupID = self.groupID
                
            } else if (self.filterdsgns.count != nil) && (tfCount != 0) {
                
                obj.classificationText = filterdsgns[indexPath.row]
                obj.groupID = self.groupID
            }
            self.navigationController?.pushViewController(obj, animated: true)
            
            print("Hello One")
            
            
            
        }
        else
        {
            textfieldSearch.resignFirstResponder()
            var countss = 0
            if let countsss = dirOnline?.result?.count {
                countss = countsss
                print("countss:: \(countss)")
            }
            
            if ((countss != 0) && (self.memberFilterName.count == 0) && (tfCount == 0)) {
            
            
                if let memberName = dirOnline?.result?[indexPath.row].memberName, let clubName = dirOnline?.result?[indexPath.row].clubName, let img = dirOnline?.result?[indexPath.row].pic, let mobile = dirOnline?.result?[indexPath.row].membermobile, let profileID = dirOnline?.result?[indexPath.row].profileID, let grpID = dirOnline?.result?[indexPath.row].grpID {
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
                    obj.userName = memberName
                    obj.userProfile = img
                    obj.userMobileNumber = mobile
                    obj.selectedMemberProfileID = profileID
                    obj.groupID = grpID
                    self.navigationController?.pushViewController(obj, animated: true)
                }
            } else if ((countss != 0) && (self.memberFilterName.count == 0) && (tfCount == 0)) {
                if let memberName = dirOnline?.result?[indexPath.row].memberName, let clubName = dirOnline?.result?[indexPath.row].clubName, let img = dirOnline?.result?[indexPath.row].pic, let mobile = dirOnline?.result?[indexPath.row].membermobile, let profileID = dirOnline?.result?[indexPath.row].profileID, let grpID = dirOnline?.result?[indexPath.row].grpID {
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
                    obj.userName = memberName
                    obj.userProfile = img
                    obj.userMobileNumber = mobile
                    obj.selectedMemberProfileID = profileID
                    obj.groupID = grpID
                    self.navigationController?.pushViewController(obj, animated: true)
                }
            } else if (self.memberFilterName.count != 0) && (tfCount != 0) {
                
                let memberName = memberFilterName[indexPath.row]
                let clubName = clubFilterName[indexPath.row]
                let img = imgFilterName[indexPath.row]
                let mobile = memMobileFilterName[indexPath.row]
                let profileID = profileIDFilterName[indexPath.row]
                let grpID = grpIDFilterName[indexPath.row] 
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "DistrictDirectoryDetailsVC") as! DistrictDirectoryDetailsVC
                    obj.userName = memberName
                    obj.userProfile = img
                    obj.userMobileNumber = mobile
                    obj.selectedMemberProfileID = profileID
                    obj.groupID = grpID
                    self.navigationController?.pushViewController(obj, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(varGetPickerSelectValue=="Classification")
        {
            return 60.0
        }
        else
        {
         return 100.0
        }
    }

    
    //MARK:- Picker Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainArraySettingForPicker.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        var varGetCountry:String?
        if let row = mainArraySettingForPicker.object(at: row) as? String {
        varGetCountry = row
        }
            return varGetCountry
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if let varGetCountry:String = mainArraySettingForPicker.object(at: row) as? String {
            varGetPickerSelectValue =   varGetCountry
            if varGetPickerSelectValue == "Rotarian" {
                loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
            } else {
                loadDistrictClassificationList()
            }
        }
    }
    
    //MARK:- Scrolling Methods for Pagination
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableDistrictDirectoryList.contentOffset.y + tableDistrictDirectoryList.frame.size.height) >= tableDistrictDirectoryList.contentSize.height)
        {
//            if !isDataLoading{
//                isDataLoading = true
                self.pageNo=self.pageNo+1
                //self.limit=self.limit+10
                self.offset=self.limit * self.pageNo
               // loadCallLogData(offset: self.offset, limit: self.limit)
            
            if(searchORNot=="Search")
            {
                let searchText = textfieldSearch.text!
                functionForGetDistrictMemberListSearching(String(pageNo), pagelimit: String(100), SearchText: searchText)
                loadDistrictDirectoryList(String(self.pageNo), pagelimit: String(100), searchTxt: "")
            }
            else if(searchORNot=="Classification")
            {
                print("---------CLASSIFICATION------------")
                let searchText = textfieldSearch.text!
             functionForGetClasssificationMemberList(String(pageNo), pagelimit: String(100),SearchText: searchText)
            }
            else
            {
                print("---------FAMILY------------")
              self.functionForGetDistrictMemberList(String(self.pageNo),pagelimit: String(100))
                loadDistrictDirectoryList(String(self.pageNo), pagelimit: String(100), searchTxt: "")
                
            }
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        isDataLoading = true
    }
    
  //MARK:- Button Action
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject) {
        viewForPicker.isHidden=true
        buttonOptocity.isHidden=true
    }
    @IBAction func buttonDoneClickEvent(_ sender: AnyObject)
    {
       
        if (varGetPickerSelectValue == "Rotarian")
        {
            searchORNot="Rotarian"
            buttonFilter.setTitle("Rotarian",  for: UIControl.State.normal)
            muarrayForGetList=NSMutableArray()
            pageNo = 1
            functionForGetDistrictMemberList(String(1),pagelimit: String(100))
            loadDistrictDirectoryList(String(1), pagelimit: String(100), searchTxt: "")
        }
        else if (varGetPickerSelectValue == "Classification")
        {
            searchORNot = "Classification"
            buttonFilter.setTitle("Classification",  for: UIControl.State.normal)
            muarrayForGetClassifcationList=NSMutableArray()
             pageNo = 1
            functionForGetClasssificationMemberList(String(1), pagelimit: String(100),SearchText: "")
        }
        viewForPicker.isHidden=true
        buttonOptocity.isHidden=true
    }
    
    @IBAction func buttonFilterClickEvent(_ sender: AnyObject)
    {
        viewForPicker.isHidden=false
        buttonOptocity.isHidden=false
        
       
    }
}


struct DistDirectoryOnline: Codable {
    let status, message, resultCount, totalPages: String?
    let currentPage: String?
    let result: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, message, resultCount
        case totalPages = "TotalPages"
        case currentPage
        case result = "Result"
    }
}

// MARK: - Result
struct Result: Codable {
    let masterUID, grpID, profileID, memberName: String?
    let pic: String?
    let membermobile: String?
    let clubName: String?

    enum CodingKeys: String, CodingKey {
        case masterUID, grpID, profileID, memberName, pic, membermobile
        case clubName = "club_name"
    }
}

enum ClubName: String, Codable {
    case newClubTestEntry = "New Club Test Entry"
    case owala = "Owala"
    case rotaryClubOfLeo = "Rotary Club of Leo"
    case thaneCityView = "Thane City View"
    case thaneOwala = "Thane Owala"
}
