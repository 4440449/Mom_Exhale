//
//  BannerGateway_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//


protocol BannerGatewayProtocol {
    
    func fetch() async throws -> [Banner]
}
