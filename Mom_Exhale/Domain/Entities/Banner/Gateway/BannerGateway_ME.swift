//
//  BannerGateway_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//


protocol BannerGateway_ME {
    
    func fetch() async throws -> [Banner]
}
