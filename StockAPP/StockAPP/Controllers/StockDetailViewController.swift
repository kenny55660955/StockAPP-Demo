//
//  StockDetailViewController.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/2.
//

import UIKit

class StockDetailViewController: UIViewController {
    // MARK: - Properties
    private let symbol: String
    private let company: String
    private var candleStickData: [CandleStick] = []
    
    // MARK: - init
    init(symbol: String, company: String, candleStickData: [CandleStick]) {
        self.symbol = symbol
        self.company = company
        self.candleStickData = candleStickData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
