//

//  ProfileDynamicNewViewController.swift

//  TouchBase

//

//  Created by deepak on 29/05/17.

//  Copyright © 2017 Parag. All rights reserved.

//userFamilyImage



import UIKit

import MessageUI

import Foundation

import MessageUI
import Contacts
import ContactsUI
import Alamofire
import SVProgressHUD



class ProfileDynamicNewViewController: UIViewController,CNContactViewControllerDelegate ,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate , UIActionSheetDelegate , UITableViewDelegate , UITableViewDataSource
{
    var objptotocolForDirectoryScrenBackValue:ptotocolForDirectoryScrenBackValue?=nil
    
    
    let loaderClass  = WebserviceClass()
    var appDelegate : AppDelegate = AppDelegate()
    @IBOutlet weak var buttonProcessing: UIButton!
    @IBOutlet weak var labelDisctrictDesignation: UILabel!
    @IBOutlet weak var buttonCalcelPopupCallSmsEmail: UIButton!
    @IBOutlet weak var buttonEditProfileImage: UIButton!

    
    var varGetFamilyImageImages:UIImage=UIImage()
    var varISPhotoAvailable:String!=""
    var varISProfileorFamilyImage:String!=""
    var varGetSelectedIndex:Int!=0
    var isCategory:String!=""
    var groupUniqueName:String!=""
    var isUserProfile:String! = ""
    //groupUniqueName
    var X_Position:CGFloat? = 0.0 //use your X position here
    
    var Y_Position:CGFloat? = 150.0 //use your Y position here
    
    var isAdminss = ""
    
    //first
    
    var muarrayKeyFirst:NSMutableArray=NSMutableArray()
    
    var muarrayValueFirst:NSMutableArray=NSMutableArray()
    
    var muarrayContactKey:NSMutableArray=NSMutableArray()
    
    var muarrayContactValue:NSMutableArray=NSMutableArray()
    
    var muarrayCountryTextFirst:NSMutableArray=NSMutableArray()
    
    var muarrayCountryCodeFirst:NSMutableArray=NSMutableArray()
    
    var muarrayCountryIdFirst:NSMutableArray=NSMutableArray()
    
    //second
    
    var muarrayAddressSecond:NSMutableArray=NSMutableArray()
    
    var muarrayCitySecond:NSMutableArray=NSMutableArray()
    
    var muarrayPostalCodeSecond:NSMutableArray=NSMutableArray()
    
    var muarrayStateSecond:NSMutableArray=NSMutableArray()
    
    var muarrayAddressIdSecond:NSMutableArray=NSMutableArray()
    
    var muarrayCountryTextSecond:NSMutableArray=NSMutableArray()
    
    var muarrayCountryCodeSecond:NSMutableArray=NSMutableArray()
    
    var muarrayCountryIdSecond:NSMutableArray=NSMutableArray()
    
    var muarrayBusinessContactCountryTextSecond:NSMutableArray=NSMutableArray()
    
    var muarrayBusinessContactCountryCodeSecond:NSMutableArray=NSMutableArray()
    
    var muarrayBusinessContactCountryIdSecond:NSMutableArray=NSMutableArray()
    
    var muarrayBusinessContactMobileNumberSecond:NSMutableArray=NSMutableArray()
    
    //three
    
    var muarrayNameThree:NSMutableArray=NSMutableArray()
    var muarrayFamilyMemberIDThree:NSMutableArray=NSMutableArray()
    var muarrayFamilyMemberDeletedIDThree:NSMutableArray=NSMutableArray()
    var muarrayRelationshipThree:NSMutableArray=NSMutableArray()
    var muarrayCountryTextThree:NSMutableArray=NSMutableArray()
    var muarrayCountryCodeThree:NSMutableArray=NSMutableArray()
    var muarrayCountryIdThree:NSMutableArray=NSMutableArray()
    var muarrayMobileNumberThree:NSMutableArray=NSMutableArray()
    var muarrayEmailIDThree:NSMutableArray=NSMutableArray()
    var muarrayBloodGroupThree:NSMutableArray=NSMutableArray()
    var muarrayBirthdayThree:NSMutableArray=NSMutableArray()
    var muarrayAnniversaryThree:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewOne: UIView!
    
    var NormalMemberOrAdmin:String!=""
    var varGetPickerSelectValue:String!=""
    var FromDistrictOrBOD:String!=""
    var FromDistrictHideFamilyDetails:String!=""
    
    @IBOutlet weak var buttonPhoness: UIButton!
    
    @IBOutlet weak var buttonEmailss: UIButton!
    
    @IBOutlet weak var buttonMessagess: UIButton!
    
    @IBOutlet weak var buttonEditsss: UIButton!
    
    @IBOutlet weak var tableviewAllInformation: UITableView!
    
    var bussAddrsV1 = ""
    var busscityV1 = ""
    var bussstateV1 = ""
    var busspinV1 = ""
    var busscountryV1 = ""
    
    var muarrayAllInformation:NSMutableArray=NSMutableArray()
    
    //var appDelegate : AppDelegate!
    
    @IBOutlet weak var buttonCallMessageEmail: UIButton!
    
    var picker = UIImagePickerController()
    
    @IBOutlet weak var buttonSendMessage: UIButton!
    
    @IBOutlet weak var tableviewUpperPhoneMessageMail: UITableView!
    
    @IBOutlet weak var tableviewEmail: UITableView!
    
    @IBOutlet weak var viewUpperContact: UIView!
    
    var commonClassHoldDataAccessibleVariable:CommonAccessibleHoldVariable=CommonAccessibleHoldVariable()
    
    @IBOutlet weak var buttonOpacity: UIButton!
    
    var cell:upperProfilePhoneMessageEmailTableViewCell=upperProfilePhoneMessageEmailTableViewCell()
    
    var cells:EmailTableViewCell=EmailTableViewCell()
    var cell3:AllInformationTableViewCell=AllInformationTableViewCell()
    var varRowHeight:CGFloat!=0.0
    var varRowHeightFamilyDetail:CGFloat!=0.0
    var varAdminProfileID:String!=""
    var ClubNameFotShowProfile:String!=""
    var moduleName:String! = ""
    var masterId:String! = ""
    var profileId:String! = ""
    var grpID:String! = ""
    var isAdmin:String! = ""
    var isCalled:String! = ""
    var muarrayMessage:NSMutableArray=NSMutableArray()
    var muarrayEmail:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var lblClubDesignation: UILabel!
    
    var varCallMessageEmail:String!=""
    var muarrayGetContactProfileUpper:NSMutableArray=NSMutableArray()
    var muarrayGetEmailProfileUpper:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var imageUserImage: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    var fromBOD = false
    var from = ""
    var userImg = ""
    var userNam = ""
    var lblKeyArray = [String]()
    var lblValueArray = [String]()
    var mob = ""
    var secMob = ""
    var mail = ""
    var bEmail = ""
    var bName = ""
    var desgn = ""
    var bAddrs = ""
    var bCntcNo = ""
    var classifica = ""
    var kayProf = ""
    var rotarId = ""
    var clubDesgn = ""
    var bthday = ""
    var donor = ""
    var anniDate = ""
    var bldGrp = ""
    var resAddres = ""
    var relati = ""
    var mother = ""
    var resMob = ""
    var famImg = ""
    var memIntro = ""
    var fb = ""
    var insta = ""
    var lnkdin = ""
    var web = ""
    var twit = ""
    var yt = ""
    var proofileId = ""
    var city = ""
    var state = ""
    var country = ""
    var pincode = ""
    var cellHeightForFamily = 80.0
    var mastersId: Int?
    
    var phnArray = [String]()
    var mailArray = [String]()
    
    var famDetailOnline: FamilyDetailes?
    var classificationMemberDetails: ClassificationDetail?
    var membersDetailV1: MemberDetailV1?
    
    //    var famDetails =
    
    //MARK:- Button click event
    
    
    
