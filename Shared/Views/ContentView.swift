//
//  ContentView.swift
//  Shared
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ClassView()
                .tabItem {
                    Label("Classroom", systemImage: "house")
                }
                .navigationViewStyle(.stack)
            
            StudentsView()
                .tabItem {
                    Label("Students", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let envObject = DataController()
    
    static var previews: some View {
        ContentView()
            .environmentObject(envObject)
    }
}
