//
//  MaGraphItemView.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

public enum Orientation: Int {
    case Vertical = 11
    case Horizontal = 21
}

public struct MaYItem {
    var maximum: CGFloat
    var item: MaItem
    var animationDuration: CGFloat = 2
    var animationDelay: CGFloat = 0
}

@IBDesignable public class MaGraphItemView: UIView {
    @IBInspectable public var positionY: CGFloat = 0
    
    private let defaultGraphColor = UIColor.blueColor()
    @IBInspectable public var graphColor: UIColor?

    private var orientation: Orientation = .Vertical
    private var barLayer: CAShapeLayer!
    
    public var item: MaYItem? {
        didSet {
            guard let aItem = item else { return }
            let weightedHeight = bounds.height / 100.0
            let mok = aItem.item.value / aItem.maximum * 100
            positionY = weightedHeight * mok
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        let height = bounds.height
        let width = bounds.width
        let rect = CGRectMake(0, height - positionY, width, positionY)
        
        let path = UIBezierPath(rect: rect)
        
//        let y = height - positionY
//        path.moveToPoint(CGPoint(x: 0, y: height))
//        path.addLineToPoint(CGPoint(x: width, y: height))
//        path.addLineToPoint(CGPoint(x: width, y: y))
//        path.addLineToPoint(CGPoint(x: 0, y: y))
//        path.closePath()
        
            
        
        bounds.size.height = 0
        
        barLayer = CAShapeLayer()
        barLayer.fillColor = graphColor == nil ? defaultGraphColor.CGColor : graphColor!.CGColor
        barLayer.strokeColor = graphColor == nil ? defaultGraphColor.CGColor : graphColor!.CGColor
        barLayer.lineWidth = width
        barLayer.path = path.CGPath
        barLayer.strokeEnd = 0
        barLayer.bounds = CGRectMake(0, height - positionY, width, 0)
        
//        layer.addSublayer(barLayer)
    }
    
//    public override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        
//        let aPositionY = positionY
//        
//        let rect = CGRectMake(0, bounds.height - aPositionY, bounds.width, aPositionY)
//        let context = UIGraphicsGetCurrentContext()
//        var color = UIColor.blueColor()
//        if let aColor = graphColor { color = aColor }
//        
//        CGContextSetRGBFillColor(context, color.CIColor.red, color.CIColor.green, color.CIColor.blue, color.CIColor.alpha)
//        CGContextFillRect(context, rect)
//    }
    
    public func show() {
        let height = bounds.height
        let width = bounds.width
        let rect = CGRectMake(0, height - positionY, width, positionY)
        
//        let path = UIBezierPath(rect: rect)
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.fillColor = graphColor == nil ? defaultGraphColor.CGColor : graphColor!.CGColor
//        maskLayer.lineWidth = width
//        maskLayer.path = path.CGPath
//        barLayer.bounds = CGRectMake(0, height - positionY, width, 0)
        
        if let aItem = item where aItem.animationDuration > 0 {
            CATransaction.setDisableActions(true)
            let pathAnimation = CABasicAnimation(keyPath: "bounds.size.height")
            pathAnimation.duration = CFTimeInterval(aItem.animationDuration)
            barLayer.bounds.size.height = positionY
            pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            pathAnimation.fromValue = NSNumber(float: 0)
            pathAnimation.toValue = NSNumber(float: Float(positionY))
            pathAnimation.autoreverses = false
            pathAnimation.removedOnCompletion = false
            pathAnimation.fillMode = kCAFillModeForwards
            pathAnimation.beginTime = CACurrentMediaTime() + CFTimeInterval(aItem.animationDelay)
//            barLayer.strokeEnd = 1.0
//            barLayer.bounds = rect
//            barLayer.addAnimation(pathAnimation, forKey: nil)
//            maskLayer.bounds = rect
            barLayer.addAnimation(pathAnimation, forKey: "bounds")
            
            
        } else {
            barLayer.strokeEnd = 1.0
        }
    
        
    }
    
//    public func show() {
////        layer.addSublayer(generateLayer())
//    }
}
