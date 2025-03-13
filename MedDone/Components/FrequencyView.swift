//
//  FrequencyView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct FrequencyView: View {
    private let action: () -> Void
    private let option: FrequencyType
    
    init(action: @escaping () -> Void, option: FrequencyType) {
        self.action = action
        self.option = option
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing:5) {
                Text(option.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(option.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
        }
        .padding(5)
    }
    
}


#Preview {
    FrequencyView(action: {}, option: .cyclically)
}
