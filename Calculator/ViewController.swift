//
//  ViewController.swift
//  Calculator
//
//  Created by iFlame on 06/04/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    var userInTheMiddelOfTyping = false
    
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddelOfTyping{
        let textCurreentalyDisplay = display.text!
        display.text = textCurreentalyDisplay + digit
        }else {
            display.text = digit
        }
        userInTheMiddelOfTyping = true
    }
    
   private var displayValue : Double{
        get{
            return Double(display.text!)!
            
        }
        set{
          display.text = String(newValue)
        }
    }
    private var brain = CalculatorBrain()

    @IBAction private func performOperation(_ sender: UIButton) {
        if userInTheMiddelOfTyping {
            brain.setOperand(displayValue)
            userInTheMiddelOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
    }

}