    @IBAction func buttonImageEditClickEvent(_ sender: AnyObject) {
        
        if self.isCategory=="2"
        {
            self.buttonEditsss.isHidden = true
        }
        else
        {
            
            if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
            {
                self.buttonEditsss.isHidden = true
            }
            else if (NormalMemberOrAdmin == "Classification")
            {
                self.buttonEditsss.isHidden = true
                if(isUpperImageAvailable.characters.count>10)
                {
                    //print(isUpperImageAvailable)
                    //print("available")
                    
                    let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
                    objImageFullViewViewController.varGetImageUrl=isUpperImageAvailable
                    self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
                    
                }
            }
            else if (NormalMemberOrAdmin == "Family")
            {
                self.buttonEditsss.isHidden = true
            }
            else if (NormalMemberOrAdmin == "BOD")
            {
                self.buttonEditsss.isHidden = true
                if(isUpperImageAvailable.characters.count>10)
                {
                    //print(isUpperImageAvailable)
                    //print("available")
                    
                    let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
                    objImageFullViewViewController.varGetImageUrl=isUpperImageAvailable
                    self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
                    
                }
                else
                {
                    //print(" not available")
                }
            }
            else
            {
                if(isUpperImageAvailable.characters.count>10)
                {
                    //print(isUpperImageAvailable)
                    //print("available")
                    
                    let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
                    objImageFullViewViewController.varGetImageUrl=userImg.replacingOccurrences(of: " ", with: "%20")
                    self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
                    
                }
                else
                {
                    //print(" not available")
                }
            }
            
            
            
            /*
             
             if self.isCategory=="2"
             {
             self.buttonEditsss.hidden = true
             }
             else
             {
             
             if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
             {
             self.buttonEditsss.hidden = true
             }
             else if (NormalMemberOrAdmin == "Classification")
             {
             self.buttonEditsss.hidden = true
             }
             else if (NormalMemberOrAdmin == "Family")
             {
             self.buttonEditsss.hidden = true
             }
             else if (NormalMemberOrAdmin == "BOD")
             {
             self.buttonEditsss.hidden = true
             }
             else
             {
             varISProfileorFamilyImage="profile"
             var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.ActionSheet)
             var cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.Default)
             {
             UIAlertAction in
             self.openCamera()
             
             }
             var gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.Default)
             {
             UIAlertAction in
             self.openGallary()
             }
             var RemocvxvveAction = UIAlertAction(title: "Remxcvove", style: UIAlertAction.Style.Default)
             {
             UIAlertAction in
             self.imageUserImage.image=UIImage(named:"profile_pic.png")
             self.functionForRemxcvoveProfilePic()
             
             }
             var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.Cancel)
             {
             UIAlertAction in
             }
             
             
             picker.delegate = self
             alert.addAction(cameraAction)
             alert.addAction(gallaryAction)
             alert.addAction(RemzcxoveAction)
             alert.addAction(cancelAction)
             self.presentViewController(alert, animated: true, completion: nil)
             
             
             }
             
             */
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
    
    
    func functionForRemoveProfilePic()
    {
        if(varISProfileorFamilyImage=="profile")
        {
            
            
            imageUserImage.image=UIImage(named:"profile_pic.png")
            
            buttonProcessing.isHidden=false
            
            //-----------------------------------------------------------
            var parameters = [String:AnyObject]()
            parameters = [
                "typeID":profileId as AnyObject,
                "grpID":grpID as AnyObject,
                "type":"Member" as AnyObject
            ]
            buttonOpacity.isHidden=false
            let completeURL = baseUrl+touchBase_GetRemovedMemberProfile
            Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if(response != nil)
                    {
                        
                        if let value = response.result.value {
                            let dic = response.result.value!
                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                            let jsonString = String(data: jsonData!, encoding: .utf8)!
                            ////print(jsonString)
                            //--
                            let dd = response.result.value as! NSDictionary
                            
                            //print("dd \(dd)")
                            var varGetValueServerError = dd.object(forKey: "serverError")as? String
                            
                            if(varGetValueServerError == "Error")
                            {
                                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                SVProgressHUD.dismiss()
                            }
                            else
                            {
                                if(response==nil)
                                {
                                    
                                }
                                else
                                {
                                    
                                    if let dd = response.result.value as? NSDictionary
                                    {
                                        if((dd.object(forKey: "DeleteResult")! as AnyObject).object(forKey: "status") as! String == "0")
                                        {
                                            
                                            UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
                                            self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                                            self.buttonOpacity.isHidden=true
                                            self.view.makeToast("Profile image removed successfully", duration: 3, position: CSToastPositionCenter)
                                            self.isUpperImageAvailable=""
                                            self.buttonProcessing.isHidden=true
                                        }
                                        else
                                        {
                                            self.view.makeToast("Something went wrong, Please try again later", duration: 3, position: CSToastPositionCenter)
                                            self.buttonOpacity.isHidden=true
                                            self.buttonProcessing.isHidden=true
                                            SVProgressHUD.dismiss()
                                        }
                                    }
                                    SVProgressHUD.dismiss()
                                }
                            }
                            //----
                        }
                    }
                case .failure(_): break
                }
            }
            //----------------------------------------------------
            
            
            
            
            
        }
    }
    
    
    
    
    @IBAction func buttonEditClickEvent(_ sender: AnyObject)
    {
        varISProfileorFamilyImage="profile"
        //print(varISProfileorFamilyImage)
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
        let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            //profile_pic.png
            self.imageUserImage.image=UIImage(named:"profile_pic.png")
            self.functionForRemoveProfilePic()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        
        if(isUpperImageAvailable.characters.count>10)
        {
            alert.addAction(RemoveAction)
        }
        
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
    //MARK:UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print("This is profile and family")
        //print(varISProfileorFamilyImage)
        
        if(varISProfileorFamilyImage=="profile")
        {
            buttonProcessing.isHidden=false
            picker .dismiss(animated: true, completion: nil)
            var image : UIImage!
            if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            {
                image = img
            }
            else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                image = img
            }
            imageUserImage.image=image
            
            //------------------------------------------------------------------------------------------------
            var parameters = [String:AnyObject]()
            parameters = [
                "ProfileID":profileId as AnyObject,
                "GrpID":grpID as AnyObject,
                "Type":"profile" as AnyObject
            ]
            
            var varQueryString:String!=""
            //update profile image
            varQueryString="?ProfileID="+profileId+"&GrpID="+grpID+"&Type=profile"
            //update family image
            buttonOpacity.isHidden=false
            let URL = baseUrl+touchBase_GetChangedMemberProfile+varQueryString
            
            
            
            // let imageT = imageAnnouncement.image
            let imageLater:UIImage =  self.compressImage(imageUserImage.image!)
            //let imageData: NSData = UIImagePNGRepresentation(image) as! NSData
            var imageData = imageLater.jpegData(compressionQuality: 0.19) //UIImageJPEGRepresentation(imageLater, 0.19)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if let data = imageData{
                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
                }
            }, usingThreshold: UInt64.init(), to: URL, method: .post, headers: nil) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //print("Succesfully uploaded")
                        if let JSON = response.result.value
                        {
                            var dictResponseData:NSDictionary = NSDictionary()
                            dictResponseData = JSON as! NSDictionary
                            //print("JSON: \(JSON)")
                            
                            //let varEventID=(((dictResponseData.object(forKey: "UploadImageResult")! as AnyObject).object(forKey: "status")! as AnyObject)) as! String
                            
                            
                            if(((dictResponseData.object(forKey: "UploadImageResult")! as AnyObject).object(forKey: "status")! as AnyObject) as! String == "0")
                            {
                                self.buttonProcessing.isHidden=true
                                //print(dictResponseData)
                                self.buttonOpacity.isHidden=true
                                self.imageUserImage.image=image
                                
                                // Delay the dismissal by 5 seconds
                                let alert = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
                                self.present(alert, animated: true, completion: nil)
                                UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
                                
                                self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                                
                                // change to desired number of seconds (in this case 5 seconds)
                                let when = DispatchTime.now() + 2
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    // your code with delay
                                    self.view.makeToast("Profile Image changed successfully", duration: 2, position: CSToastPositionCenter)
                                    
                                    alert.dismiss(animated: true, completion: nil)
                                }
                                
                                self.isUpperImageAvailable=(((dictResponseData.object(forKey: "UploadImageResult")! as AnyObject).object(forKey: "Imagepath")! as AnyObject)) as! String
                                self.varISFamilyImageAvailable="0"
                            }
                            else
                            {
                                self.buttonProcessing.isHidden=true
                                self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                            }
                        }
                        else
                        {
                            self.buttonOpacity.isHidden=true
                            self.buttonProcessing.isHidden=true
                            self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                        }
                        if let err = response.error
                        {
                            return
                        }
                        if let err = response.error{
                            
                            return
                        }
                    }
                case .failure(let error):
                    //print("Error in upload: \(error.localizedDescription)")
                    self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                    self.buttonOpacity.isHidden=true
                    self.buttonProcessing.isHidden=true
                }
            }
            //----------------------------------------------------------------------------------------------
            /*
             Alamofire.upload(.POST, URL, multipartFormData: {
             multipartFormData in
             if let imageData = UIImageJPEGRepresentation(imageT!, 0.9) {
             multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
             }
             for (key, value) in parameters {
             multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
             }
             }, encodingCompletion: {
             encodingResult in
             switch encodingResult {
             case .Success(let upload, _, _):
             var dictResponseData:NSDictionary = NSDictionary()
             upload.responseJSON
             {
             response in
             //print(response.request)  // original URL request
             //print(response.response) // URL response
             //print(response.data)     // server data
             //print(response.result)   // result of response serialization
             if let JSON = response.result.value
             {
             dictResponseData = JSON as! NSDictionary
             //print("JSON: \(JSON)")
             if(dictResponseData.objectForKey("UploadImageResult")!.objectForKey("status") as! String == "0")
             {
             self.buttonProcessing.hidden=true
             //print(dictResponseData)
             self.view.makeToast("Profile Image changed successfully", duration: 2, position: CSToastPositionCenter)
             self.buttonOpacity.hidden=true
             self.imageUserImage.image=image
             self.isUpperImageAvailable=dictResponseData.valueForKey("UploadImageResult")!.valueForKey("Imagepath")as! String
             self.varISFamilyImageAvailable="0"
             }
             else
             {
             self.buttonProcessing.hidden=true
             self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
             
             }
             }
             else
             {
             self.buttonOpacity.hidden=true
             self.buttonProcessing.hidden=true
             self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
             }
             }
             case .Failure(let encodingError):
             //print(encodingError)
             self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
             self.buttonOpacity.hidden=true
             self.buttonProcessing.hidden=true
             }
             })
             */
        }
        else if(varISProfileorFamilyImage=="family")
        {
            buttonProcessing.isHidden=false
            ///////////////dfg/dg/df/gd/g/df/gdf/g/df/gd/gd/fg/df
            picker .dismiss(animated: true, completion: nil)
            let varGetImage:UIImage =  self.compressImage((info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
            //let imageData: Data = UIImageJPEGRepresentation(varGetImage , 0.9)!
            //var imageSize: Int = imageData.count
            // //print("size of image in KB: %f ", Double(imageSize) / 1024.0)
            
            var imageUserImageNew:UIImageView=UIImageView()
            
            
            imageUserImageNew.image=varGetImage
            //-----------------------------------------------------------
            var parameters = [String:AnyObject]()
            parameters = [
                "ProfileID":profileId as AnyObject,
                "GrpID":grpID as AnyObject,
                "Type":"family" as AnyObject
            ]
            
            
            var varQueryString:String!=""
            //update family image
            varQueryString="?ProfileID="+profileId+"&GrpID="+grpID+"&Type=family"
            buttonOpacity.isHidden=false
            let URL = baseUrl+touchBase_GetChangedMemberProfile+varQueryString
            
            let image:UIImage =  self.compressImage(imageUserImageNew.image!)
            var imageData = image.jpegData(compressionQuality: 0.19) //UIImageJPEGRepresentation(image, 0.19)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if let data = imageData{
                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
                }
            }, usingThreshold: UInt64.init(), to: URL, method: .post, headers: nil) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //print("Succesfully uploaded")
                        if let JSON = response.result.value
                        {
                            UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
                            self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                            var dictResponseData:NSDictionary = NSDictionary()
                            self.buttonProcessing.isHidden=true
                            dictResponseData = JSON as! NSDictionary
                            //print("JSON: \(JSON)")
                            //print(dictResponseData)
                            self.view.makeToast("Family Image changed successfully", duration: 2, position: CSToastPositionCenter)
                            self.buttonOpacity.isHidden=true
                            //self.viewDidLoad()
                            self.varGetFamilyImageImages=varGetImage
                            self.varISPhotoAvailable="yes"
                            
                            self.tableviewAllInformation.isHidden=false
                            self.viewTwo.isHidden=false
                            var varGetImagePath:String! =  (((dictResponseData.object(forKey: "UploadImageResult")! as AnyObject).object(forKey: "Imagepath")! as AnyObject)) as! String
                            self.getImageURls=varGetImagePath
                            for i in 00..<self.muarrayKeyFirst.count
                            {
                                var varGetFamilyPhoto:String!=self.muarrayKeyFirst.object(at: i) as! String
                                if(varGetFamilyPhoto=="familyphoto")
                                {
                                    self.muarrayValueFirst.replaceObject(at: i, with: varGetImagePath)
                                }
                            }
                            self.tableviewAllInformation.reloadData()
                        }
                        else
                        {
                            self.buttonOpacity.isHidden=true
                            self.buttonProcessing.isHidden=true
                            self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                        }
                        
                        if let err = response.error
                        {
                            self.tableviewAllInformation.isHidden=false
                            self.viewTwo.isHidden=false
                            return
                        }
                        
                        if let err = response.error{
                            self.tableviewAllInformation.isHidden=false
                            self.viewTwo.isHidden=false
                            return
                        }
                    }
                case .failure(let error):
                    //print("Error in upload: \(error.localizedDescription)")
                    
                    self.view.makeToast("Image Upload failed, Please try again!", duration: 2, position: CSToastPositionCenter)
                    self.buttonProcessing.isHidden=true
                    self.buttonOpacity.isHidden=true
                }
            }
            /*---------------------------------ppp------------------------------------------------------------------------*/
        }
    }
    
    /*----------------------------------Code by DPk-----Image Compress------------------------------------------*/
    
    func compressImage (_ image: UIImage) -> UIImage {
        
        let actualHeight:CGFloat = image.size.height
        
        let actualWidth:CGFloat = image.size.width
        
        let imgRatio:CGFloat = actualWidth/actualHeight
        
        let maxWidth:CGFloat = 1024.0
        
        let resizedHeight:CGFloat = maxWidth/imgRatio
        
        let compressionQuality:CGFloat = 0.9
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        
        UIGraphicsBeginImageContext(rect.size)
        
        //image.drawInRect(CGRect)
        
        image.draw(in: rect)
        
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)! //UIImageJPEGRepresentation(img, compressionQuality)!
        
        let imageSize: Int = imageData.count
        
        //print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData)!
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        //print("picker cancel.")
        dismiss(animated: true, completion: nil)
        
    }
    
    //image pick from gallery
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    //
    
    @IBAction func buttonWhatsAppClickEvent(_ sender: Any)
    {
        if(phnArray.count<=0)
        {
            view.self.makeToast("No Contact number available", duration: 2, position: CSToastPositionCenter)
        }
        else
        {
            buttonCallMessageEmail.setTitle("WhatsApp",  for: UIControl.State.normal)
            
            tableviewUpperPhoneMessageMail.isHidden=false
            
            tableviewEmail.isHidden=true
            
            //print("Phone")
            
            buttonOpacity.isHidden=false
            
            viewUpperContact.isHidden=false
            
            varCallMessageEmail="whatsapp"
            
            
            
            buttonSendMessage.isHidden=true
            
            tableviewUpperPhoneMessageMail.reloadData()
            
            
            
            buttonPhoness.isUserInteractionEnabled=false
            
            buttonEmailss.isUserInteractionEnabled=false
            
            buttonMessagess.isUserInteractionEnabled=false
            
            
            
            //print("This  is count:-----")
            //print(muarrayGetContactProfileUpper.count)
            
        }
    }
    
    @IBAction func buttonPhoneClickEvent(_ sender: AnyObject)
    
    {
        if(phnArray.count<=0)
        {
            view.self.makeToast("No Phone number available", duration: 2, position: CSToastPositionCenter)
        }
        else
        {
            buttonCallMessageEmail.setTitle("Call",  for: UIControl.State.normal)
            
            tableviewUpperPhoneMessageMail.isHidden=false
            
            tableviewEmail.isHidden=true
            
            //print("Phone")
            
            buttonOpacity.isHidden=false
            
            viewUpperContact.isHidden=false
            
            varCallMessageEmail="Phone"
            
            
            
            buttonSendMessage.isHidden=true
            
            tableviewUpperPhoneMessageMail.reloadData()
            
            
            
            buttonPhoness.isUserInteractionEnabled=false
            
            buttonEmailss.isUserInteractionEnabled=false
            
            buttonMessagess.isUserInteractionEnabled=false
            
            
            
            //print("This  is count:-----")
            //print(muarrayGetContactProfileUpper.count)
            
        }
        
        
    }
    
    @IBAction func buttonMessageClickEvent(_ sender: AnyObject)
    
    {
        if(phnArray.count<=0)
        {
            view.self.makeToast("No Phone number available", duration: 2, position: CSToastPositionCenter)
        }
        else
        {
            tableviewUpperPhoneMessageMail.isHidden=false
            
            tableviewEmail.isHidden=true
            
            buttonCallMessageEmail.setTitle("Message",  for: UIControl.State.normal)
            
            //  buttonSendMessage.setImage(UIImage(named: "message_blue_New"), forState: .Normal)
            
            
            buttonSendMessage.setTitle("Send",  for: UIControl.State.normal)
            
            
            //print("Message")
            
            buttonOpacity.isHidden=false
            
            viewUpperContact.isHidden=false
            
            tableviewUpperPhoneMessageMail.reloadData()
            
            varCallMessageEmail="Message"
            
            buttonSendMessage.isHidden=false
            
            
            
            buttonPhoness.isUserInteractionEnabled=false
            
            buttonEmailss.isUserInteractionEnabled=false
            
            buttonMessagess.isUserInteractionEnabled=false
            //print("This  is count:-----")
            //print(muarrayGetContactProfileUpper.count)
        }
        
    }
    func functionForDisableEmailIdIconIfNotEmailAvail()
    {
        //buttonEmailss.
        //muarrayGetEmailProfileUpper
        let varGetCount:Int!=mailArray.count
        if(varGetCount>0)
        {
            buttonEmailss.setImage(UIImage(named: "blue_mail"),  for: UIControl.State.normal)
        }
        else
        
        {
            buttonEmailss.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
            
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func buttonEmailClickEvent(_ sender: AnyObject)
    
    {
        
        
        //
        //       if varGetPickerSelectValue=="Family"
        //        {
        //
        //
        //        //buttonEmailss.setImage(UIImage(named: "mail_gray.png"), forState: .Normal)
        //        }
        //        else
        //       {
        
        if(mailArray.count<=0)
        {
            view.self.makeToast("No Email Id available", duration: 2, position: CSToastPositionCenter)
        }
        else
        {
            
            
            
            buttonCallMessageEmail.setTitle("Mail",  for: UIControl.State.normal)
            
            //buttonSendMessage.setImage(UIImage(named: "messageDP.png"), forState: .Normal)
            buttonSendMessage.setTitle("Send",  for: UIControl.State.normal)
            
            
            //print("Email")
            
            buttonOpacity.isHidden=false
            
            viewUpperContact.isHidden=false
            
            tableviewUpperPhoneMessageMail.reloadData()
            
            
            
            varCallMessageEmail="Email"
            
            buttonSendMessage.isHidden=false
            
            tableviewUpperPhoneMessageMail.isHidden=false
            
            tableviewEmail.isHidden=true
            
            
            
            
            
            buttonPhoness.isUserInteractionEnabled=false
            
            buttonEmailss.isUserInteractionEnabled=false
            
            buttonMessagess.isUserInteractionEnabled=false
            tableviewUpperPhoneMessageMail.reloadData()
            
            //print("This  is count:-----")
            //print(muarrayGetEmailProfileUpper.count)
            
        }
        // }
        
        
    }
    
    
    
    @IBAction func buttonCloseClickEvent(_ sender: AnyObject)
    
    {
        
        buttonOpacity.isHidden=true
        
        viewUpperContact.isHidden=true
        
        buttonCallMessageEmail.setTitle("",  for: UIControl.State.normal)
        
        
        
        buttonPhoness.isUserInteractionEnabled=true
        
        buttonEmailss.isUserInteractionEnabled=true
        
        buttonMessagess.isUserInteractionEnabled=true
        
        
        
        
        for i in 0..<muarrayMessage.count
        {
            muarrayMessage.replaceObject(at: i, with: "0")
        }
        for i in 0..<muarrayEmail.count
        {
            muarrayEmail.replaceObject(at: i, with: "0")
        }
        tableviewEmail.reloadData()
        
        
    }
    
    
    
    @IBAction func buttonOpacityClickEvent(_ sender: AnyObject)
    
    {
        
        buttonOpacity.isHidden=true
        
        viewUpperContact.isHidden=true
        
        buttonCallMessageEmail.setTitle("",  for: UIControl.State.normal)
        
        
        
        buttonPhoness.isUserInteractionEnabled=true
        
        buttonEmailss.isUserInteractionEnabled=true
        
        buttonMessagess.isUserInteractionEnabled=true
        
        
        
        for i in 0..<muarrayMessage.count
        {
            muarrayMessage.replaceObject(at: i, with: "0")
        }
        for i in 0..<muarrayEmail.count
        {
            muarrayEmail.replaceObject(at: i, with: "0")
        }
        tableviewEmail.reloadData()
        
        
        
    }
    
    func functionForTemp()
    {
        buttonOpacity.isHidden=true
        
        viewUpperContact.isHidden=true
        
        buttonCallMessageEmail.setTitle("",  for: UIControl.State.normal)
        
        
        
        buttonPhoness.isUserInteractionEnabled=true
        
        buttonEmailss.isUserInteractionEnabled=true
        
        buttonMessagess.isUserInteractionEnabled=true
        
        
        
        for i in 0..<muarrayMessage.count
        {
            muarrayMessage.replaceObject(at: i, with: "0")
        }
        for i in 0..<muarrayEmail.count
        {
            muarrayEmail.replaceObject(at: i, with: "0")
        }
        tableviewEmail.reloadData()
    }
    
    @IBAction func buttonSendMessageClickEvent(_ sender: AnyObject) {
        
        //print("send message")
        
        if(varCallMessageEmail=="Message")
            
        {
            
            SMSAction()
            
        }
        
        else if(varCallMessageEmail=="Email")
                
        {
            //            if(varGetPickerSelectValue == "Family")
            //            {
            //                //buttonSendMessage.setImage(UIImage(named: "mail_gray.png"), forState: .Normal)
            //
            //            }
            //            else
            //            {
            MailAction()
            //}
            
        }
        
    }
    
    func MailAction()
    
    {
        SVProgressHUD.dismiss()
        var arrayEmailAddress = [String]()
        
        var varEmailString = ""
        
        var varISEmailNumberContain:String!="no"
        
        for i in 00..<mailArray.count
                
        {
            
            let varGetValue = muarrayEmail.object(at: i)
            
            if(varGetValue as! String=="1")
                
            {
                
                //                commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                //
                //                commonClassHoldDataAccessibleVariable = muarrayGetEmailProfileUpper.object(at: i) as! CommonAccessibleHoldVariable
                //
                //                let varGetPhoneNumber = commonClassHoldDataAccessibleVariable.varEmailDynamicProfEmail
                
                
                var emailMsg = mailArray[i]
                varEmailString = emailMsg
                arrayEmailAddress.append(emailMsg)
                varISEmailNumberContain="yes"
                
            }
            
        }
        
        if(varISEmailNumberContain=="no")
            
        {
            
            self.view.makeToast("Please select at least one Email id ", duration: 2, position: CSToastPositionCenter)
            
        }
        
        else if(varISEmailNumberContain=="yes")
                
        {
            
            //MFMailComposeViewControllerDelegate
            
            //print("Email Sent")
            
            if MFMailComposeViewController.canSendMail()
            {
                //print(varEmailString)
                
                let mail = MFMailComposeViewController()
                
                mail.mailComposeDelegate = self
                
                mail.setToRecipients(arrayEmailAddress)// gg@hing.co.in
                
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
                
                // ToRecipients([varEmailString])
                
            }
            
            else
            {
                //                let alertView:UIAlertView = UIAlertView()
                //                alertView.title = "Rotary India"
                //                alertView.message = "Please check whether you have logged in to your mail account."
                //                alertView.delegate = self
                //                alertView.addButton(withTitle: "OK")
                //                alertView.show()
                sendEmailFallback(mail: varEmailString)
            }
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    
    {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func createNavigationBar()
    {
        if varGetPickerSelectValue == "Family" || varGetPickerSelectValue == "Classification" || self.from == "BOD" {
            self.navigationItem.setHidesBackButton(true, animated: false)
            //self.title = moduleName
            self.title = "Profile"
            let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
            self.navigationController!.navigationBar.titleTextAttributes = attributes
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
            self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
            
            let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(ProfileDynamicNewViewController.backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            
            
            let shareButton = UIButton(type: UIButton.ButtonType.custom)
            shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
            shareButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.shareContact), for: UIControl.Event.touchUpInside)
            let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
            var buttons:NSArray=NSArray()
            
            self.buttonEditProfileImage.isHidden=false
            //            let settingButton = UIButton(type: UIButton.ButtonType.custom)
            //            settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            //            settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
            //            settingButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.editClicked), for: UIControl.Event.touchUpInside)
            //            let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
            //            //let buttons : NSArray = [search, setting] //14 mar
            buttons = [sharing]
            //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            self.buttonEditsss.isHidden = true
            let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
            saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
            saveContactButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
            let savecontact: UIBarButtonItem = UIBarButtonItem(customView: saveContactButton)
            buttons = [sharing,savecontact]
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        } else {
            self.navigationItem.setHidesBackButton(true, animated: false)
            //self.title = moduleName
            self.title = "Profile"
            let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
            self.navigationController!.navigationBar.titleTextAttributes = attributes
            let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
            self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
            
            let buttonleft = UIButton(type: UIButton.ButtonType.custom)
            buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
            buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
            buttonleft.addTarget(self, action: #selector(ProfileDynamicNewViewController.backClicked), for: UIControl.Event.touchUpInside)
            let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
            self.navigationItem.leftBarButtonItem = leftButton
            
            let shareButton = UIButton(type: UIButton.ButtonType.custom)
            shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
            shareButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.shareContact), for: UIControl.Event.touchUpInside)
            let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
            var buttons:NSArray=NSArray()
            
            let qrButton = UIImageView()
            qrButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            qrButton.image = UIImage(named: "qrDirectory")
            qrButton.contentMode = .scaleAspectFit
            qrButton.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            qrButton.addGestureRecognizer(tapGestureRecognizer)
            let qrCodeSetup: UIBarButtonItem = UIBarButtonItem(customView: qrButton)
            
            self.buttonEditProfileImage.isHidden=false
            let settingButton = UIButton(type: UIButton.ButtonType.custom)
            settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            settingButton.setImage(UIImage(named:"edit_Blue"),  for: UIControl.State.normal)
            settingButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.editClicked), for: UIControl.Event.touchUpInside)
            let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
            //let buttons : NSArray = [search, setting] //14 mar
            buttons = [sharing,setting]
            //self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            self.buttonEditsss.isHidden = true
            let saveContactButton = UIButton(type: UIButton.ButtonType.custom)
            saveContactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            saveContactButton.setImage(UIImage(named:"saveContact"),  for: UIControl.State.normal)
            saveContactButton.addTarget(self, action: #selector(ProfileDynamicNewViewController.savedContactButtonclicked), for: UIControl.Event.touchUpInside)
            let savecontact: UIBarButtonItem = UIBarButtonItem(customView: saveContactButton)
            buttons = (isAdminss=="Yes") ? [sharing,setting,savecontact,qrCodeSetup] : [sharing,savecontact,qrCodeSetup]
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        }
    }
    
    
    
    @objc func savedContactButtonclicked()
    {
        if varGetPickerSelectValue == "Family" {
            var letGetPhoneNumber:String = ""
            letGetPhoneNumber = self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? ""
            var userName = self.famDetailOnline?.tbGetRotarianResult?.result?.memberName ?? ""
            print(letGetPhoneNumber)
            let varGetValue=letGetPhoneNumber
            
            let newContact = CNMutableContact()
            newContact.givenName = userName
            newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue)))
            let contactVC = CNContactViewController(forUnknownContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
            self.navigationController?.pushViewController(contactVC, animated: true)

        } else if varGetPickerSelectValue == "Classification" {
            var letGetPhoneNumber:String = ""
            letGetPhoneNumber = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? ""
            var userName = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberName ?? ""
            print(letGetPhoneNumber)
            let varGetValue=letGetPhoneNumber
            
            let newContact = CNMutableContact()
            newContact.givenName = userName
            newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue)))
            let contactVC = CNContactViewController(forUnknownContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
            self.navigationController?.pushViewController(contactVC, animated: true)
        } else if varGetPickerSelectValue == "ClubProfile" {
            var letGetPhoneNumber:String = ""
            letGetPhoneNumber = self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? ""
            var userName = self.famDetailOnline?.tbGetRotarianResult?.result?.memberName ?? ""
            print(letGetPhoneNumber)
            let varGetValue=letGetPhoneNumber
            
            let newContact = CNMutableContact()
            newContact.givenName = userName
            newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue)))
            let contactVC = CNContactViewController(forUnknownContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
            self.navigationController?.pushViewController(contactVC, animated: true)
        }
        else {
            var letGetPhoneNumber:String = ""
            letGetPhoneNumber = self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile ?? ""
            var userName = self.membersDetailV1?.tbGetRotarianResult?.result?.memberName ?? ""
            print(letGetPhoneNumber)
            let varGetValue=letGetPhoneNumber
            
            let newContact = CNMutableContact()
            newContact.givenName = userName
            newContact.phoneNumbers.append(CNLabeledValue(label: "home", value: CNPhoneNumber(stringValue: varGetValue)))
            let contactVC = CNContactViewController(forUnknownContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
            if #available(iOS 11.0, *) {
                contactVC.additionalSafeAreaInsets.top = self.navigationController?.navigationBar.frame.height ?? 0
            }
            self.navigationController?.pushViewController(contactVC, animated: true)
        }
        
    }
    @objc func backClicked()
    {
        if(ifDirecUnloads==0)
        {
            DispatchQueue.global(qos:.background).async {
                //self.functionForGetZipFilePath()
            }
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- contact share methods
    @objc func shareContact()
    {
        let contact = createContact()
        
        do {
            try shareContacts(contacts: [contact])
        }
        catch {
            // Handle error
        }
    }
    
    func shareContacts(contacts: [CNContact]) throws {
        
        guard let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        var filename = NSUUID().uuidString
        
        // Create a human friendly file name if sharing a single contact.
        if let contact = contacts.first, contacts.count == 1 {
            
            if let fullname = CNContactFormatter().string(from: contact) {
                //filename = fullname.componentsSeparatedBy(" ").joinWithSeparator("")
                filename = fullname.components(separatedBy: " ").joined(separator: "")
            }
        }
        
        let fileURL = directoryURL.appendingPathComponent(filename).appendingPathExtension("vcf")
        
        let data = try CNContactVCardSerialization.data(with: contacts)
        
        print("filename: \(filename)")
        print("contact: \(String(data: data, encoding: String.Encoding.utf8))")
        
        //   try data.writeToURL(fileURL, options: [.AtomicWrite])
        try data.write(to: fileURL, options: [.atomicWrite])
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL],
            applicationActivities: nil
        )
        
        present(activityViewController, animated: true, completion: {})
    }
    
    
    func createContact() -> CNContact {
        
        if varGetPickerSelectValue == "Family" || varGetPickerSelectValue == "ClubProfile"{
            var contactName:String = self.famDetailOnline?.tbGetRotarianResult?.result?.memberName ?? ""
            var mobileNo:String = self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? ""
            var emailID:String = self.famDetailOnline?.tbGetRotarianResult?.result?.email ?? ""
            var addresses:String = self.famDetailOnline?.tbGetRotarianResult?.result?.businessAddress ?? ""
            var city:String = self.famDetailOnline?.tbGetRotarianResult?.result?.city ?? ""
            var state:String = self.famDetailOnline?.tbGetRotarianResult?.result?.state ?? ""
            var country:String = self.famDetailOnline?.tbGetRotarianResult?.result?.country ?? ""
            var postalCode:String = self.famDetailOnline?.tbGetRotarianResult?.result?.pincode ?? ""
           
            
            
            
            // Creating a mutable object to add to the contact
            let contact = CNMutableContact()
            contact.imageData = NSData() as Data // The profile picture as a NSData object
            contact.givenName = contactName
            contact.familyName = ""
            let workEmail = CNLabeledValue(label: CNLabelWork, value: emailID as NSString)
            let homeEmail = CNLabeledValue(label: CNLabelHome , value: "" as NSString)
            contact.emailAddresses = [homeEmail, workEmail]
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberiPhone,
                value:CNPhoneNumber(stringValue:mobileNo))]
            
            
            let address = CNMutablePostalAddress()
            address.street = addresses.trimmingCharacters(in: .newlines)
            address.city = city
            address.state = state
            address.postalCode = postalCode
            address.country = country
            
            let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
            contact.postalAddresses = [workAddress]
            return contact
        } else  if varGetPickerSelectValue == "Classification" {
            var contactName:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberName ?? ""
            var mobileNo:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? ""
            var emailID:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? ""
            var addresses:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessAdress ?? ""
            var city:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.addressDetails?.addressResult?[0].city ?? ""
            var state:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.addressDetails?.addressResult?[0].state ?? ""
            var country:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.addressDetails?.addressResult?[0].country ?? ""
            var postalCode:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.addressDetails?.addressResult?[0].pincode ?? ""
          // Creating a mutable object to add to the contact
            let contact = CNMutableContact()
            contact.imageData = NSData() as Data // The profile picture as a NSData object
            contact.givenName = contactName
            contact.familyName = ""
            let workEmail = CNLabeledValue(label: CNLabelWork, value: emailID as NSString)
            let homeEmail = CNLabeledValue(label: CNLabelHome , value: "" as NSString)
            contact.emailAddresses = [homeEmail, workEmail]
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberiPhone,
                value:CNPhoneNumber(stringValue:mobileNo))]
            
            
            let address = CNMutablePostalAddress()
            address.street = addresses.trimmingCharacters(in: .newlines)
            address.city = city
            address.state = state
            address.postalCode = postalCode
            address.country = country
            
            let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
            contact.postalAddresses = [workAddress]
            return contact
        } else {
            
            var contactName:String = self.membersDetailV1?.tbGetRotarianResult?.result?.memberName ?? ""
            var mobileNo:String = self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile ?? ""
            var emailID:String = self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail ?? ""
            var addresses:String = self.bussAddrsV1
            var city:String = self.busscityV1
            var state:String = self.bussstateV1
            var country:String = self.busscountryV1
            var postalCode:String = self.busspinV1
            
            // Creating a mutable object to add to the contact
            let contact = CNMutableContact()
            contact.imageData = NSData() as Data // The profile picture as a NSData object
            contact.givenName = contactName
            contact.familyName = ""
            let workEmail = CNLabeledValue(label: CNLabelWork, value: emailID as NSString)
            let homeEmail = CNLabeledValue(label: CNLabelHome , value: "" as NSString)
            contact.emailAddresses = [homeEmail, workEmail]
            contact.phoneNumbers = [CNLabeledValue(
                label:CNLabelPhoneNumberiPhone,
                value:CNPhoneNumber(stringValue:mobileNo))]
            
            
            let address = CNMutablePostalAddress()
            address.street = addresses.trimmingCharacters(in: .newlines)
            address.city = city
            address.state = state
            address.postalCode = postalCode
            address.country = country
            
            let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
            contact.postalAddresses = [workAddress]
            return contact
        }
    }
    //MARK:-
    var ifDirecUnloads:Int=0
    /*-------------------------------------------------------------------------------------------------*/
    /*5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
    
    func functionForDeleteMember()
    {
        // loaderClass.loaderViewMethod()
        SVProgressHUD.show()
        buttonProcessing.isHidden=false
        let completeURL = baseUrl+touchBase_DeleteByModuleName
        let parameterst = [
            "typeID" : profileId!,
            "type" : "Member",
            "profileID": varAdminProfileID!            ]
        //print(parameterst)
        //print(completeURL)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            /////-------
            //------------------------------------------------------
            buttonOpacity.isHidden=false
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if(response != nil)
                    {
                        let dd = response.result.value as! NSDictionary
                        
                        //print("dd \(dd)")
                        var varGetValueServerError = dd.object(forKey: "serverError")as? String
                        
                        
                        if(varGetValueServerError == "Error")
                        {
                            self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                            SVProgressHUD.dismiss()
                            self.buttonOpacity.isHidden=true
                        }
                        else
                        {
                            if let value = response.result.value {
                                let dic = response.result.value!
                                let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                                let jsonString = String(data: jsonData!, encoding: .utf8)!
                                //print(jsonString)
                                //--
                                if(response==nil)
                                {
                                }
                                else
                                {
                                    let dd = response.result.value as! NSDictionary
                                    //print("dd \(dd)")
                                    var varGetStatus=(dd.object(forKey: "DeleteResult")! as AnyObject).object(forKey: "status")as! String
                                    print("Result:: \(varGetStatus)")
                                    if(varGetStatus == "0")
                                    {
                                        
                                        var databasePath : String
                                        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
                                        // open database
                                        databasePath = fileURL.path
                                        var db: OpaquePointer? = nil
                                        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
                                        {
                                            //print("error opening database")
                                        }
                                        else
                                        {
                                        }
                                        let contactDB = FMDatabase(path: databasePath as String)
                                        
                                        if contactDB == nil
                                            
                                        {
                                        }
                                        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                                        if (contactDB?.open())!
                                        {
                                            let insertSQL1 = "DELETE   FROM ProfileMaster WHERE profileId="+self.profileId+""
                                            let result1 = contactDB?.executeStatements(insertSQL1)
                                            if (result1 == nil)
                                            {
                                                //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                            }
                                            else
                                            {
                                                //print("success deleted")
                                                //2.
                                                let insertSQL2 = "DELETE   FROM PersonalBusinessMemberDetails WHERE profileId="+self.profileId+""
                                                //print(insertSQL2)
                                                let result2 = contactDB?.executeStatements(insertSQL2)
                                                //3.
                                                let insertSQL3 = "DELETE   FROM AddressDetails WHERE profileId="+self.profileId+""
                                                //print(insertSQL3)
                                                let result3 = contactDB?.executeStatements(insertSQL3)
                                                //4.
                                                let insertSQL4 = "DELETE   FROM FamilyMemberDetail WHERE profileId="+self.profileId+""
                                                //print(insertSQL4)
                                                let result4 = contactDB?.executeStatements(insertSQL4)
                                            }
                                            self.loaderClass.window=nil
                                            //self.view.makeToast("Member  deleted successfully.", duration: 3, position: CSToastPositionCenter)
                                            let alert = UIAlertController(title: "Member", message: "Deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                                                
                                                SVProgressHUD.dismiss()
                                                self.buttonOpacity.isHidden=true
                                                self.buttonOpacity.isHidden=false
                                                self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                                                self.navigationController?.popViewController(animated: true)
                                            }));
                                            self.present(alert, animated: true, completion: nil)
                                            ///go to previous cotroller
                                        }
                                        else
                                        {
                                            self.loaderClass.window=nil
                                            //print("Error: \(contactDB?.lastErrorMessage())")
                                            self.buttonOpacity.isHidden=true
                                        }
                                    }
                                    else
                                    {
                                        self.loaderClass.window=nil
                                        self.view.makeToast("Something went wrong, while deleting member", duration: 3, position: CSToastPositionCenter)
                                        
                                        SVProgressHUD.dismiss()
                                        self.buttonOpacity.isHidden=true
                                    }
                                    SVProgressHUD.dismiss()
                                    self.buttonOpacity.isHidden=true
                                }
                                //----
                            }
                        }
                    }
                case .failure(_): break
                }
            }
        }
        else
        {
            self.loaderClass.window=nil
            self.view.makeToast("Oops! Something went wrong. Please check your Internet Connection and try again.", duration: 3, position: CSToastPositionCenter)
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    
    {
        //print("\(buttonIndex)")
        switch (buttonIndex){
        case 0:
            print("Cancel")
        case 1:
            //print("Save")
            if (NormalMemberOrAdmin=="ForSelf")
                
            {
                self.view.makeToast("You are the Admin , You Can't Delete Yourself.", duration: 3, position: CSToastPositionCenter)
            }
            else
            {
                SVProgressHUD.show()
                functionForDeleteMember()
            }
            
        case 2:
            print("Delete")
        default:
            print("Default")
        }
        
        
        
    }
    
    
    
    /*-----------------------------------------------------------------------------------------------------*/
    
    
    
    
    
    
    
    @objc func deleteClicked()
    {
        
        
        
        let actionSheet = UIActionSheet(title: "Do you want to delete ?", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Yes")
        
        
        
        actionSheet.show(in: self.view)
        
        
        
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let qrCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        qrCodeVC.memName = self.membersDetailV1?.tbGetRotarianResult?.result?.memberName ?? ""
        qrCodeVC.bussName = self.membersDetailV1?.tbGetRotarianResult?.result?.businessName ?? ""
        qrCodeVC.memEmail = self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail ?? ""
        qrCodeVC.mobile = self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile ?? ""
        qrCodeVC.bMail = self.membersDetailV1?.tbGetRotarianResult?.result?.email ?? ""
        qrCodeVC.baddresses = self.bussAddrsV1
        qrCodeVC.bcity = self.busscityV1
        qrCodeVC.bstate = self.bussstateV1
        qrCodeVC.bpostalCode = self.busspinV1
        qrCodeVC.bcountry = self.busscountryV1
        qrCodeVC.web = self.membersDetailV1?.tbGetRotarianResult?.result?.websiteTxt ?? ""
        qrCodeVC.lnkd = self.membersDetailV1?.tbGetRotarianResult?.result?.linkedInTxt ?? ""
        qrCodeVC.yt = self.membersDetailV1?.tbGetRotarianResult?.result?.youtubeTxt ?? ""
        qrCodeVC.fb = self.membersDetailV1?.tbGetRotarianResult?.result?.faceBookTxt ?? ""
        qrCodeVC.twit = self.membersDetailV1?.tbGetRotarianResult?.result?.twitterTxt ?? ""
        qrCodeVC.insta = self.membersDetailV1?.tbGetRotarianResult?.result?.instagramTxt ?? ""
        self.navigationController?.pushViewController(qrCodeVC, animated: false)
      }
    
    
    @objc func editClicked()
    
    {
        if self.varGetPickerSelectValue == "ClubProfile" {
            let userId = UserDefaults.standard.string(forKey: "userID")
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            print("userId:: \(userId)")
            print("mastersId:: \(mainMemberID)")
            if let masteruid = mainMemberID, let userID = userId {
                print(masteruid)
                
                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                editProfileScreen.varOpenUrl = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(masteruid)&isadmin=\(userID)"
                editProfileScreen.navTitle = "Edit Profile"
                print(editProfileScreen.varOpenUrl)
                self.navigationController?.pushViewController(editProfileScreen, animated: true)
                
//                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//                editProfileScreen.url = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(masteruid)&isadmin=\(userID)"
//                editProfileScreen.moduleName = "Edit Profile"
//                editProfileScreen.varFromCalling = "Edit Profile"
//                print(editProfileScreen.URLstr)
//                self.navigationController?.pushViewController(editProfileScreen, animated: true)
            }
        } else {
            let userId = UserDefaults.standard.string(forKey: "userID")
            print("userId:: \(userId)")
            print("mastersId:: \(self.mastersId)")
            if let masteruid = self.mastersId, let userID = userId {
                print(masteruid)
                
                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                editProfileScreen.varOpenUrl = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(masteruid)&isadmin=\(userID)"
                editProfileScreen.navTitle = "Edit Profile"
                print(editProfileScreen.varOpenUrl)
                self.navigationController?.pushViewController(editProfileScreen, animated: true)
                
//                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
//                editProfileScreen.url = "https://profile.rotaryindia.org/?fk_main_member_master_id=\(masteruid)&isadmin=\(userID)"
//                editProfileScreen.moduleName = "Edit Profile"
//                editProfileScreen.varFromCalling = "Edit Profile"
//                print(editProfileScreen.URLstr)
//                self.navigationController?.pushViewController(editProfileScreen, animated: true)
            }
        }
    }
    
    
    
//    override func viewDidAppear(_ animated: Bool)
//    {
//        tableviewAllInformation.delegate = self
//        tableviewAllInformation.dataSource = self
//        //   tableviewAllInformation.setNeedsLayout()
//        tableviewAllInformation.reloadData()
//        //print("151151515151515151515151",self.tableviewAllInformation.frame.origin.y)
//    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if varGetPickerSelectValue == "Family"{
            print("profileID::--- \(self.profileId)")
            self.loadFamilyDetail(profileID: self.profileId)
        } else if varGetPickerSelectValue == "Classification"{
            print("profileID::--- \(self.profileId)")
            self.loadClassificationDetail(profileID: self.profileId, groupID: self.grpID)
        } else if varGetPickerSelectValue == "ClubProfile"{
            self.loadClubProfile()
        } else if varGetPickerSelectValue == "Rotarian" {
            self.loadDirMemberDetailV1(profileID: self.profileId)
//            self.loadDirMemberDetailV1(profileID: "844094")
        }
        if fromBOD == true {
            if mob != "" {
                lblKeyArray.append("Mobile Number")
                lblValueArray.append(mob)
            }
            if secMob != "" {
                lblKeyArray.append("Secondary Mobile Number")
                lblValueArray.append(secMob)
            }
            if mail != "" {
                lblKeyArray.append("Email ID")
                lblValueArray.append(mail)
            }
            if bEmail != "" {
                lblKeyArray.append("Business Email ID")
                lblValueArray.append(bEmail)
            }
            if bName != "" {
                lblKeyArray.append("Business Name")
                lblValueArray.append(bName)
            }
            if desgn != "" {
                print("desgn: \(desgn)")
                lblKeyArray.append("Designation")
                lblValueArray.append(desgn)
            }
            if bAddrs != "" {
                lblKeyArray.append("Business Address")
                lblValueArray.append(bAddrs)
            }
            if bCntcNo != "" {
                lblKeyArray.append("Business Contact No.")
                lblValueArray.append(bCntcNo)
            }
            if classifica != "" {
                lblKeyArray.append("Classification")
                lblValueArray.append(classifica)
            }
            if kayProf != "" {
                lblKeyArray.append("Keywords about your profession")
                lblValueArray.append(kayProf)
            }
            if rotarId != "" {
                lblKeyArray.append("Rotary ID")
                lblValueArray.append(rotarId)
            }
            if clubDesgn != "" {
                lblKeyArray.append("Club Designation")
                lblValueArray.append(clubDesgn)
            }
            if donor != "" {
                lblKeyArray.append("Donor Recognition")
                lblValueArray.append(donor)
            }
            if bthday != "" {
                lblKeyArray.append("Birthday")
                lblValueArray.append(bthday)
            }
            if anniDate != "" {
                lblKeyArray.append("Anniversary Date")
                lblValueArray.append(anniDate)
            }
            if bldGrp != "" {
                lblKeyArray.append("Blood group")
                lblValueArray.append(bldGrp)
            }
            if resAddres != "" {
                lblKeyArray.append("Residence Address")
                lblValueArray.append(resAddres)
            }
            if mother != "" {
                lblKeyArray.append(relati)
                lblValueArray.append(mother)
            }
            if resMob != "" {
                lblKeyArray.append("Mobile")
                lblValueArray.append(resMob)
            }
            if famImg != "" {
                lblKeyArray.append("Family Photo")
                lblValueArray.append(famImg)
            }
            if memIntro != "" {
                lblKeyArray.append("Member Introduction")
                lblValueArray.append(memIntro)
            }
            if fb != "" {
                lblKeyArray.append("Facebook")
                lblValueArray.append(fb)
            }
            if insta != "" {
                lblKeyArray.append("Instagram")
                lblValueArray.append(insta)
            }
            if lnkdin != "" {
                lblKeyArray.append("Linkedin")
                lblValueArray.append(lnkdin)
            }
            if web != "" {
                lblKeyArray.append("Website")
                lblValueArray.append(web)
            }
            if yt != "" {
                lblKeyArray.append("Youtube")
                lblValueArray.append(yt)
            }
            if twit != "" {
                lblKeyArray.append("Twitter")
                lblValueArray.append(twit)
            }
            //print("This is group name :'''!!!!!!!")
        }
        
        print("lblKeyArray-------\(lblKeyArray)")
        print("lblValueArray-------\(lblValueArray)")
        
        
        self.edgesForExtendedLayout=[]
        buttonProcessing.isHidden=true
        
        
        //print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",profileId , masterId)
        //       viewTwo.isHidden=true
        
        buttonCalcelPopupCallSmsEmail.layer.borderWidth = 1
        buttonCalcelPopupCallSmsEmail.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        buttonCalcelPopupCallSmsEmail.layer.cornerRadius = 5
        
        
        
        let lineView2 = UIView(frame: CGRect(x: 0, y: 0, width: buttonCalcelPopupCallSmsEmail.frame.size.width, height: 1))
        lineView2.backgroundColor=UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        buttonSendMessage.addSubview(lineView2)
        buttonSendMessage.layer.borderWidth = 1
        buttonSendMessage.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        varISPhotoAvailable=""
        if(FromDistrictOrBOD=="FromDistrictOrBOD" &&  self.isCategory=="2")
        {
            
            if(ClubNameFotShowProfile.characters.count>2)
            {
                //                self.lblClubDesignation.text! = self.ClubNameFotShowProfile+" (Club)"
                
            }
            else
            {
                //                self.lblClubDesignation.text! = self.ClubNameFotShowProfile
                
            }
        }
        
        functionForViewDidLoad()
        createNavigationBar()
        muarrayGetContactProfileUpper=NSMutableArray()
        muarrayGetEmailProfileUpper=NSMutableArray()
        muarrayAllInformation=NSMutableArray()
        self.edgesForExtendedLayout = []
        viewUpperContact.isHidden=true
        buttonOpacity.isHidden=true
        varCallMessageEmail="Phone"
        buttonCallMessageEmail.setTitle("Call",  for: UIControl.State.normal)
        buttonSendMessage.isHidden=true
        muarrayMessage=NSMutableArray()
        
        for i in 00..<100
        {
            muarrayMessage.add("0")
        }
        
        muarrayEmail=NSMutableArray()
        
        for i in 00..<100
                
        {
            muarrayEmail.add("0")
        }
        
        // Do any additional setup after loading the view.
        tableviewAllInformation.tag=3
        tableviewUpperPhoneMessageMail.tag=1
        tableviewEmail.isHidden=true
        //
        if self.isCategory=="2"
        {
            functionForFetchOtherDetailsFromPersonalBusinessTablesForDistrict()
        }
        else
        {
            functionForFetchOtherDetailsFromPersonalBusinessTables()
        }
        
        buttonPhoness.isUserInteractionEnabled=true
        buttonEmailss.isUserInteractionEnabled=true
        buttonMessagess.isUserInteractionEnabled=true
        
        //        downloadImage(from: userImg) { downloadedImage in
        //            // Use the downloaded image here
        //            DispatchQueue.main.async {
        //                if let image = downloadedImage {
        //                    // Set the downloaded image to an existing UIImageView
        //                    self.imageUserImage.image = image
        //                } else {
        //                    // Handle the case where the image couldn't be downloaded
        //                    print("Failed to download image")
        //                }
        //            }
        //        }
        
        if userImg == ""  || userImg == "profile_photo.png"
        {
            self.imageUserImage.image = UIImage(named: "profile_pic")
        }
        else
        {
            
            // /*------------------------------Code by --------------------DPK--------------------------- */
            let ImageProfilePic:String = userImg.replacingOccurrences(of: " ", with: "%20")
            print("ImageProfilePic: \(ImageProfilePic)")
            let checkedUrl = URL(string: ImageProfilePic)
            self.imageUserImage.sd_setImage(with: checkedUrl)
            
        }
        
        //        functionForGetContactNumberFromProfileBusinessAddressDetailProMaster()
        functionForGetEmailAddressFromProfileBusinessAddressDetailProMaster()
        print("userNam \(userNam)")
        self.labelUsername.text = userNam
        tableviewUpperPhoneMessageMail.reloadData()
        if fromBOD == true {
            if !(mob == "") {
                phnArray.append(mob)
            }
            if !(secMob == "") {
                phnArray.append(secMob)
            }
            if !(mail == "") {
                mailArray.append(mail)
            }
        }
    }
    
    func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    func loadDirMemberDetailV1(profileID: String?) {
        
        if let profileIdd = profileID {
            
            let completeURL = baseUrl + dirMemberDetailV1
            
            let parameterst = ["memberProfileId": profileIdd]
            
            print("loadDirMemberDetailV1y parameterst:: \(parameterst)")
            print("loadDirMemberDetailV1 completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                    if let value = response.result.value {
                        do {
                            // Attempt to decode the JSON data
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(MemberDetailV1.self, from: jsonData)
                            print("Decoded Data loadDirMemberDetailV1:--- \(decodedData)")
                            self.membersDetailV1 = decodedData
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.pic == ""  || self.membersDetailV1?.tbGetRotarianResult?.result?.pic == "profile_photo.png"
                            {
                                self.imageUserImage.image = UIImage(named: "profile_pic")
                            }
                            else
                            {
                                let ImageProfilePic:String = self.membersDetailV1?.tbGetRotarianResult?.result?.pic?.replacingOccurrences(of: " ", with: "%20") ?? ""
                                print("ImageProfilePic: \(ImageProfilePic)")
                                let checkedUrl = URL(string: ImageProfilePic)
                                self.imageUserImage.sd_setImage(with: checkedUrl)
                            }
                            self.labelUsername.text = self.membersDetailV1?.tbGetRotarianResult?.result?.memberName
                            self.phnArray.removeAll()
                            if (self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile != "") {
                                self.phnArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile ?? "")
                            }
                            if (self.membersDetailV1?.tbGetRotarianResult?.result?.secondaryMobile != "") {
                                self.phnArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
                            }
                            self.mailArray.removeAll()
                            if (self.membersDetailV1?.tbGetRotarianResult?.result?.email != "") {
                                self.mailArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.email ?? "")
                            }
                            if (self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail != "") {
                                self.mailArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile != "" {
                                self.lblKeyArray.append("Mobile Number")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberMobile ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.secondaryMobile != "" {
                                self.lblKeyArray.append("Secondary Mobile Number")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail != "" {
                                self.lblKeyArray.append("Email ID")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberEmail ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.rotaryid != "" {
                                self.lblKeyArray.append("Rotary ID")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.rotaryid ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.designation != "" {
                                self.lblKeyArray.append("Designation")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.designation ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.clubName != "" {
                                self.lblKeyArray.append("Club Name")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.clubName ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.clubDesignation != "" {
                                self.lblKeyArray.append("Club Designation")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.clubDesignation ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.districtDesignation != "" {
                                self.lblKeyArray.append("District Designation")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.districtDesignation ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.classification != "" {
                                self.lblKeyArray.append("Classification")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.classification ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.donorRecognition != "" {
                                self.lblKeyArray.append("Donor Recognition")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.donorRecognition ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfBirth != "" {
                                self.lblKeyArray.append("Birth Date")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfBirth ?? "")
//                                let date = self.convertDateToWords(dateString:self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfBirth ?? "")
//                                let date = self.convertDateToMonth(dateString:self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfBirth ?? "")
//                                self.lblValueArray.append(date ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfWedding != "" {
                                self.lblKeyArray.append("Wedding Date")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfWedding ?? "")
//                                let date = self.convertDateToWords(dateString:self.membersDetailV1?.tbGetRotarianResult?.result?.memberDateOfWedding ?? "")
//                                self.lblValueArray.append(date ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.bloodGroup != "" {
                                self.lblKeyArray.append("Blood group")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.bloodGroup ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.businessName != "" {
                                self.lblKeyArray.append("Business Name")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.businessName ?? "")
                            }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessDesignation != "" {
//                                    self.lblKeyArray.append("Business Designation")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessDesignation ?? "")
//                                }
//                                if self.membersDetailV1?.tbGetRotarianResult?.result?.businessAddress != "" {
//                                    self.lblKeyArray.append("Business Address")
//                                    self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.businessAddress ?? "")
//                                }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessPhoneNo != "" {
//                                    self.lblKeyArray.append("Business Contact No.")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessPhoneNo ?? "")
////                                    self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
//                                }
                           
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.keywords != "" {
                                self.lblKeyArray.append("Keywords about your profession")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.keywords ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.familyPic != "" {
                                self.lblKeyArray.append("Family Photo")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.familyPic ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.memberInfo != "" {
                                self.lblKeyArray.append("Member Introduction")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.memberInfo ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.faceBookTxt != "" {
                                self.lblKeyArray.append("Facebook")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.faceBookTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.instagramTxt != "" {
                                self.lblKeyArray.append("Instagram")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.instagramTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.linkedInTxt != "" {
                                self.lblKeyArray.append("Linkedin")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.linkedInTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.youtubeTxt != "" {
                                self.lblKeyArray.append("Youtube")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.youtubeTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.twitterTxt != "" {
                                self.lblKeyArray.append("Twitter")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.twitterTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.websiteTxt != "" {
                                self.lblKeyArray.append("Website")
                                self.lblValueArray.append(self.membersDetailV1?.tbGetRotarianResult?.result?.websiteTxt ?? "")
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.familylistOutput?.count ?? 0 > 0 {
                                if let familyMem = self.membersDetailV1?.tbGetRotarianResult?.result?.familylistOutput {
                                    for famMem in familyMem {
                                        if famMem.relation != ""{
                                            self.lblKeyArray.append("Relation")
                                            self.lblValueArray.append(famMem.relation ?? "")
                                        }
                                        if famMem.relativeName != ""{
                                            self.lblKeyArray.append("Relative Name")
                                            self.lblValueArray.append(famMem.relativeName ?? "")
                                        }
                                        if famMem.mob != ""{
                                            self.lblKeyArray.append("Mobile Number")
                                            self.lblValueArray.append(famMem.mob ?? "")
                                        }
                                        if famMem.emailID != ""{
                                            self.lblKeyArray.append("Email ID")
                                            self.lblValueArray.append(famMem.emailID ?? "")
                                        }
                                        if famMem.birth != "" {
                                            self.lblKeyArray.append("Birth Date")
//                                            let date = self.convertMonthToDate(dateString:famMem.birth ?? "")
//                                            let dateMonth = self.convertMonthToWords(dateString: date ?? "")
                                            self.lblValueArray.append(famMem.birth ?? "")
                                        }
                                        if famMem.anniversary != "" {
                                            self.lblKeyArray.append("Anniversary Date")
//                                            let date = self.convertMonthToDate(dateString:famMem.anniversary ?? "")
//                                            let dateMonth = self.convertDateToWords(dateString: date ?? "")
                                            self.lblValueArray.append(famMem.anniversary ?? "")
                                        }
                                        if famMem.bloodGroup != "" {
                                            self.lblKeyArray.append("BloodGroup")
                                            self.lblValueArray.append(famMem.bloodGroup ?? "")
                                        }
                                    }
                                }
                            }
                            if self.membersDetailV1?.tbGetRotarianResult?.result?.address?.count ?? 0 > 0 {
                                if let address = self.membersDetailV1?.tbGetRotarianResult?.result?.address {
                                    for adrs in address {
                                        if adrs.address != "" {
                                            if adrs.addressType == "Residence" {
                                                self.lblKeyArray.append("Residence Address")
                                                var adrsType = (adrs.address ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.city ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.state ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.country ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.pincode ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.phoneNo ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.fax ?? "")
                                                adrsType.append(". ")
                                                self.lblValueArray.append(adrsType)
                                            } else if adrs.addressType == "Business" {
                                                self.lblKeyArray.append("Business Address")
                                                var adrsType = (adrs.address ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.city ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.state ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.country ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.pincode ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.phoneNo ?? "")
                                                adrsType.append(", ")
                                                adrsType.append(adrs.fax ?? "")
                                                adrsType.append(". ")
                                                self.lblValueArray.append(adrsType)
                                                self.bussAddrsV1 = adrs.address ?? ""
                                                self.busscityV1 = adrs.city ?? ""
                                                self.busspinV1 = adrs.pincode ?? ""
                                                self.bussstateV1 = adrs.state ?? ""
                                                self.busscountryV1 = adrs.country ?? ""
                                            }
                                        }
                                    }
                                }
                            }
                            
                            self.tableviewAllInformation.reloadData()
                            SVProgressHUD.dismiss()
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func loadFamilyDetail(profileID: String?) {
        
        if let profileIdd = profileID {
            
            let completeURL = baseUrl + dirFamilyDetail
            
            let parameterst = ["memberProfileId": profileIdd]
            
            print("Club Online Directory parameterst:: \(parameterst)")
            print("Club Online Directory completeURL:: Club Online Directory completeURL:: \(completeURL)")
            
            //------------------------------------------------------
            Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    
                    
                    if let value = response.result.value {
                        do {
                            // Attempt to decode the JSON data
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(FamilyDetailes.self, from: jsonData)
                            
                            // Access the properties of the decoded data
                            print("Decoded Data Club Profile:--- \(decodedData)")
                            self.famDetailOnline = decodedData
                            if let fam = self.varGetPickerSelectValue {
                                print("fam---- \(fam)")
                                if fam == "Family" {
                                    print("<><><><<<><><><><><><><><><><><><><><><><>><><<")
                                    for i in 0 ..< (self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?.count ?? 0) {
                                        if self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].relation != "" {
                                            self.lblKeyArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].relation ?? "")
                                            self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].relativeName ?? "")
                                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].mob != "") {
                                                self.lblKeyArray.append("Mobile")
                                                self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].mob ?? "")
                                            }
                                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].emailID != "") {
                                                self.lblKeyArray.append("Email")
                                                self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].emailID ?? "")
                                            }
                                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].birth != "") {
                                                self.lblKeyArray.append("Birthday")
//                                                let date = self.convertDateToMonth(dateString: self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].birth ?? "")
                                                self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].birth ?? "")
                                              }
                                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].anniversary != "") {
                                                self.lblKeyArray.append("Anniversary")
//                                                let date = self.convertDateToMonth(dateString:self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].anniversary ?? "")
                                                self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familylistOutput?[i].anniversary ?? "")
                                           }
                                            
                                            print("KEYS------ \(self.lblKeyArray)")
                                            print("VALUES------ \(self.lblValueArray)")
                                        }
                                    }
                                    self.phnArray.removeAll()
                                    if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile != "") {
                                        self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? "")
                                    }
                                    if (self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile != "") {
                                        self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
                                    }
                                    self.mailArray.removeAll()
                                    if (self.famDetailOnline?.tbGetRotarianResult?.result?.email != "") {
                                        self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.email ?? "")
                                    }
                                    if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail != "") {
                                        self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail ?? "")
                                    }
                                }
                            }
                            
                            if self.famDetailOnline?.tbGetRotarianResult?.result?.pic == ""  || self.famDetailOnline?.tbGetRotarianResult?.result?.pic == "profile_photo.png"
                            {
                                self.imageUserImage.image = UIImage(named: "profile_pic")
                            }
                            else
                            {
                                
                                // /*------------------------------Code by --------------------DPK--------------------------- */
                                let ImageProfilePic:String = self.famDetailOnline?.tbGetRotarianResult?.result?.pic?.replacingOccurrences(of: " ", with: "%20") ?? ""
                                print("ImageProfilePic: \(ImageProfilePic)")
                                let checkedUrl = URL(string: ImageProfilePic)
                                self.imageUserImage.sd_setImage(with: checkedUrl)
                                
                            }
                            
                            self.phnArray.removeAll()
                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile != "") {
                                self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? "")
                            }
                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile != "") {
                                self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
                            }
                            self.mailArray.removeAll()
                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.email != "") {
                                self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.email ?? "")
                            }
                            if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail != "") {
                                self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail ?? "")
                            }
                            
                            self.labelUsername.text = self.famDetailOnline?.tbGetRotarianResult?.result?.memberName
                            self.lblClubDesignation.text = self.famDetailOnline?.tbGetRotarianResult?.result?.clubName
                            self.tableviewAllInformation.reloadData()
                            SVProgressHUD.dismiss()
                            //                                 self.tableviewAllInformation.reloadData()
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
    
    func loadClubProfile() {
        
//        if let grpID = groupID {
            let completeURL = baseUrl + dirFamilyDetail
            var profID: String?
            profID = UserDefaults.standard.string(forKey: "grpProfileID")
            if let profileID = profID {
                
                let parameterst = ["memberProfileId":profID!]
                
                print("Club Profile Directory parameterst:: \(parameterst)")
                print("Club Profile Directory completeURL:: \(completeURL)")
                
                //------------------------------------------------------
                
                Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    switch response.result {
                    case .success:
                        
                        
                        if let value = response.result.value {
                            do {
                                // Attempt to decode the JSON data
                                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(FamilyDetailes.self, from: jsonData)
                                
                                // Access the properties of the decoded data
                                print("Decoded Data CLUB PROFILE:--- \(decodedData)")
                                self.famDetailOnline = decodedData
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.pic == ""  || self.famDetailOnline?.tbGetRotarianResult?.result?.pic == "profile_photo.png"
                                {
                                    self.imageUserImage.image = UIImage(named: "profile_pic")
                                }
                                else
                                {
                                    let ImageProfilePic:String = self.famDetailOnline?.tbGetRotarianResult?.result?.pic?.replacingOccurrences(of: " ", with: "%20") ?? ""
                                    print("ImageProfilePic: \(ImageProfilePic)")
                                    let checkedUrl = URL(string: ImageProfilePic)
                                    self.imageUserImage.sd_setImage(with: checkedUrl)
                                }
                                self.labelUsername.text = self.famDetailOnline?.tbGetRotarianResult?.result?.memberName
                                
                                self.phnArray.removeAll()
                                if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile != "") {
                                    self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? "")
                                }
                                if (self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile != "") {
                                    self.phnArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
                                }
                                self.mailArray.removeAll()
                                if (self.famDetailOnline?.tbGetRotarianResult?.result?.email != "") {
                                    self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.email ?? "")
                                }
                                if (self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail != "") {
                                    self.mailArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail ?? "")
                                }
                                
                                
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile != "" {
                                    self.lblKeyArray.append("Mobile Number")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberMobile ?? "")
//                                    self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile != "" {
                                    self.lblKeyArray.append("Secondary Mobile Number")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.secondaryMobile ?? "")
