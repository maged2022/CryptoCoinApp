//
//  NetworkService.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var description: String {
            switch self {
            case .badURLResponse(let url):
                return "bad url server \(url)"
            case .unknown:
                return "unknown Error !"
            }
            
        }
        
    }
    
    static func fetchData(from urlString: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try handleResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Network request error: \(error.localizedDescription)")
        }
    }
}

