//
//  Repository.swift
//  IntegratedTestDojo
//
//  Created by Giovane Silva de Menezes Cavalcante on 25/08/20.
//  Copyright © 2020 GSMenezes. All rights reserved.
//

import Foundation

class Repository {
    
    let key: String
    let userDefaults: UserDefaults
    
    init(key: String) {
        userDefaults = UserDefaults.standard
        self.key = key
    }
    
    func cleanRepository() {
        userDefaults.set(nil, forKey: key)
    }
}
