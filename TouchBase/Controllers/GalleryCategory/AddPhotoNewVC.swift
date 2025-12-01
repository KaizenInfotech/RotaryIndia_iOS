//
//  AddPhotoNewVC.swift
//  TouchBase
//
//  Created by tt on 11/10/18.
//  Copyright © 2018 Parag. All rights reserved.
//
//checkString
import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import MBProgressHUD

protocol HideFloatButton: AnyObject {
    func hideFloatAction()
}

class clubeTVC:UITableViewCell{
    
    @IBOutlet weak var btnaddPic: UIButton!
    @IBOutlet weak var lblplaceholder: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var imgphoto: UIImageView!
}

class AddPhotoNewVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate ,UIPickerViewDelegate , UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate,  uploadDocDelegate,UIDocumentPickerDelegate{
 
    @IBOutlet weak var hostRotaryClubTF: UITextField!
    @IBOutlet weak var locationOfProjectTF: UITextField!
    @IBOutlet weak var globalGrantPartnerTF: UITextField!
    @IBOutlet weak var globalGrantHostTF: UITextField!
    @IBOutlet weak var globalGrantAmtSpenTF: UITextField!
    @IBOutlet weak var globalGrantAmtRecTF: UITextField!
    @IBOutlet weak var globalGrantSanTF: UITextField!
    @IBOutlet weak var globalGrantNoTF: UITextField!
    @IBOutlet weak var amtRecCsrTF: UITextField!
    @IBOutlet weak var amtSanCsrTF: UITextField!
    @IBOutlet weak var csrNameTF: UITextField!
    @IBOutlet var header1View: UIView!
    
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var secondSelectionVieww: UIView!
    @IBOutlet var serviceProFooterView: UIView!

    @IBOutlet weak var lblMeetingDownloaded: UILabel!
    @IBOutlet weak var lblAgendaDownloaded: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet var clubRoleView: UIView!
    
    var hideFloatButtonDelegate: HideFloatButton?
    var isOnetimeProject = Bool()
    var isOngoingProject = Bool()
    var year:String!=""
    var sharetype: String = "1"
    var Iscreatenew = Bool()
    var isselectFromExiting = Bool()
    var yearFrom:String! = ""
    var photoIDArray = [String]()
    @IBOutlet weak var titleProjectBtn: UIButton!
    @IBOutlet var TitleforOngoingWalaView: UIView!
    @IBOutlet weak var selectProjBtnnnnnn: UIButton!
    @IBOutlet weak var selectProjListWalaView: UIView!
    @IBOutlet weak var doneSelectProjBtn: UIButton!
    
    @IBOutlet weak var cancelSelectProjBtn: UIButton!
    @IBOutlet weak var selectProjPickerViewww: UIPickerView!
    @IBOutlet weak var coHostBtnImg: UIImageView!
    @IBOutlet var selectProjWalaVieww: UIView!
    
    
    @IBOutlet weak var titleOfNewOngoingProjectTX: UITextField!
    
    @IBOutlet var titleOfOngoingWalaView: UIView!
    
    var isSubGrpAdmin : String = "0"
    var titleRIZone = ""
    
    @IBAction func DoneSelectProjBtnclickedd(_ sender: Any) {
        functionForHideKeyBoard()
         if(IsSelectDateAction==1)
         {
        if !isDateisFutureDate(selectedDate: datePickers.date)
          {
           txtSelectDate.text = datePickers.date.formatted
           txtSelectedDateRot.text = datePickers.date.formatted
          }
        }
        IsSelectDateAction=0
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewCategory.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
        viewFunding.isHidden = true
        selectProjPickerViewww.isHidden = true
        selectProjListWalaView.isHidden = true
        
        
    }
    @IBAction func cancelProjBtnClickddd(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
        viewCategory.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
        selectProjPickerViewww.isHidden = true
        selectProjListWalaView.isHidden = true
    }
    @IBAction func titleProjectBtnClickedd(_ sender: Any) {
    }
    @IBOutlet weak var leadClubImg: UIImageView!
    @IBAction func IsjointYesProjBtn(_ sender: Any) {
        isOnetimeProject = false
        isOngoingProject = true
        
        JoinedOrNotSelectType = "1"

        if Iscreatenew == true {
//            {
                
                let screenSize: CGRect = UIScreen.main.bounds
                let screenWidth = screenSize.width
                let screenHeight = screenSize.height
                
                Iscreatenew = true
            isselectFromExiting = false
            
            
            if isMainProjectSelect == "yes" {
                oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                ongoingProImg.image = UIImage(named: "RoundUncheck")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                createNewProImg.image = UIImage(named: "RoundUncheck")
                selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                coHostBtnImg.image = UIImage(named: "RoundUncheck")
                leadClubImg.image = UIImage(named: "RoundUncheck")
               
                
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
            titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
                serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
            }
            else{
                oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                createNewProImg.image = UIImage(named: "RoundUncheck")
                selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                coHostBtnImg.image = UIImage(named: "RoundUncheck")
                leadClubImg.image = UIImage(named: "RoundUncheck")
               
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
            titleOfOngoingWalaView.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 90)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
                clubRoleView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: 233)
                serviceProFooterView.frame = CGRect(x: 0, y: 658, width: screenWidth, height: 3500)
            }
            
         
//            }
        }
        if isselectFromExiting == true {
//            {
    //            {
                    
                    let screenSize: CGRect = UIScreen.main.bounds
                    let screenWidth = screenSize.width
                    let screenHeight = screenSize.height
                    Iscreatenew = false
                    isselectFromExiting = true
//                    clubRoleView.isHidden = false
                    oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    createNewProImg.image = UIImage(named: "radio_btn_Check1")
                    selectExitProjImg.image = UIImage(named: "RoundUncheck")
                    IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                    IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                    coHostBtnImg.image = UIImage(named: "RoundUncheck")
                    leadClubImg.image = UIImage(named: "RoundUncheck")
                  
                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                    secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
            selectProjWalaVieww.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 80)
                    IsJointProjWalaView.frame = CGRect(x: 0, y: 335, width: screenWidth, height: 80)
                    clubRoleView.frame = CGRect(x: 0, y: 415, width: screenWidth, height: 233)
                    serviceProFooterView.frame = CGRect(x: 0, y: 648, width: screenWidth, height: 3500)
    //            }
//            }
        }
    }
    @IBAction func IsjointNoProj(_ sender: Any) {
        isOnetimeProject = false
        isOngoingProject = true
        JoinedOrNotSelectType = "2"
        if Iscreatenew == true {
//            {
                
                let screenSize: CGRect = UIScreen.main.bounds
                let screenWidth = screenSize.width
                let screenHeight = screenSize.height
                
                Iscreatenew = true
            isselectFromExiting = false
            
            
            if isMainProjectSelect == "yes" {
                oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                createNewProImg.image = UIImage(named: "RoundUncheck")
                selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
                IsJointProYesImg.image = UIImage(named: "RoundUncheck")
//                coHostBtnImg.image = UIImage(named: "RoundUncheck")
//                leadClubImg.image = UIImage(named: "radio_btn_Check1")
               
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
            titleOfOngoingWalaView.frame=CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 00)
                serviceProFooterView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 3500)
            }
            else{
                oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                createNewProImg.image = UIImage(named: "RoundUncheck")
                selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
                IsJointProYesImg.image = UIImage(named: "RoundUncheck")
//                coHostBtnImg.image = UIImage(named: "RoundUncheck")
//                leadClubImg.image = UIImage(named: "radio_btn_Check1")
               
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
            titleOfOngoingWalaView.frame=CGRect(x: 0, y: 255, width: screenWidth, height: 90)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
                clubRoleView.frame = CGRect(x: 0, y: 465, width: screenWidth, height: 00)
                serviceProFooterView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: 3500)
            }
        }
        if isselectFromExiting == true {
//            {
    //            {
                    
                    let screenSize: CGRect = UIScreen.main.bounds
                    let screenWidth = screenSize.width
                    let screenHeight = screenSize.height
                    
                    isselectFromExiting = true
            Iscreatenew = false
                    oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    createNewProImg.image = UIImage(named: "radio_btn_Check1")
                    selectExitProjImg.image = UIImage(named: "RoundUncheck")
                    IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
                    IsJointProYesImg.image = UIImage(named: "RoundUncheck")
                    coHostBtnImg.image = UIImage(named: "RoundUncheck")
                    leadClubImg.image = UIImage(named: "RoundUncheck")
               
//                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                    secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                    IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//                    clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                    serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: (screenHeight-390))
//
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
    selectProjWalaVieww.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 80)
            IsJointProjWalaView.frame = CGRect(x: 0, y: 335, width: screenWidth, height: 80)
            clubRoleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 00)
            serviceProFooterView.frame = CGRect(x: 0, y: 415, width: screenWidth, height: 3500)
            
            
            
    //            }
//            }
        }
    }
    var onlinemuarrayModule:NSArray = NSArray()
//    func GetdataForselectProject()
////    func makeGetCall()
//    {
//      // Set up the URL request
//      let todoEndpoint: String = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/LoadExistingProject"
//      guard let url = URL(string: todoEndpoint) else {
//        print("Error: cannot create URL")
//        return
//      }
//      let urlRequest = URLRequest(url: url)
//
//      // set up the session
//      let config = URLSessionConfiguration.default
//      let session = URLSession(configuration: config)
//
//      // make the request
//      let task = session.dataTask(with: urlRequest) {
//        (data, response, error) in
//        // check for any errors
//        guard error == nil else {
//          print("error calling GET on /todos/1")
//          print(error!)
//          return
//        }
//        // make sure we got data
//        guard let responseData = data else {
//          print("Error: did not receive data")
//          return
//        }
//        // parse the result as JSON, since that's what the API provides
//        do {
//          guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
//            as? [String: Any] else {
//              print("error trying to convert data to JSON")
//              return
//          }
//          // now we have the todo
//          // let's just print it to prove we can access it
//          print("The todo is: " + todo.description)
//
//          // the todo object is a dictionary
//          // so we just access the title using the "title" key
//          // so check for a title and print it if we have one
//          guard let todoTitle = todo["tblExistingResult"] as? NSDictionary else {
//            print("Could not get todo title from JSON")
//
//            if let TBRotaryIndiaModulesResult = todo["tblExistingResult"] as? NSDictionary
//            {
//                if TBRotaryIndiaModulesResult.object(forKey: "status") as! String == "0"
//                {
//                    if let RotaryIndiaModulesResult = TBRotaryIndiaModulesResult.object(forKey: "Table") as? NSArray
//                    {
//                        self.onlinemuarrayModule=RotaryIndiaModulesResult
//                        if self.onlinemuarrayModule.count>0
//                        {
//                            print(self.onlinemuarrayModule.count)
////                            self.lblLoading.isHidden=true
////                            self.indiaCollectionView.isHidden=false
////                            self.indiaCollectionView.reloadData()
//
//                        self.selectProjPickerViewww.reloadAllComponents()
//                        }
//                        else
//                        {
//                            print("no dataaa")
////                            self.lblLoading.text="No result."
//                        }
//                    }
//                }
//                else{
////                    self.lblLoading.text="Could not connect to server"
//                }
//            }
//
//
//            return
//          }
////          print("The title is: " + todoTitle)
//
//                        if let TBRotaryIndiaModulesResult = todo["tblExistingResult"] as? NSDictionary
//                        {
//                            print(TBRotaryIndiaModulesResult)
//
////                            if TBRotaryIndiaModulesResult.object(forKey: "status") as! String == "0"
////                            {
//                                if let RotaryIndiaModulesResult = TBRotaryIndiaModulesResult.object(forKey: "Table") as? NSArray
//                                {
//                                    self.onlinemuarrayModule=RotaryIndiaModulesResult
//                                    if self.onlinemuarrayModule.count>0
//                                    {
//                                        print(self.onlinemuarrayModule.count)
//            //                            self.lblLoading.isHidden=true
//            //                            self.indiaCollectionView.isHidden=false
//            //                            self.indiaCollectionView.reloadData()
//
//                                    self.selectProjPickerViewww.reloadAllComponents()
//                                    }
//                                    else
//                                    {
//                                        print("no dataaa")
//            //                            self.lblLoading.text="No result."
//                                    }
//                                }
////                            }
//                            else{
//            //                    self.lblLoading.text="Could not connect to server"
//                            }
//                        }
//
//
//
//
//        } catch  {
//          print("error trying to convert data to JSON")
//          return
//        }
//      }
//      task.resume()
//    }
    
//    {
//        let completeURL=" http://rowtestapi.rosteronwheels.com/V4/api/Gallery/LoadExistingProject"
//        SVProgressHUD.show()
////        self.indiaCollectionView.isHidden=true
////        self.lblLoading.isHidden=false
////        self.lblLoading.text="Loading... Please Wait"
//        Alamofire.request(completeURL,method: .get, parameters: nil, encoding: URLEncoding.default, headers:nil).responseJSON { response in
//            SVProgressHUD.dismiss()
//            if response.result.value != nil
//            {
//                if let status = response.response?.statusCode {
//                    switch(status)
//                    {
//                    case 200:
//
//                        if let data = response.result.value as? NSDictionary
//                        {
//            print("Data is \(data)")
//            if let TBRotaryIndiaModulesResult = data.object(forKey: "tblExistingResult") as? NSDictionary
//            {
////                if TBRotaryIndiaModulesResult.object(forKey: "status") as! String == "0"
////                {
//                    if let RotaryIndiaModulesResult = TBRotaryIndiaModulesResult.object(forKey: "Table") as? NSArray
//                    {
//                        self.onlinemuarrayModule=RotaryIndiaModulesResult
//                        if self.onlinemuarrayModule.count>0
//                        {
////                            self.lblLoading.isHidden=true
////                            self.indiaCollectionView.isHidden=false
////                            self.indiaCollectionView.reloadData()
//
//                        self.selectProjPickerViewww.reloadAllComponents()
//                        }
//                        else
//                        {
//                            print("no dataaa")
////                            self.lblLoading.text="No result."
//                        }
//                    }
////                }
//                else{
////                    self.lblLoading.text="Could not connect to server"
//                }
//            }
//        }
//        break
//    default:
////        self.lblLoading.text="Could not connect to server"
//                        break
//                    }
//                }
//            }
//            else
//            {
//                print("response.result.value != nil ")
//            }
//        }
//    }
    @IBAction func selectProjBtnClickedd(_ sender: Any) {
        selectProjPickerViewww.isHidden = false
        selectProjListWalaView.isHidden = false
        selectProjPickerViewww .reloadAllComponents()
        
        
    }
    @IBAction func leadClubBtnClickedd(_ sender: Any) {
        ClubRole = "1"
        
        if isOnetimeProject == true {
            
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
            
            
            isOngoingProject = false
            
            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
    //            isOnetimeProject = true
            IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
            IsProjNoImg.image = UIImage(named: "RoundUncheck")
            
                coHostBtnImg.image = UIImage(named: "RoundUncheck")
                leadClubImg.image = UIImage(named: "radio_btn_Check1")
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
                clubRoleView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: 233)
            serviceProFooterView.frame = CGRect(x: 0, y: 508, width: screenWidth, height: 3500)
        }
        if isOngoingProject == true {
            if Iscreatenew == true {
    //            {
                    
                    let screenSize: CGRect = UIScreen.main.bounds
                    let screenWidth = screenSize.width
                    let screenHeight = screenSize.height
                    
                    Iscreatenew = true
                    oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    createNewProImg.image = UIImage(named: "RoundUncheck")
                    selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                    IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                    IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                    coHostBtnImg.image = UIImage(named: "RoundUncheck")
                    leadClubImg.image = UIImage(named: "radio_btn_Check1")
                   
                if isMainProjectSelect == "yes" {
                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                    secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
                titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                    IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                    clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
                    serviceProFooterView.frame = CGRect(x: 0, y: 280, width: screenWidth, height: 3500)
                }
                else{
                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                    secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
                titleOfOngoingWalaView.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 90)
                    IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
                    clubRoleView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: 233)
                    serviceProFooterView.frame = CGRect(x: 0, y: 658, width: screenWidth, height: 3500)
                }
              
                
    //            }
            }
            if isselectFromExiting == true {
    //            {
        //            {
                        
                        let screenSize: CGRect = UIScreen.main.bounds
                        let screenWidth = screenSize.width
                        let screenHeight = screenSize.height
                        
                        isselectFromExiting = true
                        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                        ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        
                //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                        createNewProImg.image = UIImage(named: "radio_btn_Check1")
                        selectExitProjImg.image = UIImage(named: "RoundUncheck")
                        IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                        IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                        coHostBtnImg.image = UIImage(named: "RoundUncheck")
                        leadClubImg.image = UIImage(named: "radio_btn_Check1")
                   
//                        header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                        secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                        IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//                        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                        serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: (screenHeight-390))
//
//
                
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
        selectProjWalaVieww.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 80)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 335, width: screenWidth, height: 80)
                clubRoleView.frame = CGRect(x: 0, y: 415, width: screenWidth, height: 233)
                serviceProFooterView.frame = CGRect(x: 0, y: 648, width: screenWidth, height: 3500)
                
                
        //            }
    //            }
            }
        }
//        {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
//
//
//
//            isOngoingProject = false
//
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//
//
//
//    //            isOnetimeProject = true
//            IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
//            IsProjNoImg.image = UIImage(named: "RoundUncheck")
//                coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
//                leadClubImg.image = UIImage(named: "RoundUncheck")
//            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//            IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
//                clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
//            serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: (screenHeight-300))
//        }
    }
//    {
//      "Fk_Funding_Id" : "2",
//      "albumDescription" : "Ccjcjjvcjjc",
//      "categoryId" : "1",
//      "AttendancePer" : "0",
//      "MediaDesc" : "",
//      "manhourspenttype" : "Hours",
//      "beneficiary" : "2",
//      "JoinedOrNot" : "1",
//      "costofprojecttype" : "1",
//      "Fk_SubTosubcategoryID" : "5",
//      "NewOrExisting" : "2",
//      "costofproject" : "1",
//      "shareType" : "1",
//      "dateofproject" : "2021-05-25",
//      "albumTitle" : "ios restring25thmay",
//      "type" : "0",
//      "NumberofRotarian" : "4",
//      "Ismedia" : "1",
//      "memberIds" : "",
//      "OtherSubCategory" : "",
//      "MeetingType" : "0",
//      "OnetimeOrOngoing" : "2",
//      "createdBy" : "588050",
//      "AgendaDocID" : "0",
//      "ddl_selectProject" : 334,
//      "manhourspent" : "3",
//      "TempBeneficiary" : "0",
//      "Attendance" : "0",
//      "TtlOfNewOngoingProj" : "",
//      "albumId" : "0",
//      "groupId" : "2765",
//      "ClubRole" : "2",
//      "OtherCategorytext" : "",
//      "moduleId" : "52",
//      "isSubGrpAdmin" : "0",
//      "albumImage" : "0",
//      "MOMDocID" : "0",
//      "TempBeneficiary_flag" : "0",
//      "Fk_SubcategoryID" : "2",
//      "Rotaractors" : "5",
//      "MediaphotoID" : "28132"
//    }
    
    
    
    
    
//    {"status":"0","message":"success","ImageID":"28132"}}
    @IBAction func coHostBtnClicked(_ sender: Any) {
        ClubRole = "2"
        
        if isOnetimeProject == true {
            
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
            
            
            isOngoingProject = false
            
            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
    //            isOnetimeProject = true
            IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
            IsProjNoImg.image = UIImage(named: "RoundUncheck")
            
                coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                leadClubImg.image = UIImage(named: "RoundUncheck")
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
                clubRoleView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: 233)
            serviceProFooterView.frame = CGRect(x: 0, y: 508, width: screenWidth, height: 3500)
        }
        if isOngoingProject == true {
            if Iscreatenew == true {
    //            {
                    
                    let screenSize: CGRect = UIScreen.main.bounds
                    let screenWidth = screenSize.width
                    let screenHeight = screenSize.height
                    
                    Iscreatenew = true
                    oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                    createNewProImg.image = UIImage(named: "RoundUncheck")
                    selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                    IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                    IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                    coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                    leadClubImg.image = UIImage(named: "RoundUncheck")

                if isMainProjectSelect == "yes" {
                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                    secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
                titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                    IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                    clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
                    serviceProFooterView.frame = CGRect(x: 0, y: 500, width: screenWidth, height: 3500)
                }
                else{
                    header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                    secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
                titleOfOngoingWalaView.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 90)
                    IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
                    clubRoleView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: 233)
                    serviceProFooterView.frame = CGRect(x: 0, y: 658, width: screenWidth, height: 3500)
                }
                
                
               
                
    //            }
            }
            if isselectFromExiting == true {
    //            {
        //            {
                        
                        let screenSize: CGRect = UIScreen.main.bounds
                        let screenWidth = screenSize.width
                        let screenHeight = screenSize.height
                        
                        isselectFromExiting = true
                        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                        ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        
                //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                        createNewProImg.image = UIImage(named: "radio_btn_Check1")
                        selectExitProjImg.image = UIImage(named: "RoundUncheck")
                        IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                        IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                        coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                        leadClubImg.image = UIImage(named: "RoundUncheck")
                   
//                        header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                        secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                        IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//                        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                        serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: (screenHeight-390))
//
//
                
                header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
        selectProjWalaVieww.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 80)
                IsJointProjWalaView.frame = CGRect(x: 0, y: 335, width: screenWidth, height: 80)
                clubRoleView.frame = CGRect(x: 0, y: 415, width: screenWidth, height: 233)
                serviceProFooterView.frame = CGRect(x: 0, y: 648, width: screenWidth, height: 3500)
                
                
        //            }
    //            }
            }
        }
//        {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
//
//
//
//            isOngoingProject = false
//
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//
//
//
//    //            isOnetimeProject = true
//            IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
//            IsProjNoImg.image = UIImage(named: "RoundUncheck")
//                coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
//                leadClubImg.image = UIImage(named: "RoundUncheck")
//            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//            IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
//                clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
//            serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: (screenHeight-300))
//        }
    }
    @IBOutlet weak var selectProjImgViewww: UIImageView!
    @IBOutlet weak var IsJointProjWalaView: UIView!
    @IBOutlet weak var IsJointProYesImg: UIImageView!
    @IBOutlet weak var IsJointProjNoImgg: UIImageView!
    
    
    @IBOutlet weak var IsProjWalaView: UIView!
    @IBOutlet weak var selectExitProjImg: UIImageView!
    @IBOutlet weak var createNewProImg: UIImageView!
    @IBOutlet weak var IsProjNoImg: UIImageView!
    @IBOutlet weak var IsprojYEsImg: UIImageView!
    @IBOutlet weak var ongoingProImg: UIImageView!
    @IBOutlet weak var oneTimeProjImg: UIImageView!
    //MARK:- All variable declaration
    var objProtocolNameNew:protocolNamePopValue?=nil
    var strWitchType:String!=""
    
    var CheckDelete:String?
    var CheckAgend:String?
    var CheckMettng:String?
    var commonIDString : String!
    var groupProfileID : String!
    var groupID = String()
    var isAddProject = Bool()
    var imageCondition = Bool()
    var videoCondition = Bool()
    var PDFCondition = Bool()
    var chosenImage = UIImage()
    var PDFLinkDrpBx : String = ""
    var PDFTypeFromDrpBx : String = ""
    var docTypeStr : String = "0"
    var strAgendaMetting:String?
    var strcreatedBy:String?
    var strAlbumId:String?
    var strGroupId:String?
    var memberIds : String?
    var type:String?
    var moduleId:String?
    var categoryId:String?
    var oneTimeOngoingSelectType:String?
    var NewOrExistingSelectType:String?
    var JoinedOrNotSelectType:String?
    var ClubRole:String?
    var selectedProjectTitleeName:String?
//    ClubRole
    var shareTypee:String?
    var subCategoryId:String?
    var ddSubProjectID:NSNumber?
    var subtoSubCategoryId:String?
    var fundID:String?
    var isCalledFRom:String?
    var strSelectDate:String?
    var strimageC1:UIImage?
    var strimageC2:UIImage?
    var strimageC3:UIImage?
    var strimageC4:UIImage?
    var strimageC5:UIImage?
    var strFileNameWithExtension:String=""
    var strimageR1:UIImage?
    var strimageR2:UIImage?
    var strimageR3:UIImage?
    var strimageR4:UIImage?
    var strimageR5:UIImage?
    var strimageR6:UIImage?
    var MemberCount:String=""
    var BodMemCount:String=""
    var issendwhatsapp:String=""
    var BenificiaryCount:String=""
    var isMediaCheck:String="0"
    var mediaImageID:String=""
    
    var isMainProjectSelect:String=""
    
    var isFromMoveToClub:String=""
    var isFromMoveToService:String=""
    var strSendServerImage:UIImage?
    var MurrayPhoto:NSMutableArray?
    var MurrayPhotoID:NSMutableArray?
    var MurrayText:NSMutableArray?
    var strMetting:String?
    var logoImagesClube = [UIImage]()
    var muaaryDescClube = NSMutableArray()
    var intTag:Int = 0
    var albumImagesID:String?
    let loaderClass  = WebserviceClass()
    var rotaryArray : NSMutableArray?
    var Clubearray :  NSMutableArray?
    var picker = UIImagePickerController()
    var checkString:String?
    var isImageThere = "false"
    var isimageSelect:String?
    var alertTitle:String=""
    var navTitle: String = ""
    var muarrayCategoryListArray:NSArray=NSArray()
    var muarraySubCategoryListArray:NSArray=NSArray()
    var muarraySubToSubCategoryListArray:NSArray=NSArray()
    var muarrayFundinglistArray:NSArray=NSArray()
 // var arrayImages = Array<UIImage>()
    var muarrayForMetting:NSMutableArray=NSMutableArray()
    var muarrayForCategoryListWithOutZeroIndex:NSMutableArray=NSMutableArray()
    var muarrayForSubCategoryList:NSMutableArray=NSMutableArray()
    var muarrayForSubToSubCategoryList:NSMutableArray=NSMutableArray()
    var arrayforphoto:NSMutableArray = NSMutableArray()
    var arrayforphotoRotatery:NSMutableArray = NSMutableArray()
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    var strC:String!=""
    var strR:String!=""
    var flagExceedBenificiary:String="0"
    var finalBenificiary:String = ""
    var finalTempBenificiary:String = ""
    var intgetindexVlaue:Int?
  //var module_name:String=""
    var arrayTempImageIndexHold:NSMutableArray=NSMutableArray()
    var AgendaDocID:String?
    var MOMDocID:String?
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    var loadingImage:MBProgressHUD = MBProgressHUD()
    
    //MARK:- ALL IBOutlet declaration
    //@IBOutlet weak var buttonClubServiceRotary: UIButton!
    // @IBOutlet weak var buttonRotaryserviceClub: UIButton!
    //radio_btn_Check1
    //radio_btn_Uncheck1
    @IBOutlet weak var btnMinutesofMetting: UIButton!
    @IBOutlet weak var btnAgenda: UIButton!
    @IBOutlet weak var imgC1: UIImageView!
    @IBOutlet weak var btnC1: UIButton!
    @IBOutlet weak var txtViewC1: UITextView!
    @IBOutlet weak var imgC2: UIImageView!
    @IBOutlet weak var btnC2: UIButton!
    @IBOutlet weak var txtViewC2: UITextView!
    @IBOutlet weak var imgC3: UIImageView!
    @IBOutlet weak var btnC3: UIButton!
    @IBOutlet weak var txtViewC3: UITextView!
    @IBOutlet weak var imgC4: UIImageView!
    @IBOutlet weak var btnC4: UIButton!
    @IBOutlet weak var txtViewC4: UITextView!
    @IBOutlet weak var imgC5: UIImageView!
    @IBOutlet weak var btnC5: UIButton!
    @IBOutlet weak var txtViewC5: UITextView!
    @IBOutlet weak var imgR1: UIImageView!
    @IBOutlet weak var btnR1: UIButton!
    @IBOutlet weak var txtViewR1: UITextView!
    @IBOutlet weak var imgR2: UIImageView!
    @IBOutlet weak var btnR2: UIButton!
    @IBOutlet weak var txtViewR2: UITextView!
    @IBOutlet weak var imgR3: UIImageView!
    @IBOutlet weak var btnR3: UIButton!
    @IBOutlet weak var txtViewR3: UITextView!
    @IBOutlet weak var imgR4: UIImageView!
    @IBOutlet weak var btnR4: UIButton!
    @IBOutlet weak var txtViewR4: UITextView!
    @IBOutlet weak var lblAgenda: UILabel!
    @IBOutlet weak var imgR5: UIImageView!
    @IBOutlet weak var btnR5: UIButton!
    @IBOutlet weak var txtViewR5: UITextView!
