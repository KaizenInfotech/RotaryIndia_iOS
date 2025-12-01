//
//  SideBarGroupDistrictListViewController.swift
//  TouchBase
//
//  Created by rajendra on 26/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class SideBarGroupDistrictListViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableGroupList: UITableView!
    var listSyncOnline: Resultus?
    var mainArray:NSMutableArray=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        print(mainArray)
        // Do any additional setup after loading the view.
    }
    
    
    func createNavigationBar()
    {
//        self.edgesForExtendedLayout=[]
        
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        self.title = "Settings"
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
        
        self.navigationItem.setHidesBackButton(true, animated:true);
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SideBarGroupDistrictListViewController.backClicked), for: UIControl.Event.touchUpInside)
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
    

    //MARK:- Table Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listSyncOnline?.groupList?.newGroupList?.count ?? 0
    }
    
    
    /*(
     {
     grpId = 2765;
     grpImg = "http://www.rosteronwheels.com/Documents/Group/it-directorates_0212122017030952PM.png";
     grpName = ROW;
     grpProfileid = 247960;
     isGrpAdmin = Yes;
     myCategory = 1;
     notificationCount = 14;
     },
     {
     grpId = 31185;
     grpImg = "";
     grpName = "District 5656";
     grpProfileid = 247976;
     isGrpAdmin = Yes;
     myCategory = 2;
     notificationCount = 1;
     }
     )*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableGroupList.dequeueReusableCell(withIdentifier: "SidebarGroupDistrictListCell", for: indexPath) as! SidebarGroupDistrictListCell
       if((listSyncOnline?.groupList?.newGroupList?.count ?? 0) > 0)
       {
           let grpName = listSyncOnline?.groupList?.newGroupList?[indexPath.row].grpName
           cell.lblGroupName.text! = grpName ?? ""
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let grpIds = listSyncOnline?.groupList?.newGroupList?[indexPath.row].grpID
        let grpProfileIDs = listSyncOnline?.groupList?.newGroupList?[indexPath.row].grpProfileID
        let myCategory = listSyncOnline?.groupList?.newGroupList?[indexPath.row].myCategory
        let grpName = listSyncOnline?.groupList?.newGroupList?[indexPath.row].grpName
        
        
        if(myCategory=="2")
        {
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "SideBarNotificationViewController") as! SideBarNotificationViewController
            profVC.grpID = grpIds
            profVC.grpProfileID = grpProfileIDs
            profVC.moduleName = grpName
            self.navigationController?.pushViewController(profVC, animated: true)
        }
        else
        {
            let profVC = self.storyboard!.instantiateViewController(withIdentifier: "ModuleSettingViewController") as! ModuleSettingViewController
            profVC.grpID = grpIds
            profVC.grpProfileID = grpProfileIDs
            //profVC.moduleName = "Settings"
            profVC.moduleName = grpName

            self.navigationController?.pushViewController(profVC, animated: true)
            
            
   
        }
        //
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
