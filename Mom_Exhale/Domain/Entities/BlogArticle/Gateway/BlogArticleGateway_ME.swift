//
//  BlogArticleGateway_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//


protocol BlogArticleGateway_ME {
    
    func fetch() async throws -> [BlogArticle_ME]
}
