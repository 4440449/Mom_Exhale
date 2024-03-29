//
//  HeaderCollectionViewCell_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 01.07.2022.
//

import UIKit


final class HeaderCollectionViewCell_ME: UICollectionViewCell {
    
    static let identifier = String(describing: HeaderCollectionViewCell_ME.self)
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(articleTitleLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Property
    
    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.isHighlighted ? 0.6 : 1
        }
      }
    }

    private lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 17)!
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        articleTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        articleTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -5).isActive = true
        articleTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
    }
    
    
    // MARK: - External handling

    func setupCellUI(text: String) {
        articleTitleLabel.text = text
    }
    
}
