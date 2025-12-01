                                                                                                                                                                                                                                                                                                                                                  //
//  DistAddPhotoNewVC.swift
//  TouchBase
//
//  Created by ABC on 02/11/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD
class DistAddPhotoNewVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate ,UIPickerViewDelegate , UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate, uploadDocDelegate{

    //MARK:- All Variable declaration
    var objProtocolNameNew:protocolNamePopValue?=nil
    var strWitchType:String?
    var CheckDelete:String?
    var strcreatedBy:String?
    var strAlbumId:String?
    var strGroupId:String?
    var memberIds : String?
    var type:String?
    var moduleId:String?
    var categoryId:String!=""
    var year:String!=""
    var isCalledFRom:String?
    var strSelectDate:String?
    var strimageC1:UIImage?
    var strimageC2:UIImage?
    var strimageC3:UIImage?
    var strimageC4:UIImage?
    var strimageC5:UIImage?
    var strimageR1:UIImage?
    var strimageR2:UIImage?
    var strimageR3:UIImage?
    var strimageR4:UIImage?
    var strimageR5:UIImage?
    var strSendServerImage:UIImage?
    var alertTitle:String=""
    var MurrayPhoto:NSMutableArray?
    var MurrayPhotoID:NSMutableArray?
    var MurrayText:NSMutableArray?
    var strMetting:String?
    var logoImagesClube = [UIImage]()
    var muaaryDescClube = NSMutableArray()
    var intTag:Int = 0
    var albumImagesID:String?
    let loaderClass  = WebserviceClass()
    var arrayTempImageIndexHold:NSMutableArray=NSMutableArray()
    var loadingNotification:MBProgressHUD = MBProgressHUD()
    var loadingImage:MBProgressHUD = MBProgressHUD()
    var IsSelectDateAction:Int=0
    var apiKeyYear = ""

    @IBOutlet weak var rotLocationOfProj: UITextField!
    //MARK:- Variable added on April 2020
    var muarrayForSubCategoryList:NSMutableArray=NSMutableArray()
    var muarrayForSubToSubCategoryList:NSMutableArray=NSMutableArray()
    var muarraySubCategoryListArray:NSArray=NSArray()
    var muarraySubToSubCategoryListArray:NSArray=NSArray()
    var strimageR6:UIImage?
    var MemberCount:String=""
    var BenificiaryCount:String=""
    var isMediaCheck:String="0"
    var mediaImageID:String=""
    var flagExceedBenificiary:String="0"
    var finalBenificiary:String = ""
    var finalTempBenificiary:String = ""
    var subCategoryId:String?
    var subtoSubCategoryId:String?
    var strDR:String=""
    var rotaryArray : NSMutableArray?
    var Clubearray :  NSMutableArray?
    //var module_name:String=""
    var picker = UIImagePickerController()
    var checkString:String?
    var muarrayCategoryListArray:NSArray=NSArray()
    var arrayImages = Array<UIImage>()
    var muarrayForMetting:NSMutableArray=NSMutableArray()
    var muarrayForCategoryListWithOutZeroIndex:NSMutableArray=NSMutableArray()
    var arrayforphoto:NSMutableArray = NSMutableArray()
    var arrayforphotoRotatery:NSMutableArray = NSMutableArray()
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    var strC:String!=""
    var strR:String!=""
    var intgetindexVlaue:Int?
    //Added funding variables on 2020 OCT
    var fundID:String?
    var muarrayFundinglistArray:NSArray=NSArray()

    
    //MARK:- All IBOutlet declaration
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
    @IBOutlet weak var imgR5: UIImageView!
    @IBOutlet weak var btnR5: UIButton!
    @IBOutlet weak var txtViewR5: UITextView!
    @IBOutlet weak var btnselectedDate: UIButton!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var pickermetting: UIPickerView!
    // @IBOutlet weak var txtPhotoRotDesc: UITextView!
    @IBOutlet weak var txtRotDesc: UITextView!
    @IBOutlet weak var viewDatepicker: UIView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtCategoryNew: UITextField!
    //MARK:-New view on April 2020
    @IBOutlet weak var txtSubCategoryNew: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var txtSubtoSubCategory: UITextField!
    @IBOutlet weak var btnSubCategoryDrop: UIButton!
    @IBOutlet weak var btnSubToSubCategoryDrop: UIButton!
    @IBOutlet weak var txtRotractors: UITextField!
    @IBOutlet weak var lblPopup1: UILabel!
    @IBOutlet weak var lblPopup2: UILabel!
    @IBOutlet weak var lblPopup3: UILabel!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var viewSubToSubCategory: UIView!
    @IBOutlet weak var viewBenPopup: UIView!
    @IBOutlet weak var pickerSubCategory: UIPickerView!
    @IBOutlet weak var pickerSubToSubCategory: UIPickerView!
    @IBOutlet weak var viewAddEditCancel: UIView!
    @IBOutlet weak var txtRotatiran: UITextField!
    @IBOutlet weak var txtmanHours: UITextField!
    @IBOutlet weak var txtBenificary: UITextField!
    @IBOutlet weak var txtCost: UITextField!
//  @IBOutlet weak var lblPhotoDesc: UILabel!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSelectDate: UITextField!
    @IBOutlet weak var datePickers: UIDatePicker!
    @IBOutlet weak var btnOpacity: UIButton!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewMettingType: UIView!
//  @IBOutlet weak var imgAddPhoto: UIImageView!
//  @IBOutlet weak var imgAddPhotoRotatery: UIImageView!
    @IBOutlet weak var txtRotetoryTitle: UITextField!
    @IBOutlet weak var tblRotary: UITableView!
    @IBOutlet weak var tblClube: UITableView!
//  @IBOutlet weak var txtDesc: UITextView!
//  @IBOutlet weak var lblDesc: UILabel!
//  @IBOutlet weak var btnAddCross: UIButton!
    @IBOutlet weak var txtSelectedDateRot: UITextField!
//  @IBOutlet weak var btnAddcrossClube: UIButton!
    @IBOutlet weak var btnAddEdit: UIButton!
    //Added funding IBOutlet on 2020 OCT
    @IBOutlet weak var pickerFundinglist: UIPickerView!
    @IBOutlet weak var txtFundName: UITextField!
    @IBOutlet weak var btnFundName: UIButton!
    @IBOutlet weak var viewFunding: UIView!
    @IBOutlet weak var locationOfProject: UITextField!
    
