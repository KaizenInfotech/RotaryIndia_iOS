//
//  EditProfileViewController.swift
//  TouchBase
//
//  Created by IOS 2 on 05/10/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController {

    @IBOutlet weak var editProfileTableView: UITableView!
    
    var sectionss = [EditProfileSection]()
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadEditProfile()
        register()
        configure()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Edit Profile"
    }
    
    func register() {
        editProfileTableView.register(UINib(nibName: "PersonalDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonalDetailsTableViewCell")
        editProfileTableView.register(UINib(nibName: "BusinessDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessDetailsTableViewCell")
        editProfileTableView.register(UINib(nibName: "RotarydetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "RotarydetailsTableViewCell")
        editProfileTableView.register(UINib(nibName: "FamilyDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyDetailsTableViewCell")
    }
    
    func configure() {
        sectionss.append(.personalDetail)
        sectionss.append(.businessDetail)
        sectionss.append(.rotaryDetail)
        sectionss.append(.familyDetail)
    }
 }

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionss.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sections = sectionss[section]
        switch sections {
        case .personalDetail:
            return 1
        case .businessDetail:
            return 1
        case .rotaryDetail:
            return 1
        case .familyDetail:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = sectionss[indexPath.section]
        switch sections {
        case .personalDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDetailsTableViewCell", for: indexPath) as? PersonalDetailsTableViewCell
            else{return UITableViewCell()}
            return cell
        case .businessDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessDetailsTableViewCell", for: indexPath) as? BusinessDetailsTableViewCell
            else{return UITableViewCell()}
            return cell
        case .rotaryDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RotarydetailsTableViewCell", for: indexPath) as? RotarydetailsTableViewCell
            else{return UITableViewCell()}
            return cell
        case .familyDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyDetailsTableViewCell", for: indexPath) as? FamilyDetailsTableViewCell
            else{return UITableViewCell()}
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sections = sectionss[indexPath.section]
        switch sections {
        case .personalDetail:
            return 400
        case .businessDetail:
            return 550
        case .rotaryDetail:
            return 1908
        case .familyDetail:
            return 200
        }
    }
    
}

//extension EditProfileViewController {
//    func loadEditProfile() {
//
//        var masterUId = UserDefaults.standard.string(forKey: "masterUID")
//        let parameterst = ["fk_main_member_master_id": masterUId!,"&isadmin": userId]
//        let completeURL = editUrl
//
//        print(completeURL)
//        print(parameterst)
//        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
//
//            print(response)
//            var loadedDataResult = response
//
//        }
//    )}
//}

enum EditProfileSection {
    case personalDetail
    case businessDetail
    case rotaryDetail
    case familyDetail
}
