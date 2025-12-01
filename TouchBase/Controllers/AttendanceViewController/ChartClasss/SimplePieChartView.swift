//
//  SimplePieChartView.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 30/06/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit
/*
struct Segment {
    var color : UIColor
    var value : CGFloat
}

class PieChartView: UIView {
    
    /// An array of tuples representing the colors of the segments, and the values (the ratios will automatically be calculated)
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.size.width, frame.size.height)*0.5
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width*0.5, y: bounds.size.height*0.5)
        
        // enumerate the total value of the segments by using reduce to sum them
        let valueCount = segments.reduce(0) {$0 + $1.value}
        
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat(M_PI*0.5)
        
        for segment in segments { // loop through the values array
            
            // set fill color to the segment color
            ctx?.setFillColor(segment.color.cgColor)
            
            // update the end angle of the segment
            let endAngle = startAngle+CGFloat(M_PI*2)*(segment.value/valueCount)
            
            // move to the center of the pie chart
            ctx?.moveTo(x: viewCenter.x, y: viewCenter.y)
            
            // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
            ctx?.addArc(centerX: viewCenter.x, y: viewCenter.y, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: 0)
            
            // fill segment
            ctx?.fillPath()
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
    }
}*/
