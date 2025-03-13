//
//  MediMindApp.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 01/03/25.
//

import SwiftUI

@main
struct MedDone: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Medicationas.self)
    }
}
