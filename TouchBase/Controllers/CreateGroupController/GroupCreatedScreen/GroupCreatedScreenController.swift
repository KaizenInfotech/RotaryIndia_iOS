//
//  GroupCreatedScreenController.swift
//  TouchBase
//
//  Created by Kaizan on 20/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class GroupCreatedScreenController: UIViewController , uploadDocDelegate , webServiceDelegate{
    
    let bounds = UIScreen.main.bounds
    
    var count = 0
    var appDelegate = AppDelegate()
    var NameString : String = ""
    var NumberString : String = ""
    
    var NameArray = NSArray()
    var NumberArray = NSArray()
    
    var GroupID : String = ""
    var GroupName : String = ""
    var GroupImage : String = ""
    var trialMessage : NSString!
    @IBOutlet var AddLabelString: UILabel!
    @IBOutlet var addedMemberCountSTR: UILabel!
    @IBOutlet var memberSTR: UILabel!
    @IBOutlet var editMembersButton: UIButton!
    
    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let tabledata = UserDefaults.standard.array(forKey: "contactNameForGroup")
        {
            
            let tabledata1 = UserDefaults.standard.array(forKey: "contactNumberForGroup")
            
            print(tabledata)
            print(tabledata.count)
            
            NameArray = tabledata as NSArray
            addedMemberCountSTR.text = String(format:"%d",NameArray.count)
            NameString = NameArray.componentsJoined(by: ",")
            print(NameString)
            
            
            
            NumberArray = tabledata1! as NSArray
            NumberString = NumberArray.componentsJoined(by: ",")
            print(NumberString)
            
            
            addedMemberCountSTR.isHidden = false
            AddLabelString.isHidden = false
            //editMembersButton.hidden = false
            memberSTR.isHidden = false
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        groupNameLabel.text = GroupName
        
        if let checkedUrl = URL(string: GroupImage) {
            
            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                DispatchQueue.main.async { () -> Void in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    self.groupImageView.image = UIImage(data: data)
                    
                   
                }
            }
        }

        if(trialMessage != ""){
            let alert = UIAlertController(title: "Thank You!", message: trialMessage as String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Subscribe", style: UIAlertAction.Style.cancel, handler: { alertAction in
               // UIApplication.sharedApplication().openURL(NSURL(string : "http://touchbase.in/mobile/subscribes.html")!)
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "terms_conditions") as! TermsConditionsController
                secondViewController.isCalledFrom="group"
                
                self.navigationController?.pushViewController(secondViewController, animated: true)
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Try Free", style: UIAlertAction.Style.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
      func createNavigationBar()
      {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Entity Created"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(GroupCreatedScreenController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        //self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddMembersAction(_ sender: AnyObject)
    {
//        let profVC = self.storyboard!.instantiateViewControllerWithIdentifier("add_member_group") as! AddMemberToGroupController
//        profVC.GroupID =  GroupID  //nameTitles[indexPath.row]
//        self.navigationController?.pushViewController(profVC, animated: true)
        
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("add_member_group") as UIViewController, animated: true)
    }//contact_list
    
    @IBAction func EditMembersAction(_ sender: AnyObject)
    {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "contact_list") as UIViewController, animated: true)
    }
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        UserDefaults.standard.set("", forKey: "contactNameForGroup")
        UserDefaults.standard.set("", forKey: "contactNumberForGroup")
        UserDefaults.standard.set("", forKey: "EditcontactNameForGroup")
        UserDefaults.standard.set("", forKey: "EditcontactNumberForGroup")
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "rootDashss") as UIViewController, animated: true)
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("modules") as UIViewController, animated: true) //
        
//        let memberUID = NSUserDefaults.standardUserDefaults().stringForKey("MasterUID")
//        print(memberUID)
//        let wsm : UploadDocManager = UploadDocManager.getSharedInstance()
//        wsm.delegate=self
//        wsm.createNsArrayDic(NameArray as [AnyObject], andNumberArray: NumberArray as [AnyObject], andGroupID: GroupID, andMasterUID: memberUID)

    }
    
    
//    func getDicArraySucceeded(responce : NSMutableArray)
//    {
//        print(responce)
//        
//        let wsm : WebserviceClass = WebserviceClass.sharedInstance
//        wsm.delegates = self
//        wsm.getAddMembersToGroup(responce)
//    }
    
    
    func getAddMembersSuccss(_ addMembers : TBAddMemberGroupResult)
    {
        print(addMembers.status)
        print(addMembers.message)
    }
    
}

