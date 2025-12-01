//
//  RotariansOtherClubsTableViewController.swift
//  TouchBase
//
//  Created by rajendra on 16/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class RotariansOtherClubsTableViewController: UITableViewController,UITextFieldDelegate
{
    
    // var objProtocol:protocolName?=nil
    // var varWhichRowClicked:String!=""
    
    var objProtocol:protocolName?=nil
    
    @IBOutlet weak var tableviewRotarriansOtherClubs: UITableView!
    
    var varWhichRowClicked:String!=""
    var muarrayListData:NSMutableArray=NSMutableArray()
    var muDictData:NSMutableDictionary=NSMutableDictionary()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableviewRotarriansOtherClubs.separatorStyle = .none
        tableviewRotarriansOtherClubs.allowsSelection = false
        functionForCreaqteNavigation()
        //This is for adding new Annets.... 11june 2018
        //print(muarrayListData)
        if(muarrayListData.count>0)
        {
            
        }
        else
        {
            muDictData = ["RotarianID": "0", "RotarianName": "", "ClubName": "","FK_AttendanceID":"","PK_AttendanceRotarianID":""]
            muarrayListData.add(muDictData)
        }
        
        /*
         "RotarianID": "R101",
         "RotarianName": "Rot1",
         "ClubName": "Clu1"
         */
        
        
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
        str = "Rotarian's (Other Club)"
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
        buttonleft.addTarget(self, action: #selector(RotariansOtherClubsTableViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(RotariansOtherClubsTableViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
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
                 "RotarianID": "R101",
                 "RotarianName": "Rot1",
                 "ClubName": "Clu1"
                 */
                
                
                var rotarianid:String=muDictData.valueForKey("RotarianID")as! String
                var rotarianname:String=muDictData.valueForKey("RotarianName")as! String
                var clubname:String=muDictData.valueForKey("ClubName")as! String
                
                rotarianid = rotarianid.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                rotarianname = rotarianname.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                clubname = clubname.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                //print(rotarianid)
                //print(rotarianname)
                //print(clubname)
                
                if(rotarianid.characters.count==0 || rotarianname.characters.count==0 || clubname.characters.count==0 )
                {
                    isSuccessValidation=false
                    let alert = UIAlertController(title: "Rotary India", message: "Some information are missing for Rotarins"+String(i), preferredStyle: UIAlertController.Style.Alert)
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
            self.objProtocol?.functionForSendingValue("Rotarian", index: 8, muarrayValueGlobal: muarrayListData)
            self.navigationController?.popViewController(animated: true)
       /* }*/
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
            return 90.0
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
        //prototypeCells.textfieldThirdValue.isEnabled=false
        //prototypeCells.textfieldFour.isEnabled=false
        prototypeCells.textfieldFour.returnKeyType = .done
        
        if(muarrayListData.count>0)
        {
            //print(muarrayListData)
            if(indexPath.row==0)
            {
                //print(muarrayListData)
                prototypeCells.viewFirst.isHidden=false
                prototypeCells.labelAnnsAnnestVisitors.text="Total Rotarians"
                //print(muDictData)
                prototypeCells.textfieldValue.text=String(muarrayListData.count-1)
            }
            else if(indexPath.row != 0)
            {
                //print(muDictData)
                muDictData=muarrayListData.object(at: indexPath.row) as! NSMutableDictionary
                prototypeCells.viewSecond.isHidden=false
                // prototypeCells.labelSecondAnnsAnnestVisitors.text="Rotarian ID "+String(indexPath.row)
                
                //prototypeCells.labelSecondAnnsAnnestVisitors.text="Rotarian ID"
                
               // prototypeCells.textfieldSecondValue.text=muDictData.value(forKey: "RotarianID")as! String
                //add value in third textfield
                prototypeCells.textfieldThirdValue.text=muDictData.value(forKey: "RotarianName")as! String
                prototypeCells.textfieldThirdValue.autocorrectionType = .no
                //
                prototypeCells.textfieldFour.text=muDictData.value(forKey: "ClubName")as! String
                prototypeCells.textfieldFour.autocorrectionType = .no
                
            }
            
            /*
             "RotarianID": "R101",
             "RotarianName": "Rot1",
             "ClubName": "Clu1"
             */
            
            //-1
           // prototypeCells.textfieldSecondValue.tag=indexPath.row
           // prototypeCells.textfieldSecondValue.delegate = self
            //0
            prototypeCells.textfieldThirdValue.tag=indexPath.row
            prototypeCells.textfieldThirdValue.delegate = self
            //0-1
            prototypeCells.textfieldFour.tag=indexPath.row+100
            prototypeCells.textfieldFour.delegate = self
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
    
 @objc func buttonDecreaseClickEvent(_ sender:UIButton)
    {
        //print(muarrayListData)
        if(muarrayListData.count==1)
        {
            
        }
        else
        {
            //For delete id holding
            muDictData=muarrayListData.object(at: muarrayListData.count-1) as! NSMutableDictionary
            let PK_AttendanceVisitorID=muDictData.value(forKey: "PK_AttendanceRotarianID")as! String
            if(muarrayRotarianServerIDDelete.contains(PK_AttendanceVisitorID))
            {
                muarrayRotarianDelete.add(PK_AttendanceVisitorID)
            }
            //For delete id holding end
            muarrayListData.removeObject(at: muarrayListData.count-1)
            //print(muarrayListData)
            //print(muarrayRotarianServerIDDelete)
            //print(muarrayRotarianDelete)
            
            tableviewRotarriansOtherClubs.reloadData()
        }
        
        print("This is delete id Decrease Rotarian:>>>>>>>>>>>>>>>>>>>")
        print(muarrayRotarianDelete)
        print(muarrayRotarianServerIDDelete)

    }
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
   @objc func buttonIncreaseClickEvent(_ sender:UIButton)
    {
        //print(sender.tag)
        //print(muDictData)
        //print(muarrayListData)
        
        muDictData = ["RotarianID": "", "RotarianName": "", "ClubName": "","FK_AttendanceID":"","PK_AttendanceRotarianID":""]
        muarrayListData.add(muDictData)
        
        tableviewRotarriansOtherClubs.reloadData()
        let indexPath = IndexPath(row: muarrayListData.count - 1, section: 0)
        self.tableviewRotarriansOtherClubs.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        
        
        
    }
 @objc func buttonMinusClickEvent(_ sender:UIButton)
    {
        //print(muarrayListData)
        //print(muarrayVisitorsServerIDDelete)
        //print(muarrayVisitorsDelete)
        
        //For delete id holding
        //print(muarrayListData)
        muDictData=muarrayListData.object(at: sender.tag) as! NSMutableDictionary
        let PK_AttendanceRotarianID=muDictData.value(forKey: "PK_AttendanceRotarianID")as! String
        if(muarrayRotarianServerIDDelete.contains(PK_AttendanceRotarianID))
        {
            muarrayRotarianDelete.add(PK_AttendanceRotarianID)
        }
        //print(muarrayRotarianDelete)
        //For delete id holding end
        //print(sender.tag)
        muarrayListData.removeObject(at: sender.tag)
        //print(muarrayListData)
        
        tableviewRotarriansOtherClubs.reloadData()
        
        print("This is delete id minus Rotarian :>>>>>>>>>>>>>>>>>>>")
        print(muarrayRotarianDelete)
        print(muarrayRotarianServerIDDelete)

    }
    /////---
    
    var varSelectedTableRowIndexGet_Text:String!=""
    /**------------------------------------------------------------------**/
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool
    {
        //this si temp code
        varSelectedTableRowTextFieldTag=textField.tag
       // var cursorPosition:Int!=0
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        /*----*/
        muDictData=NSMutableDictionary()
        
        muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        var rotarianid:String!=muDictData.value(forKey: "RotarianID")as! String
        let rotarianname:String!=muDictData.value(forKey: "RotarianName")as! String
        let clubnames:String!=muDictData.value(forKey: "ClubName")as! String
        let FK_AttendanceID:String!=muDictData.value(forKey: "FK_AttendanceID")as! String
        let PK_AttendanceRotarianID:String!=muDictData.value(forKey: "PK_AttendanceRotarianID")as! String
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)

        //,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID

      
        if (isBackSpace == -92)
        {
            //print("Backspace was pressed rajendra jat")
            if(textField.tag>0 && textField.tag<99)
            {
                //print("This is real value after remove one character from string !!!!!")
                muDictData = ["RotarianID":rotarianid,"RotarianName":newString,"ClubName":clubnames,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
                //print(muarrayListData)
            }
            else
            {
                //print("This is real value after remove one character from string !!!!!")
                muDictData = ["RotarianID":rotarianid,"RotarianName":rotarianname,"ClubName":newString,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID]
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
                muDictData=["RotarianID":rotarianid,"RotarianName":newString,"ClubName":clubnames,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }
            else
            {
                muDictData=["RotarianID":rotarianid,"RotarianName":rotarianname,"ClubName":newString,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID]
                muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
            }

            //print(muarrayListData)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewRotarriansOtherClubs)
        let indexPath = tableviewRotarriansOtherClubs.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
    }
    /*keyboard return key event delegate*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        prototypeCells =  tableviewRotarriansOtherClubs.dequeueReusableCell(withIdentifier: "cell") as! AnnsAnnestVisitorsTableViewCell
        self.view.endEditing(true)
        prototypeCells.textfieldValue.resignFirstResponder()
        prototypeCells.textfieldSecondValue.resignFirstResponder()
        //print("This is table textfield selected index :- ",varSelectedTableRowIndex)
        
        muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        var rotarianid:String!=muDictData.value(forKey: "RotarianID")as! String
        
        rotarianid = rotarianid.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if(rotarianid.characters.count>0)
        {
            //print(rotarianid)
            /*------*/
           // functionForFetchingRotarianIDDetailData()
        }
        else
        {
           // self.view.makeToast("Please enter Rotarian ID for Rotarian ID number:- "+String(varSelectedTableRowIndex), duration: 3, position: CSToastPositionCenter)
        }
        return false
    }
    /*--calling web service for fetching Rotarian ID detail from server----*/
}
//,"FK_AttendanceID":FK_AttendanceID,"PK_AttendanceRotarianID":PK_AttendanceRotarianID
