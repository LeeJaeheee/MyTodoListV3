//
//  URLManager.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/24.
//

import UIKit

class URLManager {
    static let shared = URLManager()
    
    private init() { }
    
    let session = URLSession.shared
    let apiURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
    
    func getJsonData(completion: @escaping (Result<[ImageAPI], Error>) -> Void) {
        let task = session.dataTask(with: apiURL) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            guard let imageAPI = try? JSONDecoder().decode([ImageAPI].self, from: data) else {
                completion(.failure(NetworkError.decodeError))
                return
            }
            completion(.success(imageAPI))
        }
        task.resume()
    }
    
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case emptyResponse
    case invalidResponse
    case decodeError
    case unknown(String)
}
