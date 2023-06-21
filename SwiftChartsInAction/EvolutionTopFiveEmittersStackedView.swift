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
        VStack(alignment: .leading){
            headerBlock
            chartBlock
                .frame(height: 340)
            Spacer()
                .navigationBarTitle("Top five emitters (stacked)", displayMode: .inline)
        }
        .padding()
    }
    
    var chartBlock: some View{
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
        .chartYScale(domain: 0...22500)
        .chartXScale(domain: startYear...2021)
        .chartYAxis{
            AxisMarks(values: .stride(by: 2500)){ _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel()
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .top) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(collisionResolution: .disabled)
                    //.offset(x: -20.0, y:0)
            }
        }
        .padding(.leading,10)
    }
    
    var headerBlock: some View{
        VStack(alignment: .leading){
            Text("Emissions top 5 in 2021")
                .font(.callout)
                .foregroundStyle(.secondary)
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Text("\(store.evolutionTopFiveEmitters.filter({$0.year==2021}).map({$0.total ?? 0}).reduce(0, +), format: .number.precision(.fractionLength(0))) million metric tons")//(MMmt)
                .font(.title2.bold())
                .foregroundColor(.primary)
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
}

struct EvolutionTopFiveEmittersStackedView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionTopFiveEmittersStackedView()
            .environmentObject(DataStore())
    }
}