//                                    self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail != "" {
                                    self.lblKeyArray.append("Email ID")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberEmail ?? "")
//                                    self.mailArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.rotaryid != "" {
                                    self.lblKeyArray.append("Rotary ID")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.rotaryid ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.clubDesignation != "" {
                                    self.lblKeyArray.append("Club Designation")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.clubDesignation ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.classification != "" {
                                    self.lblKeyArray.append("Classification")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.classification ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.donorRecognition != "" {
                                    self.lblKeyArray.append("Donor Recognition")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.donorRecognition ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.memberDateOfBirth != "" {
                                    self.lblKeyArray.append("Birthday")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberDateOfBirth ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.bloodGroup != "" {
                                    self.lblKeyArray.append("Blood group")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.bloodGroup ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessName != "" {
                                    self.lblKeyArray.append("Business Name")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessName ?? "")
                                }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessDesignation != "" {
//                                    self.lblKeyArray.append("Business Designation")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessDesignation ?? "")
//                                }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessAdress != "" {
//                                    self.lblKeyArray.append("Business Address")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessAdress ?? "")
//                                }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.businessPhoneNo != "" {
//                                    self.lblKeyArray.append("Business Contact No.")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.businessPhoneNo ?? "")
////                                    self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
//                                }
                               
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.keywords != "" {
                                    self.lblKeyArray.append("Keywords about your profession")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.keywords ?? "")
                                }
//                                if self.famDetailOnline?.tbGetRotarianResult?.result?.familyPic != "" {
//                                    self.lblKeyArray.append("Family Photo")
//                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.familyPic ?? "")
//                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.memberInfo != "" {
                                    self.lblKeyArray.append("Member Introduction")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.memberInfo ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.faceBookTxt != "" {
                                    self.lblKeyArray.append("Facebook")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.faceBookTxt ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.instagramTxt != "" {
                                    self.lblKeyArray.append("Instagram")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.instagramTxt ?? "")
                                }
                                if self.famDetailOnline?.tbGetRotarianResult?.result?.linkedInTxt != "" {
                                    self.lblKeyArray.append("Linkedin")
                                    self.lblValueArray.append(self.famDetailOnline?.tbGetRotarianResult?.result?.linkedInTxt ?? "")
                                }
                                       
                                self.tableviewAllInformation.reloadData()
                                SVProgressHUD.dismiss()
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
    
    func loadClassificationDetail(profileID: String?, groupID: String?) {
        
        if let profileIdd = profileID, let grpID = groupID {
            
            let completeURL = baseUrl + dirClassificationDetail
            
            let parameterst = ["memberProfileId":profileIdd,"groupId":grpID]
            
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
                            let decodedData = try decoder.decode(ClassificationDetail.self, from: jsonData)
                            
                            // Access the properties of the decoded data
                            print("Decoded Data:--- \(decodedData)")
                            self.classificationMemberDetails = decodedData
                            self.phnArray.removeAll()
                            self.mailArray.removeAll()
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile != "" {
                                self.lblKeyArray.append("Mobile Number")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? "")
                                self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberMobile ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile != "" {
                                self.lblKeyArray.append("Secondary Mobile Number")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile ?? "")
                                self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.secondaryMobile ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail != "" {
                                self.lblKeyArray.append("Email ID")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? "")
                                self.mailArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberEmail ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.rotaryid != "" {
                                self.lblKeyArray.append("Rotary ID")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.rotaryid ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubDesignation != "" {
                                self.lblKeyArray.append("Club Designation")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubDesignation ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.classification != "" {
                                self.lblKeyArray.append("Classification")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.classification ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.donorRecognition != "" {
                                self.lblKeyArray.append("Donor Recognition")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.donorRecognition ?? "")
                            }
                            
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfBirth != "" {
                                self.lblKeyArray.append("Birthday")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfBirth ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfWedding != "" {
                                self.lblKeyArray.append("Anniversary")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberDateOfWedding ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.bloodGroup != "" {
                                self.lblKeyArray.append("Blood group")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.bloodGroup ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessName != "" {
                                self.lblKeyArray.append("Business Name")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessName ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessDesignation != "" {
                                self.lblKeyArray.append("Business Designation")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessDesignation ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessAdress != "" {
                                self.lblKeyArray.append("Business Address")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessAdress ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo != "" {
                                self.lblKeyArray.append("Business Contact No.")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
                                self.phnArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.businessPhoneNo ?? "")
                            }
                           
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.keywords != "" {
                                self.lblKeyArray.append("Keywords about your profession")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.keywords ?? "")
                            }
                        
                            
//                            if mother != "" {
//                                lblKeyArray.append(relati)
//                                lblValueArray.append(mother)
//                            }
//                            if resMob != "" {
//                                lblKeyArray.append("Mobile")
//                                lblValueArray.append(resMob)
//                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.familyPic != "" {
                                self.lblKeyArray.append("Family Photo")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.familyPic ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberInfo != "" {
                                self.lblKeyArray.append("Member Introduction")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberInfo ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.faceBookTxt != "" {
                                self.lblKeyArray.append("Facebook")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.faceBookTxt ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.instagramTxt != "" {
                                self.lblKeyArray.append("Instagram")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.instagramTxt ?? "")
                            }
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.linkedInTxt != "" {
                                self.lblKeyArray.append("Linkedin")
                                self.lblValueArray.append(self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.linkedInTxt ?? "")
                            }
                            
                            self.labelUsername.text = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.memberName
                            self.lblClubDesignation.text = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.clubName
                            if self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic == ""  || self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic == "profile_photo.png"
                            {
                                self.imageUserImage.image = UIImage(named: "profile_pic")
                            }
                            else
                            {
                                
                                // /*------------------------------Code by --------------------DPK--------------------------- */
                                let ImageProfilePic:String = self.classificationMemberDetails?.memberListDetailResult?.memberDetails?.profilePic?.replacingOccurrences(of: " ", with: "%20") ?? ""
                                print("ImageProfilePic: \(ImageProfilePic)")
                                let checkedUrl = URL(string: ImageProfilePic)
                                self.imageUserImage.sd_setImage(with: checkedUrl)
                                
                            }
                            SVProgressHUD.dismiss()
                            self.tableviewAllInformation.reloadData()
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
    
    
    func functionForGetUSerImageFromProfileMaster()
    
    {
        var databasePath : String
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        
        // open database
        
        databasePath = fileURL.path
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            
            //print("error opening database")
        }else{
            // self.Createtablecity()
        }
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB == nil {
            
            //print("Error: \(contactDB?.lastErrorMessage())")
            
        }
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        
        if (contactDB?.open())! {
            //SELECT * FROM ProfileMaster
            //print(profileId)
            // WHERE (membername LIKE '%ande%' OR membermobile LIKE '%1234567%' )
            //print("<<<<<-------@@@@@----->>>>>>>>>")
            //print("SELECT DISTINCT profilePic FROM ProfileMaster where  profileId='"+profileId+"'")
            print(profileId)
            if profileId != nil && profileId != ""
            {
                let querySQL = "SELECT DISTINCT profilePic FROM ProfileMaster where  profileId='"+profileId+"'"
                print(querySQL)
                let results:FMResultSet? = contactDB?.executeQuery(querySQL,withArgumentsIn: nil)
                var varGetImage:String!=""
                while results?.next() == true
                {
                    varGetImage=results?.string(forColumn: "profilePic")
                }
                //print("99999999999999999999999999999999999999",varGetImage)
                if(varGetImage == "")
                    
                {
                    imageUserImage.image = UIImage(named: "profile_pic.png")
                    //print("Default55565656565656565656565656565656565")
                }
                else
                {
                    
                    let ImageProfilePic:String = varGetImage!.replacingOccurrences(of: " ", with: "%20")
                    /*------------------------------Code by --------------------DPK-------------31-08-2017-------------- */
                    let checkedUrl = URL(string: ImageProfilePic)
                    imageUserImage.sd_setImage(with: checkedUrl)
                    isUpperImageAvailable=ImageProfilePic
                    functionForTemp()
                    /*------------------------------Code by --------------------DPK--------------------------- */
                    /*
                     
                     if let checkedUrl = NSURL(string: ImageProfilePic) {
                     KingfisherManager.sharedManager.retrieveImageWithURL(checkedUrl, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                     //print(image)
                     self.imageUserImage.image = image
                     
                     //print("æææææææ««««««««………………………………………¬¬¬¬˚˚˚∆˚˚∆˙∆˙∆˚˙˚∆˙˙©˙˙©˙©ƒ˙©∂ƒ©ƒ∞´§∞¢∑≈¶£¶∞¢£¨§∞®´¥†®†¥ç®")
                     })
                     
                     }
                     */
                }
            }
        }
    }
    
    var isUpperImageAvailable:String!="0"
    
    override func viewWillAppear(_ animated: Bool)
    
    {
        //functionForGetZipFilePath()
        
        //functionForGetUSerImageFromProfileMaster()
        
    }
    
    func functionForViewDidLoad()
    
    {
        
        //print(profileId)
        
        muarrayKeyFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayValueFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryTextFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryCodeFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryIdFirst=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        //second
        
        muarrayAddressSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCitySecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayPostalCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayStateSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayAddressIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryTextSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBusinessContactCountryTextSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBusinessContactCountryCodeSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBusinessContactCountryIdSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBusinessContactMobileNumberSecond=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        //three
        
        muarrayNameThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayFamilyMemberIDThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayFamilyMemberDeletedIDThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayRelationshipThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryTextThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryCodeThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayCountryIdThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayMobileNumberThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayEmailIDThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBloodGroupThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayBirthdayThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        muarrayAnniversaryThree=["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
        
        imageUserImage.layer.borderWidth = 1.0
        imageUserImage.contentMode = .scaleAspectFit
        imageUserImage.layer.masksToBounds = false
        imageUserImage.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imageUserImage.layer.cornerRadius = imageUserImage.frame.size.width/2
        imageUserImage.clipsToBounds = true
        
        functionForGetUSerImageFromProfileMaster()
        
    }
    
    override func didReceiveMemoryWarning()
    
    {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    //call and sms
    
    func functionForGetContactNumberFromProfileBusinessAddressDetailProMaster()
    
    {
        
        var databasePath : String
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        
        // open database
        
        databasePath = fileURL.path
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            
        {
            
            //print("error opening database")
            
        }
        
        else
        
        {
            
            // self.Createtablecity()
            
        }
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB == nil
            
        {
            
            //print("Error: \(contactDB?.lastErrorMessage())")
            
        }
        
        if (contactDB?.open())!
            
        {
            
            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT uniquekey,value from PersonalBusinessMemberDetails where  profileId="+profileId+" and isVisible='y'"
            
            print(querySQLPersonalBusinessMemberDetails)
            
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            
            //1.
            
            var varIntCount:Int!=0
            
            
            while resultsPersonalBusinessMemberDetails?.next() == true
                    
            {
                varIntCount=varIntCount+1
                let getResponse = NSMutableDictionary ()
                
                getResponse.setValue((resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey"))! as String, forKey:"uniquekey")
                
                getResponse.setValue((resultsPersonalBusinessMemberDetails?.string(forColumn: "value"))! as String, forKey:"value")
                //print(getResponse)
                
                
                
                let letGetUniqueKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                
                var letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                
                
                
                if(letGetUniqueKey=="member_mobile_no" || letGetUniqueKey=="secondry_mobile_no" || letGetUniqueKey=="member_name")
                    
                {
                    
                    if(letGetUniqueKey=="member_name")
                        
                    {
                        
                        labelUsername.text=letGetValue
                        
                    }
                    
                    else
                    
                    {
                        
                        //print(letGetValue)
                        
                        let trimmedString = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                        
                        if(trimmedString.characters.count>0)
                            
                        {
                            
                            
                            
                            commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                            
                            commonClassHoldDataAccessibleVariable.varKeyDynamicProf=letGetUniqueKey
                            
                            commonClassHoldDataAccessibleVariable.varNameDynamicProf=""
                            
                            
                            /* 745834753943487 53485323489 34 834853483498 539 83485349 8538539 8349 85349039058 439 89 83490 385 390 85*/
                            //print(letGetValue)
                            if(letGetValue.characters.count>0)
                            {
                                var varGetCountryCode=letGetValue.components(separatedBy: " ")
                                
                                var databasePath : String
                                let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                let fileURL = documents.appendingPathComponent("Calendar.sqlite")
                                // open database
                                databasePath = fileURL.path
                                var db: OpaquePointer? = nil
                                if sqlite3_open(fileURL.path, &db) != SQLITE_OK
                                {
                                    //print("error opening database")
                                }
                                else
                                {
                                    // self.Createtablecity()
                                }
                                let contactDB = FMDatabase(path: databasePath as String)
                                if contactDB == nil
                                {
                                    //print("Error: \(contactDB?.lastErrorMessage())")
                                }
                                var country_master_id:String!=""
                                var country_Code:String!=""
                                if (contactDB?.open())!
                                {
                                    let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT country_master_id,country_master_name,country_code from country_master where  country_master_id='"+varGetCountryCode[0]+"'"
                                    //print(querySQLPersonalBusinessMemberDetails)
                                    let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                                    while resultsPersonalBusinessMemberDetails?.next() == true
                                    {
                                        country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                                        country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                                        
                                    }
                                    //print("-------------------------")
                                    //print(country_Code)
                                    //print(country_master_id)
                                    //print(letGetValue)
                                    
                                    // letGetValue=country_Code+" "+varGetCountryCode[1]
                                }
                            }
                            
                            /*74 8347 8348 3 7835783 73738473857   347383837337 73378375837837385738737337373 87  7384 573457389 734753 857*/
                            
                            commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf=letGetValue
                            muarrayGetContactProfileUpper.add(commonClassHoldDataAccessibleVariable)
                            
                            //add both business and residence contact number
                            /*
                             muarrayKeyFirst.replaceObjectAtIndex(8, withObject: "Business Contact No.")
                             muarrayValueFirst.replaceObjectAtIndex(8, withObject: varGetstringGetcountryId+" "+phoneNo)
                             muarrayKeyFirst.replaceObjectAtIndex(19, withObject: "Residential Contact No.")
                             muarrayValueFirst.replaceObjectAtIndex(19, withObject: varGetstringGetcountryId+" "+phoneNo)
                             */
                            
                            
                            /*--------------------------------------------------------------------------------*/
                            
                            
                            
                            
                            
                            
                            
                            //all information tableview
                            
                            //print(letGetUniqueKey)
                            
                            commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key=letGetUniqueKey
                            
                            commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name=""
                            
                            commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value=letGetValue
                            
                            commonClassHoldDataAccessibleVariable.varIsPhoneNumberorEmailorOther="phone"
                            
                            muarrayAllInformation.add(commonClassHoldDataAccessibleVariable)
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            if(varIntCount>0)
            {
                self.functionForGetZipFilePath()
            }
            else
            {
                ifDirecUnloads=1
                let alertController = UIAlertController(title: "Message", message: "Please first load Directory contacts to view your profile.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                let delay = 4.0 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time, execute: {
                    alertController.dismiss(animated: true, completion: nil)
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
                    
                })
                //self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                
                self.navigationController?.popViewController(animated: true)
            }
            
            for i in 00..<muarrayKeyFirst.count
            {
                var varGetKey:String!=muarrayKeyFirst.object(at: i)as! String
                //print(varGetKey)
                //print(muarrayValueFirst.object(at: i)as! String)
                if(varGetKey=="Business Contact No." || varGetKey=="Residential Contact No.")
                {
                    
                    commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                    commonClassHoldDataAccessibleVariable.varKeyDynamicProf=varGetKey
                    
                    
                    commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf=muarrayValueFirst.object(at: i)as! String
                    muarrayGetContactProfileUpper.add(commonClassHoldDataAccessibleVariable)
                }
            }
            
            //2.
            
            let querySQLFamilyMemberDetail = "SELECT DISTINCT relationship,memberName,contactNo from FamilyMemberDetail where  profileId="+profileId+" and isVisible='y'"
            
            //print(querySQLFamilyMemberDetail)
            
            let resultsquerySQLFamilyMemberDetail:FMResultSet? = contactDB?.executeQuery(querySQLFamilyMemberDetail,withArgumentsIn: nil)
            
            while resultsquerySQLFamilyMemberDetail?.next() == true
                    
            {
                
                let getResponse = NSMutableDictionary ()
                
                getResponse.setValue((resultsquerySQLFamilyMemberDetail?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                
                getResponse.setValue((resultsquerySQLFamilyMemberDetail?.string(forColumn: "contactNo"))! as String, forKey:"contactNo")
                
                //print(getResponse)
                
                
                
                let letGetValuecontactNo:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "contactNo")
                
                
                
                let trimmedString = letGetValuecontactNo.trimmingCharacters(in: CharacterSet.whitespaces)
                
                
                
                if(trimmedString.characters.count>0)
                    
                {
                    
                    commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                    
                    
                    
                    let letGetrelationship:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "relationship")
                    
                    let letGetmemberName:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "memberName")
                    
                    var letGetcontactNo:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "contactNo")
                    
                    
                    
                    commonClassHoldDataAccessibleVariable.varKeyDynamicProf=letGetrelationship
                    
                    commonClassHoldDataAccessibleVariable.varNameDynamicProf=letGetmemberName
                    
                    
                    
                    
                    
                    
                    
                    
                    /* 745834753943487 53485323489 34 834853483498 539 83485349 8538539 8349 85349039058 439 89 83490 385 390 85*/
                    //print(letGetcontactNo)
                    if(letGetcontactNo.characters.count>0)
                    {
                        var varGetCountryCode=letGetcontactNo.components(separatedBy: " ")
                        
                        var databasePath : String
                        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                        let fileURL = documents.appendingPathComponent("Calendar.sqlite")
                        // open database
                        databasePath = fileURL.path
                        var db: OpaquePointer? = nil
                        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
                        {
                            //print("error opening database")
                        }
                        else
                        {
                            // self.Createtablecity()
                        }
                        let contactDB = FMDatabase(path: databasePath as String)
                        if contactDB == nil
                        {
                            //print("Error: \(contactDB?.lastErrorMessage())")
                        }
                        var country_master_id:String!=""
                        var country_Code:String!=""
                        if (contactDB?.open())!
                        {
                            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT country_master_id,country_master_name,country_code from country_master where  country_master_id='"+varGetCountryCode[0]+"'"
                            //print(querySQLPersonalBusinessMemberDetails)
                            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
                            while resultsPersonalBusinessMemberDetails?.next() == true
                            {
                                country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
                                country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
                            }
                            //print("-------------------------")
                            //print(country_Code)
                            //print(country_master_id)
                            //print(letGetcontactNo)
                            
                            letGetcontactNo=country_Code+" "+varGetCountryCode[1]
                        }
                    }
                    
                    /*74 8347 8348 3 7835783 73738473857   347383837337 73378375837837385738737337373 87  7384 573457389 734753 857*/
                    
                    
                    
                    commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf=letGetcontactNo
                    muarrayGetContactProfileUpper.add(commonClassHoldDataAccessibleVariable)
                    //all information tableview
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key=letGetrelationship
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name=letGetmemberName
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value=letGetcontactNo
                    
                    commonClassHoldDataAccessibleVariable.varIsPhoneNumberorEmailorOther="phone"
                    
                    
                    
                    muarrayAllInformation.add(commonClassHoldDataAccessibleVariable)
                    
                    
                    
                    
                    
                    
                    
                }
                
                //print(getResponse)
                
                //print(muarrayGetContactProfileUpper.count)
                
                tableviewUpperPhoneMessageMail.reloadData()
                
            }
            
        }
        
        //print(muarrayAllInformation.count)
        
        // tableviewAllInformation.reloadData()
        
    }
    
    //---messages-----------------------------------------------------------
    
    func
    functionForGetEmailAddressFromProfileBusinessAddressDetailProMaster()
    
    {
        
        var databasePath : String
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        
        // open database
        
        databasePath = fileURL.path
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            
        {
            
            //print("error opening database")
            
        }
        
        else
        
        {
            
            // self.Createtablecity()
            
        }
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB == nil
            
        {
            
            //print("Error: \(contactDB?.lastErrorMessage())")
            
        }
        
        if (contactDB?.open())!
            
        {
            
            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT uniquekey,value from PersonalBusinessMemberDetails where  profileId="+profileId+" and isVisible='y'"
            
            print(querySQLPersonalBusinessMemberDetails)
            
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            
            //1.
            
            while resultsPersonalBusinessMemberDetails?.next() == true
                    
            {
                
                let getResponse = NSMutableDictionary ()
                
                getResponse.setValue((resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey"))! as String, forKey:"uniquekey")
                
                getResponse.setValue((resultsPersonalBusinessMemberDetails?.string(forColumn: "value"))! as String, forKey:"value")
                
                //print(getResponse)
                
                
                
                let letGetUniqueKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                
                let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                
                
                
                if(letGetUniqueKey=="member_email_id" || letGetUniqueKey=="member_buss_email")
                    
                {
                    
                    let trimmedString = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                    
                    if(trimmedString.characters.count>0)
                        
                    {
                        
                        //print(letGetUniqueKey)
                        
                        //print(letGetValue)
                        
                        
                        
                        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                        
                        commonClassHoldDataAccessibleVariable.varKeyDynamicProfEmail=letGetUniqueKey
                        
                        commonClassHoldDataAccessibleVariable.varEmailDynamicProfEmail=letGetValue
                        
                        commonClassHoldDataAccessibleVariable.varNameDynamicProfEmail=""
                        
                        muarrayGetEmailProfileUpper.add(commonClassHoldDataAccessibleVariable)
                        
                        
                        
                        //all information tableview
                        
                        commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key=letGetUniqueKey
                        
                        commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name=""
                        
                        commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value=letGetValue
                        
                        commonClassHoldDataAccessibleVariable.varIsPhoneNumberorEmailorOther="email"
                        
                        
                        
                        muarrayAllInformation.add(commonClassHoldDataAccessibleVariable)
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
            }
            
            //2.
            
            let querySQLFamilyMemberDetail = "SELECT DISTINCT relationship,memberName,emailID from FamilyMemberDetail where  profileId="+profileId+" and isVisible='y'"
            
            //print(querySQLFamilyMemberDetail)
            
            let resultsquerySQLFamilyMemberDetail:FMResultSet? = contactDB?.executeQuery(querySQLFamilyMemberDetail,withArgumentsIn: nil)
            
            while resultsquerySQLFamilyMemberDetail?.next() == true
                    
            {
                
                let getResponse = NSMutableDictionary ()
                
                getResponse.setValue((resultsquerySQLFamilyMemberDetail?.string(forColumn: "memberName"))! as String, forKey:"memberName")
                
                getResponse.setValue((resultsquerySQLFamilyMemberDetail?.string(forColumn: "emailID"))! as String, forKey:"emailID")
                
                //print(getResponse)
                
                let letGetValuecontactNo:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "emailID")
                
                let trimmedString = letGetValuecontactNo.trimmingCharacters(in: CharacterSet.whitespaces)
                
                if(trimmedString.characters.count>0)
                    
                {
                    
                    commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                    
                    let letGetrelationship:String!=resultsquerySQLFamilyMemberDetail?.string(forColumn: "relationship")
                    
                    
                    
                    //print(letGetrelationship)
                    
                    //print(letGetValuecontactNo)
                    
                    commonClassHoldDataAccessibleVariable.varKeyDynamicProfEmail=letGetrelationship
                    
                    commonClassHoldDataAccessibleVariable.varEmailDynamicProfEmail=letGetValuecontactNo
                    
                    commonClassHoldDataAccessibleVariable.varNameDynamicProfEmail=resultsquerySQLFamilyMemberDetail?.string(forColumn: "memberName")
                    
                    muarrayGetEmailProfileUpper.add(commonClassHoldDataAccessibleVariable)
                    
                    //all information tableview
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key=letGetrelationship
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name=resultsquerySQLFamilyMemberDetail?.string(forColumn: "memberName")
                    
                    commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value=letGetValuecontactNo
                    
                    commonClassHoldDataAccessibleVariable.varIsPhoneNumberorEmailorOther="email"
                    
                    
                    
                    muarrayAllInformation.add(commonClassHoldDataAccessibleVariable)
                    
                    
                    
                }
                
                //print(getResponse)
                
                //print(muarrayGetEmailProfileUpper.count)
                
                tableviewEmail.reloadData()
                
            }
            
        }
        
        //print(muarrayAllInformation.count)
        
        //tableviewAllInformation.reloadData()
        
    }
    
    //----messages-----------------------------------------------------------
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView.tag==1)
        {
            //            return  muarrayGetContactProfileUpper.count
            if (varCallMessageEmail=="Email") {
                return mailArray.count
            } else {
                return phnArray.count
            }
            
        }
        else if(tableView.tag==3)
        {
            //            return  muarrayKeyFirst.count
            return lblKeyArray.count
        }
        else if(tableView.tag==2)
        {
            return  muarrayGetEmailProfileUpper.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if(tableView.tag==1)
        {
            return 64.0;
        }
        else if(tableView.tag==2)
        {
            return 64.0;
        }
        else if(tableView.tag==3)
        {
            
            return cellHeightForFamily
            //            if varRowHeight<13
            //            {
            //                return varRowHeight
            //            }
            //            return varRowHeight-13
        }
        return 100.0;//Choose your custom row height
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    {
        
        if(tableView.tag==1)
        {
            cellHeightForFamily = 80
            viewTwo.isHidden=false
            
            cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! upperProfilePhoneMessageEmailTableViewCell
            //            cell.layer.backgroundColor = UIColor.red.cgColor
            cell.whatsappImgBtn.isHidden = true
            print("varCallMessageEmail:: \(varCallMessageEmail)")
            if(varCallMessageEmail=="Phone")
            {
                cell.lableKey.text = "Mobile"
                cell.lableName.isHidden = true
                //                cell.lableName.text = phnArray[indexPath.row]
                cell.buttonCheckBox.isHidden=true
                cell.buttonCheckBoxMain.isHidden=true
                cell.buttonPhoneNumberMain.isHidden=false
                cell.buttonMobileIcon.isHidden=false
                cell.buttonWhatsApp.isHidden=true
                cell.buttonPhoneNumberMain.setTitle(phnArray[indexPath.row], for: UIControl.State.normal)
            }
            else if(varCallMessageEmail=="whatsapp")
            {
                cell.whatsappImgBtn.isHidden = false
                cell.lableName.isHidden = true
                cell.lableKey.text = "Mobile"
                //                                cell.lableName.text = phnArray[indexPath.row]
                cell.buttonCheckBox.isHidden=true
                cell.buttonCheckBoxMain.isHidden=true
                cell.buttonPhoneNumberMain.isHidden=true
                cell.buttonPhoneNumber.isHidden = true
                cell.buttonMobileIcon.isHidden=true
                cell.buttonWhatsApp.isHidden=false
                cell.buttonWhatsApp.setTitle(phnArray[indexPath.row], for: UIControl.State.normal)
                
            }
            else if(varCallMessageEmail=="Message")
            {
                cell.lableName.isHidden = true
                cell.lableKey.text = "Mobile"
                //                                cell.lableName.text = phnArray[indexPath.row]
                
                cell.buttonCheckBox.isHidden=false
                
                cell.buttonCheckBoxMain.isHidden=false
                
                cell.buttonPhoneNumberMain.isHidden=true
                cell.buttonWhatsApp.isHidden=true
                cell.buttonMobileIcon.isHidden=true
                cell.buttonCheckBoxMain.setTitle(phnArray[indexPath.row], for: UIControl.State.normal)
                
                if(muarrayMessage.object(at: indexPath.row) as! String=="0")
                    
                {
                    cell.buttonCheckBox.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
                }
                else
                
                {
                    cell.buttonCheckBox.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
                }
            }
            else  if(varCallMessageEmail=="Email")
            {
                cell.lableName.isHidden = true
                cell.lableKey.text = "Mail ID"
                //                                cell.lableName.text = mailArray[indexPath.row]
                print(" cell.lableName.text:: \( cell.lableName.text)")
                cell.buttonCheckBox.isHidden=false
                
                cell.buttonCheckBoxMain.isHidden=false
                
                cell.buttonPhoneNumberMain.isHidden=true
                cell.buttonWhatsApp.isHidden=true
                cell.buttonMobileIcon.isHidden=true
                cell.buttonCheckBoxMain.setTitle(mailArray[indexPath.row], for: UIControl.State.normal)
                
                if(muarrayEmail.object(at: indexPath.row) as! String=="0")
                {
                    cell.buttonCheckBox.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
                }
                else
                
                {
                    cell.buttonCheckBox.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
                }
                
            }
            
            
            
            
            
            //            if(muarrayGetContactProfileUpper.count>0)
            //
            //            {
            //                commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
            //
            //                commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.object(at: indexPath.row) as! CommonAccessibleHoldVariable
            //
            //               // //print(commonClassHoldDataAccessibleVariable.varKeyDynamicProf)
            //
            //                 cell.lableKey.text=commonClassHoldDataAccessibleVariable.varKeyDynamicProf
            //
            //                cell.lableName.text=commonClassHoldDataAccessibleVariable.varNameDynamicProf
            ////                cell.lableKey.text=lblKeyArray[indexPath.row]
            ////
            //////               cell.lableName.text=commonClassHoldDataAccessibleVariable.varNameDynamicProf
            //
            //                //key member_mobile_no secondry_mobile_no
            //
            //                if( commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="member_mobile_no" || commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="Residential Contact No." || commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="Business Contact No.")
            //
            //                {
            //                    if(commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="member_mobile_no")
            //                    {
            //                    var attributedStringss:NSAttributedString=NSAttributedString()
            //                    attributedStringss=functionForSetColorInString("Telephone No", stringName: " ")
            //                    cell.lableKey.attributedText=attributedStringss
            //                    }
            //                    if(commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="Residential Contact No." || commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="Business Contact No.")
            //                    {
            //                        var attributedStringss:NSAttributedString=NSAttributedString()
            //                        attributedStringss=functionForSetColorInString(commonClassHoldDataAccessibleVariable.varKeyDynamicProf, stringName: " ")
            //                        cell.lableKey.attributedText=attributedStringss
            //                    }
            //                }
            //                else if( commonClassHoldDataAccessibleVariable.varKeyDynamicProf=="secondry_mobile_no")
            //
            //                {
            //                    var attributedStringss:NSAttributedString=NSAttributedString()
            //                    attributedStringss=functionForSetColorInString("Telephone No", stringName: " ")
            //                    cell.lableKey.attributedText=attributedStringss
            //                }
            //                else
            //                {
            //                    var attributedStringss:NSAttributedString=NSAttributedString()
            //                    attributedStringss=functionForSetColorInString(commonClassHoldDataAccessibleVariable.varKeyDynamicProf, stringName: commonClassHoldDataAccessibleVariable.varNameDynamicProf)
            //                    cell.lableKey.attributedText=attributedStringss
            //                }
            //            cell.buttonPhoneNumber.setTitle(commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf,  for: UIControl.State.normal)
            //                cell.buttonMobileIcon.isHidden=true
            //                if(varCallMessageEmail=="Phone")
            //                {
            //                    cell.buttonCheckBox.isHidden=true
            //                    cell.buttonCheckBoxMain.isHidden=true
            //                    cell.buttonPhoneNumberMain.isHidden=false
            //                    cell.buttonMobileIcon.isHidden=false
            //                    cell.buttonWhatsApp.isHidden=true
            //                }
            //                else if(varCallMessageEmail=="whatsapp")
            //                {
            //                    cell.buttonCheckBox.isHidden=true
            //                    cell.buttonCheckBoxMain.isHidden=true
            //                    cell.buttonPhoneNumberMain.isHidden=true
            //                    cell.buttonMobileIcon.isHidden=true
            //                     cell.buttonWhatsApp.isHidden=false
            //
            //                }
            //                else if(varCallMessageEmail=="Message")
            //                {
            //
            //                    cell.buttonCheckBox.isHidden=false
            //
            //                    cell.buttonCheckBoxMain.isHidden=false
            //
            //                    cell.buttonPhoneNumberMain.isHidden=true
            //                     cell.buttonWhatsApp.isHidden=true
            //
            //                }
            //                else  if(varCallMessageEmail=="Email")
            //                {
            //                    cell.buttonCheckBox.isHidden=true
            //                    cell.buttonCheckBoxMain.isHidden=true
            //                    cell.buttonPhoneNumberMain.isHidden=false
            //                    cell.buttonWhatsApp.isHidden=true
            //                }
            //
            //                //-----need to check check box check or uncheck
            //
            //                //muarrayMessage
            //
            //                if(muarrayMessage.object(at: indexPath.row) as! String=="0")
            //
            //                {
            //                    cell.buttonCheckBox.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
            //                }
            //                else
            //
            //                {
            //                    cell.buttonCheckBox.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
            //                }
            
            //            if(muarrayEmail.object(at: indexPath.row) as! String=="0")
            //            {
            //                cell.buttonCheckBox.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
            //            }
            //            else
            //
            //            {
            //                cell.buttonCheckBox.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
            //            }
            
            //
            //                //Check_DynaProfile.png  //Uncheck_DynaProfile.png
            //
            //            }
            //            else
            //            {
            //
            //            }
            
            //-----
            
            cell.buttonCheckBox.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            
            cell.buttonCheckBox.tag=indexPath.row;
            cell.buttonWhatsApp.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonbuttonWhatsAppClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonWhatsApp.tag=indexPath.row;
            cell.buttonCheckBoxMain.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonCheckBoxMain.tag=indexPath.row;
            cell.buttonPhoneNumber.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonPhoneClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonPhoneNumber.tag=indexPath.row;
            cell.buttonPhoneNumberMain.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonPhoneClicked(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonPhoneNumberMain.tag=indexPath.row;
            functionForDisableEmailIdIconIfNotEmailAvail()
            return cell
        }
        else if(tableView.tag==2)
        {
            cellHeightForFamily = 80
            if(muarrayGetEmailProfileUpper.count>0)
            {
                cells =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! EmailTableViewCell
                cells.layer.backgroundColor = UIColor.orange.cgColor
                //print(muarrayGetContactProfileUpper.count)
                commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                commonClassHoldDataAccessibleVariable = muarrayGetEmailProfileUpper.object(at: indexPath.row) as! CommonAccessibleHoldVariable
                let varGetEmialId:String! =  commonClassHoldDataAccessibleVariable.varKeyDynamicProfEmail
                if(varGetEmialId=="member_email_id")
                {
                    var attributedStringss:NSAttributedString=NSAttributedString()
                    
                    attributedStringss=functionForSetColorInString("Email", stringName: " ")
                    cells.labelNameEmail.attributedText=attributedStringss
                }
                else  if(varGetEmialId=="member_buss_email")
                {
                    var attributedStringss:NSAttributedString=NSAttributedString()
                    
                    attributedStringss=functionForSetColorInString("Email", stringName: " ")
                    
                    cells.labelNameEmail.attributedText=attributedStringss
                }
                else
                {
                    var attributedStringss:NSAttributedString=NSAttributedString()
                    
                    attributedStringss=functionForSetColorInString(commonClassHoldDataAccessibleVariable.varKeyDynamicProfEmail, stringName: commonClassHoldDataAccessibleVariable.varNameDynamicProfEmail)
                    
                    cells.labelNameEmail.attributedText=attributedStringss
                }
                //
                if(muarrayEmail.object(at: indexPath.row) as! String=="0")
                    
                {
                    cells.buttonCheckBoxEmail.setImage(UIImage(named: "Uncheck_DynaProfile.png"),  for: UIControl.State.normal)
                }
                else
                
                {
                    
                    cells.buttonCheckBoxEmail.setImage(UIImage(named: "Check_DynaProfile.png"),  for: UIControl.State.normal)
                    
                }
                
                cells.buttonCheckBoxEmail.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
                cells.buttonCheckBoxEmail.tag=indexPath.row;
                cells.buttonCheckBoxEmailMain.addTarget(self, action: #selector(ProfileDynamicNewViewController.buttonEmailCheckUncheckClicked(_:)), for: UIControl.Event.touchUpInside)
                cells.buttonCheckBoxEmailMain.tag=indexPath.row;
                cells.buttonEmailEmailSend.setTitle(commonClassHoldDataAccessibleVariable.varEmailDynamicProfEmail,  for: UIControl.State.normal)
                functionForDisableEmailIdIconIfNotEmailAvail()
                return cells
                
            }
            
        }
        
        else  if(tableView.tag==3)
        {
            
            cell3 =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! AllInformationTableViewCell
            
            cell3.layer.backgroundColor = UIColor.yellow.cgColor
            cell3.textviewAddressorFamilyMember.isHidden = true
            cell3.viewFamilyImage.isHidden = true
            
            if (lblKeyArray[indexPath.row] == "Family Photo") {
                cellHeightForFamily = 200
                cell3.buttonValueFirst.isHidden = true
                //                cell3.labelValFirst.isHidden = true
                cell3.viewFamilyImage.isHidden = false
                cell3.viewFamilyImage.layer.backgroundColor = UIColor.white.cgColor
                NSLayoutConstraint.activate([
                    cell3.imageFamilyImage.topAnchor.constraint(equalTo: cell3.contentView.topAnchor, constant: 8),
                    cell3.imageFamilyImage.leadingAnchor.constraint(equalTo: cell3.contentView.leadingAnchor, constant: 8),
                    cell3.imageFamilyImage.bottomAnchor.constraint(equalTo: cell3.contentView.bottomAnchor, constant: -8),
                    cell3.imageFamilyImage.trailingAnchor.constraint(equalTo: cell3.contentView.trailingAnchor, constant: -8)
                ])
                //                cell3.labelKeyFirst.text = key
                let ImageProfilePic = lblValueArray[indexPath.row].replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                print(ImageProfilePic)
                cell3.imageFamilyImage.sd_setImage(with: checkedUrl)
            } else if(lblKeyArray[indexPath.row] == "Birthday" || lblKeyArray[indexPath.row] == "Anniversary Date" || lblKeyArray[indexPath.row] == "Birthday Date" || lblKeyArray[indexPath.row] == "Anniversary" || lblKeyArray[indexPath.row] == "Birth Date") {
                cellHeightForFamily = 80
                cell3.buttonValueFirst.isHidden = false
                cell3.labelKeyFirst.text = lblKeyArray[indexPath.row]
                cell3.buttonValueFirst.setTitleColor(UIColor.black,  for: UIControl.State.normal)
                cell3.buttonValueFirst.setTitle(lblValueArray[indexPath.row],  for: UIControl.State.normal)
                
//                if let convertedDate = convertDateToWords(dateString: lblValueArray[indexPath.row]) {
//                    print("Converted date: \(convertedDate)")
//                    cell3.buttonValueFirst.setTitle(convertedDate,  for: UIControl.State.normal)
//                } else {
//                    print("Invalid date format")
//                }
                
                
            } else {
                    cellHeightForFamily = 80
                    cell3.buttonValueFirst.isHidden = false
                    cell3.labelKeyFirst.text = self.lblKeyArray[indexPath.row]
                    cell3.buttonValueFirst.setTitleColor(UIColor.black,  for: UIControl.State.normal)
                    print("self.lblValueArray[indexPath.row]-------------\(self.lblValueArray[indexPath.row]), Row: \(indexPath.row)")
                    cell3.buttonValueFirst.setTitle(self.lblValueArray[indexPath.row],  for: UIControl.State.normal)
            }
            
            
            if(lblKeyArray[indexPath.row]=="Mobile Number" || lblKeyArray[indexPath.row]=="Email ID" || lblKeyArray[indexPath.row]=="Business Contact No." || lblKeyArray[indexPath.row]=="Mobile" || lblKeyArray[indexPath.row]=="Secondary Mobile Number" || lblKeyArray[indexPath.row]=="Business Email ID" || lblKeyArray[indexPath.row]=="Facebook" || lblKeyArray[indexPath.row]=="Instagram" || lblKeyArray[indexPath.row]=="Linkedin" || lblKeyArray[indexPath.row]=="Member Introduction" || lblKeyArray[indexPath.row]=="Email" || lblKeyArray[indexPath.row]=="Address" ||  lblKeyArray[indexPath.row]=="Business Address" || lblKeyArray[indexPath.row]=="Website" || lblKeyArray[indexPath.row]=="Youtube" || lblKeyArray[indexPath.row]=="Twitter" || lblKeyArray[indexPath.row]=="Residence Address")
            {
                if(lblKeyArray[indexPath.row]=="Member Introduction" || lblKeyArray[indexPath.row]=="Address" || lblKeyArray[indexPath.row]=="Business Address" || lblKeyArray[indexPath.row]=="Residence Address") {
                    cell3.buttonValueFirst.tintColor = UIColor.black
                } else {
                    cell3.buttonValueFirst.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
                }
                
                cell3.buttonValueFirst.isUserInteractionEnabled=true
                
                cell3.buttonValueFirst.tag = indexPath.row
                
                cell3.buttonValueFirst.addTarget(self, action: #selector(tapBtnAction(_:)), for: .touchUpInside)
                //                if (lblKeyArray[indexPath.row]=="Facebook" || lblKeyArray[indexPath.row]=="Instagram" || lblKeyArray[indexPath.row]=="Linkedin") {
                //                    let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                //                    webScreen.varOpenUrl = lblValueArray[indexPath.row]
                //                    webScreen.navTitle = lblKeyArray[indexPath.row]
                //                    print(webScreen.varOpenUrl)
                //                    self.navigationController?.pushViewController(webScreen, animated: true)
                //                }
            } else {
                cell3.buttonValueFirst.isUserInteractionEnabled=false
            }
            return cell3
        }
        return cell
        
    }
    
    @objc func tapLblAction(_ sender: UILabel) {
        let buttonTag = sender.tag
        
        if lblKeyArray.indices.contains(buttonTag) {
            let key = lblKeyArray[buttonTag]
            var value = lblValueArray[buttonTag]
            
            if key == "Facebook" || key == "Instagram" || key == "Linkedin" || key == "Twitter" || key == "Youtube" || key == "Website" {
                let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                webScreen.varOpenUrl = value
                webScreen.navTitle = key
                print(webScreen.varOpenUrl)
                self.navigationController?.pushViewController(webScreen, animated: true)
            }
            if key == "Business Email ID" || key == "Email ID" {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([value])      // gg@hing.co.in
                    mail.setMessageBody("", isHTML: true)
                    present(mail, animated: true, completion: nil)
                }
                else
                {
                    sendEmailFallback(mail: value)
                    
                }
            }
            
            if key == "Mobile Number" || key == "Secondary Mobile Number" || key == "Mobile" {
                value = value.replacingOccurrences(of: " ", with: "")
                print("calling\(value)")
                if value.characters.count > 1
                {
//                    let url = URL(string: "tel://\(value)")
//                    UIApplication.shared.openURL(url!)
                    
                    if let url = URL(string: "tel://\(value)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("Unable to make a call. Invalid phone number or URL.")
                    }
                }
                else
                {
                }
            }
        }
    }
    
    
    @objc func tapBtnAction(_ sender: UIButton) {
        let buttonTag = sender.tag
        
        if lblKeyArray.indices.contains(buttonTag) {
            let key = lblKeyArray[buttonTag]
            var value = lblValueArray[buttonTag]
            
            if key == "Facebook" || key == "Instagram" || key == "Linkedin" || key == "Twitter" || key == "Youtube" || key == "Website" {
                let webScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
                webScreen.varOpenUrl = value
                webScreen.navTitle = key
                print(webScreen.varOpenUrl)
                self.navigationController?.pushViewController(webScreen, animated: true)
            }
            if key == "Business Email ID" || key == "Email ID" || key == "Email" {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([value])      // gg@hing.co.in
                    mail.setMessageBody("", isHTML: true)
                    present(mail, animated: true, completion: nil)
                }
                else
                {
                    sendEmailFallback(mail: value)
                    
                }
            }
            
            if key == "Mobile Number" || key == "Secondary Mobile Number" || key == "Mobile" {
                value = value.replacingOccurrences(of: " ", with: "")
                print("calling\(value)")
                if value.characters.count > 1
                {

                            if let url = URL(string: "tel://\(value)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                print("Unable to make a call. Invalid phone number or URL.")
                            }
                    
                }
                else
                {
                }
            }
            
            if key == "Member Introduction" {
                let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
                memberIntroVC.desc = value
                memberIntroVC.navTitle = "Member Introduction"
                self.navigationController?.pushViewController(memberIntroVC, animated: true)
            }
            
            if key == "Address" || key == "Business Address" || key == "Residence Address"{
                let memberIntroVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileMemberIntroViewController") as! ProfileMemberIntroViewController
                memberIntroVC.desc = value 
                memberIntroVC.navTitle = "Address"
                self.navigationController?.pushViewController(memberIntroVC, animated: true)
            }
        }
    }
    
    func sendEmailFallback(mail: String) {
        let recipientEmail = mail // Replace with the recipient email address
        
        let emailURLString = "mailto:\(recipientEmail)"
        if let emailURL = URL(string: emailURLString) {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            } else {
                // Provide an alert indicating that email sending is not available
                let alert = UIAlertController(title: "Error", message: "Email sending is not available on this device.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    var getImageURls:String!=""
    var varISFamilyImageAvailable:String!="0"
    
    @objc func mobTap(_ sender: UILabel)
    {
        let varGetKeyValue:String!=muarrayKeyFirst.object(at: sender.tag)as! String
        //  if(varGetKeyValue=="Telephone No." || varGetKeyValue=="Email" || varGetKeyValue=="Business Contact No." || varGetKeyValue=="Residential Contact No.")
        if(varGetKeyValue=="Telephone No." || varGetKeyValue=="Business Contact No." || varGetKeyValue=="Residential Contact No.")
        {
            let varGetValue:String!=muarrayValueFirst.object(at: sender.tag) as! String
            //print(varGetValue)
            let PhoneNumberSTR:String = varGetValue.replacingOccurrences(of: " ", with: "")
//            let url = URL(string: "tel://\(PhoneNumberSTR)")
//            UIApplication.shared.openURL(url!)
            if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to make a call. Invalid phone number or URL.")
            }
        }
        else if(varGetKeyValue=="Email")
        {
            if MFMailComposeViewController.canSendMail()
                
            {
                let varEmailString:String!=muarrayValueFirst.object(at: sender.tag) as! String
                //print(varEmailString)
                //print(varEmailString)
                
                let mail = MFMailComposeViewController()
                
                mail.mailComposeDelegate = self
                
                mail.setToRecipients([varEmailString])// gg@hing.co.in
                
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
                
                // ToRecipients([varEmailString])
                
            }
        }
    }
    
    @IBAction func buttonbuttonValueFirstClicked(_ sender: AnyObject)
    {
        let varGetKeyValue:String!=muarrayKeyFirst.object(at: sender.tag)as! String
        //  if(varGetKeyValue=="Telephone No." || varGetKeyValue=="Email" || varGetKeyValue=="Business Contact No." || varGetKeyValue=="Residential Contact No.")
        if(varGetKeyValue=="Telephone No." || varGetKeyValue=="Business Contact No." || varGetKeyValue=="Residential Contact No.")
        {
            let varGetValue:String!=muarrayValueFirst.object(at: sender.tag) as! String
            //print(varGetValue)
            let PhoneNumberSTR:String = varGetValue.replacingOccurrences(of: " ", with: "")
//            let url = URL(string: "tel://\(PhoneNumberSTR)")
//            UIApplication.shared.openURL(url!)
            if let url = URL(string: "tel://\(PhoneNumberSTR)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to make a call. Invalid phone number or URL.")
            }
        }
        else if(varGetKeyValue=="Email")
        {
            if MFMailComposeViewController.canSendMail()
                
            {
                let varEmailString:String!=muarrayValueFirst.object(at: sender.tag) as! String
                //print(varEmailString)
                //print(varEmailString)
                
                let mail = MFMailComposeViewController()
                
                mail.mailComposeDelegate = self
                
                mail.setToRecipients([varEmailString])// gg@hing.co.in
                
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true, completion: nil)
                
                // ToRecipients([varEmailString])
                
            }
        }
    }
    var varGetForLoopCounting:Int!=0
    @IBAction func buttonFamilyImageBigViewChanged(_ sender: AnyObject)
    {
        let varGetIndex:Int=sender.tag
        
        
        varGetSelectedIndex=varGetIndex
        
        //print(varISFamilyImageAvailable)
        varISProfileorFamilyImage="family"
        //0 menas there is image and 1 means no image
        if(varISFamilyImageAvailable=="0" || getImageURls.characters.count>15 || self.from == "BOD")
        {
            //print("make it dull image view")
            
            
            let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
            objImageFullViewViewController.varGetImageUrl=getImageURls
            self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
            
            
            
        }
        else   if(varISFamilyImageAvailable=="1")
        {
            let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
            if mainMemberID == "Yes"
            {
                if(isCategory=="2")
                {
                    let varGetIndex:Int=sender.tag
                    varGetSelectedIndex=varGetIndex
                    varISProfileorFamilyImage="family"
                    //print("image changes")
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
                    let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
                    {
                        UIAlertAction in
                        self.functionForChangeFamilyPic()
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                    {
                        UIAlertAction in
                    }
                    // Add the actions
                    picker.delegate = self
                    alert.addAction(cameraAction)
                    alert.addAction(gallaryAction)
                    if(getImageURls.characters.count>15)
                    {
                        alert.addAction(RemoveAction)
                    }
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    //need to write code here
                    let varGetIndex:Int=sender.tag
                    varGetSelectedIndex=varGetIndex
                    varISProfileorFamilyImage="family"
                    //print("image changes")
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
                    let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
                    {
                        UIAlertAction in
                        self.functionForChangeFamilyPic()
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                    {
                        UIAlertAction in
                    }
                    // Add the actions
                    picker.delegate = self
                    alert.addAction(cameraAction)
                    alert.addAction(gallaryAction)
                    if(getImageURls.characters.count>15)
                    {
                        alert.addAction(RemoveAction)
                    }
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                //print("you have not admin right for change family image :( :(")
                
                //print("this is else part edit button")
                //print(NormalMemberOrAdmin)
                if(NormalMemberOrAdmin == "NormalMemberFromMainDash")
                {
                    
                    //self.buttonEditProfileImage.hidden=true
                }
                else if (NormalMemberOrAdmin == "comingfromcelebreationscreen")
                {
                    
                }
                else if (NormalMemberOrAdmin == "Classification")
                {
                    
                }
                else if (NormalMemberOrAdmin == "Family")
                {
                    
                }
                else if (NormalMemberOrAdmin == "BOD")
                {
                    
                }
                else
                {
                    /////-------------------------------------------------------------------------------------23 nov 5.23pm
                    if(isCategory=="2")
                    {
                        let varGetIndex:Int=sender.tag
                        varGetSelectedIndex=varGetIndex
                        varISProfileorFamilyImage="family"
                        //print("image changes")
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
                        let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
                        {
                            UIAlertAction in
                            self.functionForChangeFamilyPic()
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                        {
                            UIAlertAction in
                        }
                        // Add the actions
                        picker.delegate = self
                        alert.addAction(cameraAction)
                        alert.addAction(gallaryAction)
                        if(getImageURls.characters.count>15)
                        {
                            alert.addAction(RemoveAction)
                        }
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        //need to write code here
                        let varGetIndex:Int=sender.tag
                        varGetSelectedIndex=varGetIndex
                        varISProfileorFamilyImage="family"
                        //print("image changes")
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
                        let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
                        {
                            UIAlertAction in
                            self.functionForChangeFamilyPic()
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                        {
                            UIAlertAction in
                        }
                        // Add the actions
                        picker.delegate = self
                        alert.addAction(cameraAction)
                        alert.addAction(gallaryAction)
                        if(getImageURls.characters.count>15)
                        {
                            alert.addAction(RemoveAction)
                        }
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    /////----------------------------------------------------------------------------------------23 nov 5.23pm
                }
                
                
                
                
            }
            
            
            
            
            
        }
    }
    
    @IBAction func buttonFamilyImageChanged(_ sender: AnyObject)
    {
        let varGetIndex:Int=sender.tag
        
        
        varGetSelectedIndex=varGetIndex
        
        
        varISProfileorFamilyImage="family"
        
        //print("image changes")
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
        let RemoveAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.functionForChangeFamilyPic()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        if(getImageURls.characters.count>15)
        {
            alert.addAction(RemoveAction)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func functionForChangeFamilyPic()
    {
        //        if(varISProfileorFamilyImage=="family")
        //        {
        //
        
        buttonProcessing.isHidden=false
        
        
        
        //-------
        var imageUserImageNew:UIImageView=UIImageView()
        
        
        imageUserImageNew.image=UIImage(named: "profile_pic.png")
        
        
        //-----------------------------------------------------------
        var parameters = [String:AnyObject]()
        parameters = [
            "typeID":profileId as AnyObject,
            "grpID":grpID as AnyObject,
            "type":"family" as AnyObject
        ]
        buttonOpacity.isHidden=false
        let completeURL = baseUrl+touchBase_GetRemovedMemberProfile
        //print(parameters)
        //print(completeURL)
        
        
        
        ///-------------
        //------------------------------------------------------
        
        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            switch response.result {
            case .success:
                // var result = [String:String]()
                if(response != nil)
                {
                    let dd = response.result.value as! NSDictionary
                    
                    //print("dd \(dd)")
                    var varGetValueServerError = dd.object(forKey: "serverError")as? String
                    
                    if(varGetValueServerError == "Error")
                    {
                        self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                        self.buttonOpacity.isHidden=true
                        self.buttonProcessing.isHidden=true
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        if let value = response.result.value {
                            let dic = response.result.value!
                            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                            let jsonString = String(data: jsonData!, encoding: .utf8)!
                            ////print(jsonString)
                            //--
                            if(response==nil)
                            {
                                
                            }
                            else
                            {
                                if((dd.object(forKey: "DeleteResult")! as AnyObject).object(forKey: "status") as! String == "0")
                                {
                                    UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromProfileDynamicBackagainandagain")
                                    
                                    self.objptotocolForDirectoryScrenBackValue?.functionForCallingOnDirctoryuScrrenWhenBackFromProfileDynamic()
                                    self.buttonOpacity.isHidden=true
                                    self.view.makeToast("Family image removed successfully", duration: 3, position: CSToastPositionCenter)
                                    self.tableviewAllInformation.reloadData()
                                    
                                    self.buttonProcessing.isHidden=true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                                        var dictResponseData:NSDictionary = NSDictionary()
                                        
                                        var varGetImagePath:String! =  ""
                                        self.getImageURls=varGetImagePath
                                        for i in 00..<self.muarrayKeyFirst.count
                                        {
                                            var varGetFamilyPhoto:String!=self.muarrayKeyFirst.object(at: i) as! String
                                            if(varGetFamilyPhoto=="familyphoto")
                                            {
                                                //print(varGetImagePath)
                                                self.muarrayValueFirst.replaceObject(at: i, with: varGetImagePath)
                                            }
                                        }
                                        //print("This code for, Family image removed 2222222")
                                        self.tableviewAllInformation.reloadData()
                                    })
                                }
                                else
                                {
                                    self.view.makeToast("Something went wrong, Please try again later", duration: 3, position: CSToastPositionCenter)
                                    self.buttonOpacity.isHidden=true
                                    self.buttonProcessing.isHidden=true
                                    
                                    SVProgressHUD.dismiss()
                                }
                            }
                        }
                    }
                }
            case .failure(_): break
            }
        }
    }
    
    func  functionToCall(){
        
        tableviewAllInformation.reloadData()
    }
    
    func  functionToCall2(){
        tableviewAllInformation.reloadData()
        
    }
    
    @IBAction func buttonPhoneMainClicked(_ sender: AnyObject)
    
    {
        
        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
        
        commonClassHoldDataAccessibleVariable = muarrayAllInformation.object(at: sender.tag) as! CommonAccessibleHoldVariable
        
        
        
        //-----------
        
        var varGetKey = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key
        
        var varGetName = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name
        
        var varGetValue = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value
        
        
        
        //print("Key:-"+varGetKey!)
        
        //print("Name:-"+varGetName!)
        
        //print("Value:-"+varGetValue!)
        
        
        
        
        
        
        
        //  commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.objectAtIndex(sender.tag) as! CommonAccessibleHoldVariable
        
        //  var letGetPhoneNumber = commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf
        
        
        
        //print(varGetValue)
        
        if(varGetValue?.hasPrefix("+"))!
            
        {
            
            
            
            
            
            var varGetArrayNumber = varGetValue?.components(separatedBy: " ")
            
            let trimmedString = varGetArrayNumber?[1].trimmingCharacters(in: CharacterSet.whitespaces)
            
            var url:URL = URL(string: "telprompt://"+trimmedString!+"")!
            
//            UIApplication.shared.openURL(url)
            
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:]) { success in
                        if success {
                            print("The URL was successfully opened.")
                        } else {
                            print("Failed to open the URL.")
                        }
                    }
                }
            
            
        }
        
        else
        
        {
            
            let trimmedString = varGetValue?.trimmingCharacters(in: CharacterSet.whitespaces)
            
            var url:URL = URL(string: "telprompt://"+trimmedString!+"")!
            
//            UIApplication.shared.openURL(url)
            
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:]) { success in
                        if success {
                            print("The URL was successfully opened.")
                        } else {
                            print("Failed to open the URL.")
                        }
                    }
                }
            
            
        }
        
    }
    
    @IBAction func buttonEmailMainClicked(_ sender: AnyObject)
    
    {
        
        commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
        
        commonClassHoldDataAccessibleVariable = muarrayAllInformation.object(at: sender.tag) as! CommonAccessibleHoldVariable
        
        
        
        //-----------
        
        let varGetKey = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Key
        
        let varGetName = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Name
        
        let varGetValue = commonClassHoldDataAccessibleVariable.varAllDetailInformation_Value
        
        //print("Key:-"+varGetKey!)
        
        //print("Name:-"+varGetName!)
        
        //print("Value:-"+varGetValue!)
        
        
        
        
        
        //print(varGetValue)
        
        let mail = MFMailComposeViewController()
        
        mail.mailComposeDelegate = self
        
        mail.setToRecipients([varGetValue!])// gg@hing.co.in
        
        mail.setMessageBody("", isHTML: true)
        
        present(mail, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func buttonEmailCheckUncheckClicked(_ sender: AnyObject)
    {
        if(varCallMessageEmail=="Email")
        {
            let varGetValue = muarrayEmail.object(at: sender.tag)
            if(varGetValue as! String=="0")
                
            {
                muarrayEmail.replaceObject(at: sender.tag, with: "1")
            }
            else  if(varGetValue as! String=="1")
            {
                muarrayEmail.replaceObject(at: sender.tag, with: "0")
            }
            tableviewEmail.reloadData()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //    @IBAction func buttonEmailClicked(sender: AnyObject)
    
    //    {
    
    //        //print("Email clciked !")
    
    //    }
    
    @IBAction func buttonbuttonWhatsAppClicked(_ sender: AnyObject)
    
    {
        //        var letGetPhoneNumber:String! = ""
        //        if(varCallMessageEmail=="whatsapp")
        //        {
        //            commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.object(at: sender.tag) as! CommonAccessibleHoldVariable
        
        
        //            letGetPhoneNumber = commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf
        //            var varGetValue=letGetPhoneNumber
        //            let string = varGetValue!.replacingOccurrences(of: "+", with: "")
        //            let newString = string.replacingOccurrences(of: " ", with: "")
//        var value = phnArray[sender.tag]
//        value = value.replacingOccurrences(of: " ", with: "")
//        if(value.characters.count>7)
//        {
//            var varGetValue=value
//            let urlWhats = "https://wa.me/\(varGetValue)"
//            if let whatsappURL = URL(string: urlWhats) {
//                if UIApplication.shared.canOpenURL(whatsappURL) {
//                    UIApplication.shared.openURL(whatsappURL)
//                } else {
//                    let alertView:UIAlertView = UIAlertView()
//                    alertView.title = "Rotary India"
//                    alertView.message = "WhatsApp is not installed"
//                    alertView.delegate = self
//                    alertView.addButton(withTitle: "OK")
//                    alertView.show()
//                }
//            }
//        }
        
        var value = phnArray[sender.tag]
        value = value.replacingOccurrences(of: " ", with: "")

        if value.count > 7 { // Use .count instead of value.characters.count
            let varGetValue = value
            let urlWhats = "https://wa.me/\(varGetValue)"
            
            if let whatsappURL = URL(string: urlWhats) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    let alert = UIAlertController(title: "Rotary India",
                                                  message: "WhatsApp is not installed",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let topController = UIApplication.shared.keyWindow?.rootViewController {
                        topController.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }

        
        
        //        }
    }
    
    @IBAction func buttonPhoneClicked(_ sender: AnyObject)
    {
        //        var letGetPhoneNumber:String! = ""
        //        if(varCallMessageEmail=="Phone")
        //        {
        //            commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.object(at: sender.tag) as! CommonAccessibleHoldVariable
        //
        //
        //             letGetPhoneNumber = commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf
        //            //print(letGetPhoneNumber)
        //            if(letGetPhoneNumber.hasPrefix("+"))
        //            {
        
//        var value = phnArray[sender.tag]
//        value = value.replacingOccurrences(of: " ", with: "")
//        
//        let url = URL(string: "tel://\(value)")
//        UIApplication.shared.openURL(url!)
        
        var value = phnArray[sender.tag]
        value = value.replacingOccurrences(of: " ", with: "")

        if let url = URL(string: "tel://\(value)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Unable to make a call. Invalid phone number or URL.")
        }

        
        
        
        
        //            }
        //            else
        //            {
        //                let trimmedString = letGetPhoneNumber.trimmingCharacters(in: CharacterSet.whitespaces)
        //                let url:URL = URL(string: "telprompt://"+trimmedString+"")!
        //                UIApplication.shared.openURL(url)
        //
        //            }
        
        //        }
        
    }
    
    /*
     
     
     
     PhoneNumberSTR = PhoneNumberSTR.stringByReplacingOccurrencesOfString(" ", withString: "")
     
     //print("calling\(PhoneNumberSTR)")
     
     if PhoneNumberSTR.characters.count > 1
     
     {
     
     let alertView:UIAlertView = UIAlertView()
     
     alertView.title = "Rotary India"
     
     alertView.message = String(format:"Do you want to make call with %@",PhoneNumberSTR)
     
     alertView.delegate = self
     
     alertView.tag = 1
     
     alertView.addButtonWithTitle("No")
     
     alertView.addButtonWithTitle("Yes")
     
     alertView.show()
     
     
     
     }
     
     */
    
    
    
    @IBAction func buttonCheckUncheckClicked(_ sender: AnyObject)
    
    {
        
        //print(sender.tag)
        
        if(varCallMessageEmail=="Phone")
            
        {
            
            cell.buttonCheckBox.isHidden=true
            
        }
        
        else if(varCallMessageEmail=="Message")
                
        {
            
            cell.buttonCheckBox.isHidden=false
            
            let varGetValue = muarrayMessage.object(at: sender.tag)
            
            if(varGetValue as! String=="0")
                
            {
                
                muarrayMessage.replaceObject(at: sender.tag, with: "1")
                
                //cell.buttonCheckBox.setBackgroundImage(UIImage(named: "Check_DynaProfile.png"), forState: .Normal)
                
                
                
            }
            
            else  if(varGetValue as! String=="1")
                        
            {
                
                muarrayMessage.replaceObject(at: sender.tag, with: "0")
                
                // cell.buttonCheckBox.setBackgroundImage(UIImage(named: "Uncheck_DynaProfile.png"), forState: .Normal)
                
                
                
            }
            
            
            
            //let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
            
            // tableviewUpperPhoneMessageMail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableviewUpperPhoneMessageMail.reloadData()
            
            
            
        }
        
        else  if(varCallMessageEmail=="Email")
                    
        {
            
            //            cell.buttonCheckBox.isHidden=true
            //
            //            tableviewUpperPhoneMessageMail.reloadData()
            cell.buttonCheckBox.isHidden=false
            
            let varGetValue = muarrayEmail.object(at: sender.tag)
            
            if(varGetValue as! String=="0")
                
            {
                
                muarrayEmail.replaceObject(at: sender.tag, with: "1")
                
                //cell.buttonCheckBox.setBackgroundImage(UIImage(named: "Check_DynaProfile.png"), forState: .Normal)
                
                
                
            }
            
            else  if(varGetValue as! String=="1")
                        
            {
                
                muarrayEmail.replaceObject(at: sender.tag, with: "0")
                
                // cell.buttonCheckBox.setBackgroundImage(UIImage(named: "Uncheck_DynaProfile.png"), forState: .Normal)
                
                
                
            }
            
            
            
            //let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
            
            // tableviewUpperPhoneMessageMail.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableviewUpperPhoneMessageMail.reloadData()
            
        }
        
        
        
        
        
    }
    
    //1.........
    
    func functionForSetColorInString(_ stringKey:String,stringName:String)->NSAttributedString
    
    {
        
        let text = "I agree with TERMS and CONDITION"
        
        let linkTextWithColor = "CONDITION"
        
        
        
        let range = (text as NSString).range(of: linkTextWithColor)
        
        
        
        let attributedString = NSMutableAttributedString(string:text)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        
        var attributedStringss:NSAttributedString=NSAttributedString()
        
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;"+stringName+"</span></font> </font>"
        
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        do {
            
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            
            
            
            // labelIAgreeWith.attributedText=attributedStringss;
            
        } catch _ {
            //print("Cannot create attributed String")
        }
        
        //print(attributedStringss)
        
        return attributedStringss
    }
    
    //2.
    func functionForSetColorInStringFamilyDetail(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        
        var attributedStringss:NSAttributedString=NSAttributedString()
        
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\"><br/><br/>"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"</span></font> </font>"
        
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        do {
            
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            // labelIAgreeWith.attributedText=attributedStringss;
            
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    
    //3.
    
    func functionForSetColorInStringFamilyDetailRElationn(_ stringKey:String,stringName:String)->NSAttributedString
    
    {
        
        let text = "I agree with TERMS and CONDITION"
        
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"</span></font> </font>"
        
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        do {
            
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            
            
            
            // labelIAgreeWith.attributedText=attributedStringss;
            
        } catch _ {
            
            //print("Cannot create attributed String")
            
        }
        
        //print(attributedStringss)
        
        return attributedStringss
        
    }
    
    
    
    //4.
    
    func functionForSetColorInStringFamilyDetailBG(_ stringKey:String,stringName:String)->NSAttributedString
    
    {
        
        let text = "I agree with TERMS and CONDITION"
        
        let linkTextWithColor = "CONDITION"
        
        
        
        let range = (text as NSString).range(of: linkTextWithColor)
        
        
        
        let attributedString = NSMutableAttributedString(string:text)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        
        var attributedStringss:NSAttributedString=NSAttributedString()
        
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><br/><br/><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"</span></font> </font>"
        
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        do {
            
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            
            
            
            // labelIAgreeWith.attributedText=attributedStringss;
            
        } catch _ {
            
            //print("Cannot create attributed String")
            
        }
        
        //print(attributedStringss)
        
        return attributedStringss
        
    }
    
    
    
    //sms
    
    func SMSAction()
    
    {
        SVProgressHUD.dismiss()
        //var varContactString:String!=""
        
        var varContactString = [String]()
        var varISPhoneNumberContain:String!="no"
        
        for i in 00..<phnArray.count
                
        {
            
            let varGetValue = muarrayMessage.object(at: i)
            
            if(varGetValue as! String=="1")
                
            {
                
                
                
                //                commonClassHoldDataAccessibleVariable=CommonAccessibleHoldVariable()
                //
                //                commonClassHoldDataAccessibleVariable = muarrayGetContactProfileUpper.object(at: i) as! CommonAccessibleHoldVariable
                //
                //                let varGetPhoneNumber = commonClassHoldDataAccessibleVariable.varPhoneNumberDynamicProf
                
                var contactNumber = phnArray[i]
                
                varContactString.append(contactNumber)  //DPK
                // varContactString=varContactString+","+varGetPhoneNumber // Comment By Deepak
                
                //print("77777777777777777777777777777777777777777777777777777",varContactString)
                varISPhoneNumberContain="yes"
                
            }
            
        }
        
        if(varISPhoneNumberContain=="no")
            
        {
            
            self.view.makeToast("Please select at least one contact number", duration: 2, position: CSToastPositionCenter)
            
        }
        
        else if(varISPhoneNumberContain=="yes")
                
        {
            //varContactString
            //print("SMS sent")
            
            let messageVC = MFMessageComposeViewController()
            
            messageVC.body = ""
            
            messageVC.recipients = varContactString // Optionally add some tel numbers
            
            messageVC.messageComposeDelegate = self
            
            // Open the SMS View controller
            
            present(messageVC, animated: true, completion: nil)
            
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    
    {
        
        /*
         
         switch result.rawValue {
         
         case MessageComposeResultCancelled.rawValue :
         
         //print("message canceled")
         
         
         
         case MessageComposeResultFailed.rawValue :
         
         //print("message failed")
         
         
         
         case MessageComposeResultSent.rawValue :0
         
         //print("message sent")
         
         
         
         default:
         
         break
         
         }
         
         */
        controller.dismiss(animated: true, completion: nil)
    }
    
    /*--need to feth data for all information table view----*/
    
    func functionForFetchOtherDetailsFromPersonalBusinessTables()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        let contactDB = FMDatabase(path: databasePath as String)
        print(profileId)
        if (contactDB?.open())!
        {
            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT uniquekey,value,PersonalORBusiness from PersonalBusinessMemberDetails where  profileId="+profileId+""
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                var letGetKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                
                let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                
                let letGetPersonalORBusiness:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "PersonalORBusiness")
                
                let letGetValues = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                
                print(letGetKey)
                
                print(letGetValues)
                
                print(letGetPersonalORBusiness)
                
                print(letGetValues)
                if(letGetKey=="member_name")
                    
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 0, with: "Name")
                        muarrayValueFirst.replaceObject(at: 0, with: letGetValue)
                        muarrayContactKey.add("Name")
                        muarrayContactValue.add(letGetValue)
                    }
                }
                
                else if(letGetKey=="member_mobile_no")
                        
                {
                    muarrayKeyFirst.replaceObject(at: 1, with: "Telephone No.")
                    muarrayValueFirst.replaceObject(at: 1, with: letGetValue)
                    muarrayContactKey.add("Telephone No.")
                    muarrayContactValue.add(letGetValue)
                }
                
                else if(letGetKey=="secondry_mobile_no")
                        
                {
                    print("Value of secondary mobile no is \(letGetValue)")
                    let memberNames = letGetValue.trimmingCharacters(
                        in: CharacterSet.whitespacesAndNewlines)
                    if(memberNames.characters.count>3)
                    {
                        muarrayKeyFirst.replaceObject(at: 2, with: "Telephone No.")
                        muarrayValueFirst.replaceObject(at: 2, with: letGetValue)
                    }
                }
                
                else if(letGetKey=="member_email_id")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        buttonEmailss.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 3, with: "Email")
                        
                        muarrayValueFirst.replaceObject(at: 3, with: letGetValue)
                        muarrayContactKey.add("Email")
                        muarrayContactValue.add(letGetValue)
                    }
                }
                
                else if(letGetKey=="member_buss_email")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        buttonEmailss.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 4, with: "Email")
                        
                        muarrayValueFirst.replaceObject(at: 4, with: letGetValue)
                    }
                    
                }
                
                else if(letGetKey=="BusinessName")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 5, with: "Business Name")
                        
                        muarrayValueFirst.replaceObject(at: 5, with: letGetValue)
                    }
                    
                    
                    
                    
                }
                
                else if(letGetKey=="businessPosition")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 6, with: "Designation")
                        
                        muarrayValueFirst.replaceObject(at: 6, with: letGetValue)
                    }
                }
                
                
                
                else if(letGetKey=="designation")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 9, with: "Classification")
                        
                        muarrayValueFirst.replaceObject(at: 9, with: letGetValue)
                    }
                    
                }
                
                else if(letGetKey=="Keywords")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 10, with: "Keywords about your profession")
                        
                        muarrayValueFirst.replaceObject(at: 10, with: letGetValue)
                    }
                    
                }
                
                else if(letGetKey=="member_rotary_id")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 11, with: "Rotary ID")
                        
                        muarrayValueFirst.replaceObject(at: 11, with: letGetValue)
                    }
                    
                }
                
                
                else if(letGetKey=="member_master_designation")
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 12, with: "Club Designation")
                        muarrayValueFirst.replaceObject(at: 12, with: letGetValue)
                        
                    }
                    
                    //                    if(self.FromDistrictOrBOD=="FromDistrictOrBOD")
                    //                    {
                    //
                    //                    }
                    //                    else if (self.isCategory=="1")
                    //                    {
                    if(letGetValue.characters.count>0)
                    {
                        //                        self.lblClubDesignation.text! = groupUniqueName
                    }
                    else
                    {
                        //                        self.lblClubDesignation.text! = groupUniqueName
                        
                    }
                    //}
                }
                else if(letGetKey=="dg_master_designation")
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 13, with: "District Designation")
                        
                        muarrayValueFirst.replaceObject(at: 13, with: letGetValue)
                        
                    }
                    if(letGetValue.characters.count>0)
                    {
                        //  labelDisctrictDesignation.text=letGetValue+" (District)"
                        labelDisctrictDesignation.text=""
                    }
                    else
                    {
                        labelDisctrictDesignation.text=""
                        
                    }
                    //                    if(self.FromDistrictOrBOD=="FromDistrictOrBOD")
                    //                    {
                    //
                    //                    }
                    //                    else if (self.isCategory=="2")
                    //                    {
                    
                    /*
                     if(letGetValue=="")
                     {
                     
                     }
                     else
                     {
                     self.lblClufdgfdgbDesignation.text! = letGetValue
                     }
                     
                     */ //DPK Comment 30-01-2018
                    
                    // }
                    
                    
                }
                
                else if(letGetKey=="rotary_donar_recognation")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 14, with: "Donor Recognition")
                        
                        muarrayValueFirst.replaceObject(at: 14, with: letGetValue)
                        
                    }
                    
                }
                
                else if(letGetKey=="member_date_of_birth")
                {
                    
                    
                    //print(letGetValue)
                    var resultString:String!=""
                    if(letGetValue.characters.count>2 && varGetPickerSelectValue != "Family" && letGetValue != "00/00/0000")
                    {
                        
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "dd/MM/yyyy"
                        let showDate = inputFormatter.date(from: letGetValue)
                        inputFormatter.dateFormat = "dd MMM"
                        let resultString = inputFormatter.string(from: showDate!)
                        //print(resultString)
                        muarrayKeyFirst.replaceObject(at: 15, with: "Birthday")
                        muarrayValueFirst.replaceObject(at: 15, with: resultString)
                    }
                    else
                    {
                        resultString = letGetValue
                        if(varGetPickerSelectValue == "Family")
                        {
                            
                        }
                        else if (varGetPickerSelectValue != "Family")
                        {
                            muarrayKeyFirst.replaceObject(at: 15, with: "Birthday")
                            muarrayValueFirst.replaceObject(at: 15, with: resultString)
                        }
                        
                    }
                    
                    
                }
                
                else if(letGetKey=="member_date_of_wedding")
                        
                {
                    
                    var resultString:String!=""
                    //print(letGetValue)
                    if(letGetValue.characters.count>2 && letGetValue != "00/00/0000")
                    {
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "dd/MM/yyyy"
                        let showDate = inputFormatter.date(from: letGetValue)
                        inputFormatter.dateFormat = "dd MMM"
                        resultString = inputFormatter.string(from: showDate!)
                        //print(resultString)
                    }
                    else
                    
                    {
                        resultString = letGetValue
                    }
                    
                    
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 16, with: "Anniversary")
                        muarrayValueFirst.replaceObject(at: 16, with: resultString)
                    }
                    
                }
                
                else if(letGetKey=="blood_Group")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        //muarrayKeyFirst.replaceObjectAtIndex(17, withObject: "Blood group")
                        
                        // muarrayValueFirst.replaceObjectAtIndex(17, withObject: letGetValue)
                        
                    }
                    
                }
                
                
                
                
                
                
                
                
            }
            
            //print(muarrayKeyFirst)
            
            //print(muarrayValueFirst)
            
        }
        
        
        
        //print(muarrayKeyFirst)
        //print(muarrayValueFirst)
        
        
        
        
        
