//
//  EvolutionTopFiveEmittersView.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 10/6/23.
//

import SwiftUI

struct EvolutionTopFiveEmittersView: View {
    
    @EnvironmentObject var store: DataStore
    
    var body: some View {
            List{
                ForEach(store.evolutionTopFiveEmitters) { country in
                    Text("\(country.name)")
                }
                //  Text("\($0.name)")
            
        }
    }
}
/*
struct EvolutionTopFiveEmittersView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionTopFiveEmittersView()
    }
}
*/
