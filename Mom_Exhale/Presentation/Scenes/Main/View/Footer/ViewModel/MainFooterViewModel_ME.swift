//
//  MainFooterViewModel_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

import MommysEye


protocol MainFooterViewModelProtocol_ME: AnyObject {
    var blogArticles: Publisher<[BlogArticle_ME]> { get }
    var isLoading: Publisher<Bool> { get }
    func loadInitialState()
}



final class MainFooterViewModel_ME: MainFooterViewModelProtocol_ME {

        // MARK: - Dependencies

    private let repository: BlogArticleGateway_ME
    
    
    // MARK: - Init

    init(repository: BlogArticleGateway_ME) {
        self.repository = repository
    }
    
    
    // MARK: - State

    var blogArticles = Publisher(value: [BlogArticle_ME]())
    var isLoading = Publisher(value: false)
    
    
    // MARK: - Interface

    func loadInitialState() {
        guard blogArticles.value.isEmpty else { return }
        print("blogArticles is loading")
        isLoading.value = true
        let _ = Task {
            do {
                let result = try await self.repository.fetch()
                blogArticles.value = result
            } catch let domainError {
                print(domainError)
            }
            self.isLoading.value = false
        }
    }
    
    
}
