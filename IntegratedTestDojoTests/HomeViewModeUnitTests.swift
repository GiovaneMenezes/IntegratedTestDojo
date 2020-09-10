//
//  HomeViewModelUnitTests.swift
//  IntegratedTestDojoTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import XCTest
@testable import IntegratedTestDojo

class HomeViewModelUnitTests: XCTestCase {
    
    class HomeServiceMock: HomeServiceProtocol {
        
        var onCompleteFetchAlbunsMock: Result<[CollectionModel], Error> =  .success([])
        
        func fetchAlbuns(onComplete: ((Result<[CollectionModel], Error>) -> Void)?) {
            onComplete?(onCompleteFetchAlbunsMock)
        }
    }
    
    class FavoriteRepositoryMock: FavoriteRepositoryProtocol {
        
        var storeFavoriteWasCalled = false
        var removeFavoriteWasCalled = false
        var isFavoriteWasCalled = false
        
        var mockIsFavorite = true
        
        func storeFavorite(id: Int) {
            storeFavoriteWasCalled = true
        }
        
        func removeFavorite(id: Int) {
            removeFavoriteWasCalled = true
        }
        
        func isFavorite(id: Int) -> Bool {
            isFavoriteWasCalled = true
            return mockIsFavorite
        }
    }
    
    class DelegateMock: HomeViewDelegate {
        
        var reloadTableWasCalled: (() -> Void)?
        var showErrorWasCalled: (() -> Void)?
        
        func reloadTable(_ viewModel: HomeViewModel) {
            reloadTableWasCalled?()
        }
        
        func showError(_ viewModel: HomeViewModel, message: String) {
            showErrorWasCalled?()
        }
    }
    
    let repositoryMock = FavoriteRepositoryMock()
    let mockService = HomeServiceMock()
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel(service: mockService, favoriteRepository: repositoryMock)
    }
    
    func testDidSelectInFavoriteElement() {
        sut.colectionsArray = generateCollectionArray(numberOfElements: 5)
        repositoryMock.mockIsFavorite = true
        
        sut.didSelect(at: IndexPath(row: 0, section: 0))
        
        XCTAssert(repositoryMock.removeFavoriteWasCalled)
        XCTAssertFalse(repositoryMock.storeFavoriteWasCalled)
    }
    
//    func testDidSelectInNotFavoriteElement() {
//        // Do this test
//    }
//
//    func testFetchAlbunsSuccessfully() {
//        // Do this test
//    }
//
//    func testFetchAlbunsFailure() {
//        // Do this test
//    }
//
//    func testIsFavoritedAlbum() {
//        // Do this test
//    }
//
//    func testCellModelGeneration() {
//        // Do this test
//    }
}

extension HomeViewModelUnitTests {
    func generateCollectionArray(numberOfElements: Int) -> [CollectionModel] {
        var array = [CollectionModel]()
        
        for index in 0..<numberOfElements {
            array.append(CollectionModel(collectionId: index,
                                         collectionName: "Album number \(index)",
                                         releaseDate: "1984-12-01T08:00:00Z",
                                         artworkUrl100: "http://"))
        }
        
        return array
    }
}
