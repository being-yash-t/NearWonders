//
//  APIClient.swift
//  NearWonders
//
//  Created by Jay Thakur on 15/06/24.
//

import Foundation

fileprivate enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case statusCodeError(statusCode: Int)
    case unknownError
}

class APIClient {
    static let shared = APIClient()
    private let baseURL = "http://localhost:8000/api/"
    
    private init() {}
    
    private func makeRequest<T: Decodable>(
        to endpoint: APIConstant,
        method: HTTPMethod,
        body: Data? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)\(endpoint.rawValue)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Add Authorization header if token exists
        if let token = try? KeychainHelper.shared.get(forKey: .userToken) as String {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.unknownError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(APIError.statusCodeError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func get<T: Decodable>(from endpoint: APIConstant, completion: @escaping (Result<T, Error>) -> Void) {
        makeRequest(to: endpoint, method: .get, completion: completion)
    }
    
    func post<T: Codable, U: Codable>(to endpoint: APIConstant, body: U, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(body)
            makeRequest(to: endpoint, method: .post, body: jsonData, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
