//
//  HomeViewModel.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func reloadTable(_ viewModel: HomeViewModel)
    func showError(_ viewModel: HomeViewModel, message: String)
}

class HomeViewModel {
    
    var favoriteRepository: FavoriteRepositoryProtocol
    var service: HomeServiceProtocol
    weak var delegate: HomeViewDelegate?
    var colectionsArray = [CollectionModel]()
    
    var numberOfRows: Int { colectionsArray.count }
    
    init(service: HomeServiceProtocol, favoriteRepository: FavoriteRepositoryProtocol){
        self.service = service
        self.favoriteRepository = favoriteRepository
    }
    
    func isFavoriteAlbum(at indexPath: IndexPath) -> Bool {
        return favoriteRepository.isFavorite(id: colectionsArray[indexPath.row].collectionId)
    }
    
    func fetchAlbuns() {
        service.fetchAlbuns() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.colectionsArray = response
                self.delegate?.reloadTable(self)
            case .failure(let error):
                self.delegate?.showError(self, message: error.localizedDescription)
            }
        }
    }
    
    func getYear(from string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from: string) else { return "@@@" }
        let calendar = Calendar.current
        return "\(calendar.component(.year, from: date))"
    }
    
    func cellModel(for indexpath: IndexPath) -> AlbumCellModel {
        AlbumCellModel(title: colectionsArray[indexpath.row].collectionName,
                       releaseYear: getYear(from: colectionsArray[indexpath.row].releaseDate),
                       albumImagePath: "",
                       isFavourite: isFavoriteAlbum(at: indexpath))
    }
    
    func didSelect(at indexPath: IndexPath) {
        let id = colectionsArray[indexPath.row].collectionId
        if isFavoriteAlbum(at: indexPath) {
            favoriteRepository.removeFavorite(id: id)
        } else {
            favoriteRepository.storeFavorite(id: id)
        }
        
    }
}
