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

//    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    private let footerViewModel: MainFooterViewModelProtocol_ME
    
    // MARK: - Init

    init(footerViewModel: MainFooterViewModelProtocol_ME
//        repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    ) {
        self.footerViewModel = footerViewModel
//        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface

    func configure(_ footer: MainCollectionFooterReusableView_ME) {
//        let blogArticleRepository = repositoryDIContainer.blogArticle
//        let viewModel = MainFooterViewModel_ME(repository: blogArticleRepository)
        footer.setupViewModel(footerViewModel)
    }
}
