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
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds//.insetBy(dx: 1.0, dy: 1.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            ctx.setFillColor(slider.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
            
            let arrowPath = UIBezierPath()
            
            ctx.setStrokeColor(slider.graphColor.cgColor)
            ctx.setLineWidth(1.0)
            let center = CGPoint(x: thumbFrame.width / 2, y: thumbFrame.height / 2)
            let delta = thumbFrame.width / 5
            let padding: CGFloat = 3.0
            ctx.move(to: CGPoint(x: center.x - padding, y: center.y - delta))
            ctx.addLine(to: CGPoint(x: delta, y: center.y))
            ctx.addLine(to: CGPoint(x: center.x - padding, y: center.y + delta))
            
            ctx.move(to: CGPoint(x: center.x + padding, y: center.y + delta))
            ctx.addLine(to: CGPoint(x: thumbFrame.width - delta, y: center.y))
            ctx.addLine(to: CGPoint(x: center.x + padding, y: center.y - delta))
            
            ctx.addPath(arrowPath.cgPath)
            ctx.strokePath()
            
            if highlited {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }
}
