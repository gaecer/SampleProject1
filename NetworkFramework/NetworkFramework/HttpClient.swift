//
//  HttpClient.swift
//  NetworkFramework
//
//  Created by gaetano cerniglia on 21/12/2020.
//

import Foundation

public enum HttpClientError: Error {
    case requestCancelled
    case serverError
}

public protocol HttpClient {
    func getRequest(with url: URL, completion: @escaping CompletionHandler) -> Cancellable?
    typealias CompletionHandler = (Result<Data, HttpClientError>) -> Void
}

public class HttpClientImp {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

}

extension HttpClientImp: HttpClient {
    /**
     Generic HTTP request, the response is managed with the escaping completion block.
     
     - parameter url: URL address of the call
     - parameter completion: this is an escaping block of type (Result<Data, HttpClientError>)
     to handle the .success or the .failure Result
     - Returns: a Cancellable object to give the option to Cancel the running calls
     */
    public func getRequest(with url: URL, completion: @escaping CompletionHandler) -> Cancellable? {
        let task = session.dataTask(with: url) { (data, _, error) in

            #if TEST
                /// Use json file with a response sample during tests
                let bundle = Bundle(for: HttpClientImp.self)
                let path = bundle.path(forResource: "Ships", ofType: "json")!
                let sampleData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(sampleData ?? Data()))
            #else
                guard error == nil else {
                    if let error = error as NSError? {
                        completion(.failure(error.code == NSURLErrorCancelled ? .requestCancelled : .serverError))
                    }
                    return
                }
                completion(.success(data ?? Data()))
            #endif
        }
        task.resume()
        return TaskReceipt(task: task)
    }
}
