//
//  IGNNews.swift
//  JanAssaignment
//
//  Created by Oniel Rosario on 12/17/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import Foundation


struct IGN: Codable {
    let status: String
    let totalResults: Int
    struct Article: Codable {
        struct Source: Codable {
            let id: String
            let name: String
        }
        let source: Source
        let author: String?
        let title: String
        let description: String
        let url: String
        let urlToImage: String
        let publishedAt: String
    }
    let articles: [Article]
}
