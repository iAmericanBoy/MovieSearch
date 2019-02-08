//
//  MovieController.swift
//  MovieSearch
//
//  Created by Dominic Lanzillotta on 2/8/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class MovieController {
    //MARK: - BaseURl
    static var baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    //MARK: - ImageBaseURl
    static var imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w500")
    
    //MARK: - Fetch Movie
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
            
            guard let data = data else {
                print("Could not unwrap data")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(TopLevelJSON.self, from: data)
                completion(movies.results )
            } catch {
                print("Could not decode movieJSON")
                completion([])
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Fetch Image
    static func fetchImageFrom(movie: Movie ,completion: @escaping (UIImage?) -> Void) {
        guard let pictureURL = imageBaseURL?.appendingPathComponent(movie.posterURLAsString)  else {
            print("Could not unwrapp BaseURl")
            completion(nil)
            return
        }
        
        print("pictureURL: \(pictureURL)")
        
        let dataTask = URLSession.shared.dataTask(with: pictureURL) { (data, urlResponse, error) in
            if let error = error {
                print("An error in function \(#function) has occured: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let response = urlResponse else {
                print("Could not unwrap urlResponse")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Could not unwrap data")
                completion(nil)
                return
            }
            
            completion(UIImage(data: data))
        }
        dataTask.resume()
    }
}
