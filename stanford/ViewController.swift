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
    
    // 숫자 받아오기(누적하는곳)
    @IBAction func touchDigit(_ sender: UIButton) {
        // 숫자가 한개라도 있어야 isMath가 true
        if isMath {
            displayNumber = display.text!+(sender.titleLabel?.text!)!
            display.text = displayNumber
        }
        else {
            display.text = sender.titleLabel?.text!
        }
        isMath = true
    }
    
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    var brain =  CalculatorBrain()
    
    @IBAction func calFunc(_ sender: UIButton) {
        // 숫자 전달 - accumulator 셋팅
        if isMath {
            brain.setOperand(operand: displayValue)
            isMath = false
        }
        // 연산 전달
        if let displayText = sender.titleLabel?.text {
            brain.performOperation(symbol: displayText)
        }
        displayValue = brain.result
    }
}

