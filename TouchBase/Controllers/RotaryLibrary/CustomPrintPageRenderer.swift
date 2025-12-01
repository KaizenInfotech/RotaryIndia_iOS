//
//  CustomPrintPageRenderer.swift
//  TouchBase
//
//  Created by abc on 28/05/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import Foundation
import WebKit
 class CustomPrintPageRenderer: UIPrintPageRenderer {
    var customeWebView:WKWebView=WKWebView()
    
    override init() {
        super.init()
    }
    
    func getWebView(webView:WKWebView)
    {
        self.customeWebView=webView
    }

    override func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        let footerImage:UIImage=UIImage(named: "common_footer.jpg")!
        print("Origin y: \(footerRect.height):::\(footerRect.height-50)")
        let  rect:CGRect=CGRect(x:0, y:footerRect.height-70, width:footerRect.width,height:70.0)
        footerImage.draw(in: rect)
        
     }

    
    override func drawHeaderForPage(at pageIndex: Int, in headerRect: CGRect) {
        let footerImage:UIImage=UIImage(named: "rt_header.jpg")!
        let  rect:CGRect=CGRect(x:0, y:0, width:headerRect.width,height:90.0)
        footerImage.draw(in: rect)
    }

    func getTextSize(text: String, font: UIFont!, textAttributes: [String: AnyObject]! = nil) -> CGSize {
        let testLabel = UILabel(frame: CGRect(x:0.0, y:0.0,width: self.paperRect.size.width,height: footerHeight))
        if let attributes = textAttributes {
//            testLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
        else {
            testLabel.text = text
            testLabel.font = font!
        }
        
        testLabel.sizeToFit()
        
        return testLabel.frame.size
    }
}

