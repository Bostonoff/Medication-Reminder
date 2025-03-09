//
//  CalendarPage.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 01/03/25.
//

import SwiftUI

struct CalendarPage: View {
    @State private var date = Date()
    
    
    let tasks = [
        ("Task 1", true),
        ("Task 2", false),
        ("Task 3", true)
    ]
    
    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .accentColor(Color("dateColor"))
            //            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(20)
            
            Text("Overall Progress: 90%")
                .padding()
                .foregroundStyle(Color("dateColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Text("Medication List")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                ScrollView(.vertical){
                    ForEach(tasks.indices, id: \.self) { index in
                        
                        HStack {
                            Circle()
                                .fill(tasks[index].1 ? Color.green : Color.red)
                                .frame(width: 20, height: 20)
                            
                            Text(tasks[index].0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            //                                .padding(.leading, 30)
                            
                            Spacer()
                            
                            
                        }
                        
                        .padding()
                        .background(
                            index != tasks.count - 1 ? Color.white.overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color("background"))
                                    .padding(.top, 50)
                                
                                
                                
                            ) : nil
                        )
                    }
                    
                    
                }   .background(.white)
                    .cornerRadius(20)
                //                    .padding(.horizontal, 15)
                    .frame(height:175)
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage()
    }
}

