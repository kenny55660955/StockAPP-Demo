//
//  StockChartView.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/10.
//

import UIKit

class StockChartView: UIView {
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func reset() {
        
    }
    func configure(with viewModel: ViewModel) {
        
    }
}
// MARK: - ViewModel
extension StockChartView {
    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
    }
}
