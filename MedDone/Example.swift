import SwiftUI
//import SwiftData

struct Medication: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let icon: String
    var isCompleted: Bool
    var color: Color
}

struct Example: View {
    
//    @Query var medications : [Medication]
    
    @State private var medications = [
        Medication(name: "Risperidone", time: "11:32", icon: "capsule", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "9:56", icon: "tablets", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "10:09", icon: "liquid", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "10:20", icon: "liquid", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "15:20", icon: "capsule", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "00:20", icon: "tablets", isCompleted: false, color: .gray.opacity(0.5)),
    ]
    
    @State private var showModal = false
    @State private var selectedMedicationIndex: Int? = nil
    @State private var selectedTime = "Morning"
    private let timeOptions = ["Morning", "Afternoon", "Night"]
    var filteredMedications: [Medication] {
        switch selectedTime {
        case "Morning":
            return medications.filter { isMorning(time: $0.time) }
        case "Afternoon":
            return medications.filter { isAfternoon(time: $0.time) }
        case "Night":
            return medications.filter { isNight(time: $0.time) }
        default:
            return medications
        }
    }
    private func getColorForTime(_ time: String) -> Color {
        switch time {
        case "Morning":
            return Color("button")
        case "Afternoon":
            return Color("button")
        case "Night":
            return Color("button")
        default:
            return Color.primary
        }
    }
    
    // Helper methods to categorize the time
    private func isMorning(time: String) -> Bool {
        return isTimeInRange(time: time, start: "04:00", end: "12:00")
    }
    
    private func isAfternoon(time: String) -> Bool {
        return isTimeInRange(time: time, start: "12:00", end: "18:00")
    }
    
    private func isNight(time: String) -> Bool {
        return isTimeInRange(time: time, start: "18:00", end: "04:00", isNight: true)
    }
    
    
    private func isTimeInRange(time: String, start: String, end: String, isNight: Bool = false) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let timeDate = dateFormatter.date(from: time),
              let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: end) else {
            return false
        }
        if isNight {
            return timeDate >= startDate || timeDate < endDate
        } else {
            return timeDate >= startDate && timeDate < endDate
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("MedDone")
                        .font(.title)
                        .foregroundColor(Color("button"))
                    
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: CalendarPage()) {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("button"))
                            .font(.title2)
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Daily Medication Progress")
                        .font(.headline)
                    HStack {
                        Text("\(medications.filter { $0.isCompleted }.count) of \(medications.count) Completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Image(systemName: "checkmark.circle")
                            .font(.subheadline)
                            .foregroundColor(Color("button"))
                    }
                    
                    let completedCount = medications.filter { $0.isCompleted }.count
                    let totalCount = medications.count
                    let completionPercentage = totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0.0
                    
                    
                    ProgressView(value: completionPercentage, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 20)
                        .tint(completionPercentage == 1.0 ? .green : (completionPercentage > 0.13 ? Color("button") : .red))
                    
                    Text("\(Int(completionPercentage * 100))% Completed")
                        .font(.subheadline)
                        .foregroundColor(completionPercentage == 1.0 ? .green : (completionPercentage > 0.13 ? Color("button") : .red))
                }
                .padding(.vertical,20)
                
                .cornerRadius(10)
                
                Text("Today's medications")
                    .font(.title3)
                    .bold()
                    .padding(.top)
                
                Picker("", selection: $selectedTime) {
                    ForEach(timeOptions, id: \.self) { time in
                        Text(time).tag(time)
                            .foregroundColor(selectedTime == time ? getColorForTime(time) : .primary)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(5)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredMedications.indices, id: \.self) { index in
                            HStack {
                                Image(filteredMedications[index].icon)
                                    .foregroundColor(.purple)
                                    .frame(width:20)
                                
                                Divider()
                                    .frame(height: 20)
                                
                                VStack(alignment: .leading) {
                                    Text(filteredMedications[index].name)
                                        .bold()
                                    Text(filteredMedications[index].time)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Circle()
                                    .fill(filteredMedications[index].color)
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {
                                        if let selectedIndex = filteredMedications.firstIndex(where: { $0.id == filteredMedications[index].id }) {
                                            selectedMedicationIndex = selectedIndex
                                            showModal = true
                                        }
                                    }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            
                        }
                    }
                    .padding(5)
                }
                
                HStack {
                    NavigationLink(destination: AddMedicationPage()){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                        .foregroundColor(Color("button"))}
                    Text("Add Medication")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("button"))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding(.horizontal,18).background(Color("backColor"))
            .alert(isPresented: $showModal) {
                if let index = selectedMedicationIndex, index < filteredMedications.count {
                    let medication = filteredMedications[index]
                    
                    return Alert(
                        title: Text("Are you sure?"),
                        message: Text("Is it time to take \(medication.name) at \(medication.time), or should we call it a miss this time?"),
                        primaryButton: .default(Text("Taken")) {
                            if let originalIndex = medications.firstIndex(where: { $0.id == medication.id }) {
                                medications[originalIndex].isCompleted = true
                                medications[originalIndex].color = .green
                            }
                            showModal = false
                        },
                        secondaryButton: .destructive(Text("Missed")) {
                            if let originalIndex = medications.firstIndex(where: { $0.id == medication.id }) {
                                medications[originalIndex].isCompleted = false
                                medications[originalIndex].color = .red
                            }
                            showModal = false
                        }
                    )
                }
                return Alert(title: Text("Error: What's going on? This is Wrong Medication!  "))
            }
        }
    }
    
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}

