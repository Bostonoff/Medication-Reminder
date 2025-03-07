////
////  context.swift
////  MediMind
////
////  Created by Mukhammad Bustonov on 03/03/25.
////
//
//import SwiftUI
//
//struct Medication: Identifiable {
//    let id = UUID()
//    let name: String
//    let description: String
//    let doseAmount: String
//    let frequency: String
//    let time: Date
//    let durationList: [(startDate: Date, endDate: Date)]
//    let type: String
//}
//
//struct context: View {
//    var medication: Medication
//
//    var body: some View {
//        VStack {
//            Text("Medication Details").font(.title).padding()
//            
//            Group {
//                Text("Name: \(medication.name)")
//                Text("Description: \(medication.description)")
//                Text(medication.type == "liquid" ? "Dose Amount: \(medication.doseAmount)" : "Medication Type: \(medication.type.capitalized)")
//                Text("Frequency: \(medication.frequency)")
//                Text("Time: \(medication.time, style: .time)")
//            }
//            
//            ForEach(medication.durationList, id: \.startDate) { duration in
//                Text("Duration: \(duration.startDate, style: .date) - \(duration.endDate, style: .date)")
//            }
//            
//            Spacer()
//        }
//        .padding()
//    }
//}
//#Preview {
//    context(medication: Medication(
//        name: "Aspirin",
//        description: "Pain reliever",
//        doseAmount: "500 mg",
//        frequency: "Every Day",
//        time: Date(),
//        durationList: [(startDate: Date(), endDate: Date().addingTimeInterval(3600))],  // Example duration
//        type: "pill"
//    ))
//}



//VARINAT ONE OPTION ONE AND NORM IDEA
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
    @Binding var selectedTimesFromParent: [(date: Date, time: Date)] // Added Binding
    
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
                        .foregroundColor(Color("dateColor"))
                    Spacer()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
            
            Text("IF you schedule a time, we will send you a notification to take your medications")
                .font(.footnote)
                .foregroundColor(.gray)
            
            // Display all added times
            VStack {
                ForEach(selectedTwoTimes.indices, id: \.self) { index in
                   
                    HStack {
                        Text("\(selectedTwoTimes[index].date, style: .date) at \(selectedTwoTimes[index].time, style: .time)")
                            .padding(.vertical, 5)
                        
                        Spacer()
                        
                        Button(action: {
                            editingTimeIndex = index
                            selectedTime = selectedTwoTimes[index].time
//                            selectedTimesFromParent = selectedTwoTimes
                            showEditTimePicker.toggle()
                            
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.orange)
                        }
                        
                        Button(action: {
                            selectedTwoTimes.remove(at: index)
                            selectedTimesFromParent = selectedTwoTimes
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
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
                       
                        selectedTwoTimes.append((date: selectedTime, time: selectedTime))
                        selectedTimesFromParent = selectedTwoTimes // Sync with the parent view
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
                            selectedTwoTimes[index].time = selectedTime
                            selectedTwoTimes[index].date = selectedTime
                          
                        }
                        selectedTimesFromParent = selectedTwoTimes // Sync with the parent view
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
