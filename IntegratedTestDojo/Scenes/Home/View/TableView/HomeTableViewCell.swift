//
//  HomeTableViewCell.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(with model: AlbumCellModel) {
        albumTitleLabel.text = model.title
        releaseYearLabel.text = model.releaseYear
        setUpFavoriteImage(isFavourite: model.isFavourite)
    }
    
    private func setUpFavoriteImage(isFavourite: Bool) {
        let imageName = isFavourite ? "lightbulb.fill" : "lightbulb"
        favouriteImage.image = UIImage(systemName: imageName)
        favouriteImage.tintColor = isFavourite ? .orange : .lightGray
    }
    
    private func setUpAlbumImage(url: String) {
        
    }
}
