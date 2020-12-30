//
//  HistoryViewController.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    // MARK: Properties
    private let cacheVM = CacheViewModel()
    private var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                        style: .plain)
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.backgroundColor)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        cacheVM.loadRecords {
            tableView.reloadData()
        }
    }
    
    // MARK: UI setup
    private func setupTableView() {
        tableView.backgroundColor = UIColor(named: K.backgroundColor)
        tableView.separatorColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.Cell.SavedCell.nibName, bundle: nil), forCellReuseIdentifier: K.Cell.SavedCell.reuseID)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
}

// MARK: - TableView Delegate
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cacheVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.SavedCell.reuseID, for: indexPath) as! SavedTableViewCell
        
        if let record = cacheVM.getRecordInstance(index: indexPath.row) {
            cell.configure(item: record)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let record = cacheVM.getRecordInstance(index: indexPath.row) {
            let vc = SearchResultViewController()
            vc.updateResults(for: record.query ?? "")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if cacheVM.removeRecord(at: indexPath.row) {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                tableView.reloadData()
            }
         }
    }
    
}
