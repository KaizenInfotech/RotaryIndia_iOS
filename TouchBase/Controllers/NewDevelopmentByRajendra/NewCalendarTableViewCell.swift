//
//  NewCalendarTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 08/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewCalendarTableViewCell: UITableViewCell {
    
    //MARK:- variable
    var lastDateValueForMAtching:String!=""
    //MARK:- IB
    @IBOutlet weak var viewAll: UIView!
    
    
    //@IBOutlet weak var viewRepeat: UIView!
    @IBOutlet weak var labelPersonNameRepeat: UILabel!
    
    
    @IBOutlet weak var datLbl: UILabel!
    @IBOutlet weak var secDateLbl: UILabel!
    
    @IBOutlet weak var buttonEventTapClickEvent: UIButton!
    
    @IBOutlet weak var buttonEventArrows: UIButton!
    
    @IBOutlet weak var labelDate: UILabel!
    //  @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelPersonName: UILabel!
    @IBOutlet weak var buttonCall: UIButton!
    
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    
    
    @IBOutlet weak var buttonSMS: UIButton!
    @IBOutlet weak var buttoEmail: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    //MARK:- cell for bind tableview
    func configureCellServicesProviderList(_ dict:NSDictionary,indexpath:Int)
    {
        
        
    }
    
}