//        functionForGetBusinessAddress()
        
    }
    
//    func functionForGetBusinessAddress()
//    
//    {
//        var databasePath : String
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        // open database
//        databasePath = fileURL.path
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            //print("error opening database")
//        }
//        else
//        {
//            // self.Createtablecity()
//        }
//        let contactDB = FMDatabase(path: databasePath as String)
//        if contactDB == nil
//        {
//            //print("Error: \(contactDB?.lastErrorMessage())")
//        }
//        if (contactDB?.open())!
//        {
//            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT addressType,address,city,pincode,state,country,phoneNo,addressID from AddressDetails where  profileId='"+profileId+"' and addressType='Business'"
//            //print(querySQLPersonalBusinessMemberDetails)
//            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
//            while resultsPersonalBusinessMemberDetails?.next() == true
//            {
//                var addressType:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressType")
//                let address:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "address")
//                var city:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "city")
//                var pincode:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "pincode")
//                var state:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "state")
//                var addressID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressID")
//                let country:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "country")
//                var phoneNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "phoneNo")
//                //                var varGetFullAddress:String!=""
//                //varGetFullAddress=addressType+" "+address+" "+city+" "+state+" "+country+" "+pincode
//                //                varGetFullAddress = address+" "+city+" "+state+" "+pincode+" "+country
//                
//                
//                var varGetFullAddress:String!=""
//                
//                var varGetFullAddress1:String!=""
//                var varGetFullAddress2:String!=""
//                var varGetFullAddress3:String!=""
//                var varGetFullAddress4:String!=""
//                var varGetFullAddress5:String!=""
//                varGetFullAddress = address+" "
//                varGetFullAddress1 = city+" "
//                varGetFullAddress2 = state+" "
//                varGetFullAddress3 = country+" "
//                varGetFullAddress4 = " "+pincode
//                
//                varGetFullAddress5 = varGetFullAddress + varGetFullAddress1 + varGetFullAddress2 + varGetFullAddress3
//                
//                let varGetFullAddress6 = varGetFullAddress5 + varGetFullAddress4
//                //              let  varGetFullAddress = address + fakeStr + city + state + country
//                
//                //                let saveName = "\(address) \(city) \(state) \()"
//                //                let  varGetFullAddress = address + "" + city + "" + state + "" + country
//                
//                print(varGetFullAddress6)
//                
//                //                let  varGetFullAddress = address + "" + city + "" + state + "" + country
//                self.muarrayContactKey.add("address")
//                self.muarrayContactValue.add(address)
//                self.muarrayContactKey.add("city")
//                self.muarrayContactValue.add(city)
//                self.muarrayContactKey.add("state")
//                self.muarrayContactValue.add(state)
//                self.muarrayContactKey.add("country")
//                self.muarrayContactValue.add(country)
//                self.muarrayContactKey.add("pincode")
//                self.muarrayContactValue.add(pincode)
//                //print("565656565655565656656656565665656565656565",varGetFullAddress)
//                if(varGetPickerSelectValue == "Family")
//                {
//                    
//                }
//                else
//                {
//                    let BusinessAddress:String = varGetFullAddress6.trimmingCharacters(in: CharacterSet.whitespaces)
//                    if(BusinessAddress.characters.count>0)
//                    {
//                        muarrayKeyFirst.replaceObject(at: 7, with: "Business Address")
//                        muarrayValueFirst.replaceObject(at: 7, with: BusinessAddress)
//                    }
//                    else
//                    {
//                    }
//                    var varGetstringGetcountryId:String! =  functionForSelectCountry(country)
//                    //print("fffffffffffffffffffffffffffffffffff",phoneNo)
//                    if(phoneNo.characters.count>4 && phoneNo != "") // DPK
//                    {
//                        muarrayKeyFirst.replaceObject(at: 8, with: "Business Contact No.")
//                        muarrayValueFirst.replaceObject(at: 8, with: varGetstringGetcountryId+" "+phoneNo)
//                    }
//                    else
//                    {
//                    }
//                }
//                //print("Business Address:->>>>>>>>>>>")
//                //print(phoneNo)
//            }
//        }
//        tableviewAllInformation.reloadData()
//        functionForResidencyAddress()
//        
//    }
    
