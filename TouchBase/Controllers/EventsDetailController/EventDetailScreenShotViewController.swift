//
//  EventDetailScreenShotViewController.swift
//  TouchBase
//
//  Created by rajendra on 10/01/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class EventDetailScreenShotViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
  var  objProtocolBackImage:protocolNameBackImage?=nil
    override var prefersStatusBarHidden: Bool {
        return true
    }
    var isCategory:String!=""
    @IBOutlet weak var tableviewScreenShot: UITableView!
    @IBOutlet weak var viewMain: UIView!
    var TotalCount:Int!=0
    var YesCount:Int!=0
    var NoCount:Int!=0
    var MaybeCount:Int!=0
    var getText:String!=""
    //
    var imageScreenShot:String!=""
    var Titlenew:String!=""
    var Description:String!=""
    var Venue:String!=""
    var eventDateTime:String!=""
    var reglink:String!=""
    
    func createImage() -> UIImage{
        
        let contentSize : CGSize = self.tableviewScreenShot.contentSize
        let width = self.tableviewScreenShot.contentSize.width
        let height = self.tableviewScreenShot.contentSize.height
        //  Converted to Swift 4 by Swiftify v4.2.28993 - https://objectivec2swift.com/
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), _: false, _: 0.0)
        var context = UIGraphicsGetCurrentContext()
        var previousFrame: CGRect = view.frame
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: width, height: height)
        if let context = context {
            view.layer.render(in: context)
        }
        view.frame = previousFrame
        var image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
        
        
        
        
        
        let imageData: Data = image!.pngData()!
        print(imageData)
        // let imageUrlString = newString
        /// let imageUrl = URL(string: imageUrlString)!
        // let imageData = try! Data(contentsOf: imageUrl)
        //let image = UIImage(data: imageData)
        var imageSize: Int = imageData.count
        print("size of image in KB: %f ", Double(imageSize) / 1024.0)
        var getdocSize:Double=Double(imageSize) / 1024.0
        getdocSize=getdocSize/1024.0
        print(getdocSize)
        
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        
        self.objProtocolBackImage?.functionForBackImage(imageImageNew: image!)
        
        print("print screen event clicked !!!!!!!!!")
        self.navigationController?.popViewController(animated: true)
