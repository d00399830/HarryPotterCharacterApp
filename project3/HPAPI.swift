//
//  HPAPI.swift
//  project3
//
//  Created by Stratton McDonald on 11/11/21.
//

import Foundation

enum EndPoint: String {
    case hpcharacters = "6192d46e0ddbee6f8b0bff47/2"
}

struct HPAPI {
    
    private static let baseURLString = "https://api.jsonbin.io/b/"
    
    private static func hpURL (endPoint: EndPoint) -> URL {
        var components = URLComponents(string: baseURLString + endPoint.rawValue)!
        components.queryItems = [URLQueryItem]()
        return components.url!
    }
    
    static var HPCharactersURL: URL {
        return hpURL(endPoint: .hpcharacters)
    }
    
    static func characters(fromJSON data: Data) -> Result<[Character], Error> {
        do {
            let decoder = JSONDecoder()
            let hpResponse = try decoder.decode([Character].self, from: data) //this has to be the stupidest thing in the world I stfg if I ever meet the dev that won't just allow you to decode an array, I will bonk him
            
            let characterLst = hpResponse.filter{ $0.image != "" }
            return .success(characterLst)
        } catch {
            return .failure(error)
        }
    }
}