//    @IBOutlet weak var btnMediaCheck: UIButton!
//    @IBOutlet weak var imgR6: UIImageView!
//    @IBOutlet weak var btnR6: UIButton!
//    @IBOutlet weak var textViewR6: UITextView!
    @IBOutlet weak var lblMetting: UILabel!
    @IBOutlet weak var btnselectedDate: UIButton!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var pickerSubCategory: UIPickerView!
    @IBOutlet weak var pickerSubToSubCategory: UIPickerView!
    @IBOutlet weak var pickerFundinglist: UIPickerView!
    @IBOutlet weak var pickermetting: UIPickerView!
    @IBOutlet weak var viewBenPopup: UIView!
 // @IBOutlet weak var txtPhotoRotDesc: UITextView!
    @IBOutlet weak var txtRotDesc: UITextView!
    @IBOutlet weak var viewDatepicker: UIView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var txtSubtoSubCategory: UITextField!
    @IBOutlet weak var txtFundName: UITextField!
    @IBOutlet weak var txtCategoryNew: UITextField!
    @IBOutlet weak var txtSubCategoryNew: UITextField!
    @IBOutlet weak var btnSubCategoryDrop: UIButton!
    @IBOutlet weak var btnSubToSubCategoryDrop: UIButton!
    @IBOutlet weak var btnFundName: UIButton!
    @IBOutlet weak var txtRotatiran: UITextField!
    @IBOutlet weak var txtmanHours: UITextField!
    @IBOutlet weak var txtBenificary: UITextField!
    @IBOutlet weak var txtCost: UITextField!
  //@IBOutlet weak var lblPhotoDesc: UILabel!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtAttendancePercent: UITextField!
    @IBOutlet weak var txtRotractors: UITextField!
    @IBOutlet weak var txtAttendance: UITextField!
    @IBOutlet weak var txtMettingType: UITextField!
    @IBOutlet weak var txtSelectDate: UITextField!
    @IBOutlet weak var datePickers: UIDatePicker!
    @IBOutlet weak var btnOpacity: UIButton!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var viewSubToSubCategory: UIView!
    @IBOutlet weak var viewMettingType: UIView!
    @IBOutlet weak var viewAddEditCancel: UIView!
    @IBOutlet weak var viewFunding: UIView!
    @IBOutlet weak var lblPopup1: UILabel!
    @IBOutlet weak var lblPopup2: UILabel!
    @IBOutlet weak var lblPopup3: UILabel!
    //    @IBOutlet weak var imgAddPhoto: UIImageView!
    //    @IBOutlet weak var imgAddPhotoRotatery: UIImageView!
    @IBOutlet weak var txtRotetoryTitle: UITextField!
    @IBOutlet weak var tblRotary: UITableView!
    @IBOutlet weak var tblClube: UITableView!
    //   @IBOutlet weak var txtDesc: UITextView!
    //   @IBOutlet weak var lblDesc: UILabel!
    //   @IBOutlet weak var btnAddCross: UIButton!
    @IBOutlet weak var txtSelectedDateRot: UITextField!
    //   @IBOutlet weak var btnAddcrossClube: UIButton!
    @IBOutlet weak var btnAddEdit: UIButton!

    @IBOutlet weak var balancedWhatsappLbl: UILabel!
    @IBAction func switchOnOffBtn(_ sender: Any) {
        functionForButtonAllMemberSelectOrNot()
    }
    var AllMemberCheckUnCheck :String = ""
    var AllNonSmartPhoneCheckUncheck:String = ""
    var SMSCountStr : String!
    @IBOutlet weak var whatsappOnOffBtn: UIButton!
    
    @objc func backClicked()
    {
        self.hideFloatButtonDelegate?.hideFloatAction()
//        self.checkAtleastOneImfFilled()
        self.checkingEmptyImg()
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkingEmptyImg() {
        if (strimageC1 != nil) || (strimageC2 != nil) || (strimageC3 != nil) || (strimageC4 != nil) || (strimageC5 != nil) {
//        if (self.photoIDArray.count > 0) {
            self.isimageSelect = "yes"
        } else {
            self.isimageSelect = "No"
        }
            
            
    }
    
//for whatsapp button
    func functionForButtonAllMemberSelectOrNot()
    {
        print(MemberCount)
        print(SMSCountStr)
        if SMSCountStr >= MemberCount || (self.SMSCountStr != "0" || self.SMSCountStr != "")
        {
        
            if issendwhatsapp == "1"{
                whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                issendwhatsapp = "0"
            }
            else{
                whatsappOnOffBtn.setImage(UIImage(named: "switchOn"),  for:
                                            UIControl.State.normal)
                    issendwhatsapp = "1"
            }
        }
        else{
//            whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
//            issendwhatsapp = "0"
////            {
//                let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
//                alert.addAction(ok)
//                present(alert, animated: true, completion: nil)
//            }
          
            
            if issendwhatsapp == "1"{
                whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
                issendwhatsapp = "0"
            }
            else{
                let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            
        }
        
        
//        if(self.SMSCountStr == "0" || self.SMSCountStr == "")
//        {
//            let alert = UIAlertController(title: "Rotary India", message: "Balance whatsapp count is 0. Please recharge", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//        }
//        else
//        {
//            if(AllMemberCheckUnCheck == "Unchecked" )
//            {
//                //UN_CHECK_BLUE_ROW
//
////                if self.textViewDescription.text.count<=0
////                {
////                    let alert = UIAlertController(title: "Rotary India", message: "Please enter description.", preferredStyle: .alert)
////                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
////                    alert.addAction(ok)
////                    present(alert, animated: true, completion: nil)
////                    self.textViewDescription.becomeFirstResponder()
////                }
////                else if self.textViewDescription.text.count>2000
////                {
////                    let alert = UIAlertController(title: "Rotary India", message: "Description cannot be more than 2000 characters for SMS.", preferredStyle: .alert)
////                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
////                    alert.addAction(ok)
////                    present(alert, animated: true, completion: nil)
////                }
////                else if(buttonSelectPublishDate.titleLabel?.text == "  Select Date and Time  " && buttonSelectPublishDate.title( for: UIControl.State.normal)=="  Select Date and Time  ")
////                {
////                    print(buttonSelectPublishDate.titleLabel?.text)
////                    let alert = UIAlertController(title: "Rotary India", message: "Please enter publish date.", preferredStyle: .alert)
////                    let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
////                    alert.addAction(ok)
////                    present(alert, animated: true, completion: nil)
////                }
////                else
////                {
////                    whatsappOnOffBtn.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
////                    buttonNonSmartPhoneUsersCheckUncheck.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
//                    AllMemberCheckUnCheck = "Checked"
//                    AllNonSmartPhoneCheckUncheck = "AllNonSmartUserUnCheck"
////                    val = "1"
////                    if isCategory=="1"
////                    {
////                  //  self.getAnnounceSMSCountdetails()
////                    }
////                }
//            }
//            else if(AllMemberCheckUnCheck == "Checked")
//            {
////                whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
//                AllMemberCheckUnCheck = "Unchecked"
////                val = "0"
//            }
//
////            if(val == "0")
////            {
////                allSMSFlag="0"
////            }
////            else
////            {
////                allSMSFlag="1"
////                nonSmartSMSFlag="0"
////            }
//        }
    }
    
    func showMBProgress(str:String)
    {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
       loadingNotification.color = .clear
       loadingNotification.activityIndicatorColor = .gray
        //loadingNotification.labelText=str

        loadingNotification.show(true)
    }
 
    
    func showMBProgressForImage(str:String)
    {
      loadingImage = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingImage.mode = MBProgressHUDMode.indeterminate
       loadingImage.color = .clear
        loadingImage.dimBackground=true
       loadingImage.activityIndicatorColor = .black
        //loadingNotification.labelText=str
        loadingImage.show(true)
    }

    func hideMBProgress()
    {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    func createNavigationBarmine()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        print(titleDict as? [NSAttributedString.Key : Any])
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddPhotoNewVC.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    //
    func GetdataForselectProject()
        
    {
//        SVProgressHUD.show()
//        userID = GetUserProfileID
        
//            [typeID=686, type=Gallery, profileID=581428, Financeyear=2021-2022]
        
//        {"fk_group_id":"2765","financeyear":"2021-2022"}
        let params = ["fk_group_id": strGroupId as AnyObject, "financeyear":year as AnyObject, "sharetype":sharetype as AnyObject]
        
        /*-------------------------------------------------------------*/
        
        let url = "http://rotaryindiaapi.rosteronwheels.com/api/Gallery/LoadExistingProject"
        
        print(url)
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
                
            case .success:
                
                // var result = [String:String]()
                
                if response.result.value != nil
                    
                {
                    print( response.result.value)
                    
                    var dictResponseData:NSDictionary=NSDictionary()
                    
                    dictResponseData = response.result.value as! NSDictionary
                    
                    print(dictResponseData)
                    
                    let message = dictResponseData["message"] as! NSString
                    
                    if(message=="success")
                        
                    {
                        if let TBRotaryIndiaModulesResult = dictResponseData["tblExistingResult"] as? NSDictionary
                        {
//                            if TBRotaryIndiaModulesResult.object(forKey: "status") as! String == "0"
//                            {
                                if let RotaryIndiaModulesResult = TBRotaryIndiaModulesResult.object(forKey: "Table") as? NSArray
                                {
                                    self.onlinemuarrayModule=RotaryIndiaModulesResult
                                    if self.onlinemuarrayModule.count>0
                                    {
                                        print(self.onlinemuarrayModule.count)
            //                            self.lblLoading.isHidden=true
            //                            self.indiaCollectionView.isHidden=false
            //                            self.indiaCollectionView.reloadData()

                                    self.selectProjPickerViewww.reloadAllComponents()
                                    }
                                    else
                                    {
                                        print("no dataaa")
            //                            self.lblLoading.text="No result."
                                    }
                                }
//                            }
                            else{
//                                self.lblLoading.text="Could not connect to server"
                            }
                        }
                       
                      }
//                    }
                        
                    else
                    {
                        self.view.makeToast("Something went wrong please try again")
//                        self.view.makeToast("\(self.pageTitle) deleted successfully.", duration: 2, position: CSToastPositionCenter)
//                            self.functionForFetchingAlbumListData()
                    }
                    //SVProgressHUD.dismiss()
                }
            case .failure(_): break
            }
        }
    }
    
    func textfieldGreyOut() {
        globalGrantNoTF.isEnabled = false
        globalGrantNoTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        globalGrantSanTF.isEnabled = false
        globalGrantSanTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        globalGrantAmtRecTF.isEnabled = false
        globalGrantAmtRecTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        globalGrantAmtSpenTF.isEnabled = false
        globalGrantAmtSpenTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        globalGrantHostTF.isEnabled = false
        globalGrantHostTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        globalGrantPartnerTF.isEnabled = false
        globalGrantPartnerTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        csrNameTF.isEnabled = false
        csrNameTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        amtSanCsrTF.isEnabled = false
        amtSanCsrTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        amtRecCsrTF.isEnabled = false
        amtRecCsrTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    func globalTF() {
        globalGrantNoTF.isEnabled = true
        globalGrantNoTF.backgroundColor = UIColor.white
        globalGrantSanTF.isEnabled = true
        globalGrantSanTF.backgroundColor = UIColor.white
        globalGrantAmtRecTF.isEnabled = true
        globalGrantAmtRecTF.backgroundColor = UIColor.white
        globalGrantAmtSpenTF.isEnabled = true
        globalGrantAmtSpenTF.backgroundColor = UIColor.white
        globalGrantHostTF.isEnabled = true
        globalGrantHostTF.backgroundColor = UIColor.white
        globalGrantPartnerTF.isEnabled = true
        globalGrantPartnerTF.backgroundColor = UIColor.white
        csrNameTF.isEnabled = false
        csrNameTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        amtSanCsrTF.isEnabled = false
        amtSanCsrTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        amtRecCsrTF.isEnabled = false
        amtRecCsrTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    func csrTF() {
        csrNameTF.isEnabled = true
        csrNameTF.backgroundColor = UIColor.white
        amtSanCsrTF.isEnabled = true
        amtSanCsrTF.backgroundColor = UIColor.white
        amtRecCsrTF.isEnabled = true
        amtRecCsrTF.backgroundColor = UIColor.white
        globalGrantNoTF.isEnabled = false
        globalGrantNoTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        globalGrantSanTF.isEnabled = false
        globalGrantSanTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        globalGrantAmtRecTF.isEnabled = false
        globalGrantAmtRecTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        globalGrantAmtSpenTF.isEnabled = false
        globalGrantAmtSpenTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        globalGrantHostTF.isEnabled = false
        globalGrantHostTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        globalGrantPartnerTF.isEnabled = false
        globalGrantPartnerTF.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldGreyOut()
        GetdataForselectProject()
        getClubDetails()
        selectProjBtnnnnnn.layer.borderWidth = 1.0
        selectProjBtnnnnnn.layer.borderColor = UIColor .gray.cgColor
        selectProjBtnnnnnn.layer.cornerRadius = 10.0
        
        self.isimageSelect = ""
        
        oneTimeOngoingSelectType = "0"
      NewOrExistingSelectType = "0"
       JoinedOrNotSelectType = "0"
       ClubRole = "0"
        print(self.navTitle)
        
        if (self.navTitle) == ("Add Community Service Project") {
            fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
        }
        else if (self.navTitle) == ("Edit Community Service Project") || (self.navTitle) == ("Edit Club Service"){
            fucntionForGetClubChangeAccordingToDistrictIDAndGetClubListWhenComingFromEdit()
        } else if (self.navTitle) == ("Add Club Service") {
            getClubDetails()
        }
        

        
        Iscreatenew = false
        isselectFromExiting = false
        isOnetimeProject = false
        isOngoingProject = false
        datePickers.setStyle()
        print("This is ADD/Edit Activity Page")
        print(strWitchType)
        print(alertTitle)
        print(checkString)

        self.asignTextToBenificiaryPopup()
        createNavigationBarmine()
        categoryId=""
        subCategoryId=""
        subtoSubCategoryId=""
        AgendaDocID = "0"
        MOMDocID  = "0"
        self.muarrayForMetting.add("Select")
        self.muarrayForMetting.add("Regular")
        self.muarrayForMetting.add("BOD")
        self.muarrayForMetting.add("Assembly")
        self.muarrayForMetting.add("Fellowship")
        self.muarrayForMetting.add("Trust")
        txtAttendancePercent.keyboardType=UIKeyboardType.decimalPad
//        txtSelectDate.text = datePickers.date.formatted
        txtSelectDate.text = ""
        txtSelectedDateRot.text = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        strSelectDate =  formatter.string(from: datePickers.date)

        let imageView = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
//        txtSelectedDateRot.rightViewMode = UITextField.ViewMode.always
//        txtSelectedDateRot.rightView = imageView
        let imageView2 = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView2.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
//        txtSelectDate.rightViewMode = UITextField.ViewMode.always
        txtSelectDate.textFieldFullBorder()
        txtSelectedDateRot.textFieldFullBorder()
        self.viewBenPopup.layer.cornerRadius=20
        txtMettingType.textFieldFullBorder()
        txtCategory.textFieldFullBorder()
        txtSubCategory.textFieldFullBorder()
        txtSubtoSubCategory.textFieldFullBorder()
        txtFundName.textFieldFullBorder()
        txtFundName.text = "Select"
        MurrayPhoto = NSMutableArray()
        MurrayText = NSMutableArray()
        MurrayPhotoID = NSMutableArray()
        logoImagesClube = [UIImage]()
        
//        hiddenViewsofCategory()
//        unHideCategoryViews()

        // Do any additional setup after loading the view.
        self.txtCategoryNew.isEnabled = false
        self.txtSubCategoryNew.isEnabled = false
        self.txtSubCategory.isEnabled = false
        self.txtSubtoSubCategory.isEnabled = false
        self.btnSubCategoryDrop.isEnabled = false
        self.btnSubToSubCategoryDrop.isEnabled = false
//        self.textViewR6.isEditable=false
        self.titleOfNewOngoingProjectTX.delegate = self
        self.txtTitle.delegate = self
        self.txtViewDesc.delegate = self
        self.txtAttendance.delegate=self
        self.txtCost.delegate = self
        self.txtBenificary.delegate = self
        self.txtmanHours.delegate = self
        self.txtRotatiran.delegate = self
        self.txtRotetoryTitle.delegate = self
        self.txtRotDesc.delegate = self

        functionForBODCount()
        self.txtAttendance.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC1))
        imgC1.isUserInteractionEnabled = true
        imgC1.addGestureRecognizer(singleTap)
        
        imgC1.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC1.layer.borderWidth = 1
        
        btnAgenda.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        btnAgenda.layer.borderWidth = 1
        btnAgenda.layer.cornerRadius = 8
        
        btnMinutesofMetting.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        btnMinutesofMetting.layer.borderWidth = 1
        btnMinutesofMetting.layer.cornerRadius = 8
        
        btnAgenda.isEnabled = true
        btnMinutesofMetting.isEnabled = true
        
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC2))
        imgC2.isUserInteractionEnabled = true
        imgC2.addGestureRecognizer(singleTap2)
        
        imgC2.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC2.layer.borderWidth = 1
        
        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC3))
        imgC3.isUserInteractionEnabled = true
        imgC3.addGestureRecognizer(singleTap3)
        
        imgC3.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC3.layer.borderWidth = 1
        
        let singleTap4 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC4))
        imgC4.isUserInteractionEnabled = true
        imgC4.addGestureRecognizer(singleTap4)
        
        imgC4.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC4.layer.borderWidth = 1
        
        let singleTap5 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC5))
        imgC5.isUserInteractionEnabled = true
        imgC5.addGestureRecognizer(singleTap5)
        
        imgC5.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC5.layer.borderWidth = 1
        
        let singleTapR1 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR1))
        imgR1.isUserInteractionEnabled = true
        imgR1.addGestureRecognizer(singleTapR1)
        
        imgR1.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgR1.layer.borderWidth = 1
        
        let singleTapR2 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR2))
        imgR2.isUserInteractionEnabled = true
        imgR2.addGestureRecognizer(singleTapR2)
        
        imgR2.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgR2.layer.borderWidth = 1
        
        let singleTapR3 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR3))
        imgR3.isUserInteractionEnabled = true
        imgR3.addGestureRecognizer(singleTapR3)
        
        imgR3.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgR3.layer.borderWidth = 1
        
        let singleTapR4 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR4))
        imgR4.isUserInteractionEnabled = true
        imgR4.addGestureRecognizer(singleTapR4)
        
        imgR4.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgR4.layer.borderWidth = 1
        
        let singleTapR5 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR5))
        imgR5.isUserInteractionEnabled = true
        imgR5.addGestureRecognizer(singleTapR5)
        
        imgR5.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgR5.layer.borderWidth = 1

        let singleTapR6 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedR6))
//        imgR6.isUserInteractionEnabled = false
//        imgR6.addGestureRecognizer(singleTapR6)
        
//        imgR6.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
       
        
        txtViewDesc.layer.borderWidth = 1.0
        txtViewDesc.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewC1.layer.borderWidth = 1.0
        txtViewC1.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewC2.layer.borderWidth = 1.0
        txtViewC2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewC3.layer.borderWidth = 1.0
        txtViewC3.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewC4.layer.borderWidth = 1.0
        txtViewC4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewC5.layer.borderWidth = 1.0
        txtViewC5.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRotDesc.layer.borderWidth = 1.0
        txtRotDesc.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewR1.layer.borderWidth = 1.0
        txtViewR1.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewR2.layer.borderWidth = 1.0
        txtViewR2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewR3.layer.borderWidth = 1.0
        txtViewR3.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewR4.layer.borderWidth = 1.0
        txtViewR4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtViewR5.layer.borderWidth = 1.0
        txtViewR5.layer.borderColor = UIColor.lightGray.cgColor

//        textViewR6.layer.borderColor = UIColor.lightGray.cgColor
//        self.textViewR6.layer.borderWidth = 1.0
        
        rotaryArray = NSMutableArray()
        Clubearray = NSMutableArray()
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        
        if(self.strWitchType == "Club Service")
        {
        self.checkString = "Club Service"
        self.tblClube.isHidden = false
        self.tblRotary.isHidden = true
        }
        else
        {
        self.checkString = "Service Projects"
        self.tblClube.isHidden = true
        self.tblRotary.isHidden = false
        }

        
        if(isCalledFRom == "Edit"){
//            self.isimageSelect = "yes"
            btnR1.isHidden = true
            btnR2.isHidden = true
            btnR3.isHidden = true
            btnR4.isHidden = true
            btnR5.isHidden = true
//            btnR6.isHidden = true

            btnC1.isHidden = true
            btnC2.isHidden = true
            btnC3.isHidden = true
            btnC4.isHidden = true
            btnC5.isHidden = true
            
            self.title = self.navTitle
            btnAddEdit.setTitle("Update", for: UIControl.State.normal)

            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
             if self.strWitchType == "Service Projects"{
            fucntionForGetClubChangeAccordingToDistrictIDAndGetClubListWhenComingFromEdit()
            }else
             {
                functionForGetAlbumDetails_New()
            }
            
        }else{
            if self.strWitchType == "Service Projects"{
            fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
            }
            btnR1.isHidden = true
            btnR2.isHidden = true
            btnR3.isHidden = true
            btnR4.isHidden = true
            btnR5.isHidden = true
//            btnR6.isHidden = true

            btnC1.isHidden = true
            btnC2.isHidden = true
            btnC3.isHidden = true
            btnC4.isHidden = true
            btnC5.isHidden = true

            strAlbumId  = "0"
            btnAddEdit.setTitle("Add", for: UIControl.State.normal)
            self.title = self.navTitle
            //checkString = "Club Service"
            txtMettingType.text = "Select"
            
            
            //MARK:- code by rajendra jat on  4 dec 4.36pm
            strC="C1"
            
            /* as hitendra told rajendra jat for comment on 23 nov 5.53pm*/
             if(self.strWitchType == "Club Service")
             {
                for i in 00..<5
                {
                    self.MurrayPhotoID?.add(" ")
                    self.MurrayPhoto?.add(" ")
                }
             }
             else
             {
                for i in 00..<5
                {
                    self.MurrayPhotoID?.add(" ")
                    self.MurrayPhoto?.add(" ")
                }
             }
            self.txtCategory.text = "Select"
            self.categoryId=""
            self.txtSubCategory.text! = "Select"
            self.subCategoryId=""
            self.txtSubtoSubCategory.text! = "Select"
            self.subtoSubCategoryId=""

            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
            arrayTempImageIndexHold.add("0")
        }
        
        //code by rajendra jat on 4 dec set tag on textview
        txtViewC1.tag=1
        txtViewC2.tag=2
        txtViewC3.tag=3
        txtViewC4.tag=4
        txtViewC5.tag=5
        
        
        txtViewR1.tag=6
        txtViewR2.tag=7
        txtViewR3.tag=8
        txtViewR4.tag=9
        txtViewR5.tag=10
//        textViewR6.tag=11
        
        
        txtViewC1.delegate = self
        txtViewC2.delegate = self
        txtViewC3.delegate = self
        txtViewC4.delegate = self
        txtViewC5.delegate = self
        txtViewR1.delegate = self
        txtViewR2.delegate = self
        txtViewR3.delegate = self
        txtViewR4.delegate = self
        txtViewR5.delegate = self
//        textViewR6.delegate = self
        //MARK:- SET
    }
    
    func hiddenViewsofCategory() {
        categoryLbl.isHidden = true
        subCategoryLbl.isHidden = true
        btnSubToSubCategoryDrop.isHidden = true
        btnSubCategoryDrop.isHidden = true
        txtSubCategory.isHidden = true
        txtSubtoSubCategory.isHidden = true
        txtCategoryNew.isHidden = true
        txtSubCategoryNew.isHidden = true
    }
    
    
    func asignTextToBenificiaryPopup()
    {
        lblPopup1.text="A limit of \(BenificiaryCount) beneficiaries has been set for each project."
        lblPopup2.text="As this project has more than \(BenificiaryCount) beneficiaries, it will be sent to the Zonal Head of Rotary India for approval."
        lblPopup3.text="Your project will be added with \(BenificiaryCount) beneficiaries at the moment."
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        Image("RoundUncheck")

       
        
        self.header1View.isHidden = false
        self.secondSelectionVieww.isHidden = false
        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
        ongoingProImg.image = UIImage(named: "RoundUncheck")
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
        viewCategory.isHidden = true
        selectProjPickerViewww.isHidden = true
        selectProjListWalaView.isHidden = true
        viewSubCategory.isHidden = true
        viewSubToSubCategory.isHidden = true
        
        if(self.strWitchType == "Service Projects")
        {
            if isAddProject == true {
                let alertWarning = UIAlertView(title:self.alertTitle, message: "The data I will enter is for a service project conducted by my club that has benifitted the community. It is not a club meeting, fellowship meeting, club celebration or any other miscellaneous event. eg. Doctor's day celebration, Birthday, Navratri Celebration and Anniversary celebration of members, etc are NOT considered to be service projects.                                         Please Note:The content posted here will be displayed on the \(titleRIZone) Website, District Website, Club Monthly Report & \(titleRIZone) Integrated Club Website.", delegate:nil, cancelButtonTitle:"I Agree ")
                alertWarning.show()
//                return
            }
        }
       
        isAddProject = false
    
       
        tblRotary.reloadData()
        datePickers.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
        self.view.bringSubviewToFront( btnselectedDate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUploadImgSucceeded(_ response: LoadImageResult!) {
     if self.isMediaCheck=="1"
     {
         DispatchQueue.main.async {
          self.hideMBProgress()
        print("Response of image upload is \(response)")
          if response.status == "0"
          {
           print(response.imageID)
           self.mediaImageID=response.imageID
          }
          else
          {
              self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
        }
      }
     }
    }
//added by shubhs
    
    @IBAction func ongoingProjBtnClickedd(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.oneTimeOngoingSelectType = "2"

//        {
            let alertWarning = UIAlertView(title:"Ongoing/Repeat project", message: "Ongoing Project                                                                     If your club has a Hospital, Dialysis Center, Education Institute etc. and your club keeps adding beneficiaries to this existing project, it is an ongoing project. It’s a lifetime project and not a project for the particular year.                                                          Repeat Project                                                               Any Project that you have conducted before in the same Rotary year under the same or any other area of focus falls under this category.E.g.: You have conducted mask distribution today at a railway station and tomorrow the same activity is conducted in another place or you have done one tree plantation in one village last month and you are conducted one more in another village this month,it is a repeat project. These are just examples. Please upload similar projects conducted under this criteria. ", delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
//            return
//        }
        
        
        
        
        
        
        
        
        
        if isOngoingProject == false {
            
            oneTimeOngoingSelectType = "2"
            
            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            createNewProImg.image = UIImage(named: "RoundUncheck")
            selectExitProjImg.image = UIImage(named: "RoundUncheck")
//            IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
//            IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
//            coHostBtnImg.image = UIImage(named: "RoundUncheck")
//            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            isOnetimeProject = false
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
            
//            IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//            clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
            serviceProFooterView.frame = CGRect(x: 0, y: 245, width: screenWidth, height: 3500)
        }
        else{
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//            createNewProImg.image = UIImage(named: "RoundUncheck")
//            selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
//            IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
//            IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
//            coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
//            leadClubImg.image = UIImage(named: "RoundUncheck")
//            isOnetimeProject = false
//
//            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//            selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//
//            IsJointProjWalaView.frame = CGRect(x: 0, y: 320, width: screenWidth, height: 120)
//            serviceProFooterView.frame = CGRect(x: 0, y: 420, width: screenWidth, height: (screenHeight-420))
        }
    }
    @IBAction func oneTimeProjBtnClickedd(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.NewOrExistingSelectType = "0"
        self.oneTimeOngoingSelectType = "1"
        JoinedOrNotSelectType = "0"
        if isOnetimeProject == false {
//            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
//            ongoingProImg.image = UIImage(named: "RoundUncheck")
            isOngoingProject = false
            oneTimeOngoingSelectType = "1"
            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
//            isOnetimeProject = true
            IsprojYEsImg.image = UIImage(named: "RoundUncheck")
            IsProjNoImg.image = UIImage(named: "RoundUncheck")
//            coHostBtnImg.image = UIImage(named: "RoundUncheck")
//            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            selectProjWalaVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
//            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
//            serviceProFooterView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: (screenHeight-190))
            serviceProFooterView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: (3500))
        }
        else{
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//            isOnetimeProject = false
//            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//            serviceProFooterView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight-100))
        }
//        Image("radio_btn_Check1")

//        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//        ongoingProImg.image = UIImage(named: "RoundUncheck")
    }
    @IBAction func createOngoingProBtnClicked(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        NewOrExistingSelectType = "1"
        JoinedOrNotSelectType = "0"
        Iscreatenew = true
        isselectFromExiting = false
        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
        ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
        createNewProImg.image = UIImage(named: "RoundUncheck")
        selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
        IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
        IsJointProYesImg.image = UIImage(named: "RoundUncheck")
//        coHostBtnImg.image = UIImage(named: "RoundUncheck")
//        leadClubImg.image = UIImage(named: "radio_btn_Check1")
        isOnetimeProject = false
//        clubRoleView.isHidden = true
        selectProjWalaVieww.isHidden = true
        titleOfOngoingWalaView.isHidden = false
        header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
        IsProjWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
        titleOfOngoingWalaView.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 90)
        IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
        clubRoleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        serviceProFooterView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: (3500))
    }
    
    @IBAction func selectFromExitingBtnClickedd(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        isselectFromExiting = true
Iscreatenew = false
        NewOrExistingSelectType = "2"
        JoinedOrNotSelectType = "0"
            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        selectProjWalaVieww.isHidden = false
        titleOfOngoingWalaView.isHidden = true
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            createNewProImg.image = UIImage(named: "radio_btn_Check1")
            selectExitProjImg.image = UIImage(named: "RoundUncheck")
            IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            IsJointProYesImg.image = UIImage(named: "RoundUncheck")
//            coHostBtnImg.image = UIImage(named: "RoundUncheck")
//            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            isOnetimeProject = false
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
        selectProjWalaVieww.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 80)
            IsJointProjWalaView.frame = CGRect(x: 0, y: 335, width: screenWidth, height: 80)
            clubRoleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
       
            serviceProFooterView.frame = CGRect(x: 0, y: 415, width: screenWidth, height: (3500))
   
    }
    
    @IBAction func IsProjYesBtnClickedd(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        JoinedOrNotSelectType = "1"
        
        isOngoingProject = false
        isOnetimeProject = true
        oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
        ongoingProImg.image = UIImage(named: "RoundUncheck")
        
        
        
//            isOnetimeProject = true
        IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
        IsProjNoImg.image = UIImage(named: "RoundUncheck")
            coHostBtnImg.image = UIImage(named: "RoundUncheck")
            leadClubImg.image = UIImage(named: "RoundUncheck")
        header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
        IsJointProjWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        selectProjWalaVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
            clubRoleView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: 233)
        serviceProFooterView.frame = CGRect(x: 0, y: 508, width: screenWidth, height: (3500))
    }
    @IBAction func IsProNoBtnClickedd(_ sender: Any) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        

        JoinedOrNotSelectType = "2"
