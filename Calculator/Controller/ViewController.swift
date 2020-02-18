//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

// UIKit has all what Foundation has plust UI related stuff
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    // create computed property
    private var displayValue: Double {
        get {
            // get number in display and turn it into double but note
            // this will be optional making it difficult to work with
            // so we force cast it at the end with '!' as we know for
            // sure we will always have a number.
            //let number = Double(displayLabel.text!)!
            
            // another way is to use conditional cast instead of forced
            // cast but that is not great as it will hide error in this
            // case
            //let number = Double(displayLabel.text!) ?? 0
            
            // but better way is to write calculated property as in case
            // of displayValue above and use guard instead of ! or ??
            // for validation
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert displayLabel to double")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    // move out of method for efficiency and make private since
    // it is now global class var.  but since it is global now, it
    // will happen even before this view controller is finished
    // being created; therefore, computed property displayValue
    // may not be ready at this moment.  So, depending on how long
    // it takes to create this view controller, the computed prop
    // may or may not be nill and swift is erroring for that reason.
    //private let calculator = CalculatorLogic(number: displayValue)
    // for that reason, we dont pass anything to CalculatorLogic
    // but make its property 'number' optional.  That means we can
    // pass value to it at a later point, once ready.
    private var calculator = CalculatorLogic()
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            //let calculator = CalculatorLogic(number: displayValue)
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        //To figure out button, we could use tag values on each one.
        //But that is bit manual and I want to know identity of a
        //tapped button and that can also be retrieved from sender.
        //Since currentTitle is optional, we use if let
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                // to prevent user entering more than one decimal
                // point, check if number is int or double
                if numValue == "." {
                    // so, round it down and compare to display
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return  // simply return instead of putting .
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

    // ACCESS LEVELS most-to-least restrictive
    // 1.private - only accessible within curly braces of class
    // 2.fileprivate - only accessible inside the file where declared
    // 3.internal - accessible anywhere in current app module (DEFAULT)
    // 4.public - accessible from all other modules but cannot subclass or override
    // 5.open - = public+ accessible to other modules like public but
    //    also to be subclassed and overriden so anyone can do
    //    anything they want.
    // FOR STANDARD APP DEV, WE USE 1-3 BUT DEVS WORKING ON
    // FRAMEWORKS, LIBRARIES, SDKS, WILL USE 4-5 IN ORDER TO EXPOSE
    // THEM TO OTHER DEVS.
}

