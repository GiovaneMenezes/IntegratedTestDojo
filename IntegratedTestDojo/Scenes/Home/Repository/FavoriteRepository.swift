//
//  FavouriteRepository.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

protocol FavoriteRepositoryProtocol {
    func storeFavorite(id: Int)
    func removeFavorite(id: Int)
    func isFavorite(id: Int) -> Bool
}

class FavoriteRepository: Repository {
    
    private var favoritesList = [Int]() {
        didSet {
            userDefaults.set(favoritesList, forKey: key)
        }
    }
    
    override init(key: String = "FavouriteList") {
        super.init(key: key)
        favoritesList = (userDefaults.object(forKey: key) as? [Int]) ?? []
    }
}

extension FavoriteRepository: FavoriteRepositoryProtocol {
    func storeFavorite(id: Int) {
        favoritesList.append(id)
    }
    
    func removeFavorite(id: Int) {
        favoritesList.removeAll { $0 == id }
    }
    
    func isFavorite(id: Int) -> Bool {
        favoritesList.contains(id)
    }
}
