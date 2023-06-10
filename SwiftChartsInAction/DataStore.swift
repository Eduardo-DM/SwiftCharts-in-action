//
//  DataStore.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI

final class DataStore{
    
    static let shared = DataStore()
    
    @MainActor
    var data: [Country] = []
    
    private init(){
        Task{
            await loadCountries()
        }
    }
    
    @MainActor
    private func loadCountries() async{
        print("--------")
        let url = Bundle.main.url(forResource: "Emissions by country", withExtension: "csv")!
        data = loadCSVFile(from: url)
        print(data[data.count-1])
        print(data.count)
    }
    
}
