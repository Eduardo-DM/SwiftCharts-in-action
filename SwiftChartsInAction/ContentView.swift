//
//  ContentView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 14/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CoverageView(coverageVM: CoverageVM(initialStock: MovementInStockTimeline.demoInitialStock,
                                                sequencesByTypeOfMovement: SequenceByTypeOfMovement.splitSequencesPerTypeOfMovement(
                                                    unifiedTimeline: MovementInStockTimeline.stockProyection(
                                                        input: Movement.demoInitialReplesnishments,
                                                        output: Movement.demoForecastFourWeeks,
                                                        initialStock: MovementInStockTimeline.demoInitialStock))))
            .tabItem {
                Label("Interactive stock evolution", systemImage: "box.truck")
            }
            AnnualReviewView(company: Company.apple, averageYears: 4)
                .tabItem {
                    Label("Sales", systemImage: "dollarsign")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
