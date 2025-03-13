//
//  SwiftModel.swift
//  MedDone
//
//  Created by Mukhammad Bustonov on 11/03/25.
//

import SwiftData
import SwiftUI

@Model
class Medicationas {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var desc: String
    var medicineType: MedicineType
    var frequencyType: FrequencyType
    var isCompleted: Bool?
    var selectedTime: Date
    var doseType: String?
    
    init(
        id: UUID = UUID(),
        name: String,
        desc: String,
        medicineType: MedicineType,
        frequencyType: FrequencyType,
        isCompleted: Bool? = nil,
        selectedTime: Date,
        doseType: String? = nil
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.medicineType = medicineType
        self.frequencyType = frequencyType
        self.isCompleted = isCompleted
        self.selectedTime = selectedTime
        self.doseType = doseType
    }
    
    var doseAmount: String {
        if let doseType {
            return "\(desc) \(doseType)"
        } else {
            return desc
        }
    }
    
}

enum MedicineType: CaseIterable, Codable {
    case capsule, tablet, liquid
    
    var title: String {
        switch self {
        case .capsule:
            "capsule"
        case .tablet:
            "tablets"
        case .liquid:
            "liquid"
        }
    }
}

enum FrequencyType: CaseIterable, Codable {
    case everyDay, cyclically, specific, fewDays, asNeeded
    
    var title: String {
        switch self {
        case .everyDay:
            "Every Day"
        case .cyclically:
            "Cyclically"
        case .specific:
            "Specific Days of the Week"
        case .fewDays:
            "Every Few Days"
        case .asNeeded:
            "As Needed"
        }
    }
    
    var description: String {
        switch self {
        case .everyDay:
            "Take your medication every day at the same time."
        case .cyclically:
            "Take every day for 21 days and pause for 7 days."
        case .specific:
            "Take it at 11:00 AM on selected days."
        case .fewDays:
            "Take it every other day or every 3 days."
        case .asNeeded:
            ""
        }
    }
    
}
