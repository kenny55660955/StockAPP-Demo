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
    
    private struct Constants {
        static let apiKey = ""
        static let sandboxApiKey = ""
        static let baseUrl = ""
    }
    
    // MARK: - Life cycle
    private init() {
        
    }
    
    // MARK: - Public
    
    // MARK: - Methods
    
    private func url(for endPoint: Endpoint, queryParams: [String: String] = [:]) -> URL? {
        
        
        
        return nil
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
        case search
    }
    
    private enum APIError: Error {
        case invalidUrl
        case noDataReturned
    }
}
