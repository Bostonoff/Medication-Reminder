//
//  FrequencyListView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct FrequencyListView: View {
    private let frequencyOptions = [
        "Every Day",
        "Cyclically",
        "Specific Days of the Week",
        "Every Few Days",
        "As Needed"
    ]
    
    @Binding var selectedFrequency: String
    @Binding var showFrequencyModal: Bool
    
    var body: some View {
        VStack {
            Text("When will you take this?")
                .font(.headline)
                .padding()
            
            List(frequencyOptions, id: \.self) { option in
                FrequencyView(
                    action: {
                        selectedFrequency = option
                        showFrequencyModal.toggle()
                    },
                    option: option
                )
            }   .background(.red)
            
                .listStyle(.insetGrouped)
            
                .background(.red)
            
            
            //            Spacer()
        }
        //        .padding()
        //        .edgesIgnoringSafeArea(.all)
        //        .background(Color("backColor"))
        
    }
}

#Preview {
    FrequencyListView(
        selectedFrequency: .constant(
            "Every Day"
        ),
        showFrequencyModal: .constant(
            true
        )
    )
}
