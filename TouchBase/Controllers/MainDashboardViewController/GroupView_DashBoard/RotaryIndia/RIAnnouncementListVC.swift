//
//  RIAnnouncementListVC.swift
//  TouchBase
//
//  Created by IOS on 22/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class AnnounceCell:UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    
}

class RIAnnouncementListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,RIServerDelegate,UISearchBarDelegate {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var muarrayAnnounceList:NSMutableArray=NSMutableArray()
    var filteredArray:NSArray=NSArray()
    let commonClass:CommonRIClass=CommonRIClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
        commonClass.setNavigationBar(moduleName: "Announcements", uiVC: self)
        commonClass.riServerDelegate=self
        commonClass.getModuleListFromServer(fromYear: "",toYear: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
     commonClass.setNavigationBar(moduleName: "Announcements", uiVC: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnnounceCell=tableView.dequeueReusableCell(withIdentifier: "rianncell", for: indexPath) as! AnnounceCell
        cell.selectionStyle = .none
        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
            
            cell.lblTitle.text=(row_data.object(forKey: "announTitle") as! String)
            cell.lblDate.text=row_data.object(forKey: "publishDateTime") as? String
            let isRead = row_data.object(forKey: "isRead") as? String
            if(isRead == "No"){
             cell.lblTitle.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
                //  cell.contentView.backgroundColor = UIColor.lightGrayColor()
            }else{
                cell.lblTitle.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
                //  cell.contentView.backgroundColor = UIColor.whiteColor()
            }
            let filterType = row_data.object(forKey: "filterType") as? String
            if(filterType=="1"){
                cell.lblStatus.text=String(format: "Status: Published")
            }else if(filterType=="2"){
                cell.lblStatus.text=String(format: "Status: Scheduled")
            }else if(filterType=="3"){
                cell.lblStatus.text=String(format: "Status: Expired")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
         if searchBar.isFirstResponder
         {
             searchBar.resignFirstResponder()
         }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIAnnouncementDetailController") as! RIAnnouncementDetailController
        secondViewController.grpID = "-1"
        secondViewController.isCategory="1"
                secondViewController.annID = row_data.object(forKey: "announID") as! String as NSString
        self.navigationController?.pushViewController(secondViewController, animated: true)
        }
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
            let resultPredicate = NSPredicate(format: "announTitle contains[c] %@", searchText)
            self.filteredArray = (self.muarrayAnnounceList.filtered(using: resultPredicate)) as NSArray
        }
        else
        {
            filteredArray = muarrayAnnounceList
        }
        
        if filteredArray.count>0
        {
            msgLabel.isHidden=true
        }
        else
        {
            msgLabel.isHidden=false
            msgLabel.text="No results"
        }

        listTableView.reloadData()
    }
    
    func OnReceiveAnnounceResult(announceResult: NSDictionary) {
        if let TBAnnounceListResult = announceResult.object(forKey: "TBAnnounceListResult") as? NSDictionary
        {
            if TBAnnounceListResult.object(forKey: "status") as! String == "0"
            {
                if let AnnounListResult = TBAnnounceListResult.object(forKey: "AnnounListResult") as? NSArray
                {
                    for i in 0 ..< AnnounListResult.count
                    {
                        if let mainDictionary = AnnounListResult.object(at: i) as? NSDictionary
                        {
                            if let dictionary = mainDictionary.object(forKey: "AnnounceList") as? NSDictionary
                            {
                                self.muarrayAnnounceList.add(dictionary)
                            }
                        }
                    }
                    print("Final Array to show on list \(self.muarrayAnnounceList)")
                    
                    if muarrayAnnounceList.count>0
                    {
                        self.filteredArray = muarrayAnnounceList.mutableCopy() as! NSArray
                        self.msgLabel.isHidden=true
                        self.listTableView.reloadData()
                        self.listTableView.isHidden=false
                    }
                    else
                    {
                        self.msgLabel.text="No results"
                        self.msgLabel.isHidden=false
                        self.listTableView.isHidden=true
                    }
                }
                else
                {
                    self.msgLabel.text="Could not connect to server"
                }
            }
            else
            {
                if let message = TBAnnounceListResult.object(forKey: "message") as? String{
                    if message.contains("Record not found")
                    {self.msgLabel.text="No results"}else{self.msgLabel.text=message}
                }
                else
                {
                self.msgLabel.text="Could not connect to server"
                }
            }
        }
        
        
    }
}
