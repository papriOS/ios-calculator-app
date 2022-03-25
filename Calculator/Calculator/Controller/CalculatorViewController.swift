//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 숫자를 입력하고 나서, 연산자를 눌렀으면 이제 숫자는 바꿀 수 없음
    // 숫자를 입력하고 나서, 부호 바꾸기를 누르면 숫자 부호가 바뀌고, 그태에서 숫자를 하나 더 입력하면 숫자가 바뀜
    // 연산자를 누르면 연산레이블과 숫자레이블이 스택뷰의 밑에 "연산자 숫자" 레이블이 들어간다
    // = 을 누르면 연산자자리는 비고, 숫자 레이블 자리에 결과값이 나온다
    
    
    
    @IBOutlet weak var inputScrollView: UIScrollView!
    @IBOutlet weak var inputStackView: UIStackView!
    // inputStackView.addArangedSubView(만든 스택 뷰)
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    

    @IBAction func pressNumber(_ sender: UIButton) {
        // 숫자를 결정짓는 버튼들을 누르면
        // operandLabel에 숫자가 0이었다가 누르는 수로 변한다
        // inputStackView에 올라가기 전에 한번 더 누르면, operandLabel 뒤에 추가된다
        print(sender.titleLabel?.text) // String optional
    }
    
    @IBAction func pressCalculate(_ sender: UIButton) {
        // = 버튼을 누르면
        // operatorLabel, operandLabel 에 있던 내용이 inputStackView에 추가된다
        // operstorLabel은 빈다.
        // operandLabel에 계산 결과값이 나온다
        print(sender.titleLabel?.text)
    }
    
    @IBAction func pressOperator(_ sender: UIButton) {
        // 연산자 버튼을 누르면
        // 기존 operatorLabel, operandLabel 내용이 inputStackView로 들어간다
        // operatorLabel이 누른 연산자로 바뀌고, operandLabel엔 0이 들어간다
        print(sender.titleLabel?.text)
    }
    
    @IBAction func pressAllClear(_ sender: UIButton) {
        // AC 버튼을 누르면
        // inputStackView 가 모두 비워진다
        // operatorLabel은 비고, operandLabel에 0이 들어간다
        print(sender.titleLabel?.text)
    }
    
    @IBAction func pressClearEntry(_ sender: UIButton) {
        // CE 버튼을 누르면
        // operatorLabel은 그대로, operandLabel에 0이 들어간다
        print(sender.titleLabel?.text)
    }
    
    @IBAction func pressChangeNumerSign(_ sender: UIButton) {
        // 부호변경 버튼을 누르면
        // operandLabel 바로 앞에 -가 붙는다..
        // operandLabel의 값을 Double로 바꾸고 부호로 바꾸면 안됨. 3 -> -3.0이 됨
        print(sender.titleLabel?.text)
    }
}

