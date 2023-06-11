//
//  EvolutionTopFiveEmittersView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI
import Charts

struct EvolutionTopFiveEmittersView: View {
    
    @EnvironmentObject var store: DataStore
    let startYear = 1990
    
    var body: some View {
        Chart(store.evolutionTopFiveEmitters.filter({$0.year>=startYear})) { country in
            AreaMark(
                x: .value("Year", country.year),
                y: .value("Global", country.total ?? 0),
                stacking: .standard
            )
            .foregroundStyle(
                by: .value("Country", country.name)
            )
        }
        .chartXScale(domain: startYear...2021)
        .chartYScale(domain: 0...23000)
        .padding()
    }
}

struct EvolutionTopFiveEmittersView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionTopFiveEmittersView()
            .environmentObject(DataStore())
    }
}

