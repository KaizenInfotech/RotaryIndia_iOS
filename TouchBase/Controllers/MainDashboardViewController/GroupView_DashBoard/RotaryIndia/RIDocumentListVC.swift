//
//  RIDocumentListVC.swift
//  TouchBase
//
//  Created by IOS on 22/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import Alamofire
class DocCell:UITableViewCell
{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnView: UIButton!
    
}


class RIDocumentListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,RIServerDelegate,UISearchBarDelegate
{
    
    
let commonClass:CommonRIClass=CommonRIClass()
var muarrayDocumentList:NSMutableArray=NSMutableArray()
var filteredArray:NSArray=NSArray()
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonClass.setNavigationBar(moduleName: "Documents", uiVC: self)
        subNavigation()
        commonClass.riServerDelegate=self
        listTableView.isHidden=true
        commonClass.getModuleListFromServer(fromYear: "",toYear: "")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        commonClass.setNavigationBar(moduleName: "Documents", uiVC: self)
        subNavigation()
    }
    

    func subNavigation()
    {
        let searchButton = UIButton(type: UIButton.ButtonType.custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchButton.setImage(UIImage(named:"downloaded"),  for: UIControl.State.normal)
        searchButton.addTarget(self, action: #selector(buttonDownloadableDocumentClickEvent), for: UIControl.Event.touchUpInside)
        let search: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = search
    }
    
    @objc func buttonDownloadableDocumentClickEvent()
     {
         let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocumentDownloadedViewController") as! DocumentDownloadedViewController
         self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)
     }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DocCell=tableView.dequeueReusableCell(withIdentifier: "DocCell", for: indexPath) as! DocCell
        cell.selectionStyle = .none
        cell.btnDownload.isHidden=true
        cell.btnView.isHidden=true

        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
                cell.lblTitle.text=row_data.object(forKey: "docTitle") as? String
                cell.lblDate.text = (row_data.object(forKey: "createDateTime") as! String)
            let docAccessType = row_data.object(forKey: "docAccessType") as? String
            if docAccessType == "1"
            {
                //Downloadable
                cell.btnView.isHidden=true
                cell.btnDownload.isHidden=false
            }
            else if docAccessType == "0"
            {
                //View Only
                cell.btnView.isHidden=false
                cell.btnDownload.isHidden=true
            }
            let letIsRead=row_data.object(forKey: "isRead") as? String
            if(letIsRead=="0")
            {
                cell.lblTitle.textColor=UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
            }
            else
            {
                cell.lblTitle.textColor=UIColor.black
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
            let stringUrl = row_data.object(forKey: "docURL") as! String
            print("string URL \(stringUrl)")
            let docID = row_data.object(forKey: "docID") as! String
            if let accessType = row_data.object(forKey: "docAccessType") as? String
            {
                switch accessType {
                case "0":
                    //View Only
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                    secondViewController.URLstr=stringUrl
                    secondViewController.moduleName="Document"
                    secondViewController.docID = docID

                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    break
                case "1":
                    //Downloadable
                    DownloadAction(strURL: stringUrl,docID: docID)
                    break
                default:
                    break
                }
            }
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
            let resultPredicate = NSPredicate(format: "docTitle contains[c] %@", searchText)
            self.filteredArray = self.muarrayDocumentList.filtered(using: resultPredicate) as NSArray
        }
        else
        {
            filteredArray = muarrayDocumentList
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

    func OnReceiveDocumentResult(DocumentResult: NSDictionary) {
        if let TBAnnounceListResult = DocumentResult.object(forKey: "TBDocumentistResult") as? NSDictionary
        {
            if TBAnnounceListResult.object(forKey: "status") as! String == "0"
            {
                if let DocumentistResult = TBAnnounceListResult.object(forKey: "DocumentLsitResult") as? NSArray
                {
                    for i in 0 ..< DocumentistResult.count{
                        if let mainDictionary = DocumentistResult.object(at: i) as? NSDictionary
                        {
                            if let dictionary = mainDictionary.object(forKey: "DocumentList") as? NSDictionary
                            {
                                muarrayDocumentList.add(dictionary)
                            }
                        }
                    }

                    if muarrayDocumentList.count>0
                    {
                        self.filteredArray = muarrayDocumentList.mutableCopy() as! NSArray
                        self.msgLabel.isHidden=true
                        self.listTableView.isHidden=false
                    }
                    else
                    {
                        self.msgLabel.text="No results"
                        self.msgLabel.isHidden=false
                    }
                     self.listTableView.reloadData()
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
    
    func DownloadAction(strURL:String,docID:String)
    {
        let alert = UIAlertController(title: "Downloading...", message: "Please wait.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let urls:String=strURL
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        
        Alamofire.download(urls,method: .get, parameters: nil, encoding: JSONEncoding.default,headers: nil, to: destination).downloadProgress(closure: { (progress) in
        }).responseJSON(completionHandler: { (result) in
            print(result)
        }).response(completionHandler: { (DefaultDownloadResponse) in
            print(DefaultDownloadResponse)
        }).responseData { response in
            switch response.result {
            case .success:
                alert.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "", message: "Downloaded file successfully", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                    secondViewController.URLstr=urls
                    secondViewController.moduleName="Document"
                    secondViewController.docID = docID
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
                
                
            case .failure(let error):
                print(error)
                let letGetResponse:String!=String(describing: error)
                print(letGetResponse)
                if letGetResponse.contains("File exists") != nil
                {
                    alert.dismiss(animated: true, completion: nil)
                    let alert = UIAlertController(title: "", message: "This Document is already downloaded", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                        secondViewController.URLstr=urls
                        secondViewController.moduleName="Document"
                        secondViewController.docID = docID

                        self.navigationController?.pushViewController(secondViewController, animated: true)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "", message: "This Document is already downloaded", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewCommonViewController") as! webViewCommonViewController
                        secondViewController.URLstr=urls
                        secondViewController.moduleName="Document"
                        secondViewController.docID = docID

                        self.navigationController?.pushViewController(secondViewController, animated: true)

                        
                    }
                alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
