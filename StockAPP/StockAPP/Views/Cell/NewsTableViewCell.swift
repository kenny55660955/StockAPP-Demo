//
//  NewsTableViewCell.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/3.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "NewsStoryTableViewCell"
    
    static let preferredHeight: CGFloat = 140
    
    private let soureceLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let headlineLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    // Image
    private let storyImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        addSubviews(soureceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Image Layout
        let imageSize: CGFloat = contentView.height-6
        storyImageView.frame = CGRect(x: contentView.width-imageSize-10,
                                      y: (contentView.height - imageSize) / 1.4,
                                      width: imageSize,
                                      height: imageSize)
        // Label Layout
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15
        dateLabel.frame = CGRect(x: separatorInset.left, y: contentView.height - 40, width: availableWidth, height: 40)
        soureceLabel.sizeToFit()
        soureceLabel.frame = CGRect(x: separatorInset.left, y: 4, width: availableWidth, height: soureceLabel.height)
        
        headlineLabel.frame = CGRect(x: separatorInset.left, y: soureceLabel.bottom + 5, width: availableWidth, height: contentView.height - soureceLabel.bottom - dateLabel.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soureceLabel.text = nil
        headlineLabel.text = nil
        dateLabel.text = nil
        storyImageView.image = nil
    }
    // MARK: - Methods
    func configure(viewModel: ViewModel) {
        headlineLabel.text = viewModel.headline
        soureceLabel.text = viewModel.sourece
        dateLabel.text = viewModel.dateString
       // storyImageView.setImage(with: viewModel.imageURL)
        storyImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}

extension NewsTableViewCell {
    
    struct ViewModel {
        let sourece: String
        let headline: String
        let dateString: String
        let imageURL: URL?
        
        init(model: NewsStory) {
            self.sourece = model.source
            self.headline = model.headline
            self.dateString = String.string(from: model.datetime)
            self.imageURL = URL(string: model.image)
        }
    }
}
