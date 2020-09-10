//
//  AlbumModel.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

struct CollectionModel: Codable {
    let collectionId: Int
    let collectionName: String
    let releaseDate: String
    let artworkUrl100: String
}
