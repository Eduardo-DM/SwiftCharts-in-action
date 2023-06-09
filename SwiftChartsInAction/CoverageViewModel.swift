//
//  CoverageViewModel.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 25/11/22.
//

import Foundation

final class CoverageVM: ObservableObject, Hashable{
    
    static func == (lhs: CoverageVM, rhs: CoverageVM) -> Bool {
        lhs.id == rhs.id
    }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID = UUID()
    
    let initialStock: Int

    enum KeyboardControl: Int{
        case show
    }
    
    @Published var sequencesByTypeOfMovement: [SequenceByTypeOfMovement]
    @Published var draftingDate: Date{
        didSet{
            draftingQuantity = self.getReplenishment(when: draftingDate)?.quantity ?? 0
    }}
    @Published var draftingQuantity: Int
    @Published var showPlaceReplenishementView = false
    
    var lastDay: Date {
        get{
            return firstDay.advanced(by: 2419200)//3600*24*7*4
        }
    }
    var firstDay: Date {
        get{
            return forecastSequence.sequence.first?.day ?? Date.now
        }
    }
    
    var replenishmentSequence: SequenceByTypeOfMovement{get {
        return (sequencesByTypeOfMovement[0].type=="replenishment") ? sequencesByTypeOfMovement[0] : sequencesByTypeOfMovement[1]
    }}
    
    var forecastSequence: SequenceByTypeOfMovement{get {
        return (sequencesByTypeOfMovement[0].type=="replenishment") ? sequencesByTypeOfMovement[1] : sequencesByTypeOfMovement[0]
        
    }}
    
    init(initialStock: Int, draftReplenishment: MovementInStockTimeline? = nil, sequencesByTypeOfMovement: [SequenceByTypeOfMovement]) {
        self.initialStock = initialStock
        self.sequencesByTypeOfMovement = sequencesByTypeOfMovement
        let sequenceForecast = (sequencesByTypeOfMovement[0].type=="replenishment") ? sequencesByTypeOfMovement[1] : sequencesByTypeOfMovement[0]
        self.draftingDate = draftReplenishment?.day ?? sequenceForecast.sequence.first?.day ?? Date.now
        if let draftReplenishment {
            draftingQuantity = draftReplenishment.finalStock - draftReplenishment.initialStock
        }
        else{
            draftingQuantity = 0
        }
    }
    
    func placeReplenishment (when date: Date, howMany q: Int){
        
        var stock = initialStock
        
        var replenishmmentSequenceTemp = replenishmentSequence.sequence
        replenishmmentSequenceTemp.removeAll{$0.day == date}
        var newReplenishmentMovements: [Movement] = replenishmmentSequenceTemp
            .map{return Movement(day: $0.day, quantity: $0.quantity, typeInOut: "replenishment")}
        newReplenishmentMovements.append(Movement(day: date, quantity: q, typeInOut: "replenishment"))
        
        let forecastMovementRecords = self.forecastSequence.sequence
            .map{return Movement(day: $0.day, quantity: $0.quantity, typeInOut: $0.typeInOut)}
        let joinedMovements = newReplenishmentMovements + forecastMovementRecords
        var movementsPerDay : [Date:Int] = [:]
        movementsPerDay.reserveCapacity(movementsPerDay.count)
        joinedMovements.forEach {
            if let number = movementsPerDay[$0.day]{
                movementsPerDay[$0.day] = number + 1
            }
            else{
                movementsPerDay[$0.day] = 1
            }
        }
        let stockProyection = joinedMovements
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
        sequencesByTypeOfMovement[0].sequence.removeAll(keepingCapacity: true)
        sequencesByTypeOfMovement[1].sequence.removeAll(keepingCapacity: true)
        stockProyection.forEach { mov in
            if mov.typeInOut == "forecast"{
                sequencesByTypeOfMovement[0].sequence.append(mov)
            }
            else{
                sequencesByTypeOfMovement[1].sequence.append(mov)
            }
        }
    }
    
    func getReplenishment(when date: Date) -> MovementInStockTimeline?{
        return replenishmentSequence.sequence.filter{$0.day == date}.first
    }
    
    static let testCoverageVM =  CoverageVM(
        initialStock: MovementInStockTimeline.testInitialStock,
        sequencesByTypeOfMovement:
            SequenceByTypeOfMovement.splitSequencesPerTypeOfMovement(
                unifiedTimeline: MovementInStockTimeline.stockProyection(
                    input: Movement.testInitialReplenishments,
                    output: Movement.testForecastFourWeeks,
                    initialStock: MovementInStockTimeline.testInitialStock)))
}
