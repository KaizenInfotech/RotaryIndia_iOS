//
//  CustomCollectionViewLayout.swift
//  TouchBase
//
//  Created by Umesh on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    let bounds = UIScreen.main.bounds
   //  let width1 = bounds.size.width
    let itemWidth =  110
    let itemSpacing: CGFloat = 10
    var layoutInfo: [IndexPath:UICollectionViewLayoutAttributes] = [IndexPath:UICollectionViewLayoutAttributes]()
    var maxXPos: CGFloat = 0
    
   // var custcl:CustomCollectionViewCell!
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        // setting up some inherited values
        self.itemSize = CGSize(width: ((bounds.size.width/3)-10), height: ((bounds.size.width/3)-10))
        
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = itemSpacing
        self.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        self.scrollDirection = UICollectionView.ScrollDirection.vertical
       
    }
    override func prepare() {
//        layoutInfo = [NSIndexPath:UICollectionViewLayoutAttributes]()
//        for var i = 0; i < self.collectionView?.numberOfItemsInSection(0); i++ {
//            let indexPath = NSIndexPath(forRow: i, inSection: 0)
//            let itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
//            itemAttributes.frame = frameForItemAtIndexPath(indexPath)
//            if itemAttributes.frame.origin.x > maxXPos {
//                maxXPos = itemAttributes.frame.origin.x
//            }
//            layoutInfo[indexPath] = itemAttributes
//        }
    }
    
//    func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
//        let maxHeight = self.collectionView!.frame.height - 20
//        let numRows = floor((maxHeight+self.minimumLineSpacing)/(itemWidth+self.minimumLineSpacing))
//        
//        let currentColumn = floor(CGFloat(indexPath.row)/numRows)
//        let currentRow = (CGFloat(indexPath.row) % numRows)
//        
//        let xPos = currentRow % 2 == 0 ? currentColumn*(itemWidth+self.minimumInteritemSpacing) : currentColumn*(itemWidth+self.minimumInteritemSpacing)+itemWidth*0.25
//        let yPos = currentRow*(itemWidth+self.minimumLineSpacing)+10
//        
//        var rect: CGRect = CGRectMake(xPos, yPos, itemWidth, itemWidth)
//        return rect
//    }
//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
//        return layoutInfo[indexPath]
//    }
//    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
//        
//        for (indexPath, attributes) in layoutInfo {
//            if CGRectIntersectsRect(rect, attributes.frame) {
//                allAttributes.append(attributes)
//            }
//        }
//        
//        return allAttributes
//    }
//    
//    override func collectionViewContentSize() -> CGSize {
//        let collectionViewHeight = self.collectionView!.frame.height
//        let contentWidth: CGFloat = maxXPos + itemWidth
//        
//        return CGSizeMake(contentWidth, collectionViewHeight)
//    }
}
