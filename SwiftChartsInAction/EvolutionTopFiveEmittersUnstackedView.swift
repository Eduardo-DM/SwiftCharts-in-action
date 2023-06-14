//
//  EvolutionTopFiveEmittersView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI
import Charts

struct EvolutionTopFiveEmittersUnstackedView: View {
    
    @EnvironmentObject var store: DataStore
    
    let startYear = 1990
    
    var body: some View {
        Chart(store.evolutionTopFiveEmitters.filter({$0.year>=startYear})) { country in
            AreaMark(
                x: .value("Year", country.year),
                y: .value("Total", country.total ?? 0),
                stacking: .unstacked
            )
            .foregroundStyle(
                by: .value("Country", country.name)
            )
            LineMark(x: .value("Year", country.year), y: .value("Total", country.total ?? 0))
                .lineStyle(StrokeStyle(lineWidth: 1))
                .foregroundStyle(.blue)
                .foregroundStyle(by: .value("Country", country.name))
        }
        .chartForegroundStyleScale(
            range: Gradient (
                colors: [
                    .red.opacity(0.8),
                    .yellow.opacity(0.6),
                    .green.opacity(0.4),
                    .blue.opacity(0.2)
                ]
            )
        )
        .chartXScale(domain: startYear...2021)
        .chartYScale(domain: 0...14000)
        .chartXAxis {
            AxisMarks() { _ in
                AxisGridLine()
                AxisValueLabel(centered: false, collisionResolution: .disabled)
                    .offset(x: -10.0, y:1.0)
            }
        }
        .padding()
    }
}

struct EvolutionTopFiveEmittersUnstackedView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionTopFiveEmittersUnstackedView()
            .environmentObject(DataStore())
    }
}

