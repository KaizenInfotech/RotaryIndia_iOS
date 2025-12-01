//
//  DropBoxController.swift
//  TouchBase
//
//  Created by Kaizan on 21/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class DropBoxController: UIViewController , DBRestClientDelegate {
    @IBOutlet var tableViewData: UITableView!
    @IBOutlet var loginButton: UIButton!
    var dropboxMetadata: DBMetadata!
    var dbRestClient: DBRestClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar()
        tableViewData.hidden = true
        if DBSession.sharedSession().isLinked() {
            initDropboxRestClient()
            tableViewData.hidden = false
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleDidLinkNotification:", name: "didLinkToDropboxAccountNotification", object: nil)
    }
    
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "DropBox"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
        let buttonleft = UIButton(type: UIButtonType.Custom)
        buttonleft.frame = CGRectMake(0, 0, 30, 40)
        buttonleft.setImage(UIImage(named:"back_btn"), forState: UIControlState.Normal)
        buttonleft.addTarget(self, action: "backClicked", forControlEvents: UIControlEvents.TouchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
    
    func backClicked()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func initDropboxRestClient() {
        dbRestClient = DBRestClient(session: DBSession.sharedSession())
        dbRestClient.delegate = self
        
     //   dbRestClient.
        
        dbRestClient.loadMetadata("/")
        print(dbRestClient.loadMetadata("/"))
    }
    
    func handleDidLinkNotification(notification: NSNotification) {
        initDropboxRestClient()
//        self.title = "Disconnect"
    }
    
    
    @IBAction func connectToDropbox(sender: AnyObject) {
//        if !DBSession.sharedSession().isLinked() {
//            DBSession.sharedSession().linkFromController(self)
//            
////            self.title =  "Connect"
//            tableViewData.hidden = false
//            
//        }
//        else {
//            DBSession.sharedSession().unlinkAll()
//            // bbiConnect.title = "Connect"
//            dbRestClient = nil
//        }
        
        
        
    }
    
    
//    @IBAction func performAction(sender: AnyObject) {
//        if !DBSession.sharedSession().isLinked() {
//            print("You're not connected to Dropbox")
//            return
//        }
//        
//        let actionSheet = UIAlertController(title: "Upload file", message: "Select file to upload", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//        let uploadTextFileAction = UIAlertAction(title: "Upload text file", style: UIAlertActionStyle.Default) { (action) -> Void in
//            
//            let uploadFilename = "testtext.txt"
//            let sourcePath = NSBundle.mainBundle().pathForResource("testtext", ofType: "txt")
//            let destinationPath = "/"
//            
//            self.dbRestClient.uploadFile(uploadFilename, toPath: destinationPath, withParentRev: nil, fromPath: sourcePath)
//        }
//        
//        let uploadImageFileAction = UIAlertAction(title: "Upload image", style: UIAlertActionStyle.Default) { (action) -> Void in
//            
//            let uploadFilename = "nature.jpg"
//            let sourcePath = NSBundle.mainBundle().pathForResource("nature", ofType: "jpg")
//            let destinationPath = "/"
//            
//            self.dbRestClient.uploadFile(uploadFilename, toPath: destinationPath, withParentRev: nil, fromPath: sourcePath)
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
//            
//        }
//        
//        actionSheet.addAction(uploadTextFileAction)
//        actionSheet.addAction(uploadImageFileAction)
//        actionSheet.addAction(cancelAction)
//        
//        presentViewController(actionSheet, animated: true, completion: nil)
//    }
    
//    @IBAction func reloadFiles(sender: AnyObject) {
//        dbRestClient.loadMetadata("/")
//    }
//    
//    func restClient(client: DBRestClient!, uploadedFile destPath: String!, from srcPath: String!, metadata: DBMetadata!) {
//        print("The file has been uploaded.")
//        print(metadata.path)
//        
//        dbRestClient.loadMetadata("/")
//    }
//    
//    func restClient(client: DBRestClient!, uploadFileFailedWithError error: NSError!) {
//        print("File upload failed.")
//        print(error.description)
//    }
    
    
    func restClient(client: DBRestClient!, loadedMetadata metadata: DBMetadata!) {
        print(metadata)
        print(client)
        dropboxMetadata = metadata;
        tableViewData.reloadData()
    }
    
    func restClient(client: DBRestClient!, loadMetadataFailedWithError error: NSError!) {
        print("loadMetadataFailedWithError\(error.description)")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let metadata = dropboxMetadata {
            return metadata.contents.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        print(dropboxMetadata.contents.count)
         print(dropboxMetadata.contents)
        let currentFile: DBMetadata = dropboxMetadata.contents[indexPath.row] as! DBMetadata
        print(currentFile.dictionaryWithValuesForKeys(<#T##keys: [String]##[String]#>))
        cell.textLabel?.text = currentFile.filename
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedFile: DBMetadata = dropboxMetadata.contents[indexPath.row] as! DBMetadata
        
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        
        dbRestClient.loadFile(selectedFile.path, intoPath: documentsDirectoryPath as String)
        
        
        print(selectedFile)
        print(documentsDirectoryPath)
        print(selectedFile.path)
        
        
        
        //        let url = NSBundle.mainBundle().URLForResource("tb_preloader8", withExtension: "gif")
        //
        //        let gifView = UIImageView()
        //        gifView.frame = CGRectMake((Loadingview.frame.size.width/2)-50, (Loadingview.frame.size.height/2)-50, 100, 100)
        //        gifView.image = UIImage.animatedImageWithAnimatedGIFData(NSData(contentsOfURL: url!)!)
        //        gifView.backgroundColor = UIColor.clearColor()
        //        Loadingview.addSubview(gifView)
        
    }
    
    func restClient(client: DBRestClient!, loadedFile destPath: String!, contentType: String!, metadata: DBMetadata!) {
        print("The file \(metadata.filename) was downloaded. Content type: \(contentType)")
        
    }
    
    func restClient(client: DBRestClient!, loadFileFailedWithError error: NSError!) {
        print("loadFileFailedWithError \(error.description)")
        
    }
}


