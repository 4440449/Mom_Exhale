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

    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    
    
    // MARK: - Init

    init(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME) {
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    
    // MARK: - Interface

    func configure(_ header: MainCollectionHeaderReusableView_ME) {
        let bannerRepository = repositoryDIContainer.banner
        let viewModel = MainHeaderViewModel_ME(repository: bannerRepository)
        header.viewModel = viewModel
    }
}
