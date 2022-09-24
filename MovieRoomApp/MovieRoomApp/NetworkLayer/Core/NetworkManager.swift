//
//  NetworkManager.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import Foundation
import UIKit
import Alamofire


class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethod, completion: @escaping((Result)->())) {
        AF.request(url, method: method, headers: ["api_key" : "d8255fdb07be4ce132643e5e155bf54b"]).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data : data) { response in
                    completion(response)
                }
            case .failure(_):
                completion(.failure(.generalError))
            }
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
