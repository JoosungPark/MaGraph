//
//  MaGraph.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

public struct MaItem {
    var value: CGFloat
    var name: String
}

public struct MaGraphItems {
    var xValues: [CGFloat]
    var xNames: [String]
    var yValues: MaItem
    var animationDuration: CGFloat = 1
    var animationDelay: CGFloat = 0
}

public extension UIView {
    public func addConstraints(interSpace aInterSpace: CGFloat, leadingView aLeadingView: UIView?, trailingView aTrailingView: UIView?) {
        addConstraints()
        
        if aLeadingView == nil { addConstraints(attribute: .Leading) }
        else {
            NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: aLeadingView, attribute: .Trailing, multiplier: 1, constant: aInterSpace).active = true
            NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: aLeadingView, attribute: .Width, multiplier: 1, constant: 0).active = true
        }
        if aTrailingView == nil { addConstraints(attribute: .Trailing) }
    }
    
    public func addConstraints() {
        NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview, attribute: .Top, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: 1, constant: 0).active = true
    }
    
    public func addConstraints(attribute aAttribue: NSLayoutAttribute) {
        NSLayoutConstraint(item: self, attribute: aAttribue, relatedBy: .Equal, toItem: superview, attribute: aAttribue, multiplier: 1, constant: 0).active = true
    }
    
}

public class MaGraphView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        heightRate = 0
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
    }
    
    private var heightRate: CGFloat = 0 { didSet {
        for (_, graph) in graphItemViews {
            let x = graph.frame.origin.x
            print("graph bounds height ; \(graph.bounds.height)")
            
            let y = graph.frame.origin.y - graph.bounds.height*heightRate
            let width = graph.bounds.width
            let height = graph.bounds.height
            
            graph.frame = CGRectMake(x, y, width, height)
        }
        }
    }
    
    private struct MaConstrants {
        private static let defaultInterSpace: CGFloat = 5
        private static let empty: Int = 0
    }
    
    var interSpace: CGFloat = MaConstrants.defaultInterSpace
    private var countXAxis = MaConstrants.empty
    
    public var items: MaGraphItems? {
        didSet {
            guard let aItems = items else { return }
            countXAxis = aItems.xValues.count
            calcurateValues()
            createSubViews(xAxisArray: aItems.xValues)
        }
    }
    
    private var widthXAxis: CGFloat = 0
    private var maximumValue: CGFloat = 0
    
    public var maximumScale: CGFloat = 1.07
    
    private func calcurateValues() {
        let width = frame.width
        widthXAxis = width / CGFloat(countXAxis) - interSpace
        
        for value in items!.xValues {
            let temp = value
            if temp > maximumValue { maximumValue = temp }
        }
        
        maximumValue = maximumValue * maximumScale
    }

    private var graphItemViews = [Int: MaGraphItemView]()
    private var originalHeight: CGFloat = 0
    
    private func createSubViews(xAxisArray aXAxisArray: [CGFloat]) {
        var x: CGFloat = 0

        for i in 0..<countXAxis {
            let rect = CGRectMake(x, 0, widthXAxis, bounds.height)
            let graphitem = MaGraphItemView(frame: rect)
            graphitem.item = MaSubItem(maximum: maximumValue, value: items!.xValues[i], animationDuration: items!.animationDuration, animationDelay: items!.animationDelay)
            x = x + widthXAxis + interSpace
            graphItemViews[i] = graphitem
            graphitem.translatesAutoresizingMaskIntoConstraints = false
            addSubview(graphitem)
        }
        
        for i in 0..<graphItemViews.count {
            if let targetView = graphItemViews[i] {
                targetView.addConstraints(interSpace: interSpace, leadingView: graphItemViews[i-1], trailingView: graphItemViews[i+1])
            }
        }
    }
    
    public var interSpaceRatio: CGFloat = 0.3 { didSet { setInterSpace() } }
    
    private func setInterSpace() {
        if countXAxis != MaConstrants.empty {
            let width = bounds.width
            interSpace = width / CGFloat(countXAxis) * interSpaceRatio
        }
    }
    
    public func show() {
//        window?.becomeKeyWindow()
//        window?.makeKeyAndVisible()
//        for (_, graph) in graphItemViews {
//            graph.show()
//        }
//        
//        guard let aItems = items else { return }
//        
//        UIView.animateWithDuration(NSTimeInterval(5), delay: NSTimeInterval(aItems.animationDelay), options: .CurveLinear, animations: {
//            self.heightRate = 1
//            }, completion: nil)
    }
}
