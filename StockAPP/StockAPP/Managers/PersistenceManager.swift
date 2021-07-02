//
//  PersistenceManager.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/2.
//

import Foundation

final class PersistenceManager {
    
    // MARK: - Properties
    static let shared = PersistenceManager()
    
    private var hasOnBoarded: Bool {
        return false
    }
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        
    }
    
    var watchList: [String] {
        return []
    }
    
    // MARK: - Life cycle
    private init() {}
    
    // MARK: - Methods
    func addToWatchList() {
        
    }
    
    func removeFromWatchList() {
        
    }
    
    // MARK: - Private
}
