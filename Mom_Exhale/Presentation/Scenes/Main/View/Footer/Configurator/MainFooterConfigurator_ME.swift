//
//  MainFooterConfigurator_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

protocol MainFooterConfiguratorProtocol_ME {
    func configure(_ footer: MainCollectionFooterReusableView_ME)
}


final class MainFooterConfigurator_ME: MainFooterConfiguratorProtocol_ME {
    
    // MARK: - Dependencies

    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    
    
    // MARK: - Init

    init(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME) {
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface

    func configure(_ footer: MainCollectionFooterReusableView_ME) {
        let blogArticleRepository = repositoryDIContainer.blogArticle
        let viewModel = MainFooterViewModel_ME(repository: blogArticleRepository)
        footer.setupViewModel(viewModel)
    }
}
