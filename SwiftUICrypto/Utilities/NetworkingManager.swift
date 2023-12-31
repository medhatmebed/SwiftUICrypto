//
//  NetworkingManager.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/1/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): "[🔥]BAD RESPONSE FROM THE URL\(url)"
            case .unknown: "[⚠️]UNKNOWN ERROR OCCURED"
            }
        }
    }
    
    static func download(url: URL)  -> AnyPublisher<Data, Error> {
        return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error Downloading Data \(error)")
        }
    }
    
    
}
