//
//  CustumiseMyModuleViewController.swift
//  TouchBase
//
//  Created by Umesh on 02/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class CustumiseMyModuleViewController: UIViewController,webServiceDelegate,UICollectionViewDataSource,UICollectionViewDelegate{
    var moduleList:GroupResult!
    @IBOutlet weak var collectionView: UICollectionView!
    var allmoduleCAtArry:NSArray!
    fileprivate let cellIdentifier = "collectionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        wsm.delegates=self
        wsm.GetallmodulesofGroupsOFUSer(moduleList.grpId as! NSString,memberProfileId: moduleList.grpProfileId as! NSString)
        // Do any additional setup after loading the view.
    }
    func getmoduleGroupsOFUSerSuccss(_ string:TBGetGroupModuleResult){
        //menuTitles=strin
        allmoduleCAtArry=string.groupListResult as! NSArray
        let predicate = NSPredicate(format: "isCustomized = %@", "Yes")
        collectionView.reloadData()
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.title=String(self.moduleList.grpName)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.navigationController?.navigationBar.ti = UIColor.whiteColor()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return allmoduleCAtArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        var grp:GroupList!
        grp=allmoduleCAtArry[indexPath.row] as! GroupList
        cell.grpName.text=grp.moduleName
        cell.moduleStaticRef=grp.moduleStaticRef as! NSString
        cell.moduleId=grp.moduleId as! NSString
        cell.moduleIcon.image = UIImage(named: grp.image)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
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
