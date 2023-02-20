//
//  CompanyTests.swift
//  SwiftChartsInActionTests
//
//  Created by Eduardo Developer on 20/2/23.
//

import XCTest
@testable import SwiftChartsInAction

final class CompanyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetOrderedSales() {
        
        let salesDescending = Company.test.sales.map{
            return (String($0.key), $0.value)
        }
            .sorted(by: {$0.0>$1.0})
        let salesAscending = Array(salesDescending.reversed())
        
        XCTAssertEqual(salesDescending.count, Company.test.sales.count)
        XCTAssertEqual(salesAscending.count, Company.test.sales.count)
        
        for i in 0..<Company.test.sales.count{
            let elementInAscending = Company.test.getOrderedSales()[i]
            XCTAssertEqual(salesAscending[i].0, elementInAscending.0)
            XCTAssertEqual(salesAscending[i].1, elementInAscending.1)
            let elementInDescending = Company.test.getOrderedSales(ascendingOrder: false)[i]
            XCTAssertEqual(salesDescending[i].0, elementInDescending.0)
            XCTAssertEqual(salesDescending[i].1, elementInDescending.1)
        }
        
    }
    
    func testGetOrderedSalesBn() {
        
        let salesDescending = Company.test.sales.map{
            return (String($0.key), $0.value*0.000000001)
        }
            .sorted(by: {$0.0>$1.0})
        let salesAscending = Array(salesDescending.reversed())
        
        let calculatedBnSalesDescending = Company.test.getOrderedSalesBn(ascendingOrder: false)
        let calcuclatedBnSalesAscending = Company.test.getOrderedSalesBn()
        
        XCTAssertEqual(salesDescending.count, calculatedBnSalesDescending.count)
        XCTAssertEqual(salesAscending.count, calcuclatedBnSalesAscending.count)
        
        for i in 0..<calculatedBnSalesDescending.count{
            XCTAssertEqual(salesAscending[i].0, calcuclatedBnSalesAscending[i].0)
            XCTAssertEqual(salesAscending[i].1, calcuclatedBnSalesAscending[i].1)
            XCTAssertEqual(salesDescending[i].0, calculatedBnSalesDescending[i].0)
            XCTAssertEqual(salesDescending[i].1, calculatedBnSalesDescending[i].1)
        }
        
    }
    
    func testAverageSalesBnLastYears(){
        
        let average4LastYears = 50.0
        let resultForZeroOrLess = 0.0
        
        let calculatedAverage4Years = Company.test.averageSalesBnLastYears(4)
        
        XCTAssertEqual(average4LastYears, calculatedAverage4Years)
        XCTAssertEqual(resultForZeroOrLess, Company.test.averageSalesBnLastYears(0))
        XCTAssertEqual(resultForZeroOrLess, Company.test.averageSalesBnLastYears(-1))
        
    }
/*
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
