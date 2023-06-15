//
//  DataStore.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI

final class DataStore: ObservableObject{
    
   // static let shared = DataStore()
    let topFiveEmitters: Set <String> = ["China", "USA", "India", "Russia", "Japan"]
    let topThreeEmitters: Set <String> = ["China", "USA", "India"]
    
    @Published var evolutionTopFiveEmitters:[Country] = []
    @Published var evolutionTopThreeEmitters:[Country] = []
    @Published var data: [Country] = []
    
    let order: [String:Int] = ["China":1, "USA":2, "India":3, "Russia":4, "Japan":5]
    
    init(){
        Task(priority: .high){
            await initSettings()
        }
    }
    
    @MainActor
    private func initSettings() async{
        loadCountries()
        evolutionTopFiveEmitters = setEvolutionEmitters(countries: topFiveEmitters)
        evolutionTopThreeEmitters = setEvolutionEmitters(countries: topThreeEmitters)
    }
    
    private func loadCountries() {
        let url = Bundle.main.url(forResource: "Emissions by country", withExtension: "csv")!
        data = loadCSVFile(from: url)
    }
    
   
    private func setEvolutionEmitters(countries: Set<String>) -> [Country]{
        return data
            .filter({countries.contains($0.name)})
            .sorted(by: {sortCountryPerNameAndYear(countryA:$0, countryB:$1)})
     //   idTop5 = UUID()
       /* print("--------Evolution")
        dump(self.evolutionTopFiveEmitters)*/
    }
    
    private func sortCountryPerNameAndYear(countryA: Country, countryB: Country)-> Bool{
        guard let orderA = order[countryA.name], let orderB = order[countryB.name] else{
            return false
        }
        
        if orderA < orderB {
            return true
        }
        else if orderA  == orderB {
            if countryA.year < countryB.year{
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
    
}
