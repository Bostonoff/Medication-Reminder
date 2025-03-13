//
//  FrequencyListView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct FrequencyListView: View {
    @Binding var selectedFrequency: FrequencyType
    @Binding var showFrequencyModal: Bool
    
    var body: some View {
        VStack {
            Text("When will you take this?")
                .font(.headline)
                .padding()
            
            List(FrequencyType.allCases, id: \.title) { option in
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
            .asNeeded
        ),
        showFrequencyModal: .constant(
            true
        )
    )
}
