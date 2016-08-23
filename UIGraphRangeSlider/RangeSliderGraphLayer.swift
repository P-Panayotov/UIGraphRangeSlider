//
//  RangeSliderGraphLayer.swift
//  GraphRangeSlider
//
//  Created by Panayot on 22/08/2016.
//  Copyright © 2016 Panayot Panayotov. All rights reserved.
//

import UIKit

class RangeSliderGraphLayer: CALayer {
    weak var rangleSlider: UIGraphRangeSlider?
    
    override func drawInContext(ctx: CGContext) {
        //Draw the graph points
        if let slider = self.rangleSlider {
            
            //3 - set up the color space
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            //4 - set up the color stops
            let colorLocations:[CGFloat] = [0.0, 1.0]
            
            //5 - create the gradient
            let gradient = CGGradientCreateWithColors(colorSpace,
                                                      [slider.graphColor.CGColor, slider.graphColor.CGColor],
                                                      colorLocations)
            
            //6 - draw the gradient
            var startPoint = CGPoint.zero
            var endPoint = CGPoint(x:0, y:self.bounds.height)
            
            
            
            let margin = slider.thumbWidth / 2
            let columnXPoint = { (column: Int) -> CGFloat in
                // Calculate gap between points
                let spacer = (slider.bounds.width - margin * 2 - 4) /
                    CGFloat(slider.graphPoints.count - 1)
                var x:CGFloat = CGFloat(column) * spacer
                x += margin + 2
                return x
            }
            
            let topBorder:CGFloat = 20
            let bottomBorder:CGFloat = 5
            let graphHeight = slider.bounds.height - topBorder - bottomBorder
            let maxValue = slider.graphPoints.maxElement()
            let columnYPoint = { (graphPoint:Int) -> CGFloat in
                var y:CGFloat = CGFloat(graphPoint) /
                    CGFloat(maxValue ?? 0) * graphHeight
                y = graphHeight + topBorder - y // Flip the graph
                return y
            }
            
            
            //set up the points line
            let graphPath = UIBezierPath()
            //go to start of line
            let startingX = columnXPoint(0)
            graphPath.moveToPoint(CGPoint(x:startingX,
                y:columnYPoint(slider.graphPoints[0])))
            //add points for each item in the graphPoints array
            //at the correct (x, y) for the point
            for i in 1..<slider.graphPoints.count {
                let nextPoint = CGPoint(x:columnXPoint(i),
                                        y:columnYPoint(slider.graphPoints[i]))
                graphPath.addLineToPoint(nextPoint)
            }
            
            CGContextSaveGState(ctx)
            let clipPath = graphPath.copy() as! UIBezierPath

            clipPath.addLineToPoint(CGPoint(
                x: columnXPoint(slider.graphPoints.count - 1),
                y:bounds.height))
            clipPath.addLineToPoint(CGPoint(
                x:columnXPoint(0),
                y:bounds.height))
            
            CGContextAddPath(ctx, clipPath.CGPath)
            CGContextClip(ctx)
            let highestYPoint = columnYPoint(maxValue!)
            startPoint = CGPoint(x:margin, y: highestYPoint)
            endPoint = CGPoint(x:margin, y:self.bounds.height)
            CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, .DrawsAfterEndLocation)
            CGContextRestoreGState(ctx)
            
            
            CGContextSetStrokeColorWithColor(ctx, slider.graphColor.CGColor)
            CGContextSetLineJoin(ctx, .Round)
            CGContextSetLineCap(ctx, .Round)
            CGContextSetLineWidth(ctx, 1.0)
            CGContextAddPath(ctx, graphPath.CGPath)
            CGContextStrokePath(ctx)
            
        }

    }
}
