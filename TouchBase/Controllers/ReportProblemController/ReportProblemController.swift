//
//  ReportProblemController.swift
//  TouchBase
//
//  Created by Kaizan on 03/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class ReportProblemController: UIViewController,UITextFieldDelegate  ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate{
    
    var appDelegate = AppDelegate()

    @IBOutlet var ReportTitleField: UITextField!
    @IBOutlet var ReportDescriptionView: UITextView!
    @IBOutlet var attachmentImageView: UIImageView!
    
    var choosenImage = UIImage()
    let bounds = UIScreen.main.bounds
    var imagePicker = UIImagePickerController()
    let screenSize: CGRect = UIScreen.main.bounds
    
    var imageCondition = Bool()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        imageCondition = false
        
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(ReportProblemController.OpenGallary))
        singleTap.numberOfTapsRequired = 1
        attachmentImageView.isUserInteractionEnabled = true
        attachmentImageView.addGestureRecognizer(singleTap)
        
        self.createNavigationBar()
        
        
        
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Report Problem"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ReportProblemController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
    }
    
    
    @IBAction func SubmitReportAction(_ sender: AnyObject)
    {
    }
    
    
    @objc func OpenGallary()
    {
        if imageCondition == false
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
            actionSheet.tag = 1
            actionSheet.show(in: self.view)
        }
        else
        {
            let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Remove photo","Change photo")
            actionSheet.tag = 0
            actionSheet.show(in: self.view)
        }
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
                
            
                choosenImage = UIImage()
                
              //  let wsm : WebserviceClass = WebserviceClass.sharedInstance
              //  wsm.delegates=self
              //  wsm.DeletePhotoEdit(userProfileID as String, grpID: userGroupID as String, type: "Group")
                
            case 2:
                
                let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Photo Library", "Take a photo")
                actionSheet.tag = 1
                actionSheet.show(in: self.view)
                
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
                
                //   /*
                //shows the photo library
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.imagePicker.delegate = self
                
                if #available(iOS 8.0, *) {
                    self.imagePicker.modalPresentationStyle = .popover
                } else {
                    // Fallback on earlier versions
                }
                
                self.present(self.imagePicker, animated: true, completion: nil)
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

    
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any])
    {
        
        attachmentImageView.translatesAutoresizingMaskIntoConstraints = true
        attachmentImageView.layer.masksToBounds = true
        attachmentImageView.clipsToBounds = true;
        
        //var chosenImage:UIImage! //2
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            choosenImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            choosenImage = possibleImage
        }
        attachmentImageView.image = choosenImage
        imageCondition = true
        dismiss(animated: true, completion:nil);
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

