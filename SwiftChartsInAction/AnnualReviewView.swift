//
//  AnnualReviewView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 20/10/22.
//

import SwiftUI
import Charts

struct AnnualReviewView: View {
    
    let company: Company
    let averageYears: Int
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Sales of \(company.name)")
                    .font(.title2.bold())
                Text("Average sales in the last \(averageYears) years: \(company.averageSalesBnLastYears(4).formatted(.number.precision(.fractionLength(1)))) Bn")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Chart(company.getOrderedSalesBn(ascendingOrder: false), id:\.self.0){
                BarMark(
                    x: .value("Year Sales", $0.1),
                    y: .value("Year", $0.0)
                )
            }
            .chartLegend(.visible)
            .navigationTitle("Sales")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(.horizontal)
    }
}

struct AnnualReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualReviewView(company: Company.apple, averageYears: 4)
    }
}
