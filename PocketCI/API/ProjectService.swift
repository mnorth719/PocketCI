//
//  ProjectService.swift
//  PocketCI
//
//  Created by Matt  North on 9/6/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import Foundation
import PromiseKit

class ProjectService: WebService {
    func getProjects() -> Promise<[Project]> {
        let urlString = APIConstants.baseURL + "projects"
        guard let url = URL(string: urlString) else {
            return Promise(error: WebService.ErrorType.invalidURL)
        }
        
        let request = APIRequest(url: url, headers: nil, method: .GET)
        return sendRequest(request)
    }
}
