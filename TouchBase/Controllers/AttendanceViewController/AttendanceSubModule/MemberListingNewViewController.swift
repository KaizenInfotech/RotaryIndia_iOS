//
//  MemberListingNewViewController.swift
//  TouchBase
//
//  Created by tt on 12/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class MemberListingNewViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var tableviewMemberListNew: UITableView!
    var prototypeCells:MemberListingNewTableViewCell=MemberListingNewTableViewCell()
    let reuseIdentifier = "cell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForCreaqteNavigation()
        functionForFetchingMemberListingListData()
//        self.edgesForExtendedLayout=[]
        //
        textfieldSearch.addTarget(self, action: #selector(MemberListingNewViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        //print(muarrayListData)
        //print(muarrayCheckUncheck)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
        //textfieldSearch.resignFirstResponder()
        //pickerView.hidden=true
    }
    
    // Do any additional setup after loading the view.
    
    
    
    
    var muarrayListData:NSArray=NSArray()
    var muarrayMainList:NSArray=NSArray()
    var muarrayCheckUncheck:NSMutableArray=NSMutableArray()
    
    
    
    
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = "Members"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        /*
         buttonleft = UIButton(type: UIButton.ButtonType.custom)
         buttonleft.frame = CGRectMake(0, 0, 20, 20)
         buttonleft.setImage(UIImage(named:"back_btn_blue"), forState: UIControl.State.Normal)
         buttonleft.addTarget(self, action: #selector(MemberListingNewViewController.buttonBackClicked), forControlEvents: UIControl.Event.TouchUpInside)
         let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
         self.navigationItem.leftBarButtonItem = leftButton
         */
        
        
        buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonleft.setTitle("Cancel",  for: UIControl.State.normal)
        buttonleft.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonleft.layer.cornerRadius = 5
        buttonleft.layer.borderWidth = 1
        buttonleft.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonleft.addTarget(self, action: #selector(MemberListingNewViewController.buttonCancelClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        
        
        
        buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(MemberListingNewViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
        
        
        
        /*
         buttonRight = UIButton(type: UIButton.ButtonType.custom)
         buttonRight.frame = CGRectMake(0, 0, 20, 20)
         buttonRight.setImage(UIImage(named:"edit_Blue"), forState: UIControl.State.Normal)
         buttonRight.addTarget(self, action: #selector(MemberListingNewViewController.buttonEditClickEvent), forControlEvents: UIControl.Event.TouchUpInside)
         let edit: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
         let buttons : NSArray = [edit]
         self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
         */
    }
    var buttonleft = UIButton()
    var buttonRight = UIButton()
    
    
    
    @objc func buttonCancelClicked()
    {
        //print("Back button clikced")
        self.navigationController?.popViewController(animated: true)
    }
    var objProtocol:protocolName?=nil
    @objc func buttonAddClickEvent()
    {
        //let name: NSArray = ["John","Jake","Tom"]
        
        for i in 00..<muarrayCheckUncheck.count
        {
            if(muarrayCheckUncheck.object(at: i)as! String=="0")
            {
                
            }
            else
            {
                
            }
        }
        
        let muaarayMyGlboalArrayPassValue = NSMutableArray(array:muarrayCheckUncheck)
        self.objProtocol?.functionForSendingValue("Members", index: 4, muarrayValueGlobal: muaarayMyGlboalArrayPassValue)
         self.navigationController?.popViewController(animated: true)
        //print("Edit button clikced")
        
    }
    //MemberListingNewTableViewCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 74.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MemberListingNewTableViewCell
        if(muarrayListData.count>0)
        {
            
            /*
             designation = "";
             memberName = San;
             pic = "";
             profileID = 260114;
             */
            // //print(muarrayListData)
            prototypeCells.labelMemberName.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "memberName")as! String
            prototypeCells.labelDesig.text=(muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "designation")as! String
            
            let varImage = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "pic")as! String
            if varImage == ""
            {
                prototypeCells.imageUser.image = UIImage(named: "profile_pic")
            }
            else
            {
                let ImageProfilePic:String = varImage.replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                prototypeCells.imageUser.sd_setImage(with: checkedUrl)
            }
            //--check uncheck
            /*
            if(muarrayCheckUncheck.objectAtIndex(indexPath.row)as! String=="0")
            {
                prototypeCells.imageCheckUncheck.image = UIImage(named: "UN_CHECK_BLUE_ROW.png")
            }
            else
            {
                prototypeCells.imageCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW.png")
            }
            */
            
            
            let varGetValue:String! = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "profileID")as! String
            
            let memberNametemp:String! = (muarrayListData.object(at: indexPath.row) as AnyObject).value(forKey: "memberName")as! String
            
            
            //print(varGetValue)
            //print(memberNametemp)
            //print(muarrayCheckUncheck)
           // //print(muarrayListData)
            /*
             (
             244037,
             232120
             )
             */
            if(muarrayCheckUncheck.contains(varGetValue))
            {
               prototypeCells.imageCheckUncheck.image = UIImage(named: "CHECK_BLUE_ROW.png")
            }
            else
            {
                prototypeCells.imageCheckUncheck.image = UIImage(named: "UN_CHECK_BLUE_ROW.png")
            }
            
            //button event
            prototypeCells.buttonMainMember.addTarget(self, action: #selector(MemberListingNewViewController.buttonMemberListingClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMainMember.tag = indexPath.row
            /*
             DateOfAnn = 17530101;
             DateOfAnnDisplay = "";
             DateOfBirth = 17530101;
             DateOfBirthDisplay = "";
             businessName = "";
             designation = "Software support";
             groupName = "Test Club";/Users/tt/Desktop/999999/12-June-18-ROW/TouchBase/Assets.xcassets/Row/CHECK_BLUE_ROW.imageset/CHECK_BLUE_ROW.png
             grpCount = 2;
             grpID = 2765;
             isDeleted = False;/Users/tt/Desktop/999999/12-June-18-ROW/TouchBase/Assets.xcassets/Row/UN_CHECK_BLUE_ROW.imageset/UN_CHECK_BLUE_ROW.png
             masterUID = 156940;
             memberName = "Anirudh Acharya";
             membermobile = "+91 9988776655";
             pic = "http://www.rosteronwheels.com/Documents/directory/14062017064950PM.png";
             profileID = 157443;
             */
            
        }
        return prototypeCells
    }
    //details album
    @objc func buttonMemberListingClickEvent(_ sender:UIButton)
    {
        
        let varGetValue:String! = (muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "profileID")as! String
        if(muarrayCheckUncheck.contains(varGetValue))
        {
            // muarrayCheckUncheck.remo
            muarrayCheckUncheck.remove(varGetValue)
        }
        else
        {
            muarrayCheckUncheck.add(varGetValue)
        }
        
        //print(varGetValue)
        //print(muarrayCheckUncheck)
        tableviewMemberListNew.reloadData()
        
        //work for holding delete key value
          let profileID:String! = (muarrayListData.object(at: sender.tag) as AnyObject).value(forKey: "profileID")as! String
        //print(muarrayMemberDelete)
        if(muarrayMemberServerIDDelete.contains(profileID))
        {
            muarrayMemberDelete.add(profileID)
        }
        print("This is delete id Member:>>>>>>>>>>>>>>>>>>>")
        print(muarrayMemberDelete)
    }
    ////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()  //if desired
        functionForSearchByPredicate(textfieldSearch.text!)
        return true
    }
    var varGetSearchText:String!=""
    
    
    func functionForSearchByPredicate(_ searchText:String)
    {
        
         //print("Click event keyboard return button")
         //print("searchText \(textfieldSearch.text!)")
         varGetSearchText = textfieldSearch.text!
         //print("use predicate 2 here")
         //textfieldSearch.resignFirstResponder()
         if(varGetSearchText.characters.count>0)
         {
         let predicate =  NSPredicate(format: "memberName contains[c] %@ OR designation contains[c] %@", varGetSearchText,varGetSearchText)
            
            print(muarrayListData)
            
            let searchDataSource = muarrayListData.filtered(using: predicate)
            muarrayListData=searchDataSource as NSArray
         //print(muarrayListData)
         self.tableviewMemberListNew.reloadData()
         }
         else
         {
         muarrayListData=NSMutableArray()
         self.muarrayListData = self.muarrayMainList
         self.tableviewMemberListNew.reloadData()
         }
 
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        //your code
        print(textField.text)
        functionForSearchByPredicate(textField.text!)
    }
    
    //calling web services
    var grpIDMemberList:String!=""
    func functionForFetchingMemberListingListData()
    {
        //loaderViewMethod()
        /*
         masterUID=%@&grpID=%@&searchText=%@&page=%@
         */
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        
        
        let completeURL = baseUrl+"Member/GetDirectoryList"
        let parameterst = [
            "masterUID":mainMemberID,
            "grpID":grpIDMemberList,
            "searchText":"",
            "page":""
        ]
        //print(parameterst)
        //print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            // //print(response)
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
            if((dd.object(forKey: "TBMemberResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                let arrarrNewGroupList = (dd.object(forKey: "TBMemberResult")! as AnyObject).object(forKey: "MemberListResults")
                //print(arrarrNewGroupList)
                
                let arrarrNewGroupLists = ((dd.object(forKey: "TBMemberResult")! as AnyObject).object(forKey: "MemberListResults")! as AnyObject).object(at: 0)
                //print(arrarrNewGroupLists)
                
                
                print(arrarrNewGroupList)
                print(arrarrNewGroupLists)

                
                self.muarrayMainList = arrarrNewGroupList as! NSArray
                self.muarrayListData = arrarrNewGroupList as! NSArray
                
                var muarrayTemp:NSMutableArray=NSMutableArray()
                for i in 00..<self.muarrayMainList.count
                {
                
                    let memberName:String! = ((self.muarrayListData.object(at: i) as AnyObject).value(forKey: "MemberListResult")! as AnyObject).value(forKey: "memberName")as! String
                    let designation:String! = ((self.muarrayListData.object(at: i) as AnyObject).value(forKey: "MemberListResult")! as AnyObject).value(forKey: "designation")as! String
                    let pic:String! = ((self.muarrayListData.object(at: i) as AnyObject).value(forKey: "MemberListResult")! as AnyObject).value(forKey: "pic")as! String
                    let profileID:String! = ((self.muarrayListData.object(at: i) as AnyObject).value(forKey: "MemberListResult")! as AnyObject).value(forKey: "profileID")as! String

                    
                    
                    
                    var dict:NSDictionary=NSDictionary()
                    dict=["memberName":memberName,"designation":designation,"pic":pic,"profileID":profileID]
                    
                 muarrayTemp.add(dict)
                    
                    /*
                     
                     designation
                     memberName
                     pic
                     profileID
                     
                     
                     DateOfAnn = 00000000;
                     DateOfAnnDisplay = "<null>";
                     DateOfBirth = 00000000;
                     DateOfBirthDisplay = "<null>";
                     businessName = "";
                     designation = "";
                     groupName = "Rotary Club of Thane City View";
                     grpCount = 2;
                     grpID = 2765;
                     isDeleted = False;
                     masterUID = 52899;
                     memberName = "A     ios  team ";
                     membermobile = "+91 9876543210";
                     pic = "";
                     profileID = 284817;
                     */
                    
                    
                
                }
                
                print(muarrayTemp)
                print(muarrayTemp.count)

                self.muarrayMainList=NSMutableArray()
                self.muarrayListData=NSMutableArray()

                
                self.muarrayMainList = muarrayTemp as! NSArray
                self.muarrayListData = muarrayTemp as! NSArray
                
                
                
                
                //get count for check uncheck
                //var varGetValue:Int!=self.muarrayMainList.count
                /*
                 for i in 00..<self.muarrayMainList.count
                 {
                 self.muarrayCheckUncheck.addObject("0")
                 }
                 */
                
                self.tableviewMemberListNew.reloadData()
                self.window=nil
                
            }
            else
            {
                self.window=nil
                //print("NO Result")
            }
            SVProgressHUD.dismiss()
        }
        })
    }
    //MARK:- Loader Method
    var window: UIWindow?
    /*
    func loaderViewMethod()
    {
        let screenSize: CGRect = UIScreen.main.bounds
        
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
}
