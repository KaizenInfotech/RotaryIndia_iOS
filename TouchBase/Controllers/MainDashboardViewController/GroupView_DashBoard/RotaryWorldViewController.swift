//
//  RotaryWorldViewController.swift
//  TouchBase
//
//  Created by Harshada on 17/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class RotaryWorldCell:UICollectionViewCell
{
    @IBOutlet weak var moduleImageButton: UIButton!
    @IBOutlet weak var lblModuleName: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
}

class RotaryWorldViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

@IBOutlet weak var worldCollectionView: UICollectionView!
let muarrayModulName = ["Library", "Rotary News", "Rotary Blog","Rotary.org"]
    
    
let muarrayModuleImage = ["Asset7","Asset4","Asset9","Asset2"]
    
// let muarrayModulName = ["Rotary India website", "Cashback", "Rotary India Leaders","Rotary India web-committee"]

//let muarrayModuleImage = ["rt_web","cash_back","rt_leader","rt_commitee"]

    override func viewDidLoad() {
        super.viewDidLoad()
        functionForSetLeftNavigation()
        worldCollectionView.reloadData()
    }

    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Rotary World" as String
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
        return muarrayModulName.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "worldCell", for: indexPath) as! RotaryWorldCell
        cell.lblModuleName.text=muarrayModulName[indexPath.row]
        cell.moduleImageButton.setImage(UIImage(named: muarrayModuleImage[indexPath.row]), for: .normal)
        cell.mainButton.tag=indexPath.row
        cell.mainButton.addTarget(self, action: #selector(mainButtonClickEvent(_:)), for: .touchUpInside)

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
 if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
 {
     switch sender.tag {
         case 0:
             LibraryCE()
         break
         case 1:
             RotaryNewsCE()
         break
         case 2:
             RotaryBlogsCE()
         break
         case 3:
             RotaryOrgCE()
         break
         default:
         break
     }
 }
 else
 {
     self.view.makeToast("Oops! No internet available.", duration: 2, position: CSToastPositionCenter)
 }
}
    
    @objc func LibraryCE()
    {
        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryLibraryViewController") as! RotaryLibraryViewController
        objRotaryLibraryViewController.moduleName = "Rotary Library"
        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
        ////print("Tapped on Image4")
    }
    
    @objc func RotaryNewsCE()
    {
        
//        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryNewsViewController") as! RotaryNewsViewController
//        objRotaryLibraryViewController.moduleName="Rotary News"
//        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
//        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
        
    let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
    objRotaryLibraryViewController.moduleName="Rotary News"
    objRotaryLibraryViewController.varFromCalling = "Rotary News"
    self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
        
    }
    @objc func RotaryBlogsCE()
    {
        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryBlogViewController") as! RotaryBlogViewController
        objRotaryLibraryViewController.moduleName="Rotary Blogs"
        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
        
        
        
        ////print("Tapped on Image6")
    }
    @objc func RotaryOrgCE()
    {
        
        let objRotaryLibraryViewController = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
        objRotaryLibraryViewController.moduleName="Rotary.org"
        //objRotaryLibraryViewController.muarrauRotaryNews=self.muarrauRotaryNews
        self.navigationController?.pushViewController(objRotaryLibraryViewController, animated: true)
        
        
        
        //        if let requestUrl = NSURL(string: "https://my.rotary.org/en") {
        //            UIApplication.sharedApplication().openURL(requestUrl)
        //        }
        ////print("Tapped on Image7")
    }
}
