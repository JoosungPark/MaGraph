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

public struct MaSubItem {
    var maximum: CGFloat
    var value: CGFloat
    var animationDuration: CGFloat = 2
    var animationDelay: CGFloat = 0
}

@IBDesignable public class MaGraphItemView: UIView {
    @IBInspectable public var positionY: CGFloat = 0
    
    private let defaultGraphColor = UIColor.blueColor()
    @IBInspectable public var graphColor: UIColor?

    private var orientation: Orientation = .Vertical
    private var barLayer: CAShapeLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var item: MaSubItem?
    
    private var currentPositionY: CGFloat {
        get {
            if frame.height < positionY { return frame.height }
            else { return positionY }
        }
    }
    
    private func calculatepositionY() {
        guard let aItem = item else { return }
        let weightedHeight = frame.height / 100.0
        let percentage = aItem.value / aItem.maximum * 100
        
        positionY = percentage * weightedHeight
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clearColor()
        calculatepositionY()
    }
    
    func show() {
        print("show")
        let myLayer = CALayer()
        myLayer.frame = self.bounds
        myLayer.backgroundColor = UIColor.clearColor().CGColor
        
        let height = bounds.height
        let width = bounds.width
        let drawRect = CGRectMake(0, height - positionY, width, positionY)
        
        let initialRect = CGRectMake(0, height, width, 0)
        let finalRect = CGRectMake(0, 0, width, height)
        
        let subLayer = CALayer()
        subLayer.frame = initialRect
        subLayer.backgroundColor = UIColor.clearColor().CGColor
        
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = UIBezierPath(rect: drawRect).CGPath
        var color = UIColor.blueColor()
        if let aColor = graphColor { color = aColor }
        mask.fillColor = color.CGColor
        mask.strokeColor = color.CGColor
        
        
        myLayer.mask = mask
        
        layer.addSublayer(myLayer)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.toValue = NSValue(CGRect: finalRect)
        
        let anim = CAAnimationGroup()
        anim.animations = [animation]
        anim.removedOnCompletion = false
        
        guard let aItem = item else {return}
        
        anim.duration = NSTimeInterval(aItem.animationDuration)
        anim.fillMode = kCAFillModeForwards
        subLayer.addAnimation(anim, forKey: "AnimateFrame")
//        subLayer.position
        myLayer.addSublayer(subLayer)
        
    }
    
//    public override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        
//        let height = rect.height
//        let width = rect.width
//        let drawRect = CGRectMake(0, height - currentPositionY, width, currentPositionY)
//        
//        let context = UIGraphicsGetCurrentContext()
//        var color = UIColor.blueColor()
//        if let aColor = graphColor { color = aColor }
//        
//        let colorRef = color.CGColor
//        let component = CGColorGetComponents(colorRef)
//        let red = component[0]
//        let green = component[1]
//        let blue = component[2]
//        let alpha: CGFloat = 1
//        
//        CGContextSetRGBFillColor(context, red, green, blue, alpha)
//        CGContextFillRect(context, drawRect)
//    }
}
