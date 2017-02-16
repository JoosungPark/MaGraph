//
//  ViewController.swift
//  MaGraph
//
//  Created by 박주성 on 2017. 2. 15..
//  Copyright © 2017년 Park.JooSung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var barGraph: MaGraphItemView! {
        didSet {
            barGraph.item = MaYItem(maximum: 100, item: MaItem(value: 30, name: "ss"), animationDuration: 5, animationDelay: 0)
            barGraph.show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

