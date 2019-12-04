//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]
typealias TaskCompletionHandler = (JSON?, URLResponse?, Error?) -> Void

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol JSONDecodable {
    init?(json: JSON)
}

enum ServiceResponce<T> {
    case Success(T)
    case Failure(Error)
}

protocol NetworkService {
    
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func jsonTask(request: URLRequest, completionHandler: @escaping TaskCompletionHandler) -> URLSessionTask
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping (JSON) -> T?, completionHandler: @escaping (ServiceResponce<T>) -> Void)
}

extension NetworkService {
    
    func jsonTask(request: URLRequest, completionHandler: @escaping TaskCompletionHandler) -> URLSessionTask {
        
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            
            // check responce
            guard let httpResponce = responce as? HTTPURLResponse else {
                
                let userInfo = [NSLocalizedDescriptionKey: NSString(string: "Missing HTTP Responce")]
                let error = NSError(domain: SVSNetworkingErrorDomain, code: MissingHttpResponceError, userInfo: userInfo)
                
                completionHandler(nil, nil, error)
                
                return
            }
            
            // check data
            if data == nil {
                if let error = error {
                    completionHandler(nil, httpResponce, error)
                }
                
            } else {
                
                switch httpResponce.statusCode {
                case 200:
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? JSON
                        completionHandler(jsonData, httpResponce, nil)
                    } catch let error as NSError {
                        completionHandler(nil, httpResponce, error)
                    }
                default:
                    print("We have got respoce status: \(httpResponce.statusCode)")
                }
            }
        }
        
        return dataTask
    }
    
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping (JSON) -> T?, completionHandler: @escaping (ServiceResponce<T>) -> Void) {
        let task = jsonTask(request: request) { (json, responce, error) in
            guard let jsonData = json else {
                if let error = error {
                    completionHandler(.Failure(error))
                }
                return
            }
            
            if let data = parse(jsonData) {
                completionHandler(.Success(data))
            } else {
                let error = NSError(domain: SVSNetworkingErrorDomain, code: UnexpectedResponceError, userInfo: nil)
                completionHandler(.Failure(error))
            }
        }
        task.resume()
    }
}
