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
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let path = UIBezierPath()
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.withAlphaComponent(0.4).cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.withAlphaComponent(0.4).cgColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            ctx.fill(rect)
            
            let borderPath = UIBezierPath()
            ctx.move(to: CGPoint(x: lowerValuePosition, y: 0))
            ctx.addLine(to: CGPoint(x: lowerValuePosition, y: bounds.height))
            ctx.move(to: CGPoint(x: upperValuePosition, y: 0))
            ctx.addLine(to: CGPoint(x: upperValuePosition, y: bounds.height))
            ctx.setLineWidth(2)
            ctx.setStrokeColor(slider.trackHighlightTintColor.cgColor)
            ctx.addPath(borderPath.cgPath)
            ctx.strokePath()
            
        }
    }
}
