//
//  MainCollectionHeaderReusableView_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit

class MainCollectionHeaderCellView_ME: UICollectionViewCell,
                                       UICollectionViewDelegate,
                                       UICollectionViewDataSource {
    
    // MARK: - Static
    
    static let identifier = String(describing: MainCollectionHeaderCellView_ME.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: MainHeaderViewModelProtocol_ME?
    
    func setupViewModel(_ viewModel: MainHeaderViewModelProtocol_ME) {
        self.viewModel = viewModel
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collection)
        self.addSubview(articleSourceLabel)
        self.addSubview(pageControl)
        self.addSubview(activity)
        setupInitialUI()
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
    
    
    // MARK: - Observer
    
    private func setupObservers() {
        viewModel?.basicArticles.subscribe(observer: self) { [weak self] articles in
            guard let strongSelf = self else { return }
            guard !articles.isEmpty else { return }
            strongSelf.collection.reloadSections(IndexSet(integer: 0))
            strongSelf.pageControl.numberOfPages = articles.count
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
        let c1 = UIColor(red: 0.968, green: 0.711, blue: 0.559, alpha: 1)
        let c2 = UIColor(red: 0.988, green: 0.795, blue: 0.619, alpha: 1)
        collection.setGradientBackground(fromColor: c1, toColor: c2,
                                         location1: 0, location2: 1,
                                         startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 1))
        collection.layer.cornerRadius = 16
        collection.layer.borderWidth = 1
        collection.layer.borderColor = UIColor(named: "HeaderBorderColor")?.cgColor
        collection.isPrefetchingEnabled = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var articleSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "базовые статьи"
        label.font = UIFont(name: "Montserrat-Regular", size: 13)!
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        control.pageIndicatorTintColor = UIColor(named: "HeaderPageIndicator")
        control.currentPageIndicatorTintColor = UIColor(named: "HeaderCurrentPageIndicator")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    // MARK: - Initital UI
    
    private func setupInitialUI() {
        self.layer.shadowColor = UIColor(named: "bottomShadowColor")?.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 5, height: 7)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.layer.shadowColor = UIColor(named: "bottomShadowColor")?.cgColor
            collection.layer.borderColor = UIColor(named: "HeaderBorderColor")?.cgColor
        }
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        articleSourceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        articleSourceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        articleSourceLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
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
//        print("numberOfItemsInSection == \(viewModel?.basicArticles.value.count ?? 0)")
        return viewModel?.basicArticles.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell_ME.identifier, for: indexPath) as? HeaderCollectionViewCell_ME else {
            fatalError()
        }
//        print(" \n ----- basicArticles.value.count == \(viewModel!.basicArticles.value.count) indexPath.row == \(indexPath.row) ------ \n")
        guard let vm = viewModel else { return cell }
        let title = vm.basicArticles.value[indexPath.row].title
        cell.setupCellUI(text: title)
        return cell
    }
    
}

