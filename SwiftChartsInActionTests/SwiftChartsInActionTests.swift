//
//  SwiftChartsInActionTests.swift
//  SwiftChartsInActionTests
//
//  Created by Eduardo Developer on 14/2/23.
//

import XCTest
@testable import SwiftChartsInAction

final class SwiftChartsDemoTests: XCTestCase {
    var locationTest:LocationsTest!
    
    override func setUpWithError() throws {
        locationTest = LocationsTest()
    }

    override func tearDownWithError() throws {
        try eraseTestFiles(in: locationTest)
        locationTest = nil
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
    
    func testLoadCSVFile(){
        let nRecords = 3
        let afgCoal: Double? = nil
        let sample1 = ("Afghanistan",1750, afgCoal)
        let sample2 = ("Global", 2012, 35006.267581)
        
        let data = loadCSVFile(from: locationTest.bundle)
        
        XCTAssertEqual(nRecords, data.count)
        XCTAssertEqual(sample1.2 , data.first(where: {$0.name == sample1.0 && $0.year == sample1.1})?.coal)
        XCTAssertEqual(sample2.2, data.first(where: {$0.name == sample2.0 && $0.year == sample2.1})?.total)
        XCTAssertEqual(sample2.0, data.first(where: {$0.name == sample2.0 && $0.year == sample2.1})?.name)
    }

    @MainActor func testTopFiveEmitters(){
        
        dump(DataStore.shared.data.count)
        
        let sortedCountries = Array(DataStore.shared.data
            .filter({$0.year == 2021})
            .sorted(by: {($0.total ?? 0.0) > ($1.total ?? 0.0)})
            .dropFirst(1)
                                    )
        dump(sortedCountries)
        var countries: [String] = []
        for i in 0...4{
            let countryName = sortedCountries[i].name
            countries.append(countryName)
        }
        
        dump(countries)
        XCTAssertEqual("China", countries[0])
        print(countries)
        
 
    }
    
   /* func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
