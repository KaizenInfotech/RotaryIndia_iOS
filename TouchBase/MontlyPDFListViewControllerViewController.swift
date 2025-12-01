
//
//  MontlyPDFListViewControllerViewController.swift
//  TouchBase
//
//  Created by tt on 11/07/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class MontlyPDFListViewControllerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblNoResult: UILabel!
    @IBOutlet weak var tablePdfListShow: UITableView!
    
    var pdfListMuArray:NSMutableArray=NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoResult.text = ""
        lblNoResult.isHidden=true
        createNavigationBar()
        functionForGetAllDownloadedDocumentFromDirectory()
        // Do any additional setup after loading the view.
    }
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Downloaded Document list"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MontlyPDFListViewControllerViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func functionForGetAllDownloadedDocumentFromDirectory()
    {
        let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        print(dirst)
        if dirst != nil
        {
            let dirt = dirst![0]
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
                print(fileList)
                print(fileList)
                for i in 00 ..< fileList.count
                {
                    //".DS_Store", "Calendar.sqlite", "NewMembers", "NewTouchbase.db", "Profile11072018042245PM.zip
                    let varValue=fileList[i]
                    if(varValue.hasSuffix(".DS_Store") || varValue.hasSuffix(".sqlite") || varValue.hasSuffix(".db") || varValue.hasSuffix(".sqlite-wal") || varValue.hasSuffix(".sqlite-shm") || varValue.hasSuffix("NewMembers") || varValue.hasSuffix(".zip")) 
                    {
                    }
                    else
                    {
                        pdfListMuArray.add(fileList[i])
                    }
                    print(varValue)
                }
            }
            catch
            {
            }
        }
        if(pdfListMuArray.count>0)
        {
            lblNoResult.isHidden=true
        }
        else
        {
            lblNoResult.isHidden=false
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdfListMuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePdfListShow.dequeueReusableCell(withIdentifier: "pdfListMonthTableViewCell", for: indexPath) as! pdfListMonthTableViewCell
        if(pdfListMuArray.count>0)
        {
            let varGetServiceName:String = pdfListMuArray.object(at: indexPath.row) as! String
            cell.lblValue.text = varGetServiceName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select Row")
        let abc = pdfListMuArray.object(at: indexPath.row) as! String
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyPDFViewWebViewController") as! MonthlyPDFViewWebViewController
        secondViewController.URLstr = abc
        secondViewController.iscallFrom = "DownloadList"
        secondViewController.moduleName = "Downloaded Document"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
}
