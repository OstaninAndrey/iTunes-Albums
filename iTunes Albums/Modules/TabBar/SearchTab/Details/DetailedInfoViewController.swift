//
//  DetailedInfoViewController.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class DetailedInfoViewController: UIViewController {
    
    // MARK: Properties
    private var collectionItemVM: ItemViewModel
    private var songListViewModel: SongListViewModel
    private var tableView = UITableView()
    
    // MARK: VC lifecycle
    init(itemVM: ItemViewModel) {
        self.collectionItemVM = itemVM
        songListViewModel = SongListViewModel(albumId: collectionItemVM.collectionId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.backgroundColor)
        title = collectionItemVM.collectionName
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.Cell.SongNameCell.nibName, bundle: nil), forCellReuseIdentifier: K.Cell.SongNameCell.reuseID)
        tableView.register(UINib(nibName: K.Cell.AlbumFaceCell.nibName, bundle: nil), forCellReuseIdentifier: K.Cell.AlbumFaceCell.reuseID)
        
        setupTableView()
        fillElements()
        styleElements()
    }
    
    // MARK: UI setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func styleElements() {
        tableView.backgroundColor = UIColor(named: K.backgroundColor)
        tableView.separatorStyle = .none
    }

    // MARK: Data managing methods
    private func fillElements() {
        
        songListViewModel.fetchSongList {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate methods
extension DetailedInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = songListViewModel.getItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch item.wrapperType {
        case K.WrapperType.collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.AlbumFaceCell.reuseID) as! AlbumFaceCell
            cell.configure(itemVM: item)
            return cell
        case K.WrapperType.track:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.SongNameCell.reuseID) as! SongNameCell
            cell.configure(itemVM: item)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}

