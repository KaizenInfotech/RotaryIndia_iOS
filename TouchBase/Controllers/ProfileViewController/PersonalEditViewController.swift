
//
//  PersonalEditViewController.swift
//  TouchBase
//
//  Created by Umesh on 22/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class PersonalEditViewController: UIViewController,webServiceDelegate , uploadDocDelegate , UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate{
    let bounds = UIScreen.main.bounds
    var appDelegate : AppDelegate = AppDelegate()
    var personalDetailsArray = NSArray()
    var cellArray:NSMutableArray!
    var dataArray:NSMutableArray!
    var profileId:NSString!
    var varISSecondaryMobileNumberEntered:Int=0
    var varIsCountryCodeSelected:Int=0

    @IBOutlet var ProfileTableView: UITableView!
    var dictnry:Dictionary<String,NSMutableArray>!
   // let bounds = UIScreen.mainScreen().bounds
    var picker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var myview = UIView()
     var pickerDataSource = ["O +ve","O -ve", "A +ve","A -ve","AB +ve", "AB -ve", "B +ve","B -ve"];
    var pickerView:UIPickerView!
    var isCalledFrom:String!=""
    
    var positionTOscroll : Int!
    var positionSelected : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.setStyle()
        createNavigationBar()
        createCellArray()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)  {
        let defaults = UserDefaults.standard
        let country =  defaults.object(forKey: "countryCode1") as! String
        if country != ""
        {
            
            //print(positionSelected)
           // positionSelected = 1
            
            let cell = cellArray.object(at: positionSelected) as! PersonalEditCell
            cell.countryInputText.text = country as? String
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "countryName")
            defaults.set("", forKey: "countryCode1")
            defaults.set("", forKey: "countryId")
            defaults.synchronize()
        }
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title="Profile"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(PersonalEditViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.right
        buttonlog.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
        buttonlog.setTitle("SAVE",  for: UIControl.State.normal)
       // buttonlog.setImage(UIImage(named: "edit"), forState: UIControl.State.Normal)
        buttonlog.addTarget(self, action: #selector(PersonalEditViewController.editClicked), for: UIControl.Event.touchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
        
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func editClicked()
    {
        print(cellArray)
        //else{
        
        createArrayResponse()
       
       // }
    }
    func updatepersonalProfileSucc(_ docListing : UserResult){
        if(docListing.status == "0"){
             self.navigationController?.popViewController(animated: true)
        }else{
           /* let alert = UIAlertController(title: "Failed, Please try again later", message: "Please try again later", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)*/
            self.view.makeToast("Failed, Please try again later", duration: 2, position: CSToastPositionCenter)

        }
    }
    func createCellArray(){
        cellArray=NSMutableArray()
        cellArray.removeAllObjects()
        for index in 0 ..< personalDetailsArray.count {
            
            let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "PersonalEditCell") as! PersonalEditCell
            //mobileCell
        
            
            print(isCalledFrom)
            
            /*-----------------------------------------------------------------*/

            if(isCalledFrom == "Personal")
            {
            var grp:PersonalMemberDetil!
                grp=personalDetailsArray[index] as! PersonalMemberDetil
                if(grp.colType == "mobile")
                {
                    cell.countryInputText.isHidden = false
                    cell.profileInputText.translatesAutoresizingMaskIntoConstraints = true
                   cell.profileInputText.frame=CGRect(x: 80, y: 32, width: (bounds.size.width-90), height: 30)
                    cell.countryInputText.translatesAutoresizingMaskIntoConstraints = true
                    cell.countryInputText.frame=CGRect(x: 10, y: 32, width: 60, height: 30)
                    print("This is value:---->")
                    print(grp.value)
                    
                    
                    if(grp.value != "")
                    {
                        let str = grp.value.trimmingCharacters(in: CharacterSet.whitespaces)
                        print(str)
                        var myStringArr = str.components(separatedBy: " ")
                    if(myStringArr.count == 2)
                    {
                    cell.profileInputText.text = myStringArr[1]
                        
                        
                        if(myStringArr[0] .hasPrefix("+"))
                        {
                            cell.countryInputText.text = myStringArr[0]
                        }
                        else
                        {
                            cell.countryInputText.text = "+"+myStringArr[0]
                        }
                        
                   // cell.countryInputText.text = myStringArr[0]
                       // varIsCountryCodeSelected=1
                        print(myStringArr[0])
                        print(myStringArr[1])
                    }
                    else if(myStringArr.count == 1)
                    {
                        print( myStringArr)

                        if(myStringArr==[""])
                        {
                            
                        }
                        else
                        {
                         print( myStringArr)
 print( myStringArr[1])
                        
                        
                        cell.profileInputText.text = myStringArr[1]
                        
                        
                        if(myStringArr[0] .hasPrefix("+"))
                        {
                        cell.countryInputText.text = myStringArr[0]
                        }
                        else
                        {
                          cell.countryInputText.text = "+"+myStringArr[0]
                        }
                        }
                       // varIsCountryCodeSelected=1
                       // print(myStringArr[0])
                       // print(myStringArr[1])
                    }
                     

                    }
                }
                else
                {
                    cell.countryInputText.isHidden = true
                    cell.profileInputText.translatesAutoresizingMaskIntoConstraints = true
                    cell.profileInputText.frame=CGRect(x: 10, y: 32, width: (bounds.size.width-20), height: 30)
                    cell.profileInputText.text = grp.value
                }
            
            cell.ProfileLabel.text = grp.key
            
            cell.uniquekey=grp.uniquekey as! NSString
            cell.colType=grp.colType as! NSString
            cell.profileInputText.tag=index
                cell.countryInputText.tag=index
                if(grp.uniquekey == "member_mobile_no"){
                    cell.countryInputText.isEnabled = false
                    cell.profileInputText.isEnabled = false
                }else{
                    cell.profileInputText.isEnabled = true
                    cell.countryInputText.isEnabled = true
                }
                
                
            cellArray.add(cell)
                
            }
        /*-----------------------------------------------------------------*/
            
            
            else{
                
                var grp:BusinessMemberDetail!
                grp=personalDetailsArray[index] as! BusinessMemberDetail
                if(grp.colType == "mobile"){
                    cell.countryInputText.isHidden = false
                    cell.profileInputText.translatesAutoresizingMaskIntoConstraints = true
                    cell.profileInputText.frame=CGRect(x: 80, y: 32, width: (bounds.size.width-90), height: 30)
                    cell.countryInputText.translatesAutoresizingMaskIntoConstraints = true
                    cell.countryInputText.frame=CGRect(x: 10, y: 32, width: 60, height: 30)
                    if(grp.value != ""){
                        
                        var myStringArr = grp.value.components(separatedBy: " ")
                        if(myStringArr.count == 2){
                            cell.profileInputText.text = myStringArr[1]
                            cell.countryInputText.text = myStringArr[0]
                        }else if(myStringArr.count == 1){
                            cell.profileInputText.text = myStringArr[0]
                        }
                        
                    }
                }else{
                    cell.countryInputText.isHidden = true
                    cell.profileInputText.translatesAutoresizingMaskIntoConstraints = true
                    cell.profileInputText.frame=CGRect(x: 10, y: 32, width: (bounds.size.width-20), height: 30)
                    cell.profileInputText.text = grp.value
                }

                
                cell.ProfileLabel.text = grp.key
               
                cell.uniquekey=grp.uniquekey as! NSString
                cell.colType=grp.colType as! NSString
                cell.profileInputText.tag=index
                cell.countryInputText.tag=index
                cellArray.add(cell)
            }
        }
        ProfileTableView.reloadData()
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cellArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        return cellArray.object(at: indexPath.row) as! PersonalEditCell

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func createArrayResponse(){
        dataArray=NSMutableArray()
        var varISAnyFieldBlank:Int=1
        for index in 0 ..< personalDetailsArray.count {
             let cell = cellArray.object(at: index) as! PersonalEditCell
            var dictnry:Dictionary<String,String>
            let colty:String!=String(format: "%@",cell.colType! as String)
            
            let unikey:String!=String(format: "%@",cell.uniquekey! as String)
            if(cell.uniquekey! == "member_name" ){
                if(cell.profileInputText.text! == ""){
                   /* let alert = UIAlertController(title: "", message: "Please enter the Name", preferredStyle: UIAlertController.Style.Alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
                    self.presentViewController(alert, animated: true, completion: nil)*/
                    self.view.makeToast("Please enter the Name", duration: 2, position: CSToastPositionCenter)

                    varISAnyFieldBlank=0
                    break;
                }
            }
            if(cell.uniquekey! == "member_email_id" ){
                if(cell.profileInputText.text != ""){
            let isValid = isValidEmail(cell.profileInputText.text!)
            if(isValid == false){
                /*
                let alert = UIAlertController(title: "", message: "Please enter a valid Email Address", preferredStyle: UIAlertController.Style.Alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
                self.presentViewController(alert, animated: true, completion: nil)*/
                
                self.view.makeToast("Please enter a valid Email Address", duration: 2, position: CSToastPositionCenter)

                
                
                varISAnyFieldBlank=0
                break;
            }
                else
            {
                
            }
            }
        }
            if(cell.uniquekey! == "member_buss_email" ){
                 if(cell.profileInputText.text != ""){
                let isValid = isValidEmail(cell.profileInputText.text! )
                if(isValid == false){
                    /*
                    let alert = UIAlertController(title: "", message: "Please enter a valid Email Address", preferredStyle: UIAlertController.Style.Alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.Cancel, handler:nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    */
                    
                    self.view.makeToast("Please enter a valid Email Address", duration: 2, position: CSToastPositionCenter)

                    
                    
                    
                    varISAnyFieldBlank=0
                    break;
                }
                }
            }
            //member_buss_email
            if(colty == "Date"){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd"
                if(cell.profileInputText.text != "" && cell.profileInputText.text! != "00/00/0000"){
                let datstr = dateFormatter.date(from: cell.profileInputText.text!)
               let strDate1 = dateFormatter1.string(from: datstr!)
                dictnry = ["value":strDate1,"key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
                }else{
                    dictnry = ["value":"","key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
                }
                
            }
         /*---------------------------------------------------------------*/
            else if(colty  == "mobile")
            {
                if(cell.uniquekey == "member_mobile_no")
                {
                   dictnry = ["value":cell.profileInputText.text!,"key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
                }
                else
                {
                    
                    
                    
                    let str = String(format: "%@ %@",cell.countryInputText.text!,cell.profileInputText.text!)
                    dictnry = ["value":str,"key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
                    var varGetValuess:Int=(cell.ProfileLabel.text?.characters.count)!
                    let strcheck = str.trimmingCharacters(in: CharacterSet.whitespaces)as NSString
                    
                    print(cell.countryInputText.text!)
                    print(cell.profileInputText.text!)
                    
                    var varGetCountryId:String!=cell.countryInputText.text!
                    var varGetCountryMobileNo:String!=cell.profileInputText.text!

                    if(varGetCountryId.characters.count>0)
                    {
                      varIsCountryCodeSelected=1
                    }
                    if(varGetCountryMobileNo.characters.count>0)
                    {
                        varISSecondaryMobileNumberEntered=1
                    }

                    print(dictnry)
                }
         /*---------------------------------------------------------------*/
            }
                
            else if(colty == "bloodGroup"){
               
             let   newString = cell.profileInputText.text!.replacingOccurrences(of: "+",
                                                                     with: "%2B",
                                                                     options: .caseInsensitive,
                                                                     range: nil)
                dictnry = ["value":newString,"key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
            
            }
            else{
                dictnry = ["value":cell.profileInputText.text!,"key":cell.ProfileLabel.text!,"uniquekey":unikey,"colType":colty]
            }
            dataArray.add(dictnry)
        }
        print(dataArray)
        
        if(varISAnyFieldBlank==0)
        {
           print("any field empty here")
        }
        else{
          
            var varCaseForSecondaryMobileNumber:String!="yes"
       if(varISSecondaryMobileNumberEntered==1)
       {
        if(varIsCountryCodeSelected==1)
        {
         varCaseForSecondaryMobileNumber="yes"
        }
        else
        {
            varCaseForSecondaryMobileNumber="no"
            /*
            let alert = UIAlertController(title: "Message", message: "Please Select Country Code", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            self.view.makeToast("Please Select Country Code", duration: 2, position: CSToastPositionCenter)

        }
       }
      else
       {
        if(varIsCountryCodeSelected==0)
        {
            varCaseForSecondaryMobileNumber="yes"
        }
        else
        {
            varCaseForSecondaryMobileNumber="no"
            /*
            let alert = UIAlertController(title: "Message", message: "Please Enter secondary mobile No.", preferredStyle: UIAlertController.Style.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
            
            self.view.makeToast("Please Enter secondary mobile No.", duration: 2, position: CSToastPositionCenter)

            
        }
       }
            
            print(varCaseForSecondaryMobileNumber)
            print(varISSecondaryMobileNumberEntered)
            print(varIsCountryCodeSelected)


            
          if(varCaseForSecondaryMobileNumber=="yes")
          {
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=nil
        wsm.delegates=self
       
            print(profileId)
            print(dataArray)
            
            
        wsm.updatepersonalProfile(profileId as String, key: dataArray)
        dictnry = ["":dataArray]
             }
        }
       
    }
    func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        let width = bounds.size.width
        if(width <= 320.0)
        {
            
            if textField.tag == 3
            {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                    {
                        
                        self.view.frame = CGRect(x: self.view.frame.origin.x,y: 0 , width: self.view.frame.width, height: self.view.frame.height)
                        
                        
                    }, completion: { finished in
                        
                })
                
            }
        }
        else
        {
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let width = bounds.size.width
        if(width <= 320.0)
        {
        
            if textField.tag == 3
            {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations:
                    {
                    
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: -80 , width: self.view.frame.width, height: self.view.frame.height)
                    
                    
                    }, completion: { finished in
                    
                })
            
            }
         }
         else
         {
         }
    }
    

     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        let cell = cellArray.object(at: textField.tag) as! PersonalEditCell
        positionTOscroll = textField.tag
        positionSelected = textField.tag
        
        if(textField == cell.countryInputText ){
           // varIsCountryCodeSelected=1
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "country_code") as UIViewController, animated: true)
            return false
        }
 
        
        if(cell.colType == "Text"){
           textField.keyboardType = UIKeyboardType.default
            return true
        }
        if(cell.colType == "Number"){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            doneToolbar.barStyle = UIBarStyle.default
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(PersonalEditViewController.doneButtonAction))
            
            var items: [UIBarButtonItem]? = [UIBarButtonItem]()
            items?.append(flexSpace)
            items?.append(done)
            
            
            doneToolbar.setItems(items, animated: true)
            doneToolbar.sizeToFit()
            textField.inputAccessoryView=doneToolbar
            textField.keyboardType = UIKeyboardType.numberPad
            return true
        }
        if(cell.colType == "mobile"){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            doneToolbar.barStyle = UIBarStyle.default
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(PersonalEditViewController.doneButtonAction))
            
            var items: [UIBarButtonItem]? = [UIBarButtonItem]()
            items?.append(flexSpace)
            items?.append(done)
            
            
            doneToolbar.setItems(items, animated: true)
            doneToolbar.sizeToFit()
            textField.inputAccessoryView=doneToolbar
            textField.keyboardType = UIKeyboardType.numberPad
            return true
        }
        //mobile
        if(cell.colType == "bloodGroup"){
            PickerShowActions(textField.tag)
        }
        if(cell.colType == "Date"){
            DateTimeShowActions(textField.tag)
        }
        return false
        
    }
    @objc func doneButtonAction()
    {
        
        //mobileNumberField.resignFirstResponder()
        view.endEditing(true)
    }
    func DateTimeShowActions(_ sender:Int)
    {
        
        myview = UIView(frame: CGRect(x: 0,y: self.view.frame.height-300, width: self.view.frame.size.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);
        
        
        picker = UIDatePicker(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = sender
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.addTarget(self, action: #selector(PersonalEditViewController.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
//        let strDate = dateFormatter.stringFromDate(picker.date)
//        
//        let strSplit = strDate.characters.split(" ")
//        let Date = String(strSplit.first!)
//        let time = String(strSplit.last!)
//        
//        print(Date)
//        print(time)
        
        toolBar.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(PersonalEditViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myview.addSubview(toolBar)
        myview.addSubview(picker)
        
    }
    
    @objc func donePicker()
    {
        myview.removeFromSuperview()
        
    }
    
    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        let cell = cellArray.object(at: sender.tag) as! PersonalEditCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: sender.date)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        
        let datstr = dateFormatter1.date(from: strDate)
        let strDate1 = dateFormatter1.string(from: datstr!)
        
        
        cell.profileInputText.text=strDate1;
       
        
    }
    func PickerShowActions(_ sender:Int)
    {
        
        myview = UIView(frame: CGRect(x: 0,y: self.view.frame.height-300, width: self.view.frame.size.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);
        
        
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        self.pickerView.backgroundColor = .white
        self.pickerView.tag = sender
        self.pickerView.dataSource=self
        self.pickerView.delegate=self
        myview.addSubview(self.pickerView)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(pickerDataSource[row])
         let cell = cellArray.object(at: self.pickerView.tag) as! PersonalEditCell
         cell.profileInputText.text=pickerDataSource[row]
         myview.removeFromSuperview()
        self.pickerView.isHidden=true
       
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
