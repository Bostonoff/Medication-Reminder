//
//  TrashButtonView.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct TrashButtonView : View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "trash")
                .foregroundColor(.red)
                .padding()
        }
    }
    
}

#Preview {
    TrashButtonView(action: {})
}
