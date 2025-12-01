//
//  ShowCaseDeletePhotoViewController.swift
//  TouchBase
//
//  Created by tt on 09/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
import SDWebImage
class ShowCaseDeletePhotoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var appDelegate : AppDelegate = AppDelegate()
    let loaderClass  = WebserviceClass()
    @IBOutlet weak var collectionViewDelete: UICollectionView!
    
    
    var GetGroupID:String!=""
    var GetAlbumID:String!=""
    var GetUserIdProfileID:String!=""
    var GetAlbumPhotoIds:String!=""
    var Gettitle:String!=""
    var muarrayDeletePhotoArray:NSArray=NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        functionForFetchingAlbumPhotosListData()
        // Do any additional setup after loading the view.
    }

    //MARK:- Navigation bar setting
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = self.Gettitle
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ShowCaseDeletePhotoViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muarrayDeletePhotoArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCaseDeletePhotoCollectionViewCell", for: indexPath) as! ShowCaseDeletePhotoCollectionViewCell
        
        
        if(muarrayDeletePhotoArray.count>0)
        {
            
            let url =  (muarrayDeletePhotoArray.value(forKey: "url") as AnyObject).object(at: indexPath.row) as! String
            if url == ""
            {
                cell.imgView.image = UIImage(named: "logo")
            }
            else
            {
                let ImageProfilePic:String = url.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                cell.imgView.sd_setImage(with: checkedUrl)
            }
            cell.buttonDelete.addTarget(self, action: #selector(ShowCaseDeletePhotoViewController.buttonDeleteClickEvent(_:)), for: UIControl.Event.touchUpInside)
            cell.buttonDelete.tag = indexPath.row
        }

        
        return cell
    }
    
    @objc func buttonDeleteClickEvent(_ sender:UIButton)
    {
        let refreshAlert = UIAlertController(title: "Rotary India", message: "Are you Confirm Delete Photo", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            print(sender.tag)
            self.GetAlbumPhotoIds =  (self.muarrayDeletePhotoArray.value(forKey: "photoId") as AnyObject).object(at: sender.tag) as! String
            self.functionForDeleteAlbum(self.GetAlbumPhotoIds)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    //MARK:- Server api calling
    func functionForFetchingAlbumPhotosListData()
    {
      //  loaderClass.loaderViewMethod()
        let completeURL = baseUrl+"Gallery/GetAlbumPhotoList_New"
        let parameterst = ["groupId":self.GetGroupID,"albumId": self.GetAlbumID]
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
                self.muarrayDeletePhotoArray = arrarrNewGroupList
                if(self.muarrayDeletePhotoArray.count>0)
                {
                   // self.buttonNoResult.hidden=true
                }
                else
                {
                   // self.buttonNoResult.hidden=false
                }
                self.collectionViewDelete.reloadData()
                
                self.loaderClass.window = nil
            }
            else if ((dd.object(forKey: "TBAlbumPhotoListResult")! as AnyObject).object(forKey: "message") as! String == "Record not found")
                
            {
                
                self.loaderClass.window = nil
                
                print("NO Result")
                
                UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
                
                self.navigationController?.popViewController(animated: true)
                
            }
                
            //else
           //
           // {
                
               // self.loaderClass.window = nil
                
           // }
                
                
            else
            {
                self.loaderClass.window = nil
                print("NO Result")
           }
            
            self.loaderClass.window = nil
            SVProgressHUD.dismiss()
            }
        })
    }
    
    //MARK:Delete Photo Server Caling Function
    func functionForDeleteAlbum(_ photoIDs:String)
    {
        //loaderClass.loaderViewMethod()
      
        var urlStr = baseUrl+touchBase_DeleteAlbumPhoto
        // define parameters
        let parameters = ["photoId": photoIDs , "albumId": self.GetAlbumID , "deletedBy": self.GetUserIdProfileID]
        // Begin upload
        
        print(parameters)
        
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: urlStr, parameters: parameters, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            print(response)
            let dictResponseData = response as! NSDictionary
            print("dd \(dictResponseData)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            print(dictResponseData)
            let message = (dictResponseData.value(forKey: "TBDelteAlbumPhoto")! as AnyObject).value(forKey: "message") as! String
            if(message=="failed")
            {
                print("Hello Filed")
                self.loaderClass.window=nil;
            }
            else
            {
                self.functionForFetchingAlbumPhotosListData()
                UserDefaults.standard.setValue("Changes", forKey: "session_NewImageAddedSuccess")
                self.collectionViewDelete.reloadData()
                let alert = UIAlertController(title: "Album", message: "Deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:{(action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }));
                if(self.muarrayDeletePhotoArray.count==0)
                {
                    self.present(alert, animated: true, completion: nil)
                }
                //self.presentViewController(alert, animated: true, completion: nil)
                self.loaderClass.window=nil;
                }
            }
        })
    }
    
}
