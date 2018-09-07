//
//  APIService.swift
//  PocketCI
//
//  Created by Matt  North on 9/6/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import Foundation
import BoneKit
import PromiseKit

struct APIRequest {
    var url: URL
    var headers: [String: String]?
    var method: WebClient.HTTPMethod
}

struct EncodableAPIRequest<T: Encodable> {
    var url: URL
    var headers: [String: String]?
    var requestBody: T
    var method: WebClient.HTTPMethod
}

class WebService {
    enum ErrorType: Error {
        case invalidURL
        case invalidResponse
        case apiError(message: String?)
    }
    
    private var webClient: WebClient
    private var requestAuthenticator: RequestAuthenticatorProtocol
    
    required init(webClient: WebClient, requestAuthenticator: RequestAuthenticatorProtocol) {
        self.webClient = webClient
        self.requestAuthenticator = requestAuthenticator
    }
    
    func sendRequest<T>(_ request: APIRequest) -> Promise<T> where T : Decodable {
        var authenticatedRequest = requestAuthenticator.authenticateRequest(request)
        
        authenticatedRequest.headers?["Accept"] = "application/json"
        authenticatedRequest.headers?["Content-Type"] = "application/json"
        
        return validate(webClient.request(authenticatedRequest.url,
                                          headers: authenticatedRequest.headers,
                                          method: authenticatedRequest.method))
    }
    
    func sendEncodableRequest<T: Decodable, U>(_ request: EncodableAPIRequest<U>) -> Promise<T> {
        var authenticatedRequest = requestAuthenticator.authenticateRequest(request)
        
        authenticatedRequest.headers?["Accept"] = "application/json"
        authenticatedRequest.headers?["Content-Type"] = "application/json"
        
        return validate(webClient.request(authenticatedRequest.url,
                                          headers: authenticatedRequest.headers,
                                          requestBody: request.requestBody,
                                          method: authenticatedRequest.method))
    }
    
    private func validate<T>(_ requestPromise: Promise<T>) -> Promise<T> {
        return Promise { fulfill, reject in
            requestPromise.then { apiResponse -> Void in
                fulfill(apiResponse)
            }.catch { error in
                let standardError = error as NSError
                if !standardError.localizedDescription.isEmpty {
                    reject(ErrorType.apiError(message: standardError.localizedDescription))
                } else {
                    reject(ErrorType.apiError(message: "An unknown error occured."))
                }
            }
        }
    }
}
