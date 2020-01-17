//
//  ViewController.swift
//  STUDYSwift
//
//  Created by sherwin.chen on 2019/12/10.
//  Copyright © 2019 sherwin.chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rdV = CGFloat(arc4random()%255) / 255.0
        let gdV = CGFloat(arc4random()%255) / 255.0
        let bdV = CGFloat(arc4random()%255) / 255.0
        let alpha = CGFloat(arc4random()%255) / 255.0

        self.view.backgroundColor = UIColor(red:rdV, green: gdV, blue: bdV, alpha: alpha)
    }


}

