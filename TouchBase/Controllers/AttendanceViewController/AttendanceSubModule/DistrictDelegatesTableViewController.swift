/*
 "RotarianName": "Distrot1",
 "DistrictDesignation": "Distidigi1",
 "ClubName": "Disticlkub2"
 */

import UIKit

class DistrictDelegatesTableViewController: UITableViewController,UITextFieldDelegate
{

    var objProtocol:protocolName?=nil
    @IBOutlet weak var tableviewVisitors: UITableView!
    var varWhichRowClicked:String!=""
    var muarrayListData:NSMutableArray=NSMutableArray()
    var muDictData:NSMutableDictionary=NSMutableDictionary()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableviewVisitors.separatorStyle = .none
        tableviewVisitors.allowsSelection = false
        functionForCreaqteNavigation()
        //This is for adding new Annets.... 11june 2018
        //print(muarrayListData)
        if(muarrayListData.count>0)
        {
            
        }
        else
        {
            muDictData = ["RotarianName": "0", "DistrictDesignation": "", "ClubName": "","FK_AttendanceID":"","PK_AttendanceDelegateID":""]
            muarrayListData.add(muDictData)
        }
        //print(muarrayListData)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = "District Delegates"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        // self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        buttonleft.setTitle("  Cancel  ",  for: UIControl.State.normal)
        buttonleft.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonleft.layer.cornerRadius = 5
        buttonleft.layer.borderWidth = 1
        buttonleft.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonleft.addTarget(self, action: #selector(DistrictDelegatesTableViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(DistrictDelegatesTableViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    @objc func  buttonAddClickEvent()
    {
        /*
        //print(muarrayListData)
        muDictData=NSMutableDictionary()
        //need to give validation here
        var isSuccessValidation:Bool=false
        for i in 00..<muarrayListData.count
        {
            muDictData=muarrayListData.objectAtIndex(i) as! NSMutableDictionary
            if(i==0)
            {
                //here will be happen nothing beause on first index only counting in the dictionary
                isSuccessValidation=true
            }
            else
            {
                
                
                /*
                 "RotarianName": "Distrot1",
                 "DistrictDesignation": "Distidigi1",
                 "ClubName": "Disticlkub2"
                 */
                // muDictData = ["rotarianname": varGetVisitors, "districtdesignation": varGetStringAfterRemove, "clubname": ""]
                var visitors:String=muDictData.valueForKey("RotarianName")as! String
                var rotarianwhohas:String=muDictData.valueForKey("DistrictDesignation")as! String
                var clubname:String=muDictData.valueForKey("ClubName")as! String
                
                
                
                
                
                visitors = visitors.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                rotarianwhohas = rotarianwhohas.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                clubname = clubname.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                //print(visitors)
                //print(rotarianwhohas)
                //print(clubname)
                
                
                if(visitors.characters.count==0 || rotarianwhohas.characters.count==0 || clubname.characters.count==0 )
                {
                    isSuccessValidation=false
                    let alert = UIAlertController(title: "Rotary India", message: "Some information are missing for Rotarins ID "+String(i), preferredStyle: UIAlertController.Style.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Cancel, handler:nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                    //self.present(alert, animated: true)
                }
                else
                {
                    isSuccessValidation=true
                }
                
            }
        }
        
        
        if(isSuccessValidation==true)
        {
            */
            self.objProtocol?.functionForSendingValue("District Delegates", index: 9, muarrayValueGlobal: muarrayListData)
            self.navigationController?.popViewController(animated: true)
            
            
        /*}*/
    }
     @objc func backClicked()
    {
        //print("add")
        self.navigationController?.popViewController(animated: true)
    }
    /*-tableview delegate code here-*/
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row==0)
        {
            return 82.0
        }
        else if(indexPath.row != 0)
        {
            return 127.0
        }
        return 0
    }
    
    var prototypeCells:AnnsAnnestVisitorsTableViewCell=AnnsAnnestVisitorsTableViewCell()
    let reuseIdentifier = "cell"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! AnnsAnnestVisitorsTableViewCell
        prototypeCells.viewFirst.isHidden=true
        prototypeCells.viewSecond.isHidden=true
        if(muarrayListData.count>0)
        {
            //print(muarrayListData)
            if(indexPath.row==0)
            {
                //print(muarrayListData)
                prototypeCells.viewFirst.isHidden=false
                prototypeCells.labelAnnsAnnestVisitors.text="Total Delegates"
                //print(muDictData)
                prototypeCells.textfieldValue.text=String(muarrayListData.count-1)
            }
            else if(indexPath.row != 0)
            {
                //print(muDictData)
                muDictData=muarrayListData.object(at: indexPath.row) as! NSMutableDictionary
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.labelSecondAnnsAnnestVisitors.text="Rotarian Name "+String(indexPath.row)
                prototypeCells.textfieldSecondValue.text=muDictData.value(forKey: "RotarianName")as! String
                //add value in third textfield
                prototypeCells.textfieldThirdValue.text=muDictData.value(forKey: "DistrictDesignation")as! String
                prototypeCells.textfieldThirdValue.autocorrectionType = .no
                //
                prototypeCells.textfieldFour.text=muDictData.value(forKey: "ClubName")as! String
                prototypeCells.textfieldFour.autocorrectionType = .no
                //// muDictData = ["rotarianname": varGetVisitors, "districtdesignation": varGetStringAfterRemove, "clubname": ""]
            }
            
            /*
             "RotarianName": "Distrot1",
             "DistrictDesignation": "Distidigi1",
             "ClubName": "Disticlkub2"
             */
            
            
            
            //-1
            prototypeCells.textfieldSecondValue.tag=indexPath.row
            prototypeCells.textfieldSecondValue.delegate = self
            //0
            prototypeCells.textfieldThirdValue.tag=indexPath.row+100
            prototypeCells.textfieldThirdValue.delegate = self
            //0-1
            prototypeCells.textfieldFour.tag=indexPath.row+200
            prototypeCells.textfieldFour.delegate = self
            //11
            prototypeCells.buttonDecrease.addTarget(self, action: #selector(AnnetsTableViewController.buttonDecreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonDecrease.tag = indexPath.row
            
            //22
            prototypeCells.buttonIncrease.addTarget(self, action: #selector(AnnetsTableViewController.buttonIncreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonIncrease.tag = indexPath.row
            //33
            prototypeCells.buttonMinus.addTarget(self, action: #selector(buttonMinusClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMinus.tag = indexPath.row
            
        }
        return prototypeCells
    }
   @objc func buttonDecreaseClickEvent(_ sender:UIButton)
    {
        /*
        //print(sender.tag)
        let varGetValue:String! = muarrayListData.object(at: 0)as! String
        var varGetValues:Int!=Int(varGetValue)
        //print(varGetValues)
        if(varGetValues==0)
        {
            
        }
        else
        {
            //print(muarrayListData)
            //print(muarrayListData.count)
            muarrayListData.removeObject(at: muarrayListData.count-1)
            //print(muarrayListData.count)
            varGetValues=varGetValues-1
            if(muarrayListData.count==1)
            {
                muarrayListData.replaceObject(at: 0, with: String(0))
            }
            else
            {
                muarrayListData.replaceObject(at: 0, with: String(muarrayListData.count-1))
            }
            tableviewVisitors.reloadData()
        }
        */
        //print(muarrayListData)
        if(muarrayListData.count==1)
        {
            
        }
        else
        {
            //For delete id holding
            muDictData=muarrayListData.object(at: muarrayListData.count-1) as! NSMutableDictionary
            let PK_AttendanceVisitorID=muDictData.value(forKey: "PK_AttendanceDelegateID")as! String
            if(muarrayDistrictDelegatesServerIDDelete.contains(PK_AttendanceVisitorID))
            {
                muarrayDistrictDelegatesDelete.add(PK_AttendanceVisitorID)
            }
            //For delete id holding end
            muarrayListData.removeObject(at: muarrayListData.count-1)
            //print(muarrayListData)
            //print(muarrayDistrictDelegatesServerIDDelete)
            //print(muarrayDistrictDelegatesDelete)
            
            tableviewVisitors.reloadData()
        }
        
        print("This is delete id Decrease District Delegates:>>>>>>>>>>>>>>>>>>>")
        print(muarrayDistrictDelegatesDelete)
        print(muarrayDistrictDelegatesServerIDDelete)

        
        
        
        
        
    }
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
    
 @objc func buttonIncreaseClickEvent(_ sender:UIButton)
    {
        //print(sender.tag)
        //print(muDictData)
        //print(muarrayListData)
        muDictData = ["RotarianName": "", "DistrictDesignation": "", "ClubName": "","FK_AttendanceID":"","PK_AttendanceDelegateID":""]
        muarrayListData.add(muDictData)
        tableviewVisitors.reloadData()
        let indexPath = IndexPath(row: muarrayListData.count - 1, section: 0)
        self.tableviewVisitors.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        
        
    }
   @objc func buttonMinusClickEvent(_ sender:UIButton)
    {
        /*
        muarrayListData.removeObject(at: sender.tag)
        //print(muarrayListData.count)
        tableviewVisitors.reloadData()
        */
        //print(muarrayListData)
        //print(muarrayVisitorsServerIDDelete)
        //print(muarrayVisitorsDelete)
        
        //For delete id holding
        //print(muarrayListData)
        muDictData=muarrayListData.object(at: sender.tag) as! NSMutableDictionary
        let PK_AttendanceVisitorID=muDictData.value(forKey: "PK_AttendanceDelegateID")as! String
        if(muarrayDistrictDelegatesServerIDDelete.contains(PK_AttendanceVisitorID))
        {
            muarrayDistrictDelegatesDelete.add(PK_AttendanceVisitorID)
        }
        //print(muarrayDistrictDelegatesDelete)
        //For delete id holding end
        //print(sender.tag)
        muarrayListData.removeObject(at: sender.tag)
        //print(muarrayListData)
        
        
        tableviewVisitors.reloadData()
        
        print("This is delete id minus District Delegates:>>>>>>>>>>>>>>>>>>>")
        print(muarrayDistrictDelegatesDelete)
        print(muarrayDistrictDelegatesServerIDDelete)

        
        
        
    }
    /////---
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prototypeCells =  tableviewVisitors.dequeueReusableCell(withIdentifier: "cell") as! AnnsAnnestVisitorsTableViewCell
        self.view.endEditing(true)
        prototypeCells.textfieldValue.resignFirstResponder()
        prototypeCells.textfieldSecondValue.resignFirstResponder()
        return false
    }
    var varSelectedTableRowIndexGet_Text:String!=""
    /**------------------------------------------------------------------**/
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool
    {
        //this si temp code
        varSelectedTableRowTextFieldTag=textField.tag
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        /*----*/
        muDictData=NSMutableDictionary()
        
        muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        let rotarianname:String!=muDictData.value(forKey: "RotarianName")as! String
        let districtdesignation:String!=muDictData.value(forKey: "DistrictDesignation")as! String
        let clubnames:String!=muDictData.value(forKey: "ClubName")as! String
        let FK_AttendanceID:String!=muDictData.value(forKey: "FK_AttendanceID")as! String
        let PK_AttendanceDelegateID:String!=muDictData.value(forKey: "PK_AttendanceDelegateID")as! String
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)


      
        if (isBackSpace == -92)
        {
            //print("Backspace was pressed rajendra jat")
            
           // let firstCharacter = rotarianname[index]
            if(textField.tag>0 && textField.tag<99)
            {
                //print("This is real value after remove one character from string !!!!!")
                muDictData = [
                              "RotarianName": newString,
                              "DistrictDesignation": districtdesignation,
                              "ClubName": clubnames ,
                              "FK_AttendanceID":FK_AttendanceID,
                              "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
            else   if(textField.tag>100 && textField.tag<199)//this is for third textfield or trotarian who has brought
            {
               
                //print("This is real value after remove one character from string !!!!!")
                muDictData = [
                    "RotarianName": rotarianname,
                    "DistrictDesignation": newString,
                    "ClubName": clubnames ,
                    "FK_AttendanceID":FK_AttendanceID,
                    "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
            
            if(textField.tag>199 && textField.tag<299)//this is for third textfield or trotarian who has brought
            {
              
                //print("This is real value after remove one character from string !!!!!")
                muDictData = [
                    "RotarianName": rotarianname,
                    "DistrictDesignation": districtdesignation,
                    "ClubName": newString ,
                    "FK_AttendanceID":FK_AttendanceID,
                    "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
        }
        else
        {
            //print("Backspace was not  pressed")
            //for textfield second
            //print("This is index value now!!!")
            //print(varSelectedTableRowTextFieldTag)
            if(textField.tag>0 && textField.tag<99)
            {
                //print("else 3333")
                muDictData = [
                    "RotarianName": newString,
                    "DistrictDesignation": districtdesignation,
                    "ClubName": clubnames ,
                    "FK_AttendanceID":FK_AttendanceID,
                    "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }
            else if(textField.tag>100 && textField.tag<199)//this is for third textfield or trotarian who has brought
            {
                //print("if 1111")
                muDictData = [
                    "RotarianName": rotarianname,
                    "DistrictDesignation":newString,
                    "ClubName": clubnames ,
                    "FK_AttendanceID":FK_AttendanceID,
                    "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }
            else if(textField.tag>199 && textField.tag<299)//this is for third textfield or trotarian who has brought
            {
                //print("else  2222")
                muDictData = [
                    "RotarianName": rotarianname,
                    "DistrictDesignation": districtdesignation,
                    "ClubName": newString,
                    "FK_AttendanceID":FK_AttendanceID,
                    "PK_AttendanceDelegateID":PK_AttendanceDelegateID
                ]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }

            //,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceDelegateID":PK_AttendanceDelegateID
            //print(muarrayListData)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewVisitors)
        let indexPath = tableviewVisitors.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
    }
}

   
