//
//  BasicArticleRepository_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation


final class BasicArticleRepository_ME: BasicArticleGateway_ME {
    
    // MARK: - Dependencies
    
    let network: BasicArticleNetworkRepositoryProtocol_ME
    
    
    // MARK: - Init
    
    init(network: BasicArticleNetworkRepositoryProtocol_ME) {
        self.network = network
    }
    
    
    // MARK: - Interface
    
    func fetch() async throws -> [BasicArticle_ME] {
        let networkEntity = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[BasicArticleNetworkEntity_ME], Error>) -> Void in
            let _ = self.network.fetch { result in
                switch result {
                case let .success(networkEntity):
                    continuation.resume(returning: networkEntity)
                case let .failure(networkError):
                    continuation.resume(throwing: networkError)
                }
            }
        }
        let domain = networkEntity.map { $0.parseToDomain() }
        return domain
    }
    
}
