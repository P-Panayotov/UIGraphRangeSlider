//
//  RangeSliderThumbLayer.swift
//  GraphRangeSlider
//
//  Created by Panayot on 22/08/2016.
//  Copyright © 2016 Panayot Panayotov. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderThumbLayer: CALayer {
    var highlited: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: UIGraphRangeSlider?
    
    override func drawInContext(ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds//.insetBy(dx: 1.0, dy: 1.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            CGContextSetFillColorWithColor(ctx, slider.thumbTintColor.CGColor)
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextFillPath(ctx)
            
            let arrowPath = UIBezierPath()
            
            CGContextSetStrokeColorWithColor(ctx, slider.graphColor.CGColor)
            CGContextSetLineWidth(ctx, 1.0)
            let center = CGPoint(x: thumbFrame.width / 2, y: thumbFrame.height / 2)
            let delta = thumbFrame.width / 5
            let padding: CGFloat = 3.0
            CGContextMoveToPoint(ctx, center.x - padding, center.y - delta)
            CGContextAddLineToPoint(ctx, delta, center.y)
            CGContextAddLineToPoint(ctx, center.x - padding, center.y + delta)
            
            CGContextMoveToPoint(ctx, center.x + padding, center.y + delta)
            CGContextAddLineToPoint(ctx, thumbFrame.width - delta, center.y)
            CGContextAddLineToPoint(ctx, center.x + padding, center.y - delta)
            
            CGContextAddPath(ctx, arrowPath.CGPath)
            CGContextStrokePath(ctx)
            
            if highlited {
                CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
                CGContextAddPath(ctx, thumbPath.CGPath)
                CGContextFillPath(ctx)
            }
        }
    }
}
