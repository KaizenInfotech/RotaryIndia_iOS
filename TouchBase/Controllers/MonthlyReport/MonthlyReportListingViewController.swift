//
//  MonthlyReportListingViewController.swift
//  TouchBase
//
//  Created by rajendra on 06/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MonthlyReportListingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    

    //July to June DPK---------Start-------
    var arrSevenToTwelth:[String] = []
    var arrFirstToSix:[String] = []
    var totalMonth:[String] = []
    var getCurrentMonth:Int!=0
    var YearFrom2018To:Int!=0
    //July to June DPK---------End-------
    
    var grpIDMonthReport: String!=""
    var varModuleIdMonthReport:String!=""
    var moduleNameMonthReport:String!=""
    var isAdminMonthReport:String! = ""
    let reuseIdentifier = "cell"
    var muarrayListData:NSMutableArray=NSMutableArray()
    var prototypeCells:MonthlyReportListingTableViewCell=MonthlyReportListingTableViewCell()
    var yDropDButton:UIButton = UIButton()
    var profileId:String!=""
   
    //var monthArray:NSMutableArray=NSMutableArray()
    
    @IBOutlet weak var tableviewMonthlyReportListing: UITableView!
    
    @IBOutlet weak var yearPickerView: UIPickerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        functionForViewDidLoad()
        createNavigationBar()
        self.yearPickerView.dataSource = self;
        self.yearPickerView.delegate = self;
        self.yearPickerView.isHidden=true
        // Do any additional setup after loading the view.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = moduleNameMonthReport
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MonthlyReportListingViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        //dropdown button for year selection
        yDropDButton = UIButton(type: UIButton.ButtonType.custom)
        yDropDButton.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        yDropDButton.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        yDropDButton.imageView?.contentMode = .scaleAspectFit
        yDropDButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: -20,bottom: 0,right:34)
        yDropDButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 60,bottom: 0,right:0)
        yDropDButton.setTitle("Month",  for: UIControl.State.normal)
        yDropDButton.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        yDropDButton.backgroundColor = UIColor.clear
        yDropDButton.layer.cornerRadius = 5
        yDropDButton.layer.borderWidth = 1
        yDropDButton.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        yDropDButton.addTarget(self, action: #selector(MonthlyReportListingViewController.showYearDropDown), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: yDropDButton)
        let dropDownbutton : NSArray = [search]
       // self.navigationItem.rightBarButtonItems = dropDownbutton as? [UIBarButtonItem]
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func showYearDropDown()
    {
        self.yearPickerView.isHidden=false
    }
    
    func functionForViewDidLoad()
    {
        //-------------------------------July to June Code by DPK------------------Start--------------------------
        var letSetYear:String!=""
        let date = Foundation.Date()
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        
        
        if(month>=1 && month<7)
        {
            print("Hello 123")
            
            let M = month+6
            for a in 1..<M+1
            {
                print("PPPPPPPPPPPPPPPPPPPPP",a , M)
                if(a<=M)
                {
                    print("11111111111111111111111",a , M)
                    let inde = M-a
                    let previousMonth = Calendar.current.date(byAdding: .month, value: -inde, to: Date())
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM yyyy"
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    let datesss = dateFormatter.string(from: previousMonth!)
                    print(datesss)
                    arrFirstToSix.append(datesss)
                    
                }
                
            }
            
            totalMonth.append(contentsOf:arrFirstToSix)
            //totalMonth.reverse()
        }
        else if(month>=7 && month<=12)
        {
            for a in 7..<month+1
            {
                if(month<13 && a<=month)
                {
                    let inde = a-7
                    let previousMonth = Calendar.current.date(byAdding: .month, value: -inde, to: Date())
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM yyyy"
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    let datesss = dateFormatter.string(from: previousMonth!)
                    print(datesss)
                    
                    arrSevenToTwelth.append(datesss)
                    
                }
            }
            totalMonth.append(contentsOf:arrSevenToTwelth)
            totalMonth.reverse()
        }
       //-------------------------------July to June Code by DPK----------------------------End----------------
        
        
        
        
        
        
        
        
        
        
        
        
       // yearFrom = String(year)
       // print(yearFrom)
       // listTypeTextField.text! = String(year-1) + "-" + yearFrom //yearFrom+"-"+String(year+1)
        
        
        
        
        
        
        
        
        
        
        /*
         let now = NSDate()
        let dateFormatters = DateFormatter()
         dateFormatters.dateFormat = "yyyy"
        let strDate = dateFormatters.string(from: now as Date)
         dateFormatters.dateFormat = "MM"
        let strGetCurrentMonth = dateFormatters.string(from: now as Date)
         print(strGetCurrentMonth)
         
         var varGetStartingMonth:Int=7
         var varIsExist:Int=0
         
         for i in 00..<12
         {
         if(Int(strGetCurrentMonth)==varGetStartingMonth)
         {
         break
         }
         else
         {
         
         if(varIsExist==0)
         {
         let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(varGetStartingMonth))
         
         if(strGetCurrentMonth=="01" || strGetCurrentMonth=="02" || strGetCurrentMonth=="03" || strGetCurrentMonth=="04" || strGetCurrentMonth=="05" || strGetCurrentMonth=="06")
         {
         if(varGetStartingMonth==1 || varGetStartingMonth==2 || varGetStartingMonth==3 || varGetStartingMonth==4 || varGetStartingMonth==5 || varGetStartingMonth==6)
         {
            muarrayListData.add(getMonthInCharacter+" "+strDate)
         }
         else
         {
            muarrayListData.add(getMonthInCharacter+" "+String(Int(strDate)!-1))
         }
         }
         else
         {
            muarrayListData.add(getMonthInCharacter+" "+strDate)
         }
         varGetStartingMonth=varGetStartingMonth+1
         }
         else if(varIsExist==1)
         {
         let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(varGetStartingMonth))
            muarrayListData.add(getMonthInCharacter+" "+strDate)
         varGetStartingMonth=varGetStartingMonth+1
         }
         if(varGetStartingMonth==13)
         {
         varGetStartingMonth=01
         varIsExist=1
         }
         }
         }
         var mutablearray:NSMutableArray=NSMutableArray()
         mutablearray =  NSMutableArray(array: muarrayListData.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
         muarrayListData=NSMutableArray()
         muarrayListData=mutablearray
        
        
        
        */
         /*
        
        
        let now = Foundation.Date()
        let dateFormatters = DateFormatter()
        dateFormatters.dateFormat = "yyyy"
        let strDate = dateFormatters.string(from: now)
        dateFormatters.dateFormat = "MM"
        var strGetCurrentMonth = String(Int(dateFormatters.string(from: now))!)
        print(strGetCurrentMonth)
        
        // var varGetStartingMonth:Int=7
        //var varIsExist:Int=0
        var varForNextYear:Int=1
        for i in 00..<12
        {
            
            if(Int(strGetCurrentMonth)>12)
            {
                let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(varForNextYear))
                muarrayListData.add(getMonthInCharacter+" "+strDate)
                varForNextYear=varForNextYear+1
            }
            else
            {
                
                let getMonthInCharacter = commonClassFunction().functionForMonthWordWise(String(strGetCurrentMonth))
                muarrayListData.add(getMonthInCharacter+" "+String(Int(strDate)!-1))
                strGetCurrentMonth=String(Int(strGetCurrentMonth)!+1)
            }
        }
        print(muarrayListData)
        var mutablearray:NSMutableArray=NSMutableArray()
        mutablearray =  NSMutableArray(array: muarrayListData.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
        muarrayListData=NSMutableArray()
        muarrayListData=mutablearray
 */
        
       tableviewMonthlyReportListing.allowsSelection=false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK:- Table view delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return totalMonth.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        prototypeCells  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MonthlyReportListingTableViewCell
        if(totalMonth.count>0)
        {
            prototypeCells.labelMonth.text=totalMonth[indexPath.row] as! String
            prototypeCells.buttonMainMonthlyReport.addTarget(self, action: #selector(MonthlyReportListingViewController.buttonMonthReportClickEvent(_:)), for: UIControl.Event.touchUpInside)
            prototypeCells.buttonMainMonthlyReport.tag = indexPath.row
        }
        return prototypeCells
    }
    
    //#MARK:- Picker View Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "2019-2020"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.yearPickerView.isHidden=true
    }
    
    //details album
    @objc func buttonMonthReportClickEvent(_ sender:UIButton)
    {
        print(sender.tag)
        let objMonthlyReportDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyReportDetailViewController") as! MonthlyReportDetailViewController
        
        /*
         objAlbumPhotosViewController.varGroupId = grpID
         objAlbumPhotosViewController.varAlbumId = (dict.valueForKey("albumId")as! String)
         objAlbumPhotosViewController.varNavigationTitle=(dict.valueForKey("title")as! String)
         objAlbumPhotosViewController.varDescription = (dict.valueForKey("description")as! String)
         objAlbumPhotosViewController.userID = self.userID
         objAlbumPhotosViewController.imageUrlForAlbumImage = (dict.valueForKey("image")as! String)
         objAlbumPhotosViewController.recipientType = (dict.valueForKey("type")as! String)
         objAlbumPhotosViewController.varModuleId = (dict.valueForKey("moduleId")as! String)
         objAlbumPhotosViewController.createdByORUserIdOrProfileId = self.userID
         objAlbumPhotosViewController.isAdmin = isAdmin
         objAlbumPhotosViewController.isCategory=self.isCategory
         */
        
        objMonthlyReportDetailViewController.grpIDMonthReport=grpIDMonthReport
        objMonthlyReportDetailViewController.varModuleIdMonthReport=varModuleIdMonthReport
        objMonthlyReportDetailViewController.moduleNameMonthReport=moduleNameMonthReport
        objMonthlyReportDetailViewController.isAdminMonthReport=isAdminMonthReport
        objMonthlyReportDetailViewController.varGetMonthProfileID=profileId
        objMonthlyReportDetailViewController.monthYear=totalMonth[sender.tag] as! String//muarrayListData.object(at: sender.tag) as!  String
        self.navigationController?.pushViewController(objMonthlyReportDetailViewController, animated: true)
    }
}
