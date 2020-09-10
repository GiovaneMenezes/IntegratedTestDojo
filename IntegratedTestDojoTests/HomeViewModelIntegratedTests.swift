//
//  HomeIntegratedTests.swift
//  IntegratedTestDojoTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import XCTest
@testable import IntegratedTestDojo

class HomeViewModelIntegratedTests: XCTestCase {
    
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
    
    // Implement the SUT and its dependencies
    let delegateMock = DelegateMock()
    let repository = FavoriteRepository(key: "teste")
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        // Start any mocked repository if needed
        sut = HomeViewModel(service: HomeService(), favoriteRepository: repository)
        sut.delegate = delegateMock
    }
    
    override func tearDown() {
        // Clean Repository if needed
        repository.cleanRepository()
        super.tearDown()
    }
    
    func testDidSelectInNotFavoriteElement() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.colectionsArray = generateCollectionArray(numberOfElements: 10)
        
        sut.didSelect(at: indexPath)
        
        XCTAssert(sut.isFavoriteAlbum(at: indexPath))
    }
    
    //    func testFetchAlbunsSuccessfully() {
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

extension HomeViewModelIntegratedTests {
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
