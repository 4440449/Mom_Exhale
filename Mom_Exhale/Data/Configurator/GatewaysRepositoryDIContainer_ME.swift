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
    var basicArticle: BasicArticleGateway_ME { get }
    var blogArticle: BlogArticleGateway_ME { get }
}


final class GatewaysRepositoryDIContainer_ME: GatewaysRepositoryDIContainerProtocol_ME {
    
    
    // MARK: - Dependencies / Interface
    
    let module: ModuleGateway_ME
    let basicArticle: BasicArticleGateway_ME
    let blogArticle: BlogArticleGateway_ME
    
    
    // MARK: - External injection
    
    init(module: ModuleGateway_ME = createModuleRepository(),
         basicArticle: BasicArticleGateway_ME = createBasicArticleRepository(),
         blogArticle: BlogArticleGateway_ME = createBlogArticleRepository()) {
        self.module = module
        self.basicArticle = basicArticle
        self.blogArticle = blogArticle
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
    
    static func createBasicArticleRepository() -> BasicArticleGateway_ME {
        let client = BabyNetRepository()
        let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydXZtZ3V1YWRyaWt4amdscml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTQ3ODgyMzgsImV4cCI6MTk3MDM2NDIzOH0.udc8nAU84lOWCgJChCCq815w0oBoXh6zrceObzg8Z1Q"
        let network = BasicArticleNetworkRepository_ME(client: client,
                                                 apiKey: apiKey)
        let repository = BasicArticleRepository_ME(network: network)
        return repository
    }
    
    static func createBlogArticleRepository() -> BlogArticleGateway_ME {
        let client = BabyNetRepository()
        let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydXZtZ3V1YWRyaWt4amdscml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTQ3ODgyMzgsImV4cCI6MTk3MDM2NDIzOH0.udc8nAU84lOWCgJChCCq815w0oBoXh6zrceObzg8Z1Q"
        let network = BlogArticleNetworkRepository_ME(client: client,
                                                      apiKey: apiKey)
        let repository = BlogArticleRepository_ME(network: network)
        return repository
    }
    
}
