
//
//  LeaderBoardViewController.swift
//  TouchBase
//
//  Created by tt on 01/08/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class LeaderBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    //MARK:- for getting zone list 25 Feb 2019
    /*
     API for zone list
     http://rotaryindiaapi.rosteronwheels.com/api/Group/getZonelist
     Input
     {
     "grpId":"31185"
     }
     */
    
    @IBOutlet weak var textfieldYearsrpj: UITextField!
    
    @IBAction func buttonSelectYearClickEvent(_ sender: Any)
    {
        print("button clicked !!!!!")
        self.pickerViewYear.isHidden=false
        pickerZoneList.isHidden=true
    }
    
    
    @IBAction func buttonSelectZoneClickEvent(_ sender: Any)
    {
        print("This is value from server !!!!!!")
        pickerZoneList.isHidden=false
        pickerViewYear.isHidden=true
        pickerZoneList.reloadAllComponents()
    }
    
    @IBOutlet weak var textfieldZone: UITextField!
    @IBOutlet weak var pickerZoneList: UIPickerView!
    var muarrayZoneList:NSMutableArray=NSMutableArray()
    var arrayZoneList:NSArray=NSArray()

    func functionForFetchingZoneList()
    {
        let completeURL = baseUrl+"Group/getZonelist"
        var parameterst = ["":""]
        parameterst =  ["grpId": varGroupID, "filteryear":"2023-2024"]
        
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd---Zone List \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                if((((dd.value(forKey: "zonelistResult")as! AnyObject).value(forKey: "message")as! AnyObject) as! String)=="failed")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                self.arrayZoneList=((dd.value(forKey: "zonelistResult")as! AnyObject).value(forKey: "list")as! AnyObject) as! NSArray
               self.muarrayZoneList=NSMutableArray()
                var zoneDict:NSDictionary=NSDictionary()
                    zoneDict=["PK_zoneID":"0","zoneName":"All"]
                    self.muarrayZoneList.add(zoneDict)
               for i in 00..<self.arrayZoneList.count
                {
                    zoneDict=NSDictionary()
                    var PK_zoneID=(self.arrayZoneList.object(at: i) as! AnyObject).value(forKey: "PK_zoneID")as? Any
                    var zoneName:String!=(self.arrayZoneList.object(at: i) as! AnyObject).value(forKey: "zoneName")as? String

                    zoneDict=["PK_zoneID":PK_zoneID,"zoneName":zoneName]
                    self.muarrayZoneList.add(zoneDict)
                   print("muarrayZoneList \(self.muarrayZoneList)")
                }
              }
            }
        })
    }
    
    
    @IBOutlet weak var lblValueViewTRF: UILabel!
    @IBOutlet weak var lblValueViewMember: UILabel!
    @IBOutlet weak var lblTitleViewTRF: UILabel!
    @IBOutlet weak var lblTitleViewMember: UILabel!
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var viewTRF: UIView!
    @IBOutlet weak var viewMember: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!
    let loaderClass  = WebserviceClass()
    var muarrayCollectionDetails:NSMutableArray=NSMutableArray()
    var muarrayCollectionDetailsValue:NSMutableArray=NSMutableArray()
    var yearFrom:String! = ""
    var year : Int! = 0
    var pickerDataSource :[String] = []
    var varGroupID:String!=""
    var varModuleName:String!=""
    var varProfileID:String!=""
    
    var yearPutOnAPI:String!=""
    @IBOutlet weak var pickerViewYear: UIPickerView!
    
    var muarrayForTopTen:NSArray=NSArray()
    
    let editB = UIButton(type: UIButton.ButtonType.custom)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        textfieldZone.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 20, height: 20))
        let image = UIImage(named: "downArrowCalendar")
        imageView.image = image
        textfieldZone.rightView = imageView
        textfieldYearsrpj.rightViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 30, y: 100, width: 20, height: 20))
        let image2 = UIImage(named: "downArrowCalendar")
        imageView2.image = image2
        textfieldYearsrpj.rightView = imageView2
        pickerZoneList.isHidden=true
        zoneId="0"
        functionForFetchingZoneList()
