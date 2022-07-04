//
//  MainCollectionViewCell_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit


class MainCollectionViewCell_ME: UICollectionViewCell {
    
    static let identifier = String(describing: MainCollectionViewCell_ME.self)

    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        contentView.addSubview(moduleLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Property

    private lazy var moduleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLayout() {
        moduleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        moduleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        moduleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
    }
    
    
    func setupTextLabel(text: String) {
        moduleLabel.text = text
    }

}