//    func functionForResidencyAddress()
//    
//    {
//        
//        var databasePath : String
//        
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        
//        // open database
//        
//        databasePath = fileURL.path
//        
//        var db: OpaquePointer? = nil
//        
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            
//        {
//            
//            //print("error opening database")
//            
//        }
//        
//        else
//        
//        {
//            
//            // self.Createtablecity()
//            
//        }
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        
//        if contactDB == nil
//            
//        {
//            
//            //print("Error: \(contactDB?.lastErrorMessage())")
//            
//        }
//        
//        if (contactDB?.open())!
//            
//        {
//            
//            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT addressType,address,city,pincode,state,country,phoneNo,addressID from AddressDetails where  profileId='"+profileId+"' and addressType='Residence'"
//            
//            //print(querySQLPersonalBusinessMemberDetails)
//            
//            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
//            while resultsPersonalBusinessMemberDetails?.next() == true
//                    
//            {
//                
//                var addressType:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressType")
//                
//                let address:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "address")
//                
//                var city:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "city")
//                
//                let pincode:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "pincode")
//                
//                var state:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "state")
//                
//                var addressID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "addressID")
//                
//                var country:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "country")
//                
//                let phoneNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "phoneNo")
//                
//                var fakeStr:String! = " "
//                
//                var varGetFullAddress:String!=""
//                
//                var varGetFullAddress1:String!=""
//                var varGetFullAddress2:String!=""
//                var varGetFullAddress3:String!=""
//                var varGetFullAddress4:String!=""
//                var varGetFullAddress5:String!=""
//                varGetFullAddress = address+" "
//                varGetFullAddress1 = city+" "
//                varGetFullAddress2 = state+" "
//                varGetFullAddress3 = country+" "
//                varGetFullAddress4 = " "+pincode
//                
//                varGetFullAddress5 = varGetFullAddress + varGetFullAddress1 + varGetFullAddress2 + varGetFullAddress3
//                
//                let varGetFullAddress6 = varGetFullAddress5 + varGetFullAddress4
//                //              let  varGetFullAddress = address + fakeStr + city + state + country
//                
//                //                let saveName = "\(address) \(city) \(state) \()"
//                //                let  varGetFullAddress = address + "" + city + "" + state + "" + country
//                
//                print(varGetFullAddress6)
//                
//                //              let  varGetFullAddress = address + fakeStr + city + state + country
//                
//                //                let saveName = "\(address) \(city) \(state) \()"
//                //                let  varGetFullAddress = address + "" + city + "" + state + "" + country
//                
//                //                print(varGetFullAddress5)
//                if(varGetPickerSelectValue == "Family")
//                {
//                    
//                }
//                else
//                {
//                    //
//                    let ResidenceAddress:String = varGetFullAddress6.trimmingCharacters(in: CharacterSet.whitespaces)
//                    
//                    //                    let ResidenceAddress:String = varGetFullAddress.tri
//                    
//                    if(ResidenceAddress.characters.count>0)
//                    {
//                        muarrayKeyFirst.replaceObject(at: 18, with: "Residence Address")
//                        muarrayValueFirst.replaceObject(at: 18, with: varGetFullAddress6)
//                    }
//                    else
//                    {
//                    }
//                    var varGetstringGetcountryId:String! =  functionForSelectCountry(country)
//                    
//                    
//                    
//                    
//                    
//                    
//                    //print("fffffffffffffffffffffffffffffffffff",phoneNo)
//                    if(phoneNo.characters.count>4 && phoneNo != "") // DPK
//                    {
//                        muarrayKeyFirst.replaceObject(at: 19, with: "Residential Contact No.")
//                        
//                        muarrayValueFirst.replaceObject(at: 19, with: varGetstringGetcountryId+" "+phoneNo)                    }
//                    else
//                    {
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                }
//                
//                //print("Residence Address:->>>>>>>>>>>")
//                //print(phoneNo)
//                
//            }
//            
//            
//            
//        }
//        
//        //print(muarrayKeyFirst)
//        //print(muarrayValueFirst)
//        
//        
//        
//        
//        tableviewAllInformation.reloadData()
//        
//        
//        functionForGetFamilyDetails()
//        
//        
//        
//        
//        
//    }
    
