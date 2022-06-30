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
    
    
    // MARK: - Init

    init(viewModel: MainViewModelProtocol_ME,
         nibName: String? = nil,
         bundle: Bundle? = nil) {
        self.viewModel = viewModel
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
        initialUISetup()
        setupObservers()
        viewModel.loadInitialState()
        
    }
    
    // MARK: - Subscribe
    
    func setupObservers() {
        viewModel.modules.subscribe(observer: self) { [weak self] modules in
            self?.collection.reloadData()
        }
    }

    
    
    // MARK: - Property
    
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
        collection.register(MainCollectionHeaderReusableView_MEx.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MainCollectionHeaderReusableView_MEx.identifier)
        collection.contentInset.top = 20
        collection.alwaysBounceVertical = true
        collection.backgroundColor = UIColor(named: "background")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    
    // MARK: - Layout
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(0.2)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    // MARK: - Collection Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.modules.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell_ME.identifier, for: indexPath) as? MainCollectionViewCell_ME else {
            fatalError()
        }
        let text = viewModel.modules.value[indexPath.row].title
        cell.setupTextLabel(text: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainCollectionHeaderReusableView_MEx.identifier,
            for: indexPath) as? MainCollectionHeaderReusableView_MEx else {
                fatalError()
            }
        return header
    }

    
    // MARK: - Collection Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        viewModel.didSelectItem(index: indexPath.row)
    }
    
    
    // MARK: - Priivate UI
    
    private func initialUISetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "#мамавыдохни"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = userNavBarButton
    }
}

