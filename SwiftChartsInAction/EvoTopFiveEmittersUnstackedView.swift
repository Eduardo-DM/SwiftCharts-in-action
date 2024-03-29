//
//  EvolutionTopFiveEmittersView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI
import Charts

struct EvoTopFiveEmittersUnstackedView: View {
    
    @EnvironmentObject var store: DataStore
    
    let startYear = 1990
    
    var body: some View {
        VStack(alignment: .leading){
            headerBlock
            chartBlock
                .frame(height: 400)
                .navigationBarTitle("Top 5 emitters unstacked", displayMode: .inline)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding()
    }
    
    var headerBlock: some View{
        VStack(alignment: .leading){
            Text("Emissions top 5 in the last year")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(store.evolutionTopFiveEmitters.filter({$0.year==2021}).map({$0.total ?? 0}).reduce(0, +), format: .number.precision(.fractionLength(0))) million metric tons")//(MMmt)
                .font(.title2.bold())
                .foregroundColor(.primary)
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
    var chartBlock: some View{
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
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(by: .value("Country", country.name))
        }
        .chartForegroundStyleScale(
            [
                "China": .red.opacity(0.1),
                "USA": .blue.opacity(0.1),
                "Japan": .green.opacity(0.6),
                "India":  .orange.opacity(0.3),
                "Russia":  .teal.opacity(0.4)
            ]
        )
        .chartXScale(domain: startYear...2021)
        .chartYScale(domain: 0...12000)
        .chartXAxis {
            AxisMarks() { _ in
                AxisGridLine()
                AxisValueLabel(centered: false, collisionResolution: .disabled)
                    .offset(x: -10.0, y:1.0)
            }
        }
    }
}

struct EvoTopFiveEmittersUnstackedView_Previews: PreviewProvider {
    static var previews: some View {
        EvoTopFiveEmittersUnstackedView()
            .environmentObject(DataStore())
    }
}

