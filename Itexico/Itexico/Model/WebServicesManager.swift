//
//  WebServicesManager.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/7/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        let isConnected = NetworkReachabilityManager()!.isReachable
        if isConnected {
            return true
        }
        else {
            return false
        }
    }
}

class WebServicesManager: NSObject {
    
    static func getMoviesList(completionHandler : @escaping (_ movies: [Movie]) -> ()){
        
        if Connectivity.isConnectedToInternet() {
        Alamofire.request(Services.listMovies).response { response in
            guard let data = response.data else { return }
            
            do {
                let jsonResponce = JSON(data)
                let results = jsonResponce["results"].arrayValue.description
                let jonM = results.data(using: .utf8)
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: jonM!)
                completionHandler(movies)
            } catch let error {
                print(error)
                completionHandler([])

            }
        }
        }
    }
    
    static func getTrailersList(movieId: Int, completionHandler : @escaping (_ movies: [Trailer]) -> ()){
        
        if Connectivity.isConnectedToInternet() {
            WebLinks.createListTrailerPath(movieId: movieId)
            Alamofire.request(Services.listTrailers).response { response in
                guard let data = response.data else { return }
                
                do {
                    let jsonResponce = JSON(data)
                    let results = jsonResponce["results"].arrayValue.description
                    let jonM = results.data(using: .utf8)
                    let decoder = JSONDecoder()
                    let trailers = try decoder.decode([Trailer].self, from: jonM!)
                    completionHandler(trailers)
                } catch let error {
                    print(error)
                    completionHandler([])
                    
                }
            }
        }
    }
    

}
