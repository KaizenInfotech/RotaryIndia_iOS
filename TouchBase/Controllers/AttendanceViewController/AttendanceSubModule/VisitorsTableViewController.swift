//
//  VisitorsTableViewController.swift
//  TouchBase
//
//  Created by rajendra on 14/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class VisitorsTableViewController: UITableViewController,UITextFieldDelegate
{
    // var objProtocol:protocolName?=nil
    // var varWhichRowClicked:String!=""
    
    var objProtocol:protocolName?=nil
    @IBOutlet weak var tableviewVisitors: UITableView!
    var varWhichRowClicked:String!=""
    var muarrayListData:NSMutableArray=NSMutableArray()
    var muDictData:NSMutableDictionary=NSMutableDictionary()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        functionForCreaqteNavigation()
        //This is for adding new Annets.... 11june 2018
        //print(muarrayListData)
        if(muarrayListData.count>0)
        {
            
        }
        else
        {
            muDictData = ["VisitorsName": "0", "Rotarian_whohas_Brought": "","FK_AttendanceID":"","PK_AttendanceVisitorID":""]
            muarrayListData.add(muDictData)
        }
        //print(muarrayListData)
        
        /*
         "VisitorsName": "vi1",
         "Rotarian_whohas_Brought": "B1"
         */
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
        str = "Visitors"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = str as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonleft.setTitle(" Cancel ",  for: UIControl.State.normal)
        buttonleft.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonleft.layer.cornerRadius = 5
        buttonleft.layer.borderWidth = 1
        buttonleft.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonleft.addTarget(self, action: #selector(VisitorsTableViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(VisitorsTableViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
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
                 "VisitorsName": "vi1",
                 "Rotarian_whohas_Brought": "B1"
                 */
                
                
                var visitors:String=muDictData.valueForKey("VisitorsName")as! String
                var rotarianwhohas:String=muDictData.valueForKey("Rotarian_whohas_Brought")as! String
                visitors = visitors.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                rotarianwhohas = rotarianwhohas.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

                if(visitors.characters.count==0 || rotarianwhohas.characters.count==0)
                {
                   isSuccessValidation=false
                    let alert = UIAlertController(title: "Rotary India", message: "Some information are missing for Visitors"+String(i), preferredStyle: UIAlertController.Style.Alert)
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
        self.objProtocol?.functionForSendingValue("Visitors", index: 7, muarrayValueGlobal: muarrayListData)
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
            return 80.0
        }
        else if(indexPath.row != 0)
        {
            return 86.0
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
                prototypeCells.labelAnnsAnnestVisitors.text="Total Visitors"
                //print(muDictData)
                prototypeCells.textfieldValue.text=String(muarrayListData.count-1)
            }
            else if(indexPath.row != 0)
            {
                
                muDictData=muarrayListData.object(at: indexPath.row) as! NSMutableDictionary
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.labelSecondAnnsAnnestVisitors.text="Visitors "+String(indexPath.row)
                prototypeCells.textfieldSecondValue.text=muDictData.value(forKey: "VisitorsName")as! String
                //add value in third textfield
                prototypeCells.textfieldThirdValue.text=muDictData.value(forKey: "Rotarian_whohas_Brought")as! String
                prototypeCells.textfieldThirdValue.autocorrectionType = .no
            }
            
            /*
             "VisitorsName": "vi1",
             "Rotarian_whohas_Brought": "B1"
             */
            
            //-1
            prototypeCells.textfieldSecondValue.tag=indexPath.row
            prototypeCells.textfieldSecondValue.delegate = self
            //0
            prototypeCells.textfieldThirdValue.tag=indexPath.row+100
            prototypeCells.textfieldThirdValue.delegate = self
            //11
            prototypeCells.buttonDecrease.addTarget(self, action: #selector(AnnetsTableViewController.buttonDecreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonDecrease.tag = indexPath.row
            
            //22
            prototypeCells.buttonIncrease.addTarget(self, action: #selector(AnnetsTableViewController.buttonIncreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonIncrease.tag = indexPath.row
            //33
            prototypeCells.buttonMinus.addTarget(self, action: #selector(AnnetsTableViewController.buttonMinusClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMinus.tag = indexPath.row
            
        }
        return prototypeCells
    }
 @objc  func buttonDecreaseClickEvent(_ sender:UIButton)
    {
        //print(muarrayListData)
        if(muarrayListData.count==1)
        {
            
        }
        else
        {
            //For delete id holding
            muDictData=muarrayListData.object(at: muarrayListData.count-1) as! NSMutableDictionary
            let PK_AttendanceVisitorID=muDictData.value(forKey: "PK_AttendanceVisitorID")as! String
            if(muarrayVisitorsServerIDDelete.contains(PK_AttendanceVisitorID))
            {
                muarrayVisitorsDelete.add(PK_AttendanceVisitorID)
            }
            //For delete id holding end
            muarrayListData.removeObject(at: muarrayListData.count-1)
            //print(muarrayListData)
            //print(muarrayVisitorsServerIDDelete)
            //print(muarrayVisitorsDelete)

           tableviewVisitors.reloadData()
        }
        
        print("This is delete id Decrease Visitors:>>>>>>>>>>>>>>>>>>>")
        print(muarrayVisitorsDelete)
        print(muarrayVisitorsServerIDDelete)

        
    }
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
    
 @objc func buttonIncreaseClickEvent(_ sender:UIButton)
    {
        //print(sender.tag)
        //print(muDictData)
        //print(muarrayListData)
        /*
         "VisitorsName": "vi1",
         "Rotarian_whohas_Brought": "B1"
         */
        muDictData = ["VisitorsName": "", "Rotarian_whohas_Brought": "","FK_AttendanceID":"","PK_AttendanceVisitorID":""]
        muarrayListData.add(muDictData)
        tableviewVisitors.reloadData()
        let indexPath = IndexPath(row: muarrayListData.count - 1, section: 0)
        self.tableviewVisitors.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
       
        
        
        
        //print(muDictData)
        //print(muarrayListData)
        
        /*
         //print(sender.tag)
         var varGetValue:String! = muarrayListData.objectAtIndex(0)as! String
         var varGetValues:Int!=Int(varGetValue)
         //print(varGetValues)
         //print(muarrayListData)
         varGetValues=varGetValues+1
         
         //print(varGetValues)
         muarrayListData.replaceObjectAtIndex(0, withObject: String(muarrayListData.count))
         //print(muarrayListData)
         //code for check how many row already , and now next increase
         muarrayListData.addObject("")
         tableviewVisitors.reloadData()
         */
    }
  @objc  func buttonMinusClickEvent(_ sender:UIButton)
    {
  
        //print(muarrayListData)
        //print(muarrayVisitorsServerIDDelete)
        //print(muarrayVisitorsDelete)
        
        //For delete id holding
        //print(muarrayListData)
        muDictData=muarrayListData.object(at: sender.tag) as! NSMutableDictionary
        let PK_AttendanceVisitorID=muDictData.value(forKey: "PK_AttendanceVisitorID")as! String
        if(muarrayVisitorsServerIDDelete.contains(PK_AttendanceVisitorID))
        {
            muarrayVisitorsDelete.add(PK_AttendanceVisitorID)
        }
        //print(muarrayVisitorsDelete)
        //For delete id holding end
        //print(sender.tag)
        muarrayListData.removeObject(at: sender.tag)
        //print(muarrayListData)
      
        
        tableviewVisitors.reloadData()
        
        print("This is delete id minus Visitors:>>>>>>>>>>>>>>>>>>>")
        print(muarrayVisitorsDelete)
        print(muarrayVisitorsServerIDDelete)

        
    }
    /////---
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prototypeCells =  tableviewVisitors.dequeueReusableCell(withIdentifier: "cell") as! AnnsAnnestVisitorsTableViewCell
        self.view.endEditing(true)
        prototypeCells.textfieldValue.resignFirstResponder()
        prototypeCells.textfieldSecondValue.resignFirstResponder()
        return false
    }
    // func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool
    {
        
        //print(textField.tag)
        
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        muDictData=NSMutableDictionary()
        muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        let varGetVisitors:String!=muDictData.value(forKey: "VisitorsName")as! String
        let varGetRotarianWhoHAsBrought:String!=muDictData.value(forKey: "Rotarian_whohas_Brought")as! String
        let FK_AttendanceID:String!=muDictData.value(forKey: "FK_AttendanceID")as! String
        let PK_AttendanceVisitorID:String!=muDictData.value(forKey: "PK_AttendanceVisitorID")as! String

        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)

        if (isBackSpace == -92)
        {
           
            //print("Backspace was pressed rajendra jat")
            if(textField.tag>100)//this is for third textfield or trotarian who has brought
            {

                muDictData = ["VisitorsName": varGetVisitors, "Rotarian_whohas_Brought": newString,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
            else
            {
                muDictData = ["VisitorsName": newString, "Rotarian_whohas_Brought": varGetRotarianWhoHAsBrought,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
        }
        else
        {
            //print("Backspace was not  pressed")
            
            //for textfield second
            if(textField.tag>100)//this is for third textfield or trotarian who has brought
            {
                muDictData = ["VisitorsName": varGetVisitors, "Rotarian_whohas_Brought": newString,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }
            else//for textfield third
            {
                muDictData = ["VisitorsName": newString, "Rotarian_whohas_Brought": varGetRotarianWhoHAsBrought,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewVisitors)
        let indexPath = tableviewVisitors.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        //print(indexPath)
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
    }

    
    
    var varSelectedTableRowIndexGet_Text:String!=""
}



//muDictData=["VisitorsName":VisitorsName,"Rotarian_whohas_Brought":Rotarian_whohas_Brought,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceVisitorID":PK_AttendanceVisitorID]
