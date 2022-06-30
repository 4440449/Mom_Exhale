//
//  BannerNetworkEntity_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation


// Error
enum BannerNetworkEntityError_CN: Error {
    case parseToDomain(String)
    case parseFromDecoder(Error)
}

struct BannerNetworkEntity_ME: Decodable, DomainConvertable {
    
    let id: UUID
    let title: String
    let article: String
    
    
    enum CodingKeys: CodingKey {
        case id
        case created_at
        case title
        case article
    }

    
    //MARK: - Decodable

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(UUID.self, forKey: .id)
            self.title = try container.decode(String.self, forKey: .title)
            self.article = try container.decode(String.self, forKey: .article)
        } catch let error {
            throw BannerNetworkEntityError_CN.parseFromDecoder(error)
        }
    }
    
    
    //MARK: - DomainConvertable
    
    func parseToDomain() -> Banner_ME {
        return .init(id: self.id,
                     title: self.title,
                     article: self.article)
    }
}

