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
        contentView.addSubview(moduleImage)
        contentView.addSubview(moduleLabel)
        setupInitialUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Property

    private lazy var moduleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)!
        label.textColor = .label
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moduleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // MARK: - Initital UI

    func setupInitialUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 19
        //TODO: shadow color
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        contentView.layer.cornerRadius = 18
    }
    

    // MARK: - Layout
    
    private func setupLayout() {
        moduleImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moduleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        moduleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        moduleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    // MARK: - Animation
    
    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.2) {
          let scale: CGFloat = 0.95
          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
            self.alpha = self.isHighlighted ? 0.6 : 1
        }
      }
    }
    
    
    // MARK: - External handling
    
    func setupCellUI(position: MainCellLabelPosition_ME,
                     text: String,
                     textColor: UIColor,
                     image: UIImage) {
        moduleLabel.text = text
        moduleLabel.textColor = textColor
        moduleImage.image = image
        switch position {
        case .topLeading:
            moduleLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                             constant: 15).isActive = true
            moduleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: 15).isActive = true
            moduleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor,
                                                  constant: -5).isActive = true
        case .bottomTrailing:
            moduleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                constant: -15).isActive = true
            moduleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -15).isActive = true
            moduleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 5).isActive = true
        case .center:
            moduleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                 constant: 5).isActive = true
            moduleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: -5).isActive = true
            moduleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }

}


