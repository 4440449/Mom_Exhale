//
//  MainHeaderConfigurator_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//



protocol MainHeaderConfiguratorProtocol_ME {
    func configure(_ header: MainCollectionHeaderCellView_ME)
}


final class MainHeaderConfigurator_ME: MainHeaderConfiguratorProtocol_ME {
    
    // MARK: - Dependencies

    private let headerViewModel: MainHeaderViewModelProtocol_ME
    
    
    // MARK: - Init

    init(headerViewModel: MainHeaderViewModelProtocol_ME) {
        self.headerViewModel = headerViewModel
    }
    
    
    // MARK: - Interface

    func configure(_ header: MainCollectionHeaderCellView_ME) {
        header.setupViewModel(headerViewModel)
    }
}
