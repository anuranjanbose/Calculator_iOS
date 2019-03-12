//
//  ViewController.swift
//  Calculator
//
//  Created by Anuranjan Bose on 14/07/17.
//  Copyright © 2017 Anuranjan Bose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBOutlet weak var display: UILabel!
    @IBAction func digitTouch(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        let currentLabel = display.text!
        if userIsInMiddleOfTyping {
            display.text = currentLabel + digit
        }
        else{
            display.text = digit
            
                userIsInMiddleOfTyping = true
            
        }
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
   
    @IBAction func clearButton(_ sender: UIButton) {
        display.text = "0"
        brain.clearAccumulator()
        userIsInMiddleOfTyping = false
    }
    
    private var brain = CalculatorBrain()
    @IBAction func operation(_ sender: UIButton) {
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
    
}

