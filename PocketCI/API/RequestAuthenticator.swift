//
//  RequestAuthenticator.swift
//  PocketCI
//
//  Created by Matt  North on 9/6/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import Foundation

protocol RequestAuthenticatorProtocol {
    func authenticateRequest(_ request: APIRequest) -> APIRequest
    func authenticateRequest<T>(_ request: EncodableAPIRequest<T>) -> EncodableAPIRequest<T>
}

struct RequestAuthenticator: RequestAuthenticatorProtocol {
    enum Constants {
        static let AuthKey = "circle-token"
    }
    
    func authenticateRequest(_ request: APIRequest) -> APIRequest {
        let tokenItem = URLQueryItem(name: Constants.AuthKey, value: APIConstants.apiKey)
        var newURL: URL?
        let queryComponent = "\(tokenItem.name)=\(tokenItem.value!)"
        let queryToken = request.url.query == nil ? "?" : ""
        let urlString = request.url.absoluteString.appending(queryToken + queryComponent)
        newURL = URL(string: urlString)
        return APIRequest(url: newURL ?? request.url,
                          headers: request.headers,
                          method: request.method)
    }
    
    func authenticateRequest<T>(_ request: EncodableAPIRequest<T>) -> EncodableAPIRequest<T> {
        let tokenItem = URLQueryItem(name: Constants.AuthKey, value: APIConstants.apiKey)
        var newURL: URL?
        let queryComponent = "\(tokenItem.name)=\(tokenItem.value!)"
        let queryToken = request.url.query == nil ? "?" : ""
        let urlString = request.url.absoluteString.appending(queryToken + queryComponent)
        newURL = URL(string: urlString)
        return EncodableAPIRequest(url: newURL ?? request.url,
                                   headers: request.headers,
                                   requestBody: request.requestBody,
                                   method: request.method)
    }
}
