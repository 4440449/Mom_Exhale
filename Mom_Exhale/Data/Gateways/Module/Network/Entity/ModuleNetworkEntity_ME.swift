//
//  ModuleNetworkEntity_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation


// Error
enum ModuleNetworkEntityError_CN: Error {
    case parseToDomain(String)
    case parseFromDecoder(Error)
}

//TODO: локализовать протокол под каждый проект?
protocol DomainConvertable {
    associatedtype DomainEntity
    func parseToDomain() throws -> DomainEntity
}


struct ModuleNetworkEntity_ME: Decodable, DomainConvertable {
    
    let id: UUID
    let keyName: String
    let title: String
    
    
    enum CodingKeys: CodingKey {
        case id
        case created_at
        case keyName
        case title
    }
    
    
    //MARK: - Decodable

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(UUID.self, forKey: .id)
            self.keyName = try container.decode(String.self, forKey: .keyName)
            self.title = try container.decode(String.self, forKey: .title)
        } catch let error {
            throw ModuleNetworkEntityError_CN.parseFromDecoder(error)
        }
    }
    
    
    //MARK: - DomainConvertable
    
    func parseToDomain() throws -> Module_ME {
        guard let keyName = Module_ME.KeyName(rawValue: self.keyName) else {
            throw ModuleNetworkEntityError_CN.parseToDomain("")
        }
        return .init(id: self.id,
                     keyName: keyName,
                     title: self.title)
    }
}
