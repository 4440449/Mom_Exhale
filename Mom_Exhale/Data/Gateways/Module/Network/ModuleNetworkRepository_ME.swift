//
//  ModuleNetworkRepository_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 30.06.2022.
//

import Foundation
import BabyNet


protocol ModuleNetworkRepositoryProtocol_ME {
    func fetch(responseCallback: @escaping (Result<[ModuleNetworkEntity_ME], Error>) -> ()) -> URLSessionTask?
}


final class ModuleNetworkRepository_ME: ModuleNetworkRepositoryProtocol_ME {
    
    
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

    func fetch(responseCallback: @escaping (Result<[ModuleNetworkEntity_ME], Error>) -> ()) -> URLSessionTask? {
        let url = BabyNetURL(scheme: .https,
                             host: "sruvmguuadrikxjglriw.supabase.co",
                             path: "/rest/v1/Modules",
                             endPoint: nil)
        let request = BabyNetRequest(method: .get,
                                     header: ["apiKey" : apiKey],
                                     body: nil)
        let session = BabyNetSession.default
        let decoderType = [ModuleNetworkEntity_ME].self
        return client.connect(url: url,
                              request: request,
                              session: session,
                              decoderType: decoderType,
                              observationCallback: nil,
                              taskProgressCallback: nil,
                              responseCallback: responseCallback)
    }
    
}

//https://sruvmguuadrikxjglriw.supabase.co/rest/v1/Modules
