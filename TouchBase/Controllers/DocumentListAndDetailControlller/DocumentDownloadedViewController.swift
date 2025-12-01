//
//  DocumentDownloadedViewController.swift
//  TouchBase
//
//  Created by Umesh on 03/03/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class DocumentDownloadedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var buttonMessage: UIButton!
    @IBOutlet var tableviewDownloadedDocuments: UITableView!
    var muarrayDownloadedDocument:NSMutableArray=NSMutableArray()
    var muarrayDownloadedDocumentFilePath:NSMutableArray=NSMutableArray()
    var filename = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("document downloaded view controller")
         UserDefaults.standard.setValue("yes", forKey: "session_IsComingFromDownloadedvieworUploadDocumnetScreen")
        functionForGetAllDownloadedDocumentFromDirectory()
        createNavigationBar()
        // Do any additional setup after loading the view.
    }

    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title="Downloaded Documents Lists"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(DocumentDownloadedViewController.buttonBackClickEvent), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func buttonBackClickEvent()
    {
            self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Tableview Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return muarrayDownloadedDocument.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         var cell : DocumentDownloadableTableViewCell!
        cell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DocumentDownloadableTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)![0]as! DocumentDownloadableTableViewCell;
        }
        if(muarrayDownloadedDocument.count>0)
        {
            let varGetServiceName:String = muarrayDownloadedDocument.object(at: indexPath.row) as! String
            let varGetServicePrice:String = muarrayDownloadedDocument.object(at: indexPath.row) as! String
            cell.labelDocsName.text = varGetServiceName
            cell.buttonMain.addTarget(self, action: #selector(DocumentDownloadedViewController.buttonViewDocumentClickEvent(_:)), for: UIControl.Event.touchUpInside)
         
            cell.buttonMain.tag=indexPath.row;
            //if document type .pdf .doc (.png,.jpg,.jpeg,gif) .ppt .html
            if(varGetServiceName .hasSuffix(".pdf"))
            {
                cell.imageDocs.image = UIImage(named:"icon0")
            }
            else  if(varGetServiceName .hasSuffix(".png") || varGetServiceName .hasSuffix(".PNG") || varGetServiceName .hasSuffix(".jpg") || varGetServiceName .hasSuffix(".JPG") || varGetServiceName .hasSuffix(".gif")  || varGetServiceName .hasSuffix(".GIF") || varGetServiceName .hasSuffix(".jpeg") || varGetServiceName .hasSuffix(".JPEG"))
            {
                cell.imageDocs.image = UIImage(named:"icon2")
            }
            else if(varGetServiceName .hasSuffix(".html"))
            {
                 cell.imageDocs.image = UIImage(named:"icon1")
            }
            else if(varGetServiceName .hasSuffix(".ppt"))
            {
                cell.imageDocs.image = UIImage(named:"icon3")
            }
            else if(varGetServiceName .hasSuffix(".doc"))
            {
                cell.imageDocs.image = UIImage(named:"icon5")
            }
            else if(varGetServiceName .hasSuffix(".txt"))
            {
                cell.imageDocs.image = UIImage(named:"text")
            }
            else if(varGetServiceName .hasSuffix(".mp4") || varGetServiceName .hasSuffix(".mov"))
            {
                cell.imageDocs.image = UIImage(named:"mp4")
            }
            else if(varGetServiceName .hasSuffix(".mp3"))
            {
                cell.imageDocs.image = UIImage(named:"mp3")
            }
            
        }
        return cell as DocumentDownloadableTableViewCell
        }
    
    
    @objc func buttonViewDocumentClickEvent(_ sender:UIButton)
    {
        let objDocumentDownloadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DownloadedDocViewViewController") as! DownloadedDocViewViewController
        objDocumentDownloadedViewController.IsComingNewShowCase="yes"
        objDocumentDownloadedViewController.filename=String(muarrayDownloadedDocumentFilePath.object(at: sender.tag) as! String)+"/"+(muarrayDownloadedDocument.object(at: sender.tag) as! String)

        self.navigationController?.pushViewController(objDocumentDownloadedViewController, animated: true)

    }
    /*---------------*/
   
   // var filePath:String!=""
    func functionForGetAllDownloadedDocumentFromDirectory()
    {
     let fileManager = FileManager.default
     let dirst = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        print(dirst)
        if dirst != nil
        {
            let dirt = dirst![0]
            do {
               // filePath=dirt
                let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)
                print(fileList)
                print(fileList)
                
                for i in 00 ..< fileList.count
                {
                    let varValue=fileList[i]
                    print(varValue)
                    if(varValue.hasSuffix(".sqlite") || varValue.hasSuffix(".db") || varValue.hasSuffix(".sqlite-wal") || varValue.hasSuffix(".sqlite-shm") || varValue.hasSuffix("NewMembers") || varValue.hasSuffix(".DS_Store") || varValue.hasSuffix(".zip") || varValue.hasSuffix(".zip") || varValue.contains("shm") || varValue.contains(".WebKit.Networking") || varValue.contains(".Snapshots") || varValue.contains("WebKit") || varValue.contains(".FIRClearcutLogger") || varValue.contains("var") || varValue.contains("default") || varValue.contains(".kaizen.row") || varValue.contains("NewsLetterDirectory") || varValue.contains("WebKit.WebContent") ||  varValue.contains("TestDirector") || varValue.contains("TestDirecto") || varValue.contains("Snapshots") || varValue.contains("-wal") || varValue.contains("-wal") || varValue.contains("FIRC") || varValue.contains("com.apple"))
                    {
                        
                    }
                    else
                    {
                    muarrayDownloadedDocumentFilePath.add(dirt)
                    muarrayDownloadedDocument.add(fileList[i])
                    }
                }
            }
            catch
            {
            }
        }



        let dirst1 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        print("*******************************************--***********")
        print(dirst1)
        if dirst1 != nil
        {
            let dirt = dirst1![0]
            do {
                //filePath=dirt
                let fileList = try FileManager.default.contentsOfDirectory(atPath: dirt)

                for i in 00 ..< fileList.count
                {
                    let varValue=fileList[i]
                    print(varValue)
                    if(varValue.hasSuffix(".sqlite") || varValue.hasSuffix(".db") || varValue.hasSuffix(".sqlite-wal") || varValue.hasSuffix(".sqlite-shm") || varValue.hasSuffix("NewMembers") || varValue.hasSuffix(".DS_Store") || varValue.hasSuffix(".zip") || varValue.hasSuffix(".zip") || varValue.contains("shm") || varValue.contains(".WebKit.Networking") || varValue.contains(".Snapshots") || varValue.contains("WebKit") || varValue.contains(".FIRClearcutLogger") || varValue.contains("var") || varValue.contains("default") || varValue.contains(".kaizen.row") || varValue.contains("NewsLetterDirectory") || varValue.contains("WebKit.WebContent") ||  varValue.contains("TestDirector") || varValue.contains("TestDirecto") || varValue.contains("Snapshots") || varValue.contains("-wal") || varValue.contains("-wal") || varValue.contains("FIRC") || varValue.contains("com.apple"))
                    {
                        
                    }
                    else
                    {
                    muarrayDownloadedDocumentFilePath.add(dirt)
                    muarrayDownloadedDocument.add(fileList[i])
                    }
                }
            }
            catch
            {
            }
        }


        if(muarrayDownloadedDocument.count>0)
        {
            buttonMessage.isHidden=true
        }
        else
        {
            buttonMessage.isHidden=false

        }
    }
}
