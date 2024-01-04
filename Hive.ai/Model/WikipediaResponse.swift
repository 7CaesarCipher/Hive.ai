//
//  WikipediaResponse.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
struct WikipediaResponse: Codable {
    let batchcomplete: String
    let `continue`: Continue
    let query: Query
    let limits: Limits
}

struct Continue: Codable {
    let gsroffset: Int
    let `continue`: String
}

struct Query: Codable {
    let pages: [String: Page]
}

struct Page: Codable {
    let pageid: Int
    let ns: Int
    let title: String
    let index: Int
    let thumbnail: Thumbnail?
    let pageimage: String?
    let extract: String
}

struct Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}

struct Limits: Codable {
    let pageimages: Int
    let extracts: Int
}
extension WikipediaResponse {
    var pagesDictionary: [String: Page]? {
        return self.query.pages
    }
}
