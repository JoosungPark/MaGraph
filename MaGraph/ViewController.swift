//
//  ViewController.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var circularBar: MaCircularBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        circularBar.start(0.7)
    }
}

