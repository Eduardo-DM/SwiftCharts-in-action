//
//  Tools.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 9/6/23.
//

import Foundation

func loadCSVFile(from fileUrl: URL) -> [Country] {
    do {
        let fileContents = try String(contentsOf: fileUrl)
        let lines = fileContents.components(separatedBy: .newlines)
        
        var countries: [Country] = []
        countries.reserveCapacity(lines.count)
        
        if lines.count > 1 {
            let headers = lines[0].components(separatedBy: ",")
            
            for lineIndex in 1..<lines.count {
                let fields = lines[lineIndex].components(separatedBy: ",")
                
                if fields.count == headers.count {
                    let country = Country(
                        name: fields[0].replacingOccurrences(of: "\"", with: ""),
                        isoCode: fields[1].replacingOccurrences(of: "\"", with: ""),
                        year: Int(fields[2]) ?? -1,
                         total: Double(fields[3]),
                         coal: Double(fields[4]),
                         oil: Double(fields[5]),
                         gas: Double(fields[6]),
                         cement: Double(fields[7]),
                         flaring: Double(fields[8]),
                         other: Double(fields[9]),
                         perCapita: Double(fields[10])
                    )
                    
                    countries.append(country)
                }
            }
        }
        return countries
    } catch {
        print("Error reading CSV file:", error)
        return []
    }
}
