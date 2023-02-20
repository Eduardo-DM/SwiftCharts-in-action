//
//  Model.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 14/2/23.
//

import Foundation

struct Movement{
    let day: Date
    let quantity: Int
    let typeInOut: String
    
    static let testInitialReplenishments: [Movement] = [
        Movement(day: date(year: 2022, month: 11, day: 28), quantity: 500, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 12), quantity: 500, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 21), quantity: 500, typeInOut: "replenishment")
    ]
    static let testForecastFourWeeks: [Movement] = [
        Movement(day: date(year: 2022, month: 11, day: 28), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 11, day: 29), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 11, day: 30), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 1), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 2), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 3), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 5), quantity: 200, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 9), quantity: 200, typeInOut: "forecast"),
        ]
    
    static let demoInitialReplesnishments: [Movement] = [
        Movement(day: date(year: 2022, month: 11, day: 28), quantity: 450, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 11, day: 30), quantity: 850, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 1), quantity: 450, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 12), quantity: 450, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 14), quantity: 650, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 5), quantity: 850, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 9), quantity: 650, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 19), quantity: 850, typeInOut: "replenishment"),
        Movement(day: date(year: 2022, month: 12, day: 21), quantity: 450, typeInOut: "replenishment")
    ]
    static let demoForecastFourWeeks: [Movement] = [
        Movement(day: date(year: 2022, month: 11, day: 28), quantity: 78, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 11, day: 29), quantity: 125, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 11, day: 30), quantity: 225, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 1), quantity: 234, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 2), quantity: 378, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 3), quantity: 425, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 5), quantity: 168, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 6), quantity: 274, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 7), quantity: 225, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 8), quantity: 351, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 9), quantity: 261, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 10), quantity: 335, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 12), quantity: 215, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 13), quantity: 278, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 14), quantity: 256, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 15), quantity: 315, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 16), quantity: 350, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 17), quantity: 450, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 19), quantity: 180, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 20), quantity: 215, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 21), quantity: 278, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 22), quantity: 435, typeInOut: "forecast"),
        Movement(day: date(year: 2022, month: 12, day: 23), quantity: 670, typeInOut: "forecast")
    ]
}

struct MovementInStockTimeline: Identifiable, Equatable{
    var id: String {day.ISO8601Format()+typeInOut}
    
    let day: Date
    let initialStock: Int
    let finalStock: Int
    let typeInOut: String
    let uniqueMovementInDay: Bool
    
    var quantity: Int {abs(finalStock - initialStock)}
    
    static func stockProyection(input: [Movement], output: [Movement], initialStock: Int) -> [MovementInStockTimeline] {
        var stock = initialStock
        let unión = output + input
        var movementsPerDay : [Date:Int] = [:]
        movementsPerDay.reserveCapacity(unión.count)
        unión.forEach {
            if let number = movementsPerDay[$0.day]{
                movementsPerDay[$0.day] = number + 1
            }
            else{
                movementsPerDay[$0.day] = 1
            }
        }
        return unión
            .sorted(by: {
                if $0.day == $1.day {
                    return ($0.typeInOut == "forecast" ? true : false)
                }
                else {

                    return $0.day < $1.day
                }
            })
            .map{ elemento in
                let variaciónStock = elemento.typeInOut == "forecast" ? -elemento.quantity : elemento.quantity
                let newElemento = MovementInStockTimeline(day: elemento.day, initialStock:stock, finalStock: stock + variaciónStock, typeInOut: elemento.typeInOut, uniqueMovementInDay: movementsPerDay[elemento.day] == 1 ? true : false)
                stock += variaciónStock
                return newElemento
            }
    }

    static let testRecord = MovementInStockTimeline(day: date(year: 2022, month: 12, day: 2), initialStock: 1000, finalStock: 1450, typeInOut: "replenishment", uniqueMovementInDay: false)
    
    static let demoInitialStock = 1523
    static let testInitialStock = 2000
}

struct SequenceByTypeOfMovement: Identifiable{
    let type: String
    var sequence: [MovementInStockTimeline]
    var id:String {type}
    
    static func splitSequencesPerTypeOfMovement(unifiedTimeline: [MovementInStockTimeline]) -> [SequenceByTypeOfMovement]{
        var forecast = SequenceByTypeOfMovement(type: "forecast", sequence: [])
        var replenishment = SequenceByTypeOfMovement(type: "replenishment", sequence: [])
        unifiedTimeline.forEach{
            if $0.typeInOut == "forecast" {
                forecast.sequence.append($0)
            }
            else{
                replenishment.sequence.append($0)
            }
        }
        return [forecast, replenishment]
    }
}


func date(year: Int, month: Int, day: Int = 1) -> Date {
   Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}



fileprivate let salesAppleBn = [2006 :19.1,
                              2007 : 24.4,
                              2008 : 37.4,
                              2009 : 42.7,
                              2010 : 65,
                              2011 : 108,
                              2012 : 156.3,
                              2013 : 170.8,
                              2014 : 182.6,
                              2015 : 233.6,
                              2016 : 215.4,
                              2017 : 229,
                              2018 : 265.4,
                              2019 : 260.1,
                              2020 : 274.3,
                              2021 : 365.8]

struct Company {
    let name: String
    let isin: String
    let sales: [Int : Double]
    
    init(name: String, isin: String, exact sales: [Int : Double]) {
        self.name = name
        self.isin = isin
        self.sales = sales
    }
    
    init(name: String, isin: String, bnSales sales: [Int : Double]) {
        self.name = name
        self.isin = isin
        self.sales = sales.mapValues{$0*1000000000}
    }
    
    func getOrderedSales(ascendingOrder: Bool = true) -> [(String, Double)]{
        return sales
            .sorted(by: { v1, v2 in
                ascendingOrder ? (v1.key<v2.key) : (v1.key>v2.key)
            })
            .map { (String($0.key), $0.value) }
    }
    
    func getOrderedSalesBn(ascendingOrder: Bool = true) -> [(String, Double)]{
        return self.getOrderedSales(ascendingOrder: ascendingOrder)
            .map {($0.0, $0.1*0.000000001)}
    }
    
    func averageSalesBnLastYears(_ years: Int) -> Double{
        guard years >= 1 else{
            return 0
        }
        return getOrderedSalesBn(ascendingOrder: false)
            .dropLast(sales.count - years)
            .map{$0.1}
            .reduce(0,{$0+$1}) / Double(years)
    }
    
    static let apple = Company(name: "Apple Inc.",isin:"US0378331005", bnSales: salesAppleBn)
    static let test = Company(name: "Test company", isin: "test1", bnSales: [2022:10.0, 2021:150.0, 2020:30.0, 2019:10.0, 2018:50.0, 2017:50.0])
}