//        if isOnetimeProject == true {
//            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
//            ongoingProImg.image = UIImage(named: "RoundUncheck")
            isOngoingProject = false
            
            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
//            isOnetimeProject = true
            IsprojYEsImg.image = UIImage(named: "RoundUncheck")
            IsProjNoImg.image = UIImage(named: "radio_btn_Check1")
//            coHostBtnImg.image = UIImage(named: "RoundUncheck")
//            leadClubImg.image = UIImage(named: "radio_btn_Check1")
        
        // TODO: Mani changes
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
//            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
            serviceProFooterView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: (3500))
        // TODO: Mani changes
//        }
//        else{
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//            isOnetimeProject = false
//            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//            serviceProFooterView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight-100))
//        }
//        Image("radio_btn_Check1")

//        oneTimeProjImg.image = UIImage(named: "RoundUncheck")
//        ongoingProImg.image = UIImage(named: "RoundUncheck")
    }
    // MARK: - Action method
    func functionForHideKeyBoard()
    {
        
        txtAttendance.resignFirstResponder()
        txtAttendancePercent.resignFirstResponder()
        txtRotetoryTitle.resignFirstResponder()
        txtTitle.resignFirstResponder()
        titleOfNewOngoingProjectTX.resignFirstResponder()
        txtRotDesc.resignFirstResponder()
        txtViewDesc.resignFirstResponder()
        txtViewC1.resignFirstResponder()
        txtSelectDate.resignFirstResponder()
        txtCategoryNew.resignFirstResponder()
        txtCategory.resignFirstResponder()
        txtSubCategory.resignFirstResponder()
        txtSubCategoryNew.resignFirstResponder()
        txtSubtoSubCategory.resignFirstResponder()
        txtViewR1.resignFirstResponder()
        txtCost.resignFirstResponder()
        txtViewR1.resignFirstResponder()
        txtViewR2.resignFirstResponder()
        txtViewR3.resignFirstResponder()
        txtViewR4.resignFirstResponder()
        txtViewR5.resignFirstResponder()
//        textViewR6.resignFirstResponder()
        txtRotractors.resignFirstResponder()
        txtViewC1.resignFirstResponder()
        txtViewC2.resignFirstResponder()
        txtViewC3.resignFirstResponder()
        txtViewC4.resignFirstResponder()
        txtViewC5.resignFirstResponder()
        txtBenificary.resignFirstResponder()
        txtmanHours.resignFirstResponder()
        txtMettingType.resignFirstResponder()
        txtRotatiran.resignFirstResponder()
        txtRotetoryTitle.resignFirstResponder()
    }
    
    @IBAction func AgendaAction(_ sender: Any) {
       functionForHideKeyBoard()
       if(CheckAgend == "X"){
            CheckAgend  = ""
            self.lblAgenda.text = "Agenda"
            self.lblAgendaDownloaded.isHidden = true
            self.btnAgenda.setTitle("Attach File", for: UIControl.State.normal)
            AgendaDocID="0"
//        var imageData:Data=Data()
//        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
//        wsm.delegate=self
//        wsm.uploadToServer(usingDocuments: imageData, andFileName: "", moduleName: "")
        }
        else{
        strAgendaMetting = "Agenda"
            self.lblAgendaDownloaded.isHidden = false
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        // 2
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
        })
        let DropBoxAction = UIAlertAction(title: "DropBox", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(AddPhotoNewVC.DropboxAction), userInfo: nil, repeats: false)
        })
 
        let DocAction = UIAlertAction(title: "Document", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(AddPhotoNewVC.OpenBrowser), userInfo: nil, repeats: false)
        })

        // 4
        optionMenu.addAction(CancelAction)
        if let systemVersion = (UIDevice.current.systemVersion
         as? NSString)?.integerValue
        {
            if systemVersion >= 11
            {
                optionMenu.addAction(DocAction)
            }
        }
        optionMenu.addAction(DropBoxAction)
        //optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
        }
    }
   
    @IBAction func MinutesOfMetting(_ sender: Any) {
        functionForHideKeyBoard()

        if(CheckMettng == "X"){
            CheckMettng  = ""
            self.lblMeetingDownloaded.isHidden = true
            self.lblMetting.text = "Minutes Of Meeting"
            self.btnMinutesofMetting.setTitle("Attach File", for: UIControl.State.normal)
             MOMDocID = "0"
//            var imageData:Data=Data()
//            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
//            wsm.delegate=self
//            wsm.uploadToServer(usingDocuments: imageData, andFileName: "", moduleName: "")
        }
        else{
         strAgendaMetting = "MinutesAndMetting"
            self.lblMeetingDownloaded.isHidden = false
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        // 2
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
        })
        let DropAction = UIAlertAction(title: "Dropbox", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(AddPhotoNewVC.DropboxAction), userInfo: nil, repeats: false)
        })
            
        let DocAction = UIAlertAction(title: "Document", style: .default, handler: {
                 (alert: UIAlertAction!) -> Void in
  
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(AddPhotoNewVC.OpenBrowser), userInfo: nil, repeats: false)
             })
        
        // 4
        optionMenu.addAction(CancelAction)
       if let systemVersion = (UIDevice.current.systemVersion
         as? NSString)?.integerValue
        {
            if systemVersion >= 11
            {
                optionMenu.addAction(DocAction)
            }
        }
        optionMenu.addAction(DropAction)
        //optionMenu.addAction(cancelAction)
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    @objc func DropboxAction()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            
            OpenDropBox()
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    //////////----------------
   @objc func OpenBrowser()
    {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
    let cico = url as URL
    print(cico)
    print(url)
    SVProgressHUD.show()
    print(url.lastPathComponent)
    strFileNameWithExtension=url.lastPathComponent as String
    print(url.pathExtension)
        let newString=url.pathExtension

            let imageUrl = url
            print("Image URL:: \(imageUrl)")
        var imageData:Data=Data()
            do{
             imageData = try Data(contentsOf: imageUrl)
        }
        catch let error
        {
            print("Error while uploading pdf \(error)")
            SVProgressHUD.dismiss()
            return
        }
        
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        
        if(newString.contains(".pdf") || newString.contains(".PDF") || newString.contains("pdf") )
        {
            let imageSize: Int = imageData.count
            print("size of image in KB: %f ", Double(imageSize) / 1024.0)
            var getdocSize:Double=Double(imageSize) / 1024.0
            getdocSize=getdocSize/1024.0
            if(getdocSize>10.0)
            {
                self.view.makeToast("File size can not be more than 10 MB", duration: 5, position: CSToastPositionBottom)
         SVProgressHUD.dismiss()
     }
     else
     {
         if(self.strAgendaMetting == "Agenda"){
         }
         else{
         }
         wsm.uploadToServer(usingDocuments: imageData, andFileName: "gallery.pdf", moduleName: "gallery")
      //  SVProgressHUD.disdfsmiss()
     }
 }
 else if(newString.contains(".doc") || newString.contains(".DOC") || newString.contains("doc") || newString.contains("docx"))
 {
    if(self.strAgendaMetting == "Agenda"){
    }
    else{
     }
     wsm.uploadToServer(usingDocuments: imageData, andFileName: "gallery.docx", moduleName: "gallery")
 }
 else{
       SVProgressHUD.dismiss()
       self.view.makeToast("Only pdf or doc file can be attached", duration: 3, position: CSToastPositionCenter)
        }
    }
    
    func OpenDropBox()
    {
 SVProgressHUD.show()
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
 {
     DBChooser.default().open(for: DBChooserLinkTypeDirect, from: self, completion: { reasults in
        if let data = reasults as! [DBChooserResult]!
        {
print("data[0].link.description :-: \(data[0].link.description)")
   self.PDFLinkDrpBx = data[0].link.description

   
   let fullNameArr = self.PDFLinkDrpBx.split{$0 == "."}.map(String.init)

  print("Full Array ---------------",fullNameArr)
  print(fullNameArr[0]) // First
  print(fullNameArr[1]) // Last)
  print(fullNameArr[2]) // First
  print(fullNameArr[3]) // Last)
  
  self.PDFTypeFromDrpBx = String(format:".%@",fullNameArr[3])
 let newString =  self.PDFLinkDrpBx
  print("this is pdf extension !!!!")
  print(newString)
  
  if(newString.contains(".pdf") || newString.contains(".PDF") || newString.contains("pdf") )
  {
  
      let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)

      print(urlSlices[0]) // First
      print(urlSlices[1]) // Last)
      print(urlSlices[2]) // First
      print(urlSlices[3]) // Last)
      print(urlSlices[4]) // First
      print(urlSlices[5]) // Last)
          let imageUrlString = newString
          let imageUrl = URL(string: imageUrlString)!
          print("Image URL:: \(imageUrl)")
      var imageData:Data=Data()
          do{
           imageData = try Data(contentsOf: imageUrl)
      }
      catch let error
      {
          print("Error while uploading pdf \(error)")
          SVProgressHUD.dismiss()
          return
      }
       //let image = UIImage(data: imageData)
      var imageSize: Int = imageData.count
      print("size of image in KB: %f ", Double(imageSize) / 1024.0)
      var getdocSize:Double=Double(imageSize) / 1024.0
      getdocSize=getdocSize/1024.0
      print(getdocSize)
      if(getdocSize>10.0)
      {
          self.view.makeToast("File size can not be more than 10 MB", duration: 5, position: CSToastPositionBottom)
          SVProgressHUD.dismiss()
      }
      else
      {
          let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
          wsm.delegate=self
          //newString
          self.strFileNameWithExtension=String(format:"%@",urlSlices[5])
          if(self.strAgendaMetting == "Agenda"){
          }
          else{
          }
          
          wsm.uploadToServer(usingDocuments: imageData, andFileName: "gallery.pdf", moduleName: "gallery")
       //  SVProgressHUD.disdfsmiss()
      }
  }
   
 else if(newString.contains(".doc") || newString.contains(".DOC") || newString.contains("doc") || newString.contains("docx"))
 {
     
     //let urlSlices = self.PDFLinkDrpBx
    
     let urlSlices = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)

     print(urlSlices[0]) // First
     print(urlSlices[1]) // Last)
     print(urlSlices[2]) // First
     print(urlSlices[3]) // Last)
     print(urlSlices[4]) // First
     print(urlSlices[5]) // Last)
//                        let urlSlicese = self.PDFLinkDrpBx.characters.split{$0 == "/"}.map(String.init)

                        print("this si url")
                       // print(urlSlicese)
//
//                        let aString = urlSlices[5]
                        let newString =  self.PDFLinkDrpBx
                        
//                        var replaced = newString.replacingOccurrences(of: "%20", with: "")
//                        replaced = replaced.replacingOccurrences(of: "%28", with: "(")
//                        replaced = replaced.replacingOccurrences(of: "%29", with: ")")
    self.strFileNameWithExtension=String(format:"%@",urlSlices[5])
    if(urlSlices[5].hasSuffix(".doc") || urlSlices[5].hasSuffix(".DOC") || urlSlices[5].hasSuffix("doc")  || newString.contains("docx"))
   {
   if(self.strAgendaMetting == "Agenda"){
   }
   else{
    }
    let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
    wsm.delegate=self
    let imageUrl = URL(string: newString)!
    print("Dropbox url:----!!!")
    print(imageUrl)
    let imageData = try! Data(contentsOf: imageUrl)
    wsm.uploadToServer(usingDocuments: imageData, andFileName: "gallery.docx", moduleName: "gallery")
    }
    else
        
    {
        SVProgressHUD.dismiss()
        self.view.makeToast("Only pdf or doc file can be attached", duration: 3, position: CSToastPositionCenter)
        
    }
  //  SVProgressHUD.dismiss()
     }
   
     else{
           SVProgressHUD.dismiss()
           self.view.makeToast("Only pdf or doc file can be attached", duration: 3, position: CSToastPositionCenter)
     }
   
     self.imageCondition = false
     self.PDFCondition = true
 }
 else
 {
    // SVProgressHUD.dismeeeeiss()
 }
 
 //            let url = NSURL(string: String(format:"%@",data[0].link.description))!
 //            self.downloadTask = self.backgroundSession.downloadTaskWithURL(url)
 //            self.downloadTask.resume()
 
 //self.fileInDocumentsDirectory("file.pdf")
 //print(self.fileInDocumentsDirectory("file.pdf"))
     })
     //    */
     
 }
 else
 {
     self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
 }
 
 /////rajendra jat code here for programming herer ererre
 
 ////rajednra jat code hrere fro profgramming here errre
    }
    
     func getUploadDocSucceeded(_ response: LoadImageResult) {
        
     print("this isresponse !!!!")
        print(response)
        print(strAgendaMetting)
        print("Successfully Uploaded file \(strAgendaMetting) ")
        if strAgendaMetting ==  "MinutesAndMetting" {
            DispatchQueue.main.async {
             print(response.imageID)
                self.MOMDocID = response.imageID
            self.CheckMettng = "X"
                self.lblMeetingDownloaded.text =  self.strFileNameWithExtension
            self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
            }
        }
        else if strAgendaMetting ==  "Agenda" {
            DispatchQueue.main.async {
             print(response.imageID)
                self.AgendaDocID = response.imageID
               self.CheckAgend = "X"
                self.lblAgendaDownloaded.text = self.strFileNameWithExtension
            self.btnAgenda.setTitle("X", for: UIControl.State.normal)

            }
        }
        SVProgressHUD.dismiss()
    }
    
    
    
    @IBAction func CloseR1Action(_ sender: Any) {
        functionForHideKeyBoard()
        isImageThere = "false"
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR1.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![0] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgR1.image = UIImage.init(named: "AddPic")
            self.btnR1.isHidden = true
            self.strimageR1 = nil
            
            
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    @IBAction func CloseR2Action(_ sender: Any) {
        functionForHideKeyBoard()
        isImageThere = "false"
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR2.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![1] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgR2.image = UIImage.init(named: "AddPic")
            self.btnR2.isHidden = true
            self.strimageR2 = nil
            
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 1, with: "0")
            self.MurrayPhoto?.replaceObject(at: 1, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    @IBAction func CloseR3Action(_ sender: Any) {
        functionForHideKeyBoard()
        isImageThere = "false"
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR3.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![2] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgR3.image = UIImage.init(named: "AddPic")
            self.btnR3.isHidden = true
            self.strimageR3 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 2, with: "0")
            self.MurrayPhoto?.replaceObject(at: 2, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    @IBAction func CloseR4Action(_ sender: Any) {
        functionForHideKeyBoard()
        isImageThere = "false"
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR4.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![3] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgR4.image = UIImage.init(named: "AddPic")
            self.btnR4.isHidden = true
            self.strimageR4 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 3, with: "0")
            self.MurrayPhoto?.replaceObject(at: 3, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    @IBAction func CloseR5Action(_ sender: Any) {
        functionForHideKeyBoard()
        isImageThere = "false"
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR5.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![4] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgR5.image = UIImage.init(named: "AddPic")
            self.btnR5.isHidden = true
            self.strimageR5 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 4, with: "0")
            self.MurrayPhoto?.replaceObject(at: 4, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func CloseR6Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
           // if(self.isCalledFRom == "Edit"){
                
//                self.imgR6.isUserInteractionEnabled = true
               // self.funcCallDeletePhoto(strPhotoId: self.mediaImageID)
                self.CheckDelete = "Delete"
          //  }
//            self.imgR6.image = UIImage.init(named: "AddPic1")
//            self.btnR6.isHidden = true
            self.strimageR6 = nil
            self.mediaImageID="0"
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func CloseC1Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC1.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![0] as! String)
                self.CheckDelete = "Delete"
            }
            
            
            self.imgC1.image = UIImage.init(named: "AddPic")
            self.btnC1.isHidden = true
            self.strimageC1 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
            
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func CloseC2Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC2.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![1] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgC2.image = UIImage.init(named: "AddPic")
            self.btnC2.isHidden = true
            self.strimageC2 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 1, with: "0")
            self.MurrayPhoto?.replaceObject(at: 1, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    @IBAction func CloseC3Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC3.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![2] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgC3.image = UIImage.init(named: "AddPic")
            self.btnC3.isHidden = true
            self.strimageC3 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 2, with: "0")
            self.MurrayPhoto?.replaceObject(at: 2, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func CloseC4Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC4.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![3] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgC4.image = UIImage.init(named: "AddPic")
            self.btnC4.isHidden = true
            self.strimageC4 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 3, with: "0")
            self.MurrayPhoto?.replaceObject(at: 3, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    @IBAction func CloseC5Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                self.imgC5.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![4] as! String)
                self.CheckDelete = "Delete"
            }
            self.imgC5.image = UIImage.init(named: "AddPic")
            self.btnC5.isHidden = true
            self.strimageC5 = nil
            
            //--------
            self.arrayTempImageIndexHold.replaceObject(at: 4, with: "0")
            self.MurrayPhoto?.replaceObject(at: 4, with: "0")
            self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
        }

        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
            
        }
        
        // Add Actions
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
   }

    @IBAction func checkMediaClickEvent(_ sender: Any) {
        if isMediaCheck=="0"
        {
            isMediaCheck="1"
//            btnMediaCheck.setImage(UIImage(named: "CheckBlue"), for: .normal)
//            imgR6.isUserInteractionEnabled=true
//            textViewR6.isEditable=true
//            btnR6.isEnabled=true
//            imgR6.layer.borderWidth = 1
        }
        else if isMediaCheck=="1"
        {
            isMediaCheck="0"
//            btnMediaCheck.setImage(UIImage(named: "UncheckBlue"), for: .normal)
//            imgR6.isUserInteractionEnabled=false
//            textViewR6.isEditable=false
//            btnR6.isEnabled=false
//            imgR6.layer.borderWidth = 0
//            imgR6.image = UIImage.init(named: "AddPic1")
        }
    }

    @IBAction func btnPopupConfirmClickEvent(_ sender: Any) {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
               self.flagExceedBenificiary="1"
//               btnAddEdit.isEnabled=false
               self.btnOpacity.isHidden=true
               self.viewBenPopup.isHidden=true
               self.viewAddEditCancel.isHidden=false
//            if (checkString == "Service Projects") {
                if isimageSelect == "yes" {
                    SendDataToserver()
                }
                else{
                    self.view.makeToast("One image is mandatory")
                }
//            }
//            else{
//                SendDataToserver()
//            }
               
        }
        else
        {
             self.view.makeToast("No internet connection. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    @IBAction func btnPopupCancelClickEvent(_ sender: Any) {
        self.btnOpacity.isHidden=true
        self.btnAddEdit.isEnabled=true
        self.viewBenPopup.isHidden=true
        self.viewAddEditCancel.isHidden=false
    }
    
    //for whatsapp count
    func getClubDetails()
    {
        //loaderViewMethod()
        let completeURL:String! = baseUrl+row_ClubInfoDetails
        var parameterst:NSDictionary=NSDictionary()
        parameterst = ["grpID":strGroupId as Any]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable : Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            print(response)
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let MeetingPlace =    ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "MeetingPlace") as! String
                let smsCount = ((dd.object(forKey: "TBGetGroupResult")! as AnyObject).object(forKey: "getGroupDetailResult")! as AnyObject).object(forKey: "SMSCount") as! String
                if self.isCalledFRom=="add"
                {
//                self.MeetingPlace = MeetingPlace
//                let cell : HeaderCelll = self.self.cellArray.object(at: 0) as! HeaderCelll

//                cell.eventVenueTextView.text! = self.MeetingPlace
                self.SMSCountStr = smsCount
//                let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
//                self.addEventTableView.reloadData()
               // self.window = nil
              }
                if self.isCalledFRom=="Edit"
                {
//                    let cell1 : SmsQuestionCell = self.cellArray.object(at: 4) as! SmsQuestionCell
                    self.SMSCountStr = smsCount
                    print(self.SMSCountStr)
                    self.balancedWhatsappLbl.text="Balance WhatsApp : "+self.SMSCountStr
//                    self.addEventTableView.reloadData()
                }
            }
            else
            {
                //self.window = nil
            }
            SVProgressHUD.dismiss()
            }
        })
    }
    
    func unHideCategoryViews() {
        if (txtCategory.text == "Others"){
            txtCategoryNew.isEnabled = true
        }
        if (txtCategory.text != "") && (txtCategory.text == "Others"){
            txtSubCategory.isEnabled = false
            btnSubCategoryDrop.isEnabled = true
        }
        if (txtSubCategory.text == "Others") {
            txtSubCategoryNew.isEnabled = true
        }
        if (txtSubCategory.text != "") || (txtSubCategory.text == "Others"){
            txtSubtoSubCategory.isEnabled = true
            btnSubToSubCategoryDrop.isEnabled = true
        }
    }

    @IBAction func AddAction(_ sender: Any) {
    functionForHideKeyBoard()
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
    if( checkString == "Club Service"){
      
      if(txtSelectDate.text == ""){
          
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select date.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }else if(txtMettingType.text == "Select") {
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Meeting Type.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }
      else if(txtTitle.text == ""){
          
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Title.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
          
      }else if(txtViewDesc.text == ""){
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Description.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }
      else{
//              btnAddEdit.isEnabled=false
          checkingEmptyImg()
//        if (checkString == "Service Projects") {
          print("isImageThere::  \(isImageThere)")
            if isImageThere == "true" {
                SendDataToserver()
            }
            else{
                self.view.makeToast("One image is mandatory")
            }
//        }
//        else{
//            SendDataToserver()
//        }
      
             
      }
  }
  
  else if(checkString == "Service Projects"){
    
    print(oneTimeOngoingSelectType)
    print(NewOrExistingSelectType)
    print(JoinedOrNotSelectType)
    print(ClubRole)
        print("Value of Fund ID \(self.fundID)")
    let titleBtn = selectProjBtnnnnnn.title(for: UIControl.State.normal)
    print(titleBtn)
     if oneTimeOngoingSelectType == "0" || oneTimeOngoingSelectType == "" || oneTimeOngoingSelectType == nil
    {
        let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select project type.", delegate:nil, cancelButtonTitle:"OK")
         alertWarning.show()
         return
    }
    else if oneTimeOngoingSelectType == "2" {
         if NewOrExistingSelectType == "0" || NewOrExistingSelectType == "" || NewOrExistingSelectType == nil
          {
              let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select project is new or exiting.", delegate:nil, cancelButtonTitle:"OK")
               alertWarning.show()
               return
          }
         
//        titleOfNewOngoingProjectTX
         
     else if NewOrExistingSelectType == "1" || NewOrExistingSelectType == "2"
       {
           if(titleOfNewOngoingProjectTX.text == "" && NewOrExistingSelectType == "1" ){
              let alertWarning = UIAlertView(title:self.alertTitle, message: "Title of new Ongoing/Repeat projects.", delegate:nil, cancelButtonTitle:"OK")
              alertWarning.show()
              return
          }
//       else if(titleOfNewOngoingProjectTX.text != "" && NewOrExistingSelectType == "1" ){
//           let alertWarning = UIAlertView(title:self.alertTitle, message: "please select project is joint with any other rotary club or not.", delegate:nil, cancelButtonTitle:"OK")
//           alertWarning.show()
//           return
//       }
           else if (titleOfNewOngoingProjectTX.text != "" && NewOrExistingSelectType == "1" && (JoinedOrNotSelectType == "0" || JoinedOrNotSelectType == "" || JoinedOrNotSelectType == nil)){
            let alertWarning = UIAlertView(title:self.alertTitle, message: "please select project is joint with any other rotary club or not.", delegate:nil, cancelButtonTitle:"OK")
             alertWarning.show()
             return
           }
           else if (titleBtn == nil && NewOrExistingSelectType == "2"){
            let alertWarning = UIAlertView(title:self.alertTitle, message: "please select ongoing main project.", delegate:nil, cancelButtonTitle:"OK")
             alertWarning.show()
             return
           }
           else if (titleBtn != "" && NewOrExistingSelectType == "2" && (JoinedOrNotSelectType == "0" || JoinedOrNotSelectType == "" || JoinedOrNotSelectType == nil)){
            let alertWarning = UIAlertView(title:self.alertTitle, message: "please select project is joint with any other rotary club or not.", delegate:nil, cancelButtonTitle:"OK")
             alertWarning.show()
             return
           }
           else if (titleBtn != "" && NewOrExistingSelectType == "2" && JoinedOrNotSelectType == "1" && (ClubRole == "0" || ClubRole == "" || ClubRole == nil)){
            let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select Club Role as Lead Club or Co-Host.", delegate:nil, cancelButtonTitle:"OK")
             alertWarning.show()
             return
           }
           else if(titleOfNewOngoingProjectTX.text != "" && NewOrExistingSelectType == "1" && JoinedOrNotSelectType == "1" && (ClubRole == "0" || ClubRole == "" || ClubRole == nil)){
               let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select Club Role as Lead Club or Co-Host.", delegate:nil, cancelButtonTitle:"OK")
               alertWarning.show()
               return
           }
           else if JoinedOrNotSelectType == "0" || JoinedOrNotSelectType == "" || JoinedOrNotSelectType == nil
               {
                   let alertWarning = UIAlertView(title:self.alertTitle, message: "please select project is joint with any other rotary club or not.", delegate:nil, cancelButtonTitle:"OK")
                    alertWarning.show()
                    return
               }
        
      else{
          //                {
//                           if let benificiaryCount = Float(self.BenificiaryCount)
//                           {
//                             if let enteredBenificiaryCount = Float(txtBenificary.text!)
//                             {
//                       //        btnAddEdit.isEnabled=false
//          //                     SendDataToserver()
//
//                               btnAddEdit.isEnabled=false
//                               validateBenificiary(floatenteredBenificiary: enteredBenificiaryCount)
//                           }
//          //               }
//                        }
                      }
        
       }
         
         
      else if JoinedOrNotSelectType == "0" || JoinedOrNotSelectType == "" || JoinedOrNotSelectType == nil
          {
              let alertWarning = UIAlertView(title:self.alertTitle, message: "please select project is joint with any other rotary club or not.", delegate:nil, cancelButtonTitle:"OK")
               alertWarning.show()
               return
          }
      
      
    else  if JoinedOrNotSelectType == "1" {
               if ClubRole == "0" || ClubRole == "" || ClubRole == nil
              {
                  let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select Club Role as Lead Club or Co-Host.", delegate:nil, cancelButtonTitle:"OK")
                   alertWarning.show()
                   return
              }
      else{
          //                {
//                           if let benificiaryCount = Float(self.BenificiaryCount)
//                           {
//                             if let enteredBenificiaryCount = Float(txtBenificary.text!)
//                             {
//                       //        btnAddEdit.isEnabled=false
//          //                     SendDataToserver()
//
//                               btnAddEdit.isEnabled=false
//                               validateBenificiary(floatenteredBenificiary: enteredBenificiaryCount)
//                           }
//          //               }
//                        }
                      }
         
          }
       else{
//                {
//               if let benificiaryCount = Float(self.BenificiaryCount)
//               {
//                 if let enteredBenificiaryCount = Float(txtBenificary.text!)
//                 {
//           //        btnAddEdit.isEnabled=false
////                     SendDataToserver()
//
//                   btnAddEdit.isEnabled=false
//                   validateBenificiary(floatenteredBenificiary: enteredBenificiaryCount)
//               }
////               }
//            }
          }
      
      
      }
    else   if JoinedOrNotSelectType == "0" || JoinedOrNotSelectType == "" || JoinedOrNotSelectType == nil
      {
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select project is joint with any other rotary club or not", delegate:nil, cancelButtonTitle:"OK")
           alertWarning.show()
           return
      }
    
    else  if JoinedOrNotSelectType == "1" {
               if ClubRole == "0" || ClubRole == "" || ClubRole == nil
              {
                  let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select Club Role as Lead Club or Co-Host.", delegate:nil, cancelButtonTitle:"OK")
                   alertWarning.show()
                   return
              }
            else{
//                {
//                 if let benificiaryCount = Float(self.BenificiaryCount)
//                 {
//                   if let enteredBenificiaryCount = Float(txtBenificary.text!)
//                   {
//             //        btnAddEdit.isEnabled=false
////                     SendDataToserver()
//
//                     btnAddEdit.isEnabled=false
//                     validateBenificiary(floatenteredBenificiary: enteredBenificiaryCount)
//                 }
//               }
//              }
            }
          }
      if muarrayForCategoryListWithOutZeroIndex.count>0 && categoryId == ""
      {
         let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select area of focus.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }
      else if txtCategory.text=="Others" && txtCategoryNew.text == ""
      {
         let alertWarning = UIAlertView(title:self.alertTitle, message: " Please specify the area of focus.", delegate:nil, cancelButtonTitle:"OK")
        alertWarning.show()
       return
      }
      else if categoryId != "" && txtCategory.text != "Others" && muarrayForSubCategoryList.count>0 && subCategoryId==""
      {
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select category.", delegate:nil, cancelButtonTitle:"OK")
           alertWarning.show()
           return
      }
     

//   el else if oneTimeOngoingSelectType == "1"{
     
//    }

      
       else if txtSubCategory.text=="Others" &&  txtSubCategoryNew.text == "" && subCategoryId != ""
       {
          let alertWarning = UIAlertView(title:self.alertTitle, message: " Please specify the category.", delegate:nil, cancelButtonTitle:"OK")
         alertWarning.show()
        return
       }

      else if subCategoryId != "" && txtSubCategory.text != "Others" && muarrayForSubToSubCategoryList.count>0  && subtoSubCategoryId == ""
          {
              let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select sub category.", delegate:nil, cancelButtonTitle:"OK")
               alertWarning.show()
               return
          }
      else if fundID == "" || fundID == "0" || fundID == nil || txtFundName.text!.count <= 0
       {
        let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select the Source of Funding.", delegate:nil, cancelButtonTitle:"OK")
         alertWarning.show()
         return
       }
      else if(txtSelectedDateRot.text == ""){
          
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select date.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }
      else if(txtCost.text == ""){
          
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Cost.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
          
      }else if(txtBenificary.text == ""){
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Direct Beneficiaries.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }else if(txtmanHours.text == ""){
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Man Hours.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }else if(txtRotatiran.text == ""){
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Rotarians Involved.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
      }else if(txtRotetoryTitle.text == ""){
          let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter Title.", delegate:nil, cancelButtonTitle:"OK")
          alertWarning.show()
          return
  }

  
      else if (isMediaCheck == "1" && (self.mediaImageID == "" || self.mediaImageID == "0"))
 {
           let alertWarning = UIAlertView(title:self.alertTitle, message: "Please upload Print media photo.", delegate:nil, cancelButtonTitle:"OK")
               alertWarning.show()
               return
   }
     
   
   else{
    if let benificiaryCount = Float(self.BenificiaryCount)
    {
      if let enteredBenificiaryCount = Float(txtBenificary.text!)
      {
//        btnAddEdit.isEnabled=false
//        SendDataToserver()
        
//        btnAddEdit.isEnabled=false
        validateBenificiary(floatenteredBenificiary: enteredBenificiaryCount)
    }
  }
 }
    
    
}
}else
{
     self.view.makeToast("No internet connection. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
}
}

    
func validateBenificiary(floatenteredBenificiary:Float)
{
let completeURL = baseUrl+"Gallery/validateDirectBeneficiaries"
var parameterst:NSDictionary=NSDictionary()
if isCalledFRom == "Edit"
{
   parameterst = ["albumId":strAlbumId as Any,"FinancialYear":"2021-2022"]
}
else
{
    parameterst = ["albumId":"0", "FinancialYear":"2021-2022"]
}
    
//    Financeyear=2021-2022]
    print("validate Ben URL: \(completeURL)")
    print("Parameter: \(parameterst)")
SVProgressHUD.show()
ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
let dd = response as! NSDictionary
print("dd \(dd)")
let varGetValueServerError = response.object(forKey: "serverError")as? String
if(varGetValueServerError == "Error")
{
    self.btnAddEdit.isEnabled=true
    SVProgressHUD.dismiss()
    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
}
else
{
SVProgressHUD.dismiss()
if((dd.object(forKey: "TBDirectBeneficiariesResult")! as AnyObject).object(forKey: "status") as! String == "0")
{
if let maxBenificiary = ((dd.object(forKey: "TBDirectBeneficiariesResult")! as AnyObject).object(forKey: "MaxNumber")) as? String
{
self.BenificiaryCount = maxBenificiary
self.asignTextToBenificiaryPopup()
if let floatbenificiaryCount = Float(maxBenificiary){
 if floatenteredBenificiary>floatbenificiaryCount
 {
 if self.isCalledFRom != "Edit"
 {
    //Show Popup
    self.btnOpacity.isHidden=false
    self.viewBenPopup.isHidden=false
    self.viewAddEditCancel.isHidden=true
    self.finalBenificiary = self.BenificiaryCount
    self.finalTempBenificiary = self.txtBenificary.text!
  }
 else if self.isCalledFRom == "Edit"
 {
   if let Approvedbeneficiary = ((dd.object(forKey: "TBDirectBeneficiariesResult")! as AnyObject).object(forKey: "Approvedbeneficiary")) as? String
   {
    if let ApprovedFlag = ((dd.object(forKey: "TBDirectBeneficiariesResult")! as AnyObject).object(forKey: "ApprovedFlag")) as? String
    {
 if let floatapproveBenificiary = Float(Approvedbeneficiary)
 {
  if floatenteredBenificiary != floatapproveBenificiary && ApprovedFlag == "2"
  {
      /*
       case true{
       1. maxBen = 500
       2. enteredBen = 501
       3. approvedAmount = 520
       4. aprroveFlag = 2
       }
       */
      //Show Popup
      self.btnOpacity.isHidden=false
      self.viewBenPopup.isHidden=false
      self.viewAddEditCancel.isHidden=true
      self.finalBenificiary = Approvedbeneficiary
      self.finalTempBenificiary = self.txtBenificary.text!
  }
   else if floatenteredBenificiary == floatapproveBenificiary && ApprovedFlag == "2"
   {
       /*
        case1:{
        1. maxBen = 500
        2. enteredBen = 520
        3. approvedAmount = 520
        4. aprroveFlag =  2
        }
        */
       self.finalBenificiary = self.txtBenificary.text!
       self.finalTempBenificiary = ""
       self.flagExceedBenificiary="2"
//       self.btnAddEdit.isEnabled=false
    
//    if (self.checkString == "Service Projects") {
        if self.isimageSelect == "yes" {
            self.SendDataToserver()
        }
        else{
            self.view.makeToast("One image is mandatory")
        }
//    }
//    else{
//        self.SendDataToserver()
//    }
       
   }
  else
  {
      self.SendDataToserver()
          /*
          case3:{
          1. maxBen = 500
          2. enteredBen = < maxBen
          3. approvedAmount = anything
          4. aprroveFlag = anything
          }
          */
            //Show Popup
            self.btnOpacity.isHidden=false
            self.viewBenPopup.isHidden=false
            self.viewAddEditCancel.isHidden=true
            self.finalBenificiary = self.BenificiaryCount
            self.finalTempBenificiary = self.txtBenificary.text!
          }
        }
      }
    }
  }
}
else
{
    self.finalBenificiary = self.txtBenificary.text!
    self.finalTempBenificiary = ""
    self.flagExceedBenificiary="0"
//    self.btnAddEdit.isEnabled=false
    
//    if (self.checkString == "Service Projects") {
        if self.isImageThere == "true" {
            self.SendDataToserver()
        }
        else{
            self.view.makeToast("One image is mandatory")
        }
//    }
//    else{
//        self.SendDataToserver()
//    }
    
   }
 }
}
}else
{
    self.btnAddEdit.isEnabled=true
}
}
})
}
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField==txtAttendance
        {
            self.txtAttendancePercent.text=""
            
            if txtMettingType.text == "BOD" {
                if self.BodMemCount != ""
                {
//                    let intt = Float(self.BodMemCount)
                   
                    if let memberCount = Float(self.BodMemCount)
                {
                    if let actualMember = Float(textField.text!)
                    {
                        if memberCount != 0 {
                            let attendPer=(Float(actualMember/memberCount)*100.0)
                            
                            self.txtAttendancePercent.text=String(format: "%.0f", attendPer)
                        }
                    }
                 }
              }

            }
            else{
                if self.MemberCount != ""
                {
                    if let memberCount = Float(self.MemberCount)
                {
                    if let actualMember = Float(textField.text!)
                    {
                        if memberCount != 0 {
                            let attendPer=(Float(actualMember/memberCount)*100.0)
                            
                            self.txtAttendancePercent.text=String(format: "%.0f", attendPer)
                        }
                    }
                 }
              }

            }
       }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /* Older versions of Swift */
    // hides text views
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if (text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    
    
    @IBAction func CencelAction(_ sender: Any) {
        
        functionForHideKeyBoard()
        self.hideFloatButtonDelegate?.hideFloatAction()
        self.checkAtleastOneImfFilled()
    }
    
    func checkAtleastOneImfFilled() {
        if (isCalledFRom == "Edit") {
            checkingEmptyImg()
            print(self.isimageSelect)
            if (self.isimageSelect == "yes") {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.makeToast("One image is mandatory")
            }
        } else if (self.navTitle) == ("Add Community Service Project") || (self.navTitle) == ("Add Club Service") {
            self.navigationController?.popViewController(animated: true)
        }

    }

    @IBAction func RotatryAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewCategory.isHidden = false
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
    }

    @IBAction func SubRotatryAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewSubCategory.isHidden = false
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
    }

    @IBAction func SubToSubRotatryAction(_ sender: Any){
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewSubToSubCategory.isHidden = false
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
    }
    
    @IBAction func FundingAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewCategory.isHidden = true
        viewFunding.isHidden = false
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
    }



    @objc func handleDatePicker(sender: UIDatePicker) {
        if isDateisFutureDate(selectedDate: datePickers.date)
        {
            return
        }
        txtSelectDate.text = datePickers.date.formatted
        txtSelectedDateRot.text = datePickers.date.formatted
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        strSelectDate =  formatter.string(from: datePickers.date)
        //print(strSelectDate)
        
        
        functionForBODCount()
    }
    
    func isDateisFutureDate(selectedDate:Date) -> Bool
    {
        let currentDate:Date=Date()
        if currentDate.compare(selectedDate) == .orderedAscending
        {
            var message:String=""
            if checkString == "Club Service"
            {
                message = "Date here cannot be a future date as you are reporting the completion of a meeting."
            }
            else
            {
                message = "Project Completion date cannot be a future date."
            }
            let alertWarning = UIAlertView(title:self.alertTitle, message: message, delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
            let dformatter:DateFormatter=DateFormatter()
            dformatter.dateFormat="dd MMM yyyy"
            let selectedDate=dformatter.date(from: self.txtSelectDate.text ?? "") ?? Date()
            datePickers.setDate(selectedDate, animated: false)
            return true
        }
       return false
    }
    
    @IBAction func cencelAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewFunding.isHidden = true
        viewCategory.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        functionForHideKeyBoard()
         if(IsSelectDateAction==1)
         {
        if !isDateisFutureDate(selectedDate: datePickers.date)
          {
           txtSelectDate.text = datePickers.date.formatted
           txtSelectedDateRot.text = datePickers.date.formatted
          }
        }
        IsSelectDateAction=0
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewCategory.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
        viewFunding.isHidden = true
        
        functionForBODCount()
//        zeroIndexSelection()
    
    }
    
