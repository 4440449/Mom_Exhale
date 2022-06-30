//
//  MainViewModel_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import MommysEye


protocol MainViewModelProtocol_ME {
    var modules: Publisher<[Module_ME]> { get }
    func loadInitialState()
    func didSelectItem(index: Int)
}



final class MainViewModel_ME: MainViewModelProtocol_ME {
    
    private let repository: ModuleGateway_ME
    private let router: MainRouterProtocol_ME
    
    init(repository: ModuleGateway_ME,
         router: MainRouterProtocol_ME) {
        self.repository = repository
        self.router = router
    }
    
    
    var modules = Publisher(value: [Module_ME]())
    
    func loadInitialState() {
        let _ = Task {
            do {
                let result = try await self.repository.fetch()
                modules.value = result
            } catch let domainError {
                print(domainError)
            }
            
        }
    }
    
    func didSelectItem(index: Int) {
        let key = modules.value[index].keyName
        router.showModule(by: key)
    }
    
    
}
