//
//  APICaller.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/2.
//

import Foundation

final class APICaller {
    
    // MARK: - Properties
    static let shared = APICaller()
    
    // MARK: - Life cycle
    private init() {
        
    }
    
    // MARK: - Public
    
    func search(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        request(url: url(for: .search, queryParams: ["q": safeQuery]), expection: SearchResponse.self, completion: completion)
    }
    
    // MARK: - Methods
    
    private func url(for endPoint: Endpoint, queryParams: [String: String] = [:]) -> URL? {
        
        var urlString = Constants.baseUrl + endPoint.rawValue
        
        var queryItems = [URLQueryItem]()
        // Add Any parameters
        
        for (name , value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Add Token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        let queryString = queryItems.map{ "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        urlString += "?" + queryString
        
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(url: URL?, expection: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  error == nil else {  return }
            
            do {
                let reuslt = try JSONDecoder().decode(expection, from: data)
                completion(.success(reuslt))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// MARK: - ENUM
extension APICaller {
    private enum Endpoint: String {
        case search = "search"
    }
    
    private enum APIError: Error {
        case invalidUrl
        case noDataReturned
    }
    
    // Sign up API from https://finnhub.io/
    private struct Constants {
        
        static let apiKey = "I Did Push api key "
        static let sandboxApiKey = ""
        static let baseUrl = ""
        
    }
}