//    func zeroIndexSelection() {
//        if txtCategory.text == "Select" {
//            txtCategory.text = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: 0) as? String ?? ""
//            txtSubCategory.isHidden = false
//        }
//        if txtSubCategory.text == "Select" {
//            txtSubCategory.text = (muarrayForSubCategoryList.value(forKey: "SubcategoryName") as AnyObject).object(at: 0) as? String ?? ""
//            txtSubtoSubCategory.isHidden = false
//        }
//        if txtSubtoSubCategory.text == "Select" {
//            txtSubtoSubCategory.text = (muarrayForSubToSubCategoryList.value(forKey: "subtosubcategoryname") as AnyObject).object(at: 0) as? String ?? ""
//        }
//        if txtFundName.text == "Select" {
//            txtFundName.text = (muarrayFundinglistArray.value(forKey: "Fund_Name") as AnyObject).object(at: 0) as? String ?? ""
//        }
//    }
    
    @IBAction func BackAction(_ sender: Any) {
        functionForHideKeyBoard()
        self.hideFloatButtonDelegate?.hideFloatAction()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ClubeAction(_ sender: Any) {
        functionForHideKeyBoard()
        
        //buttonRotaryserviceClub.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)

        
        
        
        self.tblClube.isHidden = false
        self.tblRotary.isHidden = true
       // strZXWitchType = "Club Service"
        checkString = "Club Service"
        rotaryArray = NSMutableArray()
        Clubearray = NSMutableArray()
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        tblClube.reloadData()
    }
    
    @IBAction func RotaryAction(_ sender: Any) {
        functionForHideKeyBoard()
        IsSelectDateAction=0
        //buttonClubServiceRotary.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)

        
        self.tblClube.isHidden = true
        self.tblRotary.isHidden = false
        //strWdfsaditchType = "Service Projects"
        checkString = "Service Projects"
        Clubearray = NSMutableArray()
        rotaryArray = NSMutableArray()
        rotaryArray?.add("add")
        rotaryArray?.add("add")
        rotaryArray?.add("add")
        rotaryArray?.add("add")
        rotaryArray?.add("add")
        tblRotary.reloadData()
    }
    
    var IsSelectDateAction:Int=0
    @IBAction func SelectDateAction(_ sender: Any) {
        functionForHideKeyBoard()
        IsSelectDateAction=1
        btnOpacity.isHidden = false
        viewDatepicker.isHidden = false
        btnselectedDate.isHidden = false
        self.view.bringSubviewToFront( btnselectedDate)
    }
    
    @IBAction func SelectMettingTypeAction(_ sender: Any) {
        
        functionForHideKeyBoard()
        
        
        btnOpacity.isHidden = false
        viewMettingType.isHidden = false
    }
    
    //    @IBAction func crossPhotoAction(_ sender: Any) {
    //        if(arrayImages.count>1){
    //            btnAddCross.isHidden = false
    //            btnAddcrossClube.isHidden = false
    //        }
    //        else{
    //            btnAddCross.isHidden = true
    //            btnAddcrossClube.isHidden = true
    //        }
    //        imgAddPhoto.image = UIImage.init(named: "addevent")
    //    }
    
    func allImagesTapAction()
    {
            print("image changes")
            print( self.MurrayPhoto?.count)
            let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    //        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
    //        {
    //            UIAlertAction in
    //            self.openCamera()
    //        }
            let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                self.openGallary()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            {
                UIAlertAction in
            }
            
            picker.delegate = self
          //  alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    
    @objc func tapDetectedC1() {
        strC = "C1"
        photoIDArray.append("1")
        allImagesTapAction()
    }
    
    @objc func tapDetectedC2() {
        strC = "C2"
        photoIDArray.append("2")
        allImagesTapAction()
    }
    
    @objc func tapDetectedC3() {
        strC = "C3"
        photoIDArray.append("3")
        allImagesTapAction()
    }
    
    @objc func tapDetectedC4() {
        strC = "C4"
        photoIDArray.append("4")
        allImagesTapAction()
    }
    
    @objc func tapDetectedC5() {
        strC = "C5"
        photoIDArray.append("5")
        allImagesTapAction()
    }
    
    @objc func tapDetectedR1() {
        strR = "R1"
        isImageThere = "true"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR2() {
        strR = "R2"
        isImageThere = "true"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR3() {
        strR = "R3"
        isImageThere = "true"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR4() {
        strR = "R4"
        isImageThere = "true"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR5() {
        strR = "R5"
        isImageThere = "true"
        allImagesTapAction()
    }
    @objc func tapDetectedR6() {
        strR = "R6"
        isImageThere = "true"
        allImagesTapAction()
    }
    // MARK: - Function method

    func loaderViewMethod()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.clear
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
        }
        let Loadingview = UIView()
        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
        let gifView = UIImageView()
        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
        gifView.backgroundColor = UIColor.clear
        //                gifView.contentMode = .Center
        Loadingview.addSubview(gifView)
        window?.addSubview(Loadingview)
        
    }
    
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerController.SourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:self.alertTitle, message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallary()
    {
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
  //  func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
  //  {
       func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        else
        {
            let userEnteredString = textView.text
            var newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: text)
            print(newString?.characters.count)
            if( newString != nil || newString != "")
            {
                print("------------------__>-_>>>",userEnteredString)
                print("=========================>",newString)
                //2.....
                if(textView==txtViewC1)
                {
                    txtViewR1.text=newString
                }
                else if(textView==txtViewC2)
                {
                    txtViewR2.text=newString
                }
                else if(textView==txtViewC3)
                {
                    txtViewR3.text=newString
                } else if(textView==txtViewC4)
                {
                    txtViewR4.text=newString
                } else if(textView==txtViewC5)
                {
                    txtViewR5.text=newString
                }
                //1.....
                if(textView==txtViewR1)
                {
                    txtViewC1.text=newString
                }
                else if(textView==txtViewR2)
                {
                    txtViewC2.text=newString
                }
                else if(textView==txtViewR3)
                {
                    txtViewC3.text=newString
                } else if(textView==txtViewR4)
                {
                    txtViewC4.text=newString
                } else if(textView==txtViewR5)
                {
                    txtViewC5.text=newString
                }
                
                
                
                
                
            }
        }
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker .dismiss(animated: true, completion: nil)
        //MARK:- rajendra addding code here 3 Dec
        print("This is my code here 3 dec")
        if(strC == "C1" || strR == "R1")
        {
            arrayTempImageIndexHold.replaceObject(at: 0, with: "1")
        }
        else  if(strC == "C2" || strR == "R2")
        {
            arrayTempImageIndexHold.replaceObject(at: 1, with: "1")
        }
        else  if(strC == "C3" || strR == "R3")
        {
            arrayTempImageIndexHold.replaceObject(at: 2, with: "1")
        }
        else  if(strC == "C4" || strR == "R4")
        {
            arrayTempImageIndexHold.replaceObject(at: 3, with: "1")
        }
        else  if(strC == "C5" || strR == "R5")
        {
            arrayTempImageIndexHold.replaceObject(at: 4, with: "1")
        }
        print("<<<<<<<<<-------------------------this is image array---------------------------------->>>>>>>>>>>")
        
//        self.isimageSelect = "yes"
        
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            
            if(checkString! == "Club Service"){
                self.isimageSelect = "yes"
//                MurrayPhoto = ["","","",""]
            if(strC == "C1"){
      btnC1.isHidden = false
     btnR1.isHidden = false
     imgC1.image = img
     imgR1.image = img
     intgetindexVlaue = 0
     if(isCalledFRom == "Edit"){
         if(strimageC1 != nil){
             //
     MurrayPhotoID?.replaceObject(at: 0, with: MurrayPhotoID![0] as! String)
            self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![0] as! String)
            MurrayPhotoID?.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
            
        }
        else if( self.CheckDelete == "Delete"){
            
            MurrayPhotoID?.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
        }
        else{
            strimageC1 = img
            strimageR1=img
            //self.MurrayPhoto?.add(strimageC1 as Any)
            //MurrayPhotoID?.add("0")
            
            MurrayPhotoID?.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
        }
    }
    else
    {
        strimageC1 = img
        strimageR1=img
        // self.MurrayPhoto?.add(strimageC1 as Any)
        //MurrayPhotoID?.add("0")
        
        self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
        self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
    }
                }
                    
    else if(strC == "C2"){
        btnC2.isHidden = false
        btnR2.isHidden = false
        imgC2.image = img
        imgR2.image = img
        intgetindexVlaue = 1
        if(isCalledFRom == "Edit"){
            if( strimageC2 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![1] as! String)
                MurrayPhotoID?.replaceObject(at: 1, with: "0")
                self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
            }
            else if( self.CheckDelete == "Delete")
            {
                
                MurrayPhotoID?.replaceObject(at: 1, with: "0")
                self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
            }
            else
            {
                strimageC2 = img
                strimageR2=img
                //self.MurrayPhoto?.add(strimageC2 as Any)
                //MurrayPhotoID?.add("0")
                print("1<<<<<.......................................>>>>>>>")
                print(MurrayPhotoID)
                print("2<<<<<.......................................>>>>>>>")
                
                
                MurrayPhotoID?.replaceObject(at: 1, with: "0")
                self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
            }
        }
        else
        {
            strimageC2 = img
            strimageR2=img
            // self.MurrayPhoto?.add(strimageC2 as Any)
            // MurrayPhotoID?.add("0")
            self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
            self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
        }
        
    }
    else if(strC == "C3"){
        btnC3.isHidden = false
        btnR3.isHidden = false
        imgC3.image = img
        imgR3.image = img
        intgetindexVlaue = 2
        if(isCalledFRom == "Edit"){
            if( strimageC3 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![2] as! String)
                MurrayPhotoID?.replaceObject(at: 2, with: "0")
                self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
                
                MurrayPhotoID?.replaceObject(at: 2, with: "0")
                self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
            }
            else{
                strimageC3 = img
                strimageR3=img
                // self.MurrayPhoto?.add(strimageC3 as Any)
                // MurrayPhotoID?.add("0")
                
                MurrayPhotoID?.replaceObject(at: 2, with: "0")
                self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
            }
        } else{
            strimageC3 = img
            strimageR3=img
            // self.MurrayPhoto?.add(strimageC3 as Any)
            // MurrayPhotoID?.add("0")
            self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
            self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
        }
        
    } else if(strC == "C4"){
        btnC4.isHidden = false
        btnR4.isHidden = false
        imgC4.image = img
        imgR4.image = img
        intgetindexVlaue = 3
        if(isCalledFRom == "Edit"){
            if( strimageC4 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
                MurrayPhotoID?.replaceObject(at: 3, with: "0")
                self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
                
                MurrayPhotoID?.replaceObject(at: 3, with: "0")
                self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
            }
            else{
                strimageC4 = img
                strimageR4=img
                // self.MurrayPhoto?.add(strimageC4 as Any)
                // MurrayPhotoID?.add("0")
                
                MurrayPhotoID?.replaceObject(at: 3, with: "0")
                self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
            }
            
        } else{
            strimageC4 = img
            strimageR4=img
            //  self.MurrayPhoto?.add(strimageC4 as Any)
            // MurrayPhotoID?.add("0")
            
            self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
            self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
        }
        
    } else if(strC == "C5"){
        btnC5.isHidden = false
        btnR5.isHidden = false
        
        
        imgC5.image = img
        imgR5.image = img
        intgetindexVlaue = 4
        if(isCalledFRom == "Edit"){
            if(strimageC5 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
                MurrayPhotoID?.replaceObject(at: 4, with: "0")
                self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
                
                MurrayPhotoID?.replaceObject(at: 4, with: "")
                self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
            }
            else{
                strimageC5 = img
                strimageR5=img
                // self.MurrayPhoto?.add(strimageC5 as Any)
                // MurrayPhotoID?.add("0")
                
                MurrayPhotoID?.replaceObject(at: 4, with: "0")
                self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
            }
        } else{
            strimageC5 = img
            strimageR5=img
            //self.MurrayPhoto?.add(strimageC5 as Any)
            // MurrayPhotoID?.add("0")
            
            
            self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
            self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
        }
    }
    print("edit club service ------  11111111")
    print(MurrayPhoto)
    print(MurrayPhoto?.count)
            }
   else if(checkString! == "Service Projects")
   {
    
        if(strR == "R1"){
            self.isimageSelect = "yes"
       btnR1.isHidden = false
       btnC1.isHidden = false
       imgR1.image = img
       imgC1.image = img
       intgetindexVlaue = 0
       if(isCalledFRom == "Edit"){
           if( strimageR1 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![0] as! String)
               MurrayPhotoID?.replaceObject(at: 0, with: "0")
               self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 0, with: "0")
               self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
           }
           else{
               strimageR1 = img
               strimageC1=img
               //  self.MurrayPhoto?.add(strimageR1 as Any)
               //  MurrayPhotoID?.add("0")
               
               
               MurrayPhotoID?.replaceObject(at: 0, with: "0")
               self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
               
               
               
           }
       } else{
           strimageR1 = img
           strimageC1=img
//           self.MurrayPhoto?.add(strimageR1 as Any)
           // MurrayPhotoID?.add("0")
           
           
           self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
           self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
       }
   }
   else if(strR == "R2"){
    self.isimageSelect = "yes"
       btnR2.isHidden = false
       btnC2.isHidden = false
       imgR2.image = img
       imgC2.image = img
       intgetindexVlaue = 1
       if(isCalledFRom == "Edit"){
        print(strimageR2)
           if(  strimageR2 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![1] as! String)
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
//            uploadMediaImageOnServer(image: self.compressImage(img))
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
           }
           else{
               strimageR2 = img
               strimageC2=img
               //self.MurrayPhoto?.add(strimageR2 as Any)
               //MurrayPhotoID?.add("0")
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
//            strimageR2
//            uploadMediaImageOnServer(image: self.compressImage(img))
            
            
           }
       } else{
           strimageR2 = img
           strimageC2=img
           // self.MurrayPhoto?.add(strimageR2 as Any)
           //MurrayPhotoID?.add("0")
           self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
           self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
       }
   }
   else if(strR == "R3"){
    self.isimageSelect = "yes"
       btnR3.isHidden = false
       btnC3.isHidden = false
       imgR3.image = img
       imgC3.image = img
       intgetindexVlaue = 2
       if(isCalledFRom == "Edit"){
           if( strimageR3 != nil){
            //If image already exist first delete then add
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![2] as! String)
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               //if existed image is deleted
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
           }
           else{
            //if there is no any image
               strimageR3 = img
               strimageC3=img
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
           }
       } else{
           strimageR3 = img
           strimageC3=img
           // self.MurrayPhoto?.add(strimageR3 as Any)
            MurrayPhotoID?.add("0")
           self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
           self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
       }
   } else if(strR == "R4"){
    self.isimageSelect = "yes"
       btnR4.isHidden = false
       btnC4.isHidden = false
       imgR4.image = img
       imgC4.image = img
       intgetindexVlaue = 3
       if(isCalledFRom == "Edit"){
           if(strimageR4 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else{
               strimageR4 = img
               strimageC4=img
               // self.MurrayPhoto?.add(strimageR4 as Any)
               // MurrayPhotoID?.add("0")
               
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)
           }
       } else{
           strimageR4 = img
           strimageC4=img
           // self.MurrayPhoto?.add(strimageR4 as Any)
           // MurrayPhotoID?.add("0")
           
           self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)
           self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
       }
       
   } else if(strR == "R5"){
    self.isimageSelect = "yes"
       btnR5.isHidden = false
       btnC5.isHidden = false
       
       imgR5.image = img
       imgC5.image = img
       intgetindexVlaue = 4
       if(isCalledFRom == "Edit"){
           if( strimageR5 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else{
               strimageR5 = img
               strimageC5=img
               //self.MurrayPhoto?.add(strimageR5 as Any)
               // MurrayPhotoID?.add("0")
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
           }
       } else{
           strimageR5 = img
           strimageC5=img
           // self.MurrayPhoto?.add(strimageR5 as Any)
           // MurrayPhotoID?.add("0")
           
           self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
           self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
       }
       
   }
 else if(strR == "R6"){
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//       btnR6.isHidden = false
//       imgR6.image = img
       if(isCalledFRom == "Edit"){
           if( strimageR6 != nil){
          //  self.funcCallDeletePhoto2(strPhotoId: self.mediaImageID)
               uploadMediaImageOnServer(image: self.compressImage(img))
           }
           else if( self.CheckDelete == "Delete"){
               uploadMediaImageOnServer(image: self.compressImage(img))
           }
           else{
               strimageR6 = img
               uploadMediaImageOnServer(image: self.compressImage(img))
           }
       } else{
           strimageR6 = img
           uploadMediaImageOnServer(image: self.compressImage(img))
       }
      }else {
              self.view.makeToast("No internet connection. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       }
       }
    }
  }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            //  print("dskfjdskfjdskfjdskfj---------",checkchchgString)
  
  if(checkString == "Club Service"){
    self.isimageSelect = "yes"
      if(strC == "C1"){
         btnC1.isHidden = false
         btnR1.isHidden = false
         imgC1.image = img
         imgR1.image = img
         intgetindexVlaue = 0
         if(isCalledFRom == "Edit"){
             if(strimageC1 != nil){
                 //
                 //                            MurrayPhotoID?.replaceObject(at: 0, with: MurrayPhotoID![0] as! String)
                 self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![0] as! String)
                 MurrayPhotoID?.replaceObject(at: 0, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
                 
             }
             else if( self.CheckDelete == "Delete"){
                 
                 MurrayPhotoID?.replaceObject(at: 0, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
             }
             else{
                 strimageC1 = img
                 strimageR1=img
                 // self.MurrayPhoto?.add(strimageC1 as Any)
                 //  MurrayPhotoID?.add("0")
                 
                 MurrayPhotoID?.replaceObject(at: 0, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
             }
         }
         else
         {
             strimageC1 = img
             strimageR1=img
             // self.MurrayPhoto?.add(strimageC1 as Any)
             // MurrayPhotoID?.add("0")
             self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
             self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
         }
     }
     else if(strC == "C2"){
         btnC2.isHidden = false
         btnR2.isHidden = false
         imgC2.image = img
         imgR2.image = img
         intgetindexVlaue = 1
         if(isCalledFRom == "Edit"){
             if( strimageC2 != nil){
                 self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![1] as! String)
                 MurrayPhotoID?.replaceObject(at: 1, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
             }
             else if( self.CheckDelete == "Delete"){
                 
                 MurrayPhotoID?.replaceObject(at: 1, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
             }
             else{
                 strimageC2 = img
                 strimageR2=img
                 //  self.MurrayPhoto?.add(strimageC2 as Any)
                 //  MurrayPhotoID?.add("0")
                 
                 MurrayPhotoID?.replaceObject(at: 1, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
             }
         } else{
             strimageC2 = img
             strimageR2=img
             // self.MurrayPhoto?.add(strimageC2 as Any)
             // MurrayPhotoID?.add("0")
             self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
             self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
         }
     }
     else if(strC == "C3"){
         btnC3.isHidden = false
         btnR3.isHidden = false
         imgC3.image = img
         imgR3.image = img
         intgetindexVlaue = 2
         if(isCalledFRom == "Edit"){
             if( strimageC3 != nil){
                 self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![2] as! String)
                 MurrayPhotoID?.replaceObject(at: 2, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
             }
             else if( self.CheckDelete == "Delete"){
                 
                 MurrayPhotoID?.replaceObject(at: 2, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
             }
             else{
                 strimageC3 = img
                 strimageR3=img
                 //  self.MurrayPhoto?.add(strimageC3 as Any)
                 //  MurrayPhotoID?.add("0")
                 
                 MurrayPhotoID?.replaceObject(at: 2, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
             }
         } else{
             strimageC3 = img
             strimageR3=img
             // self.MurrayPhoto?.add(strimageC3 as Any)
             // MurrayPhotoID?.add("0")
             self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
             self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
         }
         
     } else if(strC == "C4"){
         btnC4.isHidden = false
         btnR4.isHidden = false
         imgC4.image = img
         imgR4.image = img
         intgetindexVlaue = 3
         if(isCalledFRom == "Edit"){
             if( strimageC4 != nil){
                 self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
                 MurrayPhotoID?.replaceObject(at: 3, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
             }
             else if( self.CheckDelete == "Delete"){
                 
                 MurrayPhotoID?.replaceObject(at: 3, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
             }
             else{
                 strimageC4 = img
                 strimageR4=img
                 // self.MurrayPhoto?.add(strimageC4 as Any)
                 // MurrayPhotoID?.add("0")
                 
                 MurrayPhotoID?.replaceObject(at: 3, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
             }
             
         } else{
             strimageC4 = img
             strimageR4=img
             // self.MurrayPhoto?.add(strimageC4 as Any)
             //  MurrayPhotoID?.add("0")
             self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
             self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
         }
         
     } else if(strC == "C5"){
         btnC5.isHidden = false
         btnR5.isHidden = false
         
         imgC5.image = img
         imgR5.image = img
         intgetindexVlaue = 4
         if(isCalledFRom == "Edit"){
             if(strimageC5 != nil){
                 self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
                 MurrayPhotoID?.replaceObject(at: 4, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
             }
             else if( self.CheckDelete == "Delete"){
                 
                 MurrayPhotoID?.replaceObject(at: 4, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
             }
             else{
                 strimageC5 = img
                 strimageR5=img
                 //  self.MurrayPhoto?.add(strimageC5 as Any)
                 //  MurrayPhotoID?.add("0")
                 
                 MurrayPhotoID?.replaceObject(at: 4, with: "0")
                 self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
             }
         } else{
             strimageC5 = img
             strimageR5=img
             //  self.MurrayPhoto?.add(strimageC5 as Any)
             // MurrayPhotoID?.add("0")
             
             self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
             self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
         }
     }
     
     print("edit club service   11111111  fdsf")
     print(MurrayPhoto)
     print(MurrayPhoto?.count)
  }
 else if(checkString == "Service Projects")
 {
    
   if(strR == "R1"){
    self.isimageSelect = "yes"
       btnR1.isHidden = false
       btnC1.isHidden = false
       imgR1.image = img
       imgC1.image = img
       intgetindexVlaue = 0
       if(isCalledFRom == "Edit"){
   if( strimageR1 != nil){
      self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![0] as! String)
      MurrayPhotoID?.replaceObject(at: 0, with: "0")
      self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
  }
  else if( self.CheckDelete == "Delete"){
      
      MurrayPhotoID?.replaceObject(at: 0, with: "0")
      self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
  }
  else{
      strimageR1 = img
      strimageC1=img
      // self.MurrayPhoto?.add(strimageR1 as Any)
      // MurrayPhotoID?.add("0")
      
      MurrayPhotoID?.replaceObject(at: 0, with: "0")
      self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
  }
       } else{
           strimageR1 = img
           strimageC1=img
           // self.MurrayPhoto?.add(strimageR1 as Any)
           //MurrayPhotoID?.add("0")
           
           
           self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
           self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
       }
       print("edit rotary  11111111")
       print(MurrayPhoto)
       print(MurrayPhoto?.count)
   }
   else if(strR == "R2"){
    self.isimageSelect = "yes"
       btnR2.isHidden = false
       btnC2.isHidden = false
       imgR2.image = img
       imgC2.image = img
       intgetindexVlaue = 1
       if(isCalledFRom == "Edit"){
        print(strimageR2)
           if(  strimageR2 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![1] as! String)
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
           }
           else{
               strimageR2 = img
               strimageC2=img
               // self.MurrayPhoto?.add(strimageR2 as Any)
               //MurrayPhotoID?.add("0")
               
               MurrayPhotoID?.replaceObject(at: 1, with: "0")
               self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
           }
       } else{
           strimageR2 = img
           strimageC2=img
           //self.MurrayPhoto?.add(strimageR2 as Any)
           // MurrayPhotoID?.add("0")
           
           
           self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
           self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
       }
       print("edit rotary  2222")
       print(MurrayPhoto)
       print(MurrayPhoto?.count)
   }
   else if(strR == "R3"){
    self.isimageSelect = "yes"
       btnR3.isHidden = false
       btnC3.isHidden = false
       imgR3.image = img
       imgC3.image = img
       intgetindexVlaue = 2
       if(isCalledFRom == "Edit"){
           if( strimageR3 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![2] as! String)
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
           }
           else{
               strimageR3 = img
               strimageC3=img
               ///self.MurrayPhoto?.add(strimageR3 as Any)
               // MurrayPhotoID?.add("0")
               
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
           }
       } else{
           strimageR3 = img
           strimageC3=img
           // self.MurrayPhoto?.add(strimageR3 as Any)
           // MurrayPhotoID?.add("0")
           
           
           self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
           self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
       }
       
       print("edit rotary  333333")
       print(MurrayPhoto)
       print(MurrayPhoto?.count)
   } else if(strR == "R4"){
    self.isimageSelect = "yes"
       btnR4.isHidden = false
       btnC4.isHidden = false
       imgR4.image = img
       imgC4.image = img
       intgetindexVlaue = 3
       if(isCalledFRom == "Edit"){
           if(strimageR4 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else{
               strimageR4 = img
               strimageC4=img
               //self.MurrayPhoto?.add(strimageR4 as Any)
               //MurrayPhotoID?.add("0")
               
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)

           }
       } else{
           strimageR4 = img
           strimageC4=img
           // self.MurrayPhoto?.add(strimageR4 as Any)
           //MurrayPhotoID?.add("0")
           self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)
           self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
       }
       print("edit rotary  444444")
       print(MurrayPhoto)
       print(MurrayPhoto?.count)
       
   } else if(strR == "R5"){
    self.isimageSelect = "yes"
       btnR5.isHidden = false
       btnC5.isHidden = false
       imgR5.image = img
       imgC5.image = img
       intgetindexVlaue = 4
       if(isCalledFRom == "Edit"){
           if( strimageR5 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
               
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else{
               strimageR5 = img
               strimageC5=img
               //self.MurrayPhoto?.add(strimageR5 as Any)
               //MurrayPhotoID?.add("0")
               
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
           }
           print("edit rotary  5555555")
           print(MurrayPhoto)
           print(MurrayPhoto?.count)
       } else{
           strimageR5 = img
           strimageC5=img
           // self.MurrayPhoto?.add(strimageR5 as Any)
           //  MurrayPhotoID?.add("0")
           self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
           self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
       }
   }
    else if(strR == "R6"){
  if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
//          btnR6.isHidden = false
//          imgR6.image = img
          intgetindexVlaue = 5
          if(isCalledFRom == "Edit"){
     if( strimageR6 != nil){
     //self.funcCallDeletePhoto2(strPhotoId: self.mediaImageID)
       uploadMediaImageOnServer(image: self.compressImage(img))
   }
   else if( self.CheckDelete == "Delete"){
       uploadMediaImageOnServer(image: self.compressImage(img))
   }
   else{
       strimageR6 = img
       uploadMediaImageOnServer(image: self.compressImage(img))
   }
} else{
  strimageR6 = img
  uploadMediaImageOnServer(image: self.compressImage(img))
          }
    }else
   {
      self.view.makeToast("No internet connection. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
    }
        }//end of R6
      }
    }
  }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        print("picker cancel.")
        dismiss(animated: true, completion: nil)
        
    }

    //MARK:- Upload Media Image on server
    func uploadMediaImageOnServer(image:UIImage)
    {
        self.showMBProgressForImage(str: "")
        let imageData: Data = image.jpegData(compressionQuality: 0.6)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate=self
        wsm.uploadToServer(usingImage: imageData, andFileName: "image", moduleName: "gallery")
    }
    
    

    //MARK:- Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickermetting){
            return muarrayForMetting.count
        }
            
        else  if(pickerView==pickerCategory)
        {
            return muarrayForCategoryListWithOutZeroIndex.count;
        }
        else  if(pickerView==pickerSubCategory)
        {
            return muarrayForSubCategoryList.count;
        }
        else  if(pickerView==pickerSubToSubCategory)
        {
            return muarrayForSubToSubCategoryList.count;
        }
        else  if(pickerView==pickerFundinglist)
        {
            return muarrayFundinglistArray.count;
        }
//        onlinemuarrayModule
        else if(pickerView == selectProjPickerViewww){
            return onlinemuarrayModule.count
        }
        else
        {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView == pickermetting){
            
            return (muarrayForMetting[row] as! String)
        }
        else if(pickerView==pickerCategory)
        {
            var categories:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as! String
             txtSubCategory.isHidden = false
            return categories
        }
        else if(pickerView==pickerSubCategory)
               {
                   let categories:String = (muarrayForSubCategoryList.value(forKey: "SubcategoryName") as AnyObject).object(at: row) as! String
             txtSubtoSubCategory.isHidden = false
                   return categories
               }
        else if(pickerView==pickerSubToSubCategory)
               {
                   let categories:String = (muarrayForSubToSubCategoryList.value(forKey: "subtosubcategoryname") as AnyObject).object(at: row) as! String
                   return categories
               }
        else if(pickerView==pickerFundinglist)
        {
            let fundName:String = (muarrayFundinglistArray.value(forKey: "Fund_Name") as AnyObject).object(at: row) as! String
            return fundName
        }
        
        else if(pickerView == selectProjPickerViewww){
            print(onlinemuarrayModule)
//            TtlOfNewOngoingProj
//            self.onlinemuarrayModule.count>0
//            {
            var getvalueww = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as? String
            
            if getvalueww == nil {
                var selectProj:String = ""
                return selectProj
            }
            else{
                let selectProj:String = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
                return selectProj
            }
//            }
//            else
//            {
//                return ""
//            }
           
            
//            return onlinemuarrayModule.count
        }
        return ""
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        txtAttendancePercent.text = ""
        txtAttendance.text = ""
        if(pickerView == pickermetting){
            
            let  value = (muarrayForMetting[row] as! String)
            txtMettingType.text = value
           
//            if(txtMettingType.text == "BOD"){
                btnAgenda.isEnabled = true
                btnMinutesofMetting.isEnabled = true
//
//            }else if(txtMettingType.text == "Assembly"){
//                btnAgenda.isEnabled = true
//                btnMinutesofMetting.isEnabled = true
//
//            }
//            else{
//                btnAgenda.isEnabled = false
//                btnMinutesofMetting.isEnabled = false
//                //here need to remove doc id and mom id
//                print("agenda id and doc id")
//
//                AgendaDocID="0"
//                MOMDocID="0"
//
//            }
        }
        else  if(pickerView==pickerCategory)
        {
        let categories:String =  (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as? String ?? ""
        let ID:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "ID") as AnyObject).object(at: row) as? String ?? ""

            txtCategory.text = categories
            categoryId=ID
            
            mainCategorySelect(ID: ID, categoryName: categories)
        }
        else  if(pickerView==pickerSubCategory)
            {
            let categories:String =  (muarrayForSubCategoryList.value(forKey: "SubcategoryName") as AnyObject).object(at: row) as? String ?? ""
        let ID:String = (muarrayForSubCategoryList.value(forKey: "pk_subcategoryId") as AnyObject).object(at: row) as? String ?? ""
        let mainCatID:String = (muarrayForSubCategoryList.value(forKey: "fk_CategoryID") as AnyObject).object(at: row) as? String ?? ""

        txtSubCategory.text = categories
        print(ID)
        subCategoryId=ID
        self.subCategorySelect(ID: ID, categoryName: categories,mainCatID: mainCatID)
                
            }
    else  if(pickerView==pickerSubToSubCategory)
      {
         let categories:String =  (muarrayForSubToSubCategoryList.value(forKey: "subtosubcategoryname") as AnyObject).object(at: row) as? String ?? ""
         let ID:String = (muarrayForSubToSubCategoryList.value(forKey: "pk_subtosubcategoryId") as AnyObject).object(at: row) as? String ?? ""
         txtSubtoSubCategory.text = categories
         print(ID)
         subtoSubCategoryId=ID
      }
    else if pickerView==pickerFundinglist
        {
           let fID=(muarrayFundinglistArray.value(forKey: "Pk_Fund_ID") as AnyObject).object(at: row) as? String ?? ""
            print(fID)
            fundID=fID
            let fundName = (muarrayFundinglistArray.value(forKey: "Fund_Name") as AnyObject).object(at: row) as? String ?? ""
            txtFundName.text=fundName
        if fundName == "CSR" {
            csrTF()
        } else if fundName == "Global Grant" {
            globalTF()
        } else {
            textfieldGreyOut()
        }
        
        }
        
    else if pickerView==selectProjPickerViewww
        {
//           let fID=(onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
        
        let subProID=(onlinemuarrayModule.value(forKey: "pk_gallery_id") as AnyObject).object(at: row)
        
        
        self.ddSubProjectID = subProID as! NSNumber
        
        var fID = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as? String
        
        if fID == nil {
            selectProjBtnnnnnn .setTitle("", for: UIControl.State.normal)
        }
        else{
            print(fID)
            fundID=fID
        self.selectedProjectTitleeName=fID
            let fundName = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
        //.text=fundName
        selectProjBtnnnnnn .setTitle((onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String, for: UIControl.State.normal)

        }
        
//
//            print(fID)
//            fundID=fID
//        self.selectedProjectTitleeName=fID
//            let fundName = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
//        //.text=fundName
//        selectProjBtnnnnnn .setTitle((onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String, for: UIControl.State.normal)
        
        }
        
//        let selectProj:String = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
//        return selectProj
    }

    func mainCategorySelect(ID:String,categoryName:String)
    {
        self.subCategoryId=""
        self.subtoSubCategoryId=""
        self.muarrayForSubCategoryList=NSMutableArray()
        self.muarrayForSubToSubCategoryList=NSMutableArray()
        self.txtSubCategory.text="Select"
        self.txtSubCategoryNew.text=""
        self.txtSubtoSubCategory.text="Select"
        self.txtCategoryNew.text=""
        
        self.btnSubToSubCategoryDrop.isEnabled=false
        self.txtSubCategoryNew.isEnabled=false
        if(categoryName == "Others"){
        self.txtCategoryNew.isEnabled = true
        self.btnSubCategoryDrop.isEnabled=true
        }
        else{
        self.txtCategoryNew.isEnabled = false
        self.btnSubCategoryDrop.isEnabled=true
        //MARK:- addtosubCategoryList
       if muarraySubCategoryListArray.count > 0
       {
       let predicate = NSPredicate(format: "fk_CategoryID == %@", ID)
       let searchDataSource = muarraySubCategoryListArray.filtered(using: predicate)
       print("searchDataSource \(searchDataSource)")
       if let muarrayForSubCategoryListFiltereds=(searchDataSource as NSArray).mutableCopy() as? NSMutableArray
       {
        muarrayForSubCategoryList=muarrayForSubCategoryListFiltereds
       }
      }
    }
        if muarrayForSubCategoryList.count == 0
        {
            self.btnSubCategoryDrop.isEnabled=false
            self.txtSubCategory.isEnabled=false
            self.txtSubCategoryNew.isEnabled=false
            self.txtSubtoSubCategory.isEnabled=false
        }
        else
        {
            self.pickerSubCategory.reloadAllComponents()
            self.txtSubCategory.isEnabled=true
        }
    }

    func subCategorySelect(ID:String,categoryName:String,mainCatID:String)
    {
        self.txtSubCategoryNew.text=""
        self.txtSubtoSubCategory.text="Select"
        self.muarrayForSubToSubCategoryList=NSMutableArray()
        self.subtoSubCategoryId=""
        if(self.txtSubCategory.text == "Others"){
            self.txtSubCategoryNew.isEnabled = true
            self.btnSubToSubCategoryDrop.isEnabled=false
        }
        else{
            self.txtSubCategoryNew.isEnabled = false
            self.btnSubToSubCategoryDrop.isEnabled=true
              //MARK:- addtosubToSubCategoryList
             if muarraySubToSubCategoryListArray.count > 0
             {
             let predicate = NSPredicate(format: "fk_categoryID == %@ AND fk_subcategoryid == %@", mainCatID,ID)
             let searchDataSource = muarraySubToSubCategoryListArray.filtered(using: predicate)
             print("searchDataSource \(searchDataSource)")
             if let muarrayForSubToSubCategoryListFiltereds=(searchDataSource as NSArray).mutableCopy() as? NSMutableArray
             {
              muarrayForSubToSubCategoryList=muarrayForSubToSubCategoryListFiltereds
             }
            }
        }
        if muarrayForSubToSubCategoryList.count==0
        {
            self.btnSubToSubCategoryDrop.isEnabled=false
            self.txtSubtoSubCategory.isEnabled=false
        }
        else
        {
            self.pickerSubToSubCategory.reloadAllComponents()
            self.txtSubtoSubCategory.isEnabled=true
        }
    }
    
    //MARK:- Api calling
    
    func compressImage (_ image: UIImage) -> UIImage {
        let actualHeight:CGFloat = image.size.height
        let actualWidth:CGFloat = image.size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 1024.0
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.6
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        //image.drawInRect(CGRect)
        image.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)! //UIImageJPEGRepresentation(img, compressionQuality)!
        let imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }

    func SendDataToserver(){
        SVProgressHUD.show()
        let completeURL = baseUrl+"Gallery/AddUpdateAlbum_New"
        var parameterst:NSDictionary=NSDictionary()
        
        
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
                                
                if mainMemberID == "Yes"
                 {
                    self.isSubGrpAdmin = "1"
                 }
            else
                {
                    self.isSubGrpAdmin = "0"
                }
        
        
        if(txtMettingType.text == "Regular"){
            strMetting = "0"
        }
        else if(txtMettingType.text == "BOD"){
            strMetting = "1"
        } else if(txtMettingType.text == "Assembly"){
            strMetting = "2"
        }
        else if (txtMettingType.text == "Fellowship")
        {
            strMetting = "3"
        }
        else if (txtMettingType.text == "Trust")
        {
            strMetting = "4"
        }
        if( txtAttendancePercent.text == nil || txtAttendancePercent.text == "" || txtAttendancePercent.text == "0"){
            txtAttendancePercent.text = "0"
        }
        
        var strImageID =  self.albumImagesID
        if(strImageID == "" || strImageID == nil){
            strImageID = "0"
        }

        var varGetDate:String! = self.txtSelectDate.text as! String
        var varGetArray =  varGetDate.components(separatedBy: " ")
        var Day:String!=varGetArray[0]
        var Month:String!=varGetArray[1]
        var Year:String!=varGetArray[2]
            
        if(Month=="Jan")
        {
           Month="01"
        }
        else if(Month=="Feb")
        {
            Month="02"
        }
        else if(Month=="Mar")
        {
            Month="03"
        }
        else if(Month=="Apr")
        {
            Month="04"
        }
        else if(Month=="May")
        {
            Month="05"
        }
        else if(Month=="Jun")
        {
            Month="06"
        }
        else if(Month=="Jul")
        {
            Month="07"
        }
        else if(Month=="Aug")
        {
            Month="08"
        }
        else if(Month=="Sep")
        {
            Month="09"
        }
        else if(Month=="Oct")
        {
            Month="10"
        }
        else if(Month=="Nov")
        {
            Month="11"
        }
        else if(Month=="Dec")
        {
            Month="12"
        }
        let subStr = Year+"-"+Month
        let FinalDate:String!=subStr+"-"+Day
        print("final date")
        print(FinalDate)
        if(checkString == "Service Projects"){
            if isMediaCheck=="0"
            {
//                self.textViewR6.text=""
                self.mediaImageID="0"
        }
        if(categoryId=="0")
        {
            categoryId="1"
        }
        print("this is category id :-----")
        print(categoryId)
        if categoryId==""
        {
            categoryId="0"
        }
        if subCategoryId==""
        {
            subCategoryId="0"
        }
        if subtoSubCategoryId==""
        {
            subtoSubCategoryId="0"
        }
        if finalTempBenificiary == ""
        {
            finalTempBenificiary = "0"
        }
            var rotaractors:String="0"
            if let rotaract=txtRotractors.text
            {
               rotaractors=rotaract
            }
            if rotaractors==""
            {
                rotaractors="0"
            }
            print(moduleId)
            parameterst = [
//            "isSubGrpAdmin":isSubGrpAdmin as Any,
            "albumId":strAlbumId as Any,
            "groupId":strGroupId as Any,
               
            "ClubRole":ClubRole as Any,
            "JoinedOrNot":JoinedOrNotSelectType as Any,
                "NewOrExisting":NewOrExistingSelectType as Any,
                "OnetimeOrOngoing":oneTimeOngoingSelectType as Any,
                "ddl_selectProject":ddSubProjectID as Any,
            "moduleId":"52" as Any,
            "type":"0",
            "memberIds":"",
            "albumTitle":txtRotetoryTitle.text as Any,
            "albumDescription":txtRotDesc.text as Any,
            "albumImage":strImageID as Any,
            "createdBy":strcreatedBy as Any,
            "dateofproject": FinalDate,
            "shareType":"1",
            "costofproject":txtCost.text as Any,
            "beneficiary":finalBenificiary,
            "TempBeneficiary":finalTempBenificiary,
           "TempBeneficiary_flag":flagExceedBenificiary,
            "manhourspent":txtmanHours.text as Any,
                "TtlOfNewOngoingProj" : titleOfNewOngoingProjectTX.text as Any,
            "categoryId":categoryId,"Fk_SubcategoryID":subCategoryId,"Fk_SubTosubcategoryID":subtoSubCategoryId,
            "manhourspenttype":"Hours",
            "NumberofRotarian":txtRotatiran.text as Any,
            "OtherCategorytext":txtCategoryNew.text as Any,
            "OtherSubCategory":txtSubCategoryNew.text as Any,
            "costofprojecttype":"1",
            "Attendance":"0",
            "AttendancePer":"0",
            "MeetingType":"0",
            "AgendaDocID":"0",
            "MOMDocID":"0",
            "Rotaractors":rotaractors,
            "Ismedia":isMediaCheck ,// otherwise “0”
            "MediaphotoID":mediaImageID,
//            "MediaDesc":textViewR6.text as Any,
            "issendwhatsapp": issendwhatsapp as Any,
            "Fk_Funding_Id":fundID,
            "prjct_loctn":locationOfProjectTF.text ?? "",
            "csr_company":csrNameTF.text ?? "",
            "globl_partner":globalGrantPartnerTF.text ?? "",
            "amt_spnt_till":globalGrantAmtSpenTF.text ?? "",
            "host_club_district":globalGrantHostTF.text ?? "",
            "amt_sancted": txtFundName.text == "Global Grant" ? globalGrantSanTF.text ?? "" : amtSanCsrTF.text ?? "",
            "amt_recved": txtFundName.text == "Global Grant" ? globalGrantAmtRecTF.text ?? "" : amtRecCsrTF.text ?? "",
            "global_grt_num": globalGrantNoTF.text ?? "",
            "co_host_club_orgnistn": hostRotaryClubTF.text ?? ""
        ]
        }
        else {
            print(moduleId)
            categoryId="0"
            
//            if isFromMoveToClub == "yes" {
//                self.shareTypee = "0"
//            }
//            else{
//
//            }
            
            parameterst = [
                "isSubGrpAdmin":isSubGrpAdmin as Any,
                "issendwhatsapp": "0",
                "albumId":strAlbumId as Any,
                "groupId":strGroupId as Any,
                "moduleId":"8",
                "type":"0",
                "memberIds":"",
                "albumTitle":txtTitle.text as Any,
                "albumDescription":txtViewDesc.text as Any,
                "albumImage":strImageID as Any,
                "createdBy":strcreatedBy as Any,
                "dateofproject": FinalDate,
                "shareType":"0",
                "costofproject":"",
                "beneficiary":"",
                "manhourspent":"",
                "categoryId":"0",
                "Fk_SubcategoryID":"0",
                "Fk_SubTosubcategoryID":"0",
                "manhourspenttype":"",
                "NumberofRotarian":"",
                "OtherCategorytext":"",
                "OtherSubCategory":"",
                "costofprojecttype":"",
                "Attendance":txtAttendance.text as Any,
                "AttendancePer":txtAttendancePercent.text as Any,
                "MeetingType":strMetting as Any,
                "AgendaDocID":AgendaDocID as Any,
                "MOMDocID":MOMDocID as Any,
                "Rotaractors":"0",
                "Fk_Funding_Id":""
            ]
        }
        
        let bytes = try! JSONSerialization.data(withJSONObject: parameterst, options: JSONSerialization.WritingOptions.prettyPrinted)
        //var jsonObj = try! JSONSerialization.jsonObject(with: bytes, options: .mutableLeaves)
        if let str = String(data: bytes, encoding: String.Encoding.utf8)
        {
            print("<<-----------------------------json start----------------------------->>")
            print(str)
            print(completeURL)
            print("<<-----------------------------json end------------------------------->>")
            
        }
        else
        {
            print("not a valid UTF-8 sequence")
        }
        
        print("this is submit parametr and url !!!!")
      //  print()
        
//        if(Whatsappcount>=MemberCount) then Send Whatsapp .

        
        
        
            print("AddUpdateAlbum_New completeURL:: \(completeURL)")
        print("AddUpdateAlbum_New parameter:: \(parameterst)")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            SVProgressHUD.show()
            
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.btnAddEdit.isEnabled=true
                self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dd.object(forKey: "TBAddGalleryResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
  
  self.strAlbumId = ((dd.object(forKey: "TBAddGalleryResult")! as AnyObject).object(forKey: "galleryid") as! String)
  
  //  UserDefaults.standard.set(galleryid, forKey: "GalleryID")

  
  if(self.checkString == "Service Projects"){
      
 for i in 00..<(self.MurrayPhoto?.count)!{
     if(i==0){
         
         self.MurrayText?.add(self.txtViewR1.text)
         
     }else if(i==1){
         
         self.MurrayText?.add(self.txtViewR2.text)
         
     }
     else if(i==2){
         
         self.MurrayText?.add(self.txtViewR3.text)
         
     }
     else if(i==3){
         
         self.MurrayText?.add(self.txtViewR4.text)
         
     }
     else if(i==4){
         
         self.MurrayText?.add(self.txtViewR5.text)
         
     }
     else if(i==5){
       
//       self.MurrayText?.add(self.textViewR6.text)
       
   }
 }
 
 }else{
     
     for i in 00..<(self.MurrayPhoto?.count)!
     {
         if(i==0){
             
             self.MurrayText?.add(self.txtViewC1.text)
             
         }else if(i==1){
             
             self.MurrayText?.add(self.txtViewC2.text)
         }
         else if(i==2){
             
             self.MurrayText?.add(self.txtViewC3.text)
         }
         else if(i==3){
             
             self.MurrayText?.add(self.txtViewC4.text)
         }
         else if(i==4){
             
             self.MurrayText?.add(self.txtViewC5.text)
         }
     }
     
 }
 
 self.SendPhotoArrayToserver(muarrayImageID: self.MurrayPhoto!, muarrayImageText: self.MurrayText!)
 }
 else
 {
     self.btnAddEdit.isEnabled=true
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
 }
   SVProgressHUD.dismiss()
  }
  })
}

 func queryString(urlString:String, params:[String: String]) -> String {
        let queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var urlComps = URLComponents(string: urlString)
        urlComps?.queryItems = queryItems
        return urlComps?.url?.absoluteString ?? ""
    }

    func getParameter(strPhotoid:String,strDesc:String)->[String:String]?{

        var param:[String:String] = [String:String]()
        param["photoId"] = strPhotoid
        param["desc"] = strDesc
        param["albumId"] = strAlbumId
        param["groupId"] = strGroupId
        param["createdBy"] = strcreatedBy
//        desc=&albumId=23357&groupId=2765&createdBy=581428&Financeyear=2021-2022
        param["Financeyear"] = year
        return param
    }
    
    func SendPhotoArrayToserver(muarrayImageID: NSMutableArray, muarrayImageText: NSMutableArray){
        SVProgressHUD.show()
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        let completeURL = baseUrl+"Gallery/AddUpdateAlbumPhoto?"
        
        
        /*code by rajendra jat on 6 dec 2018 7.02pm*/
        //rajendra jat need to wor here 4 dec 2018
        
        //temp code
        /*
         var arrayTemporary:NSMutableArray=NSMutableArray()
         for i in 00..<5
         {
         print("Index:------")
         print(arrayTempImageIndexHold.object(at: i))
         var varGetValue:String!=arrayTempImageIndexHold.object(at: i) as! String
         if(varGetValue=="1")
         {
         arrayTemporary.add(i)
         }
         else  if(varGetValue=="0")
         {
         //addingArray.add
         }
         
         }
         
         print("this is index value by rajendra jat !!!!!!")
         print(arrayTemporary)
         print(arrayTempImageIndexHold)
         
         var tempPhotoarray:NSMutableArray=NSMutableArray()
         var tempTextarray:NSMutableArray=NSMutableArray()
         
         for i in 00..<arrayTemporary.count
         {
         print(MurrayPhoto?.object(at: arrayTemporary.object(at: i) as! Int) as Any)
         var getvalue = MurrayPhoto?.object(at: arrayTemporary.object(at: i) as! Int) as Any
         tempPhotoarray.add(getvalue)
         
         var getvaluetext = MurrayText?.object(at: arrayTemporary.object(at: i) as! Int) as Any
         tempTextarray.add(getvaluetext)
         
         
         
         print(arrayTemporary)
         }
         
         print(tempPhotoarray)
         print(arrayTemporary)
         MurrayPhoto=NSMutableArray()
         MurrayPhoto=tempPhotoarray
         
         
         MurrayText=NSMutableArray()
         MurrayText=tempTextarray
         */
        /*code by rajendra jat on 6 dec 2018 7.02pm end*/
        
        /*-----------*/
        
        //code be rajendra jat 12 dec 5.42pm
        var tempMurrayPhotoID:NSMutableArray=NSMutableArray()
        
        // for i in 00..<MurrayPhotoID?.count
        /*
         for i in 00..<((MurrayPhotoID?.count)!){
         var varGetValue:String!=MurrayPhotoID?.object(at: i)as! String
         if(varGetValue=="-1")
         {
         tempMurrayPhotoID.add("-1")
         }
         else  if(varGetValue != "0")
         {
         tempMurrayPhotoID.add(MurrayPhotoID?.object(at: i)as! String)
         }
         }
         */
        // MurrayPhotoID=NSMutableArray()
        print("this is value from photo id::::-------------------")
        // MurrayPhotoID=tempMurrayPhotoID
        print(tempMurrayPhotoID)
        print(MurrayPhotoID)
        print(MurrayPhoto)
        print(MurrayText)
        for i in 00..<(MurrayPhotoID!.count){
            //working here
            // failing.......................................................
            print("count",i)
            if(i == 5  ){
                break
            }
            
            if(isCalledFRom == "Edit"){
                print("checkDataa")
                
                var getPhotoIs:String!=MurrayPhotoID![i] as! String
                if(getPhotoIs=="0")
                {
                    getPhotoIs="0"
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String) else {
//                    guard let params = getParameter(strPhotoid:getPhotoIs, strDesc: MurrayText![i] as! String) else {
                        return
                    }
                    print("Photo array completeURL :: \(completeURL)")
                    print("Photo array params:: \(params)")
                    let URL = queryString(urlString:completeURL, params:params)
                    print("Complete URL :: \(URL)")
                    wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as? UIImage,query:URL)
                    sleep(2)
                }
                else  if(getPhotoIs=="0")
                {
                    
                }
                else
                {
                      guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String) else {
                    
                    
//                    guard let params = getParameter(strPhotoid:getPhotoIs, strDesc: MurrayText![i] as! String) else {
                        return
                    }
                    print("Photo array completeURL 11 :: \(completeURL)")
                    print("Photo array params 11:: \(params)")

                    let URL = queryString(urlString:completeURL, params:params)
                    print("Complete URL 11 :: \(URL)")
                    wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as? UIImage,query:URL)
                    sleep(2)
                }
                
            }
            else if(isCalledFRom == "add"){
                
                
                var getPhotoIs:String!=MurrayPhotoID![i] as! String
                if(getPhotoIs=="0")
                {
                    getPhotoIs="0"
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String) else {
//                    guard let params = getParameter(strPhotoid:getPhotoIs, strDesc: MurrayText![i] as! String) else {
                        return
                    }
                    print("Photo array completeURL :: \(completeURL)")
                    print("Photo array params:: \(params)")
                    let URL = queryString(urlString:completeURL, params:params)
                    print("Complete URL :: \(URL)")
                    wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as? UIImage,query:URL)
                    sleep(2)
                }
                else  if(getPhotoIs=="0")
                {
                    
                }
                else
                {
                      guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String) else {
                    
                    
//                    guard let params = getParameter(strPhotoid:getPhotoIs, strDesc: MurrayText![i] as! String) else {
                        return
                    }
                    print("Photo array completeURL 11 :: \(completeURL)")
                    print("Photo array params 11:: \(params)")

                    let URL = queryString(urlString:completeURL, params:params)
                    print("Complete URL 11 :: \(URL)")
                    wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as? UIImage,query:URL)
                    sleep(2)
                }
                
            }
            else{
                var getPhotoIs:String!=MurrayPhotoID![i] as! String
                print("this is value for array:------------------------")
                print(getPhotoIs)
                print(MurrayPhotoID)
                if(getPhotoIs=="-1")
                {
                    guard let params = getParameter(strPhotoid:"0",strDesc: MurrayText![i] as! String) else {
                        return
                    }
                    
                    let URL = queryString(urlString:completeURL, params:params)
                    print(URL)
                    
                    wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as! UIImage,query:URL)
                    sleep(2)
                }
                
            }
            
        }
        
        SVProgressHUD.dismiss()
        if(isCalledFRom == "Edit"){
            
            print("this is value :------- - - - - - - - ")
            print(strWitchType)
            strWitchType=checkString
            print(strWitchType)
            print(checkString)
            if(strWitchType == nil || strWitchType == ""){}else{
                self.objProtocolNameNew?.functionForPopBackValue1(stringValue1: strWitchType!)
            }
            self.objProtocolNameNew?.functionForPopBackValue1(stringValue1: strWitchType!)
            let alert = UIAlertController(title: "", message: "\(alertTitle) Updated successfully.", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
//                let objAddPhoto = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoNewVC") as! AddPhotoNewVC
//
//
//
//                    self.navigationController?.pushViewController(objAddPhoto, animated: true)
//
                    let viewControllers: [UIViewController] = self.navigationController?.viewControllers as [UIViewController]
                   self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                   
                
                
                
                
                
//                self.navigationController?.popViewController(animated: true)
            }
            
            //              let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "NewShowCasePhotoDetailsVC") as! NewShowCasePhotoDetailsVC
            //              self.navigationController?.pushViewController(albumControllerObject, animated: true)
            //                    let albumControllerObject = self.storyboard?.instantiateViewController(withIdentifier: "ShowCaseAlbumListVC") as! ShowCaseAlbumListVC
            //
            //                    albumControllerObject.getGroupId = strGroupId
            //                    albumControllerObject.GetUserProfileID = strcreatedBy
            //                    albumControllerObject.getModuleID = moduleId
            //                   self.navigationController?.pushViewController(albumControllerObject, animated: true)
        }
        else{
            print("ALERT TITLE:: \(alertTitle)")
            let alert = UIAlertController(title: "", message: "\(alertTitle) Added successfully.", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when){
                
                // your code with delay
                
                alert.dismiss(animated: true, completion: nil)
                self.hideFloatButtonDelegate?.hideFloatAction()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    /* code comment by rajendra hittu code 13 dec
    func SendPhotoArrayToserver(muarrayImageID: NSMutableArray, muarrayImageText: NSMutableArray){
        SVProgressHUD.show()
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        let completeURL = baseUrl+"Gallery/AddUpdateAlbumPhoto?"
        print("countsd fsdfjdsjfd ========",MurrayPhoto?.count)
        
        
        
        //rajendra jat need to wor here 4 dec 2018
        print(self.MurrayText?.count)
        print(MurrayText)
        print(self.MurrayPhoto?.count)
        print(MurrayPhoto)

        //temp code
        print("<.....>")
        print(MurrayPhoto)
        print(MurrayPhoto?.count)
        var arrayTemporary:NSMutableArray=NSMutableArray()
        for i in 00..<5
        {
            print("Index:------")
            print(arrayTempImageIndexHold.object(at: i))
            var varGetValue:String!=arrayTempImageIndexHold.object(at: i) as! String
            if(varGetValue=="1")
            {
                arrayTemporary.add(i)
            }
            else  if(varGetValue=="0")
            {
                //addingArray.add
            }
            
        }

        print("this is index value by rajendra jat !!!!!!")
        print(arrayTemporary)
        
        
        var tempPhotoarray:NSMutableArray=NSMutableArray()
        var tempTextarray:NSMutableArray=NSMutableArray()

        for i in 00..<arrayTemporary.count
        {
            print(MurrayPhoto?.object(at: arrayTemporary.object(at: i) as! Int) as Any)
            var getvalue = MurrayPhoto?.object(at: arrayTemporary.object(at: i) as! Int) as Any
            tempPhotoarray.add(getvalue)
            
            var getvaluetext = MurrayText?.object(at: arrayTemporary.object(at: i) as! Int) as Any
            tempTextarray.add(getvaluetext)

            
            
            print(arrayTemporary)
        }
        
          print(tempPhotoarray)
        
        MurrayPhoto=NSMutableArray()
        MurrayPhoto=tempPhotoarray
        
        
        MurrayText=NSMutableArray()
        MurrayText=tempTextarray
        
        print("<.....>")
        print(MurrayPhoto)
        print(MurrayPhoto?.count)
        print(MurrayText)
        print(MurrayText?.count)
        print(MurrayPhotoID)
        print(MurrayPhotoID?.count)

        

        var tempMurrayPhotoID:NSMutableArray=NSMutableArray()
        
   
        for i in 00..<((MurrayPhotoID?.count)!){
            var varGetValue:String!=MurrayPhotoID?.object(at: i)as! String
            if(varGetValue=="0")
            {
                
            }
            else
            {
                tempMurrayPhotoID.add(MurrayPhotoID?.object(at: i)as! String)
            }
        }
        
        MurrayPhotoID=NSMutableArray()
        print("this is value from photo id::::-------------------")
        MurrayPhotoID=tempMurrayPhotoID
        print(tempMurrayPhotoID)
        print(MurrayPhotoID)
        
        
        for i in 00..<(((MurrayPhoto?.count)!)){
            
            print("count",i)
            if(isCalledFRom == "Edit"){
                
                guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String) else {
                    return
                }
                
                print("This is value from 10 Dec 2018 4.08pm")
                print(MurrayPhotoID![i])
                print(MurrayText![i] )

                
                
                
                let URL = queryString(urlString:completeURL, params:params)
                print(URL)
                print(completeURL)

                //code by rajendra jat because app was crashing due to null array 3 dec 2018
              
                wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as! UIImage,query:URL)
                sleep(2)
               
            }
            else{
                guard let params = getParameter(strPhotoid:"0",strDesc: MurrayText![i] as! String) else {
                    return
                }
                
                let URL = queryString(urlString:completeURL, params:params)
                print(URL)
                wsm.multiplePhotoUpdateGalleryPhoto(MurrayPhoto![i] as! UIImage,query:URL)
                sleep(2)
               
            }
            
        }
       
        
        SVProgressHUD.dismiss()
        if(isCalledFRom == "Edit"){
            
            if(checkString == nil || checkString == ""){}else{
            self.objProtocolNameNew?.functionForPopBackValue(stringValue1: checkString!)
            }
            
            
         
            let alert = UIAlertController(title: "", message: "Activity updated sucessfully", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when){
                
                // your code with delay
                
                alert.dismiss(animated: true, completion: nil)
                 self.navigationController?.popViewController(animated: true)
            }
           
        }
          
        else{
            let alert = UIAlertController(title: "", message: "Activity added sucessfully", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when){
                
                // your code with delay
                
                alert.dismiss(animated: true, completion: nil)
                 self.navigationController?.popViewController(animated: true)
            }
       
        }
       

    }
    */
    
    
    func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubListWhenComingFromEdit()
    {
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
     {
            self.showMBProgress(str: "")
        let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
        let parameterst =  ((self.navTitle) == ("Add Community Service Project") || (self.navTitle) == ("Edit Community Service Project")) ? [ "DistrictID":"0", "ShareType":"1"] : [ "DistrictID":"0", "ShareType":"0"]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
             print(response)
             
  let varGetValueServerError = response.object(forKey: "serverError")as? String
  if(varGetValueServerError == "Error")
  {
      self.hideMBProgress()
  }
  else
  {
    let responseDict = response.value(forKey: "ShowcaseDetails")as! NSDictionary
    let letGetMessage = (responseDict.value(forKey: "message"))as! String
    let letGetStatus = (responseDict.value(forKey: "status"))as! String
    // print(letGetMessage)
    //print(letGetStatus)
    
    if(letGetStatus == "0" && letGetMessage == "success")
    {
        self.muarrayCategoryListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Categories") as! NSArray
        if(self.muarrayCategoryListArray.count>0)
        {
            var dict : NSDictionary=NSDictionary()
            for i in 0..<self.muarrayCategoryListArray.count
            {
       let Name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: i) as! String
       let ID  = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: i) as! String
       let DistrictID  = (self.muarrayCategoryListArray.value(forKey: "DistrictID") as AnyObject).object(at: i) as! String
       dict = ["Name":Name,"ID":ID,"DistrictID":DistrictID]
       print(dict)
       self.muarrayForCategoryListWithOutZeroIndex.add(dict)
            }
            
  //Commented due to category,sub category validation on April 2020
//   var getCategoryText:String!=self.txtCategory.text!
//
//   print(getCategoryText)
//   if(getCategoryText.characters.count>0)
//   {
//
//   }
//   else
//   {
//   self.txtCategory.text! = (self.muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: 0) as! String
//   }
   
   //MARK:-add sub and sub to sub category
   if let subCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subcat") as? NSArray
    {
       print(subCategoryList)
     self.muarraySubCategoryListArray=subCategoryList
     }
     if let subToSubCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subtosubcat") as? NSArray
    {
         print(subToSubCategoryList)
     self.muarraySubToSubCategoryListArray=subToSubCategoryList
    }
     self.pickerFundinglist.reloadAllComponents()
    }
        else  if (self.checkString == "Service Projects"){
    self.view.makeToast("No Category", duration: 2, position: CSToastPositionCenter)
    }

    //Added funding drop down list
    if let FundingList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Fundinglist") as? NSArray
    {
        print(FundingList)
        self.muarrayFundinglistArray=FundingList
        self.pickerFundinglist.reloadAllComponents()
    }
        
  if(self.muarrayForCategoryListWithOutZeroIndex.count>0)
    {
      self.pickerCategory.reloadAllComponents()
    }
        self.functionForGetAlbumDetails_New()
    }
    else
    {
        self.hideMBProgress()
        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
        }
      }
   })
 }
    else
    {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
    }
    }
    
 func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
    {
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
  SVProgressHUD.show()
  let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
              let parameterst =  ((self.navTitle) == ("Add Community Service Project")) ? [ "DistrictID":"0", "ShareType":"1"] : [ "DistrictID":"0", "ShareType":"0"]
  print(parameterst)
  print(completeURL)
  ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
  //=> Handle server response
 //  print(response)
   
  let varGetValueServerError = response.object(forKey: "serverError")as? String
  if(varGetValueServerError == "Error")
  {
    SVProgressHUD.dismiss()
     // self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
  }
  else
  {
 let responseDict = response.value(forKey: "ShowcaseDetails")as! NSDictionary
 let letGetMessage = (responseDict.value(forKey: "message"))as! String
 let letGetStatus = (responseDict.value(forKey: "status"))as! String
 // print(letGetMessage)
 //print(letGetStatus)
 
 if(letGetStatus == "0" && letGetMessage == "success")
 {
     self.muarrayCategoryListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Categories") as! NSArray
     if(self.muarrayCategoryListArray.count>0)
     {
         var dict : NSDictionary=NSDictionary()
         for i in 0..<self.muarrayCategoryListArray.count
         {
             let Name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: i) as! String
           let ID  = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: i) as! String
           let DistrictID  = (self.muarrayCategoryListArray.value(forKey: "DistrictID") as AnyObject).object(at: i) as! String
           dict = ["Name":Name,"ID":ID,"DistrictID":DistrictID]
           //print(dict)
           self.muarrayForCategoryListWithOutZeroIndex.add(dict)
       }
        
//Commented due to category sub category validation
//       let getCategoryText:String!=self.txtCategory.text!
//
//       print(getCategoryText)
//       if(getCategoryText.count>0)
//       {
//
//       }
//       else
//       {
//       self.txtCategory.text! = (self.muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: 0) as! String
//       }

       //MARK:-add sub and sub to sub category111

       if let subCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subcat") as? NSArray
          {
           print(subCategoryList)
           self.muarraySubCategoryListArray=subCategoryList
           }
       
           if let subToSubCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subtosubcat") as? NSArray
          {
               print(subToSubCategoryList)
           self.muarraySubToSubCategoryListArray=subToSubCategoryList
          }
       //let ID  = (self.muarrayForCategoryListWithOutZeroIndex.value(forKey: "ID") as AnyObject).object(at: 0) as! String
       // print(ID)
       // self.varSetAlbumCategory = ID
   }
   else
   {
       self.view.makeToast("No Category", duration: 2, position: CSToastPositionCenter)
   }
    
    //Added funding drop down list
    if let FundingList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Fundinglist") as? NSArray
    {
        print(FundingList)
        self.muarrayFundinglistArray=FundingList
        self.pickerFundinglist.reloadAllComponents()
    }

   if(self.muarrayForCategoryListWithOutZeroIndex.count>0)
   {
       self.pickerCategory.reloadAllComponents()
   }
 }
    else
    {
    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
    }
    SVProgressHUD.dismiss()
            }
        })
        }
          else
          {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            
        }
    }
    
    /// To Show the Date in String format
    func convertToShowFormatDate(dateString: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "dd MMM yyyy" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    
    
    func convertToShowFormatDate2(dateString: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "dd MMM yyyy" //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)! //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    //This is updated function after April 2020
    func functionForGetAlbumDetails_New()
    {
        self.showMBProgress(str: "")
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
          {
        let completeURL = baseUrl+"Gallery/GetAlbumDetails_New"
        var parameterst:NSDictionary=NSDictionary()
            parameterst =  ["albumId":strAlbumId as Any,"Financeyear":year]
        print(parameterst)
        print(completeURL)
              ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: { [self](response: AnyObject) -> Void in
  //=> Handle server response
  let dd = response as! NSDictionary
  print("dd \(dd)")
  let varGetValueServerError = response.object(forKey: "serverError")as? String
  if(varGetValueServerError == "Error")
  {
    self.hideMBProgress()
 }
  else
  {
  if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    
  let arrarrNewGroupList = (dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "AlbumDetailResult") as! NSArray
  let details = arrarrNewGroupList.value(forKey: "AlbumDetail") as! NSArray
  print(details)
      
    
    let isWhatsapp  = ((details.value(forKey: "issendwhatsapp") as AnyObject).object(at: 0) as! String)
    
    if isWhatsapp == "1" {
        self.whatsappOnOffBtn.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
        self.issendwhatsapp = "1"
    }
    else{
        self.whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
        self.issendwhatsapp = "0"
    }
    
//    whatsappOnOffBtn.setImage(UIImage(named: "switchOn"),  for: UIControl.State.normal)
//}
//else{
//    whatsappOnOffBtn.setImage(UIImage(named: "switchOff"),  for: UIControl.State.normal)
//    issendwhatsapp = "0"
    
    
    
  let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
  if(shareType == "0"){
    
    if self.isFromMoveToService == "yes"
     {
      self.checkString = "Service Projects"
      self.tblClube.isHidden = true
      self.tblRotary.isHidden = false
//        let fID=(details.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: 0) as! String
//         print(fID)
//        self.fundID=fID
//         let fundName = (onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: row) as! String
     //.text=fundName
//     selectProjBtnnnnnn .setTitle(details.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: 0) as! String, for: UIControl.State.normal)
        self.selectProjBtnnnnnn.setTitle((details.value(forKey: "TtlOfNewOngoingProj")as AnyObject).object(at: 0)as! String, for: UIControl.State.normal)
//        {
//          self.checkString = "Service Projects"
//          self.tblClube.isHidden = true
//          self.tblRotary.isHidden = false
        
        let OnetimeOrOngoingType  = ((details.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at: 0) as! String)

        
            let newOrExitType  = ((details.value(forKey: "NewOrExisting") as AnyObject).object(at: 0) as! String)
            let JoinedOrNotType  = ((details.value(forKey: "JoinedOrNot") as AnyObject).object(at: 0) as! String)
//            let JoinedOrNotType  = (details.value(forKey: "JoinedOrNot") as AnyObject).object(at: 0) as! String
            let ClubRoleType  = ((details.value(forKey: "ClubRole") as AnyObject).object(at: 0) as! String)
    //        let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
    //        let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
        print("OnetimeOrOngoingType:: \(OnetimeOrOngoingType)")
        self.oneTimeOngoingSelectType=OnetimeOrOngoingType

        self.JoinedOrNotSelectType=JoinedOrNotType
      
        self.ClubRole=ClubRoleType
  
        self.NewOrExistingSelectType=newOrExitType
//               JoinedOrNotSelectType == "0"
        
        print(self.NewOrExistingSelectType)
        print(self.ClubRole)
        print( self.JoinedOrNotSelectType)
        print(self.NewOrExistingSelectType)
        
        
        
        
        
            if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "0" {
                
    //            let screenSize: CGRect = UIScreen.main.bounds
    //            let screenWidth = screenSize.width
    //            let screenHeight = screenSize.height
                self.isselectFromExiting = true
                self.Iscreatenew = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
        //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
        //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.isOnetimeProject = false
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
               
                self.serviceProFooterView.frame = CGRect(x: 0, y: 370, width: screenWidth, height: (3500))
           
            }
            if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "2" {
                
    //            let screenSize: CGRect = UIScreen.main.bounds
    //            let screenWidth = screenSize.width
    //            let screenHeight = screenSize.height
                self.isselectFromExiting = true
                self.Iscreatenew = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
                self.IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
        //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
        //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.isOnetimeProject = false
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
               
                self.serviceProFooterView.frame = CGRect(x: 0, y: 370, width: screenWidth, height: (3500))
           
            }
            if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "0"{
                //            {
                    //            {
                                    
    //                                let screenSize: CGRect = UIScreen.main.bounds
    //                                let screenWidth = screenSize.width
    //                                let screenHeight = screenSize.height
                self.Iscreatenew = false
                self.isselectFromExiting = true
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                    
                            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                self.leadClubImg.image = UIImage(named: "RoundUncheck")
                                  
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                    //            }
                //            }
                        }
            if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "1"{
                //            {
                    //            {
                                    
    //                                let screenSize: CGRect = UIScreen.main.bounds
    //                                let screenWidth = screenSize.width
    //                                let screenHeight = screenSize.height
                self.Iscreatenew = false
                self.isselectFromExiting = true
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                    
                            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
                                  
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                    //            }
                //            }
                        }
            
            if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "2"{
                //            {
                    //            {
                                    
    //                                let screenSize: CGRect = UIScreen.main.bounds
    //                                let screenWidth = screenSize.width
    //                                let screenHeight = screenSize.height
                self.Iscreatenew = false
                self.isselectFromExiting = true
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                    
                            //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                            //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                self.leadClubImg.image = UIImage(named: "RoundUncheck")
                                  
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                    //            }
                //            }
                        }
            if OnetimeOrOngoingType == "2" && newOrExitType == "0"{
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "RoundUncheck")
                self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
    //            IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
    //            IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
    //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.isOnetimeProject = false
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
    //            IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
    //            clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 3500)
            }
            if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "0" {
                
                self.isMainProjectSelect = "yes"
                self.header1View.isHidden = true
                self.secondSelectionVieww.isHidden = true
                
                self.Iscreatenew = true
                self.isselectFromExiting = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "RoundUncheck")
                self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
        //        coHostBtnImg.image = UIImage(named: "RoundUncheck")
        //        leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.isOnetimeProject = false
//                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//        //        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3186)
                
                
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
                self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 0)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 3500)
                
                
                
                
                
                
                
            }
            if OnetimeOrOngoingType == "2"  && JoinedOrNotType == "1" && ClubRoleType == "1" {
                //            {
                                
    //                            let screenSize: CGRect = UIScreen.main.bounds
    //                            let screenWidth = screenSize.width
    //                            let screenHeight = screenSize.height
                                
                self.Iscreatenew = true
                self.isselectFromExiting = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                
                        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "RoundUncheck")
                self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
                               
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: 3500)
                //            }
                        }
            if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "1" && ClubRoleType == "2" {
                //            {
                
                self.isMainProjectSelect = "yes"
                self.header1View.isHidden = true
                self.secondSelectionVieww.isHidden = true
    //                            let screenSize: CGRect = UIScreen.main.bounds
    //                            let screenWidth = screenSize.width
    //                            let screenHeight = screenSize.height
                                
                self.Iscreatenew = true
                self.isselectFromExiting = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                
                        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "RoundUncheck")
                self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
                self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
                self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                self.leadClubImg.image = UIImage(named: "RoundUncheck")
                               
//                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//                self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                self.serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: 3186)
//
                
//                functionForGetAlbumDetails_New
                
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
                self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
                
                
                
                
                
                
                //            }
                        }
            if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "2" {
                self.isMainProjectSelect = "yes"
                self.header1View.isHidden = true
                self.secondSelectionVieww.isHidden = true
                
                self.Iscreatenew = true
                self.isselectFromExiting = false
                self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
                self.createNewProImg.image = UIImage(named: "RoundUncheck")
                self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
                self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
        //        coHostBtnImg.image = UIImage(named: "RoundUncheck")
        //        leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.isOnetimeProject = false
//                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//        //        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//                self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3186)
//
                
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
                self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
                self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
                self.clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 0)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 3500)
                
                
                
                
            }
            
            
            
            
            
            
            if OnetimeOrOngoingType == "0" {
                
            }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "0" {
    //            {
        //            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
        //            ongoingProImg.image = UIImage(named: "RoundUncheck")
                self.isOngoingProject = false
                    
                self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                    
                    
                    
        //            isOnetimeProject = true
                self.IsprojYEsImg.image = UIImage(named: "RoundUncheck")
                self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
        //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
        //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
        //            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 3500)
    //            }
            }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" {
                
    //            let screenSize: CGRect = UIScreen.main.bounds
    //            let screenWidth = screenSize.width
    //            let screenHeight = screenSize.height
                
                
                
                self.isOngoingProject = false
                self.isOnetimeProject = true
                self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                
                
                
        //            isOnetimeProject = true
                self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                self.leadClubImg.image = UIImage(named: "RoundUncheck")
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.selectProjWalaVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.IsProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
                self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 290, width: screenWidth, height: 3500)
            }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "2" {
                //            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                //            ongoingProImg.image = UIImage(named: "RoundUncheck")
                self.isOngoingProject = false
                            
                self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                            
                            
                            
                //            isOnetimeProject = true
                self.IsprojYEsImg.image = UIImage(named: "RoundUncheck")
                self.IsProjNoImg.image = UIImage(named: "radio_btn_Check1")
                //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
                //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
                //            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 3500)
                        }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "0" {
                
    //            let screenSize: CGRect = UIScreen.main.bounds
    //            let screenWidth = screenSize.width
    //            let screenHeight = screenSize.height
                
                
                
                self.isOngoingProject = false
                
                self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                
                
                
        //            isOnetimeProject = true
                self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                self.leadClubImg.image = UIImage(named: "RoundUncheck")
                self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
                self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
                self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
            }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "1" {
                
                //            let screenSize: CGRect = UIScreen.main.bounds
                //            let screenWidth = screenSize.width
                //            let screenHeight = screenSize.height
                            
                            
                            
                            self.isOngoingProject = false
                            
                            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                            
                            
                            
                    //            isOnetimeProject = true
                            self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                            self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                            self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
                            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                            self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                            self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
                            self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
                            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
                        }
            if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "2" {
                
                //            let screenSize: CGRect = UIScreen.main.bounds
                //            let screenWidth = screenSize.width
                //            let screenHeight = screenSize.height
                            
                            
                            
                            self.isOngoingProject = false
                            
                            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                            
                            
                            
                    //            isOnetimeProject = true
                            self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                            self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                            self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                            self.leadClubImg.image = UIImage(named: "RoundUncheck")
                            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                            self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                            self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
                            self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
                            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
                        }
            
