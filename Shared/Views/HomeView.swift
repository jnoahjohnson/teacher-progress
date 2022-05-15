//
//  HomeView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    @State var showingAddTest = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello There!")
            }
            
            .sheet(isPresented: $showingAddTest) {
                AddTest(withStudents: dataController.students, dataController: self.dataController)
            }
            .toolbar {
                ToolbarItem {
                    Button{
                        showingAddTest = true
                    } label: {
                        Label("Add Test", systemImage: "plus.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("My Classroom")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
