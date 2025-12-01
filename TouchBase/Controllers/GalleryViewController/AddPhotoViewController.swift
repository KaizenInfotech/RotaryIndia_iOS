
//
//  AddPhotoViewController.swift
//  TouchBase
//
//  Created by rajendra on 26/04/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import Alamofire
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}




class AddPhotoViewController: UIViewController , UITextFieldDelegate , UITextViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , UIPopoverControllerDelegate , webServiceDelegate , UIGestureRecognizerDelegate ,UIPickerViewDelegate , UIPickerViewDataSource,uploadDocDelegate{
    
    
    
    
    
    @IBOutlet weak var uncderLineSecondImgBottom5: UIImageView!
    
    @IBOutlet weak var uncderLineSecondImgBottom4: UIImageView!
    
    @IBOutlet weak var uncderLineSecondImgBottom3: UIImageView!
    @IBOutlet weak var uncderLineSecondImgBottom2: UIImageView!
    
    @IBOutlet weak var imgPlaceholderImage1: UIImageView!
    @IBOutlet weak var imgPlaceholderImage2: UIImageView!
    @IBOutlet weak var imgPlaceholderImage3: UIImageView!
    
    @IBOutlet weak var imgPlaceholderImage4: UIImageView!
    
    @IBOutlet weak var imgPlaceholderImage5: UIImageView!
    
    
    @IBOutlet weak var placeholderImgDesc5: UILabel!
    @IBOutlet weak var placeholderImgDesc4: UILabel!
    @IBOutlet weak var placeholderImgDesc3: UILabel!
    @IBOutlet weak var placeholderImgDesc2: UILabel!
    @IBOutlet weak var placeholderImgDesc1: UILabel!
    @IBOutlet weak var btnDeleteImg1: UIButton!
    @IBOutlet weak var btnDeleteImg2: UIButton!
    @IBOutlet weak var btnDeleteImg3: UIButton!
    @IBOutlet weak var btnDeleteImg4: UIButton!
    @IBOutlet weak var btnDeleteImg5: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img1Desc: UITextView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img2Desc: UITextView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img3Desc: UITextView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img4Desc: UITextView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img5Desc: UITextView!
    
    var varWhichImageClickOnTap:String!=""
    var varWhichImageDeleteorNot:String!=""
    var GalleryIDFromResponseAddAlbum:String!=""
    
    @IBOutlet weak var lblContentposted: UILabel!
    @IBOutlet weak var viewTwoForClubService: UIView!
    @IBOutlet weak var viewOneForRotaryService: UIView!
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    
    @IBOutlet weak var datePickers: UIDatePicker!
    @IBOutlet weak var btnDoneManHours: UIButton!
    
    @IBOutlet weak var btnCancelManHours: UIButton!
    
    @IBOutlet weak var pickerHourDayMonth: UIPickerView!
    @IBOutlet weak var viewForManHoursSpendPicker: UIView!
    @IBOutlet weak var textfieldManHourTypeHourYearMonth: UITextField!
    
    @IBOutlet weak var viewPickerCategory: UIView!
    @IBOutlet weak var pickerViewCategoryList: UIPickerView!
    @IBOutlet weak var buttonDoneCategory: UIButton!
    @IBOutlet weak var buttonCancelCategory: UIButton!
    @IBOutlet weak var buttonRupeeDollerDone: UIButton!
    @IBOutlet weak var viewPickerRupeeDoller: UIView!
    @IBOutlet weak var pickerViewRupeeDoller: UIPickerView!
    @IBOutlet weak var buttonRupeeDollerCancel: UIButton!
    var muarrayCategoryListArray:NSArray=NSArray()
    var muarrayDollerRupee:NSMutableArray=NSMutableArray()
    
    
    
    var muarrayForPhotoId:NSMutableArray=NSMutableArray()
    var muarrayForCategoryListWithOutZeroIndex:NSMutableArray=NSMutableArray()
    var muarrayForMultipleImageUrlStore:NSMutableArray=NSMutableArray()
    var selectPublicOrPrivate:String!=""
    
    var muarrayForMANSpendTypeHoursMonth:NSMutableArray=NSMutableArray()
    @IBOutlet weak var textfieldManHoursSpent: UITextField!
    @IBOutlet weak var textfieldBaneficiary: UITextField!
    @IBOutlet weak var textfieldRupeeSelect: UITextField!
    @IBOutlet weak var textfieldCostofProject: UITextField!
    @IBOutlet weak var textfieldDateofProject: UITextField!
    @IBOutlet weak var textfieldCategory1: UITextField!
    @IBOutlet weak var textfieldCategory2: UITextField!
    
    @IBOutlet weak var textfieldNumberOfRotarians: UITextField!
    @IBOutlet weak var imgUnderLine4: UIImageView!
    @IBOutlet weak var imgUnderLine3: UIImageView!
    @IBOutlet weak var imgUnderLine2: UIImageView!
    @IBOutlet weak var imgUnderLine1: UIImageView!
    @IBOutlet weak var lblShare: UILabel!
    var varIsPublicOrWithInClub:String!=""
    @IBOutlet weak var buttonWithInTheClub: UIButton!
    @IBOutlet weak var buttonPublic: UIButton!
    @IBOutlet weak var buttonAllAnnounce: UIButton!
    @IBOutlet weak var buttonSubGroupAnnounce: UIButton!
    @IBOutlet weak var buttonMembersAnnounce: UIButton!
    @IBOutlet weak var labelYouHaveAddedGroupsAndMember: UILabel!
    @IBOutlet weak var buttonEditAllGroupMember: UIButton!
    @IBOutlet weak var imageAddAlbum: UIImageView!
    @IBOutlet weak var textfieldTitle: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var lbHeadingRecipientType: UILabel!
    @IBOutlet weak var lblHeadingPhoto: UILabel!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblHeadingTitle: UILabel!
    
    var openDatePicker:String!=""
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var window: UIWindow?
    //Local variable
    //FromEdit/Update
    
    var setcategoryOnCancel:String!=""
    var setCategoryIDOnCancel:String!=""
    var varSubGrouporMember:Int!=0
    var picker:UIImagePickerController?=UIImagePickerController()
    var popover:UIPopoverController?=nil
    
    var annTypeStr:NSString!
    var selectRecipientTypeEditMode:String = ""
    var count = Int()
    var commonIDString : String = ""
    var ImsgId:String = ""
    var imageUploadOrNot:String = ""
    var TypeIDEdit:String = ""
    
    var groupID :String = ""
    var groupProfileID :String = ""
    var isCalledFRom:String!=""
    var varAlbumID:String! = ""
    var Getbeneficiary:String!=""
    var Getcost_of_project_type:String!=""
    var Getproject_cost:String!=""
    var Getproject_date:String!=""
    var Getworking_hour_type:String!=""
    var GetNumberOfRotarian:String!=""
    var titleForText:String! = ""
    var descriptionForAlbum:String! = ""
    var imageUrlForAlbumImage:String! = ""
    var grpID:String!=""
    var createdByORUserIdOrProfileId:String!=""
    var isAdmin:String!=""
    var isCategory:String!=""
    var varShareType:String!=""
    var stringModuleId:String=""
    var GetClubName:String!=""
    var GetShareTypes:String!=""
    var  muarrayMainList:NSArray = NSArray()
    
    var varSetAlbumCategory:String!=""
    
    
    //    textfieldCategory1
    //    textfieldCategory2
    //    textfieldBaneficiary
    //    textfieldRupeeSelect
    //    textfieldCostofProject
    //    textfieldDateofProject
    //    textfieldManHoursSpent
    
