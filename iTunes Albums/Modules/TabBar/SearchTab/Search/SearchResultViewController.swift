//
//  SearchResultViewController.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class SearchResultViewController: UIViewController {
    // MARK: Properties
    private var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private var collectionVM = CollectionViewModel()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: K.backgroundColor)
        
        setupColletion()
        setupConstraints()
    }
    
    // MARK: UI setup
    private func setupColletion() {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2 - 15
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = UIColor(named: K.backgroundColor)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: K.Cell.ThumbCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: K.Cell.ThumbCell.reuseID)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    // MARK: Search managing methods
    func updateResults(for query: String) {
        collectionVM.fetchAlbums(for: query) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let vm = collectionVM.getItemViewModel(at: indexPath.item) else {
            return
        }
        let vc = DetailedInfoViewController(itemVM: vm)
        
        present(vc, animated: true, completion: nil)
    }
}
