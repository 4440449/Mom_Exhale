//
//  BannerRepository_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation


final class BannerRepository_ME: BannerGateway_ME {
    
    // MARK: - Dependencies
    
    let network: BannerNetworkRepositoryProtocol_ME
    
    
    // MARK: - Init
    
    init(network: BannerNetworkRepositoryProtocol_ME) {
        self.network = network
    }
    
    
    // MARK: - Interface
    
    func fetch() async throws -> [Banner_ME] {
        let networkEntity = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[BannerNetworkEntity_ME], Error>) -> Void in
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
