//
//  AddNewEventViewController.swift
//  TouchBase
//
//  Created by Umesh on 17/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  @IBOutlet var addEventTableView: UITableView!
    
    var picker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    var myview = UIView()
    var cellArray : NSMutableArray!
    let bounds = UIScreen.main.bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.setStyle()
        cellArray=[]
        // Do any additional setup after loading the view.
    }
   @IBAction func createCellArray(){
       
                
    let cellRepeat = self.addEventTableView.dequeueReusableCell(withIdentifier: "datetimeCell") as! RepeatDateTimeCell
    
    
    cellRepeat.objectVal=cellArray.count
    cellRepeat.repeatDateButton.addTarget(self, action: #selector(AddNewEventViewController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
    cellRepeat.repeatDateButton.tag = cellArray.count
    cellRepeat.repeatTimeButton.addTarget(self, action: #selector(AddNewEventViewController.RepeatDateTimeShowAction(_:)), for: UIControl.Event.touchUpInside)
    cellRepeat.repeatTimeButton.tag = cellArray.count
    cellArray.add(cellRepeat)
    //addEventTableView.reloadData()
    addEventTableView.beginUpdates()
    addEventTableView.insertRows(at: [
        IndexPath(row: cellArray.count-1, section: 0)
        ], with: .automatic)
    addEventTableView.endUpdates()
    
    }
    @objc func RepeatDateTimeShowAction(_ sender:UIButton)
    {
        myview.removeFromSuperview()
        myview = UIView(frame: CGRect(x: 0,y: bounds.height-300, width: bounds.width, height: 300));
        myview.backgroundColor=UIColor.white;
        self.view.addSubview(myview);
        picker = UIDatePicker(frame: CGRect(x: 0, y: myview.frame.size.height-250 , width: myview.frame.width, height: 250))
        picker.setStyle()
        picker.backgroundColor = .white
        picker.tag = sender.tag
        picker.addTarget(self, action: #selector(AddNewEventViewController.RepeatDateValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: picker.date)
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        print(Date)
        print(time)
        toolBar.frame = CGRect(x: 0, y: 0 , width: bounds.width, height: 50)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AddNewEventViewController.RepeatDonePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        myview.addSubview(toolBar)
        myview.addSubview(picker)
    }
 @objc   func RepeatDonePicker()
    {
        myview.removeFromSuperview()
    }
    
  @objc  func RepeatDateValueChanged(_ sender:UIDatePicker)
    {
        
        let indexPath = IndexPath(row: sender.tag, section: 3)
        let cellRepeat = cellArray.object(at: sender.tag) as! RepeatDateTimeCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let strDate = dateFormatter.string(from: sender.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        cellRepeat.repeatDateButton.setTitle(Date,  for: UIControl.State.normal)
        cellRepeat.repeatTimeButton.setTitle(time,  for: UIControl.State.normal)
        
        addEventTableView.reloadData()
        
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return cellArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 58.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        return cellArray.object(at: indexPath.row) as! UITableViewCell
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
