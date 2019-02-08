//
//  MovieController.swift
//  MovieSearch
//
//  Created by Dominic Lanzillotta on 2/8/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation

class MovieController {
    //MARK: - BaseURl
    static var baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    //MARK: - Read Movie
    static func fetchMovieWith(name: String, completion: @escaping ([Movie]) -> Void) {
        guard let url = baseURL  else {
            print("Could not unwrapp BaseURl")
            completion([])
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiItem = URLQueryItem(name: "api_key", value: "4cf49922d5bd705f748eac021c458ccd")
        let queryItem = URLQueryItem(name: "query", value: name.lowercased())
        components?.queryItems = [apiItem,queryItem]
        
        guard let fullURl = components?.url else {
            print("Could not create fullURL")
            completion([])
            return
        }
        print("QueryURL: \(fullURl)")
        
        let dataTask = URLSession.shared.dataTask(with: fullURl) { (data, urlResponse, error) in
            if let error = error {
                print("An error in function \(#function) has occured: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let response = urlResponse else {
                print("Could not unwrap urlResponse")
                completion([])
                return
            }
            print("urlResonse: \(response)")
            
            guard let data = data else {
                print("Could not unwrap data")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([String:[Movie]].self, from: data)
                completion(movies["results"] ?? [])
            } catch {
                print("Could not decode movieJSON")
                completion([])
            }
        }
        dataTask.resume()
    }
}
