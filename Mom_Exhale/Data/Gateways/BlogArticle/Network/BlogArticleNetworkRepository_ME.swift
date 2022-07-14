//
//  BlogArticleNetworkRepository_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

import Foundation
import BabyNet


protocol BlogArticleNetworkRepositoryProtocol_ME {
    func fetch(responseCallback: @escaping (Result<[BlogArticleNetworkEntity_ME], Error>) -> ()) -> URLSessionTask?
}

final class BlogArticleNetworkRepository_ME: BlogArticleNetworkRepositoryProtocol_ME {
    
    // MARK: - Dependencies

    private let client: BabyNetRepositoryProtocol
    private let apiKey: String
    
    
    // MARK: - Init

    init(client: BabyNetRepositoryProtocol,
         apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    
    // MARK: - Interface

    func fetch(responseCallback: @escaping (Result<[BlogArticleNetworkEntity_ME], Error>) -> ()) -> URLSessionTask? {
        let url = BabyNetURL(scheme: .https,
                             host: "sruvmguuadrikxjglriw.supabase.co",
                             path: "/rest/v1/BlogArticles",
                             endPoint: nil)
        let request = BabyNetRequest(method: .get,
                                     header: ["apiKey" : apiKey],
                                     body: nil)
        let session = BabyNetSession.default
        let decoderType = [BlogArticleNetworkEntity_ME].self
        return client.connect(url: url,
                              request: request,
                              session: session,
                              decoderType: decoderType,
                              observationCallback: nil,
                              taskProgressCallback: nil,
                              responseCallback: responseCallback)
    }
}
