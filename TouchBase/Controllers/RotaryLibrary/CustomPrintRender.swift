//
//  CustomPrintPageRenderer.swift
//  TouchBase
//
//  Created by abc on 28/05/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import Foundation

 class CustomPrintRender: UIPrintPageRenderer {
    var footerImage:UIImage = UIImage()
    var titleLabel:UILabel = UILabel()
    override init() {
        super.init()
    }

    override func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        let footerImage:UIImage=UIImage(named: "common_footer.jpg")!
        print("Origin y: \(footerRect.height):::\(footerRect.height-50)")
        let  rect:CGRect=CGRect(x:0, y:footerRect.height-50, width:footerRect.width,height:50.0)
        footerImage.draw(in: rect)
     }
    
    
    
    override func drawHeaderForPage(at pageIndex: Int, in headerRect: CGRect) {
        let HeaderImage:UIImage=UIImage(named: "rt_header.jpg")!
        let  rect:CGRect=CGRect(x:0, y:0, width:headerRect.width,height:90.0)
        HeaderImage.draw(in: rect)

}
    
    
 }
