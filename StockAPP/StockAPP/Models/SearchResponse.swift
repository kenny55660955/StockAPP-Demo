//
//  SearchResponse.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/3.
//
/*
 {
     "count": 22,
     "result": [
         {
             "description": "APPLE INC",
             "displaySymbol": "AAPL",
             "symbol": "AAPL",
             "type": "Common Stock"
         }
    ]
 */

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
