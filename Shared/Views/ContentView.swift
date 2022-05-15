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
            HomeView()
                .tabItem {
                    Label("Class", systemImage: "house")
                }
            
            StudentsView()
                .tabItem {
                    Label("Students", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
