//
//  WebLinks.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/7/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import Foundation

enum Filter {
    case popular
    case top
}

enum Language {
    case english
    case spanish
}

struct WebLinks {
    
    static let baseUrl = "http://api.themoviedb.org/3/movie/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w185/"
    private static let popular = "popular?"
    private static let topRelated = "top_rated?"
    private static let spanish = "&language=es-MX"
    private static let english = "&language=en-US"
    private static let apiKey = "api_key=031d5b20a8083ffdbd82df9c7f87aff8"
    static var filter = Filter.popular 
    static var language = Language.english
    
    static func createMovieListPath() {
        var url = WebLinks.baseUrl
        switch WebLinks.filter {
        case .popular:
            url += popular
        case .top:
            url += topRelated
        }
        url += apiKey
        switch WebLinks.language {
        case .spanish:
            url += spanish
        case .english:
            url += english
        }
        Services.listMovies = url
    }
    
    static func createListTrailerPath(movieId: Int) {
        var url = WebLinks.baseUrl
        url += movieId.description + "/videos?" + apiKey
        switch WebLinks.language {
        case .spanish:
            url += spanish
        case .english:
            url += english
        }
        Services.listTrailers = url
        print(url)

    }
    
}


struct Services {
    static var listMovies = "http://api.themoviedb.org/3/movie/popular?api_key=031d5b20a8083ffdbd82df9c7f87aff8&language=en-US"
    static var listTrailers = ""
}
