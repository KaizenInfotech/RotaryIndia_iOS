//
//  SubGroupDetailViewController.swift
//  TouchBase
//
//  Created by Umesh on 11/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class SubGroupDetailViewController: UIViewController,webServiceDelegate,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var memberTableView: UITableView!
    var mainArray : NSArray!
    var subTitleTxt:String!
    var grpId:NSString!
    var subgrpId:NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        mainArray=[]
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        wsm.subGrpDEtailofUserGrp(grpId, subgrpId: subgrpId)
        // Do any additional setup after loading the view.
    }
    func getsubgrpDetailListSucc(_ string:TBGetSubGroupDetailListResult){
        mainArray=string.subGroupResult as! NSArray
        memberTableView.reloadData()
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=subTitleTxt
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SubGroupDetailViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainArray.count
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = memberTableView.dequeueReusableCell(withIdentifier: "subDetailCell", for: indexPath) as! SubGrpDetailCell
        
        
        var directoryList = SubgrpMemberDetail()
        directoryList = mainArray.object(at: indexPath.row) as! SubgrpMemberDetail
        
        cell.nameLabel.text   =  directoryList.memname  //nameTitles[indexPath.row]
        cell.mobileLabel.text =  directoryList.mobile
      
       
        return cell
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