//        }
        
     }
    else{
        self.checkString = "Club Service"
        self.tblClube.isHidden = false
        self.tblRotary.isHidden = true
      
    }
    
    
  }
  else{
    
    if self.isFromMoveToClub == "yes"
    {
        self.checkString = "Club Service"
        self.tblClube.isHidden = false
        self.tblRotary.isHidden = true
    }
    else{
      self.checkString = "Service Projects"
      self.tblClube.isHidden = true
      self.tblRotary.isHidden = false
        
        self.selectProjBtnnnnnn.setTitle((details.value(forKey: "TtlOfNewOngoingProj")as AnyObject).object(at: 0)as! String, for: UIControl.State.normal)
        
        let OnetimeOrOngoingType  = ((details.value(forKey: "OnetimeOrOngoing") as AnyObject).object(at: 0) as! String)
        let newOrExitType  = ((details.value(forKey: "NewOrExisting") as AnyObject).object(at: 0) as! String)
        let JoinedOrNotType  = ((details.value(forKey: "JoinedOrNot") as AnyObject).object(at: 0) as! String)
        let ClubRoleType  = ((details.value(forKey: "ClubRole") as AnyObject).object(at: 0) as! String)
//        let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
//        let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
        
        self.oneTimeOngoingSelectType=OnetimeOrOngoingType

        self.JoinedOrNotSelectType=JoinedOrNotType
      
        self.ClubRole=ClubRoleType
  
        self.NewOrExistingSelectType=newOrExitType
//               JoinedOrNotSelectType == "0"
        
        print(self.NewOrExistingSelectType)
        print(self.ClubRole)
        print( self.JoinedOrNotSelectType)
        print(self.NewOrExistingSelectType)
        

        
        
        
        if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "0" {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
            self.isselectFromExiting = true
            self.Iscreatenew = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
    //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.isOnetimeProject = false
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
           
            self.serviceProFooterView.frame = CGRect(x: 0, y: 370, width: screenWidth, height: 3500)
       
        }
        if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "2" {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
            self.isselectFromExiting = true
            self.Iscreatenew = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                
    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
            self.IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
    //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.isOnetimeProject = false
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
           
            self.serviceProFooterView.frame = CGRect(x: 0, y: 370, width: screenWidth, height: 3500)
       
        }
        if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "0"{
            //            {
                //            {
                                
//                                let screenSize: CGRect = UIScreen.main.bounds
//                                let screenWidth = screenSize.width
//                                let screenHeight = screenSize.height
            self.Iscreatenew = false
            self.isselectFromExiting = true
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                
                        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
            self.leadClubImg.image = UIImage(named: "RoundUncheck")
                              
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                //            }
            //            }
                    }
        if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "1"{
            //            {
                //            {
                                
//                                let screenSize: CGRect = UIScreen.main.bounds
//                                let screenWidth = screenSize.width
//                                let screenHeight = screenSize.height
            self.Iscreatenew = false
            self.isselectFromExiting = true
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                
                        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
            self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
                              
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                //            }
            //            }
                    }
        
        if OnetimeOrOngoingType == "2" && newOrExitType == "2" && JoinedOrNotType == "1" && ClubRoleType == "2"{
            //            {
                //            {
                                
//                                let screenSize: CGRect = UIScreen.main.bounds
//                                let screenWidth = screenSize.width
//                                let screenHeight = screenSize.height
            self.Iscreatenew = false
            self.isselectFromExiting = true
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                                
                        //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                        //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "radio_btn_Check1")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
            self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
            self.leadClubImg.image = UIImage(named: "RoundUncheck")
                              
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 80)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 380, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: 3500)
                //            }
            //            }
                    }
        if OnetimeOrOngoingType == "2" && newOrExitType == "0"{
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            
//            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
//            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "RoundUncheck")
            self.selectExitProjImg.image = UIImage(named: "RoundUncheck")
//            IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
//            IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
//            coHostBtnImg.image = UIImage(named: "RoundUncheck")
//            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.isOnetimeProject = false
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
//            IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//            clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 0)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: (screenHeight-190))
        }
        if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "0" {
            self.isMainProjectSelect = "yes"
            self.header1View.isHidden = true
            self.secondSelectionVieww.isHidden = true
            
            self.Iscreatenew = true
            self.isselectFromExiting = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            
    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "RoundUncheck")
            self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
    //        coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //        leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.isOnetimeProject = false
