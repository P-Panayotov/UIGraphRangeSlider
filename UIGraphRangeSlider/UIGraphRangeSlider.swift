//
//  UIGraphRangeSlider.swift
//  GraphRangeSlider
//
//  Created by Panayot on 22/08/2016.
//  Copyright © 2016 Panayot Panayotov. All rights reserved.
//

import UIKit
import QuartzCore

open class UIGraphRangeSlider: UIControl {

    open var minimumValue: Double = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var maximumValue: Double = 1.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var lowerValue: Double = 0.2 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var upperValue: Double = 0.8 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var trackTintColor: UIColor = UIColor(white: 0.1, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    open var graphColor: UIColor = UIColor(red: 93.0/255.0, green: 184.0/255.0, blue: 225.0/255.0, alpha: 1.0) {
        didSet {
            graphLayer.setNeedsDisplay()
        }
    }
    
    open var trackHighlightTintColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    open var thumbTintColor: UIColor = UIColor.white {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    open var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    open var graphPoints: [Int] = [] {
        didSet{
            graphLayer.setNeedsDisplay()
        }
    }
    
    let trackLayer = RangleSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    let graphLayer = RangeSliderGraphLayer()
    
    let thumbWidth:CGFloat = 30.0
    var previousLocation = CGPoint()
    
    override open var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        graphLayer.rangleSlider = self
        graphLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(graphLayer)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
    }
    
    fileprivate func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: 1)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: (bounds.height / 2) - thumbWidth / 2, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: (bounds.height / 2) - thumbWidth / 2, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
        graphLayer.frame = bounds
        graphLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    open func positionForValue(_ value: Double) -> Double {
        let a = Double(bounds.width - thumbWidth)
        let b = value - minimumValue
        let c = maximumValue - minimumValue
        let d = Double(thumbWidth / 2.0)
        return a * b / c + d
    }
    
    fileprivate func boundValue(_ value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlited = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlited = true
        }
        
        return lowerThumbLayer.highlited || upperThumbLayer.highlited
    }
    
    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        // 1. Determine by how muh the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        // 2. Update the values
        if lowerThumbLayer.highlited {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlited {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        sendActions(for: .valueChanged)
        
        return true
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlited = false
        upperThumbLayer.highlited = false
    }
    
}
