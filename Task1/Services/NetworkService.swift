//
//  NetworkService.swift
//  Task1
//
//  Created by PicsartAcademy on 26.10.22.
//

import Foundation

class NetworkService {
    
    func fetchData(completion: @escaping (Result<[Post]?, Error>) -> Void) {
        guard let postsUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else { return }
        URLSession.shared.dataTask(with: postsUrl) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200...300 ~= response.statusCode,
                  error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchData(completion: @escaping (Result<[User]?, Error>) -> Void) {
        guard let usersUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
        else { return }
        URLSession.shared.dataTask(with: usersUrl) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200...300 ~= response.statusCode,
                  error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