//            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//    //        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3186)
//
            
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
            self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
//            self.clubRoleView.frame = CGRect(x: 0, y: 400, width: screenWidth, height: 0)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 3500)
            
            
            
            
//            newOrExitType == "1"
            
            
            
        }
        if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "1" && ClubRoleType == "1" {
            //            {
            self.isMainProjectSelect = "yes"
            self.header1View.isHidden = true
            self.secondSelectionVieww.isHidden = true
//                            let screenSize: CGRect = UIScreen.main.bounds
//                            let screenWidth = screenSize.width
//                            let screenHeight = screenSize.height
                            
            self.Iscreatenew = true
            self.isselectFromExiting = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                            
                    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "RoundUncheck")
            self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
            self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
                           
//            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//            self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//            self.serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: 3186)
            
            
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
            self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
            
            
            
            
            
            
            
            //            }
                    }
        if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "1" && ClubRoleType == "2" {
            //            {
            self.isMainProjectSelect = "yes"
            self.header1View.isHidden = true
            self.secondSelectionVieww.isHidden = true
//                            let screenSize: CGRect = UIScreen.main.bounds
//                            let screenWidth = screenSize.width
//                            let screenHeight = screenSize.height
                            
            self.Iscreatenew = true
            self.isselectFromExiting = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                            
                    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
                    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "RoundUncheck")
            self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProjNoImgg.image = UIImage(named: "RoundUncheck")
            self.IsJointProYesImg.image = UIImage(named: "radio_btn_Check1")
            self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
            self.leadClubImg.image = UIImage(named: "RoundUncheck")
                           
