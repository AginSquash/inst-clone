//
//  inst_cloneApp.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import SwiftUI

@main
struct inst_cloneApp: App {
    @StateObject var instCore: InstCore
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(instCore)
        }
    }
    
    init() {
        let instCore = InstCore()
        _instCore = StateObject(wrappedValue: instCore)
    }
}
