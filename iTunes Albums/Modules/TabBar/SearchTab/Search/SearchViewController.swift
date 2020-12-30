//
//  SearchViewController.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Properties
    lazy private var searchController: UISearchController = {
        let vc = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: vc)
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private let collectionVM = CollectionViewModel()
    
    // MARK: VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.backgroundColor)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupCollection()
        collectionVM.fetchMainScreen {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UI Setup
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2 - 15
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: K.Cell.ThumbCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: K.Cell.ThumbCell.reuseID)
    }
    
}

// MARK: - UISearchBarDelegate methods
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchController.searchBar.text {
            collectionVM.saveRecord(for: query)
            
            let vc = searchController.searchResultsController as! SearchResultViewController
            vc.updateResults(for: query)
        }
    }
    
}

// MARK: - UICollectionViewDelegate methods
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.ThumbCell.reuseID, for: indexPath) as! ThumbCell
        
        if let vm = collectionVM.getItemViewModel(at: indexPath.item) {
            cell.configure(itemVM: vm)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = collectionVM.getItemViewModel(at: indexPath.item) else { return }
        
        let vc = DetailedInfoViewController(itemVM: vm)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

