//
//  Context.swift
//  MedDone
//
//  Created by Mukhammad Bustonov on 03/03/25.
//

import SwiftUI

struct AdMedicationPage: View {
    @State private var isEditingDuration: Bool = false
    @State private var durationList: [(startDate: Date, endDate: Date)] = []
    @State private var editingIndex: Int? = nil
    @State private var selectedTwoTimes: [(date: Date, time: Date)] = []
    @State private var showTimePicker: Bool = false
    @State private var showEditTimePicker: Bool = false
    @State private var editingTimeIndex: Int? = nil
    @State private var selectedTime: Date = Date()
    @State private var isPastDate: Bool = false
    @Binding var selectedTimesFromParent: [(date: Date, time: Date)]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("At what Time?")
                .font(.headline)
            
            Button(action: {
                showTimePicker.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color("button"))
                    Text("Add a Time")
                        .foregroundColor(Color("button"))
                    Spacer()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            //            .shadow(radius: 0.2)
            
            Text("IF you schedule a time, we will send you a notification to take your medications")
                .font(.footnote)
                .foregroundColor(.gray)
            
            // Display all added times
            VStack {
                ForEach(selectedTwoTimes.indices, id: \.self) { index in
                    
                    HStack {
                        
                        Text("\(selectedTwoTimes[index].time, style: .time)")
                            .padding(.vertical, 5)
                        
                        //                                                Spacer()
                        
                        
                        Button(action: {
                            selectedTwoTimes.remove(at: index)
                            selectedTimesFromParent = selectedTwoTimes
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                        //                        Spacer()
                        Button(action: {
                            editingTimeIndex = index
                            selectedTime = selectedTwoTimes[index].time
                            //                            selectedTimesFromParent = selectedTwoTimes
                            showEditTimePicker.toggle()
                            
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.orange)
                        }
                        
                    }
                    .padding(.horizontal)
                }
            }/*.frame(height:50)*/
        }
        .sheet(isPresented: $showTimePicker) {
            VStack {
                Text("Select Time")
                    .font(.headline)
                    .padding()
                
                DatePicker("Select Date and Time", selection: $selectedTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                
                Text(isPastDate ? "Please select a future date/time: " : "")
                    .foregroundColor(.red)
                    .padding(5)
                
                Button("Save Time") {
                    if selectedTime > Date() {
                        let newEntry = (date: Date(), time: selectedTime)
                        selectedTwoTimes.append(newEntry)
                        selectedTimesFromParent = selectedTwoTimes
                        selectedTime = selectedTwoTimes.last?.time ?? Date()
                        showTimePicker.toggle()
                        isPastDate = false
                    } else {
                        isPastDate = true
                    }
                }
                
                .foregroundColor(Color("button"))
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showEditTimePicker) {
            VStack {
                Text("Edit Time")
                    .font(.headline)
                    .padding()
                
                DatePicker("Select Date and Time", selection: $selectedTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                
                Text(isPastDate ? "Please select a future date/time." : "")
                    .foregroundColor(.red)
                    .padding(.top, 5)
                
                Button("Save Changes") {
                    if selectedTime > Date() {
                        if let index = editingTimeIndex {
                            selectedTwoTimes[index].time = selectedTime  // Меняем только End Date
                        }
                        selectedTimesFromParent = selectedTwoTimes
                        selectedTime = selectedTwoTimes.last?.time ?? Date()
                        showEditTimePicker.toggle()
                        isPastDate = false
                    } else {
                        isPastDate = true
                    }
                }
                .foregroundColor(Color("button"))
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func minSelectableTime() -> Date {
        let now = Date()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: now)
        
        if selectedTime <= today {
            return now
        } else {
            return today
        }
    }
}

struct AdMedicationPage_Previews: PreviewProvider {
    static var previews: some View {
        AdMedicationPage(selectedTimesFromParent: .constant([(Date(), Date())]))
    }
}
