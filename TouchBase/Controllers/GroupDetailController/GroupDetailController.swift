
//
//  GroupDetailController.swift
//  TouchBase
//
//  Created by Kaizan on 16/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class GroupDetailController: UIViewController , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var grpDetialCollectionView: UICollectionView!
    
    var selectedVal: Int!
    
    var arrDict : NSArray = NSArray()
    
    var namesArray = ["Directory","E-bulletin","Announcement","Events","Celebrations","Meetings","Gallery", "Chat","Document Safe","Committee","Entity","Task"]
    
    var appDelegate : AppDelegate = AppDelegate()
    
    
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.white
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    //    screenSize = UIScreen.mainScreen().bounds
    //    screenWidth = screenSize.width
    //    screenHeight = screenSize.height
        
        
        // Do any additional setup after loading the view, typically from a nib
  //      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
  //      layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
   //     layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
   //     layout.minimumInteritemSpacing = 0
   //     layout.minimumLineSpacing = 0
        
    //    grpDetialCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    //    grpDetialCollectionView!.dataSource = self
    //    grpDetialCollectionView!.delegate = self
     //   grpDetialCollectionView!.backgroundColor = UIColor.greenColor()
     //   self.view.addSubview(grpDetialCollectionView!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
    }
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Kaizen Infotech"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GroupDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in collectionView:
        UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return namesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell
    {
        
        let cell = grpDetialCollectionView.dequeueReusableCell(withReuseIdentifier: "groupDetail",
            for: indexPath) as! GroupDetailCell
        
    //    cell.frame.size.width = screenWidth / 2
    //    cell.frame.size.height = screenWidth / 2
        
        cell.nameLabel.text = namesArray[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if(indexPath.row == 0)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "directory") as UIViewController, animated: true)
        }
        else if(indexPath.row == 1)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ebulletine") as UIViewController, animated: true)
        }
        else if(indexPath.row == 2)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "announcement") as UIViewController, animated: true)
        }
        else if(indexPath.row == 3)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "events") as UIViewController, animated: true)
        }
        else if(indexPath.row == 4)
        {
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "profileView") as UIViewController, animated: true)
        }

    }

    
    
    
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        if indexPath.row == 0
//        {
//            return CGSize(width: screenWidth, height: screenWidth/2)
//        }
//        return CGSize(width: screenWidth/2, height: screenWidth/2);
//        
//    }
    
//    //Use for size
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        return CGSizeMake(125, 161)
//    }
//    //Use for interspacing
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//            return 10.0
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//            return 10.0
//    }

    
//    
//        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//        {
//            return CGSizeMake((UIScreen.mainScreen().bounds.width-105),160); //use height whatever you wants.
//        }
    
//        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//        {
//            return CGSize(width: collectionView.frame.width * 0.5, height: collectionView.frame.height * 0.2)
//        }
    //
  
    
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //
    //        if segue.identifier == "gallary_image" {
    //            let viewController:GallaryImageViewController = segue.destinationViewController as! GallaryImageViewController
    //
    //            viewController.photoDetails = arrDict.objectAtIndex(selectedVal) as! PhotoDetail
    //            viewController.identity = "0"
    //
    //        }
    //    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


