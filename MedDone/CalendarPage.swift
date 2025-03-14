//
//  CalendarPage.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 01/03/25.
//

import SwiftUI
import SwiftData

struct CalendarPage: View {
    @Query var medications2: [Medicationas]
    @State private var date = Date()
    
    // Filter med for the selected date
    var filteredMedicationsForCalendar: [Medicationas] {
        medications2.filter { Calendar.current.isDate($0.selectedTime, inSameDayAs: date) }
    }

    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .accentColor(Color("dateColor"))
            .background(.white)
            .cornerRadius(20)

            // Overall progress
            Text("Overall Progress: \(calculateProgress())%")
                .padding()
                .foregroundStyle(Color("dateColor"))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Med list title
            Text("Medication List")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            // Med list
            medicationListView

            Spacer()
        }
        .padding(.horizontal, 15)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // list of med
    private var medicationListView: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(filteredMedicationsForCalendar) { medication in
                    MedicationRow(medication: medication)
                }
            }
            .background(.white)
            .cornerRadius(20)
            .frame(height: 170)
        }
    }

    // Row for each med
    private func MedicationRow(medication: Medicationas) -> some View {
        HStack {
//            Image(medication.medicineType.title)
//                .frame(width:17)
            Text("\(medication.name) \(medication.desc)")
                .foregroundColor((medication.isCompleted ?? false) ? .primary : .red)
            Spacer()
              
                Circle()
                    .fill(medication.isCompleted == true ? Color.green : Color.red)
                    .frame(width: 20, height: 20)
            }
        .padding()
        .background(medicationBackground(medication))
    }

    // Conditional background for the med item
    private func medicationBackground(_ medication: Medicationas) -> some View {
        Color.white.overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("background"))
                .padding(.top, 50)
        )
    }

    // Calc progress of filtering med
    func calculateProgress() -> Int {
        let totalCount = filteredMedicationsForCalendar.count
        let completedCount = filteredMedicationsForCalendar.filter { $0.isCompleted == true }.count
        return totalCount > 0 ? Int((Double(completedCount) / Double(totalCount)) * 100) : 0
    }
//    // Calc progress of all med
//    func calculateProgress() -> Int {
//        let totalCount = medications2.count
//        let completedCount = medications2.filter { $0.isCompleted == true }.count  //
//        return totalCount > 0 ? Int((Double(completedCount) / Double(totalCount)) * 100) : 0
//    }
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
