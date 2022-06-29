//
//  MainViewModel_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import Foundation

protocol MainViewModelProtocol_ME {
    var tmpModules: [Module] { get }
    func loadInitialState()
    func didSelectItem(index: Int)
}



final class MainViewModel_ME: MainViewModelProtocol_ME {
    
    private let repository: ModuleGatewayProtocol
//    private let router:
    
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
    
    func didSelectItem(index: Int) {
        
    }
    
    
}
