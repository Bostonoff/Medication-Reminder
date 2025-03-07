//
//  FrequencyView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct FrequencyView: View {
    private let action: () -> Void
    private let option: String
    
    init(action: @escaping () -> Void, option: String) {
        self.action = action
        self.option = option
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing:5) {
                Text(option)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(getFrequencyDescription(for: option))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
        }
        .padding(5)
    }
    
    private func getFrequencyDescription(for option: String) -> String {
        switch option {
        case "Every Day":
            return "Take your medication every day at the same time."
        case "Cyclically":
            return "Take every day for 21 days and pause for 7 days."
        case "Specific Days of the Week":
            return "Take it at 11:00 AM on selected days."
        case "Every Few Days":
            return "Take it every other day or every 3 days."
        default:
            return ""
        }
    }
    
}


#Preview {
    FrequencyView(action: {}, option: "Every Day")
}
