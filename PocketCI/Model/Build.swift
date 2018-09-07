//
//  Build.swift
//  PocketCI
//
//  Created by Matt  North on 9/5/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import Foundation

struct Build : Codable {    
    let buildNum : Int?
    let outcome : String?
    let pushedAt : String?
    let vcsRevision : String?
    
    enum CodingKeys: String, CodingKey {
        case buildNum = "build_num"
        case outcome = "outcome"
        case pushedAt = "pushed_at"
        case vcsRevision = "vcs_revision"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        buildNum = try values.decodeIfPresent(Int.self, forKey: .buildNum)
        outcome = try values.decodeIfPresent(String.self, forKey: .outcome)
        pushedAt = try values.decodeIfPresent(String.self, forKey: .pushedAt)
        vcsRevision = try values.decodeIfPresent(String.self, forKey: .vcsRevision)
    }
}
