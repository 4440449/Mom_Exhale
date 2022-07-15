//
//  MainViewController_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit

class MainViewController_ME: UIViewController,
                             UICollectionViewDelegate,
                             UICollectionViewDataSource {
    
    // MARK: - Dependencies
    
    private let viewModel: MainViewModelProtocol_ME
    private let headerConfigurator: MainHeaderConfiguratorProtocol_ME
    private let footerConfigurator: MainFooterConfiguratorProtocol_ME
    
    
    // MARK: - Init
    
    init(viewModel: MainViewModelProtocol_ME,
         headerConfigurator: MainHeaderConfiguratorProtocol_ME,
         footerConfigurator: MainFooterConfiguratorProtocol_ME,
         nibName: String? = nil,
         bundle: Bundle? = nil) {
        self.viewModel = viewModel
        self.headerConfigurator = headerConfigurator
        self.footerConfigurator = footerConfigurator
        super.init(nibName: nibName,
                   bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        view.addSubview(activity)
        setupInitialUI()
        setupLayout()
        setupObservers()
        viewModel.loadInitialState()
    }
    
    
    // MARK: - Subscribe
    
    func setupObservers() {
        viewModel.modules.subscribe(observer: self) { [weak self] modules in
            guard let strongSelf = self else { return }
            strongSelf.collection.reloadSections(IndexSet(integer: 1))
        }
        
        viewModel.isLoading.subscribe(observer: self) { [weak self] isLoading in
            isLoading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }
    }
    
    
    // MARK: - Property
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: collection.bounds.midX,
                                   y: collection.bounds.midY * 1.3)
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .systemGray
        return indicator
    }()
    
    private lazy var userNavBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.fill"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(userButtonTapped))
        button.tintColor = .label
        return button
    }()
    
    @objc private func userButtonTapped() {
        print(userButtonTapped)
    }
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: setupCollectionViewLayout())
        collection.register(MainCollectionViewCell_ME.self,
                            forCellWithReuseIdentifier: MainCollectionViewCell_ME.identifier)
        collection.register(MainCollectionHeaderCellView_ME.self, forCellWithReuseIdentifier: MainCollectionHeaderCellView_ME.identifier)
        collection.register(MainCollectionFooterCellView_ME.self, forCellWithReuseIdentifier: MainCollectionFooterCellView_ME.identifier)
        collection.contentInset.top = 5
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor(named: "background")
        collection.isPrefetchingEnabled = false
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    private lazy var logo1Label: UILabel = {
        let label = UILabel()
        label.text = "п р о е к т"
        label.font = UIFont(name: "Montserrat-Light", size: 16)!
        label.textColor = .label
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logo2Label: UILabel = {
        let label = UILabel()
        label.text = "#мамавыдохни"
        label.font = UIFont(name: "Montserrat-Black", size: 29)!
        label.textColor = .label
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Initital UI
    
    private func setupInitialUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.rightBarButtonItem = userNavBarButton
        navigationController?.navigationBar.addSubview(logo1Label)
        navigationController?.navigationBar.addSubview(logo2Label)
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        logo1Label.centerXAnchor.constraint(equalTo: self.navigationController!.navigationBar.centerXAnchor).isActive = true
        logo1Label.topAnchor.constraint(greaterThanOrEqualTo: self.navigationController!.navigationBar.topAnchor, constant: 20).isActive = true
        logo2Label.centerXAnchor.constraint(equalTo: self.navigationController!.navigationBar.centerXAnchor).isActive = true
        logo2Label.topAnchor.constraint(equalTo: logo1Label.bottomAnchor).isActive = true
        logo2Label.bottomAnchor.constraint(lessThanOrEqualTo: self.navigationController!.navigationBar.bottomAnchor, constant: -24).isActive = true
    }
    
    
    //CollectionView
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.17))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25)
                return section
                
            case 1:
                let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.5))
                let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(1))
                let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitems: [leadingItem])
                
                let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(1))
                let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
                trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.4))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leadingGroup, trailingItem])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25)
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.17))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25)
                return section
                
            default:
                fatalError()
            }
        }
        return layout
    }
    
    
    // MARK: - Collection Data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.modules.value.count
        case 2:
            return 1
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionHeaderCellView_ME.identifier, for: indexPath) as? MainCollectionHeaderCellView_ME else {
                fatalError()
            }
            headerConfigurator.configure(cell)
            cell.viewDidLoad()
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell_ME.identifier, for: indexPath) as? MainCollectionViewCell_ME else {
                fatalError()
            }
            let module = viewModel.modules.value[indexPath.row]
            switch module.keyName {
            case .babyTracker:
                cell.setupCellUI(position: .topLeading,
                                 text: module.title,
                                 textColor: module.titleColor.color(),
                                 image: module.image)
            case .BLW:
                cell.setupCellUI(position: .bottomTrailing,
                                 text: module.title,
                                 textColor: module.titleColor.color(),
                                 image: module.image)
            case .calmingNotifications:
                cell.setupCellUI(position: .center,
                                 text: module.title,
                                 textColor: module.titleColor.color(),
                                 image: module.image)
            }
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionFooterCellView_ME.identifier, for: indexPath) as? MainCollectionFooterCellView_ME else {
                fatalError()
            }
            footerConfigurator.configure(cell)
            cell.viewDidLoad()
            return cell
            
        default:
            fatalError()
        }
    }
    
    
    // MARK: - Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(index: indexPath.row)
    }
    
}

