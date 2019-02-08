
//
//  Moview.swift
//  MovieSearch
//
//  Created by Dominic Lanzillotta on 2/8/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let id: Int
    let overview: String
    let rating: Float
    let posterURLAsString: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case overview
        case rating = "vote_average"
        case posterURLAsString = "poster_path"
        case releaseDate = "release_date"
    }
}
