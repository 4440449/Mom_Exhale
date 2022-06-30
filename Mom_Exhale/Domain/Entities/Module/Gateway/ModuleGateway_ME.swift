//
//  ModuleGateway_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//


protocol ModuleGateway_ME {
    
    func fetch() async throws -> [Module_ME]
}
