//
//  EvoTopThreeEmittersUnstackedView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 15/6/23.
//

import SwiftUI
import Charts

struct EvoTopThreeEmittersUnstackedView: View {
    
    @EnvironmentObject var store: DataStore
    
    let startYear = 1990
    
    var body: some View {
        VStack(alignment: .leading){
            headerBlock
            chartBlock
                .frame(height: 400)
                .navigationBarTitle("Top 3 emitters unstacked", displayMode: .inline)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding()
    }
    
    var headerBlock: some View{
        VStack(alignment: .leading){
            Text("Emissions top 3 in the last year:")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(store.evolutionTopThreeEmitters.filter({$0.year==2021}).map({$0.total ?? 0}).reduce(0, +), format: .number.precision(.fractionLength(0))) million metric tons")//(MMmt)
                .font(.title2.bold())
                .foregroundColor(.primary)
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
    var chartBlock: some View{
        Chart(store.evolutionTopThreeEmitters.filter({$0.year>=startYear})) { country in
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
            range: Gradient (
                colors: [
                    .red.opacity(0.5),
                    .blue.opacity(0.55)
                ]
            )
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

struct EvoTopThreeEmittersUnstackedView_Previews: PreviewProvider {
    static var previews: some View {
        EvoTopThreeEmittersUnstackedView()
            .environmentObject(DataStore())
    }
}
