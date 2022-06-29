//
//  Module_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import Foundation


import Foundation


struct Module {
    let id: UUID
    let keyName: KeyName
    let title: String
    
    enum KeyName: String {
        case BLW = "Самоприкорм"
        case calmingNotifications = "CalmingNotifications"
        case babyTracker = "BabyTrackerWW"
    }
}
