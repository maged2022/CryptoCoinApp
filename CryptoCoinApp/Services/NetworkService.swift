//
//  NetworkService.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import Foundation
import Combine

class NetworkService {
    enum NetworkError: Error {
        case badURL, requestFailed, invalidResponse
    }
    
    func fetchData<T: Decodable>(from urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func handleResponse( output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed
        }
        return output.data
    }
    
}

