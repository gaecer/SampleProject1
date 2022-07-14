//
//  PirateShipService.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 21/12/2020.
//

import Foundation
import NetworkFramework

// MARK: - Enums
enum Endpoints: String {
    case pirateShips = "pirates.json"
}

enum PirateShipServiceError: Error {
    case invalidUrl
    case badResponseFormat
    case networkError(HttpClientError)
}

// MARK: - Types
typealias SearchResult = Result<[PirateShipModel], PirateShipServiceError>

// MARK: - Protocols
protocol PirateShipService {
    func searchShips(completion: @escaping (SearchResult) -> Void) -> Cancellable?
}

// MARK: - PirateShipService Class
class PirateShipServiceImp {

    private let apiBaseUrl: String = "https://raw.githubusercontent.com/gaecer/SampleProject1/main/"
    private let client: HttpClientImp

    init(session: URLSession = .shared) {
        self.client = HttpClientImp(session: session)
    }

}

/// Search for Pirate Ships Endpoint
extension PirateShipServiceImp: PirateShipService {
    func searchShips(completion: @escaping (SearchResult) -> Void) -> Cancellable? {
        guard let url = URL(string: apiBaseUrl.appending(Endpoints.pirateShips.rawValue) ) else {
            completion(.failure(.invalidUrl))
            return nil
        }

        /// Download the data
        let receipt = client.getRequest(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error): completion(.failure(.networkError(error)))
                case .success(let data):
                    do {
                        /// decode the response removing empty objects
                        let decoded = try JSONDecoder().decode(PirateShipResponse.self, from: data)
                        let ships = decoded.ships.compactMap { $0 }

                        /// success completion
                        completion(.success(ships))
                    } catch {
                        completion(.failure(.badResponseFormat))
                    }
                }
            }
        }

        return receipt
    }
}
