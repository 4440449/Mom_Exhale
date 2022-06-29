//
//  ModuleRepository_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//

import Foundation


final class ModuleRepository_ME: ModuleGatewayProtocol {
    
    func fetch() async throws -> [Module] {
        let modules = [Module(id: UUID(),
                              keyName: .BLW,
                              title: "Самоприкорм"),
                       Module(id: UUID(),
                              keyName: .calmingNotifications,
                              title: "Успокаивающие уведомления"),
                       Module(id: UUID(),
                              keyName: .babyTracker,
                              title: "Трекер сна")]
        return modules
    }
    
}
