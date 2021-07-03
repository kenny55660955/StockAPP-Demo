//
//  NewsHeaderView.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/3.
//

import UIKit

protocol NewsHeaderViewDelegate: AnyObject {
    func newsHEaderViewDidTapButton(_ headerView: NewsHeaderView)
}

class NewsHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "NewsHeaderView"
    
    static let preferredHeight: CGFloat = 70
    
    weak var delegate: NewsHeaderViewDelegate?
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("+ WatchList", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(label, button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 14, y: 0,
                             width: contentView.width-28,
                             height: contentView.height)
        
        button.sizeToFit()
        button.backgroundColor = .blue
        button.frame = CGRect(x: contentView.width - button.width - 16,
                              y: (contentView.height - button.height) / 2,
                              width: button.width + 8,
                              height: button.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        
    }
    
    func configure(with viewModel: ViewModel) {
        label.text = viewModel.title
        button.isHidden = !viewModel.shouldShowAddButton
    }
    @objc
    private func didTapButton() {
        delegate?.newsHEaderViewDidTapButton(self)
    }
    

}

extension NewsHeaderView {
    struct ViewModel {
        let title: String
        let shouldShowAddButton: Bool
    }
}
