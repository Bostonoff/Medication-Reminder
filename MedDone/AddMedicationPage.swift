//
//  AddMedicationPage.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 01/03/25.
//

import SwiftUI
//import SwiftData
struct AddMedicationPage: View {
    //    @Environment(\.modelContext) var modelContext
    @State private var medicationName: String = ""
    @State private var description: String = ""
    @State private var doseAmount: String = ""
    @State private var selectedFrequency: String = "Every Day"
    @State private var selectedOption = 0
    @State private var showFrequencyModal: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var selectedTime: Date = Date()
    @State private var timeText: String = "Select Time"
    @State private var isEditingDuration: Bool = false
    @State private var durationList: [(startDate: Date, endDate: Date)] = []
    @State private var editingIndex: Int? = nil
    @State private var isPastDate: Bool = false
    @State private var isValid: Bool = true
    @State private var navigateToDetailsPage = false
    @State private var showValidationModal: Bool = true
    
    
    @State private var selectedTwoTimes: [(date: Date, time: Date)] = []
    let options = [
        ("capsule", "Capsule"),
        ("tablets", "Tablets"),
        ("liquid", "Liquid")
    ]
    let doseUnits = ["mg", "mcg", "g", "ml", "%"]
    
    var body: some View {
        //                NavigationView {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Name Input
                Text("Name")
                    .font(.headline)
                    .padding(.bottom,-5)
                    .padding(.top,20)
                
                VStack(alignment: .leading, spacing: 10) {
                    AppTextField("Medication Name", text: $medicationName)
                    Divider()
                    AppTextField("Description", text: $description)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                //                .shadow(radius: 0.2)
                
                
                // Medication Type
                VStack {
                    HStack {
                        ForEach(0..<options.count, id: \.self) { index in
                            HStack {
                                Button(action: {
                                    selectedOption = index
                                }) {
                                    HStack {
                                        Image(options[index].0)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        Text(options[index].1).foregroundColor(.black)
                                    }
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedOption == index ? Color.white : Color.clear)
                                    .cornerRadius(20)
                                    
                                }
                                
                                
                                if index < options.count - 1 {
                                    Divider()
                                        .frame(height: 20)
                                }
                            }
                        }
                    }
                    .padding(3)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                }
                
                
                // Dose Amount
                if options[selectedOption].0 == "liquid" {
                    VStack(alignment: .leading) {
                        Text("Dose Amount")
                            .font(.headline)
                        Menu {
                            ForEach(doseUnits, id: \.self) { unit in
                                Button(unit) {
                                    doseAmount = unit
                                }
                            }
                        } label: {
                            HStack {
                                Text(doseAmount.isEmpty ? "Select Dose" : doseAmount).foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            //                            .shadow(radius: 0.2)
                        }
                    }
                }
                
                // Frequency
                VStack(alignment: .leading) {
                    Text("When will you take this?")
                        .font(.headline)
                    HStack {
                        Text(selectedFrequency)
                        Spacer()
                        Button("Change") {
                            // Handle change
                            showFrequencyModal.toggle()
                        }
                        .foregroundColor(Color("dateColor"))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    //                    .shadow(radius: 0.2)
                }
                
                //              AdMedicationPage View
                HStack{
                    AdMedicationPage(selectedTimesFromParent: $selectedTwoTimes)
                    
                }
                
                // I need to edit this sections
                // Duration
                Text("Duration")
                    .font(.headline)
                    .padding(.bottom, -10)
                ForEach(selectedTwoTimes.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start Date")
                                Text(selectedTwoTimes[index].date, style: .date)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("End Date")
                                Text(selectedTwoTimes[index].time, style: .date)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        
                        
                        Divider()
                        
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    //                    .shadow(radius: 0.2)
                }
                
                
            }
            .padding(.horizontal,15)
            //        }
            .navigationTitle("Add Medication")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if medicationName.isEmpty && description.isEmpty && selectedFrequency.isEmpty && (options[selectedOption].0 == "liquid" || doseAmount.isEmpty) {
                            showValidationModal = true
                            
                        }
                        navigateToDetailsPage.toggle()
                    }
                    .foregroundColor(
                        medicationName.isEmpty || description.isEmpty || selectedFrequency.isEmpty || (options[selectedOption].0 == "liquid" && doseAmount.isEmpty) || selectedTwoTimes.isEmpty ? Color.gray : Color("button")
                    )
                    .padding()
                    .disabled(medicationName.isEmpty || description.isEmpty || selectedFrequency.isEmpty || (options[selectedOption].0 == "liquid" && doseAmount.isEmpty) || selectedTwoTimes.isEmpty)
                    .cornerRadius(10)
                }
            }
            .sheet(isPresented: $navigateToDetailsPage) {
                MedicationDetailsPage(
                    medicationName: medicationName,
                    description: description,
                    doseAmount: doseAmount,
                    selectedFrequency: selectedFrequency,
                    selectedTime: selectedTwoTimes,
                    durationList: durationList,
                    selectedOption: options[selectedOption].0
                )
            }
        }.background(Color("backColor"))
            .sheet(isPresented: $showFrequencyModal) {
                FrequencyListView(
                    selectedFrequency: $selectedFrequency,
                    showFrequencyModal: $showFrequencyModal
                )
            }
            .sheet(isPresented: $showTimePicker) {
                ShowTimeView(
                    selectedTime: $selectedTime,
                    editingIndex: $editingIndex,
                    isPastDate: $isPastDate,
                    durationList: $durationList,
                    showTimePicker: $showTimePicker
                )
            }
    }
    
}
struct MedicationDetailsPage: View {
    //    var id = UUID()
    var medicationName: String
    var description: String
    var doseAmount: String
    var selectedFrequency: String
    var selectedTime: [(date: Date, time: Date)]
    var durationList: [(startDate: Date, endDate: Date)]
    var selectedOption: String
    
    var body: some View {
        VStack {
            Text("Medication Details")
                .font(.title)
                .padding()
            
            Text("Name: \(medicationName)")
            Text("Description: \(description)")
            
            
            if selectedOption == "liquid" {
                Text("Dose Amount: \(doseAmount)")
            } else {
                Text("Medication Type: \(selectedOption.capitalized)")
            }
            
            Text("Frequency: \(selectedFrequency)")
            
            // Display (time and date)
            ForEach(selectedTime, id: \.date) { timeSlot in
                VStack(alignment: .leading) {
                    Text("At \(timeSlot.date, style: .time)")
                    Text("On \(timeSlot.time, style: .date)")
                        .foregroundColor(.gray)
                }
            }
            
            ForEach(durationList, id: \.startDate) { duration in
                Text("Duration: \(duration.startDate, style: .date) - \(duration.endDate, style: .date)")
            }
            
            Spacer()
        }
        .padding()
    }
}
struct AddMedicationPage_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationPage()
    }
}
