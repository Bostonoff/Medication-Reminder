//
//  ShowTimeView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct ShowTimeView: View {
    @Binding var selectedTime: Date
    @Binding var editingIndex: Int?
    @Binding var isPastDate: Bool
    @Binding var durationList: [(startDate: Date, endDate: Date)]
    @Binding var showTimePicker: Bool
    
    var body: some View {
        VStack {
            Text("Select Time")
                .font(.headline)
                .padding()
            
            DatePicker("Select Date and Time", selection: $selectedTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            Text(isPastDate ? "Please select a future date/time." : "")
                .foregroundColor(.red)
                .padding(.top, 5)
            
            Button("Save Time") {
                if selectedTime > Date() {
                    if let index = editingIndex {
                        durationList[index].endDate = selectedTime
                    } else {
                        // For new duration
                        durationList.append((startDate: Date(), endDate: selectedTime))
                    }
                    showTimePicker.toggle()
                } else {
                    isPastDate = true
                }
            }.foregroundColor(Color("button"))
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
}


#Preview {
    ShowTimeView(selectedTime: .constant(Date()), editingIndex: .constant(nil), isPastDate: .constant(true), durationList: .constant([(Date(), Date())]), showTimePicker: .constant(true))
}
