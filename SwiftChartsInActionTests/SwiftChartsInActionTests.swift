//
//  SwiftChartsInActionTests.swift
//  SwiftChartsInActionTests
//
//  Created by Eduardo Developer on 14/2/23.
//

import XCTest
@testable import SwiftChartsInAction

final class SwiftChartsDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStockProyection()  {

        let timeLine = MovementInStockTimeline.stockProyection(input: Movement.testInitialReplenishments, output: Movement.testForecastFourWeeks, initialStock: MovementInStockTimeline.testInitialStock)
        
        XCTAssertEqual(1900, timeLine.last?.finalStock)
        XCTAssertEqual(11, timeLine.count)
        
    }
    
    func testsplitSequencesPerTypeOfMovement(){
        
        let timeLine = MovementInStockTimeline.stockProyection(input: Movement.testInitialReplenishments, output: Movement.testForecastFourWeeks, initialStock: MovementInStockTimeline.testInitialStock)
        let sequences = SequenceByTypeOfMovement.splitSequencesPerTypeOfMovement(unifiedTimeline: timeLine)
        
        XCTAssertEqual(8, sequences[0].sequence.count)
        XCTAssertEqual("forecast", sequences[0].type)
        XCTAssertEqual(3, sequences[1].sequence.count)
        XCTAssertEqual("replenishment", sequences[1].type)
    }

   /* func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
