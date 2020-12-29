//
//  JSONParameterEncoder.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

// For scaling if need POST queries

public struct JSONParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: K.QueryContentType.contentType) == nil {
                urlRequest.setValue(K.QueryContentType.json, forHTTPHeaderField: K.QueryContentType.contentType)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}
