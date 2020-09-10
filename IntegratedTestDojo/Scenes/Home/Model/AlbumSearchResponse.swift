//
//  AlbumSearchResponse.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

struct AlbumSearchResponse: Codable {
    let results: [CollectionModel]
}
