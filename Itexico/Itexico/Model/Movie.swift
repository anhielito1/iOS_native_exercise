//
//  Movie.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/7/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id : Int
    var voteAvarage : Double
    var title : String
    var overview : String
    var releaseDate : String
    var posterPath : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAvarage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        voteAvarage = try values.decode(Double.self, forKey: .voteAvarage)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        posterPath = try WebLinks.imageBaseUrl + values.decode(String.self, forKey: .posterPath) 
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(voteAvarage, forKey: .voteAvarage)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
    }
}
