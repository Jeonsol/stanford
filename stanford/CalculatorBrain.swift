//
//  CalculatorBrain.swift
//  stanford
//
//  Created by 전솔 on 2018. 7. 22..
//  Copyright © 2018년 전솔. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    // 함수 호출
    var operations : Dictionary<String, Operation> = [
        "pi" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "root" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "x" : Operation.BinaryOperation({$0 * $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equls
    ]
    
    // enum을 나누는 기준 : 매개변수 기준으로 나눈다. -> 함수선언
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->(Double))
        case BinaryOperation((Double, Double) -> Double)
        case Equls
    }
    
    // 함수 구현
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOption()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equls:
                executePendingBinaryOption()
            }
        }
    }
    
    // 결과 노출
    private func executePendingBinaryOption() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending:PendingBinaryOperationInfo?
    
    // 이항연산 중간에 저장하는 temp
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand : Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