//    func functionForGetFamilyDetails()
//    
//    {
//        var muarrayKeyFirstTemp:NSMutableArray=NSMutableArray()
//        var muarrayValueFirstTemp:NSMutableArray=NSMutableArray()
//        
//        for i in 00..<muarrayKeyFirst.count
//        {
//            var varGetTempKey=muarrayKeyFirst.object(at: i)as! String
//            var varGetTempValues=muarrayValueFirst.object(at: i)as! String
//            
//            
//            //print(varGetTempValues)
//            //print(varGetTempKey)
//            //print(muarrayKeyFirst.count)
//            //print(i)
//            if(varGetTempValues == "" || varGetTempValues == "NA" || varGetTempValues == "0" || varGetTempValues == " ")
//            {
//                
//            }
//            else
//            {
//                muarrayKeyFirstTemp.add(varGetTempKey)
//                muarrayValueFirstTemp.add(varGetTempValues)
//            }
//        }
//        
//        muarrayKeyFirst=NSMutableArray()
//        muarrayValueFirst=NSMutableArray()
//        
//        muarrayKeyFirst=muarrayKeyFirstTemp
//        muarrayValueFirst=muarrayValueFirstTemp
//        
//        //print(muarrayKeyFirstTemp)
//        //print(muarrayValueFirstTemp)
//        
//        
//        //print(muarrayKeyFirst)
//        //print(muarrayValueFirst)
//        
//        
//        
//        
//        
//        
//        
//        var databasePath : String
//        
//        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        
//        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
//        
//        // open database
//        
//        databasePath = fileURL.path
//        
//        var db: OpaquePointer? = nil
//        
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//            
//        {
//            
//            //print("error opening database")
//            
//        }
//        
//        else
//        
//        {
//            
//            // self.Createtablecity()
//            
//        }
//        
//        let contactDB = FMDatabase(path: databasePath as String)
//        
//        if contactDB == nil
//            
//        {
//            
//            //print("Error: \(contactDB?.lastErrorMessage())")
//            
//        }
//        
//        if (contactDB?.open())!
//            
//        {
//            
//            let querySQLPersonalBusinessMemberDetails = "select DISTINCT memberName,relationship,contactNo,emailID,bloodGroup,dob,anniversary,familyMemberId from FamilyMemberDetail where  profileId='"+profileId+"'"
//            
//            //print(querySQLPersonalBusinessMemberDetails)
//            
//            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
//            
//            while resultsPersonalBusinessMemberDetails?.next() == true
//            {
//                var memberName:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "memberName")
//                var familyMemberId:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "familyMemberId")
//                var relationship:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "relationship")
//                var contactNo:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "contactNo")
//                var emailID:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "emailID")
//                var bloodGroup:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "bloodGroup")
//                var dob:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "dob")
//                var anniversary:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "anniversary")
//                
//                ///here need to set country code on behaif of country id
//                
//                //print(contactNo)
//                if(contactNo.characters.count>0)
//                {
//                    var varGetCountryCode=contactNo.components(separatedBy: " ")
//                    
//                    var databasePath : String
//                    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                    let fileURL = documents.appendingPathComponent("Calendar.sqlite")
//                    // open database
//                    databasePath = fileURL.path
//                    var db: OpaquePointer? = nil
//                    if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//                    {
//                        //print("error opening database")
//                    }
//                    else
//                    {
//                        // self.Createtablecity()
//                    }
//                    let contactDB = FMDatabase(path: databasePath as String)
//                    if contactDB == nil
//                    {
//                        //print("Error: \(contactDB?.lastErrorMessage())")
//                    }
//                    var country_master_id:String!=""
//                    var country_Code:String!=""
//                    if (contactDB?.open())!
//                    {
//                        let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT country_master_id,country_master_name,country_code from country_master where  country_master_id='"+varGetCountryCode[0]+"'"
//                        //print(querySQLPersonalBusinessMemberDetails)
//                        let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
//                        while resultsPersonalBusinessMemberDetails?.next() == true
//                        {
//                            country_master_id=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_master_id")
//                            country_Code=resultsPersonalBusinessMemberDetails?.string(forColumn: "country_code")
//                        }
//                        //print("-------------------------")
//                        //print(country_Code)
//                        //print(country_master_id)
//                        //print(contactNo)
//                        
//                        contactNo=country_Code+" "+varGetCountryCode[1]
//                    }
//                }
//                
//                
//                /*
//                 muarrayNameThree
//                 muarrayFamilyMemberIDThree
//                 muarrayFamilyMemberDeletedIDThree
//                 muarrayRelationshipThree
//                 muarrayCountryTextThree
//                 muarrayCountryCodeThree
//                 muarrayCountryIdThree
//                 muarrayMobileNumberThree
//                 muarrayEmailIDThree
//                 muarrayBloodGroupThree
//                 muarrayBirthdayThree
//                 muarrayAnniversaryThree
//                 */
//                
//                memberName=memberName+"###"
//                relationship=relationship+"###"
//                contactNo=contactNo+"###"
//                emailID=emailID+"###"
//                bloodGroup=bloodGroup+"###"
//                dob=dob+"###"
//                anniversary=anniversary+"###"
//                
//                
//                //print(contactNo)
//                
//                
//                var varGetFullMemberDetails:String!=""
//                
//                
//                var String1:String!=memberName+relationship
//                var String2:String!=contactNo+emailID
//                var String3:String!=bloodGroup+dob
//                var String4:String!=anniversary
//                
//                var stringConcatStringFirst:String!=String1+String2
//                var stringConcatStringSecond:String!=String3+String4
//                
//                
//                
//                varGetFullMemberDetails=stringConcatStringFirst+stringConcatStringSecond
//                
//                
//                if(self.isCategory=="2")
//                {
//                    
//                }
//                else
//                {
//                    
//                    muarrayKeyFirst.add("familymember")
//                }
//                muarrayValueFirst.add(varGetFullMemberDetails)
//            }
//            
//        }
//        
//        //print(muarrayKeyFirst)
//        
//        //print(muarrayValueFirst)
//        
//        tableviewAllInformation.reloadData()
//        // tableviewAllInformation.setNeedsLayout()
//        
//        
//        
//        if(self.isCategory=="2")
//        {
//            
//        }
//        else
//        {
//            
//            
//            functionForAddFamilyImage()
//            
//        }
//        
//        
//    }
    func functionForAddFamilyImage()
    {
        /*
         @IBOutlet weak var viewFamilyImage: UIView!
         @IBOutlet weak var imageFamilyImage: UIImageView!
         @IBOutlet weak var buttonFamilyImage: UIButton!
         */
        
        //        muarrasdfsfyKeyFirst.addObject("familyphoto")
        //        muarrayValueFirst.addObject("http://www.google.com/sdfs.png")
        //
        
        
        
        //// 45546 456456 45 6456 456 456 456546 4 67356 6745 6546347 65767 57 563 7567
        
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB?.lastErrorMessage())")
        }
        if (contactDB?.open())!
        {
            
            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT familyPic  from ProfileMaster where  profileId="+profileId+""
            //print(querySQLPersonalBusinessMemberDetails)
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            //1.
            while resultsPersonalBusinessMemberDetails?.next() == true
            {
                var familyPic:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "familyPic")
                muarrayKeyFirst.add("familyphoto")
                //print(familyPic)
                muarrayValueFirst.add(familyPic)
                
                
            }
        }
        ///||||||
        
    }
    
    
    
    
    ////11-----member name
    func functionForSetColorMemberName(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////22-----relationship
    func functionForSetColorrelationship(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////33-----contactNo
    func functionForSetColorcontactNo(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////44-----emailID
    func functionForSetColoremailID(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////55-----emailID
    func functionForSetColorbloodGroup(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////66-----dob
    func functionForSetColordob(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    ////77-----anniversary
    func functionForSetColoranniversary(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#00AEEF\" >&nbsp;&nbsp;<br/>"+stringName+"<br/><br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    //8.
    func functionForSetColorAddress(_ stringKey:String,stringName:String)->NSAttributedString
    {
        let text = "I agree with TERMS and CONDITION"
        let linkTextWithColor = "CONDITION"
        let range = (text as NSString).range(of: linkTextWithColor)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        var attributedStringss:NSAttributedString=NSAttributedString()
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#808080\">"+stringKey+"</font> <font color=\"#000000\" >&nbsp;&nbsp;<br/><br/>"+stringName+"<br/></span></font> </font>"
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
        } catch _ {
            //print("Cannot create attributed String")
        }
        //print(attributedStringss)
        return attributedStringss
    }
    func functionForSelectCountry(_ stringCountryName:String)->String
    {
        var letGetLastUpdateDate:String!=""
        
        ModelManager.getInstance()
        
        //  ModelManager.getInstance().getAllStudentData(String(NSCalendar.currentCalendar().components([.Day , .Month , .Year], fromDate: NSDate()).month), stringYear: String(NSCalendar.currentCalendar().components([.Day , .Month , .Year], fromDate: NSDate()).year))
        
        
        
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select DISTINCT country_code from country_master where country_master_name='"+stringCountryName+"'", withArgumentsIn: nil)
        
        //print("select DISTINCT country_code from country_master where country_master_name='"+stringCountryName+"'")
        
        
        
        var stringGetcountryId:String!=""
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                stringGetcountryId = resultSet.string(forColumn: "country_code")
                
            }
        }
        sharedInstance.database!.close()
        //print(stringGetcountryId)
        return stringGetcountryId
    }
    
    
    
    
    
    
    
    
    func functionForFetchOtherDetailsFromPersonalBusinessTablesForDistrict()
    {
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            
        {
            
            //print("error opening database")
            
        }
        
        else
        
        {
            
            // self.Createtablecity()
            
        }
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB == nil
            
        {
            
            //print("Error: \(contactDB?.lastErrorMessage())")
            
        }
        
        if (contactDB?.open())!
            
        {
            
            let querySQLPersonalBusinessMemberDetails = "SELECT DISTINCT uniquekey,value,PersonalORBusiness from PersonalBusinessMemberDetails where  profileId="+profileId+""
            
            print("querySQLPersonalBusinessMemberDetails::\(querySQLPersonalBusinessMemberDetails)")
            
            let resultsPersonalBusinessMemberDetails:FMResultSet? = contactDB?.executeQuery(querySQLPersonalBusinessMemberDetails,withArgumentsIn: nil)
            
            //1.
            
            while resultsPersonalBusinessMemberDetails?.next() == true
                    
            {
                var letGetKey:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "uniquekey")
                
                let letGetValue:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "value")
                
                let letGetPersonalORBusiness:String!=resultsPersonalBusinessMemberDetails?.string(forColumn: "PersonalORBusiness")
                
                let letGetValues = letGetValue.trimmingCharacters(in: CharacterSet.whitespaces)
                
                print(letGetValue)
                print(letGetKey)
                print(letGetPersonalORBusiness)
                print(letGetValues)
                
                
                if(letGetKey=="member_name")
                    
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 0, with: "Name")
                        muarrayValueFirst.replaceObject(at: 0, with: letGetValue)
                        muarrayContactKey.add("Name")
                        muarrayContactValue.add(letGetValue)
                        
                    }
                }
                
                else if(letGetKey=="member_mobile_no")
                        
                {
                    
                    muarrayKeyFirst.replaceObject(at: 1, with: "Telephone No.")
                    muarrayValueFirst.replaceObject(at: 1, with: letGetValue)
                    muarrayContactKey.add("Telephone No.")
                    muarrayContactValue.add(letGetValue)
                    
                }
                
                else if(letGetKey=="secondry_mobile_no")
                        
                {
                    
                    
                    if(letGetValue.characters.count>2)
                    {
                        muarrayKeyFirst.replaceObject(at: 2, with: "Telephone No.")
                        muarrayValueFirst.replaceObject(at: 2, with: letGetValue)
                    }
                }
                
                else if(letGetKey=="member_email_id")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        buttonEmailss.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 3, with: "Email")
                        
                        muarrayValueFirst.replaceObject(at: 3, with: letGetValue)
                        muarrayContactKey.add("Email")
                        muarrayContactValue.add(letGetValue)
                    }
                }
                
                else if(letGetKey=="member_buss_email")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        buttonEmailss.setImage(UIImage(named: "mail_gray.png"),  for: UIControl.State.normal)
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 4, with: "Email")
                        
                        muarrayValueFirst.replaceObject(at: 4, with: letGetValue)
                    }
                    
                }
                
                else if(letGetKey=="BusinessName")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 5, with: "Business Name")
                        
                        muarrayValueFirst.replaceObject(at: 5, with: letGetValue)
                    }
                    
                    
                    
                    
                }
                
                else if(letGetKey=="businessPosition")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 6, with: "Designation")
                        
                        muarrayValueFirst.replaceObject(at: 6, with: letGetValue)
                    }
                }
                
                
                
                else if(letGetKey=="designation")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 9, with: "Classification")
                        muarrayValueFirst.replaceObject(at: 9, with: letGetValue)
                    }
                }
                
                else if(letGetKey=="Keywords")
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 10, with: "Keywords about your profession")
                        muarrayValueFirst.replaceObject(at: 10, with: letGetValue)
                    }
                }
                
                else if(letGetKey=="member_rotary_id")
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 11, with: "Rotary ID")
                        muarrayValueFirst.replaceObject(at: 11, with: letGetValue)
                    }
                }
                else if(letGetKey=="club_name")
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 12, with: "Club Name")
                        muarrayValueFirst.replaceObject(at: 12, with: letGetValue)
                    }
                }
                else if(letGetKey=="member_master_designation")
                {
                    if letGetValue != ""
                    {
                        //print("%%%%%%%%%%%%%%%%%%",letGetValue)
                        if(varGetPickerSelectValue == "Family")
                        {
                        }
                        else
                        {
                            muarrayKeyFirst.replaceObject(at: 13, with: "Club Designation")
                            muarrayValueFirst.replaceObject(at: 13, with: letGetValue)
                        }
                        
                        if(self.FromDistrictOrBOD=="FromDistrictOrBOD" &&  self.isCategory=="2")
                        {
                        }
                        else
                        {
                            if(letGetValue.characters.count>2)
                            {
                                //                                self.lblClubDesignation.text! = letGetValue+"( Club)"
                            }
                            else
                            
                            {
                                //                                self.lblClubDesignation.text! = letGetValue
                            }
                        }
                    }
                    else
                    {
                        
                    }
                }
                else if(letGetKey=="dg_master_designation")
                {
                    if(letGetValue != "")
                    {
                        //print("@@@@@@@@@@@@@@@@@@",letGetValue)
                        if(varGetPickerSelectValue == "Family")
                        {
                        }
                        else
                        {
                            muarrayKeyFirst.replaceObject(at: 13, with: "District Designation")
                            muarrayValueFirst.replaceObject(at: 13, with: letGetValue)
                        }
                    }
                    else
                    {
                    }
                    if(letGetValue=="")
                    {
                    }
                    else
                    {
                        if(self.FromDistrictOrBOD=="FromDistrictOrBOD" &&  self.isCategory=="2")
                        {
                        }
                        else
                        {
                            if(letGetValue.characters.count>2)
                            {
                                //                                self.lblClubDesignation.text! = letGetValue+"( Club)"
                            }
                            else
                            {
                                //                                self.lblClubDesignation.text! = letGetValue
                            }
                        }
                    }
                }
                
                else if(letGetKey=="rotary_donar_recognation")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                    }
                    else
                    {
                        
                        muarrayKeyFirst.replaceObject(at: 14, with: "Donor Recognition")
                        
                        muarrayValueFirst.replaceObject(at: 14, with: letGetValue)
                        
                    }
                    
                }
                
                else if(letGetKey=="member_date_of_birth")
                {
                    
                    
                    //print(letGetValue)
                    var resultString:String!=""
                    if(letGetValue.characters.count>2 && varGetPickerSelectValue != "Family" && letGetValue != "00/00/0000")
                    {
                        
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "dd/MM/yyyy"
                        let showDate = inputFormatter.date(from: letGetValue)
                        inputFormatter.dateFormat = "dd MMM"
                        let resultString = inputFormatter.string(from: showDate!)
                        //print(resultString)
                        muarrayKeyFirst.replaceObject(at: 15, with: "Birthday")
                        muarrayValueFirst.replaceObject(at: 15, with: resultString)
                    }
                    else
                    {
                        resultString = letGetValue
                        if(varGetPickerSelectValue == "Family")
                        {
                            
                        }
                        else if (varGetPickerSelectValue != "Family")
                        {
                            muarrayKeyFirst.replaceObject(at: 15, with: "Birthday")
                            muarrayValueFirst.replaceObject(at: 15, with: resultString)
                        }
                    }
                }
                else if(letGetKey=="member_date_of_wedding")
                        
                {
                    
                    var resultString:String!=""
                    //print(letGetValue)
                    if(letGetValue.characters.count>2 && letGetValue != "00/00/0000")
                    {
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "dd/MM/yyyy"
                        let showDate = inputFormatter.date(from: letGetValue)
                        inputFormatter.dateFormat = "dd MMM"
                        resultString = inputFormatter.string(from: showDate!)
                        //print(resultString)
                    }
                    else
                    
                    {
                        resultString = letGetValue
                    }
                    
                    
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        muarrayKeyFirst.replaceObject(at: 16, with: "Anniversary")
                        muarrayValueFirst.replaceObject(at: 16, with: resultString)
                    }
                    
                }
                
                else if(letGetKey=="blood_Group")
                        
                {
                    if(varGetPickerSelectValue == "Family")
                    {
                        
                    }
                    else
                    {
                        // muarrayKeyFirst.replaceObjectAtIndex(17, withObject: "Blood group")
                        
                        // muarrayValueFirst.replaceObjectAtIndex(17, withObject: letGetValue)
                        
                    }
                    
                }
                
                
                
                
                
                
                
                
            }
            //print(muarrayKeyFirst)
            //print(muarrayValueFirst)
        }
        //print(muarrayKeyFirst)
        //print(muarrayValueFirst)
        
