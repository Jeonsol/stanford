//
//  ViewController.swift
//  stanford
//
//  Created by 전솔 on 2018. 7. 20..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var displayNumber: String?
    var isMath: Bool = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if isMath {
            displayNumber = display.text!+(sender.titleLabel?.text!)!
            display.text = displayNumber
        }
        else {
            display.text = sender.titleLabel?.text!
        }
        isMath = true
    }
    @IBAction func calFunc(_ sender: UIButton) {
        if let displayText = sender.titleLabel?.text {
            if displayText == "pi" {
                display.text = String(Double.pi)
            }
        }
    }
}

