//
//  BasicArticleGateway_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//


protocol BasicArticleGateway_ME {
    
    func fetch() async throws -> [BasicArticle_ME]
}
