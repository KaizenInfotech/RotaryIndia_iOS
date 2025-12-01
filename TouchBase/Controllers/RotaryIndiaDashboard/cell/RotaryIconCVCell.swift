//
//  RotaryIconCVCell.swift
//  TouchBase
//
//  Created by IOS 2 on 22/09/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit

protocol NavigateIconCell: AnyObject {
    func findClub()
    func findRotarian()
    func referFriend()
    func webView(url: String?, title: String?)
}

class RotaryIconCVCell: UICollectionViewCell {
    
    @IBOutlet weak var iconCollView: UICollectionView!
    var navigateIconCellDelegate: NavigateIconCell?
    var headTitle = ""
    
    var iconImg = ["supportClub","find_club_newdash","find_rotarian_newdash","referFriend","imp_websites_newdash","india_leaders_newdash","district_governors_newdash","regional_leaders_newdash","rotary_news_trust_newdash","rotary_news_newdash","blog_newdash","search_projects_newdash"]
    
    var iconTitle = ["BeyondSure","Club Finder","Find a Rotarian","Refer A Friend","Important Websites","India Leaders","District Governors","Regional Leaders","Rotary News Trust","Rotary News","Blog","Search Projects"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
    }
    
    func register() {
        iconCollView.delegate = self
        iconCollView.dataSource = self
        iconCollView.register(UINib(nibName: "RotaryIconCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RotaryIconCellCollectionViewCell")
    }

}

extension RotaryIconCVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RotaryIconCellCollectionViewCell", for: indexPath) as? RotaryIconCellCollectionViewCell
        else { return UICollectionViewCell() }
        cell.iconImgView.image = UIImage(named: iconImg[indexPath.row])
        cell.iconLbl.text = iconTitle[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.size.width) / 5), height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
//            return webView(url: "https://supportclubs.rotaryindia.org/", title: "Insure to Impact")
            return webView(url: "https://supportclubs.rotaryindia.org/customer/login", title: "BeyondSure")
            
        case 1:
            return findClub()
        case 2:
            return findRotarian()
        case 3:
            return referFriend()
        case 4:
            return webView(url: "https://www.rotaryindia.org/Website.aspx", title: "Important Websites")
        case 5:
            return webView(url: "https://www.rotaryindia.org/OurLeaders.aspx", title: "India Leaders")
        case 6:
            return webView(url: "https://www.rotaryindia.org/District-Governor.aspx", title: "District Governors")
        case 7:
            return webView(url: "https://www.rotaryindia.org/RegionalLeaders.aspx", title: "Regional Leaders")
        case 8:
            return webView(url: "https://rotarynewsonline.org/", title: "Rotary News Trust")
        case 9:
            return webView(url: "https://www.rotary.org/en/news-features", title: "Rotary News")
        case 10:
            return webView(url: "https://blog.rotary.org/", title: "Blog")
        case 11:
            return webView(url: "http://showcase.rotaryindia.org/", title: "\(self.headTitle) Projects")
            
        default:
            break
        }
    }
}

extension RotaryIconCVCell {
    
    func findClub() {
        navigateIconCellDelegate?.findClub()
    }
    
    func findRotarian() {
        navigateIconCellDelegate?.findRotarian()
    }
    
    func referFriend() {
        navigateIconCellDelegate?.referFriend()
    }
    
    func webView(url: String?, title: String?) {
        navigateIconCellDelegate?.webView(url: url, title: title)
    }
    
}
