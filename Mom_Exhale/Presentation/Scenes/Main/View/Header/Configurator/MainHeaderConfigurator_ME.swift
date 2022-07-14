//
//  MainHeaderConfigurator_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//



protocol MainHeaderConfiguratorProtocol_ME {
    func configure(_ header: MainCollectionHeaderReusableView_ME)
}


final class MainHeaderConfigurator_ME: MainHeaderConfiguratorProtocol_ME {
    
    // MARK: - Dependencies

//    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    private let headerViewModel: MainHeaderViewModelProtocol_ME
    
    
    // MARK: - Init

    init(headerViewModel: MainHeaderViewModelProtocol_ME
//        repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    ) {
//        self.repositoryDIContainer = repositoryDIContainer
        self.headerViewModel = headerViewModel
    }
    
    
    // MARK: - Interface

    func configure(_ header: MainCollectionHeaderReusableView_ME) {
//        let basicArticleRepository = repositoryDIContainer.basicArticle
//        let viewModel = MainHeaderViewModel_ME(repository: basicArticleRepository)
        header.setupViewModel(headerViewModel)
    }
}