//        self.edgesForExtendedLayout=[]
        self.pickerViewYear.dataSource = self;
        self.pickerViewYear.delegate = self;
        self.pickerViewYear.isHidden=true
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        let day = components.day
        print(year , month ,day )
        if(month!>=7)
        {
            year = year+1
        }
        else
        {
        }
        yearFrom = String(year)
        print(yearFrom)
        yearPutOnAPI = String(year-1) + "-" + yearFrom
        functionForYears()
        functionRightNavigationButton()
//        self.edgesForExtendedLayout=[]
        myCollectionView.delegate=self
        myCollectionView.dataSource = self
        myTableView.delegate=self
        myTableView.dataSource=self
        functionForFetchingAlbumListData()
    }
    
    
    func functionRightNavigationButton()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = varModuleName
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white// (red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor=UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        // buttonleft.setTitleColor(UIColor.black, for: .normal)
        buttonleft.addTarget(self, action: #selector(LeaderBoardViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        editB.frame = CGRect(x: 60, y: 0, width: 50, height: 40)
        
        let last1 = String(String(year-1).characters.suffix(2))
        let last2 = String(yearFrom.characters.suffix(2))
        print(last1 , last2)
        //editB.setTitle(String(year-1) + "-" + last2, for: .normal)
       // editB.setTitle(last1 + "-" + last2, for: .normal)
        
        textfieldYearsrpj.text=last1 + "-" + last2
        textfieldZone.text="All"

        
        editB.setTitleColor(UIColor(hexString: "#00aeef"), for: .normal)
        editB.addTarget(self, action: #selector(LeaderBoardViewController.DropDownAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        // let buttons : NSArray = [edit]

        let DownArrow = UIButton(type: UIButton.ButtonType.custom)
        DownArrow.frame = CGRect(x: 65, y: 0, width: 20, height: 20)
        // let last1 = String(String(year-1).characters.suffix(2))
        // let last2 = String(yearFrom.characters.suffix(2))
        //print(last1 , last2)
       // DownArrow.setTitle(last1 + "-" + last2, for: .normal)
        //editB.setTitleColor(UIColor.black, for: .normal)
        // editB.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
        
        DownArrow.setTitleColor(UIColor(hexString: "#00aeef"), for: .normal)
        DownArrow.setImage(UIImage(named:"down_arrow"),  for: UIControl.State.normal)
        DownArrow.addTarget(self, action: #selector(LeaderBoardViewController.DropDownAction), for: UIControl.Event.touchUpInside)
        let DownArrows: UIBarButtonItem = UIBarButtonItem(customView: DownArrow)
        let buttons : NSArray = [DownArrows,edit]
        // self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func DropDownAction()
    {
        self.pickerViewYear.isHidden=false
        pickerZoneList.isHidden=true
    }
    //MARK:- Function Year
    func functionForYears()
    {
        pickerDataSource=[]
        //Code by Deepak
        // start from 2015 to current year and start from july and end with june // Code by DPK 25-06-2018
        for  i in (2015..<year)
        {
            print(i)
            let letSetYear = String(i)+"-"+String(Int(i+1))
            print(letSetYear)
            pickerDataSource.append(letSetYear)
        }
        pickerDataSource.reverse()
        //self.pickerViewYear.selectRow(pickerDataSource.count-1, inComponent: 0, animated: false)
        self.pickerViewYear.selectRow(0, inComponent: 0, animated: false)
        self.pickerViewYear.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView==pickerViewYear)
        {
        return 1
        }
       else if(pickerView==pickerZoneList)
        {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==pickerViewYear)
        {
        return pickerDataSource.count;
        }
        else if(pickerView==pickerZoneList)
        {
             return muarrayZoneList.count;
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView==pickerViewYear)
        {
        return pickerDataSource[row]
        }
        else if(pickerView==pickerZoneList)
        {
            print((muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as! String)
            
            return (muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as! String
        } else {
            return "0"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView==pickerViewYear)
        {
        print(pickerDataSource[row] )
        self.yearPutOnAPI = pickerDataSource[row]
        let yearShowLastdigit:String = pickerDataSource[row]
        
        var myStringArr = yearShowLastdigit.components(separatedBy:"-")
        
        let last1 = String(myStringArr[0].characters.suffix(2))
        let last2 = String(myStringArr[1].characters.suffix(2))
        print(last1 , last2)
        self.editB.setTitle(last1 + "-" + last2, for: .normal)
            
            
            textfieldYearsrpj.text=last1 + "-" + last2
        //self.editB.setTitle(pickerDataSource[row], for: .normal)
        self.pickerViewYear.isHidden=true
        functionForFetchingAlbumListData()
        }
        else if(pickerView==pickerZoneList)
        {
            print(muarrayZoneList[row] )
            textfieldZone.text=(muarrayZoneList[row] as! AnyObject).value(forKey: "zoneName")as? String
           zoneId=(muarrayZoneList[row] as! AnyObject).value(forKey: "PK_zoneID")as? Any
            print("ZONEID-----\(zoneId)")
            
            self.pickerZoneList.isHidden=true
           functionForFetchingAlbumListData()
        }
        
    }
    
    //MARK:- Server api calling
    var zoneId:Any?=""
    func functionForFetchingAlbumListData()
    {
       // loaderClass.loaderViewMethod()
        
       
        if(varGroupID.hasPrefix("Optional("))
        {
            let temp = String(varGroupID.dropFirst(10))
            print(temp)
            varGroupID = String(temp.dropLast(2))
            print(varGroupID)
        }
        print(varGroupID)
        print(varGroupID!)

        let completeURL = baseUrl+"LeaderBoard/GetLeaderBoardDetails"
        // var parameterst:NSDictionary=NSDictionary()
        
        var parameterst:[String: Any] = [:]
       
        
         parameterst =  ["GroupID": varGroupID,
                            "RowYear": self.yearPutOnAPI,
                            "ProfileID": varProfileID!,
                            "fk_zoneid":zoneId
        ]
        
        SVProgressHUD.show()
        print("Member list parameterst :: \(parameterst)")
        print("Member list completeURL :: \(completeURL)")
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                self.muarrayCollectionDetails = NSMutableArray()
                self.muarrayCollectionDetailsValue = NSMutableArray()

            if((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "status") as! String == "0")
            {
  //              self.muarrayCollectionDetails = NSMutableArray()
            //    self.muarrayCollectionDetailsValue = NSMutableArray()
                
                var TotalProjects = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "TotalProjects") as! String)
                print(TotalProjects)
                var ProjectCost = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "ProjectCost") as! String)
                print(ProjectCost)
                var ManHoursCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "ManHoursCount") as! String)
                print(ManHoursCount)
                var BeneficiaryCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "BeneficiaryCount") as! String)
                print(BeneficiaryCount)
                var RotariansCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "RotariansCount") as! String)
                print(RotariansCount)
                //MARK:- Rotaractors new field on May 2020
                var RotaractorsCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "RotaractoresCount") as! String)
                
                let MembersCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "MembersCount") as! String)
                print("MembersCount :: \(MembersCount)")
                let TRFCount = ((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "TRFCount") as! String)
                print(TRFCount)
                
                
                if(MembersCount != "")
                {
                    // self.lblValueViewMember.text = MembersCount
                    
                    self.muarrayCollectionDetails.add("Members")
                    self.muarrayCollectionDetailsValue.add(MembersCount)
                    
                    
                }
                else
                {
                    //self.lblValueViewMember.text = "0"
                    self.muarrayCollectionDetails.add("Members")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                
                if(TRFCount != "")
                {
                    // self.lblValueViewTRF.text = TRFCount
                    self.muarrayCollectionDetails.add("TRF\nContribution")
                    self.muarrayCollectionDetailsValue.add("$"+TRFCount)
                }
                else
                {
                    //self.lblValueViewTRF.text = "0"
                    self.muarrayCollectionDetails.add("TRF\nContribution")
                    self.muarrayCollectionDetailsValue.add("$"+TRFCount)
                }
                //11. TotalProjects
                if(TotalProjects != "")
                {
                    self.muarrayCollectionDetails.add("Projects")
                    self.muarrayCollectionDetailsValue.add(TotalProjects)
                }
                else
                {
                    self.muarrayCollectionDetails.add("Projects")
                    self.muarrayCollectionDetailsValue.add("0")
                    
                }
                //2. ProjectCost
                if(ProjectCost != "" )
                {
                    self.muarrayCollectionDetails.add("Cost")
                    self.muarrayCollectionDetailsValue.add(ProjectCost)
                }
                else
                {
                    self.muarrayCollectionDetails.add("Cost")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                //3. ManHoursCount
                if(ManHoursCount != "" )
                {
                    
                    self.muarrayCollectionDetails.add("Man Hours")
                    self.muarrayCollectionDetailsValue.add(ManHoursCount)
                    
                    
                }
                else
                {
                    self.muarrayCollectionDetails.add("Man Hours")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                //4. BeneficiaryCount
                if(BeneficiaryCount != "")
                {
                    
                    self.muarrayCollectionDetails.add("Beneficiaries")
                    self.muarrayCollectionDetailsValue.add(BeneficiaryCount)
                    
                }
                else
                {
                    self.muarrayCollectionDetails.add("Beneficiaries")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                //5.RotariansCount
                if(RotariansCount != "")
                {
                    
                    self.muarrayCollectionDetails.add("Rotarians\nInvolved")
                    self.muarrayCollectionDetailsValue.add(RotariansCount)
                    
                }
                else
                {
                    self.muarrayCollectionDetails.add("Rotarians\nInvolved")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                
                
                if(RotaractorsCount != "")
                {
                    self.muarrayCollectionDetails.add("Rotaractors\nInvolved")
                    self.muarrayCollectionDetailsValue.add(RotaractorsCount)
                }
                else
                {
                    self.muarrayCollectionDetails.add("Rotaractors\nInvolved")
                    self.muarrayCollectionDetailsValue.add("0")
                }
                
                
                if(self.muarrayCollectionDetailsValue.count>0)
                {
                    self.myCollectionView.reloadData()
                }
                else
                {
                    self.myCollectionView.reloadData()
                    print("No value in collection view list")
                }
                
                
                
                
                
                
                // self.viewTRF.isHidden=false
                // self.viewMember.isHidden=false
                
                
                
                /*
                 ManHoursCount = "31,180";
                 MembersCount = 143;
                 ProjectCost = "81,367";
                 RotariansCount = "32,211";
                 TRFCount = "34562.00";
                 TotalProjects = 31;
                 */
                
                
                let arrarrNewGroupList = (((dd.object(forKey: "TBLeaderBoardResult")! as AnyObject).object(forKey: "LeaderBoardResult")! as! NSArray))
       print(arrarrNewGroupList)
      self.muarrayForTopTen=arrarrNewGroupList
       if(arrarrNewGroupList.count>0)
       {
        self.lblNoResult.isHidden=true
        self.lblNoResult.text = ""
        self.myTableView.isHidden=false
        self.myTableView.reloadData()
       }
       else
       {
           //self.myTableView.isHidden=true
           self.lblNoResult.isHidden=false
         //  self.lblNoResult.text = "No Result"
           self.lblNoResult.text = "This place is reserved for Clubs to show their citation points."
                    //self.myTableView.isHidden=true
                    self.myTableView.reloadData()
                    if(self.muarrayCollectionDetailsValue.count>0)
                    {
                        self.myCollectionView.reloadData()
                    }
                    else
                    {
                        self.myCollectionView.reloadData()
                        self.myTableView.isHidden=true
                    }

                }
                
                self.loaderClass.window = nil
            }
            else
            {
                
                
                //self.myTableView.isHidden=true
                self.lblNoResult.isHidden=false
                //self.lblNoResult.text = "No Result"
                self.lblNoResult.text = "No Record Found"
                self.muarrayForTopTen = NSArray()
                self.myTableView.reloadData()
                self.loaderClass.window = nil
               // self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                 SVProgressHUD.dismiss()
                if(self.muarrayCollectionDetailsValue.count>0)
                {
                    self.myCollectionView.reloadData()
                }
                else
                {
                    self.myCollectionView.reloadData()
                    self.myTableView.isHidden=true
                }
            }
             self.loaderClass.window = nil
             SVProgressHUD.dismiss()
             }
        }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        tableView.tableHeaderView?.frame = CGRect(x:5,y:35,width:self.viewMain.frame.size.width-10,height:80)
        tableView.tableHeaderView = self.viewMain
        
        
        return tableView.tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.muarrayForTopTen.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "TableViewCustomeCell", for: indexPath) as! TableViewCustomeCell
        
        if(self.muarrayForTopTen.count>0)
        {
           print("Leader Board data \(muarrayForTopTen)")
            cell.btnSerialNumber.setTitle(String(indexPath.row+1), for: .normal)

            if  let dict = muarrayForTopTen.object(at: indexPath.row) as? NSDictionary
            {
                print("Coming in if side")
                if let leaderboardDict=dict.value(forKey: "LeaderBoardResult") as? NSDictionary{
                cell.lblValue.text = leaderboardDict.value(forKey: "clubName") as? String
                cell.btnPoint.setTitle(leaderboardDict.value(forKey: "Points") as? String, for: .normal)
                }
            }
            else
   {
       print("Coming in else side")
   }
   
   


//            let points = (((self.muarrayForTopTen.value(forKey: "LeaderBoardResult") as AnyObject).objectAt(indexPath.row)).value(forKey: "Points") as! String)
 }
   return cell
}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return muarrayCollectionDetails.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "LeaderBoardCollectionViewCell", for: indexPath) as! LeaderBoardCollectionViewCell
        /*
         ff9338
         89be4c
         fa5951
         d6009c
         0089ae
         */
        if(muarrayCollectionDetails.count>0)
        {
            
            //   viewMember.backgroundColor = UIColor(hexString: "#d3a885")
            //  viewTRF.backgroundColor = UIColor(hexString: "#29b49b")
            
            
            
            if(indexPath.row==0)
            {
                let darkGrey = UIColor(hexString: "#29b49b")
                cell.view1.backgroundColor = darkGrey
            }
            else  if(indexPath.row==1)
            {
                let darkGrey = UIColor(hexString: "#FA5951")
                cell.view1.backgroundColor = darkGrey
            }
            else if(indexPath.row==2)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            else  if(indexPath.row==3)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            else  if(indexPath.row==4)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            else  if(indexPath.row==5)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            else  if(indexPath.row==6)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            
            else  if(indexPath.row==7)
            {
                let darkGrey = UIColor(hexString: "#00AEEF")
                cell.view1.backgroundColor = darkGrey
            }
            cell.lblKey.backgroundColor = UIColor.clear
            cell.lblValue.backgroundColor = UIColor.clear
            cell.view1.layer.cornerRadius = 10.0
            cell.lblKey.text = muarrayCollectionDetails.object(at: indexPath.item) as! String
            cell.lblValue.text = muarrayCollectionDetailsValue.object(at: indexPath.item) as! String
            
        }
        else
        {
            
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
