//
//  PageScrollViewController.swift
//  TouchBase
//
//  Created by Umesh on 27/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class PageScrollViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet var ImageDetailTableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       ImageDetailTableView.backgroundColor = UIColor.white
        if (section == 0)
        {
            return 1;
        }
        else
        {
        return 0;
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = ImageDetailTableView.dequeueReusableCell(withIdentifier: "PageScrollViewCell", for: indexPath) as! PageScrollViewCell
        
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 325.0
    }

}
