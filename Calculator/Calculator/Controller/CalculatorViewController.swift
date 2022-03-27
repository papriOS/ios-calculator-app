
import UIKit

final class CalculatorViewController: UIViewController {

    @IBOutlet weak var historyScrollView: UIScrollView!
    @IBOutlet weak var historyStackView: UIStackView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    private var recordCollection: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allClear()
    }

    @IBAction func pressNumber(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else {
            return
        }
        updateOperandValue(input: number)
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
    
    @IBAction func pressEqualSign(_ sender: UIButton) { // 이미 연산결과가 나왔는데 = 을 누르면 아무것도 진행 안됨.
        updateHistoryStackView() // operatorLabel, operandLabel 에 있던 내용이 inputStackView에 추가된다
        operandLabel.text = formatNumber(input: String(calculateRecordCollection()))// operandLabel에 계산 결과값이 나온다. 근데 결과값이 Double.. 정제되지 않은 상태로 나옴;;
        // calculateRecordCollection() 가 format 되게 끔 하고 String 변환하면 될듯~
        recordCollection = []
    }
    
    @IBAction func pressOperator(_ sender: UIButton) {
        guard let operatorString = sender.titleLabel?.text else {
            return
        }
        if operandLabel.text != "0" { // 아무 입력이 없는 상태면??
            updateHistoryStackView() // 기존 operatorLabel, operandLabel 내용이 inputStackView로 들어간다
        }
        updateOperator(input: operatorString) // operatorLabel이 누른 연산자로 바뀐다
    }
    
    @IBAction func pressAllClear(_ sender: UIButton) {
        allClear()
    }
    
    @IBAction func pressClearEntry(_ sender: UIButton) {
        clearEntry()
    }
    
    @IBAction func pressChangeNumberSign(_ sender: UIButton) {
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
    
    private func updateOperator(input: String) {
        operatorLabel.text = input
    }
    
    private func updateHistoryStackView() {
        let recordStackView = makeRecordStackView()
        historyStackView.addArrangedSubview(recordStackView)
        historyScrollView.setContentOffset(CGPoint(x: 0, y: historyScrollView.contentSize.height - historyScrollView.bounds.height), animated: true)
        init_Operator_Operand()
        // operatorLabel, operandLabel 다 초기화된다
    }
    
    private func makeRecordStackView() -> UIStackView {
        let recordStackView = UIStackView()
        recordStackView.axis = .horizontal
        recordStackView.spacing = 8.0
        recordStackView.alignment = .fill
        recordStackView.distribution = .fill
        
        let validOperand = formatNumber(input: operandLabel.text)
        let validOperator = operatorLabel.text ?? ""
        
        let validOperandLabel = UILabel()
        validOperandLabel.text = validOperand
        validOperandLabel.textColor = .white
        
        let validOperatorLabel = UILabel()
        validOperatorLabel.text = validOperator
        validOperatorLabel.textColor = .white
        // operandLabel, operatroLabel 내용이 horizontalStackView로 생성
        
        [validOperatorLabel, validOperandLabel].forEach { recordStackView.addArrangedSubview($0) }
        updateInputCollection(validOperator: validOperator, validOperand: validOperand)
        
        return recordStackView
    }
    
    private func formatNumber(input: String?) -> String {
        var formattedNumber = input ?? "0"
        
        if formattedNumber.contains(".") {
            while formattedNumber.last == "0" {
                formattedNumber.removeLast()
            }
        }
        
        if formattedNumber.last == "." {
            formattedNumber.removeLast()
        }
        
        return formattedNumber
    }
    
    private func updateInputCollection(validOperator: String, validOperand: String) {
        let inputString = validOperator + " " + validOperand
        recordCollection.append(inputString)
    }
    
    private func calculateRecordCollection() -> Double {
        let validRecordString = recordCollection.reduce( "" , { $0 + " " + $1 } )
                                .replacingOccurrences(of: "÷", with: "/")
                                .replacingOccurrences(of: "×", with: "*")
                                .replacingOccurrences(of: ",", with: "")
        var formula = ExpressionParser.parse(from: validRecordString)
        let result = formula.result()
        
        return result
    }
    
    private func allClear() {
        init_Operator_Operand()  // operatorLabel은 비고, operandLabel에 0이 들어간다
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        recordCollection = []
    }
    
    private func clearEntry() {
        operandLabel.text = "0"
    }
}

