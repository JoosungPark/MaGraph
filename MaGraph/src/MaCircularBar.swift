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
    
    func setCircularBar(percentage: CGFloat) {
        let circle = CAShapeLayer()
        let center = CGPointMake(bounds.width / 2, bounds.height / 2)
        let endAngle = CGFloat(2*M_PI) * percentage - CGFloat(M_PI_2)
        circle.path = UIBezierPath(arcCenter: center, radius: 27, startAngle: CGFloat(-M_PI_2), endAngle: endAngle, clockwise: true).CGPath
        
        if let aFillColor = fillColor { circle.fillColor = aFillColor.CGColor }
        else { circle.fillColor = defaultFillColor }
        
        if let aStrokeColor = strokeColor { circle.strokeColor = aStrokeColor.CGColor }
        else { circle.strokeColor = defaultStrokeColor }
        
        circle.lineWidth = lineWidth

        let animation = CABasicAnimation(keyPath: animationKey)
        animation.duration = CFTimeInterval(duration)
        animation.removedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        circle.addAnimation(animation, forKey: animationKey)
        
        layer.sublayers?.forEach{ $0.removeFromSuperlayer() }
        layer.addSublayer(circle)
        layer.masksToBounds = true
    }
}
