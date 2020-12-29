//
//  Router.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            
        } catch {
            completion(nil, nil, error)
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10)
        
        if route.path != "" {
            request.url = request.url?.appendingPathComponent(route.path)
            
        }
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue(K.QueryContentType.json, forHTTPHeaderField: K.QueryContentType.contentType)
            case .requestParameters(let bodyParameters, let urlParameters):
                
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        urlRequest: &request)
                
            case .requestParametrsAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                
                addAdditionalHeaders(additionalHeaders, urlRequest: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        urlRequest: &request)
            }
            
            return request
        } catch {
            throw error
        }
        
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         urlRequest: inout URLRequest) throws {
        do {
            if let bodyParams = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParams)
            }
            if let urlParams = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParams)
            }
        } catch {
            throw error
        }
        
    }
    
    fileprivate func addAdditionalHeaders(_ headers: HTTPHeaders?,
                                     urlRequest: inout URLRequest) {
        guard let headers = headers else { return }
        
        for (key, value) in headers {
            urlRequest.setValue(key, forHTTPHeaderField: value)
        }
    }
    
}
