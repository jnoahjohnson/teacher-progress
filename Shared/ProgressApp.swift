//
//  ProgressApp.swift
//  Shared
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

@main
struct ProgressApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
        }
    }
}
