//
//  ViewController.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var maGraphView: MaGraphView! {
        didSet {
            let values: [CGFloat] = [150, 200, 50, 35, 98, 533, 75 ]
            let xNames = ["ss", "dd"]
            let yValue = MaItem(value: 77, name: "dd")
            maGraphView.items = MaGraphItems(xValues: values, xNames: xNames, yValues:yValue, animationDuration: 2, animationDelay: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        maGraphView.layoutIfNeeded()
        
        maGraphView.show()
    }
}

