//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by iFlame on 06/04/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import Foundation


class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(_ operand : Double){
        accumulator = operand
        
    }
  private  var operations : Dictionary<String,Operation> = [
        
        "π" :Operation.Constant(M_PI),
        "e" :Operation.Constant(M_E),
        "±" :Operation.UnaryOperation({-$0}),
        "√" :Operation.UnaryOperation(sqrt),
        "cos" :Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
        
    ]
    
   private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    }
    
    
    func performOperation(_ symbol : String){
        if  let operation = operations[symbol]{
            switch operation {
            case .Constant(let Value): accumulator = Value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation (let function):
                   executePendingBinaryOperation()
                   pending = pendingBinaryOperatinsInfo(binaryFunction: function,fristOperand: accumulator)
            case .Equals:executePendingBinaryOperation()
             }
        }
    }
    private func executePendingBinaryOperation()
    {
        if  pending != nil{
            accumulator = pending!.binaryFunction(pending!.fristOperand, accumulator)
            pending = nil
        
        }
    }
    private var pending : pendingBinaryOperatinsInfo?
   private  struct pendingBinaryOperatinsInfo{
        var binaryFunction : (Double , Double)-> Double
        var fristOperand: Double
    }
    
    var result : Double{
        get{
            return accumulator
        }
    }
    
    
}