//            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//            self.clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//            self.serviceProFooterView.frame = CGRect(x: 0, y: 390, width: screenWidth, height: 3186)
            
            self.header1View.isHidden = true
            self.secondSelectionVieww.isHidden = true
            
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
            self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 120)
            self.clubRoleView.frame = CGRect(x: 0, y: 210, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
            
            
            
            
            
            
            
            
            //            }
                    }
        if OnetimeOrOngoingType == "2" && newOrExitType == "1" && JoinedOrNotType == "2" {
            
            self.isMainProjectSelect = "yes"
            self.header1View.isHidden = false
            self.secondSelectionVieww.isHidden = false
            self.Iscreatenew = true
            self.isselectFromExiting = false
            self.oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.ongoingProImg.image = UIImage(named: "radio_btn_Check1")
            
    //            ongoingProImg.image = UIImage(named: "radio_btn_Check1")
    //            oneTimeProjImg.image = UIImage(named: "RoundUncheck")
            self.createNewProImg.image = UIImage(named: "RoundUncheck")
            self.selectExitProjImg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProjNoImgg.image = UIImage(named: "radio_btn_Check1")
            self.IsJointProYesImg.image = UIImage(named: "RoundUncheck")
    //        coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //        leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.isOnetimeProject = false
//            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
//            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 120)
//    //        clubRoleView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 90)
//            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3186)
            
//            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//            self.secondSelectionVieww.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 0)
//            self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 90)
//            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 120)
//            self.clubRoleView.frame = CGRect(x: 0, y: 220, width: screenWidth, height: 0)
//            self.serviceProFooterView.frame = CGRect(x: 0, y: 220, width: screenWidth, height: 3500)
            
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 80)
            self.titleOfOngoingWalaView.frame = CGRect(x: 0, y: 255, width: screenWidth, height: 90)
            self.IsJointProjWalaView.frame = CGRect(x: 0, y: 345, width: screenWidth, height: 80)
            self.clubRoleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 425, width: screenWidth, height: 3500)
            
            
            
        }
        
        
        
        
        
        
        if OnetimeOrOngoingType == "0" {
            
        }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "0" {
//            {
    //            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
    //            ongoingProImg.image = UIImage(named: "RoundUncheck")
            self.isOngoingProject = false
                
            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                
                
                
    //            isOnetimeProject = true
            self.IsprojYEsImg.image = UIImage(named: "RoundUncheck")
            self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
    //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
    //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
    //            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 3500)
//            }
        }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
            
            
            
            self.isOngoingProject = false
            self.isOnetimeProject = true
            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
    //            isOnetimeProject = true
            self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
            self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
            self.leadClubImg.image = UIImage(named: "RoundUncheck")
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.selectProjWalaVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.IsProjWalaView.frame = CGRect(x: 0, y: 90, width: screenWidth, height: 100)
            self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 290, width: screenWidth, height: 3500)
        }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "2" {
            //            oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            //            ongoingProImg.image = UIImage(named: "RoundUncheck")
            self.isOngoingProject = false
                        
            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                        
                        
                        
            //            isOnetimeProject = true
            self.IsprojYEsImg.image = UIImage(named: "RoundUncheck")
            self.IsProjNoImg.image = UIImage(named: "radio_btn_Check1")
            //            coHostBtnImg.image = UIImage(named: "RoundUncheck")
            //            leadClubImg.image = UIImage(named: "radio_btn_Check1")
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.IsProjWalaView.frame = CGRect(x: 0, y: 180, width: screenWidth, height: 100)
            //            clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 90)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 270, width: screenWidth, height: 3500)
                    }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "0" {
            
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
            
            
            
            self.isOngoingProject = false
            
            self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
            self.ongoingProImg.image = UIImage(named: "RoundUncheck")
            
            
            
    //            isOnetimeProject = true
            self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
            self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
            self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
            self.leadClubImg.image = UIImage(named: "RoundUncheck")
            self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
            self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
            self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
        }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "1" {
            
            //            let screenSize: CGRect = UIScreen.main.bounds
            //            let screenWidth = screenSize.width
            //            let screenHeight = screenSize.height
                        
                        
                        
                        self.isOngoingProject = false
                        
                        self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                        self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                        
                        
                        
                //            isOnetimeProject = true
                        self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                        self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                        self.coHostBtnImg.image = UIImage(named: "RoundUncheck")
                        self.leadClubImg.image = UIImage(named: "radio_btn_Check1")
//                        self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
//                        self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
//                        self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
//                        self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
//                        self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height:3500)
            header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
            IsJointProjWalaView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            selectProjWalaVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
            IsProjWalaView.frame = CGRect(x: 0, y: 175, width: screenWidth, height: 100)
            clubRoleView.frame = CGRect(x: 0, y: 275, width: screenWidth, height: 233)
            serviceProFooterView.frame = CGRect(x: 0, y: 508, width: screenWidth, height: (3500))
                    }
        if OnetimeOrOngoingType == "1" && JoinedOrNotType == "1" && ClubRoleType == "2" {
            
            //            let screenSize: CGRect = UIScreen.main.bounds
            //            let screenWidth = screenSize.width
            //            let screenHeight = screenSize.height
                        
                        
                        
                        self.isOngoingProject = false
                        
                        self.oneTimeProjImg.image = UIImage(named: "radio_btn_Check1")
                        self.ongoingProImg.image = UIImage(named: "RoundUncheck")
                        
                        
                        
                //            isOnetimeProject = true
                        self.IsprojYEsImg.image = UIImage(named: "radio_btn_Check1")
                        self.IsProjNoImg.image = UIImage(named: "RoundUncheck")
                        self.coHostBtnImg.image = UIImage(named: "radio_btn_Check1")
                        self.leadClubImg.image = UIImage(named: "RoundUncheck")
                        self.header1View.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 175)
                        self.secondSelectionVieww.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
                        self.IsProjWalaView.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 100)
                        self.clubRoleView.frame = CGRect(x: 0, y: 190, width: screenWidth, height: 233)
                        self.serviceProFooterView.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 3500)
                    }
        
    }
  }
  let srtdate = ((details.value(forKey: "project_date") as AnyObject).object(at: 0) as! String)
  
  print("datess:-------------",srtdate)
  self.strSelectDate = srtdate
  print("datess:-------------",self.strSelectDate)
  self.txtSelectDate.text = self.convertToShowFormatDate(dateString: srtdate)
  self.txtSelectedDateRot.text =  self.convertToShowFormatDate(dateString: srtdate)
    functionForBODCount()
    print(self.onlinemuarrayModule)
    
    
    
    
//    self.selectProjBtnnnnnn .setTitle((details.value(forKey: "FK_SelectExistingProject") as AnyObject).object(at: 0) as! String, for: UIControl.State.normal)
    
    let  selectProjTypeNew = ((details.value(forKey: "FK_SelectExistingProject") as AnyObject).object(at: 0) as! String)
    
   
