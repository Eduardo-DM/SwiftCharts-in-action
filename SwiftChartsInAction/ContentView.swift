//
//  ContentView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 14/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var path = NavigationPath()
   // let store = DataStore.shared
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                coverageLink
                annualSalesLink
                evolutionTopFiveEmittersUnstackedLink
                evolutionTopFiveEmittersStackedLink
            }
        }
    }
    
    var coverageLink: some View{
        NavigationLink {
            CoverageView(coverageVM: CoverageVM(initialStock: MovementInStockTimeline.demoInitialStock,
                                                sequencesByTypeOfMovement: SequenceByTypeOfMovement.splitSequencesPerTypeOfMovement(
                                                    unifiedTimeline: MovementInStockTimeline.stockProyection(
                                                        input: Movement.demoInitialReplesnishments,
                                                        output: Movement.demoForecastFourWeeks,
                                                        initialStock: MovementInStockTimeline.demoInitialStock))))
        } label: {
            Label("Interactive stock evolution", systemImage: "box.truck")
        }
    }
    var annualSalesLink: some View {
        NavigationLink {
            AnnualReviewView(company: Company.apple, averageYears: 4)
        } label: {
            Label("Sales", systemImage: "dollarsign")
        }
        .navigationTitle("Swift Charts")
    }
    var evolutionTopFiveEmittersUnstackedLink: some View{
        NavigationLink {
            EvoTopFiveEmittersUnstackedView()
        } label: {
            Label("Top five emitters (unstacked)", systemImage: "chart.line.uptrend.xyaxis")
        }
    }
    var evolutionTopFiveEmittersStackedLink: some View{
        NavigationLink {
            EvolutionTopFiveEmittersStackedView()
        } label: {
            Label("Top five emitters (stacked)", systemImage: "chart.line.uptrend.xyaxis")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
