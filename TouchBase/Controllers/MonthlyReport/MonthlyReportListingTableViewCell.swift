//
//  MonthlyReportListingTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 06/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class MonthlyReportListingTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var labelMonth: UILabel!
    
    
    
    @IBOutlet weak var buttonMainMonthlyReport: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCellServicesProviderList(_ muarrayData:NSDictionary)
    {
        
        print(muarrayData)
       // labelMonth.text=muarrayData.objectAtIndex(0) as! String
      
    }
    

}
