//
//  ViewController.swift
//  Calculator
//
//  Created by Anuranjan Bose on 14/07/17.
//  Copyright © 2017 Anuranjan Bose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var display: UILabel!
    
    // MARK:- Public Properties
    var userIsInMiddleOfTyping = false
    var isDotPressed = false
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- IBActions
    @IBAction func digitTouch(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        let currentLabel = display.text!
        
        if userIsInMiddleOfTyping {
            if digit == "." && isDotPressed == false {
                display.text = currentLabel + digit
                isDotPressed = true
            } else if digit != "." {
                display.text = currentLabel + digit
            }
        } else {
            if digit == "." && isDotPressed == false {
                display.text = digit
                userIsInMiddleOfTyping = true
                isDotPressed = true
            } else if digit != "." {
                display.text = digit
                userIsInMiddleOfTyping = true
            }
            
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        isDotPressed = false
        if userIsInMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        display.text = "0"
        brain.clearAccumulator()
        userIsInMiddleOfTyping = false
        isDotPressed = false
    }
}

