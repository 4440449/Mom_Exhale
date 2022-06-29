//
//  GatewaysRepositoryDIContainer_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//



final class GatewaysRepositoryDIContainer_ME {
    
    static func createModuleRepository() -> ModuleGatewayProtocol {
        let repository = ModuleRepository_ME()
        return repository
    }
    
//    static func configureBannerRepository() -> BannerGatewayProtocol {
//
//    }
}
