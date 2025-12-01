//
//  RotaryIndiaViewController.swift
//  TouchBase
//
//  Created by Harshada on 18/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class RotaryIndiaCell:UICollectionViewCell
{
    @IBOutlet weak var moduleImageButton: UIButton!
    @IBOutlet weak var lblModuleName: UILabel!
    @IBOutlet weak var mainbutton: UIButton!
}


class RotaryIndiaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var indiaCollectionView: UICollectionView!
    @IBOutlet weak var lblLoading: UILabel!
    
    var onlinemuarrayModule:NSArray = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForSetLeftNavigation()
        indiaCollectionView.reloadData()
        getModuleList()
        // Do any additional setup after loading the view.
    }

    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Rotary India" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func backClicked()
    {
      self.navigationController?.popViewController(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onlinemuarrayModule.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indiaCell", for: indexPath) as! RotaryIndiaCell
        if let row_data=onlinemuarrayModule.object(at: indexPath.row) as? NSDictionary
        {
            cell.lblModuleName.text=row_data.object(forKey: "moduleName") as? String
            let imageURL=row_data.object(forKey: "image") as? String
            cell.moduleImageButton.sd_setImage(with: URL(string: imageURL!), for: UIControl.State.normal, placeholderImage: UIImage(named: "Asset10"))
            cell.mainbutton.tag=indexPath.row
            cell.mainbutton.addTarget(self, action: #selector(mainButtonClickEvent(_:)), for: .touchUpInside)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing = CGFloat(0) //Define the space between each cell
        let leftRightMargin = CGFloat(0) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(3) //The total number of columns you want
        
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = ((screenWidth - leftRightMargin - totalCellSpace) / numColumns)
        let height = CGFloat(110) //whatever height you want
        return CGSize(width:width-7, height:height);
    }

    @objc func mainButtonClickEvent(_ sender:UIButton)
    {
        if let row_data=onlinemuarrayModule.object(at: sender.tag) as? NSDictionary
        {
            if let isWebLink=row_data.object(forKey: "isweblink") as? String
            {
                let moduleName = row_data.object(forKey: "moduleName") as? String
                let webURL=row_data.object(forKey: "URL") as? String
                let moduleId = row_data.object(forKey: "moduleId") as? String
                if isWebLink=="1" && moduleName=="CASHBACK"
                {
                    if let urlString = webURL {
                        if let whatsappURL = URL(string: urlString) {
                            if UIApplication.shared.canOpenURL(whatsappURL) {
//                                UIApplication.shared.openURL(whatsappURL)
                                
                                if UIApplication.shared.canOpenURL(whatsappURL) {
                                    UIApplication.shared.open(whatsappURL, options: [:]) { success in
                                            if success {
                                                print("The URL was successfully opened.")
                                            } else {
                                                print("Failed to open the URL.")
                                            }
                                        }
                                    }

                                
                            } else {
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = "Rotary India"
                                alertView.message = "Please check your network connection."
                                alertView.delegate = self
                                alertView.addButton(withTitle: "OK")
                                alertView.show()
                            }
                        }
                    }
                }
                else if isWebLink=="1"
                {
                    WebCall(moduleName: moduleName!, url: webURL!)
                }
                else
                {
  switch moduleId {
  case "55":
                //Announcement
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIAnnouncementListVC") as! RIAnnouncementListVC
    self.navigationController?.pushViewController(secondViewController, animated: true)

  break
  case "54":
                //Events
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIEventsListVC") as! RIEventsListVC
    self.navigationController?.pushViewController(secondViewController, animated: true)

  break
  case "57":
                //Documents
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIDocumentListVC") as! RIDocumentListVC
    self.navigationController?.pushViewController(secondViewController, animated: true)

  break
  case "56":
                //Newsletter
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RINewsLetterListVC") as! RINewsLetterListVC
    self.navigationController?.pushViewController(secondViewController, animated: true)
                        
  break
  default:
  break
   }
                }
            }
        }
    }
    
    func WebCall(moduleName:String,url:String)
    {
        let objWebSiteOpenUrlViewController = self.storyboard!.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
        objWebSiteOpenUrlViewController.URLstr=url
        print("Web Commitiee URL \(url)")
        objWebSiteOpenUrlViewController.moduleName=moduleName
        self.navigationController?.pushViewController(objWebSiteOpenUrlViewController, animated: true)
    }
    
    func getModuleList()
    {
        let completeURL=baseUrl+"Group/GetRotaryIndiaAdminModules"
        SVProgressHUD.show()
        self.indiaCollectionView.isHidden=true
        self.lblLoading.isHidden=false
        self.lblLoading.text="Loading... Please Wait"
        Alamofire.request(completeURL,method: .get, parameters: nil, encoding: URLEncoding.default, headers:nil).responseJSON { response in
            SVProgressHUD.dismiss()
            if response.result.value != nil
            {
                if let status = response.response?.statusCode {
                    switch(status)
                    {
                    case 200:
                        
                        if let data = response.result.value as? NSDictionary
                        {
            print("Data is \(data)")
            if let TBRotaryIndiaModulesResult = data.object(forKey: "TBRotaryIndiaModulesResult") as? NSDictionary
            {
                if TBRotaryIndiaModulesResult.object(forKey: "status") as! String == "0"
                {
                    if let RotaryIndiaModulesResult = TBRotaryIndiaModulesResult.object(forKey: "RotaryIndiaModulesResult") as? NSArray
                    {
                        self.onlinemuarrayModule=RotaryIndiaModulesResult
                        if self.onlinemuarrayModule.count>0
                        {
                            self.lblLoading.isHidden=true
                            self.indiaCollectionView.isHidden=false
                            self.indiaCollectionView.reloadData()
                        }
                        else
                        {
                            self.lblLoading.text="No result."
                        }
                    }
                }
                else{
                    self.lblLoading.text="Could not connect to server"
                }
            }
        }
        break
    default:
        self.lblLoading.text="Could not connect to server"
                        break
                    }
                }
            }
            else
            {
                print("response.result.value != nil ")
            }
        }
    }
}
