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
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchListKey = "watchList"
    }
    
    var watchList: [String] {
        if !hasOnBoarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setupDefault()
        }
        return userDefaults.stringArray(forKey: Constants.watchListKey) ?? []
    }
    
    // MARK: - Life cycle
    private init() {}
    
    // MARK: - Methods
    func addToWatchList() {
        
    }
    
    func removeFromWatchList(symbol: String) {
        var newsList = [String]()
        
        print("Delete: \(symbol)")
        userDefaults.set(nil, forKey: symbol)
        for item in watchList where item != symbol {
            
            newsList.append(item)
        }
        userDefaults.set(newsList, forKey: Constants.watchListKey)
    }
    
    // MARK: - Private
    private func setupDefault() {
        let map: [String: String] = [
            "AAPL": "Apple Inc",
            "MSFT": "Microsoft Corporation",
            "SNAP": "Snap Inc",
            "GOOG": "Alphabet",
            "AMZN": "Slack Technologies",
            "WORK": "Facebook Inc",
            "FB": "Nvidia Inc.",
            "NVDA": "Nvidia Inc." ,
            "NIKE": "Nike"
        ]
        let symbols = map.keys.map{ $0 }
        userDefaults.set(symbols, forKey: Constants.watchListKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol)
        }
    }
    
}
