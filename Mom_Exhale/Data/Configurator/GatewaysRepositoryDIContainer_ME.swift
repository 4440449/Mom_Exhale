//
//  RepositoryDIContainer_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation
import BabyNet


protocol GatewaysRepositoryDIContainerProtocol_ME {
    var module: ModuleGateway_ME { get }
    var banner: BannerGateway_ME { get }
}


final class GatewaysRepositoryDIContainer_ME: GatewaysRepositoryDIContainerProtocol_ME {

    
    // MARK: - Dependencies / Interface

    let module: ModuleGateway_ME
    let banner: BannerGateway_ME
    
    
    // MARK: - External injection

    init(module: ModuleGateway_ME = createModuleRepository(),
         banner: BannerGateway_ME = createBannerRepository()) {
        self.module = module
        self.banner = banner
    }
    
    
    // MARK: - Default internal injection

    static func createModuleRepository() -> ModuleGateway_ME {
        let client = BabyNetRepository()
        let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydXZtZ3V1YWRyaWt4amdscml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTQ3ODgyMzgsImV4cCI6MTk3MDM2NDIzOH0.udc8nAU84lOWCgJChCCq815w0oBoXh6zrceObzg8Z1Q"
        let network = ModuleNetworkRepository_ME(client: client,
                                                 apiKey: apiKey)
        let repository = ModuleRepository_ME(network: network)
        return repository
    }
    
    static func createBannerRepository() -> BannerGateway_ME {
        let client = BabyNetRepository()
        let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydXZtZ3V1YWRyaWt4amdscml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTQ3ODgyMzgsImV4cCI6MTk3MDM2NDIzOH0.udc8nAU84lOWCgJChCCq815w0oBoXh6zrceObzg8Z1Q"
        let network = BannerNetworkRepository_ME(client: client,
                                                 apiKey: apiKey)
        let repository = BannerRepository_ME(network: network)
        return repository
    }
    
}
