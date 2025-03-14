import SwiftUI
import SwiftData

struct Medication: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let icon: String
    var isCompleted: Bool
    var color: Color
}

struct Example: View {
    
    @Query var medications2: [Medicationas]
    @State private var selectedMedicine: Medicationas?
    
    @State private var medications = [
        Medication(name: "Risperidone", time: "11:32", icon: "capsule", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "19:56", icon: "tablets", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "14:09", icon: "liquid", isCompleted: false, color: .gray.opacity(0.5)),
        Medication(name: "Risperidone", time: "00:20", icon: "liquid", isCompleted: false, color: .gray.opacity(0.5)),
    ]
    
    @State private var showModal = false
    @State private var selectedMedicationIndex: Int? = nil
    @State private var selectedTime = "Morning"
    private let timeOptions = ["Morning", "Afternoon", "Night"]
    
    var filteredMedications: [Medicationas] {
        switch selectedTime {
        case "Morning":
            return medications2.filter { isMorning(time: $0.selectedTime) }
        case "Afternoon":
            return medications2.filter { isAfternoon(time: $0.selectedTime) }
        case "Night":
            return medications2.filter { isNight(time: $0.selectedTime) }
        default:
            return medications2
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
    
//    // Helper methods to categorize the time
//    private func isMorning(time: String) -> Bool {
//        return isTimeInRange(time: time, start: "04:00", end: "12:00")
//    }
//    
//    private func isAfternoon(time: String) -> Bool {
//        return isTimeInRange(time: time, start: "12:00", end: "18:00")
//    }
//    
//    private func isNight(time: String) -> Bool {
//        return isTimeInRange(time: time, start: "18:00", end: "04:00", isNight: true)
//    }
//    
//    
//    private func isTimeInRange(time: String, start: String, end: String, isNight: Bool = false) -> Bool {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        
//        guard let timeDate = dateFormatter.date(from: time),
//              let startDate = dateFormatter.date(from: start),
//              let endDate = dateFormatter.date(from: end) else {
//            return false
//        }
//        if isNight {
//            return timeDate >= startDate || timeDate < endDate
//        } else {
//            return timeDate >= startDate && timeDate < endDate
//        }
//    }
    private func extractTime(from dateTime: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            guard let date = dateFormatter.date(from: dateTime) else { return nil }
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        }
        
        // Helper methods to categorize the time
    func isMorning(time: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        return hour >= 6 && hour < 12
    }

    func isAfternoon(time: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        return hour >= 12 && hour < 18
    }

    func isNight(time: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        return hour >= 18 || hour < 6
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
                        Text("\(medications2.filter { $0.isCompleted ?? false }.count) of \(medications2.count) Completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Image(systemName: "checkmark.circle")
                            .font(.subheadline)
                            .foregroundColor(Color("button"))
                    }
                    // Calculate progress for all medications (not filtered by time)
                    let completedCount = medications2.filter { $0.isCompleted ?? false }.count
                    let totalCount = medications2.count
                    let completionPercentage = totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0.0
                    
//                    // Calculate progress for filtering medications (not for all )
//                    let completedCount = filteredMedications.filter { $0.isCompleted ?? false }.count
//                    let totalCount = filteredMedications.count
//                    let completionPercentage = totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0.0
                    
                    ProgressView(value: completionPercentage, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 20)
                        .tint(completionPercentage == 1.0 ? Color("button") : (completionPercentage > 0.13 ? Color("button") : .red))
                    
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
                
                HStack {
                    ForEach(timeOptions, id: \.self) { time in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedTime = time
                            }
                        }) {
                            Text(time)
                                .foregroundColor(selectedTime == time ? getColorForTime(time) : .black)
                                .padding(3)
                                .frame(maxWidth: .infinity)
                                .background(selectedTime == time ? Color.white : Color.clear)
                                .cornerRadius(10)
                            
                        }
                        
                        if time != timeOptions.last {
                            Divider()
                                .frame(height: 17)
                                .background(Color.gray.opacity(0.9))
                            // Divider color
                        }
                    }
                }
                .padding(3)
                .background(Color.gray.opacity(0.09))
                .cornerRadius(10)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(filteredMedications) { item in
                            HStack {
                                Image(item.medicineType.title)
                                    .foregroundColor(.purple)
                                    .frame(width:20)
                                
                                Divider()
                                    .frame(height: 20)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name + " " + item.doseAmount)
                                        .bold()
                                    Text(extractTime(from: item.selectedTime.description) ?? "Invalid Time")                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Circle()
                                    .fill(
                                        {
                                            switch item.isCompleted {
                                            case true:
                                                return Color.green
                                            case false:
                                                return Color.red
                                            default:
                                                return Color.gray.opacity(0.5)
                                            }
                                        }()
                                    )
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {

                                        selectedMedicine = item
                                        showModal = true
                                    }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            
                        }
                        .transition(.slide)
                        
//                        ForEach(filteredMedications.indices, id: \.self) { index in
//                            HStack {
//                                Image(filteredMedications[index].icon)
//                                    .foregroundColor(.purple)
//                                    .frame(width:20)
//
//                                Divider()
//                                    .frame(height: 20)
//
//                                VStack(alignment: .leading) {
//                                    Text(filteredMedications[index].name)
//                                        .bold()
//                                    Text(filteredMedications[index].time)
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                }
//
//                                Spacer()
//
//                                Circle()
//                                    .fill(filteredMedications[index].color)
//                                    .frame(width: 24, height: 24)
//                                    .onTapGesture {
//                                        if let selectedIndex = filteredMedications.firstIndex(where: { $0.id == filteredMedications[index].id }) {
//                                            selectedMedicationIndex = selectedIndex
//                                            showModal = true
//                                        }
//                                    }
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(15)
//
//
//                        }.transition(.slide)
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
                let timeString = selectedMedicine?.selectedTime.description ?? "Unknown Time"
                let extractedTime = extractTime(from: timeString) ?? "Invalid Time"
                
                    
                    return Alert(
                        title: Text("Are you sure?"),
                        message: Text("Is it time to take \(selectedMedicine?.name ?? "your medicine") at \(extractedTime), or should we call it a miss this time?"),
                        primaryButton: .default(Text("Taken")) {
                            
                            selectedMedicine?.isCompleted = true

                            showModal = false
                        },
                        secondaryButton: .destructive(Text("Missed")) {
                            selectedMedicine?.isCompleted = false
                            

                            showModal = false
                        }
                    )

            }
//            .onTapGesture {
//
//                               showModal = false
//                           }
        }
    }
    
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}
