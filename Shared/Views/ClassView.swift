//
//  HomeView.swift
//  Progress
//
//  Created by Noah Johnson on 4/10/22.
//

import SwiftUI
import Charts

enum Month: String, CaseIterable {
    case august = "Aug"
    case september = "Sep"
    case october = "Oct"
    case november = "Nov"
    case december = "Dec"
    case january = "Jan"
    case february = "Feb"
    case march = "Mar"
    case april = "Apr"
    case may = "May"
    case all = "All"
}

struct ClassView: View {
    @ObservedObject var classVM = ClassViewModel()
    @State var showingAddTest = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Your class average this year is \(classVM.getClassAverage())")
                
                Picker("Month", selection: $classVM.filteredMonth) {
                    Text("Sep").tag(Month.september)
                    Text("Oct").tag(Month.october)
                    Text("Nov").tag(Month.november)
                    Text("Dec").tag(Month.december)
                    Text("Jan").tag(Month.january)
                    Text("Feb").tag(Month.february)
                    Text("Mar").tag(Month.march)
                    Text("Apr").tag(Month.april)
                    Text("May").tag(Month.may)
                    Text("All").tag(Month.all)
                }
                .pickerStyle(.segmented)
                
                Text("Your class average in \(classVM.filteredMonth) is \(classVM.getMonthClassAverage(month: classVM.filteredMonth))")
                
                Chart {
                    ForEach(self.classVM.graphData, id: \.month) { item in
                        PointMark(x: .value("Month", item.month), y: .value("Score", item.score))
                            .annotation {
                                Text(String(item.score))
                                    .font(.caption)
                            }
                    }
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button("Reset") {
                        classVM.seedData()
                    }
                }
                ToolbarItem {
                    Button("Test Students") {
                        showingAddTest = true
                    }
                }
            }
            .navigationTitle("My Classroom")
            .sheet(isPresented: $showingAddTest) {
                TestStudents(with: TestStudentsViewModel(students: classVM.getAllStudents()))
            }
        }
    }
}


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView()
    }
}
