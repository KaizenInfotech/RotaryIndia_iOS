//
//  SelectModulesController.swift
//  TouchBase
//
//  Created by Kaizan on 20/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class SelectModulesController : UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate,moduleInfocellDelegate , webServiceDelegate
{
    @IBOutlet var ModulesTableView: UITableView!
    
    var array = [ToDoItem]()
    var moduleIds:NSMutableArray!
    //   var groupIds:NSMutableArray!
    var strGroupIDs : String = ""
    var strModuleIDs : String = ""
    
    var ModuleNamesArray : NSArray = NSArray()
    var mainArray = NSArray()
    
    @IBOutlet var outerFeaturView:UIView!
    @IBOutlet var featTitle:UITextField!
    @IBOutlet var featDesc:UITextView!
    @IBOutlet var submitBtn:UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.createNavigationBar()
        
        moduleIds = NSMutableArray()
        //   groupIds = NSMutableArray()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        footerView.backgroundColor = UIColor.white
        
        let suggestNewBtn = UIButton()
        suggestNewBtn.frame = CGRect(x: (self.view.frame.size.width/2)-100, y: 30, width: 200, height: 40)
        suggestNewBtn.layer.cornerRadius = 5.0
        suggestNewBtn.backgroundColor = UIColor.white
        footerView.addSubview(suggestNewBtn)
        suggestNewBtn.setTitle("Suggest a new Feature",  for: UIControl.State.normal)
        suggestNewBtn.setTitleColor(UIColor(red: (38/255.0), green: (113/255.0), blue: (37/255.0), alpha: 1.0),  for: UIControl.State.normal)
        suggestNewBtn.addTarget(self, action: #selector(SelectModulesController.suggestFeatureClk), for: UIControl.Event.touchUpInside)
        ModulesTableView.tableFooterView = footerView
        // ModulesTableView.reloadData()
        let toolBarmy = UIToolbar()
        toolBarmy .frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBarmy.barStyle = UIBarStyle.default
        toolBarmy.isTranslucent = true
        toolBarmy.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBarmy.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(SelectModulesController.DoneTextView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBarmy.setItems([spaceButton,doneButton], animated: false)
        toolBarmy.isUserInteractionEnabled = true
        featDesc.inputAccessoryView = toolBarmy
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates = self
        wsm.getModules()
    }
    @objc func DoneTextView()
    {
        
        featDesc.resignFirstResponder()
    }
    @objc func  suggestFeatureClk()  {
        featDesc.text! = "Feature Description"
        outerFeaturView.isHidden = false
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Select modules"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(SelectModulesController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
       // self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelClk(){
        outerFeaturView.isHidden = true
    }
    @IBAction func submitClk(){
        if(featTitle.text! == ""){
            
        }else if(featDesc.text! == "Feature Description" || featDesc.text! == ""){
            
        }else{
            
            
            let defaults = UserDefaults.standard
            let str = defaults.value(forKey: "masterUID") as! String?
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            wsm.suggestFeature(featTitle.text!, description: featDesc.text!, profileID: str!, grpId: strGroupIDs as NSString)
        }
    }
    func suggestfeatureDelegateFunction(_ dltPhoto : SuggestFeatureResult){
        outerFeaturView.isHidden = true
    }
    //    func textViewDidEndEditing(textView: UITextView){
    //        textView.resignFirstResponder()
    //        view.endEditing(true)
    //    }
    func textViewDidBeginEditing(_ textView: UITextView){
        featDesc.text = ""
        
    }
    func modulesListDelegateFunction(_ modulesListing:TBGetGroupModuleResult)
    {
        print(modulesListing.status)
        print(modulesListing.message)
        
        mainArray = modulesListing.groupListResult as NSArray
        ModulesTableView.reloadData()
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    //    {
    //
    //        if(section == 0)
    //        {
    //            let headerView = UIView()
    //            headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50)
    //            headerView.backgroundColor = UIColor.whiteColor()
    //
    //            let label = UILabel()
    //            label.frame = CGRectMake(10, 10, 200, 30)
    //            label.text = "Modules"
    //            label.textColor = UIColor.darkGrayColor()
    //            label.font = UIFont(name: "Open Sans-semibold", size: 18)
    //            headerView.addSubview(label)
    //
    //            return headerView
    //        }
    //        else
    //        {
    //            return nil
    //        }
    //    }
    
    
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        if(section == 0)
    //        {
    //            return 50
    //        }
    //        else
    //        {
    //            return 0
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return mainArray.count
        }
        else
        {
            return 0     // 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.section == 0)
        {
            return 50
        }
        else
        {
            return 88
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(indexPath.section == 0)
        {
            let cell = ModulesTableView.dequeueReusableCell(withIdentifier: "cellNew", for: indexPath) as! ModulesListCell
            
            var modulesList = GroupList()
            modulesList = mainArray.object(at: indexPath.row) as! GroupList
            
            cell.modulesLabel.text = modulesList.moduleName
            // cell.modulesInfoButton.addTarget(self, action: #selector(SelectModulesController.ModuleInfoAction), forControlEvents: UIControl.Event.TouchUpInside)
            cell.moduleInfo = modulesList.moduleInfo as! NSString
            cell.delegates=self
            if(self.moduleIds.count>0){
                if   (self.moduleIds.contains(modulesList.moduleID)){
                    //  print("yes it exists")
                    cell.modulesLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
                    cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                }else{
                    
                    cell.modulesLabel.textColor = UIColor(red: (184/255.0), green: (184/255.0), blue: (184/255.0), alpha: 1.0)
                    cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                    // print("no")
                }
            }
            
            
            return cell
        }
        else
        {
            let cell = ModulesTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FooterCell
            
            cell.typeMemberField.delegate = self
            
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ModulesTableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.section == 0)
        {
            
            var modulesList = GroupList()
            modulesList = mainArray.object(at: indexPath.row) as! GroupList
            
            
            let cell : ModulesListCell = tableView.cellForRow(at: indexPath) as! ModulesListCell
            
            if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
                //do something here
                cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                print("inside if")
                
                moduleIds.remove(modulesList.moduleID)
                
                cell.modulesLabel.textColor = UIColor(red: (184/255.0), green: (184/255.0), blue: (184/255.0), alpha: 1.0)
                
                //           groupIds.removeObject(modulesList.groupId)
                
                print(moduleIds)
                
            }else{
                
                moduleIds.add(modulesList.moduleID)
                //            groupIds.addObject(modulesList.groupId)
                
                cell.modulesLabel.textColor = UIColor(red: (76/255.0), green: (175/255.0), blue: (80/255.0), alpha: 1.0)
                
                print(moduleIds)
                
                cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
                print("inside else")
            }
            
            
            strModuleIDs = moduleIds.componentsJoined(by: ",")
            //            strGroupIDs = groupIds.componentsJoinedByString(",")
            print(strModuleIDs)
            
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if(textField == featTitle){
            
        }else{
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: -210 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
        }
        // }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(textField == featTitle){
            
        }else{
            UserDefaults.standard.set(textField.text, forKey: "NoOfMembers")
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                {
                    
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    
                }, completion: { finished in
                    
            })
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    func addModulesDelegateFunction(_ addModules : TBAddModuleResult)
    {
        print(addModules.status)
        print(addModules.message)
        
        if addModules.status == "0"
        {
            let grpVC = self.storyboard!.instantiateViewController(withIdentifier: "group_created") as! GroupCreatedScreenController
            grpVC.GroupID = addModules.grpID
            grpVC.GroupName = addModules.grpname
            grpVC.GroupImage = addModules.grpImg //nameTitles[indexPath.row]
            grpVC.trialMessage = addModules.trialMsg as! NSString
            self.navigationController?.pushViewController(grpVC, animated: true)
            
        }
        
    }
    
    
    @IBAction func NextButtonAction(_ sender: AnyObject)
    {
        let defaults = UserDefaults.standard
        let str = defaults.value(forKey: "masterUID") as! String?
        
        print(strModuleIDs)
        print(strGroupIDs)
        
        
        //        print(NoOfMembers)
        
        if strModuleIDs == ""
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Rotary India"
            alertView.message = "Please select atleast one module"
            alertView.delegate = self
            alertView.addButton(withTitle: "Ok")
            alertView.show()
        }
        else
        {
            let wsm : WebserviceClass = WebserviceClass.sharedInstance
            wsm.delegates = self
            wsm.getAddModules(strGroupIDs, moduleIDs: strModuleIDs, userID: str! , noOfmember: "")
        }
        //// Important
        /*
         if let NoOfMembers = NSUserDefaults.standardUserDefaults().stringForKey("NoOfMembers")
         {
         let wsm : WebserviceClass = WebserviceClass.sharedInstance
         wsm.delegates = self
         wsm.getAddModules(strGroupIDs, moduleIDs: strModuleIDs, userID: str! , noOfmember: NoOfMembers)
         }
         else
         {
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Rotary India"
         alertView.message = "Please enter no. of Members"
         alertView.delegate = self
         alertView.addButtonWithTitle("Okay")
         alertView.show()
         }
         */
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("group_created") as UIViewController, animated: true) //
    }
    func moduleInfoclk(_ moduleInfo:NSString,modNAme:NSString){
        //        let alertView:UIAlertView = UIAlertView()
        //        alertView.title = modNAme as String
        //        alertView.message = moduleInfo as String
        //        alertView.delegate = self
        //        alertView.addButtonWithTitle("Ok")
        //        alertView.show()
        print("moduleInfo \(moduleInfo)")
       /* let alert = UIAlertController(title: modNAme as String, message: moduleInfo as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
        //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler:{ (ACTION :UIAlertAction!)in
        //    println("User click Ok button")
        // }))
        self.presentViewController(alert, animated: true, completion: nil)
        */
        
        self.view.makeToast(moduleInfo as String, duration: 2, position: CSToastPositionCenter)

        
    }
    
    func ModuleInfoAction()
    {
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Events Info"
        alertView.message = "Have reminders for events, such as weekly club and committee meetings and even be able to RSVP and tally attendees. Have reminders for events, such as weekly club and committee meetings and even be able to RSVP and tally attedees."
        alertView.delegate = self
        alertView.addButton(withTitle: "Ok")
        alertView.show()
    }
    
}

