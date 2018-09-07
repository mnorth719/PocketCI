//
//  Project.swift
//  PocketCI
//
//  Created by Matt  North on 9/5/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import Foundation

struct Project: Codable {
    let followed: Bool?
    let reponame: String?
    let username: String?
    let vcsUrl: String?
    var branches: [String: BranchSummary]?
    
    enum CodingKeys: String, CodingKey {
        case followed
        case reponame
        case username
        case vcsUrl = "vcs_url"
        case branches
    }
}

struct BranchSummary: Codable {
    let lastNonSuccess: Build?
    let lastSuccess: Build?
    let pusherLogins: [String]?
    let recentBuilds: [Build]?
    
    enum CodingKeys: String, CodingKey {
        case lastNonSuccess = "last_non_success"
        case lastSuccess = "last_success"
        case pusherLogins = "pusher_logins"
        case recentBuilds = "recent_builds"
    }
}