//    let  selectProjTypeIDLIST = (self.onlinemuarrayModule.value(forKey: "pk_gallery_id")as? String)
//    for item in self.onlinemuarrayModule {
//        print(item)
//        let vghvg = item.self[""]
//        print(selectProjTypeIDLIST)
//        print(selectProjTypeNew)
//
//        if selectProjTypeNew == selectProjTypeIDLIST {
//            print("fnsdjhvsbdfv")
//        }
//        else{
//            print("YESSSSSS")
//        }
//
//    }
    
    var value = 0
    let jsonArray = self.onlinemuarrayModule.value(forKey: "pk_gallery_id") as! NSArray

            for json in jsonArray {
              print(json)
                value += 1
                let selectProjeValue = json as AnyObject
                let x = json
                let str1 = "\(x)"
                if selectProjTypeNew == str1 {
                    print("yesss")
                    
                    
                    self.selectProjBtnnnnnn .setTitle((self.onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: value-1) as! String, for: UIControl.State.normal)
                    
                    
//                    self.selectProjBtnnnnnn .setTitle(self.onlinemuarrayModule.value(forKey: "TtlOfNewOngoingProj") as! String, for: UIControl.State.normal)
                }
                else{
                    print("no")
                }
                
                print(selectProjeValue)
            }
   
    
  self.txtAttendance.text = ((details.value(forKey: "Attendance") as AnyObject).object(at: 0) as! String)
  self.txtAttendancePercent.text = ((details.value(forKey: "AttendancePer") as AnyObject).object(at: 0) as! String)
  let  mettingType = ((details.value(forKey: "MeetingType") as AnyObject).object(at: 0) as! String)
  let newStringAgenda = ((details.value(forKey: "AgendaDocID") as AnyObject).object(at: 0) as! String)
  let newStringMetting = ((details.value(forKey: "MOMDocID") as AnyObject).object(at: 0) as! String)
  let newStringAgendaName = ((details.value(forKey: "AgendaDoc") as AnyObject).object(at: 0) as! String)
  let newStringMettingName = ((details.value(forKey: "MOMDoc") as AnyObject).object(at: 0) as! String)
  
  //code by rajendra jat put momid and docid
  print("this is doc id and agenda id by Rajendra Jat 6Dec 2.45pm")
 self.AgendaDocID=newStringAgenda

  self.MOMDocID=newStringMetting
  print(newStringAgenda)
  print(newStringMetting)

  print("this is meeting type:----")
  print(mettingType)
  
  if(mettingType == "0"){
    
    //newStringMettingName
    let fullNameArr = newStringAgendaName.characters.split{$0 == "/"}.map(String.init)
    
    print("this is value here from 10 Dec")
    print(newStringAgendaName)
    print(newStringAgenda)
    print(fullNameArr)
    print(newStringAgenda)
    self.txtMettingType.text = "Regular"
    //this is for agenda seting button
    if(newStringAgenda == "0" || newStringAgenda == "" || fullNameArr.count<=0){
        self.btnAgenda.isEnabled = true
        self.btnMinutesofMetting.isEnabled = true
    }else{
         let strAgendaName = fullNameArr[5]
         self.CheckAgend = "X"
        self.lblAgendaDownloaded.text = strAgendaName
        self.btnAgenda.setTitle("X", for: UIControl.State.normal)
        self.btnAgenda.isEnabled = true
        self.btnMinutesofMetting.isEnabled = true
    }
    let fullNameArraynew = newStringMettingName.characters.split{$0 == "/"}.map(String.init)

    print("this is mom array")
    print(fullNameArraynew)
    
    if(newStringMetting == "0" || newStringMetting == "" || fullNameArraynew.count<=0){
        self.btnAgenda.isEnabled = true
        self.btnMinutesofMetting.isEnabled = true
    }else{
        let  strMettingNames = fullNameArraynew[5]
        self.CheckMettng = "X"
        self.lblMeetingDownloaded.text = strMettingNames
        self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
        self.btnAgenda.isEnabled = true
        self.btnMinutesofMetting.isEnabled = true
    }

}
  else if (mettingType == "4")
  {
      
      //newStringMettingName
      let fullNameArr = newStringAgendaName.characters.split{$0 == "/"}.map(String.init)
      
      print("this is value here from 10 Dec")
      print(newStringAgendaName)
      print(newStringAgenda)
      print(fullNameArr)
      print(newStringAgenda)
      self.txtMettingType.text = "Trust"
      //this is for agenda seting button
      if(newStringAgenda == "0" || newStringAgenda == "" || fullNameArr.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
           let strAgendaName = fullNameArr[5]
           self.CheckAgend = "X"
          self.lblAgendaDownloaded.text = strAgendaName
          self.btnAgenda.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }
      let fullNameArraynew = newStringMettingName.characters.split{$0 == "/"}.map(String.init)

      print("this is mom array")
      print(fullNameArraynew)
      
      if(newStringMetting == "0" || newStringMetting == "" || fullNameArraynew.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
          let  strMettingNames = fullNameArraynew[5]
          self.CheckMettng = "X"
          self.lblMeetingDownloaded.text = strMettingNames
          self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }

  }
  else if (mettingType == "3")
  {
      
      //newStringMettingName
      let fullNameArr = newStringAgendaName.characters.split{$0 == "/"}.map(String.init)
      
      print("this is value here from 10 Dec")
      print(newStringAgendaName)
      print(newStringAgenda)
      print(fullNameArr)
      print(newStringAgenda)
      self.txtMettingType.text = "Fellowship"
      //this is for agenda seting button
      if(newStringAgenda == "0" || newStringAgenda == "" || fullNameArr.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
           let strAgendaName = fullNameArr[5]
           self.CheckAgend = "X"
          self.lblAgendaDownloaded.text = strAgendaName
          self.btnAgenda.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }
      let fullNameArraynew = newStringMettingName.characters.split{$0 == "/"}.map(String.init)

      print("this is mom array")
      print(fullNameArraynew)
      
      if(newStringMetting == "0" || newStringMetting == "" || fullNameArraynew.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
          let  strMettingNames = fullNameArraynew[5]
          self.CheckMettng = "X"
          self.lblMeetingDownloaded.text = strMettingNames
          self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }

  }
  else if(mettingType == "1"){
      
      //newStringMettingName
      let fullNameArr = newStringAgendaName.characters.split{$0 == "/"}.map(String.init)
      
      print("this is value here from 10 Dec")
      print(newStringAgendaName)
      print(newStringAgenda)
      print(fullNameArr)
      print(newStringAgenda)
      self.txtMettingType.text = "BOD"
      //this is for agenda seting button
      if(newStringAgenda == "0" || newStringAgenda == "" || fullNameArr.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
           let strAgendaName = fullNameArr[5]
           self.CheckAgend = "X"
          self.lblAgendaDownloaded.text = strAgendaName
          self.btnAgenda.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }
      let fullNameArraynew = newStringMettingName.characters.split{$0 == "/"}.map(String.init)

      print("this is mom array")
      print(fullNameArraynew)
      
      if(newStringMetting == "0" || newStringMetting == "" || fullNameArraynew.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
          let  strMettingNames = fullNameArraynew[5]
          self.CheckMettng = "X"
          self.lblMeetingDownloaded.text = strMettingNames
          self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }

  } else if(mettingType == "2"){
      
      let fullNameArr = newStringAgendaName.characters.split{$0 == "/"}.map(String.init)
      
      print("this is array value from add photo new vc")
      print(fullNameArr)
      print(((details.value(forKey: "MOMDoc") as AnyObject).object(at: 0) as! String))
      print("this is array value from add photo new vc end")

      print(newStringAgenda.characters.count)
      print(newStringAgenda)

      self.txtMettingType.text = "Assembly"

    if(newStringAgenda == "0" || newStringAgenda == "" || fullNameArr.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
          if(fullNameArr.count>1)
          {
          let strAgendaName = fullNameArr[5]
          self.CheckAgend = "X"
          self.lblAgendaDownloaded.text = strAgendaName
          self.btnAgenda.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
          }
      }
      
      let fullNameArrarynew = newStringMettingName.characters.split{$0 == "/"}.map(String.init)

      
      print(fullNameArrarynew)
      
      if(newStringMetting == "0" || newStringMetting == "" || fullNameArrarynew.count<=0){
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }else{
          let  strMettingNames = fullNameArrarynew[5]
          self.CheckMettng = "X"
          self.lblMeetingDownloaded.text = strMettingNames
          self.btnMinutesofMetting.setTitle("X", for: UIControl.State.normal)
          self.btnAgenda.isEnabled = true
          self.btnMinutesofMetting.isEnabled = true
      }
     
  }
  
  self.txtTitle.text = ((details.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String)
    self.titleOfNewOngoingProjectTX.text = ((details.value(forKey: "TtlOfNewOngoingProj") as AnyObject).object(at: 0) as! String)
  self.txtViewDesc.text = ((details.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String)
      //--------------------------------------------------------NEWFIELDADDED
      if let amt = ((details.value(forKey: "amt_sancted") as AnyObject).object(at: 0) as? Int) {
          print("AMOUNT SANCTIONED1:: \(amt)")
          if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "Global Grant" {
              if amt == 0 {
                  self.globalGrantSanTF.text = ""
              } else {
                  self.globalGrantSanTF.text = "\(amt)"
              }
          } else if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "CSR" {
              if amt == 0 {
                  self.amtSanCsrTF.text = ""
              } else {
                  self.amtSanCsrTF.text = "\(amt)"
              }
          }
          
      }
      if let amt = ((details.value(forKey: "global_grt_num") as AnyObject).object(at: 0) as? Int) {
          print("AMOUNT SANCTIONED12:: \(amt)")
          if amt == 0 {
              self.globalGrantNoTF.text = ""
          } else {
              self.globalGrantNoTF.text = "\(amt)"
          }
      }
      if let amt = ((details.value(forKey: "amt_recved") as AnyObject).object(at: 0) as? Int) {
          print("AMOUNT SANCTIONED123:: \(amt)")
          if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "Global Grant" {
              if amt == 0 {
                  self.globalGrantAmtRecTF.text = ""
              } else {
                  self.globalGrantAmtRecTF.text = "\(amt)"
              }
          } else if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "CSR" {
              if amt == 0 {
                  self.amtRecCsrTF.text = ""
              } else {
                  self.amtRecCsrTF.text = "\(amt)"
              }
          }
          
      }
      if let amt = ((details.value(forKey: "amt_spnt_till") as AnyObject).object(at: 0) as? Int) {
          print("AMOUNT SANCTIONED1234:: \(amt)")
          if amt == 0 {
              self.globalGrantAmtSpenTF.text = ""
          } else {
              self.globalGrantAmtSpenTF.text = "\(amt)"
          }
      }
      
      self.globalGrantHostTF.text = ((details.value(forKey: "host_club_district") as AnyObject).object(at: 0) as? String)
      self.globalGrantPartnerTF.text = ((details.value(forKey: "globl_partner") as AnyObject).object(at: 0) as? String)
      self.csrNameTF.text = ((details.value(forKey: "csr_company") as AnyObject).object(at: 0) as? String)
      self.locationOfProjectTF.text = ((details.value(forKey: "prjct_loctn") as AnyObject).object(at: 0) as? String)
      self.hostRotaryClubTF.text = ((details.value(forKey: "co_host_club_orgnistn") as AnyObject).object(at: 0) as? String)
      
      if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "Global Grant" {
          self.globalTF()
      } else if ((details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String) == "CSR" {
          self.csrTF()
      }
                
  //code by Rajendra jat 3 dec 5.13pm
  self.txtCost.text = ((details.value(forKey: "project_cost") as AnyObject).object(at: 0) as! String)
  self.txtBenificary.text = ((details.value(forKey: "beneficiary") as AnyObject).object(at: 0) as! String)
  self.txtmanHours.text = ((details.value(forKey: "working_hour") as AnyObject).object(at: 0) as! String)
  self.txtRotatiran.text = ((details.value(forKey: "NumberOfRotarian") as AnyObject).object(at: 0) as! String)
  self.txtRotetoryTitle.text = ((details.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String)
  self.txtRotDesc.text = ((details.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String)
  
  
                
  //MARK:-New field get from Server
   if (self.checkString=="Service Projects"){
      self.categoryId = ((details.value(forKey: "albumCategoryID") as AnyObject).object(at: 0) as! String)
      let CategoryText = ((details.value(forKey: "albumCategoryText") as AnyObject).object(at: 0) as! String)
       if (self.categoryId != "" || self.categoryId != "0")
       {
        self.mainCategorySelect(ID: self.categoryId!, categoryName: CategoryText)
       }
       self.txtCategory.text=CategoryText
    
     let othercatergory = ((details.value(forKey: "othercategorytext") as AnyObject).object(at: 0) as! String)
     self.txtCategoryNew.text = othercatergory
    
    
     self.subCategoryId = ((details.value(forKey: "Fk_SubcategoryID") as AnyObject).object(at: 0) as! String)
    
    if self.subCategoryId != "" || self.subCategoryId != "0"
    {
        let subCategoryText = ((details.value(forKey: "SubcategoryText") as AnyObject).object(at: 0) as! String)
        self.txtSubCategory.text=subCategoryText
        self.subCategorySelect(ID: self.subCategoryId!, categoryName: subCategoryText, mainCatID: self.categoryId!)
        if let OtherSubCategory=(details.value(forKey: "OtherSubCategory") as AnyObject).object(at: 0) as? String
           {
//            self.txtSubCategoryNew.text=OtherSubCategory
          }

         self.subtoSubCategoryId = ((details.value(forKey: "Fk_SubTosubcategoryID") as AnyObject).object(at: 0) as! String)
        
        if self.subtoSubCategoryId != "" || self.subtoSubCategoryId != "0"
         {
            let subToSubCategory = ((details.value(forKey: "SubtosubcategoryText") as AnyObject).object(at: 0) as! String)
            self.txtSubtoSubCategory.text=subToSubCategory
        }
    }
    
    //Funding name and id on october 2020
    if let fundIDs=(details.value(forKey: "Fk_FundingID") as AnyObject).object(at: 0) as? String
     {
        self.fundID=fundIDs
        if let FundingText=(details.value(forKey: "FundingText") as AnyObject).object(at: 0) as? String
        {
            self.txtFundName.text=FundingText
        }
     }

    
    if let rotractors=(details.value(forKey: "Rotaractors") as AnyObject).object(at: 0) as? String
     {
         self.txtRotractors.text=rotractors
     }
    if let ismediaCheck=(details.value(forKey: "Ismedia") as AnyObject).object(at: 0) as? String{
        self.isMediaCheck=ismediaCheck
        if (self.isMediaCheck != "" && self.isMediaCheck == "1")
        {
            let mediaDesc = ((details.value(forKey: "MediaDesc") as AnyObject).object(at: 0) as! String)
//             self.textViewR6.text=mediaDesc
             let mediaphotoID = ((details.value(forKey: "MediaphotoID") as AnyObject).object(at: 0) as! String)
            self.mediaImageID=mediaphotoID
      
      if let mediaPhoto = (details.value(forKey: "Mediaphoto") as AnyObject).object(at: 0) as? String
      {
        print("mediaphot count \(mediaPhoto.count)")
        if mediaPhoto.count>1{
         let ImageProfilePic:String = mediaPhoto.replacingOccurrences(of: " ", with: "%20")
         let checkedUrl = URL(string: ImageProfilePic)
//         self.imgR6.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic1"))
//            self.strimageR6 = self.imgR6.image
//         self.btnR6.isHidden=false
        }else
        {
            self.mediaImageID="0"
//            self.btnR6.isHidden=true
        }
      }
        else
          {
            self.mediaImageID="0"
//            self.btnR6.isHidden=true
          }
//            self.btnR6.isEnabled=true
//            self.btnMediaCheck.setImage(UIImage(named: "CheckBlue"), for: .normal)
//            self.imgR6.isUserInteractionEnabled=true
//            self.textViewR6.isEditable=true
//            self.imgR6.layer.borderWidth = 1
        }
        else
        {
//            self.btnMediaCheck.setImage(UIImage(named: "UncheckBlue"), for: .normal)
//            self.imgR6.isUserInteractionEnabled=false
//            self.textViewR6.isEditable=false
//            self.textViewR6.text=""
            self.mediaImageID="0"
//            self.btnR6.isEnabled=false
//            self.imgR6.layer.borderWidth = 0
//            self.btnR6.isHidden=true
//            self.btnR6.isEnabled=false
        }
    }
 }
else
 {
    self.categoryId="0"
    self.subCategoryId="0"
    self.subtoSubCategoryId="0"
 }

 //**********************************
                
    if(self.checkString == "Club Service")
      {
          self.categoryId=""
    
      }
    
      if(self.categoryId=="1")
      {
         // self.categoryId="1"
      }
      self.functionForGetPhotoList_New()
      }
      else
      {
          self.hideMBProgress()
          self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
          
      }
  }
  })
  }
      else
      {
        self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        self.hideMBProgress()
    }
}
    
    func  funcCallDeletePhoto(strPhotoId:String)   {
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
          {
        SVProgressHUD.show()
        let completeURL = baseUrl+"/Gallery/DeleteAlbumPhoto"
        var parameterst:NSDictionary=NSDictionary()
        
//            http://rotaryindiaapi.rosteronwheels.com/api//Gallery/DeleteAlbumPhoto :- [photoId=77098, albumId=23357, deletedBy=581428, Financeyear=2021-2022]
            
        parameterst =  ["albumId":strAlbumId as Any,
                        "photoId":strPhotoId as Any,
                        "deletedBy":strcreatedBy as Any,
                        "Financeyear": year as Any]
        
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            SVProgressHUD.dismiss()
            if((dd.object(forKey: "TBDelteAlbumPhoto")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                self.view.makeToast("Photo deleted successfully", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
                //as discussed with Hitendra Rajendra can coment below line
               // self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                
            }
            
        })
        }
          else
          {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
    }


    func  funcCallDeletePhoto2(strPhotoId:String)   {
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
          {
        SVProgressHUD.show()
        let completeURL = baseUrl+"/Gallery/DeleteAlbumPhoto"
        var parameterst:NSDictionary=NSDictionary()
        
        parameterst =  ["albumId":strAlbumId as Any,
                        "photoId":strPhotoId as Any,
                        "deletedBy":strcreatedBy as Any,
                        "Financeyear": year as Any]
        
        
            print("Delete photo from activity edit parameterst:: \(parameterst)")
            print("Delete photo from activity edit completeURL:: \(completeURL)")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            SVProgressHUD.dismiss()
            if((dd.object(forKey: "TBDelteAlbumPhoto")! as AnyObject).object(forKey: "status") as! String == "0")
            {
               // self.view.makeToast("Photo deleted sucessfully", duration: 2, position: CSToastPositionCenter)
                
            }
            else
            {
                
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                
            }
            
        })
        }
        else
          {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
    }
    func BODYEARRR(dateString: String?) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "dd MMM yyyy" //Your date format
        
        print(dateString)
        let serverDate: Date = dateFormatterDate.date(from: dateString ?? "") ?? Date()//according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd" //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    func functionForBODCount()
    {
        let strr = self.txtSelectDate.text
        
//        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMM yyyy"
        let newstr = self.BODYEARRR(dateString: strr ?? "")
        var dateString = "2014-01-12"
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: newstr)
        print(s)
        
        
        
        
        
//        let s = self.BODYEARRR(dateString: strr)
        print(s)
        
        
        
        
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: s!)
        
       
        
//
//        year =  components.year
//        let month = components.month
//        let day = components.day
//        if(month!>=7)
//        {
//    //            year = year+1
//        }
//        else
//        {
//        }
//        year = year+1
//        yearFrom = String(year)
//        print(yearFrom)
//        ListTypeTextField.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
//    //        ListTypeTextField.text! = String(year-1) + "-" + String(year)
//        print(year)
//
//
        
        
//          self.showMBProgress(str: "Loading photos...")
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
  let completeURL = baseUrl+"Gallery/GEtBODMember_Cnt"
  var parameterst:NSDictionary=NSDictionary()
  parameterst =  [
                  "GallaryId":strGroupId as Any,
                  "FinancialYear": year]
        
//        {"GallaryId":"2765", "FinancialYear":"2021-2022"}
  print("URL \(completeURL)")
 print("paramters \(parameterst)")
  ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
 //=> Handle server response
 let dd = response as! NSDictionary
 print("dd \(dd)")
// self.MurrayPhoto = NSMutableArray()
// self.MurrayPhotoID =  NSMutableArray()
// self.MurrayText = NSMutableArray()

//    if((dd.value(forKey: "status") as! String == "0")
//    {
//
//    }
//  else
//  {
//    self.hideMBProgress()
//      self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
//    }
    
    
    //{
//    "status": "0",
//    "message": "Successfull",
//    "ProjResult": {
//        "Table": [
//            {
//                "BODmemCnt": 11
//            }
//        ]
//    }
//}
  
    if (dd.value(forKey: "status") as? String == "0"){
        let arrarrNewGroupList1 = (dd.object(forKey: "ProjResult")! as AnyObject).object(forKey: "Table") as! NSArray
        print(arrarrNewGroupList1)
        
        let x : Int = (arrarrNewGroupList1[0] as AnyObject).value(forKey: "BODmemCnt") as! Int
        var myString = String(x)
        self.BodMemCount = myString
        print(self.BodMemCount)
    }
    else{
        
    }
    
    
       })
   }
else
       {
            self.hideMBProgress()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    func functionForGetPhotoList_New()
    {
          self.showMBProgress(str: "Loading photos...")
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
    {
  let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
  var parameterst:NSDictionary=NSDictionary()
  parameterst =  ["albumId":strAlbumId as Any,
                  "groupId":strGroupId as Any,
                  "Financeyear": year]
  print("URL \(completeURL)")
 print("paramters \(parameterst)")
  ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
 //=> Handle server response
 let dd = response as! NSDictionary
 print("dd \(dd)")
 self.MurrayPhoto = NSMutableArray()
 self.MurrayPhotoID =  NSMutableArray()
 self.MurrayText = NSMutableArray()

    if((dd.object(forKey: "TBAlbumPhotoListResult") as AnyObject).object(forKey: "status") as! String == "0")
 {
    if let memberCount = (dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "MemberCount") as? String
    {
        self.MemberCount=memberCount
    }
    
    if let MaxBeneficiaries = (dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "MaxBeneficiaries") as? String
    {
        self.BenificiaryCount=MaxBeneficiaries
    }

    let arrarrNewGroupList = (dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "Result") as! NSArray
    print(arrarrNewGroupList)
    self.MurrayPhoto = NSMutableArray()
  //  print(self.checkString)
    
    if(self.checkString == "Service Projects"){

        self.MurrayPhotoID=NSMutableArray()
        self.MurrayPhoto=NSMutableArray()

        
        print(arrarrNewGroupList)
        for i in 00..<arrarrNewGroupList.count{
//            self.isimageSelect = "yes"
            var photossID = (arrarrNewGroupList[i] as AnyObject).value(forKey: "photoId") as! String
            if photossID.count == 0 {
                self.isImageThere = "false"
            } else {
                self.isImageThere = "true"
            }
        if(i == 0){
           let photoId = (arrarrNewGroupList[0] as AnyObject).value(forKey: "photoId") as! String
           self.MurrayPhotoID?.add(photoId)
           let urls = (arrarrNewGroupList[0] as AnyObject).value(forKey: "url") as! String
           let Desc = (arrarrNewGroupList[0] as AnyObject).value(forKey: "description") as! String
           self.btnR1.isHidden = false
            self.btnC1.isHidden = false
           self.txtViewR1.text = Desc
            self.txtViewC1.text=Desc
      
           let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
           let checkedUrl = URL(string: ImageProfilePic)
            
//            if checkedUrl == nil {
////                self.imgR1.sd_setImage(with: checkedUrl)
////                self.imgC1.sd_setImage(with: checkedUrl)
//
//                self.imgR1.image = UIImage(named: "AddPic")
//                self.imgC1.image = UIImage(named: "AddPic")
//            }
//            else{
//            self.imgR1.sd_setImage(with: checkedUrl)
//            self.imgC1.sd_setImage(with: checkedUrl)
//            }
           self.imgR1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
           self.strimageR1 = self.imgR1.image


           self.imgC1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
                self.strimageC1 = self.imgR1.image
          self.MurrayPhoto?.add(self.strimageR1 as Any)
          self.arrayTempImageIndexHold.replaceObject(at: 0, with: "1")
       //   self.imgR1.isUserInteractionEnabled = false
 
 
      }else if(i == 1){
          let photoId = (arrarrNewGroupList[1] as AnyObject).value(forKey: "photoId") as! String
          self.MurrayPhotoID?.add(photoId)
          self.btnR2.isHidden = false
           self.btnC2.isHidden = false
         let urls = (arrarrNewGroupList[1] as AnyObject).value(forKey: "url") as! String
        let Desc = (arrarrNewGroupList[1] as AnyObject).value(forKey: "description") as! String
        
        self.txtViewR2.text = Desc
         self.txtViewC2.text=Desc
        
        
        
        let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
        let checkedUrl = URL(string: ImageProfilePic)
        self.imgR2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
        self.strimageR2 = self.imgR2.image
        self.imgC2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
        self.strimageC2 = self.imgR2.image
        self.MurrayPhoto?.add(self.strimageR2 as Any)
     //   self.imgR2.isUserInteractionEnabled = false
         self.arrayTempImageIndexHold.replaceObject(at: 1, with: "1")
        
    }else if(i == 2){
        let photoId = (arrarrNewGroupList[2] as AnyObject).value(forKey: "photoId") as! String
        self.MurrayPhotoID?.add(photoId)
        let urls = (arrarrNewGroupList[2] as AnyObject).value(forKey: "url") as! String
        let Desc = (arrarrNewGroupList[2] as AnyObject).value(forKey: "description") as! String
        self.txtViewR3.text = Desc
              self.txtViewC3.text=Desc
             self.btnR3.isHidden = false
              self.btnC3.isHidden = false
             
             
             let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
             let checkedUrl = URL(string: ImageProfilePic)
             self.imgR3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageR3 = self.imgR3.image
             self.imgC3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageC3 = self.imgR3.image
             self.MurrayPhoto?.add(self.strimageR3 as Any)
         //    self.imgR3.isUserInteractionEnabled = false
              self.arrayTempImageIndexHold.replaceObject(at: 2, with: "1")
             
         }else if(i == 3){
             let photoId = (arrarrNewGroupList[3] as AnyObject).value(forKey: "photoId") as! String
             self.MurrayPhotoID?.add(photoId)
             self.btnR4.isHidden = false
              self.btnC4.isHidden = false
             
             
             let urls = (arrarrNewGroupList[3] as AnyObject).value(forKey: "url") as! String
             let Desc = (arrarrNewGroupList[3] as AnyObject).value(forKey: "description") as! String
             self.txtViewR4.text = Desc
              self.txtViewC4.text=Desc
             let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
             let checkedUrl = URL(string: ImageProfilePic)
             self.imgR4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageR4 = self.imgR4.image
             self.imgC4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageC4 = self.imgR4.image
             self.MurrayPhoto?.add(self.strimageR4 as Any)
       //      self.imgR4.isUserInteractionEnabled = false
              self.arrayTempImageIndexHold.replaceObject(at: 3, with: "1")
             
         }else if(i == 4){
             let photoId = (arrarrNewGroupList[4] as AnyObject).value(forKey: "photoId") as! String
             self.MurrayPhotoID?.add(photoId)
             let urls = (arrarrNewGroupList[4] as AnyObject).value(forKey: "url") as! String
             let Desc = (arrarrNewGroupList[4] as AnyObject).value(forKey: "description") as! String
             self.txtViewR5.text = Desc
              self.txtViewC5.text=Desc
             self.btnR5.isHidden = false
              self.btnC5.isHidden = false
             
             
             let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
             let checkedUrl = URL(string: ImageProfilePic)
             self.imgR5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageR5 = self.imgR5.image
             self.imgC5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
             self.strimageC5 = self.imgR5.image
             self.MurrayPhoto?.add(self.strimageR5 as Any)
          //   self.imgR5.isUserInteractionEnabled = false
              self.arrayTempImageIndexHold.replaceObject(at: 4, with: "1")
         }
     }
     
     var countImageID:Int=5-self.MurrayPhotoID!.count
     for i in 00..<countImageID
     {
         self.MurrayPhotoID?.add(" ")
         self.MurrayPhoto?.add(" ")
     }
     print("This is my code here 3 dec")
     print(self.MurrayPhotoID)
     print(self.MurrayPhotoID?.count)
     print(self.MurrayPhoto)
     print(self.MurrayPhoto?.count)
     
 }else{
     
     self.MurrayPhotoID=NSMutableArray()
     self.MurrayPhoto=NSMutableArray()

     
     for i in 00..<arrarrNewGroupList.count{

        if(i == 0){
            let photoId = (arrarrNewGroupList[0] as AnyObject).value(forKey: "photoId") as! String
            self.MurrayPhotoID?.add(photoId)
            let urls = (arrarrNewGroupList[0] as AnyObject).value(forKey: "url") as! String
            let Desc = (arrarrNewGroupList[0] as AnyObject).value(forKey: "description") as! String
            self.btnC1.isHidden = false
             self.btnR1.isHidden = false
            
            
            
            self.txtViewC1.text = Desc
            self.txtViewR1.text=Desc
            let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imgC1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageC1 = self.imgC1.image
            self.MurrayPhoto?.add(self.strimageC1 as Any)
            self.imgR1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageR1 = self.imgC1.image
           // self.imgC1.isUserInteractionEnabled = false
            self.arrayTempImageIndexHold.replaceObject(at: 0, with: "1")
            
        }else if(i == 1){
            let photoId = (arrarrNewGroupList[1] as AnyObject).value(forKey: "photoId") as! String
            self.MurrayPhotoID?.add(photoId)
            let urls = (arrarrNewGroupList[1] as AnyObject).value(forKey: "url") as! String
            let Desc = (arrarrNewGroupList[1] as AnyObject).value(forKey: "description") as! String
            self.btnC2.isHidden = false
             self.btnR2.isHidden = false
            
            
            self.txtViewC2.text = Desc
             self.txtViewR2.text=Desc
            let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imgC2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageC2 = self.imgC2.image
            
            self.imgR2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageR2 = self.imgC2.image
            self.MurrayPhoto?.add(self.strimageC2 as Any)
         //   self.imgC2.isUserInteractionEnabled = false
            self.arrayTempImageIndexHold.replaceObject(at: 1, with: "1")
            
        }else if(i == 2){
            
            let photoId = (arrarrNewGroupList[2] as AnyObject).value(forKey: "photoId") as! String
            self.MurrayPhotoID?.add(photoId)
            let urls = (arrarrNewGroupList[2] as AnyObject).value(forKey: "url") as! String
            let Desc = (arrarrNewGroupList[2] as AnyObject).value(forKey: "description") as! String
            self.txtViewC3.text = Desc
             self.txtViewR3.text=Desc
            self.btnC3.isHidden = false
             self.btnR3.isHidden = false
            
            
            let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imgC3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageC3 = self.imgC3.image
            self.imgR3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageR3 = self.imgC3.image
            self.MurrayPhoto?.add(self.strimageC3 as Any)
          //  self.imgC3.isUserInteractionEnabled = false
            self.arrayTempImageIndexHold.replaceObject(at: 2, with: "1")
            
        }else if(i == 3){
            let photoId = (arrarrNewGroupList[3] as AnyObject).value(forKey: "photoId") as! String
            self.MurrayPhotoID?.add(photoId)
            let urls = (arrarrNewGroupList[3] as AnyObject).value(forKey: "url") as! String
            let Desc = (arrarrNewGroupList[3] as AnyObject).value(forKey: "description") as! String
            self.txtViewC4.text = Desc
             self.txtViewR4.text=Desc
            self.btnC4.isHidden = false
             self.btnR4.isHidden = false
            
            
            let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imgC4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageC4 = self.imgC4.image
            
            self.imgR4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageR4 = self.imgC4.image
            self.MurrayPhoto?.add(self.strimageC4 as Any)
          //  self.imgC4.isUserInteractionEnabled = false
            self.arrayTempImageIndexHold.replaceObject(at: 3, with: "1")
            
        }else if(i == 4){
            let photoId = (arrarrNewGroupList[4] as AnyObject).value(forKey: "photoId") as! String
            self.MurrayPhotoID?.add(photoId)
            let urls = (arrarrNewGroupList[4] as AnyObject).value(forKey: "url") as! String
            let Desc = (arrarrNewGroupList[4] as AnyObject).value(forKey: "description") as! String
            self.txtViewC5.text = Desc
             self.txtViewR5.text=Desc
            self.btnC5.isHidden = false
             self.btnR5.isHidden = false
            
            
            let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imgC5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageC5 = self.imgC5.image
            self.imgR5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
            self.strimageR5 = self.imgC5.image
            self.MurrayPhoto?.add(self.strimageC5 as Any)
           // self.imgC5.isUserInteractionEnabled = false
            self.arrayTempImageIndexHold.replaceObject(at: 4, with: "1")
        }
        //MARK:- rajendra addding code here 3 Dec
    
    }
    //after adding my code rajendra jat 3 dec
    //MARK:- rajendra jat adding code here
    var countImageID:Int=5-self.MurrayPhotoID!.count
    for i in 00..<countImageID
    {
        self.MurrayPhotoID?.add(" ")
        self.MurrayPhoto?.add(" ")
    }
    }
   self.hideMBProgress()
  }
  else
  {
    self.hideMBProgress()
      self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
    }
  
 })
 }
    else
          {
            self.hideMBProgress()
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    //Mark:- Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblClube){
            return (Clubearray?.count)!
        }
        if(tableView == tblRotary){
            if section == 1 {
                return  (rotaryArray?.count)!
            }
            else {
                return 0
            }
           
            
        }
        else{
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tblRotary {
            return 2
        }
        else{
        return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tblRotary {
            if section == 0 {
                return serviceProFooterView.frame.size.height
            }
            else{
                return 0
            }
        }
        else{
        return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        if tableView == tblRotary {
            if section == 0 {
                return serviceProFooterView
            }
            else{
                return nil
            }
        }
        else{
        return nil
        }
    }
       
    
    func tableView(_ tableView: UITableView,
                viewForHeaderInSection section: Int) -> UIView?  {
        if tableView == tblRotary {
            if section == 0 {
                return header1View
            }
            else{
                return nil
            }
        }
        else{
        return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblRotary {
            if section == 0 {
                return header1View.frame.size.height
            }
            else{
                return 0
            }
        }
        else{
        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblClube.dequeueReusableCell(withIdentifier: "clubeTVC", for: indexPath) as! clubeTVC
        if(logoImagesClube.count == 1){
            if(indexPath.row == 0){
                cell.imgphoto.image = logoImagesClube[indexPath.row]
            }
        }
        else if(logoImagesClube.count == 2){
            if(indexPath.row == 0 || indexPath.row == 1){
                cell.imgphoto.image = logoImagesClube[indexPath.row]
            }
        }
        else if(logoImagesClube.count == 3){
            if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
                cell.imgphoto.image = logoImagesClube[indexPath.row]
            }
        }
        else if(logoImagesClube.count == 4){
            if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
                cell.imgphoto.image = logoImagesClube[indexPath.row]
            }
        }
        else if(logoImagesClube.count == 4){
            if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
                cell.imgphoto.image = logoImagesClube[indexPath.row]
            }
        }
        cell.btnCross.addTarget(self, action: #selector(AddPhotoNewVC.ClubeCrossClickEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.btnaddPic.addTarget(self, action: #selector(AddPhotoNewVC.ClubePicClickEvent(_:)), for: UIControl.Event.touchUpInside)
        cell.contentView.bringSubviewToFront( cell.btnCross)
        cell.btnaddPic.tag = indexPath.row
        cell.btnCross.tag = indexPath.row
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
 
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        //        let pointInTable = textView.convert(textView.bounds.origin, to: tableviewEditUpdateProfile)
        //        let indexPath = tableviewEditUpdateProfile.indexPathForRow(at: pointInTable)?.row
        //        print(indexPath)
        //        print(indexPath)
        //        print(indexPath)
        //
        //        varSelectedTableRowIndex=Int(indexPath!)
        //
        //        print(muarrayAddressSecond.object(at: varSelectedTableRowIndex))
        //        varSelectedTableRowIndexGet_Text=muarrayAddressSecond.object(at: varSelectedTableRowIndex) as! String
        
    }
    
    
  @objc  func ClubeCrossClickEvent(_ sender:UIButton)
    {
        
        if( self.checkString == "Club Service"){
            self.logoImagesClube.remove(at: sender.tag)
            self.tblClube.reloadData()
        }else if(self.checkString == "Service Projects"){
            
            self.tblRotary.reloadData()
            
        }
    }
    
   @objc func ClubePicClickEvent(_ sender:UIButton)
    {
        intTag = sender.tag
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        picker.delegate = self
     //   alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
//    extension AddPhotoNewVC: UIDocumentPickerDelegate {
//
//
//       func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//                 let cico = url as URL
//                 print(cico)
//                 print(url)
//
//                 print(url.lastPathComponent)
//
//                 print(url.pathExtension)
//                }
//    }
    
}

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return  formatter.string(from: self as Date)
    }
    

}