    var imgMandatoryArray = [String]()
    var imgAdded = "added"
    
    
    
    
    //MARK:- this is textfield delegate
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92)
        {
            let userEnteredString = textField.text
            let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
            print(newString)
            print("Backspace was pressed rajendra jat")
         
        }
        else
        {
            let userEnteredString = textField.text
            let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
            print(newString)
            if(textField==txtTitle)
            {
                txtRotetoryTitle.text=newString
            }
            else if(textField==txtRotetoryTitle)
            {
                txtTitle.text=newString
            } else if(textField==locationOfProject)
            {
                locationOfProject.text=userEnteredString
            } else if(textField==rotLocationOfProj)
            {
                rotLocationOfProj.text=userEnteredString
            }
        }
        return true
    }
    //MARK:- this is textview delegate
    
    /*
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     if (text == "\n") {
     textView.resignFirstResponder()
     return false
     }
     return true
     }
     */
    
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
                //1.....
                if(textView==txtViewDesc)
                {
                    txtRotDesc.text=newString
                }
               else if(textView==txtRotDesc)
                {
                    txtViewDesc.text=newString
                }
                //2.txtview of image
                else if(textView==txtViewC1)
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
                }
                else if(textView==txtViewC4)
                {
                    txtViewR4.text=newString
                }
                else if(textView==txtViewC5)
                {
                    txtViewR5.text=newString
                }
                //3.
                else if(textView==txtViewR1)
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
                }
                else if(textView==txtViewR4)
                {
                    txtViewC4.text=newString
                }
                else if(textView==txtViewR5)
                {
                    txtViewC5.text=newString
                }
            }
        }
          return true
    }
    
    func functionForHideKeyBoard()
    {
       // txtAttendance.resignFirstResponder()
       // txtAttendancePercent.resignFirstResponder()
        rotLocationOfProj.resignFirstResponder()
        locationOfProject.resignFirstResponder()
        txtRotetoryTitle.resignFirstResponder()
        txtTitle.resignFirstResponder()
        txtRotDesc.resignFirstResponder()
        txtViewDesc.resignFirstResponder()
        txtViewC1.resignFirstResponder()
        txtSelectDate.resignFirstResponder()
        txtCategoryNew.resignFirstResponder()
        txtCategory.resignFirstResponder()
        txtSubCategory.resignFirstResponder()
        txtSubCategoryNew.resignFirstResponder()
        txtSubtoSubCategory.resignFirstResponder()
        txtFundName.resignFirstResponder()
        txtViewR1.resignFirstResponder()
        txtCost.resignFirstResponder()
        txtViewR1.resignFirstResponder()
        txtViewR2.resignFirstResponder()
        txtViewR3.resignFirstResponder()
        txtViewR4.resignFirstResponder()
        txtViewR5.resignFirstResponder()
        txtRotractors.resignFirstResponder()
        txtViewC1.resignFirstResponder()
        txtViewC2.resignFirstResponder()
        txtViewC3.resignFirstResponder()
        txtViewC4.resignFirstResponder()
        txtViewC5.resignFirstResponder()
        txtBenificary.resignFirstResponder()
        txtmanHours.resignFirstResponder()
        //txtMettingType.resignFirstResponder()
        txtRotatiran.resignFirstResponder()
        txtRotetoryTitle.resignFirstResponder()
    }
    
        
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func createNavigationBarmine()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(NewShowCasePhotoDetailsVC.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickers.setStyle()
        self.asignTextToBenificiaryPopup()
        createNavigationBarmine()
        print("This is District ADD/Edit Activity page")
        print(alertTitle)
        print(strWitchType)
        print(checkString)
        self.viewBenPopup.layer.cornerRadius=20
        //code by rajendra jat on 7 dec 2018 5.36pm
       //  self.txtCategory.text! = "Peace and Conflict Prevention/Resolution"
         categoryId=""
         subCategoryId=""
         subtoSubCategoryId=""
        
//        self.edgesForExtendedLayout=[]
        print("this is category id on DistAddPhotoNewVC.swift")
        print(categoryId)
//        self.edgesForExtendedLayout=[]

        txtViewC1.delegate=self
        txtViewC2.delegate=self
        txtViewC3.delegate=self
        txtViewC4.delegate=self
        txtViewC5.delegate=self
        txtViewR1.delegate=self
        txtViewR2.delegate=self
        txtViewR3.delegate=self
        txtViewR4.delegate=self
        txtViewR5.delegate=self
        //code by Rajendra jat By default set date in textfield
        txtSelectDate.text = datePickers.date.formatted
        txtSelectedDateRot.text = datePickers.date.formatted
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        strSelectDate =  formatter.string(from: datePickers.date)
        //add image by rajendra jat 6 dec
        let imageView = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        txtSelectedDateRot.rightViewMode = UITextField.ViewMode.always
        txtSelectedDateRot.rightView = imageView
        
        
        let imageView2 = UIImageView(image: UIImage(named: "down_arrowew_blue"))
        imageView2.frame = CGRect(x: 0.0, y: 0.0, width: 35, height: 35)
        txtSelectDate.rightViewMode = UITextField.ViewMode.always
        txtSelectDate.rightView = imageView2
        txtCategory.textFieldFullBorder()
        txtSubCategory.textFieldFullBorder()
        txtSubtoSubCategory.textFieldFullBorder()
        txtFundName.textFieldFullBorder()
        
        arrayImages = NSArray() as! [UIImage]
        MurrayPhoto = NSMutableArray()
        MurrayText = NSMutableArray()
        MurrayPhotoID = NSMutableArray()
        logoImagesClube = [UIImage]()
        // Do any additional setup after loading the view.
        self.txtCategoryNew.isEnabled = false
        self.txtSubCategoryNew.isEnabled=false
        self.txtSubCategory.isEnabled = false
        self.txtSubtoSubCategory.isEnabled = false
        self.btnSubCategoryDrop.isEnabled = false
        self.btnSubToSubCategoryDrop.isEnabled = false
        self.rotLocationOfProj.delegate = self
        self.locationOfProject.delegate = self
        self.txtTitle.delegate = self
        self.txtViewDesc.delegate = self
        self.txtCost.delegate = self
        self.txtBenificary.delegate = self
        self.txtmanHours.delegate = self
        self.txtRotatiran.delegate = self
        self.txtRotetoryTitle.delegate = self
        self.txtRotDesc.delegate = self
        
       
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(AddPhotoNewVC.tapDetectedC1))
        imgC1.isUserInteractionEnabled = true
        imgC1.addGestureRecognizer(singleTap)
        
        imgC1.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgC1.layer.borderWidth = 1
        
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

        
        rotaryArray = NSMutableArray()
        Clubearray = NSMutableArray()
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        Clubearray?.add("add")
        
        
        arrayTempImageIndexHold.add("0")
        arrayTempImageIndexHold.add("0")
        arrayTempImageIndexHold.add("0")
        arrayTempImageIndexHold.add("0")
        arrayTempImageIndexHold.add("0")

        if(self.strWitchType == "District Events")
        {
            alertTitle="District Event"
            self.checkString = "Club Meetings"
            self.tblClube.isHidden = false
            self.tblRotary.isHidden = true
        }
        else
        {
            alertTitle="District Project"
            self.checkString = "Service Projects"
            self.tblClube.isHidden = true
            self.tblRotary.isHidden = false
        }

        if(isCalledFRom == "Edit"){
            btnR1.isHidden = true
            btnR2.isHidden = true
            btnR3.isHidden = true
            btnR4.isHidden = true
            btnR5.isHidden = true
            btnC1.isHidden = true
            btnC2.isHidden = true
            btnC3.isHidden = true
            btnC4.isHidden = true
            btnC5.isHidden = true
            
            self.title = "Edit "+self.alertTitle
            btnAddEdit.setTitle("Update", for: UIControl.State.normal)
            if(self.strWitchType == "District Projects")
            {
              fucntionForGetClubChangeAccordingToDistrictIDAndGetClubListWhenComingFromEdit()
            }
            else
            {
                functionForGetAlbumDetails_New()
            }
            
        }else{
            if(self.strWitchType == "District Projects")
            {
                fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
            }
            
            btnR1.isHidden = true
            btnR2.isHidden = true
            btnR3.isHidden = true
            btnR4.isHidden = true
            btnR5.isHidden = true

            btnC1.isHidden = true
            btnC2.isHidden = true
            btnC3.isHidden = true
            btnC4.isHidden = true
            btnC5.isHidden = true
            strAlbumId  = "0"
            btnAddEdit.setTitle("Add", for: UIControl.State.normal)
            self.title = "New "+self.alertTitle
            //checkString = "Clube"
            
//            if(self.strWitchType == "District Events")
//            {
//                for i in 00..<5
//                {
//                    self.MurrayPhotoID?.add(" ")
//                    self.MurrayPhoto?.add(" ")
//                }
//            }
//            else
//            {
//                for i in 00..<5
//                {
//                    self.MurrayPhotoID?.add(" ")
//                    self.MurrayPhoto?.add(" ")
//                }
//            }
          self.categoryId=""
          self.txtSubCategory.text! = ""
          self.subCategoryId=""
          self.txtSubtoSubCategory.text! = ""
          self.subtoSubCategoryId=""
        }
