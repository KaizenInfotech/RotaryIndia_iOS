import UIKit
class AnnetsTableViewController: UITableViewController,UITextFieldDelegate
{
    var objProtocol:protocolName?=nil
    var varWhichRowClicked:String!=""
    @IBOutlet weak var tableviewAnns: UITableView!
    var muarrayListDataassentsTemp:NSMutableArray=NSMutableArray()
    var muDictData:NSMutableDictionary=NSMutableDictionary()
    var varSelectedTableRowIndexGet_Text:String!=""
    var prototypeCells:AnnsAnnestVisitorsTableViewCell=AnnsAnnestVisitorsTableViewCell()
    let reuseIdentifier = "cell"
    
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
    
    
    //temp array
    var muTempLocal:NSMutableArray=NSMutableArray()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        functionForCreaqteNavigation()
        //This is for adding new Annets.... 11june 2018
        //print(muarrayListData)
        if(muarrayListDataassentsTemp.count>0)
        {
            
        }
        else
        {
            muDictData = ["AnnetsName": "0", "FK_AttendanceID": "","PK_AttendanceAnnetsID":""]
            muarrayListDataassentsTemp.add(muDictData)
        }
        print(muDictData)
        muTempLocal=muarrayListDataassentsTemp
        print(muTempLocal)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
   @objc func  buttonAddClickEvent()
    {
        //print(muarrayListData)
        self.objProtocol?.functionForSendingValue("Annets", index: 6, muarrayValueGlobal: muarrayListDataassentsTemp)
        self.navigationController?.popViewController(animated: true)
    }
     @objc func backClicked()
    {
        print(muTempLocal)
        //UserDefaults.standard.set(myarrayHoldAnnets, forKey: "session_arrayValue")
        print(UserDefaults.standard.object(forKey: "session_arrayValue") as Any)
        
        
        
        
        //print("add")
        print(muDictData)
        print(muarrayListDataassentsTemp)
        muarrayListDataassentsTemp=NSMutableArray()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = "Annets"
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
        buttonleft.addTarget(self, action: #selector(NewEventAttendanceViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(NewEventAttendanceViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row==0)
        {
            return 80.0
        }
        else if(indexPath.row != 0)
        {
            return 66.0
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayListDataassentsTemp.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! AnnsAnnestVisitorsTableViewCell
        prototypeCells.viewFirst.isHidden=true
        prototypeCells.viewSecond.isHidden=true
        if(muarrayListDataassentsTemp.count>0)
        {
            //print(muarrayListData)
            if(indexPath.row==0)
            {
                //print(muarrayListData)
                prototypeCells.viewFirst.isHidden=false
                prototypeCells.labelAnnsAnnestVisitors.text="Total Annets"
                prototypeCells.textfieldValue.text=String(muarrayListDataassentsTemp.count-1)
            }
            else if(indexPath.row != 0)
            {
                //print(muarrayListData)
                //print(muarrayListData.object(at: indexPath.row))
                muDictData=muarrayListDataassentsTemp.object(at: indexPath.row) as! NSMutableDictionary
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.labelSecondAnnsAnnestVisitors.text="Annets "+String(indexPath.row)
                prototypeCells.textfieldSecondValue.text=muDictData.value(forKey: "AnnetsName")as! String
                // muDictData = ["AnnetsName": "0", "FK_AttendanceID": "","PK_AttendanceAnnetsID":""]
            }
            
            //0
            prototypeCells.textfieldSecondValue.tag=indexPath.row
            prototypeCells.textfieldSecondValue.delegate = self
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
        if(muarrayListDataassentsTemp.count==1)
        {
            
        }
        else
        {
            //For delete id holding
            muDictData=muarrayListDataassentsTemp.object(at: muarrayListDataassentsTemp.count-1) as! NSMutableDictionary
            let PK_AttendanceAnnetsID=muDictData.value(forKey: "PK_AttendanceAnnetsID")as! String
            if(muarrayAnnetsServerIDDelete.contains(PK_AttendanceAnnetsID))
            {
                muarrayAnnetsDelete.add(PK_AttendanceAnnetsID)
            }
            //For delete id holding end
            muarrayListDataassentsTemp.removeObject(at: muarrayListDataassentsTemp.count-1)
            //print(muarrayListData)
            //print(muarrayAnnetsServerIDDelete)
            //print(muarrayAnnetsDelete)
            tableviewAnns.reloadData()
        }
        print("This is delete id Decrease Annets:>>>>>>>>>>>>>>>>>>>")
        print(muarrayAnnetsDelete)
        print(muarrayAnnetsServerIDDelete)
        
    }
    
 @objc   func buttonIncreaseClickEvent(_ sender:UIButton)
    {
        
        print(muTempLocal)
        print(muTempLocal.count)
        
        
        
        muDictData = ["AnnetsName": "", "FK_AttendanceID": "","PK_AttendanceAnnetsID":""]
        muarrayListDataassentsTemp.add(muDictData)
        print(muTempLocal)
        print(muTempLocal.count)
        
        tableviewAnns.reloadData()
        
        print(muTempLocal)
        print(muTempLocal.count)
        
        
        let indexPath = IndexPath(row: muarrayListDataassentsTemp.count - 1, section: 0)
        self.tableviewAnns.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        print(muTempLocal)
        print(muTempLocal.count)
        
        
    }
    @objc func buttonMinusClickEvent(_ sender:UIButton)
    {
        
        muDictData=muarrayListDataassentsTemp.object(at: sender.tag) as! NSMutableDictionary
        let PK_AttendanceAnnsID=muDictData.value(forKey: "PK_AttendanceAnnetsID")as! String
        if(muarrayAnnetsServerIDDelete.contains(PK_AttendanceAnnsID))
        {
            muarrayAnnetsDelete.add(PK_AttendanceAnnsID)
        }
        muarrayListDataassentsTemp.removeObject(at: sender.tag)
        tableviewAnns.reloadData()
        
        
        print("This is delete id minus Annets:>>>>>>>>>>>>>>>>>>>")
        print(muarrayAnnetsDelete)
        print(muarrayAnnetsServerIDDelete)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        prototypeCells =  tableviewAnns.dequeueReusableCell(withIdentifier: "cell") as! AnnsAnnestVisitorsTableViewCell
        self.view.endEditing(true)
        prototypeCells.textfieldValue.resignFirstResponder()
        prototypeCells.textfieldSecondValue.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        //muDictData=NSMutableDictionary()
        // //print(muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary)
        // //print(muarrayListData)
        // muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        
        //print(muDictData)
        muDictData=NSMutableDictionary()
        muDictData=muarrayListDataassentsTemp.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        print(muDictData)
        //print(muarrayListData)
        
        let AnnetsName:String!=muDictData.value(forKey: "AnnetsName")as? String
        let FK_AttendanceID:String!=muDictData.value(forKey: "FK_AttendanceID")as? String
        let PK_AttendanceAnnetsID:String!=muDictData.value(forKey: "PK_AttendanceAnnetsID")as? String
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
        
        if (isBackSpace == -92)
        {
            //print("Backspace was pressed rajendra jat")
            muDictData = ["AnnetsName": newString, "FK_AttendanceID": FK_AttendanceID,"PK_AttendanceAnnetsID":PK_AttendanceAnnetsID]
            muarrayListDataassentsTemp.replaceObject(at: textField.tag, with: muDictData)
        }
        else
        {
            //print("Backspace was not  pressed")
            muDictData = ["AnnetsName": newString, "FK_AttendanceID": FK_AttendanceID,"PK_AttendanceAnnetsID":PK_AttendanceAnnetsID]
            muarrayListDataassentsTemp.replaceObject(at: textField.tag, with: muDictData)
        }
        return true
    }
    ///-------------------------rajendra working above
    //muDictData = ["AnnetsName": "0", "FK_AttendanceID": "","PK_AttendanceAnnetsID":""]
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewAnns)
        let indexPath = tableviewAnns.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
    }
    
}
