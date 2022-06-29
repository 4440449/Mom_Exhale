//
//  MainCollectionHeaderReusableView_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit

class MainCollectionHeaderReusableView_MEx: UICollectionReusableView, UIScrollViewDelegate {
    
    static let identifier = String(describing: MainCollectionHeaderReusableView_MEx.self)
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.1
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Property
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.contentSize = CGSize(width: self.bounds.width * 6,
                                    height: self.bounds.height)
        scroll.showsHorizontalScrollIndicator = false
        scroll.layer.cornerRadius = 15
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        
        let colorsArr: [UIColor] = [.red, .green, .magenta, .blue, .tintColor, .brown, .cyan]
        for x in 0...5 {
            let view = UIView()
            view.backgroundColor = colorsArr.randomElement()
            view.frame = CGRect(x: self.bounds.maxX * CGFloat(x),
                                y: self.bounds.minY,
                                width: self.bounds.width,
                                height: self.bounds.height)
            scroll.addSubview(view)
        }
        return scroll
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 6
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private func setupLayout() {
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
}
