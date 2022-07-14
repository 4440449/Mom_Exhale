//
//  MainHeaderViewModel_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import MommysEye


protocol MainHeaderViewModelProtocol_ME: AnyObject {
    var basicArticles: Publisher<[BasicArticle_ME]> { get }
    var isLoading: Publisher<Bool> { get }
    func loadInitialState()
}



final class MainHeaderViewModel_ME: MainHeaderViewModelProtocol_ME {
    
    // MARK: - Dependencies
    
    private let repository: BasicArticleGateway_ME
    
    
    // MARK: - Init
    
    init(repository: BasicArticleGateway_ME) {
        self.repository = repository
    }
    
    
    // MARK: - State
    
    var basicArticles = Publisher(value: [BasicArticle_ME]())
    var isLoading = Publisher(value: false)
    
    
    // MARK: - Interface
    
    func loadInitialState() {
        guard basicArticles.value.isEmpty else { return }
        print("basicArticles is loading")
        isLoading.value = true
        let _ = Task {
            do {
                let result = try await self.repository.fetch()
                basicArticles.value = result
            } catch let domainError {
                print(domainError)
            }
            self.isLoading.value = false
        }
    }
    
    
}
