//
//  QRCodeViewController.swift
//  TouchBase
//
//  Created by IOS 2 on 03/06/24.
//  Copyright © 2024 Parag. All rights reserved.
//

import UIKit
import Contacts

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var qrBarImage: UIImageView!
    var contact: CNContact!
    var memName = ""
    var bussName = ""
    var mobile = ""
    var memEmail = ""
    var bMail = ""
    var baddresses = ""
    var bcity = ""
    var bstate = ""
    var bpostalCode = ""
    var bcountry = ""
    var fb = ""
    var insta = ""
    var web = ""
    var twit = ""
    var yt = ""
    var lnkd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("QRCODE1---------\(self.memName)")
        print("QRCODE2---------\(self.web)")
        print("QRCODE3---------\(self.mobile)")
        print("QRCODE4---------\(self.memEmail)")
        
        let contact = CNMutableContact()
        contact.givenName = self.memName
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: self.mobile))]
        
        let workEmail = CNLabeledValue(label: CNLabelWork, value: bMail as NSString)
        let homeEmail = CNLabeledValue(label: CNLabelHome , value: memEmail as NSString)
        contact.emailAddresses = [homeEmail, workEmail]
        
        let address = CNMutablePostalAddress()
        address.street = baddresses
        address.city = bcity
        address.state = bstate
        address.country = bcountry
        address.postalCode = bpostalCode
        let workAddress = CNLabeledValue<CNPostalAddress>(label:CNLabelWork, value:address)
        contact.postalAddresses = [workAddress]
        
        let facebookProfile = CNSocialProfile(urlString: fb,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: CNSocialProfileServiceFacebook)
        let facebookProfileValue = CNLabeledValue(label: CNSocialProfileServiceFacebook, value: facebookProfile)
        let twitProfile = CNSocialProfile(urlString: twit,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: CNSocialProfileServiceTwitter)
        let twitProfileValue = CNLabeledValue(label: CNSocialProfileServiceTwitter, value: twitProfile)
        let lnkdProfile = CNSocialProfile(urlString: lnkd,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: CNSocialProfileServiceLinkedIn)
        let lnkdProfileValue = CNLabeledValue(label: CNSocialProfileServiceLinkedIn, value: lnkdProfile)
        let webProfile = CNSocialProfile(urlString: web,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: "website")
        let webProfileValue = CNLabeledValue(label: "website", value: webProfile)
        let ytProfile = CNSocialProfile(urlString: yt,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: "youtube")
        let ytProfileValue = CNLabeledValue(label: "youtube", value: ytProfile)
        let instaProfile = CNSocialProfile(urlString: insta,
                                              username: nil,
                                              userIdentifier: nil,
                                              service: "instagram")
        let instaProfileValue = CNLabeledValue(label: "instagram", value: instaProfile)
        contact.socialProfiles = [facebookProfileValue,twitProfileValue,lnkdProfileValue,webProfileValue,ytProfileValue,instaProfileValue]
        
        self.contact = contact
        
        // Generate QR code
        if let qrCodeImageDetail = makeQRCode(for: self.contact) {
            qrBarImage.image = qrCodeImageDetail
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeQRCode(for contact: CNContact) -> UIImage? {
        let vCardString = contact.toVCard()
        guard let data = vCardString.data(using: .ascii) else { return nil }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

extension CNContact {
    func toVCard() -> String {
        let vCardData = try! CNContactVCardSerialization.data(with: [self])
        print(vCardData)
        return String(data: vCardData, encoding: .utf8) ?? ""
    }
}
