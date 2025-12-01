//
//  ViewPager.swift
//  ViewPager
//
//  Created by Septiyan Andika on 6/26/16.
//  Copyright © 2016 sailabs. All rights reserved.
//

import UIKit

@objc public protocol  ViewPagerDataSource {
    func numberOfItems(_ viewPager:ViewPager) -> Int
    func viewAtIndex(_ viewPager:ViewPager, index:Int, view:UIView?) -> UIView
    @objc optional func didSelectedItem(_ index:Int)
    
}

 open class ViewPager: UIView {
    
    var pageControl:UIPageControl = UIPageControl()
    var scrollView:UIScrollView = UIScrollView()
    var currentPosition:Int = 0
    
    var dataSource:ViewPagerDataSource? = nil {
        didSet {
            reloadData()
        }
    }
    
    var numberOfItems:Int = 0
    var itemViews:Dictionary<Int, UIView> = [:]
    
    required  public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        setupScroolView();
        setupPageControl();
        reloadData()
    }
    
    func setupScroolView() {
        scrollView.isPagingEnabled = true;
        scrollView.alwaysBounceHorizontal = false
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self;
        let topContraints = NSLayoutConstraint(item: scrollView, attribute:
            .top, relatedBy: .equal, toItem: self,
                  attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0,
                  constant: 0)
        
        let bottomContraints = NSLayoutConstraint(item: scrollView, attribute:
            .bottom, relatedBy: .equal, toItem: self,
                     attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0,
                     constant: 0)
        
        let leftContraints = NSLayoutConstraint(item: scrollView, attribute:
            .leadingMargin, relatedBy: .equal, toItem: self,
                            attribute: .leadingMargin, multiplier: 1.0,
                            constant: 0)
        
        let rightContraints = NSLayoutConstraint(item: scrollView, attribute:
            .trailingMargin, relatedBy: .equal, toItem: self,
                             attribute: .trailingMargin, multiplier: 1.0,
                             constant: 0)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topContraints,rightContraints,leftContraints,bottomContraints])
       // NSLayoutConstraint.activate([topContraints,rightContraints,leftContraints,bottomContraints])
        //NSLayoutConstraint.activate = [topContraints,rightContraints,leftContraints,bottomContraints]
    }
    
    
    func setupPageControl() {
        self.pageControl.numberOfPages = numberOfItems
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor =   UIColor.darkGray
        //UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        
        
        let heightContraints = NSLayoutConstraint(item: pageControl, attribute:
            .height, relatedBy: .equal, toItem: nil,
                     attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0,
                     constant: 25)
        
        let bottomContraints = NSLayoutConstraint(item: pageControl, attribute:
            .bottom, relatedBy: .equal, toItem: self,
                     attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0,
                     constant: 0)
        
        let leftContraints = NSLayoutConstraint(item: pageControl, attribute:
            .leadingMargin, relatedBy: .equal, toItem: self,
                            attribute: .leadingMargin, multiplier: 1.0,
                            constant: 0)
        
        let rightContraints = NSLayoutConstraint(item: pageControl, attribute:
            .trailingMargin, relatedBy: .equal, toItem: self,
                             attribute: .trailingMargin, multiplier: 1.0,
                             constant: 0)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        //NSLayoutConstraint.activate([heightContraints,rightContraints,leftContraints,bottomContraints])
        NSLayoutConstraint.activate([heightContraints,rightContraints,leftContraints,bottomContraints])
    }
    
    func reloadData() {
        if(dataSource != nil){
            numberOfItems = (dataSource?.numberOfItems(self))!
        }
        self.pageControl.numberOfPages = numberOfItems
        itemViews.removeAll()
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width *  CGFloat(self.numberOfItems) , height: self.scrollView.frame.height)
                 self.reloadViews(0)
            }
        }
  
//        DispatchQueue.main.async {
//            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width *  CGFloat(self.numberOfItems) , height: self.scrollView.frame.height)
//            self.reloadViews(0)
//        }
    }
    
    func loadViewAtIndex(_ index:Int){
        let view:UIView?
        if(dataSource != nil){
            view =  (dataSource?.viewAtIndex(self, index: index, view: itemViews[index]))!
        }else{
            view = UIView()
        }
        setFrameForView(view!, index: index);
        if(itemViews[index] == nil){
            itemViews[index] = view
            let tap = UITapGestureRecognizer(target: self, action:  #selector(self.handleTapSubView))
            tap.numberOfTapsRequired = 1
            itemViews[index]!.addGestureRecognizer(tap)
            scrollView.addSubview(itemViews[index]!)
        }else{
            itemViews[index] = view
        }
    }
    
    @objc func handleTapSubView() {
        if(dataSource?.didSelectedItem != nil){
           // print("fhfghgfhfghfg",currentPosition)
            dataSource?.didSelectedItem!(currentPosition)
        }
    }
    
    func reloadViews(_ index:Int){
        for i in (index-1)...(index) {
            if(i>=0 && i<numberOfItems){
                loadViewAtIndex(i)
               // print(i)
            }
        }
    }
    func setFrameForView(_ view:UIView,index:Int){
        view.frame = CGRect(x: self.scrollView.frame.width*CGFloat(index), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height);
    }
    var timer = Timer()
}

extension ViewPager:UIScrollViewDelegate {
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        var pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
       // print(pageNumber)
        pageNumber = pageNumber + 1
        pageControl.currentPage = Int(pageNumber)
        currentPosition = pageControl.currentPage
        scrollToPage(Int(pageNumber))
    }
    
    //http://stackoverflow.com/a/1857162
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: scrollView)
        ///self.perform(#selector(self.scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0.3)
        self.perform(#selector(ViewPager.scrollViewDidEndScrollingAnimation), with: scrollView, afterDelay: 1.0)
    }
}

extension ViewPager{
    
    func animationNext(){
        //NSTimer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewPager.moveToNextPage), userInfo: nil, repeats: true)
       // NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ViewPager.moveToNextPage), userInfo: nil, repeats: true)
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewPager.moveToNextPage), userInfo: nil, repeats: true)
        
    }
    
    @objc func moveToNextPage (){
        if(currentPosition <= numberOfItems && currentPosition >= 0) {
            scrollToPage(currentPosition)
            currentPosition = currentPosition + 1
            if currentPosition > numberOfItems {
                currentPosition = 1
            }
        }
    }
    
    func scrollToPage(_ index:Int) {
        if(index <= numberOfItems && index > 0) {
            let zIndex = index - 1
            let iframe = CGRect(x: self.scrollView.frame.width*CGFloat(zIndex), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height);
            scrollView.setContentOffset(iframe.origin, animated: true)
            pageControl.currentPage = zIndex
            reloadViews(zIndex)
            currentPosition = index
        }
    }
    
}
