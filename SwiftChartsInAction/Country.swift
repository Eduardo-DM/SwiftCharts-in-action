//
//  Country.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 9/6/23.
//

import Foundation

struct Country: Identifiable {
    var id: String{get{"\(name) - \(String(year))"}}
    
    let name: String
    let isoCode: String
    let year: Int
    let total: Double?
    let coal: Double?
    let oil: Double?
    let gas: Double?
    let cement: Double?
    let flaring: Double?
    let other: Double?
    let perCapita: Double?
}
