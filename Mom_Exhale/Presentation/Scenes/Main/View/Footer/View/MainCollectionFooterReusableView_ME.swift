//
//  MainCollectionFooterReusableView_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//



import UIKit

class MainCollectionFooterReusableView_ME: UICollectionReusableView,
                                           UICollectionViewDelegate,
                                           UICollectionViewDataSource {
    
    // MARK: - Static
    
    static let identifier = String(describing: MainCollectionFooterReusableView_ME.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: MainFooterViewModelProtocol_ME?
    
    func setupViewModel(_ viewModel: MainFooterViewModelProtocol_ME) {
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
        viewModel?.blogArticles.subscribe(observer: self) { [weak self] articles in
            self?.collection.reloadData()
            self?.pageControl.numberOfPages = articles.count
        }
        viewModel?.isLoading.subscribe(observer: self) { [weak self] isLoading in
            isLoading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }
    }
    
    
    // MARK: - Property
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: self.bounds,
                                          collectionViewLayout: setupCollectionViewLayout())
        collection.register(FooterCollectionViewCell_ME.self,
                            forCellWithReuseIdentifier: FooterCollectionViewCell_ME.identifier)
        collection.layer.cornerRadius = 15
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var articleSourceLabel: UILabel = {
        let label = UILabel()
        label.text = "из блога"
        label.font = UIFont(name: "Montserrat-Regular", size: 13)!
        label.textColor = .label
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
        control.pageIndicatorTintColor = .systemGray4
        control.currentPageIndicatorTintColor = .systemGray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    // MARK: - Initital UI
    
    private func setupInitialUI() {
        self.collection.backgroundColor = UIColor(named: "background")
        self.layer.shadowColor = UIColor(named: "bottomShadowColor")?.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 5, height: 7)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.borderColor = UIColor(named: "FooterBorderColor")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            print("Fotter shadowColor has been changed")
            self.layer.shadowColor = UIColor(named: "bottomShadowColor")?.cgColor
            self.layer.borderColor = UIColor(named: "FooterBorderColor")?.cgColor
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
        return viewModel?.blogArticles.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCollectionViewCell_ME.identifier, for: indexPath) as? FooterCollectionViewCell_ME else {
            fatalError()
        }
        if let title = viewModel?.blogArticles.value[indexPath.row].title {
            cell.setupCellUI(text: title)
        }
        //        let colorsArr: [UIColor] = [.red, .green, .magenta, .blue, .tintColor, .brown, .cyan]
        //        cell.backgroundColor = colorsArr.randomElement()
        return cell
    }
    
}
