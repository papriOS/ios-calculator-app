
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
    
    @IBAction func pressEqualSign(_ sender: UIButton) {
        updateHistoryStackView()
        operandLabel.text = formatNumber(input: String(calculateRecordCollection()))
        recordCollection = []
    }
    
    @IBAction func pressOperator(_ sender: UIButton) {
        guard let operatorString = sender.titleLabel?.text else {
            return
        }
        if operandLabel.text != "0" {
            updateHistoryStackView()
        }
        updateOperator(input: operatorString) 
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
    }
    
    private func makeRecordStackView() -> UIStackView {
        let recordStackView = UIStackView()
        recordStackView.axis = .horizontal
        
        let validOperand = formatNumber(input: operandLabel.text)
        let validOperator = operatorLabel.text ?? ""
        
        let validOperandLabel = UILabel()
        validOperandLabel.text = validOperand
        validOperandLabel.textColor = .white
        
        let validOperatorLabel = UILabel()
        validOperatorLabel.text = validOperator
        validOperatorLabel.textColor = .white
        
        [validOperatorLabel, validOperandLabel].forEach { recordStackView.addArrangedSubview($0) }
        updateRecordCollection(validOperator: validOperator, validOperand: validOperand)
        
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
    
    private func updateRecordCollection(validOperator: String, validOperand: String) {
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
        init_Operator_Operand()
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        recordCollection = []
    }
    
    private func clearEntry() {
        operandLabel.text = "0"
    }
}