    func functionTextfieldSetting()
    {
        labelPlaceHolder.textColor = UIColor.darkGray
        textfieldCategory1.delegate=self
        textfieldCategory2.delegate=self
        textfieldBaneficiary.delegate=self
        textfieldRupeeSelect.delegate=self
        textfieldCostofProject.delegate=self
        textfieldDateofProject.delegate=self
        textfieldManHoursSpent.delegate=self
        textfieldNumberOfRotarians.delegate=self
        textfieldManHourTypeHourYearMonth.delegate=self
        textfieldTitle.delegate=self
        
        
        textfieldManHoursSpent.keyboardType = .decimalPad
       // textfieldBaneficiary.keyboardType = .default
        textfieldNumberOfRotarians.keyboardType = .numberPad
        textfieldCostofProject.keyboardType = .decimalPad
        textfieldCategory1.placeholder = "Select Category"
        textfieldCategory1.textFieldFullBorder()
        textfieldRupeeSelect.textFieldFullBorder()
        textfieldManHourTypeHourYearMonth.textFieldFullBorder()
        self.textfieldCategory2.isUserInteractionEnabled = false
        textfieldCategory2.backgroundColor = UIColor(red: 206.0/255.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
    }
    
    
    var RotaryY:CGFloat=0.0
    var clubY:CGFloat=0.0
    
    //MARK:-Image Tap Gesture
    func functionForAddImageSelectionClickEvent()
    {
        
        let tapRecognizerfirst = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.imageTappedfirst(_:)))
        img1.addGestureRecognizer(tapRecognizerfirst)
        img1.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.ShowCaseCE))
        img2.addGestureRecognizer(tap2)
        img2.isUserInteractionEnabled = true
        
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.LibraryCE))
        img3.addGestureRecognizer(tap3)
        img3.isUserInteractionEnabled = true
        
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.RotaryNewsCE))
        img4.addGestureRecognizer(tap4)
        img4.isUserInteractionEnabled = true
        
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.RotaryBlogsCE))
        img5.addGestureRecognizer(tap5)
        img5.isUserInteractionEnabled = true
        
    }
    
    
    func fucntionForImageSelectFromLibraryAndCamra()
    {
        var actionSheet = UIActionSheet()
        if(isCalledFRom == "edit")
        {
            //actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
             actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library")
        }
        else
        {
            //actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
             actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library")
        }
        actionSheet.delegate = self
        actionSheet.tag = 1
        actionSheet.show(in: self.view)
    }
    
    //MARK: Images Click Events
    @objc func imageTappedfirst(_ gestureRecognizer: UITapGestureRecognizer)
    {
        
        
        
        if(isCalledFRom=="edit")
        {
            print(self.muarrayForPhotoId)
            let photoId = self.muarrayForPhotoId.object(at: 0) as! String
            if(photoId == "0")
            {
                print("111111111111111111111111111111111111----------",photoId)
                varWhichImageClickOnTap = "11"
                //fucntionForImageSelectFromLibraryAndCamra()
            }
            else
            {
                print("111 Image")
                varWhichImageClickOnTap = "111"
                //fucntionForImageSelectFromLibraryAndCamra()
            }
            
        }
        else
        {
            varWhichImageClickOnTap = "1"
        }
        
        
        
        let tappedImageView = gestureRecognizer.view!
        var actionSheet = UIActionSheet()
        if(isCalledFRom == "edit")
        {
           // actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
            
            actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library")
        }
        else
        {
           // actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
            actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library")
        }
        actionSheet.delegate = self
        actionSheet.tag = 1
        actionSheet.show(in: self.view)
    }
    @objc func ShowCaseCE()
    {
        if(isCalledFRom=="edit")
        {
            print(self.muarrayForPhotoId)
            let photoId = self.muarrayForPhotoId.object(at: 1) as! String
            if(photoId == "0")
            {
                print("2222222222222222222222222222222222222222222----------",photoId)
                varWhichImageClickOnTap = "22"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            else
            {
                print("22222222222222222222222222=========================================",photoId)
                varWhichImageClickOnTap = "222"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            
        }
        else
        {
            
            print("Second Image")
            varWhichImageClickOnTap = "2"
            fucntionForImageSelectFromLibraryAndCamra()
            //SelectImageIndex = 1
            
        }
        
    }
    @objc func LibraryCE()
    {
        if(isCalledFRom=="edit")
        {
            print(self.muarrayForPhotoId)
            let photoId = self.muarrayForPhotoId.object(at: 2) as! String
            if(photoId == "0")
            {
                print("33333333333333333333333333333333333333----------",photoId)
                varWhichImageClickOnTap = "33"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            else
            {
                print("333333333333333========================",photoId)
                varWhichImageClickOnTap = "333"
                fucntionForImageSelectFromLibraryAndCamra()
            }
        }
        else
        {
            print("Third Image")
            varWhichImageClickOnTap = "3"
            fucntionForImageSelectFromLibraryAndCamra()
            //SelectImageIndex = 2
            
        }
        
    }
    @objc func RotaryNewsCE()
    {
        
        if(isCalledFRom=="edit")
        {
            print(self.muarrayForPhotoId)
            let photoId = self.muarrayForPhotoId.object(at: 3) as! String
            if(photoId == "0")
            {
                print("44444444444444444444444444444444444444444444----------",photoId)
                varWhichImageClickOnTap = "44"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            else
            {
                print("4444444444444444444444444444========================",photoId)
                varWhichImageClickOnTap = "444"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            
        }
        else
        {
            
            print("Fourth Image")
            varWhichImageClickOnTap = "4"
            fucntionForImageSelectFromLibraryAndCamra()
            //SelectImageIndex = 3
            
        }
        
    }
    @objc func RotaryBlogsCE()
    {
        
        
        if(isCalledFRom=="edit")
        {
            print(self.muarrayForPhotoId)
            let photoId = self.muarrayForPhotoId.object(at: 4) as! String
            if(photoId == "0")
            {
                print("555555555555555555555555555555555555555----------",photoId)
                varWhichImageClickOnTap = "55"
                fucntionForImageSelectFromLibraryAndCamra()
            }
            else
            {
                print("5555555555555555555========================",photoId)
                varWhichImageClickOnTap = "555"
                fucntionForImageSelectFromLibraryAndCamra()
            }
        }
        else
        {
            print("Fifth Image")
            varWhichImageClickOnTap = "5"
            fucntionForImageSelectFromLibraryAndCamra()
        }
    }
    
    func functionGetAllImageDescDetailsFromBackController()
    {
        muarrayForPhotoId = NSMutableArray()
        for k in 0..<self.muarrayMainList.count
        {
            let photo = (self.muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: k) as! String
            muarrayForPhotoId.add(photo)
        }
        for j in self.muarrayMainList.count..<5
        {
            muarrayForPhotoId.add("0")
        }
        print("============================================",self.muarrayMainList.count)
        print("============================================",self.muarrayForPhotoId.count)
        
        
        for i in 0..<self.muarrayMainList.count
        {
            
            if(i==0)
            {
                let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                let descriptions = (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
                let photoId = (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
                
                if imgUrl == ""
                {
                    
                    img1.image = UIImage(named: "")
                    img1.isHidden=true
                    img1Desc.text = nil
                    placeholderImgDesc1.isHidden = false
                    muarrayForPhotoId.replaceObject(at: 0, with: "0")
                    
                    
                }
                else
                {
                    muarrayForPhotoId.replaceObject(at: 0, with: photoId)
                    placeholderImgDesc1.isHidden = true
                    img1Desc.text = descriptions
                    img1.isHidden=false
                    let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    img1.sd_setImage(with: checkedUrl)
                }
                
                print("************---------------------Image 1------------------",imgUrl,description,photoId)
            }
            else if(i==1)
            {
                let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                let descriptions = (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
                let photoId = (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
                
                if imgUrl == ""
                {
                    imgPlaceholderImage2.isHidden=false
                    muarrayForPhotoId.replaceObject(at: 1, with: "0")
                    placeholderImgDesc2.isHidden = false
                    img2.image = UIImage(named: "")
                    img2.isHidden=true
                    img2Desc.text = nil
                }
                else
                {
                    imgPlaceholderImage2.isHidden=true
                    muarrayForPhotoId.replaceObject(at: 1, with: photoId)
                    placeholderImgDesc2.isHidden = true
                    img2Desc.text = descriptions
                    img2.isHidden=false
                    let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    img2.sd_setImage(with: checkedUrl)
                }
                print("************---------------------Image 2------------------",imgUrl,description,photoId)
            }
            else if(i==2)
            {
                let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                let descriptions = (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
                let photoId = (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
                
                
                if imgUrl == ""
                {
                    imgPlaceholderImage3.isHidden=false
                    muarrayForPhotoId.replaceObject(at: 2, with: "0")
                    placeholderImgDesc3.isHidden = false
                    img3.image = UIImage(named: "")
                    img3.isHidden=true
                    img3Desc.text = nil
                }
                else
                {
                    imgPlaceholderImage3.isHidden=true
                    placeholderImgDesc3.isHidden = true
                    muarrayForPhotoId.replaceObject(at: 2, with: photoId)
                    img3Desc.text = descriptions
                    img3.isHidden=false
                    let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    img3.sd_setImage(with: checkedUrl)
                }
                
                print("************---------------------Image 3------------------",imgUrl,description,photoId)
                
            }
            else if(i==3)
            {
                let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                let descriptions = (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
                let photoId = (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
                
                if imgUrl == ""
                {
                    muarrayForPhotoId.replaceObject(at: 3, with: "0")
                    imgPlaceholderImage4.isHidden=false
                    placeholderImgDesc4.isHidden = false
                    img4.image = UIImage(named: "")
                    img4.isHidden=true
                    img4Desc.text = nil
                }
                else
                {
                    muarrayForPhotoId.replaceObject(at: 3, with: photoId)
                    placeholderImgDesc4.isHidden = true
                    imgPlaceholderImage4.isHidden=true
                    img4Desc.text = descriptions
                    img4.isHidden=false
                    let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    img4.sd_setImage(with: checkedUrl)
                }
                
                print("************---------------------Image 4------------------",imgUrl,description,photoId)
            }
            else if(i==4)
            {
                let imgUrl = (muarrayMainList.value(forKey: "url") as AnyObject).object(at: i) as! String
                let descriptions = (muarrayMainList.value(forKey: "description") as AnyObject).object(at: i) as! String
                let photoId = (muarrayMainList.value(forKey: "photoId") as AnyObject).object(at: i) as! String
                
                if imgUrl == ""
                {
                    imgPlaceholderImage5.isHidden=false
                    muarrayForPhotoId.replaceObject(at: 4, with: "0")
                    placeholderImgDesc5.isHidden = false
                    img5.image = UIImage(named: "")
                    img5.isHidden=true
                    img5Desc.text = nil
                }
                else
                {
                    
                    muarrayForPhotoId.replaceObject(at: 4, with: photoId)
                    placeholderImgDesc5.isHidden = true
                    imgPlaceholderImage5.isHidden=true
                    img5Desc.text = descriptions
                    img5.isHidden=false
                    let ImageProfilePic:String = imgUrl.replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    img5.sd_setImage(with: checkedUrl)
                }
                
                print("************---------------------Image 5------------------",imgUrl,description,photoId)
            }
            
        }
        
    }
    
    
    
    
    
    func functionShowFirstImageSelection()
    {
        
        
        btnDeleteImg2.isHidden=false
        btnDeleteImg3.isHidden=false
        btnDeleteImg4.isHidden=false
        btnDeleteImg5.isHidden=false
        
        
        
        
        
        //img1Desc.hidden=true
        img2Desc.isHidden=false
        img3Desc.isHidden=false
        img4Desc.isHidden=false
        img5Desc.isHidden=false
        
        img2.isHidden=false
        img3.isHidden=false
        img4.isHidden=false
        img5.isHidden=false
        
        
        img2.isUserInteractionEnabled=true
        img3.isUserInteractionEnabled=true
        img4.isUserInteractionEnabled=true
        img5.isUserInteractionEnabled=true
        
        
        placeholderImgDesc5.isHidden=false
        placeholderImgDesc4.isHidden=false
        placeholderImgDesc3.isHidden=false
        placeholderImgDesc2.isHidden=false
        
        
        img2Desc.isUserInteractionEnabled=true
        img3Desc.isUserInteractionEnabled=true
        img4Desc.isUserInteractionEnabled=true
        img5Desc.isUserInteractionEnabled=true
        
        
        
       
        
        imgPlaceholderImage2.isHidden=false
        imgPlaceholderImage3.isHidden=false
        imgPlaceholderImage4.isHidden=false
        imgPlaceholderImage5.isHidden=false
        
        
        
        uncderLineSecondImgBottom5.isHidden=false
        uncderLineSecondImgBottom4.isHidden=false
        uncderLineSecondImgBottom3.isHidden=false
        uncderLineSecondImgBottom2.isHidden=false
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
    }
    //When You Not Select First Cover Image Not Other Image Option show
    func functionHideFirstImageSelectionNot()
    {
        
        
        
        btnDeleteImg2.isHidden=true
        btnDeleteImg3.isHidden=true
        btnDeleteImg4.isHidden=true
        btnDeleteImg5.isHidden=true
        
        //img1Desc.hidden=true
        img2Desc.isHidden=true
        img3Desc.isHidden=true
        img4Desc.isHidden=true
        img5Desc.isHidden=true
        
        img2.isHidden=true
        img3.isHidden=true
        img4.isHidden=true
        img5.isHidden=true
        
        
        img2.isUserInteractionEnabled=false
        img3.isUserInteractionEnabled=false
        img4.isUserInteractionEnabled=false
        img5.isUserInteractionEnabled=false
        
        
        placeholderImgDesc5.isHidden=true
        placeholderImgDesc4.isHidden=true
        placeholderImgDesc3.isHidden=true
        placeholderImgDesc2.isHidden=true
        
        
        img2Desc.isUserInteractionEnabled=false
        img3Desc.isUserInteractionEnabled=false
        img4Desc.isUserInteractionEnabled=false
        img5Desc.isUserInteractionEnabled=false
        
        
        
        //imgPlaceholderImage1.isHidden=true
        imgPlaceholderImage2.isHidden=true
        imgPlaceholderImage3.isHidden=true
        imgPlaceholderImage4.isHidden=true
        imgPlaceholderImage5.isHidden=true
        
        
        
        uncderLineSecondImgBottom5.isHidden=true
        uncderLineSecondImgBottom4.isHidden=true
        uncderLineSecondImgBottom3.isHidden=true
        uncderLineSecondImgBottom2.isHidden=true
    }
    
    //MARK:-viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        datePickers.setStyle()
        img1Desc.delegate = self
        img2Desc.delegate = self
        img3Desc.delegate = self
        img4Desc.delegate = self
        img5Desc.delegate = self
        textViewDescription.delegate=self
        btnDeleteImg1.isHidden=true
        muarrayForMultipleImageUrlStore=NSMutableArray()
        muarrayForMultipleImageUrlStore.add("0")
        muarrayForMultipleImageUrlStore.add("0")
        muarrayForMultipleImageUrlStore.add("0")
        muarrayForMultipleImageUrlStore.add("0")
        muarrayForMultipleImageUrlStore.add("0")
        
        imgPlaceholderImage1.layer.borderWidth = 1.0
        imgPlaceholderImage1.layer.borderColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor
        imgPlaceholderImage2.layer.borderWidth = 1.0
        imgPlaceholderImage2.layer.borderColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor
        imgPlaceholderImage3.layer.borderWidth = 1.0
        imgPlaceholderImage3.layer.borderColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor
        imgPlaceholderImage4.layer.borderWidth = 1.0
        imgPlaceholderImage4.layer.borderColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor
        imgPlaceholderImage5.layer.borderWidth = 1.0
        imgPlaceholderImage5.layer.borderColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor
        
        
        
        
        
        
        
        
        
        
        
        
        
        img1Desc.setTextViewFullBorder()
        img2Desc.setTextViewFullBorder()
        img3Desc.setTextViewFullBorder()
        img4Desc.setTextViewFullBorder()
        img5Desc.setTextViewFullBorder()
        textViewDescription.setTextViewFullBorder()
        
        
        
        
        placeholderImgDesc1.text = "Enter Description Here"
        placeholderImgDesc1.textColor = UIColor.lightGray
        img1Desc.addSubview(placeholderImgDesc1)
        placeholderImgDesc1.frame.origin = CGPoint(x: 5, y: img1Desc.font!.pointSize / 2)
        placeholderImgDesc1.textColor = UIColor(white: 0, alpha: 0.3)
        
        
        
        
        placeholderImgDesc2.text = "Enter Description Here"
        placeholderImgDesc2.textColor = UIColor.lightGray
        img2Desc.addSubview(placeholderImgDesc2)
        placeholderImgDesc2.frame.origin = CGPoint(x: 5, y: img2Desc.font!.pointSize / 2)
        placeholderImgDesc2.textColor = UIColor(white: 0, alpha: 0.3)
        
        
        
        
        placeholderImgDesc3.text = "Enter Description Here"
        placeholderImgDesc3.textColor = UIColor.lightGray
        img3Desc.addSubview(placeholderImgDesc3)
        placeholderImgDesc3.frame.origin = CGPoint(x: 5, y: img3Desc.font!.pointSize / 2)
        placeholderImgDesc3.textColor = UIColor(white: 0, alpha: 0.3)
        
        
        
        placeholderImgDesc4.text = "Enter Description Here"
        placeholderImgDesc4.textColor = UIColor.lightGray
        img4Desc.addSubview(placeholderImgDesc4)
        placeholderImgDesc4.frame.origin = CGPoint(x: 5, y: img4Desc.font!.pointSize / 2)
        placeholderImgDesc4.textColor = UIColor(white: 0, alpha: 0.3)
        
        
        
        placeholderImgDesc5.text = "Enter Description Here"
        placeholderImgDesc5.textColor = UIColor.lightGray
        img5Desc.addSubview(placeholderImgDesc5)
        placeholderImgDesc5.frame.origin = CGPoint(x: 5, y: img5Desc.font!.pointSize / 2)
        placeholderImgDesc5.textColor = UIColor(white: 0, alpha: 0.3)
        
        
        
        //TextViewPlaceHolder
        
        if(isCalledFRom=="edit")
        {
            self.imgPlaceholderImage1.isHidden=true
            //            if(self.muarrayMainList.count>0)
            //            {
            //functionGetAllImageDescDetailsFromBackController()
            functionShowFirstImageSelection()
            functionForFetchingAlbumPhotosListData()
            
            // }
        }
        else
        {
            
            img1Desc.text = nil
            img2Desc.text = nil
            img3Desc.text = nil
            img4Desc.text = nil
            img5Desc.text = nil
            functionHideFirstImageSelectionNot()
            
            
        }
        
        functionForAddImageSelectionClickEvent()
        
        
        
        
        
        
        
        
        lbHeadingRecipientType.isHidden=true
        buttonMembersAnnounce.isHidden=true
        buttonSubGroupAnnounce.isHidden=true
        buttonAllAnnounce.isHidden=true
        buttonEditAllGroupMember.isHidden=true
        labelYouHaveAddedGroupsAndMember.isHidden=true
        
        if(isCategory=="2")
        {
            lblContentposted.text! = "In District Event, post your  District's internal events.In District Project post all projects. The content posted in District Project will be displayed to all ROW users globally."
        }
        else
        {
            lblContentposted.text! = "In Club service, post your  Club’s internal events.In Rotary Service post all projects. The content posted in Rotary Service will be displayed to all ROW users globally."
        }
        if(isCalledFRom=="edit")
        {
            
        }
        else
        {
            selectPublicOrPrivate="Private"
        }
        
        clubY = viewOneForRotaryService.frame.origin.y
        RotaryY = viewTwoForClubService.frame.origin.y
        viewOneForRotaryService.isHidden=true
        lblContentposted.isHidden=false
        imgUnderLine1.isHidden=false
        viewTwoForClubService.frame = CGRect(x: 0, y: clubY+70, width: viewTwoForClubService.frame.size.width, height: viewTwoForClubService.frame.size.height)
        
        viewTwoForClubService.backgroundColor = UIColor.white
        viewOneForRotaryService.backgroundColor = UIColor.white
        
        if(isCalledFRom=="edit")
        {
            myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
        }
        else
        
        {
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        }
        
        
        addDoneButtonOnKeyboard()
        
        //datePickers.backgroundColor = UIColor.whiteColor()
        // datePickers.hidden = true
        textfieldManHourTypeHourYearMonth.text = "Hours"
        textfieldManHourTypeHourYearMonth.isUserInteractionEnabled=true
        
        varCustomViewReloadOrNot = "Not"
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.NotificationIdentifierForGettingValue(_:)), name:NSNotification.Name(rawValue: "NotificationIdentifierForGettingValue"), object: nil)
        
        muarrayDollerRupee = ["₹","$"]
        muarrayForMANSpendTypeHoursMonth = ["Hours","days","Months","Years"]
        
        viewPickerCategory.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        viewForManHoursSpendPicker.isHidden=true
        pickerHourDayMonth.isHidden=true
        
        pickerViewRupeeDoller.delegate=self
        pickerViewRupeeDoller.dataSource=self
        pickerViewCategoryList.delegate=self
        pickerViewCategoryList.dataSource=self
        pickerHourDayMonth.delegate=self
        pickerHourDayMonth.dataSource=self
        
        let lineView:UIView=UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1)
        lineView.backgroundColor = UIColor.lightGray
        buttonAdd.addSubview(lineView)
        let lineView1:UIView=UIView()
        lineView1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1)
        lineView1.backgroundColor = UIColor.lightGray
        buttonCancel.addSubview(lineView1)
        buttonCancel.tintColor = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1)
        buttonCancel.setTitleColor(UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1),  for: UIControl.State.normal)
        
        //        if isCategory=="2"
        //        {
        //            self.buttonPublic.userInteractionEnabled = false
        //            self.buttonWithInTheClub.userInteractionEnabled = false
        //            buttonWithInTheClub.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //            buttonPublic.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        //        }
        //        else
        //        {
        //
        //        buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"), forState: UIControl.State.Normal)
        //        }
        
        
        
        if isCategory=="2"
        {
            buttonPublic.setTitle("District Project",  for: UIControl.State.normal)
            buttonWithInTheClub.setTitle("District Event",  for: UIControl.State.normal)
        }
        else
        {
            buttonPublic.setTitle("Rotary Service",  for: UIControl.State.normal)
            buttonWithInTheClub.setTitle("Club Service",  for: UIControl.State.normal)
        }
        
        
        
        buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        createNavigationBar()
        textfieldTitle.delegate = self
        functionForTextfieldButtonScrollViewTableSetting()
        
        
        if(isCalledFRom == "edit")
        {
            varIsPublicOrWithInClub=self.GetShareTypes
            buttonAdd.setTitle("Update",  for: UIControl.State.normal)
            functionForFetchingAlbumListData()
        }
        else if(isCalledFRom == "add")
        {
            varIsPublicOrWithInClub="0"
            varAlbumID = "0"
            buttonAdd.setTitle("Add",  for: UIControl.State.normal)
        }
        
        // labelYouHaveAddedGroupsAndMember.textColor =  UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lbHeadingRecipientType.LabelColor()                 // .textColor =      UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingTitle.LabelColor()                        // =       UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingPhoto.LabelColor()                        // =        UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        lblHeadingDescription.LabelColor()
        labelYouHaveAddedGroupsAndMember.LabelColor()       // =       UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        functionTextfieldSetting()
        fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
        
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddPhotoViewController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        
        
        textfieldCategory1.inputAccessoryView=doneToolbar
        textfieldCategory2.inputAccessoryView=doneToolbar
        textfieldBaneficiary.inputAccessoryView=doneToolbar
        textfieldRupeeSelect.inputAccessoryView=doneToolbar
        textfieldCostofProject.inputAccessoryView=doneToolbar
        textfieldDateofProject.inputAccessoryView=doneToolbar
        textfieldManHoursSpent.inputAccessoryView=doneToolbar
        textfieldNumberOfRotarians.inputAccessoryView=doneToolbar
        textfieldManHourTypeHourYearMonth.inputAccessoryView=doneToolbar
        textViewDescription.inputAccessoryView=doneToolbar
        textfieldTitle.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        
        self.view.endEditing(true)
    }
    
    var customView:SimpleCustomView!
    
    var varCustomViewReloadOrNot:String! = ""
    
    @IBOutlet weak var buttonOpacity: UIButton!
    
    func textFieldSelectPublishDateAndTime()
        
    {
        
        
        buttonOpticity.isHidden=false
        varCustomViewReloadOrNot = "Yes"
        self.customView =  SimpleCustomView(frame: CGRect(x: 0,y: 0, width: 320, height: 568))
        customView.center = view.center;
        self.view.addSubview(self.customView!)
        self.customView.lblTitleText = "Date";
        varWhichClicked="PSD"
        
    }
    
    @objc func NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect(_ notification: Notification)
        
    {
        self.customView.removeFromSuperview()
        buttonOpticity.isHidden=true
    }
    
    @objc func NotificationIdentifierForGettingValue(_ notification: Notification)
        
    {
        self.customView.removeFromSuperview()
        let userInfo = notification.userInfo!
        let index = userInfo.index(userInfo.startIndex, offsetBy: 0) // index 1
        print(userInfo.keys[index])
        var dictValue:NSDictionary = NSDictionary()
        dictValue = userInfo as NSDictionary
        print(dictValue.value(forKey: "varUserFullNameFB") as! String)
        textfieldDateofProject.text! = dictValue.value(forKey: "varUserFullNameFB") as! String
        buttonOpticity.isHidden=true
        
        
        
    }
    
    func functionForCurrentDate()
        
    {
        
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let currentdate = formatter.string(from: date)
        let varGetCellDateSelected = currentdate //+":00"+" +0000"
        currentdateForPSDMatch = varGetCellDateSelected
        print(varGetCellDateSelected)
        
    }
    var currentdateForPSDMatch :String = ""
     @objc func backClicked()
        
    {
        
        if(varCustomViewReloadOrNot == "Not")
        {
        }
        else
        {
            self.customView.removeFromSuperview()
        }
        print("call web api for adding this form value !!!!!")
        
        
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    var varWhichClicked:String!="0"
    
    
    //MARK:- ViewDidAppear
    override func viewDidAppear(_ animated: Bool)
    {
        //self.buttonEditAllGroupMember.hidden = true
        //functionForAllGroupMemberSetting()
    }
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        // buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check1"), forState: UIControl.State.Normal)
        // buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"), forState: UIControl.State.Normal)
        // buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"), forState: UIControl.State.Normal)
        varSubGrouporMember=0
        
    }
    //MARK:- Textfield Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textfieldTitle.resignFirstResponder()
        return true
    }
    func functionForAllGroupMemberSetting()
    {
        let defaults = UserDefaults.standard
        let tabledata =  defaults.array(forKey: "profID")
        let tabledata1 = UserDefaults.standard.array(forKey: "groupsID")
        if tabledata?.count > 0
        {
            print(tabledata)
            print(tabledata!.count)
            let array = tabledata! as NSArray
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            labelYouHaveAddedGroupsAndMember.isHidden = false
            if count == 1
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
            }
            else
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
            }
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            varSubGrouporMember=2
            print("This  value should be-------->",varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else if tabledata1?.count > 0
        {
            print(tabledata1)
            print(tabledata1!.count)
            let array = tabledata1! as NSArray
            count = array.count
            commonIDString = array.componentsJoined(by: ",")
            print(commonIDString)
            labelYouHaveAddedGroupsAndMember.isHidden = false
            if count == 1
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
            }
            else
            {
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
            }
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
            varSubGrouporMember=1
            print("This  value should be-------->",varSubGrouporMember)
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else
        {
        }
        print("This is value:-------->>",varSubGrouporMember)
        /*----------------------------------------------------------------------------------*/
        if(commonIDString=="")
        {
            buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
            buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            commonIDString=""
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        else
        {
            UserDefaults.standard.set("", forKey: "profID")
            UserDefaults.standard.set("", forKey: "groupsID")
        }
        /*-----------------------------------------------------------------------------------------------------------*/
        let varGetValue:String! =  UserDefaults.standard.value(forKey: "session_IsComingFromPop") as! String
        if(varGetValue=="yes")
        {
        }
        else
        {
            var varGetNewLabelValue:String?=labelYouHaveAddedGroupsAndMember.text
            print(varGetNewLabelValue)
            let string = labelYouHaveAddedGroupsAndMember.text
            if(varGetNewLabelValue!.characters.count<=0)
            {
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = ""
                buttonEditAllGroupMember.isHidden = true
                varSubGrouporMember=0
                annTypeStr="0"
                selectRecipientTypeEditMode = "All"
                
                
                
                
            }
            else  if string!.range(of: "groups") != nil
            {
                
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" groups"
                selectRecipientTypeEditMode = "Group"
                buttonEditAllGroupMember.isHidden = false
                varSubGrouporMember=1
                annTypeStr="1"
                
                if self.isCategory=="2"
                {
                }
                else
                {
                    
                    
                    buttonPublic.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
                    buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
                    varIsPublicOrWithInClub="0"
                    buttonPublic.isUserInteractionEnabled = false
                    buttonWithInTheClub.isUserInteractionEnabled=false
                    
                }
            }
            else  if string!.range(of: "members") != nil
            {
                
                buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
                buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
                labelYouHaveAddedGroupsAndMember.text = "You have added "+String(count)+" members"
                selectRecipientTypeEditMode = "Member"
                buttonEditAllGroupMember.isHidden = false
                
                if self.isCategory=="2"
                {
                }
                else
                {
                    
                    buttonPublic.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
                    buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
                    varIsPublicOrWithInClub="0"
                    buttonPublic.isUserInteractionEnabled = false
                    buttonWithInTheClub.isUserInteractionEnabled=false
                }
                varSubGrouporMember=2
                annTypeStr="2"
            }
        }
    }
    
    
    //MARK:- Button Action
    /*-----------------------------------------------------------Button Actions-------------------------------------Start---------------------------*/
    @IBAction func buttonAllAnnounceClickEvent(_ sender: AnyObject)
    {
        
        
        if self.isCategory=="2"
        {
        }
        else
        {
            
            buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
            buttonPublic.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
            varIsPublicOrWithInClub="0"
            buttonPublic.isUserInteractionEnabled = true
            buttonWithInTheClub.isUserInteractionEnabled = true
        }
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        labelYouHaveAddedGroupsAndMember.isHidden = true
        //editButton.hidden = true
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        commonIDString=""
        labelYouHaveAddedGroupsAndMember.text=""
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonEditAllGroupMember.isHidden = true
        varSubGrouporMember=0
        self.annTypeStr="0"
    }
    
    func functionForButtonSubGroupClickEvent()
    {
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        print("Groups")
        UserDefaults.standard.set("", forKey: "profID")
        let SubGroupController = self.storyboard?.instantiateViewController(withIdentifier: "sub_group1") as! SubGroupListController
        SubGroupController.groupIDX = grpID
        SubGroupController.isCalledFrom="add"
        if(varSubGrouporMember==0 || varSubGrouporMember==1)
        {
            if(commonIDString == "")
            {
                SubGroupController.groupIdsArray=NSMutableArray()
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                SubGroupController.groupIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
            }
        }
        else
        {
            SubGroupController.groupIdsArray=NSMutableArray()
        }
        self.navigationController?.pushViewController(SubGroupController, animated: true)
    }
    
    @IBAction func buttonSubGroupAnnounceClickEvent(_ sender: AnyObject)
    {
        functionForButtonSubGroupClickEvent()
    }
    func functionForButtonMemberClickEvent()
    {
        buttonAllAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonSubGroupAnnounce.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonMembersAnnounce.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        print("membersANN")
        UserDefaults.standard.set("", forKey: "groupsID")
        let MembersController = self.storyboard?.instantiateViewController(withIdentifier: "edit_directory") as! EditDirectoryController
        MembersController.groupIDX = grpID
        print("ggggggggggggggggggggggg",grpID)
        print(isCalledFRom)
        if(varSubGrouporMember==0 || varSubGrouporMember==2)
        {
            if(commonIDString == "")
            {
                MembersController.profileIdsArray=NSMutableArray()
                MembersController.isCalledFRom="add"
            }
            else
            {
                let pointsArr = commonIDString.components(separatedBy: ",")
                print("commonstr \(commonIDString)")
                MembersController.profileIdsArray=NSMutableArray(array: pointsArr).mutableCopy() as! NSMutableArray
                MembersController.isCalledFRom="edit"
            }
        }
        else
        {
            MembersController.profileIdsArray=NSMutableArray()
            MembersController.isCalledFRom="add"
        }
        self.navigationController?.pushViewController(MembersController, animated: true)
        
    }
    
    @IBAction func buttonEditAllGroupMemberClickEvent(_ sender: AnyObject)
    {
        
        if(selectRecipientTypeEditMode == "Group")
        {
            functionForButtonSubGroupClickEvent()
        }
        else if (selectRecipientTypeEditMode == "Member")
        {
            functionForButtonMemberClickEvent()
        }
        else
        {
        }
        functionForAllGroupMemberSetting()
    }
    
    @IBAction func buttonMembersAnnounceClickEvent(_ sender: AnyObject)
    {
        functionForButtonMemberClickEvent()
    }
    
    /*-------------------------------Navigation bar Setting --------------------------------Start----------------*/
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        if(isCalledFRom == "edit")
        {
            self.title="Edit Album"
        }
        else
        {
            self.title="Add Photo"
        }
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddPhotoViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    /*-------------------------------Navigation bar Setting ----------------------------------End--------------*/
    
    /*-------------------------------Image Picker Open On Image Tap & selection Process Setting ----------------Start----------------*/
    
    
    
    
    
    
    
    
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        switch (buttonIndex){
        case 0:
            print("Cancel")
            self.dismiss(animated: true, completion: nil)
        case 1:
            //shows the photo library
            self.picker!.allowsEditing = false  //------------------DPK
            self.picker!.sourceType = .photoLibrary
            //if #available(iOS 8.0, *) {
            self.picker!.modalPresentationStyle = .popover
            self.present(self.picker!, animated: true, completion: nil)
        case 2:
            openCamera()
        default:
            /*htgthghghghp://rohghghgwtesxcvxzcvtapi.rosterxcvcxzonwheels.com/V3/api//Group/DeleteByModuleName :- [typeID=1382, type=Gallery, profileID=255726]*/
            
            /*
             let wsm : WebserviceClass = WebserviceClass.sharedInstance
             wsm.delegates=nil
             wsm.delegates=self
             wsm.deleteDataWebservice(self.varAlbumID as String, type: "Gallery", profileID:self.createdByORUserIdOrProfileId)
             */
            
            self.img1.image = UIImage(named: "AddPic")
            print("Default")
        }
    }
    
    
    /*
     func deleteSucc(docListing : DeleteResult){
     
     if docListing.status == "0"
     {
     self.imageAddAlbum.image = UIImage(named: "addevent")
     self.ImsgId = ""
     }
     else
     {
     let alert=UIAlertController(title: "Rotary India", message:"Failed to DELETE, please Try Again", preferredStyle: UIAlertController.Style.Alert);
     
     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler: nil));
     //event handler with closure
     self.presentViewController(alert, animated: true, completion: nil);
     }
     
     
     }
     
     */
    
    /*-------------------Open Camera--------------------code by dpk -----------------------------------------*/
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            
            present(picker!, animated: true, completion: nil)
        }else
        {
            
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)
            
        }
    }
    /*--------------------Open Camera------------------code by dpk -----------------------------------------*/
    /*--------------------------------------------------------------------------------------------------------*/
    //MARK:- Loader Method
    /*
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
 */
    
    //MARK:- Image Picker Methods
    /*--------------------------------------------------------------------------------------------------------*/
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
    {
        var chosenImage:UIImage! //2
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            chosenImage = possibleImage
        }
        print(info)
        
        
        print(isCalledFRom)
        if(isCalledFRom=="edit")
        {
            
            
            print("Deepak")
            //EDIT TIME NO IMAGE AVAILABLE
            if(varWhichImageClickOnTap == "11")
            {
                print("First Time Image Add  11")
                self.img1.contentMode = .scaleAspectFit
                img1.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 0, with: "1")
                self.imgPlaceholderImage1.isHidden=true
            }
            else if(varWhichImageClickOnTap == "22")
            {
                print("First Time Image Add  22")
                self.img2.contentMode = .scaleAspectFit
                img2.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 1, with: "1")
                self.imgPlaceholderImage2.isHidden=true
            }
            else if(varWhichImageClickOnTap == "33")
            {
                print("First Time Image Add  33")
                self.img3.contentMode = .scaleAspectFit
                img3.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 2, with: "1")
                self.imgPlaceholderImage3.isHidden=true
            }
            else if(varWhichImageClickOnTap == "44")
            {
                print("First Time Image Add  44")
                self.img4.contentMode = .scaleAspectFit
                img4.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 3, with: "1")
                self.imgPlaceholderImage4.isHidden=true
            }
            else if(varWhichImageClickOnTap == "55")
            {
                print("First Time Image Add  55")
                self.img5.contentMode = .scaleAspectFit
                img5.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 4, with: "1")
                self.imgPlaceholderImage5.isHidden=true
            }
                //UPDATE IMAGE IF ALREADY EXIST
            else if(varWhichImageClickOnTap == "111")
            {
                print("First Time Image Add  111")
                self.img1.contentMode = .scaleAspectFit
                img1.image=chosenImage
                self.imgPlaceholderImage1.isHidden=true
                
            }
            else if(varWhichImageClickOnTap == "222")
            {
                print("First Time Image Add  222")
                self.img2.contentMode = .scaleAspectFit
                img2.image=chosenImage
                self.imgPlaceholderImage2.isHidden=true
            }
            else if(varWhichImageClickOnTap == "333")
            {
                print("First Time Image Add  333")
                self.img3.contentMode = .scaleAspectFit
                img3.image=chosenImage
                self.imgPlaceholderImage3.isHidden=true
            }
            else if(varWhichImageClickOnTap == "444")
            {
                print("First Time Image Add  444")
                self.img4.contentMode = .scaleAspectFit
                img4.image=chosenImage
                self.imgPlaceholderImage4.isHidden=true
            }
            else if(varWhichImageClickOnTap == "555")
            {
                print("First Time Image Add  555")
                self.img5.contentMode = .scaleAspectFit
                img5.image=chosenImage
                self.imgPlaceholderImage5.isHidden=true
            }
            else
            {
            }
            
            
            
        }
        else
        {
            
            print("Patidar")
            if(varWhichImageClickOnTap == "1")
            {
                print("First Time Image Add Of Cover And Image First")
                self.img1.contentMode = .scaleAspectFit
                img1.image=chosenImage
                functionForImageUpload()
                muarrayForMultipleImageUrlStore.replaceObject(at: 0, with: "1")
                self.imgPlaceholderImage1.isHidden=true
            }
            else if(varWhichImageClickOnTap == "2")
            {
                print("First Time Image Add  Image Second")
                self.img2.contentMode = .scaleAspectFit
                img2.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 1, with: "1")
                self.imgPlaceholderImage2.isHidden=true
            }
            else if(varWhichImageClickOnTap == "3")
            {
                print("First Time Image Add  Image Third")
                self.img3.contentMode = .scaleAspectFit
                img3.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 2, with: "1")
                self.imgPlaceholderImage3.isHidden=true
            }
            else if(varWhichImageClickOnTap == "4")
            {
                print("First Time Image Add  Image Fourth")
                self.img4.contentMode = .scaleAspectFit
                img4.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 3, with: "1")
                self.imgPlaceholderImage4.isHidden=true
                
            }
            else if(varWhichImageClickOnTap == "5")
            {
                print("First Time Image Add  Image Fifth")
                self.img5.contentMode = .scaleAspectFit
                img5.image=chosenImage
                muarrayForMultipleImageUrlStore.replaceObject(at: 4, with: "1")
                self.imgPlaceholderImage5.isHidden=true
            }
            else
            {
            }
            
            
        }
        
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonAddAlbumClickEvent(_ sender: AnyObject)
    {
          if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            if(selectPublicOrPrivate=="Private")
            {
                if(textfieldTitle.text! == "")
                {
                    self.view.makeToast("Please enter Title", duration: 2, position: CSToastPositionCenter)
                }
                else if(textViewDescription.text! == "")
                {
                    self.view.makeToast("Please enter Description", duration: 2, position: CSToastPositionCenter)
                }
                else if(self.ImsgId == "")
                {
                    //self.view.makeToast("Cover photo is mandatory", duration: 2, position: CSToastPositionCenter)
                    self.view.makeToast("Please select atleast one photo", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    textfieldManHoursSpent.text = nil
                    textfieldBaneficiary.text = nil
                    textfieldCostofProject.text = nil
                    //textfieldDateofProject.text = nil
                    textfieldCategory1.text = nil
                    textfieldCategory2.text = nil
                    textfieldNumberOfRotarians.text = nil
                    varSetAlbumCategory=""
                    functionForAddUpdateAlbum()
                }
                
            }
            else
            {
                
                
                /*Project date
                 Project Cost
                 Beneficiaries
                 Man hours spent
                 No.of Rotarians involved
                 Cover Photo*/
                
                
                if(self.textfieldDateofProject.text! == "")
                {
                    self.view.makeToast("Please select Project date", duration: 2, position: CSToastPositionCenter)
                }
                else if(self.textfieldCostofProject.text! == "")
                {
                    self.view.makeToast("Please enter Project cost", duration: 2, position: CSToastPositionCenter)
                }
                    
                else if(self.textfieldBaneficiary.text! == "")
                {
                    self.view.makeToast("Please enter Direct Beneficiaries", duration: 2, position: CSToastPositionCenter)
                }
                else if(textfieldManHoursSpent.text! == "")
                {
                    self.view.makeToast("Please enter Man hours spent", duration: 2, position: CSToastPositionCenter)
                }
                else if(self.textfieldNumberOfRotarians.text! == "")
                {
                    self.view.makeToast("Please enter No.of Rotarians involved", duration: 2, position: CSToastPositionCenter)
                }
                else if(textfieldTitle.text! == "")
                {
                    self.view.makeToast("Please enter Title", duration: 2, position: CSToastPositionCenter)
                }
                else if(textViewDescription.text! == "")
                {
                    self.view.makeToast("Please enter Description", duration: 2, position: CSToastPositionCenter)
                }
                else if(self.ImsgId == "")
                {
                    self.view.makeToast("Cover photo is mandatory", duration: 2, position: CSToastPositionCenter)
                }
                else
                {
                    functionForAddUpdateAlbum()
                }
            }
        }
        else
        {
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 2, position: CSToastPositionCenter)
       
         SVProgressHUD.dismiss()
        }
    }
    
    
    
    @IBAction func buttonCancelClickEvent(_ sender: AnyObject)
    {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func dateConverter(_ dateString:String) -> String
    {//2018-06-15 14:30:00
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        
        return dateString
    }
    
    
    
    
    
    
    //
    
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
    
    //MARK:- Image Upload on Server and Get Image ID
    func functionForImageUploadFive(_ galleryidVsAlbumID:String,imageNo:Int)
    {
      //  loaderViewMethod()
        if(imageNo == 0)
        {
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            if (img1.image == nil)
            {
                
            }
            else
            {
                let varGetImage:UIImage =  self.compressImage(img1.image!)
                wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img1Desc.text!)
            }
        }
        else if(imageNo == 1)
        {
            
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            if (img2.image == nil)
            {
                
            }
            else
            {
                let varGetImage:UIImage =  self.compressImage(img2.image!)
                wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img2Desc.text!)
            }
        }
        else if(imageNo == 2)
        {
            
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            if (img3.image == nil)
            {
                
            }
            else
            {
                let varGetImage:UIImage =  self.compressImage(img3.image!)
                wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img3Desc.text!)
            }
        }
        else if(imageNo == 3)
        {
            
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            if (img4.image == nil)
            {
                
            }
            else
            {
                let varGetImage:UIImage =  self.compressImage(img4.image!)
                wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img4Desc.text!)
            }
            
        }
        else if(imageNo == 4)
        {
            
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            if (img5.image == nil)
            {
                
            }
            else
            {
                let varGetImage:UIImage =  self.compressImage(img5.image!)
                wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img5Desc.text!)
            }
            print("Hello One Two three")
        }
        
        //LastImageUpdateConfirmationYesOrNo
        
        let success = UserDefaults.standard.value(forKey: "LastImageUpdateConfirmationYesOrNo") as? String
        
        if(success=="Yes")
        {
            
            if(self.isCalledFRom=="edit")
            {
                
                
                let alert = UIAlertController(title: "Album", message: "Album updated successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                       self.backTwo()
                }));
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Album", message: "Album added successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                  self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
            }
            
          
        }
        else
        {
            
        }
        
        
        
        
        
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    
    
    func functionForUpdateAddPhoto(_ imageNo:Int , galleryidVsAlbumID:String, photoID:String)
    {
        if(imageNo == 0)
        {
            UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
            UserDefaults.standard.setValue(self.self.grpID, forKey: "session_GetGroupId")
            UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
            let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
            wsm.delegate=self
            let varGetImage:UIImage =  self.compressImage(img1.image!)
            let imageData: Data = varGetImage.jpegData(compressionQuality: 0.6)! //UIImageJPEGRepresentation(varGetImage, 0.6)!  //(varGetImage)!
            let imageSize: Int = imageData.count
            print("size of image in KB: %f ", Double(imageSize) / 1024.0)
            //wsm.MultiplePhotoSendServerInShowCase(varGetImage, param: img1Desc.text!)
            functionForImageUpload()
            wsm.multiplePhotoUpdateAddPhoto(varGetImage, param: img1Desc.text, photoID: photoID)
        }
        else if(imageNo == 1)
        {
            let photoIDss = muarrayForPhotoId.object(at: 1) as! String
            
            if(photoIDss=="0")
            {
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img2.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img2.image!)
                    wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img2Desc.text!)
                }
            }
            else if(photoIDss=="1")
            {
                
            }
            else
            {
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img2.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img2.image!)
                    //wsm.MultiplePhotoSendServerInShowCase(varGetImage, param: img2Desc.text!)
                    wsm.multiplePhotoUpdateAddPhoto(varGetImage, param: img2Desc.text, photoID: photoID)
                }
            }
            
        }
        else if(imageNo == 2)
        {
            let photoIDss = muarrayForPhotoId.object(at: 2) as! String
            if(photoIDss=="0")
            {
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img3.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img3.image!)
                    wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img3Desc.text!)
                }
            }
            else if(photoIDss=="1")
            {
                
            }
                
            else
            {
                
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img3.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img3.image!)
                    //wsm.MultiplePhotoSendServerInShowCase(varGetImage, param: img3Desc.text!)
                    wsm.multiplePhotoUpdateAddPhoto(varGetImage, param: img3Desc.text, photoID: photoID)
                }
            }
        }
        else if(imageNo == 3)
        {
            let photoIDss = muarrayForPhotoId.object(at: 3) as! String
            if(photoIDss=="0")
            {
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img4.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img4.image!)
                    wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img4Desc.text!)
                }
            }
            else if(photoIDss=="1")
            {
                
            }
            else
            {
                
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img4.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img4.image!)
                    // wsm.MultiplePhotoSendServerInShowCase(varGetImage, param: img4Desc.text!)
                    wsm.multiplePhotoUpdateAddPhoto(varGetImage, param: img4Desc.text, photoID: photoID)
                }
                
            }
            
        }
        else if(imageNo == 4)
        {
            let photoIDss = muarrayForPhotoId.object(at: 4) as! String
            if(photoIDss=="0")
            {
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img5.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img5.image!)
                    wsm.multiplePhotoSendServer(inShowCase: varGetImage, param: img5Desc.text!)
                }
            }
            else if(photoIDss=="1")
            {
                
            }
            else
            {
                
                UserDefaults.standard.setValue(self.createdByORUserIdOrProfileId, forKey: "session_createdByORUserIdOrProfileId")
                UserDefaults.standard.setValue(self.grpID, forKey: "session_GetGroupId")
                UserDefaults.standard.setValue(galleryidVsAlbumID, forKey: "session_AlbumID")
                let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
                wsm.delegate=self
                if (img5.image == nil)
                {
                    
                }
                else
                {
                    let varGetImage:UIImage =  self.compressImage(img5.image!)
                    // wsm.MultiplePhotoSendServerInShowCase(varGetImage, param: img5Desc.text!)
                    wsm.multiplePhotoUpdateAddPhoto(varGetImage, param: img5Desc.text!, photoID: photoID)
                }
                
            }
        }
        
        
    }
    
    
    
    
    /*--------------------------------------------------------------------------------------------------------*/
    
    
    
    
    
    
    
    
    func functionForTextfieldButtonScrollViewTableSetting()
    {
        
        //scrollview setting
        myScrollView.delegate = self
        if(isCalledFRom=="edit")
        {
            myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
        }
        else{
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        }
        
        //button
        buttonOpticity.isHidden = true
        buttonEditAllGroupMember.isHidden = true
        //Picker
        picker?.delegate = self
        //MARK:-Textfield setting
        textfieldTitle.delegate = self
        // textfieldTitle.functionTextFieldFullBorder()
        //textViewDescription.functionTextViewFullBorder()
        
        /*----------------textViewDescription placeholder setting------------------------------------------*/
        textViewDescription.delegate = self
        textViewDescription.text = nil
        labelPlaceHolder.text = "Enter Description Here"
        labelPlaceHolder.textColor = UIColor.lightGray
        textViewDescription.addSubview(labelPlaceHolder)
        labelPlaceHolder.frame.origin = CGPoint(x: 5, y: textViewDescription.font!.pointSize / 2)
        labelPlaceHolder.textColor = UIColor(white: 0, alpha: 0.3)
        textfieldTitle.attributedPlaceholder = NSAttributedString(string:"Enter Title",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    //MARK:- Placehoder in textview
    /*------------------------------placeholder --------------------------------------End----------------*/
    
    func textViewDidChange(_ textView: UITextView) {
        
        if(textView==textViewDescription)
        {
            labelPlaceHolder.isHidden = !textView.text.isEmpty
        }
        else  if(textView==img1Desc)
        {
            placeholderImgDesc1.isHidden = !textView.text.isEmpty
        }
        else  if(textView==img2Desc)
        {
            placeholderImgDesc2.isHidden = !textView.text.isEmpty
        }
        else  if(textView==img3Desc)
        {
            placeholderImgDesc3.isHidden = !textView.text.isEmpty
        }
        else  if(textView==img4Desc)
        {
            placeholderImgDesc4.isHidden = !textView.text.isEmpty
        }
        else  if(textView==img5Desc)
        {
            placeholderImgDesc5.isHidden = !textView.text.isEmpty
        }
        
        
        print("dfsdfsdfsdfdsfdsfsdfsdfsd==========================")
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        // handling code
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView==textViewDescription)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                textViewDescription.text!  = textViewDescription.text! + "\n"
                return false
            }
            return true
        }
        else  if(textView==img1Desc)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                img1Desc.text!  = img1Desc.text! + "\n"
                return false
            }
            return true
        }
        else  if(textView==img2Desc)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                img2Desc.text!  = img2Desc.text! + "\n"
                return false
            }
            return true
        }
        else  if(textView==img3Desc)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                img3Desc.text!  = img3Desc.text! + "\n"
                return false
            }
            return true
        }
        else  if(textView==img4Desc)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                img4Desc.text!  = img4Desc.text! + "\n"
                return false
            }
            return true
        }
        else  if(textView==img5Desc)
        {
            if text == "\n"  // Recognizes enter key in keyboard
            {
                img5Desc.text!  = img5Desc.text! + "\n"
                return false
            }
            return true
        }
        
        return true
    }
    /*------------------------------placeholder--------------------------------------End----------------*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func WithinClubSharing()
    {
        buttonPublic.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        varIsPublicOrWithInClub="0"
        print("Select Within the Club Service",varIsPublicOrWithInClub)
        print("Select Within the District Event",varIsPublicOrWithInClub)
        
        
        
        selectPublicOrPrivate = "Private"
        imgUnderLine1.isHidden=false
        if(isCalledFRom=="edit")
        {
            myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
        }
        else
        {
            if(self.ImsgId != "")
            {
              myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
            }
            else
            {
        myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            }
       
        }
        viewOneForRotaryService.isHidden=true
        lblContentposted.isHidden=false
        viewTwoForClubService.frame = CGRect(x: 0, y: clubY+70, width: viewTwoForClubService.frame.size.width, height: viewTwoForClubService.frame.size.height)
        
        
    }
    
    func PublicShare()
    {
        buttonWithInTheClub.setImage(UIImage(named: "radio_btn_Uncheck1"),  for: UIControl.State.normal)
        buttonPublic.setImage(UIImage(named: "radio_btn_Check1"),  for: UIControl.State.normal)
        varIsPublicOrWithInClub="1"
        print("Select Rotary Service",varIsPublicOrWithInClub)
        print("Select District Project",varIsPublicOrWithInClub)
        
        
        selectPublicOrPrivate = "Public"
        imgUnderLine1.isHidden=true
      
            myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2800)
       
        
        
        lblContentposted.isHidden=true
        viewOneForRotaryService.isHidden=false
        viewTwoForClubService.frame = CGRect(x: 0, y: clubY+viewOneForRotaryService.frame.size.height, width: viewTwoForClubService.frame.size.width, height: viewTwoForClubService.frame.size.height)
        
    }
    @IBAction func buttonWithinTheClubClickEvent(_ sender: AnyObject)
    {
        WithinClubSharing()
    }
    
    @IBAction func buttonPublicClickEvent(_ sender: AnyObject)
    {
        PublicShare()
    }
    
    
    
    //MARK:- Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView==pickerViewCategoryList)
        {
            return muarrayForCategoryListWithOutZeroIndex.count;
        }
        else if(pickerView==pickerViewRupeeDoller)
        {
            return muarrayDollerRupee.count
        }
        else if(pickerView==pickerHourDayMonth)
        {
            return muarrayForMANSpendTypeHoursMonth.count
        }
        else
        {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(pickerView==pickerViewCategoryList)
        {
            let categories:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as! String
            return categories
        }
        else if(pickerView==pickerViewRupeeDoller)
        {
            let RD:String = muarrayDollerRupee.object(at: row) as! String
            return RD
        }
        else if(pickerView==pickerHourDayMonth)
        {
            let RD:String = muarrayForMANSpendTypeHoursMonth.object(at: row) as! String
            return RD
        }
        
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if(pickerView==pickerViewCategoryList)
        {
            let categories:String =  (muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: row) as! String
            let ID:String = (muarrayForCategoryListWithOutZeroIndex.value(forKey: "ID") as AnyObject).object(at: row) as! String
            
            if(categories=="Others")
            {
                self.textfieldCategory2.isUserInteractionEnabled = true
                textfieldCategory2.backgroundColor = UIColor.white
                
            }
            else
            {
                self.textfieldCategory2.isUserInteractionEnabled = false
                textfieldCategory2.backgroundColor = UIColor(red: 206.0/255.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
                
            }
            
            self.varSetAlbumCategory = ID
            self.textfieldCategory1.text! = categories
            
            
            print(ID)
        }
        else if(pickerView==pickerViewRupeeDoller)
        {
            let RD:String = muarrayDollerRupee.object(at: row) as! String
            //self.textfieldRupeeSelect.text! = RD
        }
        else if(pickerView==pickerHourDayMonth)
        {
            //let RD:String = muarrayForMANSpendTypeHoursMonth.objectAtIndex(row) as! String
            //self.textfieldManHourTypeHourYearMonth.text! = RD
        }
        else
        {
        }
        
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == textfieldBaneficiary)
        {
            viewPickerCategory.isHidden=true
            buttonOpticity.isHidden=true
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            // textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
            
        }
        else if(textField == textfieldCategory2)
        {
            viewPickerCategory.isHidden=true
            buttonOpticity.isHidden=true
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            //textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
            
        }
            //        else if(textField == textfieldRupeeSelect)
            //        {
            //            viewForManHoursSpendPicker.hidden=true
            //            viewPickerCategory.hidden=true
            //            buttonOpticity.hidden=true
            //            viewPickerRupeeDoller.hidden=false
            //            buttonOpticity.hidden=false
            //
            //            textViewDescription.resignFirstResponder()
            //            textfieldTitle.resignFirstResponder()
            //            textfieldCategory1.resignFirstResponder()
            //            textfieldCategory2.resignFirstResponder()
            //            textfieldBaneficiary.resignFirstResponder()
            //            //textfieldRupeeSelect.resignFirstResponder()
            //            textfieldCostofProject.resignFirstResponder()
            //            textfieldDateofProject.resignFirstResponder()
            //            textfieldManHoursSpent.resignFirstResponder()
            //            textfieldNumberOfRotarians.resignFirstResponder()
            //            textfieldManHourTypeHourYearMonth.resignFirstResponder()
            //
            //        }
        else if textField == textfieldCostofProject
        {
            viewForManHoursSpendPicker.isHidden=true
            viewPickerCategory.isHidden=true
            buttonOpticity.isHidden=true
            viewPickerRupeeDoller.isHidden=true
            buttonOpticity.isHidden=true
            
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            //textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
        }
            //        else if(textField==textfieldDateofProject)
            //        {
            //
            //        }
            
        else if(textField==textfieldManHoursSpent)
        {
            viewForManHoursSpendPicker.isHidden=true
            viewPickerCategory.isHidden=true
            buttonOpticity.isHidden=true
            viewPickerRupeeDoller.isHidden=true
            buttonOpticity.isHidden=true
            
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            //textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
        }
        else if(textField==textfieldNumberOfRotarians)
        {
            viewForManHoursSpendPicker.isHidden=true
            viewPickerCategory.isHidden=true
            buttonOpticity.isHidden=true
            viewPickerRupeeDoller.isHidden=true
            buttonOpticity.isHidden=true
            
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            //textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
        }
        else if(textField==textfieldManHourTypeHourYearMonth)
        {
            
            //            viewPickerCategory.hidden=true
            //            viewPickerRupeeDoller.hidden=true
            //
            //            buttonOpticity.hidden=false
            //            viewForManHoursSpendPicker.hidden=false
            //            pickerHourDayMonth.hidden=false
            //            textViewDescription.resignFirstResponder()
            //            textfieldTitle.resignFirstResponder()
            //            textfieldCategory1.resignFirstResponder()
            //            textfieldCategory2.resignFirstResponder()
            //            textfieldBaneficiary.resignFirstResponder()
            //            textfieldRupeeSelect.resignFirstResponder()
            //            textfieldCostofProject.resignFirstResponder()
            //            textfieldDateofProject.resignFirstResponder()
            //            textfieldManHoursSpent.resignFirstResponder()
            //            textfieldNumberOfRotarians.resignFirstResponder()
            //            textfieldManHourTypeHourYearMonth.resignFirstResponder()
        }
        else if(textField==textfieldTitle)
        {
            textViewDescription.resignFirstResponder()
            //textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
            
        }else
        {
            textViewDescription.resignFirstResponder()
            textfieldTitle.resignFirstResponder()
            textfieldCategory1.resignFirstResponder()
            textfieldCategory2.resignFirstResponder()
            textfieldBaneficiary.resignFirstResponder()
            textfieldRupeeSelect.resignFirstResponder()
            textfieldCostofProject.resignFirstResponder()
            textfieldDateofProject.resignFirstResponder()
            textfieldManHoursSpent.resignFirstResponder()
            textfieldNumberOfRotarians.resignFirstResponder()
            textfieldManHourTypeHourYearMonth.resignFirstResponder()
        }
    }
    
    //Rupee Doller
    @IBAction func buttonRupeeDollerDoneCE(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewPickerCategory.isHidden=true
        viewPickerRupeeDoller.isHidden=true
    }
    @IBAction func buttonRupeeDollerCancelCE(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        viewPickerCategory.isHidden=true
        textfieldRupeeSelect.text! = "₹"
    }
    
    //Category
    @IBAction func buttonCancelCategoryCE(_ sender: AnyObject)
    {
        
        
        
        
        buttonOpticity.isHidden=true
        viewPickerCategory.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        
        
        
        if(self.isCalledFRom == "edit")
        {
            textfieldCategory1.text! = setcategoryOnCancel
            varSetAlbumCategory = self.setCategoryIDOnCancel
        }
        else
        {
            textfieldCategory1.text = nil
        }
    }
    @IBAction func buttonDoneCategoryCE(_ sender: AnyObject)
    {
        buttonOpticity.isHidden=true
        viewPickerCategory.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        
    }
    //Man Hours Spend Picker Button
    
    
    @IBAction func buttonDoneManHoursClickEvent(_ sender: AnyObject) {
        
        buttonOpticity.isHidden=true
        viewForManHoursSpendPicker.isHidden=true
        pickerHourDayMonth.isHidden=true
        
    }
    @IBAction func buttonCancelManHOursClickEvent(_ sender: AnyObject) {
        
        buttonOpticity.isHidden=true
        viewForManHoursSpendPicker.isHidden=true
        pickerHourDayMonth.isHidden=true
        textfieldManHourTypeHourYearMonth.text="Hours"
    }
    
    
    @IBOutlet weak var btnRupee: UIButton!
    @IBOutlet weak var btnDateOfProject: UIButton!
    
    @IBOutlet weak var btnTimeSpendType: UIButton!
    
    @IBOutlet weak var btnCategory: UIButton!
    @IBAction func buttonTimeSpendTypeClickEvent(_ sender: AnyObject) {
        viewPickerCategory.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        
        buttonOpticity.isHidden=false
        viewForManHoursSpendPicker.isHidden=false
        pickerHourDayMonth.isHidden=false
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        textfieldManHourTypeHourYearMonth.resignFirstResponder()
    }
    
    @IBAction func buttonCategorySelectClickEvent(_ sender: AnyObject) {
        
        viewPickerCategory.isHidden=false
        buttonOpticity.isHidden=false
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        textfieldManHourTypeHourYearMonth.resignFirstResponder()
    }
    @IBAction func buttonDateOfProjectClickEvent(_ sender: AnyObject)
    {
        textFieldSelectPublishDateAndTime()
        //datePickers.hidden = false
        //openDatePicker = "Open"
        viewForManHoursSpendPicker.isHidden=true
        viewPickerCategory.isHidden=true
        buttonOpticity.isHidden=true
        viewPickerRupeeDoller.isHidden=true
        buttonOpticity.isHidden=false
        
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        textfieldManHourTypeHourYearMonth.resignFirstResponder()
    }
    
    @IBAction func buttonRupeesPickerClickEvent(_ sender: AnyObject) {
        viewForManHoursSpendPicker.isHidden=true
        viewPickerCategory.isHidden=true
        buttonOpticity.isHidden=true
        viewPickerRupeeDoller.isHidden=false
        buttonOpticity.isHidden=false
        
        textViewDescription.resignFirstResponder()
        textfieldTitle.resignFirstResponder()
        textfieldCategory1.resignFirstResponder()
        textfieldCategory2.resignFirstResponder()
        textfieldBaneficiary.resignFirstResponder()
        //textfieldRupeeSelect.resignFirstResponder()
        textfieldCostofProject.resignFirstResponder()
        textfieldDateofProject.resignFirstResponder()
        textfieldManHoursSpent.resignFirstResponder()
        textfieldNumberOfRotarians.resignFirstResponder()
        textfieldManHourTypeHourYearMonth.resignFirstResponder()
    }
    
    
    
    //MARK:- Button Delete Action
    @IBAction func btnDeleteImg1ClickEvent(_ sender: AnyObject)
    {
        
        
    }
    
    
    
    
    @IBAction func btnDeleteImg2ClickEvent(_ sender: AnyObject) {
        
        if(self.muarrayForPhotoId.count>0)
        {
            let photoId = self.muarrayForPhotoId.object(at: 1) as! String
            if(photoId != "0" && photoId != "")
            {
                varWhichImageDeleteorNot = "2"
                functionForDeleteAlbum(photoId)
            }
            else
            {
                self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
            }
        }
        else
        {
            self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    
    @IBAction func btnDeleteImg3ClickEvent(_ sender: AnyObject)
    {
        if(self.muarrayForPhotoId.count>0)
        {
            let photoId = self.muarrayForPhotoId.object(at: 2) as! String
            if(photoId != "0" && photoId != "")
            {
                varWhichImageDeleteorNot = "3"
                functionForDeleteAlbum(photoId)
            }
            else
            {
                self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
            }
        }
        else
        {
            self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    
    
    
    @IBAction func btnDeleteImg4ClickEvent(_ sender: AnyObject)
    {
        if(self.muarrayForPhotoId.count>0)
        {
            let photoId = self.muarrayForPhotoId.object(at: 3) as! String
            if(photoId != "0" && photoId != "")
            {
                varWhichImageDeleteorNot = "4"
                functionForDeleteAlbum(photoId)
            }
            else
            {
                self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
            }
        }
        else
        {
            self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
        }
        
    }
    
    @IBAction func btnDeleteImg5ClickEvent(_ sender: AnyObject)
    {
        if(self.muarrayForPhotoId.count>0)
        {
            let photoId = self.muarrayForPhotoId.object(at: 4) as! String
            if(photoId != "0" && photoId != "")
            {
                varWhichImageDeleteorNot = "5"
                functionForDeleteAlbum(photoId)
            }
            else
            {
                self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
            }
            
        }
        else
        {
            self.view.makeToast("No Image Availble First Add Image.", duration: 2, position: CSToastPositionCenter)
        }
    }
    
    
    
    //MARK:Delete Photo Server Caling Function
    func functionForDeleteAlbum(_ photoIDs:String)
    {
       // loaderClass.loaderViewMethod()
        
        var urlStr = baseUrl+touchBase_DeleteAlbumPhoto
        // define parameters
        let parameters = ["photoId": photoIDs , "albumId": self.varAlbumID , "deletedBy": self.createdByORUserIdOrProfileId]
        // Begin upload
        
        print(parameters)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: urlStr, parameters: parameters, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            let dictResponseData = response as! NSDictionary
            print("dd \(dictResponseData)")
            print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            let message = (dictResponseData.value(forKey: "TBDelteAlbumPhoto")! as AnyObject).value(forKey: "message") as! String
            if(message=="failed")
            {
                print("Hello Filed")
                self.loaderClass.window=nil;
            }
            else
            {
                
                //self.view.makeToast("Deleted successfully", duration: 2, position: CSToastPositionCenter)
                
                
                if(self.varWhichImageDeleteorNot=="2")
                {
                    self.img2.image = UIImage(named: "")
                    self.img2Desc.text=nil
                }
                else if(self.varWhichImageDeleteorNot=="3")
                {
                    self.img3.image = UIImage(named: "")
                    self.img3Desc.text=nil
                }
                else if(self.varWhichImageDeleteorNot=="4")
                {
                    self.img4.image = UIImage(named: "")
                    self.img4Desc.text=nil
                }
                else if(self.varWhichImageDeleteorNot=="5")
                {
                    self.img5.image = UIImage(named: "")
                    self.img5Desc.text=nil
                }
                
                let alert = UIAlertController(title: "Album", message: "Album image Deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
                    self.navigationController?.popViewController(animated: true)
                }));
                self.present(alert, animated: true, completion: nil)
                
                self.loaderClass.window=nil;
            }
            SVProgressHUD.dismiss()
            }
        })
    }
    
    
    //MARK:- Fetch Get Album Details Server calling
    func functionForFetchingAlbumListData()
    {
        let completeURL = baseUrl+touchBase_GetAlbumDetails+"_New"
        let parameterst = ["albumId":varAlbumID ]
        
        
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
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
            if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "status") as! String == "0" && (dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "message") as! String != "Record not found")
            {
                
                let varAlbumTitleText = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumTitle")! as AnyObject).object(at: 0)) as! String
                print(varAlbumTitleText)
                let varAlbumDescriptiom = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumDescription")! as AnyObject).object(at: 0)) as! String
                print(varAlbumDescriptiom)
                let varAlbumImage = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumImage")! as AnyObject).object(at: 0)) as! String
                print(varAlbumImage)
                let varTypeOFRecipient = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "type")! as AnyObject).object(at: 0)) as! String
                print(varTypeOFRecipient)
                let varGroupId = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "groupId")! as AnyObject).object(at: 0)) as! String
                print(varGroupId)
                var varAlbumId = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumId")! as AnyObject).object(at: 0)) as! String
                print(varAlbumId)
                let varMemberIds = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "memberIds")! as AnyObject).object(at: 0)) as! String
                print(varMemberIds)
                
                
                let beneficiary = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "beneficiary")! as AnyObject).object(at: 0)) as! String
                print(beneficiary)
                let NumberOfRotarian = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "NumberOfRotarian")! as AnyObject).object(at: 0)) as! String
                print(NumberOfRotarian)
                
                //let cost_of_project_type = (dd.valueForKey("TBAlbumDetailResult")!.valueForKey("AlbumDetailResult")!.valueForKey("AlbumDetail")!.valueForKey("cost_of_project_type")!.objectAtIndex(0)) as? String
                //print(cost_of_project_type)
                
                let project_cost = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "project_cost")! as AnyObject).object(at: 0)) as! String
                print(project_cost)
                
                var project_date = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "project_date")! as AnyObject).object(at: 0)) as! String
                print(project_date)
                
                
                let working_hour = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "working_hour")! as AnyObject).object(at: 0)) as! String
                print(working_hour)
                
                
                //let working_hour_type = (dd.valueForKey("TBAlbumDetailResult")!.valueForKey("AlbumDetailResult")!.valueForKey("AlbumDetail")!.valueForKey("working_hour_type")!.objectAtIndex(0)) as? String
                // print(working_hour_type)
                
                
                
                let albumCategoryID = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumCategoryID")! as AnyObject).object(at: 0)) as! String
                print(albumCategoryID)
                
                let albumCategoryText = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "albumCategoryText")! as AnyObject).object(at: 0)) as! String
                print(albumCategoryText)
                
                let othercategorytext = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "othercategorytext")! as AnyObject).object(at: 0)) as! String
                print(othercategorytext)
                
                self.varShareType = (((((dd.value(forKey: "TBAlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetailResult")! as AnyObject).value(forKey: "AlbumDetail")! as AnyObject).value(forKey: "shareType")! as AnyObject).object(at: 0)) as! String
                print(self.varShareType)
                
                self.varIsPublicOrWithInClub = self.varShareType
                if(project_date != "")
                {
                    project_date = self.dateConverter(project_date)
                }
                
                
                
                
                
                
                
                //cost_of_project_type
                
                
                
                //                if(cost_of_project_type == "$" || cost_of_project_type == "Dollar")
                //                {
                //                    self.textfieldRupeeSelect.text! = "Dollar"
                //                }
                //                else
                //                {
                //                    self.textfieldRupeeSelect.text! = "Rupees"
                //                }
                
                
                //                                if(cost_of_project_type == "2")
                //                                {
                //                                    self.textfieldRupeeSelect.text! = "$"
                //                                }
                //                                else
                //                                {
                //                                  self.textfieldRupeeSelect.text! = "₹"
                //                                }
                //
                
                
                
                self.setcategoryOnCancel = albumCategoryText
                self.setCategoryIDOnCancel = albumCategoryID
                
                self.textfieldTitle.text = varAlbumTitleText
                self.textViewDescription.text = varAlbumDescriptiom
                self.textfieldBaneficiary.text = beneficiary
                self.textfieldDateofProject.text = project_date
                self.textfieldCostofProject.text = project_cost
                self.textfieldManHoursSpent.text = working_hour
                //self.textfieldRupeeSelect.text = cost_of_project_type
                self.textfieldNumberOfRotarians.text = NumberOfRotarian
                self.textfieldCategory1.text = albumCategoryText
                self.varSetAlbumCategory = albumCategoryID
                // self.textfieldManHourTypeHourYearMonth.text = working_hour_type
                if(albumCategoryText=="Others" || albumCategoryText=="others")
                {
                    self.varSetAlbumCategory=albumCategoryID
                    self.textfieldCategory2.text! = othercategorytext
                    self.textfieldCategory2.backgroundColor = UIColor.white
                    self.textfieldCategory2.isUserInteractionEnabled=true
                }
                else
                {
                    self.varSetAlbumCategory=albumCategoryID
                    self.textfieldCategory2.isUserInteractionEnabled=false
                    self.textfieldCategory2.backgroundColor = UIColor(red: 206.0/255.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
                }
                if(self.textViewDescription.text != "")
                {
                    self.labelPlaceHolder.isHidden = true
                }
                
                /*---------------------------------loading Image Direct from url-------------------------*/
                if(varAlbumImage == "")
                {
                    self.img1.image = UIImage(named: "AddPic")
                    self.ImsgId = ""
                }
                else
                {
                    //Alamofire.request(.GET, varAlbumImage).response { (request, response, data, error) in self.img1.image = UIImage(data: data!, scale:1) }
                    
                    self.ImsgId = "0"
                }
                
                /*-------------------------Get Profile Id and Count No. Of sub group & Members--------Start-----*/
                self.commonIDString = varMemberIds
                let  varGetValueForGroupAndMemberCount=varMemberIds.components(separatedBy: ",")
                
                self.count = varGetValueForGroupAndMemberCount.count
                /*-------------------------Get Profile Id and Count No. Of sub group & Members---------End-----*/
                
                
                
                
                
                
                
                if(self.varShareType=="0" )
                {
                    self.WithinClubSharing()
                }
                else if (self.varShareType=="1")
                {
                    self.PublicShare()
                }
                
                
                /*-----------------All SubGroup Member Selection--------Code by Deepak----------End-----------*/
                
                
                self.loaderClass.window=nil
                
            }
            else if((dd.object(forKey: "TBAlbumDetailResult")! as AnyObject).object(forKey: "message") as! String == "Record not found")
            {
                self.loaderClass.window=nil
                self.view.makeToast("No Result", duration: 2, position: CSToastPositionCenter)
                
            }
            else
            {
                self.loaderClass.window=nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
        })
        
    }
    
    
    
    
    func functionForAddUpdateAlbum()
    {
        
        var isSubGrpAdmins:String!=""
        print(self.isAdmin)
        
        
        
        
      //  loaderViewMethod()
        
        self.annTypeStr = "0"
        self.commonIDString = ""
        // print(self.annTypeStr)
        // print(self.grpID)
        // print(self.ImsgId)
        // print(self.createdByORUserIdOrProfileId)
        //let URL = baseUrl+touchbase_AddAlbumUpdate
        let URL = baseUrl+"Gallery/AddUpdateAlbum_New"
        let parameters = [
            "albumId": self.varAlbumID,
            "groupId": self.grpID,
            "type": self.annTypeStr,
            "memberIds": self.commonIDString ,
            "albumTitle": self.textfieldTitle.text!,
            "albumDescription": self.textViewDescription.text!,
            "albumImage": self.ImsgId,
            "createdBy": self.createdByORUserIdOrProfileId,
            "isSubGrpAdmin":"0",
            "subgrpIDs":"",
            "moduleId": self.stringModuleId,
            "shareType":self.varIsPublicOrWithInClub,
            "categoryId":varSetAlbumCategory,
            "dateofproject":self.textfieldDateofProject.text!,
            "costofproject":self.textfieldCostofProject.text!,
            "beneficiary":self.textfieldBaneficiary.text!,
            "manhourspent":self.textfieldManHoursSpent.text!,
            "Manhourspenttype":"Hours",
            "NumberofRotarian":self.textfieldNumberOfRotarians.text!,
            "OtherCategorytext":self.textfieldCategory2.text!,
            "costofprojecttype":"",
            ] as [String : Any]
        
        print(parameters)
        print(URL)
        // Begin upload
        
        Alamofire.request(URL, method: .post, parameters: parameters as? [String : AnyObject],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result
            {
            case .success:
                print(response)
                if response.result.value != nil
                {
                    print( response.result.value)
                    var dictResponseData:NSDictionary=NSDictionary()
                    dictResponseData = response.result.value as! NSDictionary
                    print(dictResponseData)
                  //  let message = (dictResponseData.value(forKey: "TBAddGalleryResult")! as AnyObject).value("message") as! String
                    let message = (dictResponseData.value(forKey: "TBAddGalleryResult")! as AnyObject).value(forKey: "message") as! String

                    
                    
                    
                    
                    if(message=="failed")
                    {
                        print("Hello Filed")
                        self.window=nil;
                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                        
                         SVProgressHUD.dismiss()
                    }
                    else
                    {
                        /*--if response come from server success-------------------------------------*/
                        print("Hello Success")
                        if(self.varAlbumID != "0")
                        {
                            let galleryidVsAlbumID = (dictResponseData.value(forKey: "TBAddGalleryResult")! as AnyObject).value(forKey:"galleryid") as! String
                            self.GalleryIDFromResponseAddAlbum = galleryidVsAlbumID
                            if(self.GalleryIDFromResponseAddAlbum=="")
                            {
                            }
                            else
                            {

                                print(self.muarrayForPhotoId)
                                if(self.muarrayForPhotoId.count>0)
                                {
                                    for i in 0..<self.muarrayForPhotoId.count
                                    {
                                        
                                        if(self.muarrayForMultipleImageUrlStore.object(at: i) as! String == "1")
                                        {
                                            self.functionForImageUploadFive(self.GalleryIDFromResponseAddAlbum, imageNo: i)
                                        }
                                        else
                                        {
                                            let photoIddds = self.muarrayForPhotoId.object(at: i) as! String
                                            let imageNos = self.muarrayForPhotoId.object(at: i) as! String
                                            self.functionForUpdateAddPhoto(i, galleryidVsAlbumID: self.GalleryIDFromResponseAddAlbum , photoID: photoIddds)
                                        }
                                        
                                        //self.functionForImageUploadFive(self.GalleryIDFromResponseAddAlbum, imageNo: Int(imageNos)!)
                                        
                                    }
                                }
                                
                                
                                
                                self.window=nil;
                            }
                            self.window=nil;
                        }
                        else
                        {
                            let galleryidVsAlbumID = (dictResponseData.value(forKey: "TBAddGalleryResult")! as AnyObject).value(forKey: "galleryid") as! String
                            self.GalleryIDFromResponseAddAlbum = galleryidVsAlbumID
                            if(self.GalleryIDFromResponseAddAlbum=="")
                            {
                            }
                            else
                            {
                                print(self.muarrayForMultipleImageUrlStore)
                                if(self.muarrayForMultipleImageUrlStore.count>0)
                                {
                                    var countArray:NSMutableArray=NSMutableArray()
                                    for i in 0..<self.muarrayForMultipleImageUrlStore.count
                                    {
                                        if(self.muarrayForMultipleImageUrlStore.object(at: i) as! String == "1")
                                        {
                                            countArray.add(i)
                                            
                                            print(countArray.count)
                                            if(i==countArray.count-1)
                                            {
                                                print("Innnnnnnnnnnnnnnnnnnnnnnnnnnnnnn")
                                                UserDefaults.standard.setValue("Success5", forKey: "LastImageUpdateConfirmationYesOrNo")
                                            }
                                            self.functionForImageUploadFive(self.GalleryIDFromResponseAddAlbum, imageNo: i)
                                            
                                            
                                        }
                                    }
                                }
                            }
                            
                            self.window=nil;
                            
                            //
                            //                        let alert = UIAlertController(title: "Album", message: "Images Upload successfully.", preferredStyle: UIAlertController.Style.Alert)
                            //                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:{(action:UIAlertAction) in
                            //                            self.navigationController?.popViewControllerAnimated(true)
                            //                        }));
                            //                        self.presentViewController(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
        
        
        
        
       // Alamofire.request(URL, method: .post, parameters: parameters as? [String : AnyObject],encoding: JSONEncoding.default, headers: nil).responseJSON {_ in
           
       // }
    }
    
    
    
    //MARK:- Image Upload on Server and Get Image ID
    func functionForImageUpload()
    {
       // loaderViewMethod()
        
        /////--------------
      //  loaderViewMethod()
        
        var parameters = [String:AnyObject]()
        parameters =  ["name":"gallery" as AnyObject]
        let URL = baseUrl+touchBase_UploadImag
        let imageT = img1.image
        
        
        // let imageT = imageAnnouncement.image
        let image:UIImage =  self.compressImage(img1.image!)
        //let imageData: NSData = UIImagePNGRepresentation(image) as! NSData
        var imageData = image.jpegData(compressionQuality: 0.6)! //UIImageJPEGRepresentation(image, 0.6)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = imageData as? Data {
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: URL, method: .post, headers: nil) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let JSON = response.result.value
                    {
                          var dictResponseData:NSDictionary = NSDictionary()
                        dictResponseData = JSON as! NSDictionary
                        print("JSON: \(JSON)")
                        print(dictResponseData)
                        self.ImsgId = (dictResponseData.value(forKey: "LoadImageResult")! as AnyObject).value(forKey:"ImageID") as! String
                        self.window=nil;
                        print(self.ImsgId)
                        self.imageUploadOrNot = "UploadSuccess"
                        if(self.isCalledFRom=="edit")
                        {
                            if(self.isCalledFRom=="edit")
                            {
                                let alert = UIAlertController(title: "Album", message: "Album updated successfully.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                                    self.backTwo()
                                }));
                                self.present(alert, animated: true, completion: nil)
                            }
                            else
                            {
                                let alert = UIAlertController(title: "Album", message: "Album added successfully.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                                    self.navigationController?.popViewController(animated: true)
                                }));
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                            
//
//                            let alert = UIAlertController(title: "Album", message: "Album updated successfully.", preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
//                               // self.navigationController?.popViewController(animated: true)
//
//                                if(self.isCalledFRom=="edit")
//                                {
//
//                                    self.backTwo()
//                                }
//                                else
//                                {
//                                    self.navigationController?.popViewController(animated: true)
//                                }
//
//
//
//                            }));
//                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            if(self.ImsgId != "")
                            {
                                self.functionShowFirstImageSelection()
                                
                                if(self.selectPublicOrPrivate=="Private")
                                {
                                self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2300)
                                }
                                else if (self.selectPublicOrPrivate == "Public")
                                {
                                self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 2800)
                                }
                                else
                                {
                                  self.myScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 3000)
                                }
                                
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                self.window=nil;
                
                self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                self.imageUploadOrNot = "Not"
                
                
            }
        }
        ////-------------
        
        /*
        
        
        var parameters = [String:AnyObject]()
        parameters = ["name":"gallery" as AnyObject]
        
       
      Alamofire.upload(multipartFormData:{ multipartFormData in
            if let imageData = UIImageJPEGRepresentation(imageT!, 0.6) {
                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
        }, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .Success(let upload, _, _):
                print("s")
                var dictResponseData:NSDictionary = NSDictionary()
                upload.responseJSON
                    {
                        response in

                }
            case .Failure(let encodingError):
                print(encodingError)
                /*
                 let alert = UIAlertController(title: "Rotary India", message: "Image Upload failed, Please try Again!", preferredStyle: UIAlertController.Style.Alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
                 self.presentViewController(alert, animated: true, completion: nil)
                 */
             
            }
        })
        */
    }
    
    
    
    
    //MARK:- Server api calling
    func functionForFetchingAlbumPhotosListData()
    {
        self.muarrayForPhotoId = NSMutableArray()
        self.muarrayMainList = NSArray()
       // loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
        let parameterst = ["groupId":self.grpID,"albumId": self.varAlbumID]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
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
            if((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "status") as! String == "0" && ((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "message") as! String == "success"))
            {
                let arrarrNewGroupList = ((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "Result")) as! NSArray
                print(arrarrNewGroupList)
                self.muarrayMainList = arrarrNewGroupList
                //dpk code for image count for max photo five
                var CountImag :String! = ""
                CountImag = String(self.muarrayMainList.count)
                print(CountImag)
                UserDefaults.standard.setValue(CountImag, forKey: "ImageCountFiveOrNot")
                if(self.muarrayMainList.count>0)
                {
                    self.functionGetAllImageDescDetailsFromBackController()
                }
                else
                {
                }
                self.loaderClass.window = nil
            }
            else
            {
                self.loaderClass.window = nil
                //self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                print("NO Result")
                 SVProgressHUD.dismiss()
            }
            
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
        }
        })
    }
    
    
    //MARK:- WEB API Selected District
    func fucntionForGetClubChangeAccordingToDistrictIDAndGetClubList()
    {
       // loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetShowcaseDetails"
        let parameterst =  [ "DistrictID":"0"]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
             print(response)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.loaderClass.window=nil
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                 SVProgressHUD.dismiss()
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
                        if(self.isCalledFRom == "edit")
                        {
                            var dict : NSDictionary=NSDictionary()
                            for i in 1..<self.muarrayCategoryListArray.count
                            {
                                let Name = (self.muarrayCategoryListArray.value(forKey: "Name") as AnyObject).object(at: i) as! String
                                let ID  = (self.muarrayCategoryListArray.value(forKey: "ID") as AnyObject).object(at: i) as! String
                                let DistrictID  = (self.muarrayCategoryListArray.value(forKey: "DistrictID") as AnyObject).object(at: i) as! String
                                dict = ["Name":Name,"ID":ID,"DistrictID":DistrictID]
                                // print(dict)
                                self.muarrayForCategoryListWithOutZeroIndex.add(dict)
                            }
                            // print(self.muarrayForCategoryListWithOutZeroIndex)
                        }
                        else
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
                            }
                            self.textfieldCategory1.text! = (self.muarrayForCategoryListWithOutZeroIndex.value(forKey: "Name") as AnyObject).object(at: 0) as! String
                            let ID  = (self.muarrayForCategoryListWithOutZeroIndex.value(forKey: "ID") as AnyObject).object(at: 0) as! String
                            // print(ID)
                            self.varSetAlbumCategory = ID
                        }
                        
                    }
                    else
                    {
                        self.textfieldCategory1.text = nil
                        self.view.makeToast("No Category", duration: 2, position: CSToastPositionCenter)
                    }
                    if(self.muarrayForCategoryListWithOutZeroIndex.count>0)
                    {
                        self.pickerViewCategoryList.reloadAllComponents()
                    }
                    self.pickerViewRupeeDoller.reloadAllComponents()
                    self.loaderClass.window=nil
                }
                else
                {
                    self.loaderClass.window=nil
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                     SVProgressHUD.dismiss()
                }
                self.loaderClass.window=nil
            }
            SVProgressHUD.dismiss()
            
        })
    }
}



extension UITextView : UITextViewDelegate
{
    
    
    
    func setTextViewFullBorder()
    {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 227.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0).cgColor
        
}
}
