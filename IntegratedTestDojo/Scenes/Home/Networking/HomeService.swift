//
//  HomeService.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchAlbuns(onComplete: ((Result<[CollectionModel], Error>) -> Void)?)
}

class HomeService: HomeServiceProtocol {
    
    func fetchAlbuns(onComplete: ((Result<[CollectionModel], Error>) -> Void)?) {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=album&attribute=artistTerm&term=Wanderley+andrade")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                onComplete?(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(AlbumSearchResponse.self, from: data)
                onComplete?(.success(result.results))
            } catch let e {
                onComplete?(.failure(e))
            }
        }

        task.resume()
    }
}
