//
//  CoverageView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 25/10/22.
//

import SwiftUI
import Charts

struct CoverageView: View {
    
    @StateObject private var coverageVM: CoverageVM
    
   init(coverageVM: CoverageVM) {
        self._coverageVM = StateObject(wrappedValue: coverageVM)
    }
    
    var body: some View {
        List{
            VStack(alignment: .leading){
                Text("Interactive stock evolution")
                    .font(.title2.bold())
                Text("Stock evolution next 4 weeks")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                ChartStockProyectionEightWeeks(sourceVM: coverageVM)
                    .frame(height: 240)
                PlaceOrderView(coverageVM: coverageVM)
                    .opacity(coverageVM.showPlaceReplenishementView ? 1.0 : 0.0)
            }
            .navigationTitle("Stock")
            .navigationBarTitleDisplayMode(.inline)
            .listRowSeparator(.hidden)
        }
        .padding(.top)
        .listStyle(.plain)
    }
}

struct CoverageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverageView(coverageVM: CoverageVM.testCoverageVM)
    }
}

struct ChartStockProyectionEightWeeks: View {
    
    @ObservedObject var sourceVM: CoverageVM
    
    var body: some View {
        Chart{
            ForEach(sourceVM.sequencesByTypeOfMovement, id:\.type){ serie in
                ForEach(serie.sequence) { element in
                    BarMark(
                        x: .value("Día", element.day, unit:.day),
                        yStart: .value("Inicial", element.initialStock),
                        yEnd: .value("Final", element.finalStock)
                    )
                    .position(by: .value("tipo", serie.type),span: .ratio(1))
                    .foregroundStyle(by: .value("tipo", serie.type))
                }
            }
        }
        .chartForegroundStyleScale([
            "forecast": .red,
            "replenishment": .blue
        ])
        .chartYAxis{
            AxisMarks(preset: .aligned, values: .stride(by: 500))
        }
        .chartXAxis{
            AxisMarks(values: .stride(by: .weekOfYear)){ value in
                let abscissa = value.as(Date.self)
                AxisGridLine()
                AxisTick()
                if let dateLabel = abscissa{
                    AxisValueLabel("""
w\(dateLabel.formatted(.dateTime.week(.twoDigits)))
\(dateLabel.formatted(.dateTime.day().month()))
""")
                }
            }
        }
        .chartOverlay{ proxyC in
            GeometryReader{ _ in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .onTapGesture(perform: { clickedPointInChart in
                        let pointDate = proxyC.value(atX: clickedPointInChart.x) as Date?
                        if let pointDate{
                            let componentsPointDate = Calendar.current.dateComponents([.year, .month, .day], from: pointDate)
                            if let day = Calendar.current.date(from: componentsPointDate){
                                sourceVM.draftingDate = day
                                sourceVM.draftingQuantity = sourceVM.getReplenishment(when: day)?.quantity ?? 0
                            }
                            sourceVM.showPlaceReplenishementView = true
                        }
                    })
            }
        }
    }
}
