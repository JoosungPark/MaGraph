//
//  MaCircularBar.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 4. 4..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

@IBDesignable public class MaCircularBar: UIView {
    private let defaultFillColor = UIColor.clearColor().CGColor
    private let defaultStrokeColor = UIColor.blueColor().CGColor
    
    @IBInspectable public var fillColor: UIColor?
    @IBInspectable public var strokeColor: UIColor?
    
    @IBInspectable public var lineWidth: CGFloat = 0
    @IBInspectable public var duration: CGFloat = 1
    
    private let animationKey = "strokeEnd"
    private let startAngle = CGFloat(-M_PI_2)
    private let fillEndAngle = CGFloat(2*M_PI - M_PI_2)
    
    @IBInspectable public var radius: CGFloat = 0
    
    private var defaultRadius: CGFloat {
        get {
            let target = max(bounds.width, bounds.height)
            return target / 2 - lineWidth
        }
    }
    
    public func start(percentage: CGFloat) {
        let circle = CAShapeLayer()
        let center = CGPointMake(bounds.width / 2, bounds.height / 2)
        
        let endAngle = CGFloat(2*M_PI) * percentage - CGFloat(M_PI_2)
        var aRadius = radius
        if aRadius == 0 { aRadius = defaultRadius }
        
        circle.path = UIBezierPath(arcCenter: center, radius: aRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        
        circle.fillColor = UIColor.clearColor().CGColor
        if let aStrokeColor = strokeColor { circle.strokeColor = aStrokeColor.CGColor }
        else { circle.strokeColor = defaultStrokeColor }
        
        circle.lineWidth = lineWidth
        
        let fillCircle = CAShapeLayer()
        fillCircle.path = UIBezierPath(arcCenter: center, radius: aRadius, startAngle: startAngle, endAngle: fillEndAngle, clockwise: true).CGPath
        fillCircle.fillColor = UIColor.clearColor().CGColor
        
        if let aFillColor = fillColor { fillCircle.strokeColor = aFillColor.CGColor }
        else { fillCircle.strokeColor = defaultFillColor }
        
        fillCircle.lineWidth = lineWidth
        
        let animation = CABasicAnimation(keyPath: animationKey)
        animation.duration = CFTimeInterval(duration)
        animation.removedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        circle.addAnimation(animation, forKey: animationKey)
        
        layer.sublayers?.forEach{ $0.removeFromSuperlayer() }
        layer.addSublayer(fillCircle)
        layer.addSublayer(circle)
        
        layer.masksToBounds = true
    }
}