//        let layer = UIApplication.shared.keyWindow!.layer
//        let scale = UIScreen.main.scale
//        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//       /// let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//       // UIGraphicsEndImageContext()
//       // UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
//        // set up activity view controller
//        let imageToShare = [ image! ]
//        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//        
//        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
//        
//        // present the view controller
//        self.present(activityViewController, animated: true, completion: nil)
//        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return image!
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Events"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ClubEventDetailsShowViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ClubEventDetailsShowViewController.AddEventAction))
        //add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
        //        if mainMemberID == "Yes"
        //        {
        //            self.navigationItem.rightBarButtonItem = add
        //        }
        //Partial
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        if((self.presentingViewController) != nil)
        {
            self.dismiss(animated: false, completion: nil)
            print("done")
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.view.backgroundColor=UIColor.white
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 4)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.createImage()
        })
        
        
        
        tableviewScreenShot.isHidden=false
        //UserDefaults.standard.setValue(dictMainnew, forKey: "session_screenShotEventsDetail")
        tableviewScreenShot.separatorStyle = .none
        print(myTempDictForScreenShotDataHolding)
        print(imageScreenShot)
        print(Titlenew)
        print(Description)
        print(Venue)
        print(eventDateTime)
        print(reglink)
        print(TotalCount)
        print(YesCount)
        print(NoCount)
        print(MaybeCount)
        print(getText)
        createNavigationBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
          var RowHeight:CGFloat!=0.0
    //-------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return RowHeight
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        tableView.tableHeaderView?.frame = CGRect(x:5,y:5,width:self.viewMain.frame.size.width-10,height:80)
//        tableView.tableHeaderView = self.viewMain
//
//
//        return tableView.tableHeaderView
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableviewScreenShot.dequeueReusableCell(withIdentifier: "TableViewCustomeCell", for: indexPath) as! ScreenShotTableViewCell
        cell.viewHeader.isHidden=true
        cell.viewImage.isHidden=true
        //2.
        cell.viewTitle.isHidden=true
        //3.
        cell.viewVenue.isHidden=true
        //4.
        cell.viewDate.isHidden=true
        //5.
        cell.viewLink.isHidden=true
        //6.
        cell.viewAll.isHidden=true
        cell.textviewDescription.isHidden=true
        cell.textviewVenue.isHidden=true

       cell.viewBottom.isHidden=true
        cell.viewLower.isHidden=true

        
        
        
        /*
         print(imageScreenShot)
         print(Titlenew)
         print(Description)
         print(Venue)
         print(eventDateTime)
         print(reglink)
         print(TotalCount)
         print(YesCount)
         print(NoCount)
         print(MaybeCount)
         print(getText)
         */
        //1.
        if(indexPath.row==0)
        {
            cell.viewHeader.isHidden=false
            RowHeight=90
            if(isCategory=="1")
            {
                cell.imageUpper.image=UIImage(named:"clubUpper")

            }
            else if(isCategory=="2")
            {
                cell.imageUpper.image=UIImage(named:"districtLower")

            }
            cell.labelHeadercluborDistrictName.text=cluborDistrictName
            
        }
        if(indexPath.row==1)
        {
          if(imageScreenShot.characters.count>5)
          {
            cell.viewImage.isHidden=false
            RowHeight=200
            let ImageProfilePic:String = imageScreenShot!.replacingOccurrences(of: " ", with: "%20")
            let checkedUrl = URL(string: ImageProfilePic)
            cell.imageMain.sd_setImage(with: checkedUrl)
          }
        else
           {
             cell.viewImage.isHidden=true
             RowHeight=0
           }
        }
        //2.
        if(indexPath.row==2)
        {
            if(Titlenew.characters.count>2)
            {
                cell.viewTitle.isHidden=false
                RowHeight=60
                cell.labelTitle.text=Titlenew
            }
            else
            {
                cell.viewTitle.isHidden=true
                RowHeight=0
            }
        }
        //3.
        if(indexPath.row==3)
        {
            if(Description.characters.count>2)
            {
                  cell.textviewDescription.isHidden=false
              //  RowHeight=80
                cell.textviewDescription.text=Description
                let fixedWidth = cell.textviewDescription.frame.size.width
                cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame = cell.textviewDescription.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewDescription.frame = newFrame;
                RowHeight=newSize.height+5
            }
            else
            {
                cell.textviewDescription.isHidden=true
                RowHeight=0
            }
        }
        if(indexPath.row==4)
        {
            if(Venue.characters.count>2)
            {
                /*
                cell.viewVenue.isHidden=false
                cell.labelVenue.text=Venue
                */
                cell.textviewVenue.isHidden=false
                //  RowHeight=80
                cell.textviewVenue.text=Venue
                let fixedWidth = cell.textviewVenue.frame.size.width
                cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                let newSize = cell.textviewVenue.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                var newFrame = cell.textviewVenue.frame
                newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                cell.textviewVenue.frame = newFrame;
                RowHeight=newSize.height+5
                
                
                
                
                
                
                

               /* RowHeight=92*/
            }
            else
            {
                cell.textviewVenue.isHidden=true
                cell.viewVenue.isHidden=true
                RowHeight=0
            }
        }
        //4.
        if(indexPath.row==5)
        {
            if(eventDateTime.characters.count>2)
            {
                cell.viewDate.isHidden=false
                RowHeight=50
                cell.labelDate.text=eventDateTime
            }
            else
            {
                cell.viewDate.isHidden=true
                RowHeight=0
            }
        }
        //5.
        if(indexPath.row==6)
        {
            if(reglink.characters.count>2)
            {
                cell.viewLink.isHidden=false
                RowHeight=50
                cell.labelLink.text="Link : "+reglink
            }
            else
            {
                cell.viewLink.isHidden=true
                RowHeight=0
            }
        }
        //6.
        if(indexPath.row==7)
        {
            if(TotalCount != 0)
            {
                cell.viewAll.isHidden=false
                RowHeight=80
                cell.labelTotalYesNoMayBe.text="\(TotalCount)"+" "+"\(YesCount)"+" "+"\(NoCount)"+" "+"\(MaybeCount)"
                cell.labelTextRed.text=getText
            }
            else
            {
                cell.viewAll.isHidden=true
                RowHeight=0
            }
        }
        
        if(indexPath.row==8)
        {
            cell.viewBottom.isHidden=false
             RowHeight=105
            if(isCategory=="1")
            {
                cell.imageLower.image=UIImage(named:"clubLower")
            }
            else if(isCategory=="2")
            {
                cell.imageLower.image=UIImage(named:"districtLower")

            }
            
        }
         if(indexPath.row==9 )
        {
           RowHeight=1
        }
       
 
        
        
        /*
         cell.textviewDescription.attributedText=attributedStringss
         let fixedWidth = cell.textviewDescription.frame.size.width
         cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
         let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
         var newFrame = cell.textviewDescription.frame
         newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
         cell.textviewDescription.frame = newFrame;
         varRowHeight=newSize.height+5
         */
        return cell
    }
}







