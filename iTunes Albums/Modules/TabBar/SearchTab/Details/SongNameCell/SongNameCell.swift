//
//  SongNameCell.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 29.12.2020.
//

import UIKit

class SongNameCell: UITableViewCell {
    
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    
    private var itemVM: ItemViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(itemVM: ItemViewModel) {
        self.itemVM = itemVM
        
        numberLabel.text = "\(itemVM.trackNumber ?? 0)"
        titleLabel.text = itemVM.trackName
    }
    
}
