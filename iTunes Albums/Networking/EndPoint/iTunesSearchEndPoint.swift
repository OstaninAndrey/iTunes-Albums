//
//  iTunesSearchEndPoint.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

public enum iTunesSearchEndPoint {
    
    case image(url: String)
    
    case search(term: String,
                entity: String = "album",
                limit: Int)
    
    case lookup(id: Int,
                entity: String = "song")
}

extension iTunesSearchEndPoint: EndPointType {
    
    var stringBaseURL: String {
        switch self {
        case .image(let url):
            let safeUrl = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            return safeUrl ?? url
        default:
            return K.Path.basePath
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: stringBaseURL) else {
            print(stringBaseURL)
            fatalError()
        }
        
        return url
    }
    
    public var path: String {
        switch self {
        case .search:
            return K.Path.search
        case .image:
            return K.Path.empty
        case .lookup:
            return K.Path.lookup
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
            
        case .search(let term, let entity, let limit):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        K.ParameterOptions.term: term,
                                        K.ParameterOptions.entity: entity,
                                        K.ParameterOptions.limit: limit
                                      ])
        case .image:
            return .request
            
        case .lookup(id: let id, entity: let entity):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        K.ParameterOptions.id: id,
                                        K.ParameterOptions.entity: entity
                                      ])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
