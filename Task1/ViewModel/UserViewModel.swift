//
//  UserViewModel.swift
//  Task1
//
//  Created by PicsartAcademy on 27.10.22.
//

import Foundation

class UserViewModel {
    
    var items: [User]?
    var networkService = NetworkService()
    
    func fetchData(completion: @escaping (Result<[User]?, Error>) -> Void) {
        networkService.fetchData() { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let post):
                self.items = post
                completion(.success(post))
            }
        }
    }
}
