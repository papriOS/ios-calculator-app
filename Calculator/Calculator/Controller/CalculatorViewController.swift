//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    @IBOutlet weak var inputScrollView: UIScrollView!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    private var inputCollection: [String] = [] // Scroll View의 VerticalStackView에 들어간 모든 HorizontalStackView의 Label들(operator, operand)을 합친 String의 모음집
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        init_Operator_Operand()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressNumber(_ sender: UIButton) {
        // 숫자를 결정짓는 버튼들을 누르면
        guard let number = sender.titleLabel?.text else {
            return
        }
        updateOperandValue(input: number) // operandLabel가 업데이트 된다
    }
    
    @IBAction func pressDoubleZero(_ sender: UIButton) {
        guard let operand = operandLabel.text, let doubleZero = sender.titleLabel?.text else{
            return
        }
        
        if operand == "0" {
            return
        } else {
            operandLabel.text = operand + doubleZero
        }
        
    }
    
    @IBAction func pressDecimalPoint(_ sender: UIButton) {
        
        guard let operand = operandLabel.text, let number = sender.titleLabel?.text else{
            return
        }
        
        if operand.contains(".") {
            return
        } else {
            operandLabel.text = operand + number
        }
        
    }
    
    @IBAction func pressEqualSign(_ sender: UIButton) {
        // = 버튼을 누르면
        
        updateInputStackView() // operatorLabel, operandLabel 에 있던 내용이 inputStackView에 추가된다
        showCalculationResult() // operandLabel에 계산 결과값이 나온다
    }
    
    @IBAction func pressOperator(_ sender: UIButton) {
        // 연산자 버튼을 누르면
        
        updateInputStackView() // 기존 operatorLabel, operandLabel 내용이 inputStackView로 들어간다
        updateOperator() // operatorLabel이 누른 연산자로 바뀐다
    }
    
    @IBAction func pressAllClear(_ sender: UIButton) {
        // AC 버튼을 누르면
        
        allClear() // inputStackView 가 모두 비워진다
       
       
    }
    
    @IBAction func pressClearEntry(_ sender: UIButton) {
        // CE 버튼을 누르면
        
        clearEntry()
       
    }
    
    @IBAction func pressChangeNumerSign(_ sender: UIButton) {
        updateOperandSign()
    }
    
    
    
    
    
    // private method
    
    private func init_Operator_Operand() {
        operatorLabel.text = ""
        operandLabel.text = "0"
    }
    
    private func updateOperandValue(input: String) {
        guard let operand = operandLabel.text else {
            return
        }
        
        if operandLabel.text == "0" {
            operandLabel.text = input
        } else {
            operandLabel.text = operand + input
        }
    }
    
    private func updateOperandSign() {
        guard var operand = operandLabel.text, operandLabel.text != "0" else {
            return
        }
        
        if operand.contains("-") {
            operand.removeFirst()
        } else {
            operand.insert("-", at: operand.startIndex)
        }
        operandLabel.text = operand
    }
    
    private func updateOperator() {
        // 연산자 버튼 누른걸로 operandLabel 업데이트하기
    }
    
    private func updateInputStackView() {
        init_Operator_Operand() // operatorLabel, operandLabel 다 초기화된다
        makeInputStackSubView()
        //inputStackView.addArangedSubView(만든 스택 뷰)
    }
    
    private func makeInputStackSubView() {
        formatOperand()
        // operandLabel, operatroLabel 내용이 horizontalStackView로 생성
        updateInputCollection()
    }
    
    private func formatOperand() {
        // operandLabel에 .이 있다면
            // operandLabel이 . 으로 끝나면, .을 없애준다.
            // operandLabel의 마지막이 0이 아닐때까지 0을 없애준다.
            // 3칸마다 , 찍어준다.
    }
    
    private func updateInputCollection() {
        // operandLabel, operatorLabel 내용이 공백을 간격으로 합쳐진 String을 만들고 inputCollection에 append함
    }
    
    private func showCalculationResult() {
        init_Operator_Operand() // operatorLabel, operandLabel 다 초기화된다
        
        // inputCollection에 있는 String들 다 " " 구분점으로 합쳐서 하나의 String으로 변환
        // String에 있는 나누기,곱하기 기호를 각각 /랑 *로 대체
        // String에 있는 , 다 없앰
        /*
         var formula = ExpressionParser.parse(from: input)
         let result = formula.result()
         */
        
        // operandLabel이 result로 바뀜
    }
    
    private func allClear() {
        init_Operator_Operand()  // operatorLabel은 비고, operandLabel에 0이 들어간다
        // inputStackView 가 모두 비워진다
    }
    
    private func clearEntry() {
        // operatorLabel은 그대로, operandLabel에 0이 들어간다
    }
}

