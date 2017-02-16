//
//  MaGraph.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

struct MaItem {
    var value: CGFloat
    var name: String
}

struct MaGraphItems {
    var xValue: [MaItem]
    var yValue: MaItem
    var yMaxValue: CGFloat
}

class MaGraphView: UIView {

    private struct MaConstrants {
        private static let defaultInterSpace: CGFloat = 5
        private static let empty: Int = 0
    }
    
    var items: MaGraphItems? {
        didSet {
            
        }
    }
    
    var interSpaceRatio: CGFloat = 0.3 { didSet { setInterSpace() } }
    
    private func setInterSpace() {
        if countXAxis != MaConstrants.empty {
            
        }
    }
    
    var interSpace = MaConstrants.defaultInterSpace
    var countXAxis = MaConstrants.empty
    
    override func drawRect(rect: CGRect) {
        
    }

    override func layoutSubviews() {
        
    }
    
}
