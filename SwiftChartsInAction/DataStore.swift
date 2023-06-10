//
//  DataStore.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI

final class DataStore{
    
    static let shared = DataStore()
    let topFiveEmitters: Set <String> = ["China", "USA", "India", "Russia", "Japan"]
    
    var evolutionTopFiveEmitters:[Country]?
    
    @MainActor
    var data: [Country] = [] {
        didSet{
            Task{
                await setEvolutionTopFiveEmitters()
            }
        }
    }
    
    private init(){
        Task{
            await loadCountries()
        }
    }
    
    @MainActor
    private func loadCountries() async{
        let url = Bundle.main.url(forResource: "Emissions by country", withExtension: "csv")!
        data = loadCSVFile(from: url)
    }
    
    @MainActor
    private func setEvolutionTopFiveEmitters() async{
        self.evolutionTopFiveEmitters = data
            .filter({topFiveEmitters.contains($0.name)})
            .sorted(by: {sortCountryPerNameAndYear(countryA:$0, countryB:$1)})
        print("--------Evolution")
        dump(self.evolutionTopFiveEmitters)
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
