//
//  ModuleRepository_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//

import Foundation


final class ModuleRepository_ME: ModuleGateway_ME {
    
    // MARK: - Dependencies
    
    let network: ModuleNetworkRepositoryProtocol_ME
    
    
    // MARK: - Init
    
    init(network: ModuleNetworkRepositoryProtocol_ME) {
        self.network = network
    }
    
    
    // MARK: - Interface
    
    func fetch() async throws -> [Module_ME] {
        let networkEntity = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[ModuleNetworkEntity_ME], Error>) -> Void in
            let _ = self.network.fetch { result in
                switch result {
                case let .success(networkEntity):
                    continuation.resume(returning: networkEntity)
                case let .failure(networkError):
                    continuation.resume(throwing: networkError)
                }
            }
            sleep(2)
        }
        do {
            let domain = try networkEntity.map { try $0.parseToDomain() }
            return domain
        } catch let dataError {
            throw dataError
        }
    }
    
}