//        self.edgesForExtendedLayout=[]
    }
    
    func asignTextToBenificiaryPopup()
    {
        lblPopup1.text="A limit of \(BenificiaryCount) beneficiaries has been set for each project."
        lblPopup2.text="As this project has more than \(BenificiaryCount) beneficiaries, it will be sent to the Zonal Head of Rotary India for approval."
        lblPopup3.text="Your project will be added with \(BenificiaryCount) beneficiaries at the moment."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        txtCategoryNew.text == ""
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewCategory.isHidden = true
        viewFunding.isHidden = true
        viewSubCategory.isHidden = true
        viewSubToSubCategory.isHidden = true
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
    
    // MARK: - Action method
    
    @IBAction func CloseR1Action(_ sender: Any) {
        functionForHideKeyBoard()
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR1.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![0] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgR1.image = UIImage.init(named: "AddPic")
            self.btnR1.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR2.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![1] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgR2.image = UIImage.init(named: "AddPic")
            self.btnR2.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR3.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![2] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgR3.image = UIImage.init(named: "AddPic")
            self.btnR3.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR4.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![3] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgR4.image = UIImage.init(named: "AddPic")
            self.btnR4.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgR5.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![4] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgR5.image = UIImage.init(named: "AddPic")
            self.btnR5.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
           // if(self.isCalledFRom == "Edit"){
                
                //self.funcCallDeletePhoto(strPhotoId: self.mediaImageID)
                self.CheckDelete = "Delete"
          //  }
          
            self.strimageR6 = nil
            self.mediaImageID=""
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC1.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![0] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            
            self.imgC1.image = UIImage.init(named: "AddPic")
            self.btnC1.isHidden = true
           print(self.imgMandatoryArray.count)
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC2.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![1] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgC2.image = UIImage.init(named: "AddPic")
            self.btnC2.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC3.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![2] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgC3.image = UIImage.init(named: "AddPic")
            self.btnC3.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC4.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![3] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgC4.image = UIImage.init(named: "AddPic")
            self.btnC4.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this Photo ?", preferredStyle: .alert)
        
        // Initialize Actions
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            
            if(self.isCalledFRom == "Edit"){
                
                self.imgC5.isUserInteractionEnabled = true
                self.funcCallDeletePhoto(strPhotoId: self.MurrayPhotoID![4] as! String,paramYear: self.apiKeyYear)
                self.CheckDelete = "Delete"
            }
            self.imgC5.image = UIImage.init(named: "AddPic")
            self.btnC5.isHidden = true
            self.imgMandatoryArray.remove(at: 0)
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
    

    
    @IBAction func btnPopupConfirmClickEvent(_ sender: Any) {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
               btnAddEdit.isEnabled=false
               self.btnOpacity.isHidden=true
               self.viewBenPopup.isHidden=true
               self.viewAddEditCancel.isHidden=false
               SendDataToserver()
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

    
    @IBAction func AddAction(_ sender: Any) {
        functionForHideKeyBoard()
    if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
        if( checkString == "Club Meetings"){
            if(txtSelectDate.text == ""){
                
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please select date.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }
            else if(txtTitle.text == ""){
                
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter title.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
                
            }else if(txtViewDesc.text == ""){
                let alertWarning = UIAlertView(title:self.alertTitle, message: "Please enter description.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(locationOfProject.text == ""){
                
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter Location Of Project.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
                
            } 
            else if (self.imgMandatoryArray.count == 0) {
                let alertWarning = UIAlertView(title:self.alertTitle, message: "One image is mandatory.", delegate:nil, cancelButtonTitle:"OK")
                    alertWarning.show()
                    return
            }
                
            else{
                btnAddEdit.isEnabled = false
                SendDataToserver()
            }
        }
        
        else if(checkString == "Service Projects"){
            print(MurrayPhotoID?.count)
            if muarrayForCategoryListWithOutZeroIndex.count>0 && categoryId == ""
            {
               let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select area of focus.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }
            else if txtCategory.text=="Others" && txtCategoryNew.text == ""
            {
               let alertWarning = UIAlertView(title:self.alertTitle, message: "Please specify the area of focus.", delegate:nil, cancelButtonTitle:"OK")
              alertWarning.show()
             return
            }
            else if categoryId != "" && txtCategory.text != "Others" && muarrayForSubCategoryList.count>0 && subCategoryId==""
            {
                let alertWarning = UIAlertView(title:self.alertTitle, message: "Please select category.", delegate:nil, cancelButtonTitle:"OK")
                 alertWarning.show()
                 return
            }
             else if txtSubCategory.text=="Others" &&  txtSubCategoryNew.text == "" && subCategoryId != ""
             {
                let alertWarning = UIAlertView(title:self.alertTitle, message: "Please specify the category.", delegate:nil, cancelButtonTitle:"OK")
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
            if(txtSelectedDateRot.text == ""){
                
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please select date.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }
            else if(txtCost.text == ""){
                
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter cost.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
                
            }else if(txtBenificary.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter Direct Beneficiaries.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(txtmanHours.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter man hours.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(txtRotatiran.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter Rotarians Involved.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(txtRotetoryTitle.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter title.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(rotLocationOfProj.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter location of Project.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }else if(txtRotDesc.text == ""){
                let alertWarning = UIAlertView(title: self.alertTitle, message: "Please enter description.", delegate:nil, cancelButtonTitle:"OK")
                alertWarning.show()
                return
            }
//                   else if (isMediaCheck == "1" && self.mediaImageID == "")
//     {
//               let alertWarning = UIAlertView(title:self.alertTitle, message: "Please upload Print media photo.", delegate:nil, cancelButtonTitle:"OK")
//                   alertWarning.show()
//                   return
//                   }
            else if (self.imgMandatoryArray.count == 0) {
                let alertWarning = UIAlertView(title:self.alertTitle, message: "One image is mandatory.", delegate:nil, cancelButtonTitle:"OK")
                    alertWarning.show()
                    return
            }
            
//            else if (MurrayPhotoID?.count ?? 0 <= 0) {
//                       let alertWarning = UIAlertView(title:self.alertTitle, message: "One image is mandatory.", delegate:nil, cancelButtonTitle:"OK")
//                           alertWarning.show()
//                           return
//                   }
       
 else{
              SendDataToserver()
                btnAddEdit.isEnabled = false
                
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
   parameterst = ["AlbumID":strAlbumId as Any]
}
else
{
   parameterst = ["AlbumID":"0"]
}
SVProgressHUD.show()
ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
let dd = response as! NSDictionary
print("dd \(dd)")
let varGetValueServerError = response.object(forKey: "serverError")as? String
if(varGetValueServerError == "Error")
{
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
       self.btnAddEdit.isEnabled=false
       self.SendDataToserver()
   }
  else
  {
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
    self.btnAddEdit.isEnabled=false
    self.SendDataToserver()
}
}
}
}
}
})
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
}

/* Older versions of Swift */
// hides text views



@IBAction func CencelAction(_ sender: Any) {
    functionForHideKeyBoard()
    self.navigationController?.popViewController(animated: true)
}
    
    @IBAction func RotatryAction(_ sender: Any) {
        functionForHideKeyBoard()
        arrayImages = NSArray() as! [UIImage]
        btnOpacity.isHidden = false
        viewCategory.isHidden = false
        viewFunding.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
    }
    
    @IBAction func SubRotatryAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewSubCategory.isHidden = false
        viewFunding.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
    }

    @IBAction func SubToSubRotatryAction(_ sender: Any){
        functionForHideKeyBoard()
        btnOpacity.isHidden = false
        viewSubToSubCategory.isHidden = false
        viewDatepicker.isHidden = true
        viewFunding.isHidden = true
        viewMettingType.isHidden = true
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
    }

    func isDateisFutureDate(selectedDate:Date) -> Bool
    {
        let currentDate:Date=Date()
        if currentDate.compare(selectedDate) == .orderedAscending
        {
            var message:String=""
            if checkString == "Club Meetings"
            {
                message = "Date here cannot be a future date as you are reporting the completion of a District Event."
            }
            else
            {
                message = "Project Completion date cannot be a future date."
            }
            let alertWarning = UIAlertView(title:self.alertTitle, message: message, delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
            let dformatter:DateFormatter=DateFormatter()
            dformatter.dateFormat="dd MMM yyyy"
            let selectedDate=dformatter.date(from: self.txtSelectDate.text!)
            datePickers.setDate(selectedDate!, animated: false)
            return true
        }
       return false
    }

    
    @IBAction func cencelAction(_ sender: Any) {
        functionForHideKeyBoard()
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewCategory.isHidden = true
        viewFunding.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        functionForHideKeyBoard()
        //temp code by rajnedra jat on 6 dec
        //txtSelectDate.text = datePickers.date.formatted
        //txtSelectedDateRot.text = datePickers.date.formatted
        
        
        if(IsSelectDateAction==1)
        {
            if !isDateisFutureDate(selectedDate: datePickers.date)
            {
            txtSelectDate.text = datePickers.date.formatted
            txtSelectedDateRot.text = datePickers.date.formatted
            }
        }
        IsSelectDateAction=0

        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        strSelectDate =  formatter.string(from: datePickers.date)
        
        btnOpacity.isHidden = true
        viewDatepicker.isHidden = true
        viewMettingType.isHidden = true
        viewCategory.isHidden = true
        viewFunding.isHidden = true
        viewSubCategory.isHidden=true
        viewSubToSubCategory.isHidden=true
    }
    
    @IBAction func BackAction(_ sender: Any) {
        functionForHideKeyBoard()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ClubeAction(_ sender: Any) {
        //buttonRotaryserviceClub.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)
        
        
        functionForHideKeyBoard()
        arrayImages = NSArray() as! [UIImage]
        self.tblClube.isHidden = false
        self.tblRotary.isHidden = true
        strWitchType = "Club Meetings"
        checkString = "Club Meetings"
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
        
        //buttonClubServiceRotary.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)
 IsSelectDateAction=0
        
        functionForHideKeyBoard()
        
        self.tblClube.isHidden = true
        self.tblRotary.isHidden = false
        strWitchType = "Service Projects"
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
        // alert.addAction(cameraAction)
         alert.addAction(gallaryAction)
         alert.addAction(cancelAction)
         self.present(alert, animated: true, completion: nil)

    }
    
    @objc func tapDetectedC1() {
        strC = "C1"
        allImagesTapAction()
    }
    
    @objc func tapDetectedC2() {
        strC = "C2"
        allImagesTapAction()
    }
    
    @objc func tapDetectedC3() {
        strC = "C3"
        allImagesTapAction()
    }
    
    @objc func tapDetectedC4() {
        strC = "C4"
        allImagesTapAction()
    }
    
    @objc func tapDetectedC5() {
        strC = "C5"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR1() {
        strR = "R1"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR2() {
        strR = "R2"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR3() {
        strR = "R3"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR4() {
        strR = "R4"
        allImagesTapAction()
    }
    
    @objc func tapDetectedR5() {
        strR = "R5"
        allImagesTapAction()
    }
    @objc func tapDetectedR6() {
        strR = "R6"
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
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallary()
    {
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
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
            
            if(checkString! == "Club Meetings"){
//                self.isimageSelect = "yes"
//                MurrayPhoto = ["","","",""]
            if(strC == "C1"){
      btnC1.isHidden = false
     btnR1.isHidden = false
     imgC1.image = img
     imgR1.image = img
                self.imgMandatoryArray.append(self.imgAdded)
                print(self.imgMandatoryArray.count)
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
//            self.MurrayPhoto?.add(strimageC1 as Any)
//            MurrayPhotoID?.add("0")
            MurrayPhotoID?.replaceObject(at: 0, with: "0")
            self.MurrayPhoto?.replaceObject(at: 0, with: img as Any)
        }
        else{
            strimageC1 = img
            strimageR1=img
            self.MurrayPhoto?.add(strimageC1 as Any)
            MurrayPhotoID?.add("0")
            
//            MurrayPhotoID?.replaceObject(at: 0, with: "0")
//            self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
        }
    }
    else
    {
        strimageC1 = img
        strimageR1=img
         self.MurrayPhoto?.add(strimageC1 as Any)
        MurrayPhotoID?.add("0")
        
//        self.MurrayPhoto?.replaceObject(at: 0, with: strimageC1 as Any)
//        self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
        print(img)
    }
                }
                    
    else if(strC == "C2"){
        btnC2.isHidden = false
        btnR2.isHidden = false
        imgC2.image = img
        imgR2.image = img
        self.imgMandatoryArray.append(self.imgAdded)
        print(self.imgMandatoryArray.count)
        intgetindexVlaue = 1
        if(isCalledFRom == "Edit"){
            if( strimageC2 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![1] as! String)
                MurrayPhotoID?.replaceObject(at: 1, with: "0")
                self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
            }
            else if( self.CheckDelete == "Delete")
            {
//                self.MurrayPhoto?.add(strimageC2 as Any)
//                MurrayPhotoID?.add("0")
                MurrayPhotoID?.replaceObject(at: 1, with: "0")
                self.MurrayPhoto?.replaceObject(at: 1, with: img as Any)
            }
            else
            {
                strimageC2 = img
                strimageR2=img
                self.MurrayPhoto?.add(strimageC2 as Any)
                MurrayPhotoID?.add("0")
                print("1<<<<<.......................................>>>>>>>")
                print(MurrayPhotoID)
                print("2<<<<<.......................................>>>>>>>")
                
                
//                MurrayPhotoID?.replaceObject(at: 1, with: "0")
//                self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
            }
        }
        else
        {
            strimageC2 = img
            strimageR2=img
             self.MurrayPhoto?.add(strimageC2 as Any)
             MurrayPhotoID?.add("0")
//            self.MurrayPhoto?.replaceObject(at: 1, with: strimageC2 as Any)
//            self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
        }
        
    }
    else if(strC == "C3"){
        btnC3.isHidden = false
        btnR3.isHidden = false
        imgC3.image = img
        imgR3.image = img
        self.imgMandatoryArray.append(self.imgAdded)
        print(self.imgMandatoryArray.count)
        intgetindexVlaue = 2
        if(isCalledFRom == "Edit"){
            if( strimageC3 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![2] as! String)
                MurrayPhotoID?.replaceObject(at: 2, with: "0")
                self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
//                self.MurrayPhoto?.add(strimageC3 as Any)
//                MurrayPhotoID?.add("0")
                MurrayPhotoID?.replaceObject(at: 2, with: "0")
                self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
            }
            else{
                strimageC3 = img
                strimageR3=img
                 self.MurrayPhoto?.add(strimageC3 as Any)
                 MurrayPhotoID?.add("0")
                
//                MurrayPhotoID?.replaceObject(at: 2, with: "0")
//                self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
            }
        } else{
            strimageC3 = img
            strimageR3=img
             self.MurrayPhoto?.add(strimageC3 as Any)
             MurrayPhotoID?.add("0")
//            self.MurrayPhoto?.replaceObject(at: 2, with: strimageC3 as Any)
//            self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
        }
        
    } else if(strC == "C4"){
        btnC4.isHidden = false
        btnR4.isHidden = false
        imgC4.image = img
        imgR4.image = img
        self.imgMandatoryArray.append(self.imgAdded)
        intgetindexVlaue = 3
        if(isCalledFRom == "Edit"){
            if( strimageC4 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
                MurrayPhotoID?.replaceObject(at: 3, with: "0")
                self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
//                self.MurrayPhoto?.add(strimageC4 as Any)
//               MurrayPhotoID?.add("0")
                MurrayPhotoID?.replaceObject(at: 3, with: "0")
                self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
            }
            else{
                strimageC4 = img
                strimageR4=img
                 self.MurrayPhoto?.add(strimageC4 as Any)
                 MurrayPhotoID?.add("0")
                
//                MurrayPhotoID?.replaceObject(at: 3, with: "0")
//                self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
            }
            
        } else{
            strimageC4 = img
            strimageR4=img
              self.MurrayPhoto?.add(strimageC4 as Any)
             MurrayPhotoID?.add("0")
            
//            self.MurrayPhoto?.replaceObject(at: 3, with: strimageC4 as Any)
//            self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
        }
        
    } else if(strC == "C5"){
        btnC5.isHidden = false
        btnR5.isHidden = false
        
        
        imgC5.image = img
        imgR5.image = img
        self.imgMandatoryArray.append(self.imgAdded)
        intgetindexVlaue = 4
        if(isCalledFRom == "Edit"){
            if(strimageC5 != nil){
                self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
                MurrayPhotoID?.replaceObject(at: 4, with: "0")
                self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
            }
            else if( self.CheckDelete == "Delete"){
//                self.MurrayPhoto?.add(strimageC5 as Any)
//                 MurrayPhotoID?.add("0")
                MurrayPhotoID?.replaceObject(at: 4, with: "")
                self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
            }
            else{
                strimageC5 = img
                strimageR5=img
                 self.MurrayPhoto?.add(strimageC5 as Any)
                 MurrayPhotoID?.add("0")
                
//                MurrayPhotoID?.replaceObject(at: 4, with: "0")
//                self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
            }
        } else{
            strimageC5 = img
            strimageR5=img
            self.MurrayPhoto?.add(strimageC5 as Any)
             MurrayPhotoID?.add("0")
            
            
//            self.MurrayPhoto?.replaceObject(at: 4, with: strimageC5 as Any)
//            self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
        }
    }
    print("edit club service ------  11111111")
    print(MurrayPhoto)
    print(MurrayPhoto)
    print(MurrayPhoto?.count)
            }
   else if(checkString! == "Service Projects")
   {
    
        if(strR == "R1"){
//            self.isimageSelect = "yes"
       btnR1.isHidden = false
       btnC1.isHidden = false
       imgR1.image = img
       imgC1.image = img
     self.imgMandatoryArray.append(self.imgAdded)
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
                 self.MurrayPhoto?.add(strimageR1 as Any)
                 MurrayPhotoID?.add("0")
               
               
//               MurrayPhotoID?.replaceObject(at: 0, with: "0")
//               self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
               
               
               
           }
       } else{
           strimageR1 = img
           strimageC1=img
           self.MurrayPhoto?.add(strimageR1 as Any)
            MurrayPhotoID?.add("0")
           
           
//           self.MurrayPhoto?.replaceObject(at: 0, with: strimageR1 as Any)
//           self.MurrayPhotoID?.replaceObject(at: 0, with: "0")
       }
   }
   else if(strR == "R2"){
//    self.isimageSelect = "yes"
       btnR2.isHidden = false
       btnC2.isHidden = false
       imgR2.image = img
       imgC2.image = img
       self.imgMandatoryArray.append(self.imgAdded)
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
               self.MurrayPhoto?.add(strimageR2 as Any)
               MurrayPhotoID?.add("0")
//               MurrayPhotoID?.replaceObject(at: 1, with: "0")
//               self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
//            strimageR2
//            uploadMediaImageOnServer(image: self.compressImage(img))
            
            
           }
       } else{
           strimageR2 = img
           strimageC2=img
            self.MurrayPhoto?.add(strimageR2 as Any)
           MurrayPhotoID?.add("0")
//           self.MurrayPhoto?.replaceObject(at: 1, with: strimageR2 as Any)
//           self.MurrayPhotoID?.replaceObject(at: 1, with: "0")
       }
   }
   else if(strR == "R3"){
//    self.isimageSelect = "yes"
       btnR3.isHidden = false
       btnC3.isHidden = false
       imgR3.image = img
       imgC3.image = img
       self.imgMandatoryArray.append(self.imgAdded)
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
//               self.MurrayPhoto?.add(strimageR3 as Any)
//               MurrayPhotoID?.add("0")
               MurrayPhotoID?.replaceObject(at: 2, with: "0")
               self.MurrayPhoto?.replaceObject(at: 2, with: img as Any)
           }
           else{
            //if there is no any image
               strimageR3 = img
               strimageC3=img
               self.MurrayPhoto?.add(strimageR3 as Any)
               MurrayPhotoID?.add("0")
//               MurrayPhotoID?.replaceObject(at: 2, with: "0")
//               self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
           }
       } else{
           strimageR3 = img
           strimageC3=img
            self.MurrayPhoto?.add(strimageR3 as Any)
            MurrayPhotoID?.add("0")
//           self.MurrayPhoto?.replaceObject(at: 2, with: strimageR3 as Any)
//           self.MurrayPhotoID?.replaceObject(at: 2, with: "0")
       }
   } else if(strR == "R4"){
//    self.isimageSelect = "yes"
       btnR4.isHidden = false
       btnC4.isHidden = false
       imgR4.image = img
       imgC4.image = img
       self.imgMandatoryArray.append(self.imgAdded)
       intgetindexVlaue = 3
       if(isCalledFRom == "Edit"){
           if(strimageR4 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![3] as! String)
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
//               self.MurrayPhoto?.add(strimageR4 as Any)
//               MurrayPhotoID?.add("0")
               MurrayPhotoID?.replaceObject(at: 3, with: "0")
               self.MurrayPhoto?.replaceObject(at: 3, with: img as Any)
           }
           else{
               strimageR4 = img
               strimageC4=img
                self.MurrayPhoto?.add(strimageR4 as Any)
                MurrayPhotoID?.add("0")
               
//               MurrayPhotoID?.replaceObject(at: 3, with: "0")
//               self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)
           }
       } else{
           strimageR4 = img
           strimageC4=img
            self.MurrayPhoto?.add(strimageR4 as Any)
            MurrayPhotoID?.add("0")
           
//           self.MurrayPhoto?.replaceObject(at: 3, with: strimageR4 as Any)
//           self.MurrayPhotoID?.replaceObject(at: 3, with: "0")
       }
       
   } else if(strR == "R5"){
//    self.isimageSelect = "yes"
       btnR5.isHidden = false
       btnC5.isHidden = false
       
       imgR5.image = img
       imgC5.image = img
       self.imgMandatoryArray.append(self.imgAdded)
       intgetindexVlaue = 4
       if(isCalledFRom == "Edit"){
           if( strimageR5 != nil){
               self.funcCallDeletePhoto2(strPhotoId: self.MurrayPhotoID![4] as! String)
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else if( self.CheckDelete == "Delete"){
//               self.MurrayPhoto?.add(strimageR5 as Any)
//                MurrayPhotoID?.add("0")
               MurrayPhotoID?.replaceObject(at: 4, with: "0")
               self.MurrayPhoto?.replaceObject(at: 4, with: img as Any)
           }
           else{
               strimageR5 = img
               strimageC5=img
               self.MurrayPhoto?.add(strimageR5 as Any)
                MurrayPhotoID?.add("0")
//               MurrayPhotoID?.replaceObject(at: 4, with: "0")
//               self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
           }
       } else{
           strimageR5 = img
           strimageC5=img
            self.MurrayPhoto?.add(strimageR5 as Any)
            MurrayPhotoID?.add("0")
           
//           self.MurrayPhoto?.replaceObject(at: 4, with: strimageR5 as Any)
//           self.MurrayPhotoID?.replaceObject(at: 4, with: "0")
       }
       
   }
 else if(strR == "R6"){
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){

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
  
  if(checkString == "Club Meetings"){
//    self.isimageSelect = "yes"
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
//    self.isimageSelect = "yes"
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
           uploadMediaImageOnServer(image: self.compressImage(img))
       }
       print("edit rotary  11111111")
       print(MurrayPhoto)
       print(MurrayPhoto?.count)
   }
   else if(strR == "R2"){
//    self.isimageSelect = "yes"
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
//    self.isimageSelect = "yes"
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
//    self.isimageSelect = "yes"
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
//    self.isimageSelect = "yes"
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

        else
        {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
       if(pickerView==pickerCategory)
        {
            let categories:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as! String
            return categories
        }
        else if(pickerView==pickerSubCategory)
               {
                   let categories:String = (muarrayForSubCategoryList.value(forKey: "SubcategoryName") as AnyObject).object(at: row) as! String
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

        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView==pickerCategory)
             {
             let categories:String =  (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as! String
             let ID:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "ID") as AnyObject).object(at: row) as! String

                 txtCategory.text = categories
                 categoryId=ID
                 
                 mainCategorySelect(ID: ID, categoryName: categories)
             }
             else  if(pickerView==pickerSubCategory)
                 {
             let categories:String =  (muarrayForSubCategoryList.value(forKey: "SubcategoryName") as AnyObject).object(at: row) as! String
             let ID:String = (muarrayForSubCategoryList.value(forKey: "pk_subcategoryId") as AnyObject).object(at: row) as! String
             let mainCatID:String = (muarrayForSubCategoryList.value(forKey: "fk_CategoryID") as AnyObject).object(at: row) as! String

             txtSubCategory.text = categories
             print(ID)
             subCategoryId=ID
             self.subCategorySelect(ID: ID, categoryName: categories,mainCatID: mainCatID)
                     
                 }
         else  if(pickerView==pickerSubToSubCategory)
           {
              let categories:String =  (muarrayForSubToSubCategoryList.value(forKey: "subtosubcategoryname") as AnyObject).object(at: row) as! String
              let ID:String = (muarrayForSubToSubCategoryList.value(forKey: "pk_subtosubcategoryId") as AnyObject).object(at: row) as! String
              txtSubtoSubCategory.text = categories
              print(ID)
              subtoSubCategoryId=ID
           }
        else if pickerView==pickerFundinglist
             {
                let fID=(muarrayFundinglistArray.value(forKey: "Pk_Fund_ID") as AnyObject).object(at: row) as! String
                 print(fID)
                 fundID=fID
                 let fundName = (muarrayFundinglistArray.value(forKey: "Fund_Name") as AnyObject).object(at: row) as! String
                 txtFundName.text=fundName
             }
        
    }
    
    
 func mainCategorySelect(ID:String,categoryName:String)
    {
        self.subCategoryId=""
        self.subtoSubCategoryId=""
        self.muarrayForSubCategoryList=NSMutableArray()
        self.muarrayForSubToSubCategoryList=NSMutableArray()
        self.txtSubCategory.text=""
        self.txtSubCategoryNew.text=""
        self.txtSubtoSubCategory.text=""
        self.txtCategoryNew.text=""
        
        self.btnSubToSubCategoryDrop.isEnabled=false
        self.txtSubCategoryNew.isEnabled=false

        if(categoryName == "Others"){
        self.txtCategoryNew.isEnabled = true
        self.btnSubCategoryDrop.isEnabled=false
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
        self.txtSubtoSubCategory.text=""
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
        
        var strImageID =  self.albumImagesID
        if(strImageID == "" || strImageID == nil){
            strImageID = "0"
        }
            var varGetDate:String! = self.txtSelectDate.text as! String
            var varGetArray =  varGetDate.components(separatedBy: " ")
            
            var Day:String!=varGetArray[0]
            var Month:String!=varGetArray[1]
            var Year:String!=varGetArray[2]
        var IntYear = Int(Year) ?? 0
        var calculatedYear = IntYear - 1
        var paramYear = "\(calculatedYear)-\(IntYear)"
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
            var FinalDate:String!=subStr+"-"+Day
            print("final date")
            print(FinalDate)
        if(checkString == "Service Projects"){
            
//            if isMediaCheck=="0"
//            {
//                self.mediaImageID="0"
//            }
            
            if(categoryId=="0")
            {
                categoryId="1"
            }
            print("this is category id :-----")
            print(categoryId)
            var myBenificiary:String=""
            var tempBenificiary:String=""
            if flagExceedBenificiary=="1"
            {
                myBenificiary=BenificiaryCount
                tempBenificiary=txtBenificary.text!
            }
            else
            {
                myBenificiary=txtBenificary.text!
                tempBenificiary=""
            }

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

            var rotaractors:String="0"
            if let rotaract=txtRotractors.text
            {
               rotaractors=rotaract
            }
            if rotaractors==""
            {
                rotaractors="0"
            }
            if tempBenificiary==""
            {
                tempBenificiary="0"
            }
            parameterst = [
                "isSubGrpAdmin":"0",
                "albumId":strAlbumId as Any,
                "groupId":strGroupId as Any,
                "moduleId":moduleId as Any,
                "type":"0",
                "memberIds":"",
                "albumTitle":txtRotetoryTitle.text as Any,
                "albumDescription":txtRotDesc.text as Any,
                "albumImage":strImageID as Any,
                "createdBy":strcreatedBy as Any,
                "dateofproject": FinalDate,
                "shareType":"1",
                "costofproject":txtCost.text as Any,
                "beneficiary":txtBenificary.text as Any,
                "TempBeneficiary":tempBenificiary,
                "TempBeneficiary_flag":flagExceedBenificiary,
                "manhourspent":txtmanHours.text as Any,
                "categoryId":categoryId,
                "Fk_SubcategoryID":subCategoryId,
                "Fk_SubTosubcategoryID":subtoSubCategoryId,
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
                "Fk_Funding_Id":fundID,
                "Financeyear" : year,
                "prjct_loctn":rotLocationOfProj.text as Any
            ]
        }
        else{
            categoryId="0"
            parameterst = [
                "isSubGrpAdmin":"0",
                "albumId":strAlbumId as Any,
                "groupId":strGroupId as Any,
                "moduleId":moduleId as Any,
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
                "costofprojecttype":"",
                "Attendance":"0",
                "AttendancePer":"0",
                "MeetingType":"0",
                "AgendaDocID":"0",
                "MOMDocID":"0",
                "Rotaractors":"0",
                "Fk_Funding_Id":"",
                "Financeyear" : year,
                "prjct_loctn":locationOfProject.text as Any
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
        print("District AddUpdateAlbum_New completeURL:: \(completeURL)")
               print("District AddUpdateAlbum_New parameter:: \(parameterst)")
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
            SVProgressHUD.dismiss()
            if((dd.object(forKey: "TBAddGalleryResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                self.strAlbumId = ((dd.object(forKey: "TBAddGalleryResult")! as AnyObject).object(forKey: "galleryid") as! String)
                
                //  UserDefaults.standard.set(galleryid, forKey: "GalleryID")
                
              //  self.view.makeToast("Album added successfully", duration: 2, position: CSToastPositionCenter)
                
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
            
            
        }
    }
    
}else{
    
    for i in 00..<(self.MurrayPhoto?.count)!
    {
        if(i==0){
            print(self.MurrayPhoto)
            self.MurrayText?.add(self.txtViewC1.text)
            
        }else if(i==1){
            print(self.MurrayPhoto)
            self.MurrayText?.add(self.txtViewC2.text)
        }
        else if(i==2){
            print(self.MurrayPhoto)
            self.MurrayText?.add(self.txtViewC3.text)
        }
        else if(i==3){
            print(self.MurrayPhoto)
            self.MurrayText?.add(self.txtViewC4.text)
        }
        else if(i==4){
            print(self.MurrayPhoto)
            self.MurrayText?.add(self.txtViewC5.text)
        }
    }
    
}

print("this is nvalue:=-------------------")
 print(self.MurrayPhotoID!)
 print(self.MurrayPhoto!)
 print(self.MurrayText!)
                self.SendPhotoArrayToserver(muarrayImageID: self.MurrayPhoto!, muarrayImageText: self.MurrayText!, parYear: paramYear)

            }
            else
            {
                self.btnAddEdit.isEnabled=true
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                self.btnAddEdit.isEnabled=true
                SVProgressHUD.dismiss()
                
            }
            }
            
        })
    }
    
    
    func queryString(urlString:String, params:[String: String]) -> String {
        
        let queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        var urlComps = URLComponents(string: urlString)
        
        urlComps?.queryItems = queryItems
        
        return urlComps?.url?.absoluteString ?? ""
        
    }
    
    func getParameter(strPhotoid:String,strDesc:String,parYear:String)->[String:String]?{
        
        var param:[String:String] = [String:String]()
        param["photoId"] = strPhotoid
        param["desc"] = strDesc
        param["albumId"] = strAlbumId
        param["groupId"] = strGroupId
        param["createdBy"] = strcreatedBy
        param["Financeyear"] = year
//        param["Financeyear"] = parYear
        print("param------\(param)")
        return param
}
    
    func SendPhotoArrayToserver(muarrayImageID: NSMutableArray, muarrayImageText: NSMutableArray,parYear:String){
        SVProgressHUD.show()
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        let completeURL = baseUrl+"Gallery/AddUpdateAlbumPhoto?"
        
        var tempMurrayPhotoID:NSMutableArray=NSMutableArray()
    
        print("this is value from photo id::::-------------------")
        // MurrayPhotoID=tempMurrayPhotoID
        print(tempMurrayPhotoID)
        print(MurrayPhotoID)
        print(MurrayPhoto)
        print(MurrayText)
        for i in 00..<(MurrayPhoto!.count){
            // failing.......................................................
            print("count : ",i)
//            if(i == 5  ){
//                break
//            }
            
            if(isCalledFRom == "Edit"){
                print("checkDataa")
                
                var getPhotoIs:String!=MurrayPhotoID![i] as? String
                if(getPhotoIs=="0")
                {
                    getPhotoIs="0"
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String, parYear: parYear) else {
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
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String, parYear: parYear) else {
                    
                    
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
                
                
                var getPhotoIs:String!=MurrayPhotoID![i] as? String
                if(getPhotoIs=="0")
                {
                    getPhotoIs="0"
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String, parYear: parYear) else {
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
                    guard let params = getParameter(strPhotoid:MurrayPhotoID![i] as! String, strDesc: MurrayText![i] as! String, parYear: parYear) else {
                    
                    
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
                    guard let params = getParameter(strPhotoid:"0",strDesc: MurrayText![i] as! String, parYear: parYear) else {
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
            let alert = UIAlertController(title: "", message: "\(alertTitle) updated successfully", preferredStyle: .alert)
            
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
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
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
            let alert = UIAlertController(title: "", message: "\(alertTitle) added successfully", preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when){
                
                // your code with delay
                
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubListWhenComingFromEdit()
        {
            if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
            {
           self.showMBProgress(str: "")
            let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
            let parameterst =  [ "DistrictID":"0", "ShareType": "1"]
            print(parameterst)
            print(completeURL)
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                // print(response)
                SVProgressHUD.dismiss()
                let varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.hideMBProgress()
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
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
        self.muarrayForMetting.add("Regular")
        self.muarrayForMetting.add("BOD")
        self.muarrayForMetting.add("Assembly")
        self.muarrayForMetting.add("Fellowship")
        self.muarrayCategoryListArray = (responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Categories") as! NSArray
        if(self.muarrayCategoryListArray.count>0)
        {
            var dict : NSDictionary=NSDictionary()
            for i in 1..<self.muarrayCategoryListArray.count
                            {
          let Name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: i) as! String
          let ID  = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: i) as! String
          let DistrictID  = (self.muarrayCategoryListArray.value(forKey: "DistrictID") as AnyObject).object(at: i) as! String
          dict = ["Name":Name,"ID":ID,"DistrictID":DistrictID]
          //print(dict)
          self.muarrayForCategoryListWithOutZeroIndex.add(dict)
          print("self.muarrayForCategoryListWithOutZeroIndex ------\(self.muarrayForCategoryListWithOutZeroIndex)")
      }
      //MARK:-add sub and sub to sub category111

      if let subCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subcat") as? NSArray
         {
          self.muarraySubCategoryListArray=subCategoryList
          }
      
         
          if let subToSubCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subtosubcat") as? NSArray
         {
          self.muarraySubToSubCategoryListArray=subToSubCategoryList
         }
    }
    else
    {
        
        self.view.makeToast("No Category", duration: 2, position: CSToastPositionCenter)
    }
      //Added funding drop down list
      if let FundingList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Fundinglist") as? NSArray
      {
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
                SVProgressHUD.dismiss()
            }
        }
    
    func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
    {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        SVProgressHUD.show()
        let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
        let parameterst =  [ "DistrictID":"0", "ShareType": "1"]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            // print(response)
            SVProgressHUD.dismiss()
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
                let responseDict = response.value(forKey: "ShowcaseDetails")as! NSDictionary
                let letGetMessage = (responseDict.value(forKey: "message"))as! String
                let letGetStatus = (responseDict.value(forKey: "status"))as! String
                print(responseDict)
                print(letGetStatus)
                print(letGetMessage)
                
if(letGetStatus == "0" && letGetMessage == "success")
{
    self.muarrayForMetting.add("Regular")
    self.muarrayForMetting.add("BOD")
    self.muarrayForMetting.add("Assembly")
    self.muarrayForMetting.add("Fellowship")
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
    print("self.muarrayForCategoryListWithOutZeroIndex123---------\(self.muarrayForCategoryListWithOutZeroIndex)")
  }
  //MARK:-add sub and sub to sub category111

  if let subCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subcat") as? NSArray
     {
      self.muarraySubCategoryListArray=subCategoryList
      print("self.muarraySubCategoryListArray---------\(self.muarraySubCategoryListArray)")
      }
  
     
      if let subToSubCategoryList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "subtosubcat") as? NSArray
     {
      self.muarraySubToSubCategoryListArray=subToSubCategoryList
          print("self.muarraySubToSubCategoryListArray---------\(self.muarraySubToSubCategoryListArray)")
     }
}
else
{
    
    self.view.makeToast("No Category", duration: 2, position: CSToastPositionCenter)
}
    
    //Added funding drop down list
    if let FundingList=(responseDict.value(forKey: "Result")! as AnyObject).value(forKey: "Fundinglist") as? NSArray
    {
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
  
            }
        })
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
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
    
    
    func functionForGetAlbumDetails_New()
    {
      
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        self.showMBProgress(str: "")
        let completeURL = baseUrl+"Gallery/GetAlbumDetails_New"
        var parameterst:NSDictionary=NSDictionary()
        print(year)
        parameterst =  ["albumId":strAlbumId as Any,
                        "Financeyear":year
        ]
        
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            let varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.hideMBProgress()
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
            }
            else
            {
            if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
 let arrarrNewGroupList = (dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "AlbumDetailResult") as! NSArray
 let details = arrarrNewGroupList.value(forKey: "AlbumDetail") as! NSArray
 print(details)
 let shareType  = (details.value(forKey: "shareType") as AnyObject).object(at: 0) as! String
 print("sjare Type:------",shareType)
 if(shareType == "0"){
     self.checkString = "Club Meetings"
     self.tblClube.isHidden = false
     self.tblRotary.isHidden = true
 }
 else{
     self.checkString = "Service Projects"
     self.tblClube.isHidden = true
     self.tblRotary.isHidden = false
     //self.buttonClubServiceRotary.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)

 }
 let srtdate = ((details.value(forKey: "project_date") as AnyObject).object(at: 0) as! String)
 
 print("datess:-------------",srtdate)
 self.strSelectDate = srtdate
 print("datess:-------------",self.strSelectDate)
 self.txtSelectDate.text = self.convertToShowFormatDate(dateString: srtdate)
 self.txtSelectedDateRot.text =  self.convertToShowFormatDate(dateString: srtdate)
 
 self.txtTitle.text = ((details.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String)
self.locationOfProject.text = ((details.value(forKey: "prjct_loctn") as AnyObject).object(at: 0) as! String)
 self.txtViewDesc.text = ((details.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String)
 
 self.txtCost.text = ((details.value(forKey: "project_cost") as AnyObject).object(at: 0) as! String)
 self.txtBenificary.text = ((details.value(forKey: "beneficiary") as AnyObject).object(at: 0) as! String)
 self.txtmanHours.text = ((details.value(forKey: "working_hour") as AnyObject).object(at: 0) as! String)
 self.txtRotatiran.text = ((details.value(forKey: "NumberOfRotarian") as AnyObject).object(at: 0) as! String)
 self.txtRotetoryTitle.text = ((details.value(forKey: "albumTitle") as AnyObject).object(at: 0) as! String)
 self.rotLocationOfProj.text = ((details.value(forKey: "prjct_loctn") as AnyObject).object(at: 0) as! String)
 self.txtRotDesc.text = ((details.value(forKey: "albumDescription") as AnyObject).object(at: 0) as! String)
           //rajendra jat working here.......
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
      self.subCategorySelect(ID: self.subCategoryId!, categoryName: subCategoryText, mainCatID: self.categoryId!)
      self.txtSubCategory.text=subCategoryText
      if let OtherSubCategory=(details.value(forKey: "OtherSubCategory") as AnyObject).object(at: 0) as? String
         {
          if OtherSubCategory == "\(0)" {
              self.txtSubCategoryNew.text=""
          } else {
              self.txtSubCategoryNew.text=OtherSubCategory
          }
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
           let mediaphotoID = ((details.value(forKey: "MediaphotoID") as AnyObject).object(at: 0) as! String)
          self.mediaImageID=mediaphotoID
    
    if let mediaPhoto = (details.value(forKey: "Mediaphoto") as AnyObject).object(at: 0) as? String
    {
      if mediaPhoto.count>1{
       let ImageProfilePic:String = mediaPhoto.replacingOccurrences(of: " ", with: "%20")
       let checkedUrl = URL(string: ImageProfilePic)
      }else
      {
      }
    }
      else
        {
        }
      }
      else
      {
         

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

 
     self.functionForGetPhotoList_New()
 }
 else
 {
     self.hideMBProgress()
     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
 }
 }
 if(self.checkString == "Club Meetings")
     {
         self.categoryId="0"
         
     }
 })
 }
 else
 {
          self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
        }
    }

    
    func  funcCallDeletePhoto(strPhotoId:String,paramYear:String)   {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        SVProgressHUD.show()
        let completeURL = baseUrl+"/Gallery/DeleteAlbumPhoto"
        var parameterst:NSDictionary=NSDictionary()
        
        parameterst =  ["albumId":strAlbumId as Any,
                        "photoId":strPhotoId as Any,
                        "deletedBy":strcreatedBy as Any,
                        "Financeyear":year as Any]
        
        
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
    
    func  funcCallDeletePhoto2(strPhotoId:String)   {
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        SVProgressHUD.show()
        let completeURL = baseUrl+"/Gallery/DeleteAlbumPhoto"
        var parameterst:NSDictionary=NSDictionary()
        
        parameterst =  ["albumId":strAlbumId as Any,
                        "photoId":strPhotoId as Any,
                        "deletedBy":strcreatedBy as Any]
        
        
        print(parameterst)
        print(completeURL)
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
    
    
    func functionForGetPhotoList_New()
    {
        self.showMBProgress(str: "Loading photos..")
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
        let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
        var parameterst:NSDictionary=NSDictionary()
        parameterst =  ["albumId":strAlbumId as Any,
                        "groupId":strGroupId as Any,
                        "Financeyear": year]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as! [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            self.MurrayPhoto = NSMutableArray()
            self.MurrayPhotoID =  NSMutableArray()
            self.MurrayText = NSMutableArray()
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
      self.hideMBProgress()
  }
  else
  {
  if((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "status") as! String == "0")
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
 print(self.checkString)
  
  if(self.checkString == "Service Projects"){
 //self.buttonClubServiceRotary.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)
      self.MurrayPhotoID=NSMutableArray()
      self.MurrayPhoto=NSMutableArray()
      for i in 00..<arrarrNewGroupList.count{
          if ((arrarrNewGroupList[i] as AnyObject).value(forKey: "photoId") as! String) != "0" {

              self.imgMandatoryArray.append(self.imgAdded)
          }
  if(i == 0){
      let photoId = (arrarrNewGroupList[0] as AnyObject).value(forKey: "photoId") as! String
      self.MurrayPhotoID?.add(photoId)
      let urls = (arrarrNewGroupList[0] as AnyObject).value(forKey: "url") as! String
      let Desc = (arrarrNewGroupList[0] as AnyObject).value(forKey: "description") as! String
      self.btnR1.isHidden = false
      self.btnC1.isHidden = false
      self.txtViewR1.text = Desc
      self.txtViewC1.text = Desc
      
      
      
      let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
      let checkedUrl = URL(string: ImageProfilePic)
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
       self.txtViewC2.text = Desc
      
      
      let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
      let checkedUrl = URL(string: ImageProfilePic)
      self.imgR2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageR2 = self.imgR2.image
      
      self.imgC2.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageC2 = self.imgR2.image
      
      
      self.MurrayPhoto?.add(self.strimageR2 as Any)
      
      
      self.arrayTempImageIndexHold.replaceObject(at: 1, with: "1")

      //   self.imgR2.isUserInteractionEnabled = false
      
      
  }else if(i == 2){
      let photoId = (arrarrNewGroupList[2] as AnyObject).value(forKey: "photoId") as! String
      self.MurrayPhotoID?.add(photoId)
      let urls = (arrarrNewGroupList[2] as AnyObject).value(forKey: "url") as! String
      let Desc = (arrarrNewGroupList[2] as AnyObject).value(forKey: "description") as! String
      self.txtViewR3.text = Desc
        self.txtViewC3.text = Desc
      
      
      self.btnR3.isHidden = false
      self.btnC3.isHidden = false
      
      
      let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
      let checkedUrl = URL(string: ImageProfilePic)
      self.imgR3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageR3 = self.imgR3.image
      
      
      self.imgC3.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageC3 = self.imgR3.image
      
      
      self.MurrayPhoto?.add(self.strimageR3 as Any)
      
      
      self.arrayTempImageIndexHold.replaceObject(at: 2, with: "1")

      //    self.imgR3.isUserInteractionEnabled = false
      
      
  }else if(i == 3){
      let photoId = (arrarrNewGroupList[3] as AnyObject).value(forKey: "photoId") as! String
      self.MurrayPhotoID?.add(photoId)
      self.btnR4.isHidden = false
       self.btnC4.isHidden = false
      
      
      let urls = (arrarrNewGroupList[3] as AnyObject).value(forKey: "url") as! String
      let Desc = (arrarrNewGroupList[3] as AnyObject).value(forKey: "description") as! String
      self.txtViewR4.text = Desc
       self.txtViewC4.text = Desc
      let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
      let checkedUrl = URL(string: ImageProfilePic)
      self.imgR4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageR4 = self.imgR4.image
      
      
      self.imgC4.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageC4 = self.imgR4.image
      
      
      
      
      self.MurrayPhoto?.add(self.strimageR4 as Any)
      
      
      self.arrayTempImageIndexHold.replaceObject(at: 3, with: "1")

      //      self.imgR4.isUserInteractionEnabled = false
      
      
  }else if(i == 4){
      let photoId = (arrarrNewGroupList[4] as AnyObject).value(forKey: "photoId") as! String
      self.MurrayPhotoID?.add(photoId)
      
      print("self.imgMandatoryArray------\(self.imgMandatoryArray.count)")
      let urls = (arrarrNewGroupList[4] as AnyObject).value(forKey: "url") as! String
      let Desc = (arrarrNewGroupList[4] as AnyObject).value(forKey: "description") as! String
      self.txtViewR5.text = Desc
      
      self.txtViewC5.text = Desc

      
      self.btnR5.isHidden = false
        self.btnC5.isHidden = false
      
      
      let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
      let checkedUrl = URL(string: ImageProfilePic)
      self.imgR5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageR5 = self.imgR5.image
      
      self.imgC5.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
      self.strimageC5 = self.imgR5.image
      
      
      
      self.MurrayPhoto?.add(self.strimageR5 as Any)
      
      
      
      
      
      self.arrayTempImageIndexHold.replaceObject(at: 4, with: "1")

      //   self.imgR5.isUserInteractionEnabled = false
      
  }
     }
//     var countImageID:Int=5-self.MurrayPhotoID!.count
//     for i in 00..<countImageID
//     {
//         self.MurrayPhotoID?.add("0")
//         self.MurrayPhoto?.add("0")
//     }
     print("This is my code here 3 dec")
     print(self.MurrayPhotoID)
     print(self.MurrayPhotoID?.count)
     print(self.MurrayPhoto)
     print(self.MurrayPhoto?.count)
 }
 else  if(self.checkString == "Club Meetings"){ //Club Service
     //self.buttonRotaryserviceClub.setImage(UIImage(named:"radio_btn_Check1"), for: .normal)
    // self.txtCategory.text! = "Peace and Conflict Prevention/Resolution"
    // self.categoryId="0"
     self.MurrayPhotoID=NSMutableArray()
     self.MurrayPhoto=NSMutableArray()
     for i in 00..<arrarrNewGroupList.count{
        
         if ((arrarrNewGroupList[i] as AnyObject).value(forKey: "photoId") as! String) != "0" {             self.imgMandatoryArray.append(self.imgAdded)
         }
 if(i == 0){
     let photoId = (arrarrNewGroupList[0] as AnyObject).value(forKey: "photoId") as! String
     self.MurrayPhotoID?.add(photoId)
     let urls = (arrarrNewGroupList[0] as AnyObject).value(forKey: "url") as! String
     let Desc = (arrarrNewGroupList[0] as AnyObject).value(forKey: "description") as! String
     self.btnC1.isHidden = false
     self.txtViewC1.text = Desc
     
     self.btnR1.isHidden = false
     self.txtViewR1.text = Desc
     
   
         let ImageProfilePic:String = urls.replacingOccurrences(of: " ", with: "%20")
         let checkedUrl = URL(string: ImageProfilePic)
         self.imgC1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
         self.strimageC1 = self.imgC1.image
         
         
         self.imgR1.sd_setImage(with: checkedUrl, placeholderImage: UIImage.init(named: "AddPic"))
         self.strimageR1 = self.imgC1.image
     
     
     
     
     self.MurrayPhoto?.add(self.strimageC1 as Any)
     
     
     
     self.arrayTempImageIndexHold.replaceObject(at: 0, with: "1")

     // self.imgC1.isUserInteractionEnabled = false
     
     
 }else if(i == 1){
     let photoId = (arrarrNewGroupList[1] as AnyObject).value(forKey: "photoId") as! String
     self.MurrayPhotoID?.add(photoId)
     let urls = (arrarrNewGroupList[1] as AnyObject).value(forKey: "url") as! String
     let Desc = (arrarrNewGroupList[1] as AnyObject).value(forKey: "description") as! String
     self.btnC2.isHidden = false
     self.txtViewC2.text = Desc
     
     self.btnR2.isHidden = false
     self.txtViewR2.text = Desc
     
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
     
     self.btnC3.isHidden = false
     
     
     self.txtViewR3.text = Desc
     
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
     
     self.btnC4.isHidden = false
     
     
     self.txtViewR4.text = Desc
     
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
     
     self.btnC5.isHidden = false
     
     self.txtViewR5.text = Desc
     
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
 
    }
    
    //after adding my code rajendra jat 3 dec
    //MARK:- rajendra jat adding code here
//    var countImageID:Int=5-self.MurrayPhotoID!.count
//    for i in 00..<countImageID
//    {
//        self.MurrayPhotoID?.add("0")
//        self.MurrayPhoto?.add("0")
//    }
    print("This is my code here 3 dec")
    print(self.MurrayPhotoID)
    print(self.MurrayPhotoID?.count)
    print(self.MurrayPhoto)
    print(self.MurrayPhoto?.count)
    
    
    
}
 self.hideMBProgress()
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
    
    
    //Mark:- Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblClube){
            return (Clubearray?.count)!
        }
        if(tableView == tblRotary){
            return  (rotaryArray?.count)!
            
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
    
    
    func ClubeCrossClickEvent(_ sender:UIButton)
    {
        
        if( self.checkString == "Club Meetings"){
            self.logoImagesClube.remove(at: sender.tag)
            self.tblClube.reloadData()
        }else if(self.checkString == "Service Projects"){
            
            self.tblRotary.reloadData()
            
        }
    }

   func ClubePicClickEvent(_ sender:UIButton)
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
       // alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
