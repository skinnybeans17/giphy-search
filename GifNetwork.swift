//
//  GifNetwork.swift
//  GiphySearchIOS
//
//  Created by mo aabas on 4/27/23.
//

import Foundation
class GifNetwork {
    let apiKey = "Wh23cW6jy8sq1wp6CF1ywuiYrC3z2BEN"
    /**
     Fetches gifs from the Giphy api
    -Parameter searchTerm: What we should query gifs of.
    */
    func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {
        // Create a GET url request
        let url = urlBuilder(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                // Decode the data into array of Gifs
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
        }.resume()
    }
    func urlBuilder(searchTerm: String) -> URL {
            let apikey = apiKey
            var components = URLComponents()
               components.scheme = "https"
               components.host = "api.giphy.com"
               components.path = "/v1/gifs/search"
               components.queryItems = [
                   URLQueryItem(name: "api_key", value: apikey),
                   URLQueryItem(name: "q", value: searchTerm),
                   URLQueryItem(name: "limit", value: "3") // Edit limit to display more gifs
               ]
            return components.url!
        }
}
