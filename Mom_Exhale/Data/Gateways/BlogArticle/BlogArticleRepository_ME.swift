//
//  BlogArticleRepository_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

import Foundation


final class BlogArticleRepository_ME: BlogArticleGateway_ME {
    
    // MARK: - Dependencies
    
    let network: BlogArticleNetworkRepositoryProtocol_ME
    
    
    // MARK: - Init
    
    init(network: BlogArticleNetworkRepositoryProtocol_ME) {
        self.network = network
    }
    
    
    // MARK: - Interface
    
    func fetch() async throws -> [BlogArticle_ME] {
        let networkEntity = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[BlogArticleNetworkEntity_ME], Error>) -> Void in
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
