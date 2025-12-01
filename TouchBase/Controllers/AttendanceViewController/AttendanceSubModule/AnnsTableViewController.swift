import UIKit
protocol protocolName
{
    func functionForSendingValue(_ stringValue:String,index:Int,muarrayValueGlobal:NSMutableArray)
}
class AnnsTableViewController: UITableViewController,UITextFieldDelegate
{
    
    var objProtocol:protocolName?=nil
    var varWhichRowClicked:String!=""
    @IBOutlet weak var tableviewAnns: UITableView!
    var varSelectedTableRowIndex:Int!=0
    var varSelectedTableRowTextFieldTag:Int!=0
    var varSelectedTableRowIndexGet_Text:String!=""
    var muarrayListData:NSMutableArray=NSMutableArray()
    var prototypeCells:AnnsAnnestVisitorsTableViewCell=AnnsAnnestVisitorsTableViewCell()
    let reuseIdentifier = "cell"
    var muDictData:NSMutableDictionary=NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionForCreaqteNavigation()
        //print(muarrayListData)
        if(muarrayListData.count>0)
        {
            
        }
        else
        {
            muDictData = ["AnnsName": "0", "Fk_AttendanceID": "","PK_AttendanceAnnsID":""]
            muarrayListData.add(muDictData)
        }
        //print(muarrayListData)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func functionForCreaqteNavigation()
    {
        let str : String!
        str = "Anns"
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
        buttonleft.addTarget(self, action: #selector(AnnsTableViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonRight = UIButton(type: UIButton.ButtonType.custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        buttonRight.setTitle("Add",  for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonRight.layer.cornerRadius = 5
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue:239/255.0, alpha: 1.0).cgColor
        buttonRight.addTarget(self, action: #selector(AnnsTableViewController.buttonAddClickEvent), for: UIControl.Event.touchUpInside)
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func  buttonAddClickEvent()
    {
        self.objProtocol?.functionForSendingValue("Anns", index: 5, muarrayValueGlobal: muarrayListData)
        self.navigationController?.popViewController(animated: true)
    }
     @objc func backClicked()
    {
        //print("add")
        self.navigationController?.popViewController(animated: true)
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
                prototypeCells.labelAnnsAnnestVisitors.text="Total Anns"
                prototypeCells.textfieldValue.text=String(muarrayListData.count-1)
            }
            else if(indexPath.row != 0)
            {
                muDictData=muarrayListData.object(at: indexPath.row) as! NSMutableDictionary
                prototypeCells.viewSecond.isHidden=false
                prototypeCells.labelSecondAnnsAnnestVisitors.text="Anns "+String(indexPath.row)
                prototypeCells.textfieldSecondValue.text=muDictData.value(forKey: "AnnsName")as! String
                
            }
            
            //prototypeCells.textfieldThirdValue.text=""
            //0
            prototypeCells.textfieldSecondValue.tag=indexPath.row
            prototypeCells.textfieldSecondValue.delegate = self
            //11
            prototypeCells.buttonDecrease.addTarget(self, action: #selector(AnnsTableViewController.buttonDecreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonDecrease.tag = indexPath.row
            
            //22
            prototypeCells.buttonIncrease.addTarget(self, action: #selector(AnnsTableViewController.buttonIncreaseClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonIncrease.tag = indexPath.row
            //33
            prototypeCells.buttonMinus.addTarget(self, action: #selector(AnnsTableViewController.buttonMinusClickEvent(_:)), for: UIControl.Event.touchUpInside)
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
            let PK_AttendanceAnnsID=muDictData.value(forKey: "PK_AttendanceAnnsID")as! String
            if(muarrayAnnsServerIDDelete.contains(PK_AttendanceAnnsID))
            {
                muarrayAnnsDelete.add(PK_AttendanceAnnsID)
            }
            //For delete id holding end
            muarrayListData.removeObject(at: muarrayListData.count-1)
            //print(muarrayListData)
            tableviewAnns.reloadData()
        }
        print("This is delete id Decrease Anns:>>>>>>>>>>>>>>>>>>>")
        print(muarrayAnnsDelete)
        print(muarrayAnnsServerIDDelete)

    }
    
    @objc func buttonIncreaseClickEvent(_ sender:UIButton)
    {
        muDictData = ["AnnsName": "", "Fk_AttendanceID": "","PK_AttendanceAnnsID":""]
        muarrayListData.add(muDictData)
        
        print(muarrayListData)
        print(muDictData)

      
        tableviewAnns.reloadData()
        
        let indexPath = IndexPath(row: muarrayListData.count - 1, section: 0)
        self.tableviewAnns.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    @objc func buttonMinusClickEvent(_ sender:UIButton)
    {
        //For delete id holding
        //print(muarrayListData)
        muDictData=muarrayListData.object(at: sender.tag) as! NSMutableDictionary
        let PK_AttendanceAnnsID=muDictData.value(forKey: "PK_AttendanceAnnsID")as! String
        if(muarrayAnnsServerIDDelete.contains(PK_AttendanceAnnsID))
        {
            muarrayAnnsDelete.add(PK_AttendanceAnnsID)
        }
        //print(muarrayAnnsDelete)
        //For delete id holding end
        //print(sender.tag)
        muarrayListData.removeObject(at: sender.tag)
        //print(muarrayListData)
        tableviewAnns.reloadData()
        
        
        print("This is delete id minus Anns:>>>>>>>>>>>>>>>>>>>")
        print(muarrayAnnsDelete)
         print(muarrayAnnsServerIDDelete)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        prototypeCells =  tableviewAnns.dequeueReusableCell(withIdentifier: "cell") as! AnnsAnnestVisitorsTableViewCell
        self.view.endEditing(true)
        prototypeCells.textfieldValue.resignFirstResponder()
        prototypeCells.textfieldSecondValue.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField,  shouldChangeCharactersIn range: NSRange, replacementString string: String)  -> Bool {
        
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        //print(muarrayListData)
        //print(muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary)
        
        muDictData=muarrayListData.object(at: varSelectedTableRowIndex) as! NSMutableDictionary
        
        //print(muDictData.value(forKey: "AnnsName")as! String)
        
        var AnnetsName:String!=muDictData.value(forKey: "AnnsName")as! String
        let FK_AttendanceID:String!=muDictData.value(forKey: "Fk_AttendanceID")as! String
        let PK_AttendanceAnnetsID:String!=muDictData.value(forKey: "PK_AttendanceAnnsID")as! String
        
        
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString?)?.replacingCharacters(in: range, with: string)
        
        
        if (isBackSpace == -92)
        {
            //print("Backspace was pressed rajendra jat")
            
            muDictData = ["AnnsName": newString, "Fk_AttendanceID": FK_AttendanceID,"PK_AttendanceAnnsID":PK_AttendanceAnnetsID]
            muarrayListData.replaceObject(at: varSelectedTableRowIndex, with: muDictData)
        }
        else
        {
            //print("Backspace was not  pressed")
            muDictData = ["AnnsName": newString, "Fk_AttendanceID": FK_AttendanceID,"PK_AttendanceAnnsID":PK_AttendanceAnnetsID]
            muarrayListData.replaceObject(at: textField.tag, with: muDictData)
        }
        //print(muarrayListData)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewAnns)
        let indexPath = tableviewAnns.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        //print(indexPath)
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "keyboardshown"), object: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        let pointInTable = textView.convert(textView.bounds.origin, to: tableviewAnns)
        let indexPath = tableviewAnns.indexPathForRow(at: pointInTable)?.row
        //print(indexPath)
        varSelectedTableRowIndex=Int(indexPath!)
        //print(muarrayListData.object(at: varSelectedTableRowIndex))
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        varSelectedTableRowTextFieldTag=textField.tag
        //print(textField.text)
        let pointInTable = textField.convert(textField.bounds.origin, to: tableviewAnns)
        let indexPath = tableviewAnns.indexPathForRow(at: pointInTable)?.row
        varSelectedTableRowIndex=Int(indexPath!)
        //print("This is index:----")
        //print(varSelectedTableRowIndex)
        // varSelectedTableRowIndexGet_Text=muarrayListData.object(at: varSelectedTableRowIndex) as! String
        return true
    }
    //rajendra working above......
    
    ///-------------------------rajendra working above
    //muDictData = ["AnnetsName": "0", "FK_AttendanceID": "","PK_AttendanceAnnetsID":""]
    
    
}

