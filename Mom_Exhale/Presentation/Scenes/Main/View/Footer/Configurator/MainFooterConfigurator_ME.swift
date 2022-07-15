//
//  MainFooterConfigurator_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

protocol MainFooterConfiguratorProtocol_ME {
    func configure(_ footer: MainCollectionFooterCellView_ME)
}


final class MainFooterConfigurator_ME: MainFooterConfiguratorProtocol_ME {
    
    // MARK: - Dependencies

    private let footerViewModel: MainFooterViewModelProtocol_ME
    
    // MARK: - Init

    init(footerViewModel: MainFooterViewModelProtocol_ME) {
        self.footerViewModel = footerViewModel
    }
    
    
    // MARK: - Interface

    func configure(_ footer: MainCollectionFooterCellView_ME) {
        footer.setupViewModel(footerViewModel)
    }
}
