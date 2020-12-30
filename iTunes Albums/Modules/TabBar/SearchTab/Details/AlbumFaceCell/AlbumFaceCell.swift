//
//  AlbumFaceCell.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 29.12.2020.
//

import UIKit

class AlbumFaceCell: UITableViewCell {

    @IBOutlet private var albumArtwork: UIImageView!
    @IBOutlet private var albumTitleLabel: UILabel!
    @IBOutlet private var artistNameLabel: UILabel!
    
    private var itemVM: ItemViewModel?
    
    func configure(itemVM: ItemViewModel) {
        self.itemVM = itemVM
        
        fillWithData()
    }
    
    private func fillWithData() {
        
        itemVM?.loadImage { (image) in
            DispatchQueue.main.async {
                
                if let safeImage = image {
                    self.albumArtwork.image = safeImage
                }
                else {
                    self.albumArtwork.image = UIImage()
                }
            }
        }
        
        albumTitleLabel.text = itemVM?.collectionName
        artistNameLabel.text = itemVM?.artistName
        
        albumArtwork.layer.masksToBounds = true
        albumArtwork.layer.cornerRadius = 5
    }
    
}
