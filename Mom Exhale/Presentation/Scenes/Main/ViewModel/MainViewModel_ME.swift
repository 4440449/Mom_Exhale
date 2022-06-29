//
//  MainViewModel_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import Foundation

protocol MainViewModelProtocol_ME {
    func loadInitialState()
    var tmpModules: [Module] { get }
}



final class MainViewModel_ME: MainViewModelProtocol_ME {
    
    private let repository: ModuleGatewayProtocol
    
    init(repository: ModuleGatewayProtocol) {
        self.repository = repository
    }
    
    
    var tmpModules: [Module] = [Module(id: UUID(),
                                       keyName: .BLW,
                                       title: "Самоприкорм"),
                                Module(id: UUID(),
                                       keyName: .calmingNotifications,
                                       title: "Успокаивающие уведомления"),
                                Module(id: UUID(),
                                       keyName: .babyTracker,
                                       title: "Трекер сна")]
    
    func loadInitialState() {
        let _ = Task {
            do {
                tmpModules = try await repository.fetch()
            } catch let domainError {
                print(domainError)
            }
            
        }
    }
    
    
}
