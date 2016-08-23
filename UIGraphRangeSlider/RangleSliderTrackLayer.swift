//
//  RangleSliderTrackLayer.swift
//  GraphRangeSlider
//
//  Created by Panayot on 22/08/2016.
//  Copyright © 2016 Panayot Panayotov. All rights reserved.
//

import UIKit
import QuartzCore

class RangleSliderTrackLayer: CALayer {
    weak var rangeSlider: UIGraphRangeSlider?
    
    override func drawInContext(ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let path = UIBezierPath()
            CGContextAddPath(ctx, path.CGPath)
            
            // Fill the track
            CGContextSetFillColorWithColor(ctx, slider.trackTintColor.colorWithAlphaComponent(0.4).CGColor)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            // Fill the highlighted range
            CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.colorWithAlphaComponent(0.4).CGColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            CGContextFillRect(ctx, rect)
            
            let borderPath = UIBezierPath()
            CGContextMoveToPoint(ctx, lowerValuePosition, 0)
            CGContextAddLineToPoint(ctx, lowerValuePosition, bounds.height)
            CGContextMoveToPoint(ctx, upperValuePosition, 0)
            CGContextAddLineToPoint(ctx, upperValuePosition, bounds.height)
            CGContextSetLineWidth(ctx, 2)
            CGContextSetStrokeColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
            CGContextAddPath(ctx, borderPath.CGPath)
            CGContextStrokePath(ctx)
            
        }
    }
}
