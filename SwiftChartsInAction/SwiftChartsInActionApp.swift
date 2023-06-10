//
//  SwiftChartsInActionApp.swift
//  SwiftChartsInAction
//
//  Created by Eduardo Developer on 20/2/23.
//

import SwiftUI

@main
struct SwiftChartsInActionApp: App {
    
    @StateObject var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
