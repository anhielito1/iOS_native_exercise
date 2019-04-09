//
//  Trailer.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/8/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import Foundation

struct Trailer: Codable {
    
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
