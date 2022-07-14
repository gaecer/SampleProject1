//
//  URLProtocolMock.swift
//  NetworkFrameworkTests
//
//  Created by Gaetano Cerniglia on 29/12/2020.
//

@testable import NetworkFramework

enum MockedResponse {
    case none
    case error(NSError)
    case data(Data)
}

class URLProtocolMock: URLProtocol {

    static var providedResponse: MockedResponse = .none

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if request.url != nil {
            switch URLProtocolMock.providedResponse {
            case .none:
                fatalError("Must provide response")
            case .error(let error):
                client?.urlProtocol(self, didFailWithError: error)
            case .data(let data):
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

}
