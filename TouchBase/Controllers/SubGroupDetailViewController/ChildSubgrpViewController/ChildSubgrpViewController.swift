//
//  ChildSubgrpViewController.swift
//  TouchBase
//
//  Created by Umesh on 31/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class ChildSubgrpViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var subgrpTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = subgrpTableView.dequeueReusableCell(withIdentifier: "childcell", for: indexPath) as! ChildSubgrpCell
        
//        var directoryList = SubgrpMemberDetail()
//        directoryList = mainArray.objectAtIndex(indexPath.row) as! SubgrpMemberDetail
//        
//        cell.nameLabel.text   =  directoryList.memname  //nameTitles[indexPath.row]
//        cell.mobileLabel.text =  directoryList.mobile
        
        
        return cell
        
    }

    override func didReceiveMemoryWarning()
    {
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
