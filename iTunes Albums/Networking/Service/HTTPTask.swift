//
//  HTTPTask.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    
    case requestParametrsAndHeaders(bodyParameters: Parameters?,
                                    urlParameters: Parameters?,
                                    additionHeaders: HTTPHeaders?)
}