//        functionForGetBusinessAddress()
        tableviewAllInformation.reloadData()
        
    }
    
    
    /*---------------------------------------*/
    func functionForGetZipFilePath()
    {
        //if any json file(New,Updated,Deleted) is remain to server then first server that
        //code by Rajendra Jat for delete all zip files from document directory
        
        functionForGetNewUpdateDeleteMember()
        MainDashboardViewController().funcForRemoveZipFileFromDocumentDirectory()
        //print("™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™™")
        
        
        
        
        
        var updatedOn =  String ()
        let defaults = UserDefaults.standard
        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",grpID)
        
        
        var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String?
        ////print(testlet)
        
        if let str = defaults.value(forKey: UpdatedefaultNew) as! String?
        {
            ////print(str)
            updatedOn = str
            // updatedOn = "19bv70-01-01 00:00:00"
        }
        
        
        
        
        //
        //        var updatedOn =  String ()
        //        let defaults = UserDefaults.standard
        //        let UpdatedefaultNew = String(format: "updatedOnDirectory%@",grpID)
        //
        //
        //      //  var  testlet = defaults.value(forKey: UpdatedefaultNew) as! String
        //        ////print(testlet)
        //
        //        if let str:String? = defaults.value(forKey: UpdatedefaultNew) as? String
        //        {
        //            //print(str)
        //            updatedOn = str!
        //            // updatedOn = "19bv70-01-01 00:00:00"
        //        }
        else
        {
            updatedOn = "1970-01-01 00:00:00"
        }
        if(updatedOn == "1970-01-01 00:00:00")
        {
            
        }
        //moduleId
        var  completeURL:String!=""
        if(isCategory=="2") //DPK
        {
            completeURL = baseUrl+touchBAse_GetDistrictListSync
        }
        else
        {
            completeURL = baseUrl+touchBase_GetMemberListSync
        }
        
        
        
        if(grpID.hasPrefix("Optional("))
        {
            let result3 = String(grpID.dropFirst(9))    // "he"
            //print(result3)
            grpID = String(result3.dropLast(1))   // "o"
            //print("31313113133131131331313131311331133131313131",grpID)
        }
        
        
        
        
        
        
        
        let parameterst = [
            k_API_DirectoryZipFile : self.grpID!,
            k_API_updatedOn : updatedOn
        ]
        
        //print(parameterst)
        //print(completeURL)
        //----------------------
        //------------------------------------------------------
        
        Alamofire.request(completeURL, method: .post, parameters: parameterst, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            switch response.result {
            case .success:
                // var result = [String:String]()
                
                //print("adasdsadsadsa")
                //print(response)
                
                
                if(response != nil)
                {
                    let dd = response.result.value as! NSDictionary
                    
                    
                    /*
                     //print(response)
                     let dd = response as! NSDictionary
                     //print("dd \(dd)")
                     var varGetValueServerError = dd.object(forKey: "serverError")as? String
                     
                     if(varGetValueServerError == "Error")
                     {
                     self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                     SVProgressHUD.dismiss()
                     }
                     else
                     {
                     */
                    if let value = response.result.value {
                        let dic = response.result.value!
                        let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        ////print(jsonString)
                        //--
                        if(response==nil)
                        {
                        }
                        else
                        {
                            UserDefaults.standard.set(dd.object(forKey: "curDate")as! String, forKey: UpdatedefaultNew)
                            // //print(NSUserDefaults.standardUserDefaults().setObject(dd.objectForKey("curDate")as! String, forKey: UpdatedefaultNew))
                            // //print(dd.objectForKey("curDate")as! String)
                            //print(dd)
                            if(dd.object(forKey: "status") as! String == "1")
                            {
                                // self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                                //self.fetchData()
                                SVProgressHUD.dismiss()
                            }
                            else
                            {
                                
                                if(dd.object(forKey: "status") as! String == "2")
                                {
                                    //self.view.makeToast("No new updates found", duration: 2, position: CSToastPositionCenter)
                                    //self.fetchData()
                                }
                                else
                                {
                                    let UpdateMemberListjsonResult: NSDictionary = NSDictionary()
                                    
                                    //print("this is c")
                                    //print(dd)
                                    var varGetNewMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")
                                    var varGetUpdatedMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")
                                    
                                    //print("this is delete when member is deleted,˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚")
                                    //print(dd)
                                    var varGetDeleteMemberList=(dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "DeletedMemberList") as? String
                                    
                                    //print(varGetDeleteMemberList)
                                    //print("this is new,˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚˚")
                                    if(varGetDeleteMemberList != nil)
                                    {
                                        
                                    }
                                    else if(varGetDeleteMemberList != nil)
                                    {
                                        self.functionForDeleteMembers([varGetDeleteMemberList!])
                                    }
                                    /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                                    if(varGetNewMemberList != nil)
                                    {
                                        self.functionForNewMemberWhenDataComingNotZipFile(dd)
                                    }
                                    /*555555555555555555555555555555555555555555555555555555555555555555555555555555555555*/
                                    
                                    /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                                    if(varGetUpdatedMemberList != nil)
                                    {
                                        self.functionForUpdateMemberWhenDataComingNotZipFile(dd)
                                    }
                                    /*6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666*/
                                    //self.fetchData()
                                }
                            }
                        }
                    }
                }
                //}
            case .failure(_): break
            }
        }
        //----------------------------------------------------
        //----------------------------
        
    }
    ////
    func functionForDeleteMembers(_ muaarayDeleteMemberListjsonResult:[String])
    {
        //print("Called !!!!!!")
        // //print(muaarayDeleteMemberListjsonResult)
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
            // self.Createtablecity()
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            //print("22This is count of main start point of file:-----------")
            for i in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                
                let insertSQLDelete = "DELETE FROM  ProfileMaster  where profileId in  ("+muaarayDeleteMemberListjsonResult[i]+")"
                let result = contactDB?.executeStatements(insertSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
            }
            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='personal'"
                //  //print(childSQL)
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
            for j in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let childSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails where profileId in ("+muaarayDeleteMemberListjsonResult[j]+") and PersonalORBusiness='Business'"
                let result = contactDB?.executeStatements(childSQLDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //3. PersonalBusinessMemberDetails
            for k in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let familyMemberDetailsDelete = "DELETE FROM  FamilyMemberDetail  where profileId in ("+muaarayDeleteMemberListjsonResult[k]+")"
                let result = contactDB?.executeStatements(familyMemberDetailsDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
            //4.  AddressDetails
            for l in 0 ..< muaarayDeleteMemberListjsonResult.count
            {
                let addressDetailDelete = "DELETE FROM  AddressDetails  where profileId in ("+muaarayDeleteMemberListjsonResult[l]+")"
                let result = contactDB?.executeStatements(addressDetailDelete)
                if (result == nil)
                {
                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                }
                else
                {
                    
                }
            }
        }
        else
        {
            //print("Error: \(contactDB?.lastErrorMessage())")
        }
        //---
        //  fetchData()
        contactDB?.commit()
        contactDB?.close()
    }
    var varGetTotalFilesCount:Int!=0
    /////------
    func functionForNewMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        if(ifDirecUnloads==1)
        {
            
            
        }
        else
        {
            var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
            dictNewMemberListjsonResult=dd
            
            
            
            var databasePath : String
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent("NewTouchbase.db")
            // open database
            databasePath = fileURL.path
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK
            {
                //print("error opening database")
            }
            else
            {
                // self.Createtablecity()
            }
            let contactDB = FMDatabase(path: databasePath as String)
            if contactDB == nil
            {
                //print("Error: \(contactDB?.lastErrorMessage())")
            }
            if let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as? String
            {
                print("Entered in if case")
                if  let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as? String
                // let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                
                {
                    if (contactDB?.open())!
                    {
                        ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
                        
                        // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
                        //print(dictNewMemberListjsonResult)
                        //print((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count)
                        
                        var getValue = ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
                        
                        if(getValue == nil)
                        {
                            
                        }
                        else if(getValue != nil)
                        {
                            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).count
                            {
                                
                                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                // //print(dictMain)
                                
                                
                                // let  dict = arrdata[i] as! NSDictionary
                                //let dictMain=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i)
                                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                                
                                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                                
                                //
                                
                                //print(dictNewMemberListjsonResult)
                                
                                
                                
                                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                
                                
                                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                                
                                //print(dictMain)
                                //print(profilePic)
                                //print(familyPic)
                                // //print(profileID)
                                let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                                ////print(insertSQL)
                                let result = contactDB?.executeStatements(insertSQL)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                else
                                {
                                    // //print("success saved");//print(databasePath);
                                    //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("NewMemberList")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count)
                                    
                                    var dictTemporaryDictionarynew22:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                    
                                    for j in 0 ..< (dictTemporaryDictionarynew22.object(forKey: "personalMemberDetails")! as AnyObject).count
                                    {
                                        let dictChild=(dictTemporaryDictionarynew22.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                                        ////print(dictChild)
                                        print(dictChild)
                                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                        
                                        let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                                        // //print(childSQLl)
                                        let result = contactDB?.executeStatements(childSQLl)
                                        if (result == nil)
                                        {
                                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                        }
                                        else
                                        {
                                        }
                                        
                                        
                                        print(result)
                                    }
                                    //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count)
                                    
                                    var dictTemporaryDictionarydfdsfdsfdsfsdf:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                    
                                    
                                    
                                    
                                    for j in 0 ..< (dictTemporaryDictionarydfdsfdsfdsfsdf.object(forKey: "businessMemberDetails")! as AnyObject).count
                                    {
                                        
                                        var dictTemporaryDictionarfghfghfghfdhdfhf:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                        
                                        
                                        
                                        let dictChild=(dictTemporaryDictionarfghfghfghfdhdfhf.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                                        
                                        //   let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
                                        let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                        let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                        let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                        let value=(dictChild as AnyObject).object(forKey: "value")as! String
                                        let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                        let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                        let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                        
                                        let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                                        ////print(childSQLNewww)
                                        let result = contactDB?.executeStatements(childSQLNewww)
                                        if (result == nil)
                                        {
                                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                        }
                                        else
                                        {
                                            
                                        }
                                    }
                                    //3. PersonalBusinessMemberDetails
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMemberDetails")!.count)
                                    // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemberDetails")!.count
                                    //for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("NewMemberList")!.objectAtIndex(i).objectForKey("familyMemberDetails")!.objectForKey("familyMemberDetail")!.count
                                    
                                    var dictTemporaryDictionarynewew:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                    
                                    
                                    
                                    for k in 0 ..< ((dictTemporaryDictionarynewew.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                                    {
                                        
                                        
                                        
                                        let dictChild=((dictTemporaryDictionarynewew.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)  // DPK
                                        // let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMemberDetails")!.objectForKey("familyMemberDetail")!.objectAtIndex(k)   // Comment by DPK
                                        //print("app Crashhed Check",dictChild)
                                        
                                        var dictTemporaryDictionaryewrwewe:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                        
                                        
                                        let isVisible=(dictTemporaryDictionaryewrwewe.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                                        
                                        
                                        let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                                        let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                                        let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                                        let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                                        let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                                        let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                                        let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                                        let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                                        let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                                        
                                        let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                                        
                                        let result = contactDB?.executeStatements(familyMemberDetails)
                                        if (result == nil)
                                        {
                                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                        }
                                        else
                                        {
                                            
                                        }
                                    }
                                    //4.  AddressDetails
                                    //for l in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("addressDetails")!.count
                                    
                                    // //print("This is count:------")
                                    
                                    // let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("addressDetails")!.objectForKey("addressResult")
                                    // //print(dictChild)
                                    
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0))
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("addressDetails")!.objectForKey("addressResult"))
                                    
                                    
                                    
                                    
                                    var dictTemporaryDictionarynbnvbv:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                    
                                    
                                    for l in 0 ..< ((dictTemporaryDictionarynbnvbv.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                                    {
                                        
                                        var dictTemporaryDictionarynewchild:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                        
                                        let dictChild=((dictTemporaryDictionarynewchild.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                                        
                                        
                                        
                                        var dictTemporaryDictionarysadsadasdasdasd:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                        
                                        let isBusinessAddrVisible=(dictTemporaryDictionarysadsadasdasdasd.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                                        
                                        var dictTemporaryDictionarysdfgddsfdsafsadfasdf:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "NewMemberList")! as AnyObject).object(at: i)
                                        
                                        let isResidanceAddrVisible=(dictTemporaryDictionarysdfgddsfdsafsadfasdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                                        
                                        
                                        let address=(dictChild as AnyObject).object(forKey: "address")as! String
                                        let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                                        let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                                        let city=(dictChild as AnyObject).object(forKey: "city")as! String
                                        let country=(dictChild as AnyObject).object(forKey: "country")as! String
                                        let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                                        let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                                        let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                                        ////print(pincode)
                                        let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                                        
                                        let state=(dictChild as AnyObject).object(forKey: "state")as! String
                                        // //print(state)
                                        
                                        //print("this is country from rajendra side")
                                        //print(country)
                                        
                                        let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                                        
                                        ////print(familyMemberDetails)
                                        
                                        
                                        let result = contactDB?.executeStatements(familyMemberDetails)
                                        if (result == nil)
                                        {
                                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                        }
                                        else
                                        {
                                            
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
            contactDB?.close()
        }
        
    }
    //////----
    func functionForUpdateMemberWhenDataComingNotZipFile(_ dd:NSDictionary)
    {
        if(ifDirecUnloads==1)
        {
            
            
        }
        else
        {
            
            // //print(dd)
            if let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as? String
            {
                if let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as? String
                {
                    var dictNewMemberListjsonResult:NSDictionary=NSDictionary()
                    dictNewMemberListjsonResult=dd
                    
                    
                    var databasePath : String
                    let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let fileURL = documents.appendingPathComponent("NewTouchbase.db")
                    // open database
                    databasePath = fileURL.path
                    var db: OpaquePointer? = nil
                    if sqlite3_open(fileURL.path, &db) != SQLITE_OK
                    {
                        //print("error opening database")
                    }
                    else
                    {
                        // self.Createtablecity()
                    }
                    let contactDB = FMDatabase(path: databasePath as String)
                    if contactDB == nil
                    {
                        //print("Error: \(contactDB?.lastErrorMessage())")
                    }
                    let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                    if (contactDB?.open())!
                    {
                        //print("33This is count of main start point of file:-----------")
                        ////print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
                        
                        // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!)
                        
                        ((dd.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
                        
                        
                        var getValue = ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
                        
                        
                        
                        if(getValue == nil)
                        {
                            
                        }
                        else if(getValue != nil)
                        {
                            ////print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
                            for i in 0 ..< ((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).count
                            {
                                // let  dict = arrdata[i] as! NSDictionary
                                let dictMain=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                // //print(dictMain)
                                // let dictMain=dictNewMemberListjsonResult.objectForKey("MemberDetail")!
                                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                                var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                                //familyPic
                                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                                //
                                
                                //////////-----------
                                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                
                                
                                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                                
                                
                                /////////-----------
                                
                                //print(dictMain)
                                //print(profilePic)
                                //print(familyPic)
                                
                                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                let result = contactDB?.executeStatements(insertSQLUpdate)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                
                                var cdicvxcTempxcvoxcvraryDxcvictionavcry:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                
                                
                                
                                let dictMainasdas=cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")
                                // //print(dictMainasdas)
                                
                                for j in 0 ..< (cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")! as AnyObject).count
                                {
                                    let dictChild=(cdicvxcTempxcvoxcvraryDxcvictionavcry.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                                    
                                    ////print(dictChild)
                                    
                                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                    
                                    
                                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                                    
                                    
                                    
                                    
                                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                                    
                                    let result = contactDB?.executeStatements(childSQLUpdate)
                                    if (result == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                    else
                                    {
                                    }
                                }
                                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                                // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count)
                                // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("businessMemberDetails")!)
                                
                                var dictTemporaryDictionaryzfdhjhhjkhkhjkhj:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                
                                
                                for j in 0 ..< (dictTemporaryDictionaryzfdhjhhjkhkhjkhj.object(forKey: "businessMemberDetails")! as AnyObject).count
                                {
                                    
                                    let dictChild=(dictTemporaryDictionaryzfdhjhhjkhkhjkhj.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                                    
                                    //print("businessMemberDetails**businessMemberDetails**businessMemberDetails**",dictChild)
                                    
                                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                    
                                    
                                    let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"'  and moduleID='"+moduleID+"' and groupId='"+GroupID+"' "
                                    
                                    // //print(childSQL)
                                    let result = contactDB?.executeStatements(childSQLUpdate)
                                    if (result == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                    else
                                    {
                                        
                                    }
                                }
                                
                                //3. PersonalBusinessMemberDetails
                                
                                var dictsTempsoraryDisctionsarylaterss:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                
                                
                                var varGetCountFamilyMemberDetail:Int!=((dictsTempsoraryDisctionsarylaterss.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                                
                                
                                //print(masterID)
                                if(varGetCountFamilyMemberDetail>0)
                                {
                                    let insertSQLDelete = "DELETE FROM  FamilyMemberDetail  where masterId="+masterID+""
                                    let result = contactDB?.executeStatements(insertSQLDelete)
                                    if (result == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                }
                                
                                
                                var dictTemporaryDictionary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                
                                for k in 0 ..< ((dictTemporaryDictionary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                                        
                                {
                                    
                                    // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectForKey("UpdatedMemberList")!.objectAtIndex(i).objectForKey("familyMemdfgberDetails")!.objectForKey("familyMemberDetail")!)
                                    
                                    
                                    var dictTsdfemporsdfaryDictidfsfonary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                    
                                    let dictChild=((dictTemporaryDictionary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).object(at: k)
                                    
                                    let isVisible=(dictTsdfemporsdfaryDictidfsfonary.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                                    
                                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                                    /*
                                     let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"
                                     
                                     */
                                    
                                    
                                    
                                    
                                    
                                    
                                    let familyMemberDetailsUpdate = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                                    let resultinserts = contactDB?.executeStatements(familyMemberDetailsUpdate)
                                    if (resultinserts == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                    else
                                    {
                                        
                                    }
                                }
                                
                                //4.  AddressDetails
                                
                                var diasdctTasdemposdrrasdaryDsdaictioasdnary:NSDictionary=((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(forKey: "UpdatedMemberList")! as AnyObject).object(at: i)
                                
                                
                                for l in 0 ..< ((diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                                {
                                    
                                    
                                    
                                    let dictChild=((diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                                    
                                    let isBusinessAddrVisible=(diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                                    let isResidanceAddrVisible=(diasdctTasdemposdrrasdaryDsdaictioasdnary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                                    
                                    
                                    // //print(dictChild)
                                    
                                    // //print(isBusinessAddrVisible)
                                    // //print(isResidanceAddrVisible)
                                    
                                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                                    var country=(dictChild as AnyObject).object(forKey: "country")as! String
                                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                                    
                                    
                                    
                                    let insertSQLDelete = "DELETE FROM  AddressDetails  where addressID='"+addressID+"' "
                                    let resultt = contactDB?.executeStatements(insertSQLDelete)
                                    if (resultt == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                    
                                    //print("this is country from rajendra side222222")
                                    //print(country)
                                    if(country.characters.count>2)
                                    {
                                        
                                    }
                                    else
                                    {
                                        country="India"
                                    }
                                    
                                    // //print(dictChild)
                                    let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                                    
                                    //  //print(familyMemberDetails)
                                    ////print("AddressDetails",l)
                                    
                                    let result = contactDB?.executeStatements(familyMemberDetails)
                                    if (result == nil)
                                    {
                                        //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                    }
                                    else
                                    {
                                        
                                    }
                                    /*
                                     let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
                                     
                                     
                                     let result = contactDB?.executeStatements(addressDetailUpdate)
                                     if (result == nil)
                                     {
                                     //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                     }
                                     else
                                     {
                                     
                                     }
                                     */
                                }
                                
                            }
                        }
                    }
                    
                    contactDB?.close()
                }
            }
        }
    }
    ////
    func functionForGetNewUpdateDeleteMember()
    {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        //1.New members
        let MyFilesPath = documentsPath.appendingPathComponent("/NewMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath)
            let count = fileList.count
            varGetTotalFilesCount=count
            //print(fileList)
            //print(count)
            for i in 0 ..< count
            {
                // //print(fileList[i])
                if(fileList[i].hasPrefix("New"))
                {
                    
                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath+"/"+fileList[i]))
                    do
                    {
                        let NewMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                        // if(fileList[i]=="New7.json")
                        //{
                        //print(fileList[i])
                        ////print(NewMemberListjsonResult)
                        
                        varGetForLoopCounting=i+1
                        
                        /*------------§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§£££££££££££££££££££££££££££------------------------*/
                        let zipPath:String =  MyFilesPath+"/"+fileList[i]
                        
                        let fileManager = FileManager.default
                        try fileManager.removeItem(atPath: zipPath)
                        
                        
                        
                        self.functionForAddNewMembers(NewMemberListjsonResult)
                        
                        
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        catch
        {
        }
        //2.Update members
        let MyFilesPath2 = documentsPath.appendingPathComponent("/UpdatedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath2)
            let count = fileList.count
            ////print(fileList)
            //print(count)
            for i in 0 ..< count
            {
                // //print(fileList[i])
                if(fileList[i].hasPrefix("Update"))
                {
                    
                    let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: MyFilesPath2+"/"+fileList[i]))
                    do
                    {
                        //print(MyFilesPath2+"/"+fileList[i])
                        let UpdateMemberListjsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
                        
                        
                        // //print(UpdateMemberListjsonResult)
                        
                        // if(fileList[i]=="New7.json")
                        //{
                        ////print("This is file name:----")
                        //print(fileList[i])
                        ////print(UpdateMemberListjsonResult)
                        self.functionForUpdateMembers(UpdateMemberListjsonResult)
                        
                        
                        let zipPath:String =  MyFilesPath2+"/"+fileList[i]
                        
                        //   //print(zipPath)
                        // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                        //  {
                        let fileManager = FileManager.default
                        try fileManager.removeItem(atPath: zipPath)
                        
                        
                        
                        //}
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        catch
        {
        }
        //3.Delete members
        let MyFilesPath3 = documentsPath.appendingPathComponent("/DeletedMembers")
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: MyFilesPath3)
            let count = fileList.count
            ////print(fileList)
            // //print(count)
            for i in 0 ..< count
            {
                //  //print(fileList[i])
                if(fileList[i].hasPrefix("Delete"))
                {
                    let letGetDeletedID = try NSString(contentsOf:URL(fileURLWithPath: (MyFilesPath3+"/"+fileList[i])), encoding: String.Encoding.utf8.rawValue)
                    // //print(letGetDeletedID)
                    let letGetId=letGetDeletedID.components(separatedBy: ",")
                    self.functionForDeleteMembers(letGetId)
                    let zipPath:String =  MyFilesPath3+"/"+fileList[i]
                    
                    //   //print(zipPath)
                    // if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
                    //  {
                    let fileManager = FileManager.default
                    try fileManager.removeItem(atPath: zipPath)
                    
                    
                    
                }
            }
        }
        catch
        {
        }
        
        // fetchData()
    }
    
    ///
    func functionForAddNewMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
        // //print(dictNewMemberListjsonResult)
        if  let moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as? String
        {
            if  let GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as? String
            {
                
                var databasePath : String
                let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documents.appendingPathComponent("NewTouchbase.db")
                // open database
                databasePath = fileURL.path
                var db: OpaquePointer? = nil
                if sqlite3_open(fileURL.path, &db) != SQLITE_OK
                {
                    //print("error opening database")
                }
                else
                {
                    // self.Createtablecity()
                }
                let contactDB = FMDatabase(path: databasePath as String)
                if contactDB == nil
                {
                    //print("Error: \(contactDB?.lastErrorMessage())")
                }
                let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                if (contactDB?.open())!
                {
                    contactDB?.beginTransaction()
                    //  //print("44This is count of main start point of file:-----------")
                    ////print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.count)
                    for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
                    {
                        // let  dict = arrdata[i] as! NSDictionary
                        let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                        let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                        let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                        let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                        let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                        var memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                        let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                        let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                        let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                        let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                        let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                        
                        let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                        let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                        let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                        ////print("Profile Master",i)
                        
                        var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        
                        
                        memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                        
                        
                        //print(dictNewMemberListjsonResult)
                        //print(dictMain)
                        //print(profilePic)
                        //print(familyPic)
                        
                        
                        let insertSQL = "INSERT INTO ProfileMaster (masterId,grpId,profileId,isAdmin,memberName,memberEmail,memberMobile,memberCountry,profilePic,familyPic,isPersonalDetVisible,isBussinessDetVisible,isFamilyDetVisible) VALUES('"+masterID+"','"+grpID+"','"+profileID+"','"+isAdmin+"','"+memberNames+"','"+memberEmail+"','"+memberMobile+"','"+memberCountry+"','"+profilePic+"','"+familyPic+"','"+isPersonalDetVisible+"','"+isBusinDetVisible+"','"+isFamilDetailVisible+"')"
                        ////print(insertSQL)
                        let result = contactDB?.executeStatements(insertSQL)
                        if (result == nil)
                        {
                            //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                        }
                        else
                        {
                            // //print("success saved");//print(databasePath);
                            //1......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                            //  //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count)
                            
                            
                            
                            var dictTemporaryDictionary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                            
                            
                            
                            for j in 0 ..< (dictTemporaryDictionary.object(forKey: "personalMemberDetails")! as AnyObject).count
                            {
                                
                                
                                var dizxcctTemxczxporaryDictizxconary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                                
                                
                                let dictChild=(dizxcctTemxczxporaryDictizxconary.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                                let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                var value=(dictChild as AnyObject).object(forKey: "value")as! String
                                let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                
                                ////print("PersonalBusinessMemberDetails Personal",j)
                                value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                                
                                
                                //print(dictChild)
                                //print(dictChild)
                                //print(dictChild)
                                let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                                //   //print(childSQLl)
                                let result = contactDB?.executeStatements(childSQLl)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                else
                                {
                                    
                                }
                            }
                            //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                            // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!./count)
                            
                            
                            var dictTemporaryDictionarygffdfgfddxvsd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                            
                            
                            for j in 0 ..< (dictTemporaryDictionarygffdfgfddxvsd.object(forKey: "businessMemberDetails")! as AnyObject).count
                            {
                                let dictChild=(dictTemporaryDictionarygffdfgfddxvsd.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                                let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                                let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                                let key=(dictChild as AnyObject).object(forKey: "key")as! String
                                let value=(dictChild as AnyObject).object(forKey: "value")as! String
                                let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                                let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                                let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                                
                                let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                                // //print(childSQLNewww)
                                
                                ////print("PersonalBusinessMemberDetails Business",j)
                                
                                
                                let result = contactDB?.executeStatements(childSQLNewww)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                else
                                {
                                    
                                }
                            }
                            //3. PersonalBusinessMemberDetails
                            // //print(dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("familyMemberDetails")!.count)
                            // for k in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(0).objectForKey("familyMemberDetails")!.count
                            
                            var dictTemporaryDictionarytwo:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                            
                            
                            
                            for k in 0 ..< ((dictTemporaryDictionarytwo.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "familyMemberDetail")! as AnyObject).count
                            {
                                
                                var dictTemporaryDictionarydcvsdcsadsadasd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                                
                                let isVisible=(dictTemporaryDictionarydcvsdcsadsadasd.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                                let dictChild=(dictTemporaryDictionarydcvsdcsadsadasd.object(forKey: "familyMemberDetails")! as AnyObject).object(at: k)
                                
                                let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                                let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                                let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                                let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                                let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                                let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                                let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                                let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                                let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                                
                                
                                let familyMemberDetails = "INSERT INTO FamilyMemberDetail (profileId,isVisible,familyMemberId,memberName,relationship,dob,emailID,anniversary,contactNo,particulars,bloodGroup,masterId) VALUES("+profileID+",'"+isVisible+"','"+familyMemberId+"','"+memberName+"','"+relationship+"','"+dob+"','"+emailID+"','"+anniversary+"','"+contactNo+"','"+particulars+"','"+bloodGroup+"','"+masterID+"')"
                                
                                let result = contactDB?.executeStatements(familyMemberDetails)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                else
                                {
                                    
                                }
                            }
                            //4.  AddressDetails
                            
                            
                            var dictTemporaryDictionarydfsdfsdfsdf:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                            
                            
                            
                            
                            
                            
                            let dictChild=(dictTemporaryDictionarydfsdfsdfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
                            
                            for l in 0 ..< ((dictTemporaryDictionarydfsdfsdfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                            {
                                let isBusinessAddrVisible=(dictTemporaryDictionarydfsdfsdfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                                let isResidanceAddrVisible=(dictTemporaryDictionarydfsdfsdfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                                
                                let dictChild=((dictTemporaryDictionarydfsdfsdfsdf.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                                
                                let address=(dictChild as AnyObject).object(forKey: "address")as! String
                                let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                                let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                                let city=(dictChild as AnyObject).object(forKey: "city")as! String
                                let country=(dictChild as AnyObject).object(forKey: "country")as! String
                                let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                                let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                                let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                                ////print(pincode)
                                let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                                
                                let state=(dictChild as AnyObject).object(forKey: "state")as! String
                                // //print(state)
                                
                                //print("this is country from rajendra side 33333")
                                //print(country)
                                
                                
                                
                                let familyMemberDetails = "INSERT INTO AddressDetails (profileId,AddressprofileId,addressID,addressType,address,city,state,country,pincode,phoneNo,fax,isBusinessAddrVisible,isResidanceAddrVisible,masterId) VALUES("+profileID+",'"+AddressprofileId+"','"+addressID+"','"+addressType+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+phoneNo+"','"+fax+"','"+isBusinessAddrVisible+"','"+isResidanceAddrVisible+"','"+masterID+"')"
                                
                                //  //print(familyMemberDetails)
                                ////print("AddressDetails",l)
                                
                                let result = contactDB?.executeStatements(familyMemberDetails)
                                if (result == nil)
                                {
                                    //print("ErrorAi: \(contactDB?.lastErrorMessage())")
                                }
                                else
                                {
                                    
                                }
                            }
                        }
                    }
                }
                contactDB?.commit()
                contactDB?.close()
                
            }
        }
        //   var varGetCountTotalFiles:Int!=varGetTotalFilesCount
        
        
        //  //print(varGetForLoopCounting)
        //  //print(varGetTotalFilesCount)
        if(varGetForLoopCounting==varGetTotalFilesCount)
        {
            // //print("∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞")
            // //print(varGetForLoopCounting)
            // //print(varGetTotalFilesCount)
            // fetchData()
            
        }
        
    }
    /////
    func functionForUpdateMembers(_ dictNewMemberListjsonResult:NSDictionary)
    {
        
        var moduleID = UserDefaults.standard.value(forKey: "session_GetModuleId")as! String
        var GroupID = UserDefaults.standard.value(forKey: "session_GetGroupId")as! String
        
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            //print("error opening database")
        }
        else
        {
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil
        {
            //print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())!
        {
            contactDB?.beginTransaction()
            //print("11This is count of main start point of file:-----------")
            //print((dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count)
            for i in 0 ..< (dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).count
            {
                
                let dictMain=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                let masterID=(dictMain as AnyObject).object(forKey: "masterID")as! String
                let grpID=(dictMain as AnyObject).object(forKey: "grpID")as! String
                let profileID=(dictMain as AnyObject).object(forKey: "profileID")as! String
                let isAdmin=(dictMain as AnyObject).object(forKey: "isAdmin")as! String
                let memberName=(dictMain as AnyObject).object(forKey: "memberName")as! String
                let memberEmail=(dictMain as AnyObject).object(forKey: "memberEmail")as! String
                let memberMobile=(dictMain as AnyObject).object(forKey: "memberMobile")as! String
                let memberCountry=(dictMain as AnyObject).object(forKey: "memberCountry")as! String
                let profilePic=(dictMain as AnyObject).object(forKey: "profilePic")as! String
                let familyPic=(dictMain as AnyObject).object(forKey: "familyPic")as! String
                
                
                let isPersonalDetVisible=(dictMain as AnyObject).object(forKey: "isPersonalDetVisible")as! String
                let isBusinDetVisible=(dictMain as AnyObject).object(forKey: "isBusinDetVisible")as! String
                let isFamilDetailVisible=(dictMain as AnyObject).object(forKey: "isFamilDetailVisible")as! String
                
                
                
                
                var memberNames = memberName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                memberNames=(memberNames as NSString).replacingOccurrences(of: "'", with: "`")
                //print(dictMain)
                //print(profilePic)
                //print(familyPic)
                
                let insertSQLUpdate = "UPDATE ProfileMaster SET grpId='"+grpID+"' ,isAdmin='"+isAdmin+"',memberName='"+memberNames+"',memberEmail='"+memberEmail+"',memberMobile='"+memberMobile+"',memberCountry='"+memberCountry+"',profilePic='"+profilePic+"',familyPic='"+familyPic+"',isPersonalDetVisible='"+isPersonalDetVisible+"',isBussinessDetVisible='"+isBusinDetVisible+"',isFamilyDetVisible='"+isFamilDetailVisible+"' where masterId="+masterID+" and profileId='"+profileID+"'"
                //print("user image !")
                //print(insertSQLUpdate)
                
                let result = contactDB?.executeStatements(insertSQLUpdate)
                /*
                 for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.count
                 {
                 let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("personalMemberDetails")!.objectAtIndex(j)
                 let fieldID=dictChild.objectForKey("fieldID")as! String
                 let uniquekey=dictChild.objectForKey("uniquekey")as! String
                 let key=dictChild.objectForKey("key")as! String
                 let value=dictChild.objectForKey("value")as! String
                 let colType=dictChild.objectForKey("colType")as! String
                 let isEditable=dictChild.objectForKey("isEditable")as! String
                 let isVisible=dictChild.objectForKey("isVisible")as! String
                 let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='personal',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                 let result = contactDB?.executeStatements(childSQLUpdate)
                 }
                 */
                
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                var dictTempocvxcvraryDictixcvxzonary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                for j in 0 ..< (dictTempocvxcvraryDictixcvxzonary.object(forKey: "personalMemberDetails")! as AnyObject).count
                {
                    let dictChild=(dictTempocvxcvraryDictixcvxzonary.object(forKey: "personalMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    var value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    value=(value as NSString).replacingOccurrences(of: "'", with: "`")
                    
                    /*
                     let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"'and groupId='"+GroupID+"'"
                     let result = contactDB?.executeStatements(insertSQLDelete)
                     */
                    
                    
                    
                    
                    
                    let childSQLl = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','personal','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLl)
                    
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                var dictTemporaryDictionarydasdasdasd:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                for j in 0 ..< (dictTemporaryDictionarydasdasdasd.object(forKey: "businessMemberDetails")! as AnyObject).count
                {
                    let dictChild=(dictTemporaryDictionarydasdasdasd.object(forKey: "businessMemberDetails")! as AnyObject).object(at: j)
                    let fieldID=(dictChild as AnyObject).object(forKey: "fieldID")as! String
                    let uniquekey=(dictChild as AnyObject).object(forKey: "uniquekey")as! String
                    let key=(dictChild as AnyObject).object(forKey: "key")as! String
                    let value=(dictChild as AnyObject).object(forKey: "value")as! String
                    let colType=(dictChild as AnyObject).object(forKey: "colType")as! String
                    let isEditable=(dictChild as AnyObject).object(forKey: "isEditable")as! String
                    let isVisible=(dictChild as AnyObject).object(forKey: "isVisible")as! String
                    
                    /*
                     let insertSQLDelete = "DELETE FROM  PersonalBusinessMemberDetails  where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                     let result = contactDB?.executeStatements(insertSQLDelete)
                     */
                    
                    
                    
                    let childSQLNewww = "INSERT INTO PersonalBusinessMemberDetails (profileId,fieldId,uniquekey,key,value,colType,isEditable,isVisible,PersonalORBusiness,masterId,moduleID,groupId) VALUES("+profileID+",'"+fieldID+"','"+uniquekey+"','"+key+"','"+value+"','"+colType+"','"+isEditable+"','"+isVisible+"','Business','"+masterID+"','"+moduleID+"','"+GroupID+"')"
                    let resultT = contactDB?.executeStatements(childSQLNewww)
                    
                }
                /*££££££££££££££££££££££££‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹*/
                
                
                
                
                
                
                //2......if master table entry inserted then need to data in PersonalBusinessMemberDetails
                /*
                 for j in 0 ..< dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.count
                 {
                 
                 let dictChild=dictNewMemberListjsonResult.objectForKey("MemberDetail")!.objectAtIndex(i).objectForKey("businessMemberDetails")!.objectAtIndex(j)
                 let fieldID=dictChild.objectForKey("fieldID")as! String
                 let uniquekey=dictChild.objectForKey("uniquekey")as! String
                 let key=dictChild.objectForKey("key")as! String
                 let value=dictChild.objectForKey("value")as! String
                 let colType=dictChild.objectForKey("colType")as! String
                 let isEditable=dictChild.objectForKey("isEditable")as! String
                 let isVisible=dictChild.objectForKey("isVisible")as! String
                 
                 
                 let childSQLUpdate = "UPDATE PersonalBusinessMemberDetails SET key='"+key+"',value='"+value+"',colType='"+colType+"',isEditable='"+isEditable+"',isVisible='"+isVisible+"',PersonalORBusiness='Business',masterId='"+masterID+"' where fieldID='"+fieldID+"' and uniquekey='"+uniquekey+"' and profileId='"+profileID+"' and moduleID='"+moduleID+"' and groupId='"+GroupID+"'"
                 
                 let result = contactDB?.executeStatements(childSQLUpdate)
                 
                 }
                 */
                //3. PersonalBusinessMemberDetails
                
                
                var dictTemporaryasdDictionaryfghjghjdghj:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                for k in 0 ..< (dictTemporaryasdDictionaryfghjghjdghj.object(forKey: "familyMemberDetail")! as AnyObject).count
                {
                    
                    let isVisible=(dictTemporaryasdDictionaryfghjghjdghj.object(forKey: "familyMemberDetails")! as AnyObject).object(forKey: "isVisible")as! String
                    let dictChild=(dictTemporaryasdDictionaryfghjghjdghj.object(forKey: "familyMemberDetails")! as AnyObject).object(at: k)
                    
                    let familyMemberId=(dictChild as AnyObject).object(forKey: "familyMemberId")as! String
                    let memberName=(dictChild as AnyObject).object(forKey: "memberName")as! String
                    let relationship=(dictChild as AnyObject).object(forKey: "relationship")as! String
                    let dob=(dictChild as AnyObject).object(forKey: "dOB")as! String
                    let emailID=(dictChild as AnyObject).object(forKey: "emailID")as! String
                    let anniversary=(dictChild as AnyObject).object(forKey: "anniversary")as! String
                    let contactNo=(dictChild as AnyObject).object(forKey: "contactNo")as! String
                    let particulars=(dictChild as AnyObject).object(forKey: "particulars")as! String
                    let bloodGroup=(dictChild as AnyObject).object(forKey: "bloodGroup")as! String
                    
                    let familyMemberDetailsUpdate = "UPDATE FamilyMemberDetail  SET isVisible='"+isVisible+"',memberName='"+memberName+"',relationship='"+relationship+"',dob='"+dob+"',emailID='"+emailID+"',anniversary='"+anniversary+"',contactNo='"+contactNo+"',particulars='"+particulars+"',bloodGroup='"+bloodGroup+"',masterId='"+masterID+"' WHERE familyMemberId='"+familyMemberId+"' and profileId='"+profileID+"'"
                    
                    let result = contactDB?.executeStatements(familyMemberDetailsUpdate)
                    
                }
                
                //4.  AddressDetails
                
                
                
                
                
                var dictTemporaryDictionary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                let dictChild=(dictTemporaryDictionary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")
                
                
                var dictTemzxcporaryDictizxconary:NSDictionary=(dictNewMemberListjsonResult.object(forKey: "MemberDetail")! as AnyObject).object(at: i)
                
                
                for l in 0 ..< ((dictTemzxcporaryDictizxconary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).count
                {
                    
                    let isBusinessAddrVisible=(dictTemzxcporaryDictizxconary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isBusinessAddrVisible")as! String
                    let isResidanceAddrVisible=(dictTemzxcporaryDictizxconary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "isResidanceAddrVisible")as! String
                    
                    let dictChild=((dictTemzxcporaryDictizxconary.object(forKey: "addressDetails")! as AnyObject).object(forKey: "addressResult")! as AnyObject).object(at: l)
                    
                    let address=(dictChild as AnyObject).object(forKey: "address")as! String
                    let addressID=(dictChild as AnyObject).object(forKey: "addressID")as! String
                    let addressType=(dictChild as AnyObject).object(forKey: "addressType")as! String
                    let city=(dictChild as AnyObject).object(forKey: "city")as! String
                    let country=(dictChild as AnyObject).object(forKey: "country")as! String
                    let fax=(dictChild as AnyObject).object(forKey: "fax")as! String
                    let phoneNo=(dictChild as AnyObject).object(forKey: "phoneNo")as! String
                    let pincode=(dictChild as AnyObject).object(forKey: "pincode")as! String
                    let AddressprofileId=(dictChild as AnyObject).object(forKey: "profileID")as! String
                    let state=(dictChild as AnyObject).object(forKey: "state")as! String
                    
                    
                    //print("this is country from rajendra side 55555")
                    //print(country)
                    
                    let addressDetailUpdate = "UPDATE AddressDetails  SET AddressprofileId='"+AddressprofileId+"',addressType='"+addressType+"',address='"+address+"',city='"+city+"',state='"+state+"',country='"+country+"',pincode='"+pincode+"',phoneNo='"+phoneNo+"',fax='"+fax+"',isBusinessAddrVisible='"+isBusinessAddrVisible+"',isResidanceAddrVisible='"+isResidanceAddrVisible+"',masterId='"+masterID+"' WHERE addressID='"+addressID+"' and profileId='"+profileID+"'"
                    
                    let result = contactDB?.executeStatements(addressDetailUpdate)
                    
                }
                
                
                
            }
            
        }
        contactDB?.commit()
        contactDB?.close()
    }
    /*
     //print(memberName)
     //print(relationship)
     //print(contactNo)
     //print(emailID)
     //print(bloodGroup)
     //print(dob)
     //print(anniversary)
     */
    
    func convertDateToWords(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let month = monthFormatter.string(from: date)
            
            return "\(day) \(month)"
        } else {
            return nil // Handle invalid date format
        }
    }
    
    func convertMonthToWords(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let month = monthFormatter.string(from: date)
            
            return "\(day) \(month)"
        } else {
            return nil // Handle invalid date format
        }
    }
    
    func convertDateToMonth(dateString: String) -> String? {
        
        // Formatter for the original date format
        let originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        // Parse the original date string
        if let originalDate = originalFormatter.date(from: dateString) {
            // Formatter for the desired output format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            
            // Convert the date to the desired output format
            let formattedDate = outputFormatter.string(from: originalDate)
            
            print(formattedDate) // Output: "01/01/1753"
            return "\(formattedDate)"
        } else {
            print("Failed to parse the date string")
            return nil
        }
    }
    
    func convertMonthToDate(dateString: String) -> String? {
        
        // Formatter for the original date format
        let originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "yyyy-MM-dd"
        
        // Parse the original date string
        if let originalDate = originalFormatter.date(from: dateString) {
            // Formatter for the desired output format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            
            // Convert the date to the desired output format
            let formattedDate = outputFormatter.string(from: originalDate)
            
            print(formattedDate) // Output: "01/01/1753"
            return "\(formattedDate)"
        } else {
            print("Failed to parse the date string")
            return nil
        }
    }
}

// MARK: - FamilyDetail
struct FamilyDetailes: Codable {
    let tbGetRotarianResult: TBGetRotarianResultes?
    
    enum CodingKeys: String, CodingKey {
        case tbGetRotarianResult = "TBGetRotarianResult"
    }
}

// MARK: - TBGetRotarianResult
struct TBGetRotarianResultes: Codable {
    let status, message: String?
    let result: Resulteses?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case result = "Result"
    }
}

// MARK: - Result
struct Resulteses: Codable {
    let masterUID, profileID, memberName, memberMobile: String?
    let designation, resultClubName, clubDesignation, districtDesignation: String?
    let pic: String?
    let email, businessName, businessAddress, city: String?
    let state, country, pincode, phoneNo: String?
    let fax, classification, secondaryMobile, memberEmail: String?
    let keywords, bloodGroup, donorRecognition, clubName: String?
    let rotaryid, memberDateOfBirth, memberDateOfWedding, memberInfo: String?
    let faceBookTxt, instagramTxt, twitterTxt, linkedInTxt: String?
    let websiteTxt, youtubeTxt: String?
    let familylistOutput: [FamilylistOutput]?
    
    enum CodingKeys: String, CodingKey {
        case masterUID, profileID, memberName, memberMobile, designation
        case resultClubName = "clubName"
        case clubDesignation, districtDesignation, pic
        case email = "Email"
        case businessName = "BusinessName"
        case businessAddress = "BusinessAddress"
        case city, state, country, pincode, phoneNo
        case fax = "Fax"
        case classification = "Classification"
        case secondaryMobile = "SecondaryMobile"
        case memberEmail
        case keywords = "Keywords"
        case bloodGroup = "blood_Group"
        case donorRecognition = "Donor_Recognition"
        case clubName = "Club_Name"
        case rotaryid
        case memberDateOfBirth = "member_date_of_birth"
        case memberDateOfWedding = "member_date_of_wedding"
        case memberInfo = "member_info"
        case faceBookTxt = "FaceBook_Txt"
        case instagramTxt = "Instagram_Txt"
        case twitterTxt = "Twitter_Txt"
        case linkedInTxt = "LinkedIn_Txt"
        case websiteTxt = "Website_Txt"
        case youtubeTxt = "Youtube_Txt"
        case familylistOutput
    }
}

// MARK: - FamilylistOutput
struct FamilylistOutput: Codable {
    let relation, relativeName, mob, emailID: String?
    let birth, anniversary: String?
    
    enum CodingKeys: String, CodingKey {
        case relation = "Relation"
        case relativeName = "RelativeName"
        case mob = "Mob"
        case emailID = "EmailId"
        case birth = "Birth"
        case anniversary = "Anniversary"
    }
}

// MARK: - ClassificationDetail
struct ClassificationDetail: Codable {
    let memberListDetailResult: MemberListDetailResultssss?
    
    enum CodingKeys: String, CodingKey {
        case memberListDetailResult = "MemberListDetailResult"
    }
}

// MARK: - MemberListDetailResult
struct MemberListDetailResultssss: Codable {
    let status, message: String?
    let memberDetails: MemberDetailsesss?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case memberDetails = "MemberDetails"
    }
}

// MARK: - MemberDetails
struct MemberDetailsesss: Codable {
    let masterID, grpID, profileID, isAdmin: String?
    let memberName, memberEmail, memberMobile, memberCountry: String?
    let profilePic, familyPic: String?
    let gender, youthFlag, memberSuffix, memberPrefix: String?
    let primaryLanguage: String?
    let memberInfo: String?
    let faceBookTxt: String?
    let instagramTxt, twitterTxt, linkedInTxt, websiteTxt: String?
    let youtubeTxt, isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible: String?
    let secondaryMobile, businessName, businessPhoneNo, businessAdress: String?
    let businessDesignation, classification, keywords, rotaryid: String?
    let clubDesignation, memberDateOfBirth, memberDateOfWedding, bloodGroup: String?
    let donorRecognition, clubName: String?
    let personalMemberDetails, businessMemberDetails: [MemberDetaileee]?
    let familyMemberDetails: FamilyMemberDetailsesss?
    let addressDetails: AddressDetailsesss?
    
    enum CodingKeys: String, CodingKey {
        case masterID, grpID, profileID, isAdmin, memberName, memberEmail, memberMobile, memberCountry, profilePic, familyPic
        case gender = "Gender"
        case youthFlag = "Youth_Flag"
        case memberSuffix = "Member_Suffix"
        case memberPrefix = "Member_Prefix"
        case primaryLanguage = "PrimaryLanguage"
        case memberInfo = "member_info"
        case faceBookTxt = "FaceBook_Txt"
        case instagramTxt = "Instagram_Txt"
        case twitterTxt = "Twitter_Txt"
        case linkedInTxt = "LinkedIn_Txt"
        case websiteTxt = "Website_Txt"
        case youtubeTxt = "Youtube_Txt"
        case isPersonalDetVisible, isBusinDetVisible, isFamilDetailVisible
        case secondaryMobile = "SecondaryMobile"
        case businessName = "BusinessName"
        case businessPhoneNo = "Business_Phone_no"
        case businessAdress = "Business_Adress"
        case businessDesignation = "Business_Designation"
        case classification = "Classification"
        case keywords = "Keywords"
        case rotaryid, clubDesignation
        case memberDateOfBirth = "member_date_of_birth"
        case memberDateOfWedding = "member_date_of_wedding"
        case bloodGroup = "blood_Group"
        case donorRecognition = "Donor_Recognition"
        case clubName = "Club_Name"
        case personalMemberDetails, businessMemberDetails, familyMemberDetails, addressDetails
    }
}

// MARK: - AddressDetails
struct AddressDetailsesss: Codable {
    let isResidanceAddrVisible: String?
    let isBusinessAddrVisible: String?
    let addressResult: [AddressResultesss]?
}

// MARK: - AddressResult
struct AddressResultesss: Codable {
    let addressID, addressType, address, city: String?
    let state, country, pincode, phoneNo: String?
    let fax, profileID: String?
}

enum IsVisiblesss: String, Codable {
    case y = "y"
}

// MARK: - MemberDetail
struct MemberDetaileee: Codable {
    let fieldID, uniquekey, key, value: String?
    let colType, isEditable: String?
    let isVisiblesss: String?
}

// MARK: - FamilyMemberDetails
struct FamilyMemberDetailsesss: Codable {
    let isVisiblesss: String?
    let familyMemberDetail: [JSONAny]?
}


//// MARK: - ClubProfile
//struct ClubProfile: Codable {
//    let tbGetRotarianResult: TBGetRotarianResultus?
//
//    enum CodingKeys: String, CodingKey {
//        case tbGetRotarianResult = "TBGetRotarianResult"
//    }
//}
//
//// MARK: - TBGetRotarianResult
//struct TBGetRotarianResultus: Codable {
//    let status, message: String?
//    let result: Resultz?
//
//    enum CodingKeys: String, CodingKey {
//        case status, message
//        case result = "Result"
//    }
//}
//
//// MARK: - Result
//struct Resultz: Codable {
//    let masterUID, profileID, memberName, memberMobile: String?
//    let designation, resultClubName, clubDesignation, districtDesignation: String?
//    let pic: String?
//    let email, businessName, businessAddress, city: String?
//    let state, country, pincode, phoneNo: String?
//    let fax, classification, secondaryMobile, memberEmail: String?
//    let keywords, bloodGroup, donorRecognition, clubName: String?
//    let rotaryid, memberDateOfBirth, memberDateOfWedding, memberInfo: String?
//    let faceBookTxt, instagramTxt, twitterTxt, linkedInTxt: String?
//    let websiteTxt, youtubeTxt: String?
//    let familylistOutput: [FamilylistOutputzs]?
//
//    enum CodingKeys: String, CodingKey {
//        case masterUID, profileID, memberName, memberMobile, designation
//        case resultClubName = "clubName"
//        case clubDesignation, districtDesignation, pic
//        case email = "Email"
//        case businessName = "BusinessName"
//        case businessAddress = "BusinessAddress"
//        case city, state, country, pincode, phoneNo
//        case fax = "Fax"
//        case classification = "Classification"
//        case secondaryMobile = "SecondaryMobile"
//        case memberEmail
//        case keywords = "Keywords"
//        case bloodGroup = "blood_Group"
//        case donorRecognition = "Donor_Recognition"
//        case clubName = "Club_Name"
//        case rotaryid
//        case memberDateOfBirth = "member_date_of_birth"
//        case memberDateOfWedding = "member_date_of_wedding"
//        case memberInfo = "member_info"
//        case faceBookTxt = "FaceBook_Txt"
//        case instagramTxt = "Instagram_Txt"
//        case twitterTxt = "Twitter_Txt"
//        case linkedInTxt = "LinkedIn_Txt"
//        case websiteTxt = "Website_Txt"
//        case youtubeTxt = "Youtube_Txt"
//        case familylistOutput
//    }
//}
//
//// MARK: - FamilylistOutput
//struct FamilylistOutputzs: Codable {
//    let relation, relativeName, mob, emailID: String?
//    let birth, anniversary: String?
//
//    enum CodingKeys: String, CodingKey {
//        case relation = "Relation"
//        case relativeName = "RelativeName"
//        case mob = "Mob"
//        case emailID = "EmailId"
//        case birth = "Birth"
//        case anniversary = "Anniversary"
//    }
//}

// MARK: - MemberDetailV1
struct MemberDetailV1: Codable {
    let tbGetRotarianResult: TBGetRotarianResultV1?

    enum CodingKeys: String, CodingKey {
        case tbGetRotarianResult = "TBGetRotarianResult"
    }
}

// MARK: - TBGetRotarianResult
struct TBGetRotarianResultV1: Codable {
    let status, message: String?
    let result: ResultV1?

    enum CodingKeys: String, CodingKey {
        case status, message
        case result = "Result"
    }
}

// MARK: - Result
struct ResultV1: Codable {
    let masterUID, profileID, memberName, memberMobile: String?
    let designation, resultClubName, clubDesignation, districtDesignation: String?
    let pic, email, businessName: String?
    let businessAddress, city, state, country: String?
    let pincode, phoneNo, fax: String?
    let classification, secondaryMobile, memberEmail, keywords: String?
    let bloodGroup, donorRecognition, clubName, rotaryid: String?
    let memberDateOfBirth, memberDateOfWedding, memberInfo, faceBookTxt: String?
    let instagramTxt, twitterTxt, linkedInTxt, websiteTxt: String?
    let youtubeTxt, familyPic: String?
    let familylistOutput: [FamilylistOutputV1]?
    let address: [AddressV1]?

    enum CodingKeys: String, CodingKey {
        case masterUID, profileID, memberName, memberMobile, designation
        case resultClubName = "clubName"
        case clubDesignation, districtDesignation, pic
        case email = "Email"
        case businessName = "BusinessName"
        case businessAddress = "BusinessAddress"
        case city, state, country, pincode, phoneNo
        case fax = "Fax"
        case classification = "Classification"
        case secondaryMobile = "SecondaryMobile"
        case memberEmail
        case keywords = "Keywords"
        case bloodGroup = "blood_Group"
        case donorRecognition = "Donor_Recognition"
        case clubName = "Club_Name"
        case rotaryid
        case memberDateOfBirth = "member_date_of_birth"
        case memberDateOfWedding = "member_date_of_wedding"
        case memberInfo = "member_info"
        case faceBookTxt = "FaceBook_Txt"
        case instagramTxt = "Instagram_Txt"
        case twitterTxt = "Twitter_Txt"
        case linkedInTxt = "LinkedIn_Txt"
        case websiteTxt = "Website_Txt"
        case youtubeTxt = "Youtube_Txt"
        case familyPic, familylistOutput, address
    }
}

// MARK: - Address
struct AddressV1: Codable {
    let addressType, address, city, state: String?
    let country, pincode, phoneNo, fax: String?

    enum CodingKeys: String, CodingKey {
        case addressType = "Address_Type"
        case address = "Address"
        case city, state, country, pincode, phoneNo
        case fax = "Fax"
    }
}

// MARK: - FamilylistOutput
struct FamilylistOutputV1: Codable {
    let relation, relativeName, mob, emailID: String?
    let birth, anniversary, bloodGroup: String?

    enum CodingKeys: String, CodingKey {
        case relation = "Relation"
        case relativeName = "RelativeName"
        case mob = "Mob"
        case emailID = "EmailId"
        case birth = "Birth"
        case anniversary = "Anniversary"
        case bloodGroup
    }
}
