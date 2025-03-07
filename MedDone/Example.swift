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
//            case "Evening":
//                return medications.filter { isEvening(time: $0.time) }
            case "Night":
                return medications.filter { isNight(time: $0.time) }
            default:
                return medications
            }
        }
    
    // Helper methods to categorize the time
        private func isMorning(time: String) -> Bool {
            return isTimeInRange(time: time, start: "04:00", end: "12:00")
        }
        
        private func isAfternoon(time: String) -> Bool {
            return isTimeInRange(time: time, start: "12:00", end: "18:00")
        }
        
//        private func isEvening(time: String) -> Bool {
//            return isTimeInRange(time: time, start: "18:00", end: "23:00")
//        }
        
        private func isNight(time: String) -> Bool {
            return isTimeInRange(time: time, start: "18:00", end: "04:00", isNight: true)
        }

    // Helper methods to categorize the time
    private func isTimeInRange(time: String, start: String, end: String, isNight: Bool = false) -> Bool {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "HH:mm"
          
          guard let timeDate = dateFormatter.date(from: time),
                let startDate = dateFormatter.date(from: start),
                let endDate = dateFormatter.date(from: end) else {
              return false
          }
          
          // For night
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
                        .padding(.leading, 5)
                        
                    
                    Spacer()
                    
                    NavigationLink(destination: CalendarPage()) {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("button"))
                            .font(.title2)
                            .padding(.trailing, 5)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
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
                    
                    // Update progress color directly within the ProgressView
                    ProgressView(value: completionPercentage, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 20)
                        .foregroundColor(completionPercentage == 1.0 ? .green : (completionPercentage > 0.13 ? Color("button") : .red))
                    
                    Text("\(Int(completionPercentage * 100))% Completed")
                        .font(.subheadline)
                        .foregroundColor(completionPercentage == 1.0 ? .green : (completionPercentage > 0.13 ? Color("button") : .red))
                }
                .padding()
//                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Text("Today's medications")
                    .font(.title3)
                    .bold()
                    .padding(.top)
                
                Picker("", selection: $selectedTime) {
                    ForEach(timeOptions, id: \.self) { time in
                        Text(time).tag(time)
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
                                        selectedMedicationIndex = medications.firstIndex { $0.id == filteredMedications[index].id };                                showModal = true
                                    }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 2)
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
            .padding()
            .overlay(
                // Модальное окно
                Group {
                    if showModal {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showModal = false
                            }
                        
                        VStack(spacing: 2) {
                            
                            Image(systemName: "checkmark.seal.fill").foregroundColor(Color("button")) .font(.system(size: 30))
                            Text("Are you sure?")
                                .font(.title)
                                .bold()
                                .padding()
                            Text("Are you sure you want to mark 13:00 tablets?")
                                .font(.footnote)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                Button("Taken") {
                                    if let index = selectedMedicationIndex {
                                        medications[index].isCompleted = true
                                        medications [index].color = .green
                                    }
                                    showModal = false
                                }
                                .frame(width: 80, height: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                                Button("Missed") {
                                    if let index = selectedMedicationIndex {
                                        medications[index].isCompleted = false
                                        medications[index].color = .red
                                    }
                                    showModal = false
                                }
                                .frame(width: 80, height: 40)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }.padding()
                        }
                        .frame(width: 250, height: 250)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        
                    }
                    
                }
            )
        }
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}
