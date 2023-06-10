//
//  Environment.swift
//  SwiftChartsInActionTests
//
//  Created by Eduardo Developer on 10/6/23.
//

import XCTest
@testable import SwiftChartsInAction

final class LocationsTest {
    var filename = "Emissions test"
    var bundle:URL { Bundle(for: SwiftChartsDemoTests.self).url(forResource: filename, withExtension: "csv")! }
    var fileManager:URL {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return doc.appendingPathComponent(filename).appendingPathExtension("csv")
    }
}

func eraseTestFiles(in locationTest: LocationsTest) throws {
    if FileManager.default.fileExists(atPath: locationTest.fileManager.path) {
        try FileManager.default.removeItem(at: locationTest.fileManager)
    }
}
