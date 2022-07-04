//
//  MainCollectionHeaderReusableView_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit

class MainCollectionHeaderReusableView_ME: UICollectionReusableView,
                                           UICollectionViewDelegate,
                                           UICollectionViewDataSource {
    
    // MARK: - Static
    
    static let identifier = String(describing: MainCollectionHeaderReusableView_ME.self)
    
    
    // MARK: - Dependencies
    
   var viewModel: MainHeaderViewModelProtocol_ME?
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.cornerRadius = 15
        self.addSubview(collection)
        self.addSubview(pageControl)
        self.addSubview(activity)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        setupObservers()
        viewModel?.loadInitialState()
    }
    
    
    // MARK: - Private logic
    
    private func setupObservers() {
        viewModel?.banners.subscribe(observer: self) { [weak self] banners in
            self?.collection.reloadData()
            self?.pageControl.numberOfPages = banners.count
        }
        viewModel?.isLoading.subscribe(observer: self) { [weak self] isLoading in
            isLoading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }
    }
    
    
    // MARK: - Property
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: self.bounds,
                                          collectionViewLayout: setupCollectionViewLayout())
        collection.register(HeaderCollectionViewCell_ME.self,
                            forCellWithReuseIdentifier: HeaderCollectionViewCell_ME.identifier)
        collection.layer.cornerRadius = 15
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: self.bounds.midX,
                                   y: self.bounds.midY)
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .systemGray
        return indicator
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 0
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let strongSelf = self else { return }
            let pageNumber = round(offset.x / strongSelf.collection.bounds.width)
            strongSelf.pageControl.currentPage = Int(pageNumber)
        }
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    // MARK: - Collection Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.banners.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell_ME.identifier, for: indexPath) as? HeaderCollectionViewCell_ME else {
            fatalError()
        }
        let colorsArr: [UIColor] = [.red, .green, .magenta, .blue, .tintColor, .brown, .cyan]
        cell.backgroundColor = colorsArr.randomElement()
        
        return cell
    }
    
}
