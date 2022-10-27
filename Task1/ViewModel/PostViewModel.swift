//
//  PostViewModel.swift
//  Task1
//
//  Created by PicsartAcademy on 26.10.22.
//

import Foundation

class PostViewModel {
    
    var items: [Post]?
    var networkService = NetworkService()
    
    func fetchData(completion: @escaping (Result<[Post]?, Error>) -> Void) {
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
