//
//  CreateProfileController.swift
//  TouchBase
//
//  Created by Kaizan on 15/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
import QuartzCore
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


class CreateProfileController: UIViewController , UITableViewDataSource,UITableViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate , webServiceDelegate , uploadDocDelegate {
    
    let bounds = UIScreen.main.bounds
    var chosenImage : UIImage?
    var imagePicker = UIImagePickerController()
    
    var memberDetail :  MemberDetail = MemberDetail()
    var imageCondition = Bool()
    var appDelegate : AppDelegate = AppDelegate()
    
    var detailArray = NSArray()
    
    var array : NSMutableArray = NSMutableArray()
    var imgID:NSString!
    @IBOutlet var createProfileTableView: UITableView!
    var window: UIWindow?
    let screenSize: CGRect = UIScreen.main.bounds
    
    var cellDataArray:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        //  let str = "1"
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.MemberDetail(mainMemberID!)
        
        imagePicker.delegate = self
        imgID=""
        imageCondition = false
        detailArray=[]
        // chosenImage=UIImage()
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Profile"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CreateProfileController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
/*
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRectMake(0, 0, 60, 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.Right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 14)
        buttonlog.setTitle("SKIP", forState: UIControl.State.Normal)
        buttonlog.addTarget(self, action: #selector(CreateProfileController.skipClicked), forControlEvents: UIControl.Event.TouchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
*/
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func skipClicked()
    {
        
        let defaults1 = UserDefaults.standard
        defaults1.set("1", forKey: "completeReg")
        defaults1.synchronize()
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "rootDashss") as UIViewController, animated: true)
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        
        for i in 0  ..< 3 
        {
            let indexPath = IndexPath(row: i, section: 1)
            let cell : ProfileFieldsCell = cellDataArray.object(at: i) as! ProfileFieldsCell
            
            print(cell.textsField.text)
            
            array.insert(cell.textsField.text!, at: i)
        }
        
        
        print(array.object(at: 0) as! String)
        print(array.object(at: 1) as! String)
        print(array.object(at: 2) as! String)
        if(array.object(at: 0) as! String == ""){/*
            let alert = UIAlertController(title: "", message: "Please enter the Name", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)*/
            
            self.view.makeToast("Please enter the Name", duration: 2, position: CSToastPositionCenter)
            

            
        }else{
        
        let defaults = UserDefaults.standard
        let masterUUID = defaults.string(forKey: "masterUID")
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.UpdateMemberDetail(masterUUID!, memberMobile: array.object(at: 2) as! String, memberName: array.object(at: 0) as! String, memberEmailID: array.object(at: 1) as! String, ProfilePicPath: "", ImageId: imgID as String)
        }
        
        //}
    }
    
    
    //////////////////------- Image Upload Delegate function -----------///////////////////
    
    func getUploadImgSucceeded(_ response: LoadImageResult) {
        
        window = nil
        if response.status == "0"
        {
            // ImgId=response.ImageID;
            
            print(response.imageID)
            imgID=response.imageID as! NSString
            
            //   wsm.UpdateMemberDetail(memberUID!, memberMobile: array.objectAtIndex(2) as! String , memberName: array.objectAtIndex(0) as! String, memberEmailID: array.objectAtIndex(1) as! String, memberProfilePic: "")
            
        }
    }
    
    func showAlert()
    {
        let createAccountAlert: UIAlertView = UIAlertView()
        createAccountAlert.delegate = self
        createAccountAlert.title = "Rotary India"
        createAccountAlert.message = "All fields are mandatory"
        createAccountAlert.addButton(withTitle: "okay")
        createAccountAlert.show()
    }
    
    func UpdateMemDetailDelegateFunction(_ updateUser : UserResult)
    {
        print(updateUser.message);
        
        if updateUser.status == "0"
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "rootDashss") as UIViewController, animated: true) // group_detail  , directory , events
            
            
            let defaults1 = UserDefaults.standard
            defaults1.set("1", forKey: "completeReg")
            defaults1.synchronize()
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode1")
            defaults.set("", forKey: "countryId")
            defaults.set("", forKey: "countryCode")
            defaults.synchronize()
        }
    }
    
    func memberDetailingDelegateFunction(_ memberListDetail : MemberListDetailResult)
    {
        if memberListDetail.status == "0"
        {
            detailArray = memberListDetail.memberDetails as NSArray
            print(detailArray)
            createCEll()
            createProfileTableView.reloadData()
        }
        else
        {
            detailArray=[]
            createProfileTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(detailArray.count>0){
            if(section == 0)
            {
                return 1
            }
            else
            {
                return 3
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0)
        {
            return 225
        }
        else
        {
            return 82
        }
    }
    func createCEll(){
        if detailArray.count > 0 {
            print("There are objects")
            
            memberDetail = detailArray.object(at: 0) as! MemberDetail
        }
        cellDataArray = NSMutableArray()
        
        for index in 0 ..< 3 {
            let cell = createProfileTableView.dequeueReusableCell(withIdentifier: "fieldsCell") as! ProfileFieldsCell
            
            if(index == 0)
            {
                cell.nameLabel.text = "Name"
                cell.textsField.placeholder = "Your First & Last Name"
                cell.textsField.tag = 0
                if detailArray.count > 0
                {
                    cell.textsField.text = memberDetail.memberName
                    
                }
                else
                {
                    
                }
                
            }
            else if(index == 1)
            {
                cell.nameLabel.text = "Email ID"
                cell.textsField.placeholder = "Your Email Address"
                cell.textsField.keyboardType = UIKeyboardType.emailAddress
                cell.textsField.tag = 1
                if detailArray.count > 0
                {
                    cell.textsField.text = memberDetail.memberEmailId
                    
                    
                }
                else
                {
                    
                }
                
            }
            else
            {
                cell.nameLabel.text = "Mobile"
                cell.textsField.placeholder = "Your Mobile Number"
                cell.textsField.tag = 2
                if detailArray.count > 0
                {
                    let defaults = UserDefaults.standard
                    let mobileStr = defaults.value(forKey: "mobileNo") as! String
                    print(mobileStr)
                    cell.textsField.text = mobileStr
                    cell.textsField.isEnabled = false
                    
                }
                
                
            }
            cellDataArray.add(cell)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if detailArray.count > 0 {
            print("There are objects")
            
            memberDetail = detailArray.object(at: 0) as! MemberDetail
        }
        if(indexPath.section == 0)
        {
            let cell = createProfileTableView.dequeueReusableCell(withIdentifier: "dpCell", for: indexPath) as! AddProfPicCell
            cell.addProfilePic.translatesAutoresizingMaskIntoConstraints = true
            cell.addProfilePic.frame=CGRect(x: (bounds.size.width-100)/2,y: 76, width: 100, height: 100)
            cell.addProfilePic.layer.cornerRadius = 50;
            cell.addProfilePic.layer.masksToBounds = true
            cell.addProfilePic.clipsToBounds = true;
            
            cell.indicator.startAnimating()
            if(memberDetail.profilePicPath == ""){
                 cell.addProfilePic.image = UIImage(named: "profile_pic")
                cell.indicator.stopAnimating()
            }
             cell.addProfilePic.image = UIImage(named: "profile_pic")
            if detailArray.count > 0 {
                print("There are objects")
                
                memberDetail = detailArray.object(at: 0) as! MemberDetail
                
                print(memberDetail)
                
                if let checkedUrl = URL(string: memberDetail.profilePicPath) {
                    //Working in swift new version 03-08-2018
                    cell.addProfilePic.sd_setImage(with: checkedUrl)
                    cell.indicator.stopAnimating()
//                    appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                        DispatchQueue.main.async { () -> Void in
//                            guard let data = data, error == nil else { return }
//                            print(response?.suggestedFilename ?? "")
//                            print("Download Finished")
//                            cell.addProfilePic.image = UIImage(data: data)
//                            //  self.chosenImage=UIImage(data: data)!
//                            cell.indicator.stopAnimating()
//                        }
//                    }
                }else{
                    cell.addProfilePic.image = UIImage(named: "profile_pic")
                }
                
                
            } else {
                print("No objects")
                cell.addProfilePic.image = UIImage(named: "profile_pic")
            }
            
            
            cell.editProfilePicButton.addTarget(self, action: #selector(CreateProfileController.OpenGallary), for: .touchUpInside)
            
      //      let singleTap = UITapGestureRecognizer(target: self, action:#selector(CreateProfileController.OpenGallary))
     //       singleTap.numberOfTapsRequired = 1
      //      cell.addProfilePic.userInteractionEnabled = true
     //       cell.addProfilePic.addGestureRecognizer(singleTap)
            
            return cell
        }
        else
        {
            
            return cellDataArray.object(at: indexPath.row) as! UITableViewCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
       
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: -150 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
            {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                
                
                
            }, completion: { finished in
                
        })
        
      
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func OpenGallary()
    {
        
 //       if  memberDetail.profilePicPath == "" //chosenImage.size.width == 0
  //      {
        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
        actionSheet.tag = 1
        actionSheet.show(in: self.view)
 //       }
 //       else
 //       {
            
 //           let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
//            actionSheet.tag = 0
            //actionSheet.delegate = self
//            actionSheet.showInView(self.view)
//        }
        
        
        
        //        let optionMenu = UIAlertController(title: nil, message: "Where would you like the image from?", preferredStyle: UIAlertController.Style.ActionSheet)
        //
        //        let photoLibraryOption = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.Default, handler: { (alert: UIAlertAction!) -> Void in
        //            print("from library")
        //            //shows the photo library
        //            self.imagePicker.allowsEditing = true
        //            self.imagePicker.sourceType = .PhotoLibrary
        //            self.imagePicker.modalPresentationStyle = .Popover
        //            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        //        })
        //        let cameraOption = UIAlertAction(title: "Take a photo", style: UIAlertAction.Style.Default, handler: { (alert: UIAlertAction!) -> Void in
        //            print("take a photo")
        //            //shows the camera
        //            self.imagePicker.allowsEditing = true
        //            self.imagePicker.sourceType = .Camera
        //            self.imagePicker.modalPresentationStyle = .Popover
        //            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        //
        //        })
        //        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.Cancel, handler: {
        //            (alert: UIAlertAction!) -> Void in
        //            print("Cancel")
        //            self.dismissViewControllerAnimated(true, completion: nil)
        //        })
        //
        //        //Adding the actions to the action sheet. Camera will only show up as an option if the camera is available in the first place.
        //        optionMenu.addAction(photoLibraryOption)
        //        optionMenu.addAction(cancelOption)
        //        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
        //            optionMenu.addAction(cameraOption)} else {
        //            print ("I don't have a camera.")
        //        }
        //
        //
        //        self.presentViewController(optionMenu, animated: true, completion: nil)
        //
    }
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        
        
        if actionSheet.tag == 0
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                chosenImage = UIImage()
                let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
                let wsm : WebserviceClass = WebserviceClass.sharedInstance
                wsm.delegates=self
                wsm.DeletePhotoEdit(mainMemberID! as String, grpID: "0", type: "Member",moduleId: "")
                
            case 2:
                
                //shows the photo library
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.modalPresentationStyle = .popover
                self.present(self.imagePicker, animated: true, completion: nil)
                
                
            default:
                print("Default")
            }
        }
        else
        {
            switch (buttonIndex){
                
            case 0:
                print("Cancel")
                
                self.dismiss(animated: true, completion: nil)
                
            case 1:
                
                //shows the photo library
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                if #available(iOS 8.0, *) {
                    self.imagePicker.modalPresentationStyle = .popover
                } else {
                    // Fallback on earlier versions
                }
                self.present(self.imagePicker, animated: true, completion: nil)
                
            case 2:
                
                 openCamera()
                //   /*
                //shows the photo library
//                self.imagePicker = UIImagePickerController()
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
//                self.imagePicker.cameraCaptureMode = .Photo
//                self.imagePicker.modalPresentationStyle = .FullScreen
//                self.imagePicker.delegate = self
//                
//                if #available(iOS 8.0, *) {
//                    self.imagePicker.modalPresentationStyle = .Popover
//                } else {
//                    // Fallback on earlier versions
//                }
//                
//                self.presentViewController(self.imagePicker, animated: true, completion: nil)
                //   */
                
                //           imagePicker =  UIImagePickerController()
                //            imagePicker.delegate = self
                //            imagePicker.sourceType = .Camera
                
                //  presentViewController(imagePicker, animated: true, completion: nil)
                
            default:
                print("Default")
                //Some code here..
                
            }
        }
        
    }
    
    
    func DeletePhotoDelegateFunction(_ dltPhoto : DeleteResult)
    {
        print(dltPhoto.status)
        
        chosenImage = UIImage()
        detailArray=NSMutableArray()
        
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.MemberDetail(mainMemberID!)
        
    }
    
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth
        let newHeight = newWidth
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
    {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createProfileTableView.cellForRow(at: indexPath) as! AddProfPicCell
        cell.addProfilePic.translatesAutoresizingMaskIntoConstraints = true
        cell.addProfilePic.frame=CGRect(x: (bounds.size.width-100)/2,y: 76, width: 100, height: 100)
        cell.addProfilePic.layer.cornerRadius = 50;
        cell.addProfilePic.layer.masksToBounds = true
        cell.addProfilePic.clipsToBounds = true;
        
        var chosenImage:UIImage! //2
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            chosenImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            chosenImage = possibleImage
        }
        cell.addProfilePic.image = resizeImage(chosenImage, newWidth: 100)
        
        imageCondition = true
     //   loaderViewMethod()
        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
        wsm.delegate = self
        
        let imageData: Data = chosenImage!.pngData()!
        wsm.uploadToServer(usingImage: imageData, andFileName: "ProfilePic", moduleName: "Profile")
        dismiss(animated: true, completion: nil) //5
    }
    
//    func loaderViewMethod()
//    {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.backgroundColor = UIColor.clear
//            window.rootViewController = UIViewController()
//            window.makeKeyAndVisible()
//        }
//
//        let Loadingview = UIView()
//        Loadingview.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        Loadingview.backgroundColor = UIColor.clear//.blackColor().colorWithAlphaComponent(0.6)
//
//
//        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")
//
//
//        let gifView = UIImageView()
//        gifView.frame = CGRect(x: (Loadingview.frame.size.width/2)-50, y: (Loadingview.frame.size.height/2)-50, width: 100, height: 100)
//        gifView.image = UIImage.animatedImage(withAnimatedGIFData: try! Data(contentsOf: url!))
//        gifView.backgroundColor = UIColor.clear
//        //                gifView.contentMode = .Center
//        Loadingview.addSubview(gifView)
//        window?.addSubview(Loadingview)
//
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    /*-----------------code by dpk -------------------*/
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }else{
            /*
            let alert = UIAlertController(title: "Camera Not Found", message: "Camera Not Found, this device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
            */
            self.view.makeToast("Camera Not Found, this device has no Camera", duration: 2, position: CSToastPositionCenter)

            
            
        }
    }
    /*-----------------code by dpk -------------------*/

}


