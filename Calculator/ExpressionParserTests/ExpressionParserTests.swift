
import XCTest
@testable import Calculator

class ExpressionParserTests: XCTestCase {
    
    func test_When_inputString_Expect_Formula_result() {
        //given
        let input = "3 + 4 * -2"
        
        //when
        var formula = ExpressionParser.parse(from: input)
        let result = formula.result()
        
        //then
        XCTAssertEqual(result, -14)
    }
    
    func test_When_inputString_with_first_blank_Expect_Formula_result() {
        //given
        let input = "  -8 * 3 − 4" 
        
        //when
        var formula = ExpressionParser.parse(from: input)
        let result = formula.result()
        
        //then
        XCTAssertEqual(result, -28)
    }
    
}
