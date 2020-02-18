//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Dino B on 2020-02-16.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

// Creating classes for all our models like we do here and like we
// did so far is fine and complies with MVC pattern but we can make
// our code even safer by chanigng our class into struct.  To do so,
// just change type from 'class' to 'struct'.  While in languages
// like C, C++, ObjectiveC, structs are just to organize related
// data into a structure, in swift, struct is more than just that
// and it has more capabilities to the point where they are just as
// capable as a class.  So, they can have properties, functions and
// can be used anywhere.  For example, String data type or Double are
// all structs in swift.
//class CalculatorLogic {
struct CalculatorLogic {
    // since we are not neither initializing it nor making it
    // optional, we have to create init method.
    // make it optional so it can be nil when we init this object.
    // since it is global struct var, make it private.
    private var number: Double?
    
    // Touple to store first number and calculation type
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    // and create ssetter to allow other code to set it.  I use
    // the _ in it so that I dont have to provide number when I call
    // this func from other places.  So, I can call it like:
    // calculator.setNumber(displayValue) rather than like:
    // calculator.setNumber(number: displayValue)
    // Using underbar like this allows you to set external parameter
    // name to nothing and internal parameter name to 'number'.
    // we mark it mutating since we are changing struct property.
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    // initializer is no longer needed since we changed this into a
    // struct and structs provide us with a free initializer.
//    init(number: Double) {
//        self.number = number
//    }

    // we need to somehow store 1st number and the calculation
    // button.  We can use Tuple for this to group related pieces
    // of data that have different data types.  We can put any
    // number of data in a touple separated by a comma.
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
            case "+/-":
                // here we take 1st number and switch sign
                return n * -1
            case "AC":
                // here we set it to 0
                return 0
            case "%":
                // here we take 1st number and calc percentage
                return n * 0.01
            case "=":
                // here we pass 2nd number which is the n because
                // when user taps on "=" we know that what we
                // passed in was the 2nd number on which to
                // perform calculation
                return performTwoNumberCalculation(n2: n)
            default:
                // here we set touple to store 1st number (n1)
                // and calculation type (symbol) into touple
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        
        // in order to be able to return nil (in case none matching
        // symbol is passed in, we have to change return type
        // Double to optional Double?
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
       // because touple is optional we have to unwrap it or use
        // optional binding.  Below we optionally chain
        // intermediateCalculation to get 2 constants out of it
        // and only if they are not nil, we proceed.  So, we are saying
        // "if intemediateCalculation is not nil, grab n1 and calcMethod.
        if let n1 = intermediateCalculation?.n1
            , let operation = intermediateCalculation?.calcMethod {
            // now we have both n1 and calcMethod both unwrapped so we
            // know they are not nil, we use them
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not have a match")
            }
        }
        
        //return nill in case user tapped on equal sign for example but
        //in order to be able to return nil, must return optional Double
        return nil
    }
}
