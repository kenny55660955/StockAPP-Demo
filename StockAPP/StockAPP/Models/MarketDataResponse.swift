//
//  MarketDataResponse.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/4.
//

import Foundation

struct MarketDataResponse: Codable {
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case status = "s"
        case timestamps = "t"
    }
    var candleSticks: [CandleStick] {
        var results = [CandleStick]()
        for index in 0..<open.count {
            results.append(.init(date: Date(timeIntervalSince1970: timestamps[index]),
                                 high: high[index],
                                 low: low[index],
                                 open: open[index],
                                 close: close[index]))
        }
        let sortedData = results.sorted(by: { $0.date > $1.date })
        print(sortedData)
        return results
    }
}
struct CandleStick {
    let date: Date
    let high: Double
    let low: Double
    let open: Double
    let close: Double
}
//    
//    init(open: [Double], close: [Double], high: [Double], low: [Double], status: String, timestamps: [TimeInterval]) {
//        self.open = open
//        self.close = close
//        self.high = high
//        self.low = low
//        self.status = status
//        self.timestamps = timestamps
//    }

