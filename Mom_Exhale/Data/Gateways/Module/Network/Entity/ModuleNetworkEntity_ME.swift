//
//  ModuleNetworkEntity_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation
import UIKit


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
    let imageData: String
    let titleColor: String
    
    
    enum CodingKeys: CodingKey {
        case id
        case created_at
        case keyName
        case title
        case image
        case titleColor
    }
    
    
    //MARK: - Decodable

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(UUID.self, forKey: .id)
            self.keyName = try container.decode(String.self, forKey: .keyName)
            self.title = try container.decode(String.self, forKey: .title)
            self.imageData = try container.decode(String.self, forKey: .image)
            self.titleColor = try container.decode(String.self, forKey: .titleColor)
        } catch let error {
            throw ModuleNetworkEntityError_CN.parseFromDecoder(error)
        }
    }
    
    
    //MARK: - DomainConvertable
    
    func parseToDomain() throws -> Module_ME {
        guard let keyName = Module_ME.KeyName(rawValue: self.keyName),
              let imageData = Data(base64Encoded: self.imageData),
              let image = UIImage(data: imageData),
              let color = TitleColor_ME(rawValue: self.titleColor) else {
            throw ModuleNetworkEntityError_CN.parseToDomain("")
        }
        return .init(id: self.id,
                     keyName: keyName,
                     title: self.title,
                     image: image,
                     titleColor: color)
    }
}
