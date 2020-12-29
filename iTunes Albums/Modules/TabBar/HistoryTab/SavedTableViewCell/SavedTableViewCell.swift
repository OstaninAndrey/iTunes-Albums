//
//  SavedTableViewCell.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet private var searchHistoryLabel: UILabel!
    
    func configure(item: SearchRecord) {
        
        if let q = item.query {
            searchHistoryLabel.text = q
        }
    }
    
}
