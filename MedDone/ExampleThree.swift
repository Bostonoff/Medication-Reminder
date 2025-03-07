////
////  ExampleThree.swift
////  MediMind
////
////  Created by Mukhammad Bustonov on 03/03/25.
////
//
//import SwiftUI
//
//struct Med: Identifiable {
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
//struct MedDetailsPage: View {
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
//    MedDetailsPage(medication: Medication(
//            name: "Aspirin",
//            description: "Pain reliever",
//            doseAmount: "500 mg",
//            frequency: "Every Day",
//            time: Date(),
//            durationList: [(startDate: Date(), endDate: Date().addingTimeInterval(3600))], // Example duration
//            type: "pill"
//        ))
//}
