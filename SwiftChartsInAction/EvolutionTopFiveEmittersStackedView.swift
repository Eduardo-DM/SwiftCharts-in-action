//
//  EvolutionTopFiveEmittersStackedView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 12/6/23.
//

import SwiftUI

import SwiftUI
import Charts

struct EvolutionTopFiveEmittersStackedView: View {
    
    @EnvironmentObject var store: DataStore
    let startYear = 1990
    
    var body: some View {
        Chart(store.evolutionTopFiveEmitters.filter({$0.year>=startYear})) { country in
            AreaMark(
                x: .value("Year", country.year),
                y: .value("Total emissions", country.total ?? 0),
                stacking: .standard
            )
            .foregroundStyle(
                by: .value("Country", country.name)
            )
        }
        .padding()
    }
}

struct EvolutionTopFiveEmittersStackedView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionTopFiveEmittersStackedView()
            .environmentObject(DataStore())
    }
}
/*    .chartXScale(domain: startYear...2021)
    .chartYScale(domain: 0...23000)
    .chartXAxis {
        AxisMarks() { _ in
            AxisGridLine()
            AxisValueLabel(centered: false, collisionResolution: .disabled)
                .offset(x: -10.0, y:1.0)
        }
    }*/
