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
    
    @Published var evolutionTopFiveEmitters:[Country] = []
    @Published var data: [Country] = []
    
    init(){
        Task(priority: .high){
            await initSettings()
        }
    }
    
    @MainActor
    private func initSettings() async{
        loadCountries()
        setEvolutionTopFiveEmitters()
    }
    
    private func loadCountries() {
        let url = Bundle.main.url(forResource: "Emissions by country", withExtension: "csv")!
        data = loadCSVFile(from: url)
    }
    
   
    private func setEvolutionTopFiveEmitters() {
        self.evolutionTopFiveEmitters = data
            .filter({topFiveEmitters.contains($0.name)})
            .sorted(by: {sortCountryPerNameAndYear(countryA:$0, countryB:$1)})
     //   idTop5 = UUID()
       /* print("--------Evolution")
        dump(self.evolutionTopFiveEmitters)*/
    }
    
    private func sortCountryPerNameAndYear(countryA: Country, countryB: Country)-> Bool{
        if countryA.name < countryB.name {
            return true
        }
        else if countryA.name == countryB.name {
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
