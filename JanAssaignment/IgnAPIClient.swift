//
//  IgnAPIClient.swift
//  JanAssaignment
//
//  Created by Oniel Rosario on 12/17/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import UIKit

enum ErrorHandler {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
}

final class IgnAPIClient {
    static func getArticles(completionHandler: @escaping(([IGN.Article]?, ErrorHandler?) -> Void)) {
        let urlString = "https://newsapi.org/v2/top-headlines?sources=ign&apiKey=\(SecretKeys.APIKey)"
        guard let url = URL.init(string: urlString) else { return completionHandler(nil, .badURL("bad URL"))  }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            } else if let data = data {
                do {
                    let ign = try JSONDecoder().decode(IGN.self, from: data)
                    completionHandler(ign.articles, nil)
                 
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
    static func getImage(url: String) -> UIImage? {
        guard let imageUrl = URL.init(string: url) else { return nil }
        guard let data = try? Data.init(contentsOf: imageUrl) else {return nil }
        let image = UIImage.init(data: data)
        return image
    }
}
