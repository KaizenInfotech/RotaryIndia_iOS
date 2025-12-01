//
//  RINewsLetterListVC.swift
//  TouchBase
//
//  Created by IOS on 22/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class NewsCell:UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
}

class RINewsLetterListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,RIServerDelegate,UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource
{
    
    
    let commonClass:CommonRIClass=CommonRIClass()
    var muarrayNewsList:NSMutableArray=NSMutableArray()
    var filteredArray:NSArray=NSArray()
    var pickerDataSource = [ "2015-2016", "2016-2017", "2017-2018", "2018-2019","2019-2020"];
    var year : Int! = 0
    var yearFrom:String! = ""

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var parentPickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonClass.riServerDelegate=self
        commonClass.setNavigationBar(moduleName: "Newsletters", uiVC: self)
        searchBar.delegate=self
        btnYear.layer.cornerRadius=5
        btnYear.layer.borderWidth=1
        btnYear.layer.borderColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0).cgColor
        setCurrentYearDropDown()
        getYearWiseData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commonClass.setNavigationBar(moduleName: "Newsletters", uiVC: self)
    }
    
    func setCurrentYearDropDown()
    {
        let date = Foundation.Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        year =  components.year
        let month = components.month
        if(month!>=7)
        {
            year = year+1
        }
        
        yearFrom = String(year)
        let yearpair=String(year-1) + "-" + yearFrom
        btnYear.setTitle(yearpair, for: .normal)
        functionForYears()
    }
    
    func getYearWiseData()
    {
        let getSelectYearsValue:String!=self.btnYear.titleLabel?.text
        let varGetArrayValue=getSelectYearsValue.components(separatedBy: "-")
        let fromYear = varGetArrayValue[0]
        let toYear = varGetArrayValue[1]
        msgLabel.isHidden=false
        msgLabel.text="Loading.. Please Wait"
        searchBar.text=""
        self.muarrayNewsList = NSMutableArray()
        self.filteredArray = NSArray()
        listTableView.reloadData()
        commonClass.getModuleListFromServer(fromYear: fromYear,toYear: toYear)
    }
    
    func functionForYears()
    {
        pickerDataSource=[]
        for  i in (2015..<year)
        {
            let letSetYear = String(i)+"-"+String(Int(i+1))
            pickerDataSource.append(letSetYear)
        }
        self.pickerView.selectRow(pickerDataSource.count-1, inComponent: 0, animated: false)
        self.pickerView.reloadAllComponents()
    }
    
    @IBAction func btnOpacityClickEvent(_ sender: Any) {
        self.parentPickerView.isHidden=true
    }
    
    @IBAction func btnyearFilterEvent(_ sender: Any) {
        parentPickerView.isHidden=false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsCell=tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        cell.lblTitle.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
            cell.lblTitle.text=(row_data.object(forKey: "ebulletinTitle") as! String)
            cell.lblDate.text=row_data.object(forKey: "publishDateTime") as? String
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
         {
            tableView.deselectRow(at: indexPath, animated: false)
            var stringUrl:String! = (row_data.object(forKey: "ebulletinlink")as! String)
            print("string URL \(stringUrl)")
            if searchBar.isFirstResponder
            {
                searchBar.resignFirstResponder()
            }
            if(stringUrl.contains(".pdf") || stringUrl.contains(".docx") || stringUrl.contains(".doc") || stringUrl.contains(".html") || stringUrl.contains(".gif") || stringUrl.contains(".jpg") || stringUrl.contains(".jpeg") || stringUrl.contains(".png"))
            {
                listTableView.deselectRow(at: indexPath, animated: true)
                self.parentPickerView.isHidden=true
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ebdetail") as! EbulletinDetailViewController
                secondViewController.isCalled = "list"
                secondViewController.urlLink=stringUrl
                secondViewController.bulletinID = row_data.object(forKey: "ebulletinID") as! String as NSString
                secondViewController.moduleName = "Newsletter"
                //secondViewController.objprotocolForUpdateListing=self
                secondViewController.profileID = ""
                secondViewController.SMSCountStr = ""
                self.navigationController?.pushViewController(secondViewController, animated: true)

                
                /*
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                secondViewController.URLstr=stringUrl
                secondViewController.moduleName="Newsletter"
                self.navigationController?.pushViewController(secondViewController, animated: true)
                */
            }
            else
            {

            if(stringUrl.contains("http"))
            {
            }
            else
            {
                stringUrl="http://"+stringUrl
            }
            let url = URL (string: (stringUrl)!)
            print("url to be shown \(url)")
            let requestObj = URLRequest(url: url!)            
            if let url = NSURL(string: stringUrl){
//                UIApplication.shared.openURL(url as URL)
                
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL, options: [:]) { success in
                            if success {
                                print("The URL was successfully opened.")
                            } else {
                                print("Failed to open the URL.")
                            }
                        }
                    }
                
            }
            }
        }
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
        btnYear.setTitle(pickerDataSource[row], for: .normal)
        parentPickerView.isHidden=true
        getYearWiseData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count>0
        {
            let resultPredicate = NSPredicate(format: "ebulletinTitle contains[c] %@", searchText)
            self.filteredArray = self.muarrayNewsList.filtered(using: resultPredicate) as NSArray
        }
        else
        {
            filteredArray = muarrayNewsList
        }
        
        if filteredArray.count>0
        {
            listTableView.isHidden=false
            msgLabel.isHidden=true
        }
        else
        {
            msgLabel.isHidden=false
            msgLabel.text="No results"
        }
        listTableView.reloadData()
    }

    func OnReceiveNewsLetterResult(NewsLetterResult: NSDictionary) {
        if let TBYearWiseEbulletinList = NewsLetterResult.object(forKey: "TBYearWiseEbulletinList") as? NSDictionary
        {
            if TBYearWiseEbulletinList.object(forKey: "status") as! String == "0"
            {
                if let DocumentistResult = TBYearWiseEbulletinList.object(forKey: "Result") as? NSArray
                {
                    self.muarrayNewsList = DocumentistResult.mutableCopy() as! NSMutableArray
                    if muarrayNewsList.count>0
                    {
                        self.filteredArray = muarrayNewsList.mutableCopy() as! NSArray
                        self.msgLabel.isHidden=true
                        self.listTableView.isHidden=false
                    }
                    else
                    {
                        self.msgLabel.text="No results"
                        self.msgLabel.isHidden=false
                    }
                }
                else
                {
                    self.msgLabel.text="Could not connect to server"
                }
            }
            else
            {
                if let message = TBYearWiseEbulletinList.object(forKey: "message") as? String{
                   if message.contains("Record not found")
                   {self.msgLabel.text="No results"}else{self.msgLabel.text=message}
               }
               else
               {
               self.msgLabel.text="Could not connect to server"
               }
            }
        }
        self.listTableView.reloadData()
    }
}
