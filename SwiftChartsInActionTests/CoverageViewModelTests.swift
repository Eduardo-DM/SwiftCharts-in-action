//
//  CoverageViewModelTests.swift
//  SwiftChartsInActionTests
//
//  Created by Eduardo Developer on 15/2/23.
//

import XCTest
@testable import SwiftChartsInAction

final class CoverageViewModelTests: XCTestCase {
    
    var vm: CoverageVM!

    override func setUpWithError() throws {
        vm = CoverageVM.testCoverageVM
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func testFirstDay()  {
        
        let firstDay = date(year: 2022, month: 11, day: 28)
        
        XCTAssertEqual(firstDay, vm.firstDay)
        
    }
    
    func testLasttDay()  {
        
        let lastDay = date(year: 2022, month: 12, day: 26)
        
        XCTAssertEqual(lastDay, vm.lastDay)
        
    }
    
    func testReplenishmentSequence(){
        
        XCTAssertEqual("replenishment", vm.replenishmentSequence.type)
        
    }

    func testForecastSequence(){
        
        XCTAssertEqual("forecast", vm.forecastSequence.type)
        
    }
    
    func testPlaceReplenishment() {
        
        let replenishmentDate1 = date(year: 2022, month: 11, day: 28)
        let replenishmentQuantity1 = 4500
        let replenishmentDate2 = date(year: 2022, month: 12, day: 2)
        let replenishmentQuantity2 = 1000
        let replenishmentDate3 = date(year: 2022, month: 12, day: 7)
        let replenishmentQuantity3 = 24
        
        vm.placeReplenishment(when: replenishmentDate1, howMany: replenishmentQuantity1)
        vm.placeReplenishment(when: replenishmentDate2, howMany: replenishmentQuantity2)
        vm.placeReplenishment(when: replenishmentDate3, howMany: replenishmentQuantity3)
        
        XCTAssertEqual(6924, vm.replenishmentSequence.sequence.last?.finalStock)
        
    }
    
    func testgetReplenishment() {
        
        let dateExistingMovement = date(year: 2022, month: 11, day: 28)
        let dateNotExistingMovement = date(year: 2022, month: 12, day: 10)
        let replenishementExistingDate = MovementInStockTimeline(day: date(year: 2022, month: 11, day: 28), initialStock: 1800, finalStock: 2300, typeInOut: "replenishment", uniqueMovementInDay: false)
        let replesnishmentNotExistingDate: MovementInStockTimeline? = nil
        
        XCTAssertEqual(replenishementExistingDate, vm.getReplenishment(when: dateExistingMovement))
        XCTAssertEqual(replesnishmentNotExistingDate, vm.getReplenishment(when: dateNotExistingMovement))
        
    }
    
  /*  func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
