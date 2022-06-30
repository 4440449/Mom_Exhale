//
//  MainViewModel_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import MommysEye


protocol MainViewModelProtocol_ME {
    var modules: Publisher<[Module_ME]> { get }
    var isLoading: Publisher<Bool> { get }
    func loadInitialState()
    func didSelectItem(index: Int)
}


final class MainViewModel_ME: MainViewModelProtocol_ME {
    
    // MARK: - Dependencies
    
    private let repository: ModuleGateway_ME
    private let router: MainRouterProtocol_ME
    
    
    // MARK: - Init
    
    init(repository: ModuleGateway_ME,
         router: MainRouterProtocol_ME) {
        self.repository = repository
        self.router = router
    }
    
    
    // MARK: - State
    
    var modules = Publisher(value: [Module_ME]())
    var isLoading = Publisher(value: false)
    
    
    // MARK: - Interface
    
    func loadInitialState() {
        isLoading.value = true
        let _ = Task {
            do {
                let result = try await self.repository.fetch()
                modules.value = result
            } catch let domainError {
                print(domainError)
            }
            self.isLoading.value = false
        }
    }
    
    func didSelectItem(index: Int) {
        let key = modules.value[index].keyName
        router.showModule(by: key)
    }
    
}
